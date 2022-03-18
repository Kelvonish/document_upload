import 'package:flutter/material.dart';
import 'package:upload/utils/text_styles.dart';

class RequiredText extends StatelessWidget {
  final String name;
  const RequiredText({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          name,
          style: bodyStyleNormal,
        ),
        Text(
          "*",
          style: bodyStyleRed,
        ),
      ],
    );
  }
}
