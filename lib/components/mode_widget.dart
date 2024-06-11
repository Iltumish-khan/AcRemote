import 'package:demo_project/module/dashboard/cubit/dashboard_cubit.dart';
import 'package:demo_project/module/dashboard/cubit/dashboard_state.dart';
import 'package:demo_project/services/exports/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Modes extends StatelessWidget {
  const Modes({
    super.key,
    this.index = 1,
    this.title,
  });

  final int? index;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardCubit, DashboardState>(
        builder: (context, state) {
      return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: state.modeIndex != index
                ? [greyColor, greyColor]
                : [
                    homeBackgroundPinkColor,
                    homeBackgroundPurpleColor,
                  ],
          ),
          borderRadius: BorderRadius.circular(10.0), // Rounded corners
          // A subtle shadow to add depth
          boxShadow: [
            BoxShadow(
                blurRadius: 5,
                color: state.modeIndex != index
                    ? Colors.black
                    : homeBackgroundPinkColor,
                offset: const Offset(2, 2))
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        margin: const EdgeInsets.symmetric(
          horizontal: 2,
        ),
        child: InkWell(
          onTap: () {
            context.read<DashboardCubit>().modeChange(index!);
          },
          child: Text(
            title ?? '',
            style: !state.power ? flowTextStyle : modesTextStyle,
          ),
        ),
      );
    });
  }
}
