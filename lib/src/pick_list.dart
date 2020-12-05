import 'package:deep_pick/src/pick.dart';

extension ListPick on RequiredPick {
  List<T> asList<T>([T Function(Pick)? map]) {
    final value = this.value;
    if (value is List) {
      if (map == null) {
        return value.cast<T>();
      }
      var i = 0;
      return value
          .map((it) => map(Pick(it, path: [...path, i++], context: context)))
          .toList(growable: false);
    }
    throw PickException('value $value of type ${value.runtimeType} '
        'at location ${location()} can not be casted to List<dynamic>');
  }
}

extension NullableListPick on Pick {
  // This deprecation is used to promote the `.required()` in auto-completion.
  // Therefore it is not intended to be ever removed
  @Deprecated(
      'By default values are optional and can only be converted when a fallback is provided '
      'i.e. .asListOrNull() which falls back to `null`. '
      'Use .required().asList() in cases the value is mandatory. '
      "It will crash when the value couldn't be picked.")
  List<T> asList<T>([T Function(Pick)? map]) {
    if (value == null) {
      throw PickException(
          'value at location ${location()} is null and not an instance of List<$T>');
    }
    return required().asList(map);
  }

  List<T> asListOrEmpty<T>([T Function(Pick)? map]) {
    if (value == null) return <T>[];
    if (value is! List) return <T>[];
    return required().asList(map);
  }

  List<T>? asListOrNull<T>([T Function(Pick)? map]) {
    if (value == null) return null;
    if (value is! List) return null;
    return required().asList(map);
  }
}
