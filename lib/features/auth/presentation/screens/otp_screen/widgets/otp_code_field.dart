import 'package:flutter/material.dart';

import 'package:fap/core/utils/size_config.dart';

class OtpCodeField extends StatelessWidget {
  final bool isLandscape;
  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<String> onChanged;

  const OtpCodeField({
    super.key,
    required this.isLandscape,
    required this.controller,
    required this.focusNode,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isLandscape ? SizeConfig.w(10) : SizeConfig.w(12),
      constraints: const BoxConstraints(
        maxWidth: 65,
        minWidth: 45,
      ),
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        keyboardType: TextInputType.number,
        maxLength: 1,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: SizeConfig.sp(10),
          fontWeight: FontWeight.bold,
          fontFamily: 'Tajawal',
        ),
        decoration: InputDecoration(
          counterText: '',
          contentPadding: EdgeInsets.symmetric(
            vertical: SizeConfig.h(1.3),
          ),
        ),
        onChanged: onChanged,
      ),
    );
  }
}
