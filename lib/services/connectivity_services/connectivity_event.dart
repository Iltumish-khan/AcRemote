part of 'connectivity_bloc.dart';

abstract class ConnectivityEvent {}

class NetworkObserve extends ConnectivityEvent {}

class NetworkNotify extends ConnectivityEvent {
  final bool isConnected;

  NetworkNotify({this.isConnected = false});
}
