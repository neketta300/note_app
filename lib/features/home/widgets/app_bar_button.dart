import 'package:flutter/material.dart';
import 'package:notes_app/helpers/responsive_size.dart';

class AppBarButton extends StatelessWidget {
  const AppBarButton({
    super.key,
    required this.icon,
    required this.onTap,
  });

  final IconData icon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: ResponsiveSize.fromFigmaWidth(context, 50),
        height: ResponsiveSize.fromFigmaWidth(context, 50),
        decoration: BoxDecoration(
          color: const Color(0xff3B3B3B),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Icon(icon, color: Colors.white),
      ),
    );
  }
}
