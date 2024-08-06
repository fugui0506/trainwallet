import 'package:cgwallet/common/common.dart';
import 'package:cgwallet/common/models/carousel_model.dart';
import 'package:get/get.dart';

class HomeState {
  final _noticeUnReadCount = 99.obs;
  int get noticeUnReadCount => _noticeUnReadCount.value;
  set noticeUnReadCount(int value) => _noticeUnReadCount.value = value;

  final marqueeList = MarqueeListModel.empty().obs;
  final carouselList = CarouselListModel.empty().obs;
}
