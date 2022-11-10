import 'package:flutter/material.dart';
import 'package:flutter_app_1/dominio/coleccion_juegos.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_app_1/verificacion/bloc.dart';
import 'package:fpdart/fpdart.dart';

class VistaMostrandoJuegos extends StatelessWidget {
  const VistaMostrandoJuegos(
      {Key? key, required this.juegos, required this.nick, required this.datos})
      : super(key: key);

  final Set<JuegoJugado> juegos;
  final String nick;
  final List<String> datos;
  @override
  Widget build(BuildContext context) {
    int contador = juegos.length;
    List<JuegoJugado> listaJuegos = juegos.toList();
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: contador,
              itemBuilder: (context, index) {
                var datosJuego = datos.firstWhere((element) {
                  var id = element.split(".")[0];
                  return id == listaJuegos[index].id;
                });
                var idJuego = datosJuego.split(".")[0];
                var link = datosJuego.split(".")[1];
                var disenador = datosJuego.split(".")[2];
                return ListTile(
                  leading: Text(link),
                  subtitle: Text(idJuego),
                  title: Text(listaJuegos[index].nombre.toString()),
                  trailing: Text(disenador),
                );
              },
            ),
          ),
          const SizedBox(height: 30),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: Stack(
              children: <Widget>[
                Positioned.fill(
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[
                          Color(0xFF0D47A1),
                          Color(0xFF1976D2),
                          Color(0xFF42A5F5),
                        ],
                      ),
                    ),
                  ),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.all(16.0),
                    textStyle: const TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    var bloc = context.read<BlocVerificacion>();
                    bloc.add(NombreRecibido(nick));
                  },
                  child: Text("Regresar"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
