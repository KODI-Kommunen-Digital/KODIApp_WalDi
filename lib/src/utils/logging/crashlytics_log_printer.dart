import 'package:flutter_loggy/flutter_loggy.dart';
import 'package:loggy/loggy.dart';

class FirebaseCrashlyticsLogPrinter extends PrettyDeveloperPrinter {
  @override
  void onLog(LogRecord record) {
    super.onLog(record);
    if (record.level.priority >= LogLevel.error.priority) {
      /*FirebaseCrashlytics.instance.recordError(
        record.error,
        record.stackTrace,
        reason: record.message,
      );*/
    }
  }
}
