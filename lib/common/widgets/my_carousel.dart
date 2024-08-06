import 'dart:async';

import 'package:cgwallet/common/common.dart';
import 'package:flutter/material.dart';

class MyCarousel extends StatefulWidget {
  const MyCarousel({
    super.key, 
    required this.children, 
  });

  final List<Widget> children;

  @override
  State<MyCarousel> createState() => _MyCarouselState();
}

class _MyCarouselState extends State<MyCarousel> {
  final PageController pageController = PageController();
  late List<Widget> list;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    list = [...widget.children, ...widget.children, ...widget.children];
    initPageIndex();
  }

  @override
  void dispose() {
    pageController.dispose();
    timer?.cancel();
    super.dispose();
  }

  void autoToNextPage() {
    cancelTimer();
    timer = Timer(MyConfig.app.timeWait, () {
      if (mounted) {
        final index = pageController.page?.toInt() ?? 0;
        pageController.animateToPage(index + 1, duration: MyConfig.app.timePageTransition, curve: Curves.linear);
      } else {
        cancelTimer();
      }
    });
  }

  void cancelTimer() {
    timer?.cancel();
    timer = null;
  }

  void initPageIndex() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      pageController.jumpToPage(widget.children.length);
      autoToNextPage();
    });
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      onNotification: (notification) {
        if (notification is ScrollEndNotification) {
          final index = pageController.page?.toInt() ?? 0;
          if (index == 0) {
            list.removeRange(widget.children.length * 2, list.length);
            list.insertAll(0, widget.children);
            initPageIndex();
          } else if (index == widget.children.length * 2) {
            list.addAll(widget.children);
            list.removeRange(0, widget.children.length);
            initPageIndex();
          } else {
            autoToNextPage();
          }
        } else if (notification is ScrollStartNotification) {
          cancelTimer();
        }
        return false;
      },
      child: PageView(
        controller: pageController,
        onPageChanged: (i) {
          // print('$i / ${list.length}');
          // 页面改变的回调
          // widget.onChanged(i % widget.children.length);
          cancelTimer();
        },
        children: list,
      ),
    );
  }
}
