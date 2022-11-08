import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_app_1/verificacion/bloc.dart';

class VistaMostrandoBusqueda extends StatelessWidget {
  const VistaMostrandoBusqueda({
    Key? key,
    required this.resultadoDeBusqueda,
    required this.nombreUsuario,
  }) : super(key: key);

  final String resultadoDeBusqueda;
  final String nombreUsuario;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              color: Color.fromARGB(255, 37, 34, 34),
              child: Text(
                resultadoDeBusqueda,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 249, 247, 247),
                ),
              ),
            ),
            const SizedBox(width: 40),
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
                            Color.fromARGB(255, 161, 87, 13),
                            Color.fromARGB(255, 210, 164, 25),
                            Color.fromARGB(255, 245, 150, 66),
                          ],
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Color.fromARGB(255, 0, 0, 0),
                        padding: const EdgeInsets.all(16.0),
                        textStyle: const TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        var bloc = context.read<BlocVerificacion>();
                        bloc.add(IrAJuegos(nombreUsuario));
                      },
                      child: const Text("Ir a Juegos jugados de este usuario")),
                ],
              ),
            ),
          ],
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[
                        Color.fromARGB(255, 161, 87, 13),
                        Color.fromARGB(255, 210, 164, 25),
                        Color.fromARGB(255, 245, 150, 66),
                      ],
                    ),
                  ),
                ),
              ),
              TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Color.fromARGB(255, 0, 0, 0),
                    padding: const EdgeInsets.all(16.0),
                    textStyle: const TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    var bloc = context.read<BlocVerificacion>();
                    bloc.add(Creado());
                  },
                  child: const Text('Volver a solicitar'))
            ],
          ),
        ),
      ],
    ));
  }
}
