import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_app_1/dominio/coleccion_juegos.dart';
import 'package:flutter_app_1/dominio/nick_formado.dart';
import 'package:flutter_app_1/dominio/problemas.dart';
import 'package:flutter_app_1/verificacion/juegos_jugados/repositorio_xml.dart';
import 'package:fpdart/fpdart.dart';
import 'package:xml/xml.dart';

abstract class RepositorioJuegosJugados {
  final RepositorioXml repositorio;
  RepositorioJuegosJugados(this.repositorio);
  Future<Either<Problema, Set<JuegoJugado>>> obtenerJuegosJugadosPorUsuario(
      NickFormado nick);
}

////////////////////////////////REAL/////////////////////////////////////////////////
class RepositorioJuegosJugadosReal extends RepositorioJuegosJugados {
  RepositorioJuegosJugadosReal(RepositorioXml repositorio) : super(repositorio);

  @override
  Future<Either<Problema, Set<JuegoJugado>>> obtenerJuegosJugadosPorUsuario(
      NickFormado nick) async {
    Either<Problema, List<String>> resultadoXml =
        await repositorio.obtenerXml(nick);

    return resultadoXml.match((l) {
      return left(l);
    }, (r) {
      return _obtenerJuegosJugadosDesdeXml(r);
    });
  }
}

/////////////////////////////PRUEBAS////////////////////////////////////////////////
class RepositorioJuegosJugadosPruebas extends RepositorioJuegosJugados {
  RepositorioJuegosJugadosPruebas(RepositorioXml repositorio)
      : super(repositorio);

  @override
  Future<Either<Problema, Set<JuegoJugado>>> obtenerJuegosJugados(
      NickFormado nick) async {
    final Either<Problema, List<String>> resultadoXml =
        await super.repositorio.obtenerXml(nick);
    return resultadoXml.match((l) {
      return Left(l);
    }, (r) {
      final resultado = _obtenerJuegosJugadosDesdeXml(r);
      return resultado;
    });
  }

  int obtenerTotalPaginas(String nick) {
    String respuesta = "";
    if (nick == "benthor") {
      respuesta = File('./test/verificacion/juegos_jugados/benthor.xml')
          .readAsStringSync();
    }
    if (nick == "fokuleh") {
      respuesta = File('./test/verificacion/juegos_jugados/fokuleh1.xml')
          .readAsStringSync();
    }
    final documento = XmlDocument.parse(respuesta);
    int totalJugadas = int.parse(
        documento.findAllElements("plays").first.getAttribute("total") ?? "0");
    int paginas = (totalJugadas / 100).ceil();

    return paginas;
  }

  Either<Problema, int> numeroDePaginasPruebas(String elXml) {
    return Right(0);
  }

  List<String> obtenerListaDeDireccionesXml(String nombre, int totalPaginas) {
    List<String> direcciones = [];
    for (var i = 1; i <= totalPaginas; i++) {
      if (nombre == "benthor") {
        direcciones.add("./test/verificacion/juegos_jugados/benthor.xml");
      }
      if (nombre == "benthor") {
        direcciones.add("./test/verificacion/juegos_jugados/fokuleh" +
            i.toString() +
            ".xml");
      }
    }
    return direcciones;
  }

  List<String> _obtenerXmlJugadasDelDisco({required String nombre}) {
    List<String> jugadasPorPaginas = [];
    if (nombre == "benthor") {
      jugadasPorPaginas.add(
          File('test/verificacion/juegos_jugados/benthor1.xml')
              .readAsStringSync());
    }
    if (nombre == "fokuleh") {
      jugadasPorPaginas.add(
          File('./test/verificacion/juegos_jugados/fokuleh1.xml')
              .readAsStringSync());
      jugadasPorPaginas.add(
          File('./test/verificacion/juegos_jugados/fokuleh2.xml')
              .readAsStringSync());
      jugadasPorPaginas.add(
          File('./test/verificacion/juegos_jugados/fokuleh3.xml')
              .readAsStringSync());
    }
    return jugadasPorPaginas;
  }

  @override
  Future<Either<Problema, Set<JuegoJugado>>> obtenerJuegosJugadosPorUsuario(
      NickFormado nick) async {
    List<String> losXml = _obtenerXmlJugadasDelDisco(nombre: nick.valor);
    final resulatdo = _obtenerJuegosJugadosDesdeXml(losXml);
    return resulatdo;
  }
}

//////////////////////////////////METODOS/////////////////////////////////////////////
Either<Problema, Set<JuegoJugado>> _obtenerJuegosJugadosDesdeXml(
    List<String> elXml) {
  final resultado = elXml.map((e) => _obtenerUnSoloSet(e));
  if (resultado.any((element) => element is Problema)) {
    return Left(VersionIncorrectaXML());
  }
  final soloSets = resultado.map((e) => e.getOrElse((l) => {}));

  final conjunto = soloSets.fold<Set<JuegoJugado>>(
      {},
      (Set<JuegoJugado> previo, Set<JuegoJugado> actual) =>
          previo..addAll(actual));
  return Right(conjunto);
}

Either<Problema, Set<JuegoJugado>> _obtenerUnSoloSet(String elXml) {
  try {
    String xmlitemIndex = "item";
    String itemNameAttribute = "name";
    String itemIDAttribute = "objectid";

    XmlDocument documento = XmlDocument.parse(elXml);
    final losPlay = documento.findAllElements(xmlitemIndex);
    final conjuntoIterable = losPlay.map((e) {
      String nombre = e.getAttribute(itemNameAttribute)!;
      String id = e.getAttribute(itemIDAttribute)!;
      return JuegoJugado.constructor(idPropuesta: id, nombrePropuesta: nombre);
    });
    return Right(conjuntoIterable.toSet());
  } catch (e) {
    return Left(VersionIncorrectaXML());
  }
}
