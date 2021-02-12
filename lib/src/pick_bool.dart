import 'package:deep_pick/src/pick.dart';


extension BoolPick on Pick {
  bool _asBool() {
    final value = this.value;
    if (value is bool) {
      return value;
    }
    if (value is String) {
      if (value == 'true') return true;
      if (value == 'false') return false;
    }
    throw PickException('value $value of type ${value.runtimeType} '
        'at location ${location()} can not be casted to bool');
  }

  @Deprecated('Use .asBoolOrThrow()')
  bool Function() get asBool => asBoolOrThrow;

  bool asBoolOrThrow() {
    withContext(requiredPickErrorHintKey,
        'Use asBoolOrNull() when the value may be null/absent at some point (bool?).');
    return required()._asBool();
  }

  bool? asBoolOrNull() {
    if (value == null) return null;
    try {
      return required()._asBool();
    } catch (_) {
      return null;
    }
  }

  bool asBoolOrTrue() {
    if (value == null) return true;
    try {
      return required()._asBool();
    } catch (_) {
      return true;
    }
  }

  bool asBoolOrFalse() {
    if (value == null) return false;
    try {
      return required()._asBool();
    } catch (_) {
      return false;
    }
  }
}
