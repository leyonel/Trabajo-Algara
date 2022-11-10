import 'package:http/http.dart' as http;
import 'package:flutter_app_1/dominio/imagen_formado.dart';
import 'package:flutter_app_1/dominio/problemas.dart';
import 'package:flutter_app_1/verificacion/juegos_jugados/repositorio_xml.dart';
import 'package:fpdart/fpdart.dart';
import 'package:xml/xml.dart';

abstract class RepositoriosImagenesJuegos {
  Future<String> obtenerImagenMiniaturaJuego(String id);
}

class RepositorioImagenesJuegosPruebas extends RepositoriosImagenesJuegos {
  Future<String> _obtenerImagenJuego(String id) async {
    var url = "https://boardgamegeek.com/xmlapi2/thing?id=$id";
    final resultado = await http.get(Uri.parse(url));
    return resultado.body;
  }

  String _obtenerDatosDeXml(String xml) {
    try {
      final documento = XmlDocument.parse(xml);
      final imagen = documento
          .findAllElements("thumbnail")
          .first
          .children
          .first
          .toString();

      final id = documento.findAllElements("item").first.getAttribute("id") ??
          "No encontrado";
      final links = documento.findAllElements("link");

      var designer = "";
      for (var link in links) {
        if (link.getAttribute("type") == "boardgamedesigner") {
          designer = link.getAttribute("value").toString();
        }
      }
      return id + "." + imagen + "." + designer;
    } catch (e) {
      return "Resultado No encontrado";
    }
  }

  @override
  Future<String> obtenerImagenMiniaturaJuego(String id) async {
    final xml = await _obtenerImagenJuego(id);
    return _obtenerDatosDeXml(xml);
  }
}
