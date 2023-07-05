import 'package:loggy/loggy.dart';

mixin ApiLoggy implements LoggyType {
  @override
  Loggy<ApiLoggy> get loggy => Loggy<ApiLoggy>('Api Loggy - $runtimeType');
}
