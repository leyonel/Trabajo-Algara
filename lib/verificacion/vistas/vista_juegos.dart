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
                  leading: Text((index + 1).toString()),
                  subtitle: Text(listaJuegos[index].id.toString()),
                  title: Text(listaJuegos[index].nombre.toString()),
                );
              },
            ),
          ),
          FloatingActionButton(
            onPressed: () {
              var bloc = context.read<BlocVerificacion>();
              bloc.add(NombreRecibido(nick));
            },
            child: const Text('Regresar'),
          ),
        ],
      ),
    );
  }
}
