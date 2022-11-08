class ImagenFormado {
  late final String valor;
  ImagenFormado._(this.valor);

  factory ImagenFormado.constructor(String imagenPropuesta) {
    if (imagenPropuesta.trim().isEmpty) {
      throw ('Imagen no formada');
    }
    return ImagenFormado._(imagenPropuesta);
  }
}
