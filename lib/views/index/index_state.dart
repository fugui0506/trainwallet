import 'package:get/get.dart';

class IndexState {
  final _timer = 0.obs;
  set timer(int value) => _timer.value = value;
  int get timer => _timer.value;

  final imageBytes = <int>[].obs;

  final isMove = false.obs;

  final zoumadeng = ''.obs;
}
