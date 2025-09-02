import 'package:flutter/widgets.dart';
import '/core/helper/helper.dart';

class OnCloseService extends WidgetsBindingObserver {
  final DbHelper _dbHelper;

  OnCloseService({required DbHelper dbHelper}) : _dbHelper = dbHelper;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.detached) {
      _dbHelper.closeAllDatabases();
    }
  }
}
