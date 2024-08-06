import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../common/common.dart';
import 'index.dart';

class HomeController extends GetxController {
  final state = HomeState();
  final RefreshController refreshController = RefreshController();
  final ScrollController scrollController = ScrollController();

  @override
  void onReady() async {
    super.onReady();
    await Future.delayed(MyConfig.app.timePageTransition);
    await getHomeData();
  }

  Future<void> getHomeData() async {
    await getUnReadCount();
    await getMarqueeList();
    await getCarouselList();
  }

  void copyUserId() {
    UserController.to.userInfo.value.user.id.toString().copyToClipBoard();
  }

  void copyWalletAddress() {
    UserController.to.userInfo.value.walletAddress.toString().copyToClipBoard();
  }

  void goUserInfoView() {
    
  }

  void goNoticeView() {
    state.noticeUnReadCount == 0 ? state.noticeUnReadCount = 99 : state.noticeUnReadCount = 0;
  }

  Future<void> getUnReadCount() async {
    await DioService.to.post(ApiPath.me.getUnreadCount,
      onSuccess: (code, msg, data) {
        state.noticeUnReadCount = data is int ? data : 0;
      },
    );
  }

  Future<void> getMarqueeList() async {
    await state.marqueeList.value.update();
    state.marqueeList.update((val) {});
  }

  Future<void> getCarouselList() async {
    await state.carouselList.value.update();
    state.carouselList.update((val) {});
  }
}
