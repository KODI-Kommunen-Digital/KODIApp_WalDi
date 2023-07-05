import 'package:loggy/loggy.dart';

mixin DriftLoggy implements LoggyType {
  @override
  Loggy<DriftLoggy> get loggy =>
      Loggy<DriftLoggy>('Drift Loggy - $runtimeType');
}
