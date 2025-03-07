import 'package:flutter/material.dart';

import '../../../utils/constants/colors.dart';


class TSettingsMenuTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTab;

  const TSettingsMenuTile(
      {super.key,
        required this.icon,
        required this.title,
        this.trailing, this.onTab, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        size: 28,
        color: TColors.primary,
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.headlineSmall,
      ),
      subtitle: subtitle != null ? Text(subtitle!) : null,
      trailing: trailing,
      onTap: onTab,
    );
  }
}
