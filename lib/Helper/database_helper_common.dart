import 'dart:io' show Platform;

export 'database_helper.dart' if (dart.library.html) 'database_helper_web.dart';
