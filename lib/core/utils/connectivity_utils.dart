import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityUtils {
  static final Connectivity _connectivity = Connectivity();

  // Check if the device has an internet connection
  static Future<bool> hasInternetConnection() async {
    final connectivityResult = await _connectivity.checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }
  
  // Stream of connectivity changes
  static Stream<ConnectivityResult> get connectivityStream => 
      _connectivity.onConnectivityChanged;
}