import 'package:flutter/material.dart';

class MyCarousel extends StatefulWidget {
  const MyCarousel({
    super.key, 
    required this.children, 
    required this.onChanged,
  });

  final List<Widget> children;
  final void Function(int index) onChanged;

  @override
  State<MyCarousel> createState() => _MyCarouselState();
}

class _MyCarouselState extends State<MyCarousel> {
  final PageController pageController = PageController();
  late List<Widget> list;

  @override
  void initState() {
    super.initState();
    list = [...widget.children, ...widget.children, ...widget.children];
    init();
  }

  void init() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      pageController.jumpToPage(widget.children.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      onNotification: (notification) {
        if (notification is ScrollEndNotification) {
          final index = pageController.page?.toInt() ?? 0;
          if (index == 0) {
            Future.microtask(() {
              setState(() {
                list.removeRange(widget.children.length * 2, list.length);
                list.insertAll(0, widget.children);
              });
            }).then((value) => pageController.jumpToPage(widget.children.length));
          } else if (index == widget.children.length * 2) {
            setState(() {
              list.addAll(widget.children);
              list.removeRange(0, widget.children.length);
            });
            Future.microtask(() {  
              pageController.jumpToPage(widget.children.length);
            });
          }
        }
        return false;
      },
      child: PageView(
        controller: pageController,
        onPageChanged: (i) {
          widget.onChanged(i % widget.children.length);
        },
        children: list,
      )
    );
  }
}