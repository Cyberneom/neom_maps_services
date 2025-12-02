
class Path {
  final String? color;
  final String? enc;

  Path({
    this.color,
    this.enc,
  });

  @override
  String toString() {
    return [
      color != null ? 'color:$color' : null,
      enc != null ? 'enc:$enc' : null,
    ].where((v) => v != null).join('|');
  }
}
