import 'package:cgwallet/common/common.dart';
import 'package:get/get.dart';

class HomeState {
  final _noticeUnReadCount = 99.obs;
  int get noticeUnReadCount => _noticeUnReadCount.value;
  set noticeUnReadCount(int value) => _noticeUnReadCount.value = value;

  final marqueeList = MarqueeListModel.empty().obs;
  final carouselList = CarouselListModel.empty().obs;
  final faqList = FaqListModel.empty().obs;


  final _carouselIndex = 0.obs;
  int get carouselIndex => _carouselIndex.value;
  set carouselIndex(int value) => _carouselIndex.value = value;
}
