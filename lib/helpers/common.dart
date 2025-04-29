abstract class MappableParams {
  Map<String, dynamic> toMap();
}

Map<String, T> generateStatusMap<T>(
  List<T> values,
  String Function(T) nameGetter,
) {
  return {for (var e in values) _toSnakeCase(nameGetter(e)).toUpperCase(): e};
}

String _toSnakeCase(String input) {
  return input
      .replaceAllMapped(
        RegExp(r'([a-z])([A-Z])'),
        (match) => '${match.group(1)}_${match.group(2)}',
      )
      .toUpperCase();
}
