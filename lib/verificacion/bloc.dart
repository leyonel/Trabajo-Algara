import 'package:bloc/bloc.dart';
import 'package:flutter_app_1/dominio/nick_formado.dart';
import 'package:flutter_app_1/dominio/problemas.dart';
import 'package:flutter_app_1/verificacion/data_usuario.dart';
import 'package:flutter_app_1/verificacion/repositorio_verificacion.dart';

class EventoVerificacion {}

class Creado extends EventoVerificacion {}

class NombreRecibido extends EventoVerificacion {
  final String nombreAProcesar;

  NombreRecibido(this.nombreAProcesar);
}

class IrAJuegos extends EventoVerificacion {
  final String nombreUsuario;

  IrAJuegos(this.nombreUsuario);
}

class NombreConfirmado extends EventoVerificacion {}

class EstadoVerificacion {}

class Creandose extends EstadoVerificacion {}

class SolicitandoNombre extends EstadoVerificacion {}

class EsperandoConfirmacionNombre extends EstadoVerificacion {}

class MostrandoJuegos extends EstadoVerificacion {
  final List<String> juegos;

  MostrandoJuegos(this.juegos);
}

class MostrandoNombre extends EstadoVerificacion {
  final String _nombre;
  final String _apellido;
  final int _anio;
  final String _pais;
  final String _estado;
  final String nombreUsuario;

  late String mensaje = "";
  MostrandoNombre(this._nombre, this._apellido, this._anio, this._pais,
      this._estado, this.nombreUsuario) {
    mensaje = 'El usuario se registró en el año: ' + _anio.toString() + '\n';
    mensaje += 'Nombre del usuario: ' + _nombre + '\n';
    mensaje += 'Apellido del usurio: ' + _apellido + '\n';
    mensaje += 'Pais del usurio: ' + _pais + '\n';
    mensaje += 'Estado o provincia del usurio: ' + _estado + '\n';
  }
}

class MostrandoNombreNoConfirmado extends EstadoVerificacion {
  final Problema problema;
  late String mensaje = "";
  MostrandoNombreNoConfirmado(this.problema) {
    if (problema is VersionIncorrectaXML) {
      mensaje = "La versión de XML está mal";
    }
    if (problema is UsuarioNoRegistrado) {
      mensaje = "El usuario no existe";
    }
  }
}

class BlocVerificacion extends Bloc<EventoVerificacion, EstadoVerificacion> {
  BlocVerificacion() : super(Creandose()) {
    on<Creado>((event, emit) {
      emit(SolicitandoNombre());
    });
    on<NombreRecibido>((event, emit) {
      RepositorioPruebasVerificacion repositorio =
          RepositorioPruebasVerificacion();
      var estadoUsuario = repositorio.obenerRegistroUsuario(
          NickFormado.constructor(event.nombreAProcesar));
      estadoUsuario.match(
          (l) => emit(MostrandoNombreNoConfirmado(l)),
          (r) => emit(MostrandoNombre(r.nombre, r.apellido, r.anioRegistro,
              r.pais, r.estado, event.nombreAProcesar)));
    });
    on<IrAJuegos>((event, emit) {
      ChecadorDeJugadasDePrueba checador = ChecadorDeJugadasDePrueba();
      var coleccionUsuario =
          checador.obtenerJuegos(NickFormado.constructor(event.nombreUsuario));
      emit(MostrandoJuegos(coleccionUsuario.juegos));
    });
  }
}
