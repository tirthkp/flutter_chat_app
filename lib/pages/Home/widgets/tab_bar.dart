import 'package:flutter/material.dart';

myTabBar(TabController tabController, BuildContext context) {
  return PreferredSize(
    preferredSize: const Size.fromHeight(60),
    child: TabBar(
        controller: tabController,
        labelStyle: Theme.of(context).textTheme.bodyLarge,
        unselectedLabelStyle: Theme.of(context).textTheme.labelLarge,
        dividerHeight: 0,
        indicatorSize: TabBarIndicatorSize.label,
        enableFeedback: false,
        overlayColor: WidgetStateProperty.resolveWith<Color?>(
          (Set<WidgetState> states) {
            return states.contains(WidgetState.focused)
                ? null
                : Colors.transparent;
          },
        ),
        tabs: const [
          Tab(
            text: 'Chats',
          ),
          Tab(
            text: 'Groups',
          ),
          Tab(
            text: 'Calls',
          ),
        ]),
  );
}
