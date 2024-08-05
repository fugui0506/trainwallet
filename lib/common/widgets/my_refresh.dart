import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

/// ## 通用下拉刷新组件
/// ### 参数一：controller 必传，方便控制刷新的一些控制
/// ### 参数二：onRefresh 是下拉刷新的方法，可选
/// - 传入了这个方法会自动打开允许下拉刷新，
/// 也会自动填充下拉刷新的样式
/// ### 参数三：onLoading 是上拉加载更多数据的方法，可选
/// - 传入了这个方法会自动打开允许上拉加载，
/// 也会自动填充上拉的样式
/// ### 参数四：child 需要传入各种滑动组件
/// - 不传的话没有效果
class MyRefreshView extends StatelessWidget {
  const MyRefreshView({
    super.key,
    required this.controller,
    this.onRefresh,
    this.onLoading,
    required this.children,
    this.scrollController,
    this.padding,
  });
  final RefreshController controller;
  final void Function()? onRefresh;
  final void Function()? onLoading;
  final List<Widget> children;
  final ScrollController? scrollController;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final header = WaterDropHeader(
      complete: Center(child: Container(
        width: 26,
        height: 26,
        decoration: const BoxDecoration(
            color: Colors.green, shape: BoxShape.circle),
        clipBehavior: Clip.antiAlias,
        child: const Icon(
          Icons.done,
          color: Colors.white,
          size: 16,
        ),
      )),
    );

    final footer = CustomFooter(
      height: 80,
      builder: (context, mode) {
        Widget body;
        if (mode == LoadStatus.idle) {
          body = const Text("上拉加载");
        } else if (mode == LoadStatus.loading) {
          body = const CupertinoActivityIndicator();
        } else if (mode == LoadStatus.failed) {
          body = const Text("加载失败！点击重试！");
        } else if (mode == LoadStatus.canLoading) {
          body = const Text("松手,加载更多!");
        } else {
          body = const Text("没有更多数据了!");
        }
        return SizedBox(
          height: 55.0,
          child: Center(child: body),
        );
      },
    );

    return SmartRefresher(
      // 是否允许下拉刷新
      // 如果没有传入刷新的方法，这里就直接定义为 false
      enablePullDown: onRefresh == null ? false : true,
      // 是否允许上拉加载新数据
      // 如果没有传入相应的方法，这里就直接定义为 false
      enablePullUp: onLoading == null ? false : true,
      header: onRefresh == null ? null : header,
      footer: onLoading == null ? null : footer,
      controller: controller,
      onRefresh: onRefresh,
      onLoading: onLoading,
      child: ListView(
        controller: scrollController,
        padding: padding,
        children: children,
      ),
    );
  }
}
