part of 'connectivity_bloc.dart';

abstract class ConnectivityState {}

class NetworkInitial extends ConnectivityState {}

class NetworkConnected extends ConnectivityState {}

class NetworkDisconnected extends ConnectivityState {}
