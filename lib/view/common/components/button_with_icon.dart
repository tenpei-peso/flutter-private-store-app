import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../style.dart';

class ButtonWithIcon extends StatelessWidget {
  final VoidCallback? onPressed;
  final IconData iconData;
  final String label;

  ButtonWithIcon({
    required this.iconData,
    this.onPressed,
    required this.label
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        onPressed: onPressed,
        icon: FaIcon(iconData, color: Colors.red,),
        label: Text(label, style: buttonTextColor),
        style: ElevatedButton.styleFrom(
          side: BorderSide(
            color: Colors.green,
          )
          ),
        );
  }
}
