import 'package:cgwallet/views/views.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common/common.dart';
import 'index.dart';

class FrameView extends GetView<FrameController> {
  const FrameView({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).myColors.background,
      body: Obx(() => _buildBody(context)),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        IndexedStack(
          index: controller.state.pageIndex,
          children:const [
            HomeView(),
            FlashExchangeView(),
            ChatView(),
            MineView(),
          ],
        ),
        _buildBottomNavigationBar(context),
      ],
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    final floatButton = Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Theme.of(context).myColors.background,
      ),
      child: MyButton.widget(onPressed: controller.goScanView, child: Column(children: [
        MyButton.icon(onPressed: controller.goScanView, icon: Theme.of(context).myIcons.bottomScan),
      ])),
    );

    final bottomItems = Row(children: [
      Expanded(child: MyButton.widget(onPressed: () => controller.onChanged(0), child: Container(color: Theme.of(context).myColors.background.withOpacity(0), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        SizedBox(height: 24, child: controller.state.pageIndex == 0 ? Theme.of(context).myIcons.bottomHome1 : Theme.of(context).myIcons.bottomHome0,),
        SizedBox(height: 18, width: double.infinity, child: Center(child: FittedBox(child: Text(Lang.bottomHome.tr, style: controller.state.pageIndex == 0 ? Theme.of(context).myStyles.bottomSelect : Theme.of(context).myStyles.bottomUnselect)))),
      ])))),
       Expanded(child: MyButton.widget(onPressed: () => controller.onChanged(1), child: Container(color: Theme.of(context).myColors.background.withOpacity(0), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        SizedBox(height: 24, child: controller.state.pageIndex == 1 ? Theme.of(context).myIcons.bottomFlash1 : Theme.of(context).myIcons.bottomFlash0,),
        SizedBox(height: 18, width: double.infinity, child: Center(child: FittedBox(child: Text(Lang.bottomFlashExchange.tr, style: controller.state.pageIndex == 1 ? Theme.of(context).myStyles.bottomSelect : Theme.of(context).myStyles.bottomUnselect)))),
      ])))),
       Expanded(child: MyButton.widget(onPressed: () => controller.onChanged(4), child: Container(color: Theme.of(context).myColors.background.withOpacity(0), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        SizedBox(height: 24, child: Theme.of(context).myIcons.bottomScan),
        SizedBox(height: 18, width: double.infinity, child: Center(child: FittedBox(child: Text(Lang.bottomScan.tr, style: Theme.of(context).myStyles.bottomSelect)))),
      ])))),
       Expanded(child: MyButton.widget(onPressed: () => controller.onChanged(2), child: Container(color: Theme.of(context).myColors.background.withOpacity(0), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        SizedBox(height: 24, child: controller.state.pageIndex == 2 ? Theme.of(context).myIcons.bottomChat1 : Theme.of(context).myIcons.bottomChat0,),
        SizedBox(height: 18, width: double.infinity, child: Center(child: FittedBox(child: Text(Lang.bottomChat.tr, style: controller.state.pageIndex == 2 ? Theme.of(context).myStyles.bottomSelect : Theme.of(context).myStyles.bottomUnselect)))),
      ])))),
       Expanded(child: MyButton.widget(onPressed: () => controller.onChanged(3), child: Container(color: Theme.of(context).myColors.background.withOpacity(0), child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        SizedBox(height: 24, child: controller.state.pageIndex == 3 ? Theme.of(context).myIcons.bottomMine1 : Theme.of(context).myIcons.bottomMine0,),
        SizedBox(height: 18, width: double.infinity, child: Center(child: FittedBox(child: Text(Lang.bottomMine.tr, style: controller.state.pageIndex == 3 ? Theme.of(context).myStyles.bottomSelect : Theme.of(context).myStyles.bottomUnselect)))),
      ])))),
    ]);
    
    final navigationBar = Stack(
      alignment: Alignment.bottomCenter,
      children: [
        const SizedBox(
          width: double.infinity,
          height: 80,
        ),
        Container(
          color: Theme.of(context).myColors.background,
          child: SizedBox(height: 58, child: bottomItems),
        ),
        Positioned(
          top: 0,
          child: floatButton,
        ),
      ],
    );

    final bottomSafeSpace = Container(
      color: Theme.of(context).myColors.background, 
      child: SafeArea(top: false,child: Container(color: Theme.of(context).myColors.background))
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        navigationBar,
        bottomSafeSpace,
    ]);
  }
}