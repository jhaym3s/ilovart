import 'package:flutter/material.dart';
import 'package:travoli/core/configs/configs.dart';
import '../../../../core/components/components.dart';
import '../widgets/history_tile.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen>
    with SingleTickerProviderStateMixin{
  late TabController _tabController;
  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: kScreenPadding.dx),
              child: CustomText(
                      text:"History",
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xff0B0B0B),
                      fontFamily: kSecondaryFontFamily,
                    ),
            ),
            SpaceY(10.dy),
            Expanded(
              child:  ListView.builder(
                         padding: EdgeInsets.symmetric(horizontal: kScreenPadding.dx, ),
                         itemBuilder: (context,index){
                         return const PendingHistoryTile();
                       }),
            ),
           //CustomTabBar(tabController: _tabController, label1: "Pending",  label2: "Complete"),
          //  Expanded(
          //   child: TabBarView(
          //     controller: _tabController,
          //     children: [
          //       //
          //      ListView.builder(
          //                padding: EdgeInsets.symmetric(horizontal: kScreenPadding.dx, vertical: 24.dy),
          //                itemBuilder: (context,index){
          //                return const PendingHistoryTile();
          //              }),
          //   ListView.builder(
          //             padding: EdgeInsets.symmetric(horizontal: kScreenPadding.dx,vertical: 24.dy),
          //             itemBuilder: (context,index){
          //             return const HistoryTile();
          //           })
          //     ],
          //   ),
          // ),
          ],
        ),
      ),
    );
  }
}
