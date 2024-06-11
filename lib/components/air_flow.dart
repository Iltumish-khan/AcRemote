import 'package:demo_project/module/dashboard/cubit/dashboard_cubit.dart';
import 'package:demo_project/module/dashboard/cubit/dashboard_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_colors.dart';
import '../utils/assets_path.dart';
import '../utils/text_styles.dart';

class AirFlow extends StatelessWidget {
  const AirFlow({
    super.key,
    this.title,
  });

  final String? title;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardCubit, DashboardState>(
        builder: (context, state) {
      return Expanded(
        child: Container(
          decoration: BoxDecoration(
              color: state.power ? Colors.blue.shade900 : greyColor,
              borderRadius: BorderRadius.circular(5)),
          child: InkWell(
            onTap: null,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 15,
                horizontal: 8,
              ),
              child: Row(
                children: [
                  Image.asset(
                    AssetsPath.flow,
                    height: 24,
                    width: 24,
                  ),
                  SizedBox(
                    width: 0.03.sw,
                  ),
                  Text(
                    title ?? '',
                    style: state.power ? flowWhiteTextStyle : flowTextStyle,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
