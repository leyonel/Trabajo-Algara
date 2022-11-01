import 'dart:math';

import 'package:flutter_app_1/dominio/coleccion_juegos.dart';
import 'package:flutter_app_1/dominio/nick_formado.dart';
import 'package:flutter_app_1/verificacion/juegos_jugados/repositorio_juegos.dart';
import 'package:flutter_app_1/verificacion/juegos_jugados/repositorio_xml.dart';
import 'package:test/test.dart';
import 'package:xml/xml.dart';

void main() {
  group('Repositorio Pruebas con Benhtor', () {
    RepositorioXmlPruebas repositorioPruebas = RepositorioXmlPruebas();
    RepositorioJuegosJugadosPruebas repositorio =
        RepositorioJuegosJugadosPruebas(repositorioPruebas);
    test('Para benthor esta bien formado', () async {
      final respuesta = await repositorio
          .obtenerJuegosJugadosPorUsuario(NickFormado.constructor('benthor'));
      expect(respuesta.isRight(), true);
    });
    test('Benthor tiene 5 juegos', () async {
      final respuesta = await repositorio
          .obtenerJuegosJugadosPorUsuario(NickFormado.constructor('benthor'));
      respuesta.match((l) {
        expect(true, equals(false));
      }, (r) {
        expect(r.length, equals(2));
      });
    });

    test('Benthor ha jugado "Takenoko"', () async {
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
      final monopoly = JuegoJugado.constructor(
          idPropuesta: "9", nombrePropuesta: "Monopoly");
      final respuesta = await repositorio
          .obtenerJuegosJugadosPorUsuario(NickFormado.constructor('benthor'));
      respuesta.match((l) {
        //expect(true, equals(false));
        assert(false);
      }, (r) {
        expect(!r.contains(monopoly), true);
      });
    });
  });

//////////PRUEBAS FOKULEH/////////////////////////////

  group('Repositorio Prueba con fokuleh', () {
    RepositorioXmlPruebas repositorioXmlPruebas = RepositorioXmlPruebas();
    RepositorioJuegosJugadosPruebas repositorio =
        RepositorioJuegosJugadosPruebas(repositorioXmlPruebas);

    test('fokulhe funciona con repositorio Prueba', () async {
      final respuesta = await repositorio
          .obtenerJuegosJugadosPorUsuario(NickFormado.constructor('fokuleh'));
      expect(respuesta.isRight(), true);
    });

    test('Fokuleh tiene 6 juegos', () async {
      final respuesta = await repositorio
          .obtenerJuegosJugadosPorUsuario(NickFormado.constructor('fokuleh'));
      respuesta.match((l) {
        expect(true, equals(false));
      }, (r) {
        expect(r.length, equals(6));
      });
    });
  });

//////////BENTHOR REAL//////////////////////////////////////
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

    test('benthor a jugado "The Dwarf King"', () async {
      final juego = JuegoJugado.constructor(
          idPropuesta: "85250", nombrePropuesta: "The Dwarf King");

      final respuesta = await repositorio
          .obtenerJuegosJugadosPorUsuario(NickFormado.constructor('benthor'));
      respuesta.match((l) {
        assert(false);
      }, (r) {
        expect(r.contains(juego), true);
      });
    });

    test('benthor a jugado "Palenque"', () async {
      final juego = JuegoJugado.constructor(
          idPropuesta: "88950", nombrePropuesta: "Palenque");

      final respuesta = await repositorio
          .obtenerJuegosJugadosPorUsuario(NickFormado.constructor('benthor'));
      respuesta.match((l) {
        assert(false);
      }, (r) {
        expect(r.contains(juego), true);
      });
    });
  });

  ////////// FOKULEH REAL//////////////////////////////////////
  group('Repositorio real con fokuleh', () {
    RepositorioXmlReal repositorioXmlReal = RepositorioXmlReal();
    RepositorioJuegosJugadosReal repositorio =
        RepositorioJuegosJugadosReal(repositorioXmlReal);
    test('fokuleh tiene x cantidad de juegos', () async {
      final respuesta = await repositorio
          .obtenerJuegosJugadosPorUsuario(NickFormado.constructor('fokuleh'));
      respuesta.match((l) {
        assert(false);
      }, (r) {
        expect(r.length, equals(150));
      });
    });

    test('fokuleh a jugado "Hanabi"', () async {
      final juego = JuegoJugado.constructor(
          idPropuesta: "98778", nombrePropuesta: "Hanabi");

      final respuesta = await repositorio
          .obtenerJuegosJugadosPorUsuario(NickFormado.constructor('fokuleh'));
      respuesta.match((l) {
        assert(false);
      }, (r) {
        expect(r.contains(juego), true);
      });
    });

    test('fokuleh no a jugado "Mario Bros"', () async {
      final juego = JuegoJugado.constructor(
          idPropuesta: "88950", nombrePropuesta: "Mario Bros");

      final respuesta = await repositorio
          .obtenerJuegosJugadosPorUsuario(NickFormado.constructor('fokuleh'));
      respuesta.match((l) {
        assert(false);
      }, (r) {
        expect(r.contains(juego), false);
      });
    });
  });
}
