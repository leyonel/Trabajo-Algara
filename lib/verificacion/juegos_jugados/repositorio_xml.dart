import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app_1/dominio/nick_formado.dart';
import 'package:flutter_app_1/dominio/problemas.dart';
import 'package:fpdart/fpdart.dart';
import 'package:xml/xml.dart';
import 'package:http/http.dart' as http;

abstract class RepositorioXml {
  Future<Either<Problema, List<String>>> obtenerXml(NickFormado nick);
}

/////////////////////////////REAL////////////////////////////////////////////////
class RepositorioXmlReal extends RepositorioXml {
  final tamanoPaginaReal = 100;

  int _obtenerCuantasPaginasDesdeXmlReal(String elXml) {
    final documento = XmlDocument.parse(elXml);
    int totalJugadas =
        int.parse(documento.getElement("plays")!.getAttribute("total")!);
    int paginas = (totalJugadas / tamanoPaginaReal).ceil();

    return paginas;
  }

  List<String> _obtenerNombresPaginasReal(
      int cuantasPaginas, NickFormado nick) {
    var base =
        'https://boardgamegeek.com//xmlapi2/plays?username=${nick.valor}';
    List<String> lista = [];
    for (var i = 1; i <= cuantasPaginas; i++) {
      lista.add(base + '&page=$i');
    }
    return lista;
  }

  Future<Either<Problema, String>> _obtenerXmlOnline(String nick) async {
    final respuesta;
    Uri direccion =
        Uri.https('www.boardgamegeek.com', 'xmlapi2/plays', {'username': nick});

    respuesta = await http.get(direccion);
    if (respuesta.statusCode != 200) {
      return Left(ServidorNoAlcanzado());
    }
    return Right(respuesta.body);
  }

  Future llenarArchivo(String datos, int paginas) async {
    final file = await File(
        "test/verificacion/juegos_jugados/benthorLlenado$paginas.xml");

    file.writeAsString(datos);
  }

  @override
  Future<Either<Problema, List<String>>> obtenerXml(NickFormado nick) async {
    try {
      final resultado = await _obtenerXmlOnline(nick.valor);
      final elXml = resultado;
      int cuantasPaginas = _obtenerCuantasPaginasDesdeXmlReal(elXml.toString());
      print('Numero de Paginas: ${cuantasPaginas}');
      List<String> nombrePaginas =
          _obtenerNombresPaginasReal(cuantasPaginas, nick);
      List<String> resultadoFinal = [];

      for (var pagina in nombrePaginas) {
        final resultadoAPI = await http.get(Uri.parse(pagina));
        resultadoFinal.add(resultadoAPI.body);
      }

      resultadoFinal.forEach((element) {
        llenarArchivo(element, resultadoFinal.indexOf(element));
      });

      return Right(resultadoFinal);
    } catch (e) {
      return Left(VersionIncorrectaXML());
    }
  }
}

///////////////////////////PRUEBAS//////////////////////////////////////////
class RepositorioXmlPruebas extends RepositorioXml {
  final tamanoPagina = 2;

  int _obtenerCuantasPaginasDesdeXml(String elXml) {
    final documento = XmlDocument.parse(elXml);
    int totalJugadas =
        int.parse(documento.getElement("plays")!.getAttribute("total")!);
    int paginas = (totalJugadas / tamanoPagina).ceil();

    return paginas;
  }

  List<String> _obtenerNombresPaginas(int cuantasPaginas, NickFormado nick) {
    var base = './test/verificacion/juegos_jugados/${nick.valor}';
    List<String> lista = [];
    for (var i = 1; i <= cuantasPaginas; i++) {
      lista.add(base + '$i' + '.xml');
    }
    return lista;
  }

  @override
  Future<Either<Problema, List<String>>> obtenerXml(NickFormado nick) async {
    if (nick.valor == "benthor") {
      try {
        String elXml = File('./test/verificacion/juegos_jugados/benthor1.xml')
            .readAsStringSync();
        int cuantasPaginas = _obtenerCuantasPaginasDesdeXml(elXml);
        List<String> nombresPaginas =
            _obtenerNombresPaginas(cuantasPaginas, nick);
        print(nombresPaginas.map((e) => File(e).readAsStringSync()).toList());
        return Right(
            nombresPaginas.map((e) => File(e).readAsStringSync()).toList());
      } catch (e) {
        return Left(VersionIncorrectaXML());
      }
    }
    if (nick.valor == "fokuleh") {
      try {
        String elXml = File('./test/verificacion/juegos_jugados/fokuleh1.xml')
            .readAsStringSync();
        int cuantasPaginas = _obtenerCuantasPaginasDesdeXml(elXml);
        List<String> nombresPaginas =
            _obtenerNombresPaginas(cuantasPaginas, nick);
        return Right(
            nombresPaginas.map((e) => File(e).readAsStringSync()).toList());
      } catch (e) {
        return Left(VersionIncorrectaXML());
      }
    }
    return Left(UsuarioNoRegistrado());
  }
}

///////////////////////////////////////////////////////////





