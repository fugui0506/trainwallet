import 'package:cgwallet/common/common.dart';
import 'package:cgwallet/common/widgets/my_card.dart';
import 'package:cgwallet/common/widgets/my_image.dart';
import 'package:cgwallet/common/widgets/my_marquee.dart';
import 'package:cgwallet/common/widgets/my_refresh.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'index.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    /// 页面构成
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (controller) => _buildScaffold(context, controller),
    );
  }

  Widget _buildScaffold(BuildContext context, HomeController controller) {
    return Scaffold(
      appBar: _buildAppBar(context, controller), 
      body: _buildBody(context, controller),
    );
  }

  MyAppBar _buildAppBar(BuildContext context, HomeController controller) {
    return MyAppBar.spacer(
      title: _buildAppBarTitle(context, controller),
      bottom: _buildAppBarBottom(context, controller),
      flexibleSpace: _buildAppBarSpace(context),
    );
  }

  Widget _buildAppBarSpace(BuildContext context) {
    return Container(color: Theme.of(context).myColors.primary,
      child: Theme.of(context).myIcons.homeAppBarBackground,
    );
  }

  Widget _buildBody(BuildContext context, HomeController controller) {
    return MyRefreshView(
      padding: const EdgeInsets.all(16),
      controller: controller.refreshController, 
      children: [
        _buildMarquee(context, controller),
      ]
    );
  }

  Widget _buildMarquee(BuildContext context, HomeController controller) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Theme.of(context).myIcons.homeNewsIcon,
      const SizedBox(width: 8),
      Expanded(child:  Obx(() => controller.state.marqueeList.value.list.isEmpty
        ? const SizedBox()
        : MyMarquee(marqueeList: controller.state.marqueeList.value)
      )),
    ]);
  }

  Widget _buildAppBarTitle(BuildContext context, HomeController controller) {
    final avatarButton = MyButton.widget(onPressed: controller.goUserInfoView, child: Row(children: [
      const SizedBox(width: 16),
      MyCard.avatar(context, 16, child: Obx(() => MyImage(imageUrl: UserController.to.userInfo.value.user.avatarUrl))),
      const SizedBox(width: 8),
      Obx(() => Text('${Lang.homeViewUid.tr} ${UserController.to.userInfo.value.user.id}', style: Theme.of(context).myStyles.onHomeAppBarUID)),
    ]));
    return Row(children: [
      avatarButton,
      MyButton.icon(onPressed: controller.copyUserId, icon: Theme.of(context).myIcons.homeCopy),
      const Spacer(),
      Obx(() => MyButton.icon(onPressed: controller.goNoticeView, icon: controller.state.noticeUnReadCount > 0 ? Theme.of(context).myIcons.homeNotice1 : Theme.of(context).myIcons.homeNotice0))
    ]);
  }

  PreferredSizeWidget _buildAppBarBottom(BuildContext context, HomeController controller) {
    const width = double.infinity;
    const height = 24.0 + 36.0 + 34.0 + 9.0;

    final title = Row(children: [
      Expanded(child: Container(padding: const EdgeInsets.fromLTRB(16, 0, 8, 0), height: 24, alignment: Alignment.centerLeft, child: FittedBox(
        child: Text(Lang.homeViewBlance.tr, style: Theme.of(context).myStyles.onHomeAppBarNormal)
      ))),
      Expanded(child: Container(padding: const EdgeInsets.fromLTRB(8, 0, 8, 0), height: 24, alignment: Alignment.center, child: FittedBox(
        child: Text(Lang.homeViewSelling.tr, style: Theme.of(context).myStyles.onHomeAppBarNormal)
      ))),
      Expanded(child: Container(padding: const EdgeInsets.fromLTRB(8, 0, 16, 0), height: 24, alignment: Alignment.centerRight, child: FittedBox(
        child: Text(Lang.homeViewLock.tr, style: Theme.of(context).myStyles.onHomeAppBarNormal)
      ))),
    ]);

    final amount = Row(children: [
      Expanded(child: Container(padding: const EdgeInsets.fromLTRB(16, 0, 8, 0), height: 36, alignment: Alignment.centerLeft, child: FittedBox(
        child: Obx(() => Text(UserController.to.userInfo.value.balance, style: Theme.of(context).myStyles.onHomeAppBarBigger))
      ))),
      Expanded(child: Container(padding: const EdgeInsets.fromLTRB(8, 0, 8, 0), height: 36, alignment: Alignment.center, child: FittedBox(
        child: Obx(() => Text(UserController.to.userInfo.value.frozenBalance, style: Theme.of(context).myStyles.onHomeAppBarHeader))
      ))),
      Expanded(child: Container(padding: const EdgeInsets.fromLTRB(8, 0, 16, 0), height: 36, alignment: Alignment.centerRight, child: FittedBox(
        child: Obx(() => Text(UserController.to.userInfo.value.lockBalance, style: Theme.of(context).myStyles.onHomeAppBarHeader))
      ))),
    ]);

    final walletAddressTitle = SizedBox(width: 80, height: 34, child: Stack(alignment: Alignment.center, children: [
      Theme.of(context).myIcons.homeWalletAddressBackground,
      Padding(padding: const EdgeInsets.fromLTRB(10, 0, 10, 0), child: FittedBox(child: Text(Lang.homeViewWalletAddress.tr, style: Theme.of(context).myStyles.onHomeAppBarNormal)),),
    ]));

    final walletAddress = Row(children: [
      const SizedBox(width: 16),
      walletAddressTitle,
      const SizedBox(width: 16),
      Obx(() => Text(UserController.to.userInfo.value.walletAddress, style: Theme.of(context).myStyles.onHomeAppBarNormal)),
      const SizedBox(width: 10),
      MyButton.widget(onPressed: controller.copyWalletAddress, child: Theme.of(context).myIcons.homeCopy),
      const SizedBox(width: 10),
      MyButton.widget(onPressed: controller.copyWalletAddress, child: Theme.of(context).myIcons.qrcode),
    ]);

    return PreferredSize(
      preferredSize: const  Size(width, height),
      child: SizedBox(width: width, height: height,child: Column(children: [
        title, amount, walletAddress
      ])),
    );
  }
}
