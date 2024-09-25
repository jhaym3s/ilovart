import 'package:flutter/material.dart';
import 'package:travoli/core/configs/configs.dart';

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({
    super.key,
    required this.tabController,
    required this.label1,
    required this.label2
  });
  final TabController tabController;
  final String label1, label2;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52.dy,
      decoration: BoxDecoration(
        color: kWhite,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: TabBar(
        isScrollable: false,
        controller: tabController,
        dividerColor: Colors.transparent,
         padding: EdgeInsets.symmetric(horizontal: 8.dx, vertical: 6.dy),
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: kBlack,
        ),
        labelColor: kWhite,
        indicatorColor: kBlack,
        unselectedLabelColor: kBlack,
        indicatorSize: TabBarIndicatorSize.tab,
        labelStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 12.sp,
                color: const Color(0xff46531F)),
        unselectedLabelStyle: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 12.sp,
                color: const Color(0xff000000)),
        tabs:  [
          Tab(
            text: label1,
          ),
          Tab(
            text: label2,
          ),
        ],
      ),
    );
  }
}