import 'package:flutter/material.dart';
import '../../core/ui_helper.dart';

class DefAppBar extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget>? actBtn;
  final double? leadingWidth;
  final Widget? leading;
  final Widget? title;
  final bool? centered;
  const DefAppBar(
      {Key? key,
      required this.title,
      this.leadingWidth,
      this.leading,
      this.actBtn,
      this.centered})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 65,
      backgroundColor: darkgreenv2,
      elevation: 0.3,
      title: title,
      centerTitle: centered,
      leadingWidth: leadingWidth,
      leading: leading,
      actions: actBtn,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(65);
}


// by rafiknurf