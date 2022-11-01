import 'dart:math';

import 'package:flutter_app_1/dominio/coleccion_juegos.dart';
import 'package:flutter_app_1/dominio/nick_formado.dart';
import 'package:flutter_app_1/verificacion/juegos_jugados/repositorio_juegos.dart';
import 'package:flutter_app_1/verificacion/juegos_jugados/repositorio_xml.dart';
import 'package:test/test.dart';
import 'package:xml/xml.dart';

void main() {
  test('Para benthor esta bien formado', () async {
    RepositorioXmlPruebas repositorioPruebas = RepositorioXmlPruebas();
    RepositorioJuegosJugadosPruebas repositorio =
        RepositorioJuegosJugadosPruebas(repositorioPruebas);
    final respuesta = await repositorio
        .obtenerJuegosJugadosPorUsuario(NickFormado.constructor('benthor'));
    expect(respuesta.isRight(), true);
  });
  test('Benthor tiene 5 juegos', () async {
    RepositorioXmlPruebas repositorioPruebas = RepositorioXmlPruebas();
    RepositorioJuegosJugadosPruebas repositorio =
        RepositorioJuegosJugadosPruebas(repositorioPruebas);
    final respuesta = await repositorio
        .obtenerJuegosJugadosPorUsuario(NickFormado.constructor('benthor'));
    respuesta.match((l) {
      expect(true, equals(false));
    }, (r) {
      expect(r.length, equals(2));
    });
  });

  test('Fokuleh tiene 6 juegos', () async {
    RepositorioXmlPruebas repositorioPruebas = RepositorioXmlPruebas();
    RepositorioJuegosJugadosPruebas repositorio =
        RepositorioJuegosJugadosPruebas(repositorioPruebas);
    final respuesta = await repositorio
        .obtenerJuegosJugadosPorUsuario(NickFormado.constructor('fokuleh'));
    respuesta.match((l) {
      expect(true, equals(false));
    }, (r) {
      expect(r.length, equals(6));
    });
  });

  test('Benthor ha jugado "Takenoko"', () async {
    RepositorioXmlPruebas repositorioPruebas = RepositorioXmlPruebas();
    RepositorioJuegosJugadosPruebas repositorio =
        RepositorioJuegosJugadosPruebas(repositorioPruebas);
    final takenoko = JuegoJugado.constructor(
        idPropuesta: "70919", nombrePropuesta: "Takenoko");
    final respuesta = await repositorio
        .obtenerJuegosJugadosPorUsuario(NickFormado.constructor('benthor'));
    respuesta.match((l) {
      expect(true, equals(false));
    }, (r) {
      expect(r, contains(takenoko));
    });
  });

  test('Benthor no ha jugado "Monopoly"', () async {
    RepositorioXmlPruebas repositorioPruebas = RepositorioXmlPruebas();
    RepositorioJuegosJugadosPruebas repositorio =
        RepositorioJuegosJugadosPruebas(repositorioPruebas);
    final monopoly =
        JuegoJugado.constructor(idPropuesta: "9", nombrePropuesta: "Monopoly");
    final respuesta = await repositorio
        .obtenerJuegosJugadosPorUsuario(NickFormado.constructor('benthor'));
    respuesta.match((l) {
      //expect(true, equals(false));
      assert(false);
    }, (r) {
      expect(!r.contains(monopoly), true);
    });
  });

  test('funcion numero de paginas regresa 4 con fokuleh', () async {
    RepositorioXmlPruebas repositorioPruebas = RepositorioXmlPruebas();
    RepositorioJuegosJugadosPruebas repositorio =
        RepositorioJuegosJugadosPruebas(repositorioPruebas);
  });

  group('Repositorio Prueba con fokuleh', () {
    RepositorioXmlReal repositorioXmlReal = RepositorioXmlReal();
    RepositorioJuegosJugadosReal repositorio =
        RepositorioJuegosJugadosReal(repositorioXmlReal);

    test('fokulhe funciona con repositorio real', () async {
      final respuesta = await repositorio
          .obtenerJuegosJugadosPorUsuario(NickFormado.constructor('fokuleh'));
      expect(respuesta.isRight(), true);
    });

    test('fokulhe ha jugado 11 juegos', () async {
      final respuesta = await repositorio
          .obtenerJuegosJugadosPorUsuario(NickFormado.constructor('fokuleh'));
      respuesta.match((l) {
        expect(true, equals(false));
      }, (r) {
        expect(r.length, equals(11));
        ;
      });
    });

    test('fokulhe ha jugado 11 juegos', () async {
      final respuesta = await repositorio
          .obtenerJuegosJugadosPorUsuario(NickFormado.constructor('fokuleh'));
      respuesta.match((l) {
        expect(true, equals(false));
      }, (r) {
        expect(r.length, equals(11));
        ;
      });
    });
  });

  group('Repositorio real con benthor', () {
    RepositorioXmlReal repositorioXmlReal = RepositorioXmlReal();
    RepositorioJuegosJugadosReal repositorio =
        RepositorioJuegosJugadosReal(repositorioXmlReal);
    test('benthor tiene x cantidad de juegos', () async {
      final respuesta = await repositorio
          .obtenerJuegosJugadosPorUsuario(NickFormado.constructor('benthor'));
      respuesta.match((l) {
        assert(false);
      }, (r) {
        expect(r.length, equals(429));
      });
    });

    test('benthor a jugado Dungeon Lords', () async {
      final juego = JuegoJugado.constructor(
          idPropuesta: "13972961", nombrePropuesta: "Dungeon Lords");

      final respuesta = await repositorio
          .obtenerJuegosJugadosPorUsuario(NickFormado.constructor('benthor'));
      respuesta.match((l) {
        assert(false);
      }, (r) {
        expect(r.contains(juego), true);
      });
    });
  });
}
