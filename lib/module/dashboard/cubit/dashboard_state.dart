import 'package:flutter/material.dart';

class DashboardState {
  final bool isLoading;
  final String? error;
  final int temperature;
  final int modeIndex;
  final bool temperatureSelection;
  final bool power;
  final bool fanSpeedSelection;
  final int fanSpeed;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final String? notifyValue;
  final List<String> logs;

  const DashboardState({
    this.isLoading = false,
    this.error,
    this.temperature = 24,
    this.modeIndex = 1,
    this.temperatureSelection = true,
    this.power = true,
    this.fanSpeedSelection = false,
    this.fanSpeed = 2,
    this.startTime = const TimeOfDay(hour: 12, minute: 00),
    this.endTime = const TimeOfDay(hour: 14, minute: 00),
    this.notifyValue,
    this.logs = const [],
  });

  DashboardState copyWith({
    bool? isLoading,
    String? error,
    int? temperature,
    int? modeIndex,
    bool? temperatureSelection,
    bool? power,
    bool? fanSpeedSelection,
    int? fanSpeed,
    TimeOfDay? startTime,
    TimeOfDay? endTime,
    String? notifyValue,
    List<String>? logs,
  }) {
    return DashboardState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      temperature: temperature ?? this.temperature,
      modeIndex: modeIndex ?? this.modeIndex,
      temperatureSelection: temperatureSelection ?? this.temperatureSelection,
      power: power ?? this.power,
      fanSpeedSelection: fanSpeedSelection ?? this.fanSpeedSelection,
      fanSpeed: fanSpeed ?? this.fanSpeed,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      notifyValue: notifyValue ?? this.notifyValue,
      logs: logs ?? this.logs,
    );
  }
}
