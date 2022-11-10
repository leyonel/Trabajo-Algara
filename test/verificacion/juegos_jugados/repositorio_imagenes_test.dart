import 'package:flutter_app_1/dominio/nick_formado.dart';
import 'package:flutter_app_1/verificacion/juegos_jugados/repositorio_imagenes.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';

void main() {
  test('Si Xml si obtiene imagen', () async {
    RepositorioImagenesJuegosPruebas repositorio =
        RepositorioImagenesJuegosPruebas();
    String id = "1010";
    final resulatdo = await repositorio.obtenerImagenMiniaturaJuego(id);
    print(resulatdo);

    List<String> resultadoSeparado = resulatdo.split(".");

    expect(resultadoSeparado[0], equals("1010"));
  });
}
