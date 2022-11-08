import 'package:flutter/material.dart';
import 'package:flutter_app_1/dominio/coleccion_juegos.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_app_1/verificacion/bloc.dart';

class VistaMostrandoJuegos extends StatelessWidget {
  const VistaMostrandoJuegos(
      {Key? key, required this.juegos, required this.nick})
      : super(key: key);

  final Set<JuegoJugado> juegos;
  final String nick;
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
                return ListTile(
                  leading: const Icon(Icons.gamepad_outlined),
                  subtitle: Text(listaJuegos[index].id.toString()),
                  title: Text(listaJuegos[index].nombre.toString()),
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
