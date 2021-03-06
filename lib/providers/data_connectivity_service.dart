import 'package:data_connection_checker/data_connection_checker.dart';
import 'dart:async';

class DataConnectivityService {
  // ignore: close_sinks
  StreamController<DataConnectionStatus> connectivityStreamController = StreamController<DataConnectionStatus>();

  DataConnectivityService() {
    DataConnectionChecker().onStatusChange.listen((dataConnectionStatus) {
      connectivityStreamController.add(dataConnectionStatus);
    });
  }
}