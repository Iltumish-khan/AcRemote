import 'package:demo_project/module/dashboard/cubit/dashboard_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blue/flutter_blue.dart';

class DashboardCubit extends Cubit<DashboardState> {
  final FlutterBlue _flutterBlue = FlutterBlue.instance;
  BluetoothDevice? _connectedDevice;
  BluetoothCharacteristic? _temperatureCharacteristic;
  BluetoothCharacteristic? _modeCharacteristic;
  BluetoothCharacteristic? _fanSpeedCharacteristic;
  BluetoothCharacteristic? _schedulingCharacteristic;
  BluetoothCharacteristic? _testControlCharacteristic;
  BluetoothCharacteristic? _debugLogsCharacteristic;
  DashboardCubit() : super(const DashboardState()) {
    startScan();
  }

  void temperatureChange(double temperature) {
    _temperatureCharacteristic?.write([temperature.toInt()]);
    emit(state.copyWith(temperature: temperature.toInt()));
  }

  void fanSpeedChange(double fanSpeed) {
    _fanSpeedCharacteristic?.write([fanSpeed.toInt()]);
    emit(state.copyWith(fanSpeed: fanSpeed.toInt()));
  }

  void modeChange(int index) {
    _modeCharacteristic?.write([index]);
    emit(state.copyWith(modeIndex: index));
  }

  void onChangetemperatureSelection() {
    emit(state.copyWith(temperatureSelection: true, fanSpeedSelection: false));
  }

  void onChangePower() {
    if (state.power) {
      emit(state.copyWith(
          startTime: const TimeOfDay(hour: 00, minute: 00),
          endTime: const TimeOfDay(hour: 00, minute: 00)));
    } else {
      emit(state.copyWith(
          startTime: const TimeOfDay(hour: 12, minute: 00),
          endTime: const TimeOfDay(hour: 14, minute: 00)));
    }
    emit(state.copyWith(
      power: !state.power,
    ));
  }

  void onChangeFanSpeed() {
    emit(state.copyWith(fanSpeedSelection: true, temperatureSelection: false));
  }

  void onChangeStartTime(TimeOfDay time) {
    emit(state.copyWith(startTime: time));
  }

  void onChangeEndTime(TimeOfDay time) {
    emit(state.copyWith(endTime: time));
  }

  void setScheduling(String scheduling) {
    _schedulingCharacteristic?.write(scheduling.codeUnits);
    // emit(state.copyWith(scheduling: scheduling));
  }

  void setTestControl(int control) {
    _testControlCharacteristic?.write([control]);
  }

  void _addLog(String log) {
    final updatedLogs = List<String>.from(state.logs)..add(log);
    emit(state.copyWith(logs: updatedLogs));
  }

  void startScan() {
    _flutterBlue.startScan(timeout: const Duration(seconds: 4));

    _flutterBlue.scanResults.listen((results) {
      for (ScanResult r in results) {
        if (r.device.name == 'MockIoTDevice') {
          _flutterBlue.stopScan();
          _connectToDevice(r.device);
          break;
        }
      }
    });
  }

  void _connectToDevice(BluetoothDevice device) async {
    await device.connect();
    _connectedDevice = device;
    _discoverServices();
  }

  void _discoverServices() async {
    var services = await _connectedDevice!.discoverServices();
    for (var service in services) {
      if (service.uuid.toString() == '12345678-1234-5678-1234-56789abcdef0') {
        for (var characteristic in service.characteristics) {
          switch (characteristic.uuid.toString()) {
            case '12345678-1234-5678-1234-56789abcdef1':
              _temperatureCharacteristic = characteristic;
              break;
            case '12345678-1234-5678-1234-56789abcdef2':
              _modeCharacteristic = characteristic;
              break;
            case '12345678-1234-5678-1234-56789abcdef3':
              _fanSpeedCharacteristic = characteristic;
              break;
            case '12345678-1234-5678-1234-56789abcdef4':
              _schedulingCharacteristic = characteristic;
              break;
            case '12345678-1234-5678-1234-56789abcdef5':
              _testControlCharacteristic = characteristic;
              break;
            case '12345678-1234-5678-1234-56789abcdef6':
              _debugLogsCharacteristic = characteristic;
              _debugLogsCharacteristic?.setNotifyValue(true);
              _debugLogsCharacteristic?.value.listen((value) {
                _addLog(String.fromCharCodes(value));
              });
              break;
          }
        }
      }
    }
  }
}
