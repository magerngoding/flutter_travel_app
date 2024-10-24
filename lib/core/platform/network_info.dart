// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:connectivity_plus/connectivity_plus.dart';

abstract class NetworkInfo {
  Future<bool> listConected();
}

class NetworkImpl implements NetworkInfo {
  final Connectivity connectivity;
  NetworkImpl({
    required this.connectivity,
  });

  @override
  Future<bool> listConected() async {
    final connectivityResult = await connectivity.checkConnectivity();

    if (connectivityResult == ConnectivityResult.wifi ||
        ConnectivityResult == ConnectivityResult.mobile) {
      return true;
    }

    return false;
  }
}
