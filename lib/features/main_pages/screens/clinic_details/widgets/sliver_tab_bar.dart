
// --------------------------
// SliverTabBar Delegate
// --------------------------


import 'package:flutter/material.dart';

class CustomSliverTabBar extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;
  final Color background;

  CustomSliverTabBar(this.tabBar, {required this.background});

  @override
  double get minExtent => tabBar.preferredSize.height;
  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(color: background, child: tabBar);
  }

  @override
  bool shouldRebuild(covariant CustomSliverTabBar oldDelegate) =>
      oldDelegate.tabBar != tabBar || oldDelegate.background != background;
}


