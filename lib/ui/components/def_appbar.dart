import 'package:flutter/material.dart';
import '../../core/ui_helper.dart';
import '../../core/styles.dart';

class DefAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actBtn;
  const DefAppBar({Key? key, required this.title, this.actBtn})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 75,
      backgroundColor: darkgreenv2,
      elevation: 0.3,
      title: Text(title, style: Styles.titleBarStyle),
      centerTitle: true,
      actions: actBtn,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(75);
}


// by rafiknurf