import 'package:flutter/material.dart';
import 'package:study_app_project/configs/themes/app_icon.dart';
import 'package:study_app_project/configs/themes/custom_text_styles.dart';
import 'package:study_app_project/configs/themes/ui_parameters.dart';
import 'package:study_app_project/widgets/app_circle_button.dart';

class CustomAppBar extends StatelessWidget implements PreferredSize {
  const CustomAppBar(
      {super.key,
      this.title = '',
      this.titleWidget,
      this.showActionIcon = false,
      this.onMenuActionTap,
      this.leading});

  final String title;
  final Widget? titleWidget;
  final Widget? leading;
  final bool showActionIcon;
  final VoidCallback? onMenuActionTap;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: EdgeInsets.symmetric(
          horizontal: mobileScreenPadding, vertical: mobileScreenPadding),
      child: Stack(
        children: [
          Positioned.fill(
              child: titleWidget == null
                  ? Center(
                      child: Text(
                        title,
                        style: appBarTs,
                      ),
                    )
                  : Center(
                      child: titleWidget,
                    )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              leading ??
                  Transform.translate(
                      offset: const Offset(-14, 0), child: const BackButton()),
              if (showActionIcon)
                Transform.translate(
                    offset: const Offset(10, 0),
                    child: AppCircleButton(
                      onTap: onMenuActionTap ?? null,
                      child: const Icon(AppIcons.menu),
                    )),
            ],
          )
        ],
      ),
    ));
  }

  @override
  // TODO: implement child
  Widget get child => throw UnimplementedError();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size(double.maxFinite, 80);
}
