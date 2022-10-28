import 'dart:io';
import 'package:flutter_app_1/dominio/nick_formado.dart';
import 'package:flutter_app_1/dominio/problemas.dart';
import 'package:fpdart/fpdart.dart';
import 'package:xml/xml.dart';

abstract class RepositorioXml {
  Future<Either<Problema, List<String>>> obtenerXml(NickFormado nick);
}

class RepositorioXmlReal extends RepositorioXml {}

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
