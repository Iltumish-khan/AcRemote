import 'package:demo_project/components/air_flow.dart';
import 'package:demo_project/components/mode_widget.dart';
import 'package:demo_project/module/dashboard/cubit/dashboard_cubit.dart';
import 'package:demo_project/module/dashboard/cubit/dashboard_state.dart';
import 'package:demo_project/services/exports/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({super.key});

  final List<String> modesItem = [
    "Auto",
    "Dry",
    "Heating",
    "Cooling",
    "Turbo",
    "Eco",
  ];

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<DashboardCubit>();

    return BlocBuilder<DashboardCubit, DashboardState>(
        builder: (context, state) {
      return Scaffold(
        backgroundColor: homeBackgroundBlueColor.withOpacity(0.3),
        appBar: AppBar(
          title: const Text('Ac Remote'),
          elevation: 0.0,
          backgroundColor: transparentColor,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: () {
                  AppHelper.showToastMessage(
                      "Notification under progress", successColor);
                },
                icon: const Icon(Icons.notifications))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 15,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Modes',
                  style: dialogTextStyle,
                ),
                SizedBox(
                  height: 0.03.sh,
                ),
                SizedBox(
                  height: 20,
                  child: ListView.builder(
                      itemCount: !state.power ? 1 : modesItem.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Modes(
                          index: index,
                          title: !state.power ? "OFF" : modesItem[index],
                        );
                      }),
                ),
                SizedBox(
                  height: 0.03.sh,
                ),
                Text(
                  'Temperature',
                  style: dialogTextStyle,
                ),
                SizedBox(
                  height: 0.03.sh,
                ),
                Center(
                    child: SleekCircularSlider(
                  min: state.fanSpeedSelection ? 1 : 16,
                  max: state.fanSpeedSelection ? 3 : 30,
                  initialValue: state.fanSpeedSelection
                      ? !cubit.state.power
                          ? 1
                          : 2
                      : !cubit.state.power
                          ? 16
                          : 24,
                  appearance: CircularSliderAppearance(
                    size: 0.3.sh,
                  ),
                  onChange: (double value) {
                    state.fanSpeedSelection
                        ? cubit.fanSpeedChange(value)
                        : cubit.temperatureChange(value);
                  },
                  onChangeStart: (double startValue) {},
                  onChangeEnd: (double endValue) {
                    // ucallback providing an ending value (when a pan gesture ends)
                  },
                  innerWidget: (double value) {
                    return Center(
                        child: Text(
                      state.fanSpeedSelection
                          ? !cubit.state.power
                              ? "OFF"
                              : (state.fanSpeed.toInt()) == 1
                                  ? "LOW"
                                  : (state.fanSpeed.toInt()) == 2
                                      ? "MEDIUM"
                                      : "HIGH"
                          : !cubit.state.power
                              ? "OFF"
                              : (state.temperature.toInt()).toString(),
                      style: headingTextStyle,
                    ));
                    // use your custom widget inside the slider (gets a slider value from the callback)
                  },
                )),
                Row(
                  children: [
                    Expanded(
                      child: Card(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40.0),
                              bottomLeft: Radius.circular(40.0)),
                        ),
                        color: !state.power
                            ? greyColor
                            : state.temperatureSelection
                                ? Colors.blue.shade900
                                : whiteColor,
                        child: InkWell(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(40.0),
                              bottomLeft: Radius.circular(40.0)),
                          onTap: !state.power
                              ? null
                              : () {
                                  cubit.onChangetemperatureSelection();
                                },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 8,
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.thermostat,
                                  color: !state.power
                                      ? Colors.black
                                      : !state.temperatureSelection
                                          ? Colors.black
                                          : whiteColor,
                                ),
                                Text(
                                  'Temperature',
                                  style: !state.power
                                      ? flowTextStyle
                                      : state.temperatureSelection
                                          ? flowWhiteTextStyle
                                          : flowTextStyle,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Card(
                      color: !state.power ? greyColor : successColor,
                      child: InkWell(
                        onTap: () {
                          cubit.onChangePower();
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 8,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.power,
                                color: state.power ? whiteColor : Colors.black,
                              ),
                              Text(
                                state.power ? "ON" : "OFF",
                                style: state.power
                                    ? flowWhiteTextStyle
                                    : flowTextStyle,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Card(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(40.0),
                            bottomRight: Radius.circular(40.0),
                          ),
                        ),
                        color: !state.power
                            ? greyColor
                            : !state.fanSpeedSelection
                                ? whiteColor
                                : Colors.blue.shade900,
                        child: InkWell(
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(40.0),
                            bottomRight: Radius.circular(40.0),
                          ),
                          onTap: !state.power
                              ? null
                              : () {
                                  cubit.onChangeFanSpeed();
                                },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 15,
                              horizontal: 8,
                            ),
                            child: Row(
                              children: [
                                Image.asset(
                                  AssetsPath.fanMode,
                                  color: !state.power
                                      ? Colors.black
                                      : state.fanSpeedSelection
                                          ? whiteColor
                                          : Colors.black,
                                ),
                                Text(
                                  'Fan Speed',
                                  style: !state.power
                                      ? flowTextStyle
                                      : state.fanSpeedSelection
                                          ? flowWhiteTextStyle
                                          : flowTextStyle,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.sp,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const AirFlow(
                      title: 'Air Flow Horizontal',
                    ),
                    SizedBox(
                      width: 2.sp,
                    ),
                    const AirFlow(
                      title: 'Air Flow Vertical',
                    ),
                  ],
                ),
                SizedBox(
                  height: 0.05.sw,
                ),
                Text(
                  'Scheduling',
                  style: dialogTextStyle,
                ),
                SizedBox(
                  height: 0.02.sw,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () {
                              state.power
                                  ? _selectStartTime(context, cubit)
                                  : null;
                            },
                            child: Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(
                                vertical: 15,
                                horizontal: 8,
                              ),
                              decoration: BoxDecoration(
                                color: state.power
                                    ? Colors.blue.shade900
                                    : greyColor,
                                borderRadius: BorderRadius.circular(
                                  5,
                                ),
                              ),
                              child: Text(
                                '${state.startTime.hour.toString().length < 2 ? "0${state.startTime.hour}" : state.startTime.hour}:${state.startTime.minute.toString().length < 2 ? "0${state.startTime.minute}" : state.startTime.minute}',
                                style: state.power
                                    ? timerTextStyle
                                    : disabledTimerTextStyle,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 2.sp,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          state.power ? _selectEndTime(context, cubit) : null;
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 8,
                          ),
                          decoration: BoxDecoration(
                            color:
                                state.power ? Colors.blue.shade900 : greyColor,
                            borderRadius: BorderRadius.circular(
                              5,
                            ),
                          ),
                          child: Text(
                            '${state.endTime.hour.toString().length < 2 ? "0${state.endTime.hour}" : state.endTime.hour}:${state.endTime.minute.toString().length < 2 ? "0${state.endTime.minute}" : state.endTime.minute}',
                            style: state.power
                                ? timerTextStyle
                                : disabledTimerTextStyle,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 0.05.sw,
                ),
                Text(
                  'Test Control',
                  style: dialogTextStyle,
                ),
                SizedBox(
                  height: 0.02.sw,
                ),
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          state.power ? cubit.setTestControl(1) : null;
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 8,
                          ),
                          decoration: BoxDecoration(
                            color:
                                state.power ? Colors.blue.shade900 : greyColor,
                            borderRadius: BorderRadius.circular(
                              5,
                            ),
                          ),
                          child: Text(
                            'Start Test',
                            style: state.power
                                ? timerTextStyle
                                : disabledTimerTextStyle,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 2.sp,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          state.power ? cubit.setTestControl(0) : null;
                        },
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 8,
                          ),
                          decoration: BoxDecoration(
                            color:
                                state.power ? Colors.blue.shade900 : greyColor,
                            borderRadius: BorderRadius.circular(
                              5,
                            ),
                          ),
                          child: Text(
                            'End Test',
                            style: state.power
                                ? timerTextStyle
                                : disabledTimerTextStyle,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 0.05.sw,
                ),
                Text(
                  'Debug Console',
                  style: dialogTextStyle,
                ),
                SizedBox(
                  height: 0.02.sw,
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.black,
                  child: BlocBuilder<DashboardCubit, DashboardState>(
                    builder: (context, state) {
                      return ListView(
                        shrinkWrap: true,
                        children: state.logs
                            .map((log) => Text(
                                  log,
                                  style: const TextStyle(color: Colors.green),
                                ))
                            .toList(),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}

Future<void> _selectStartTime(
    BuildContext context, DashboardCubit cubit) async {
  final TimeOfDay? picked = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
    initialEntryMode: TimePickerEntryMode.input,
    builder: (BuildContext? context, Widget? child) {
      return Theme(
        data: ThemeData.light().copyWith(
          colorScheme: ColorScheme.light(
            // change the border color
            primary: Colors.blue.shade900,
            // change the text color
            onSurface: Colors.blue.shade900,
          ),
          // button colors
          buttonTheme: const ButtonThemeData(
            colorScheme: ColorScheme.light(
              primary: Colors.green,
            ),
          ),
        ),
        child: MediaQuery(
          data: MediaQuery.of(context!).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        ),
      );
    },
  );
  if (picked != null) {
    cubit.onChangeStartTime(picked);
  }
}

Future<void> _selectEndTime(BuildContext context, DashboardCubit cubit) async {
  final TimeOfDay? picked = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.now(),
    initialEntryMode: TimePickerEntryMode.input,
    builder: (BuildContext? context, Widget? child) {
      return Theme(
        data: ThemeData.light().copyWith(
          colorScheme: ColorScheme.light(
            // change the border color
            primary: Colors.blue.shade900,
            // change the text color
            onSurface: Colors.blue.shade900,
          ),
          // button colors
          buttonTheme: const ButtonThemeData(
            colorScheme: ColorScheme.light(
              primary: Colors.green,
            ),
          ),
        ),
        child: MediaQuery(
          data: MediaQuery.of(context!).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        ),
      );
    },
  );
  if (picked != null) {
    cubit.onChangeEndTime(picked);
  }
}
