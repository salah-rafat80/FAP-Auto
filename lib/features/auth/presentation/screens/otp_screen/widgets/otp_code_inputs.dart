import 'package:flutter/material.dart';

import 'package:fap/core/utils/size_config.dart';
import 'package:fap/features/auth/presentation/cubit/auth_state.dart';
import 'package:fap/features/auth/presentation/screens/otp_screen/widgets/otp_code_field.dart';

class OtpCodeInputs extends StatelessWidget {
  final List<TextEditingController> controllers;
  final List<FocusNode> focusNodes;
  final bool isLandscape;
  final AuthState state;
  final VoidCallback onResetError;
  final VoidCallback onCompleted;

  const OtpCodeInputs({
    super.key,
    required this.controllers,
    required this.focusNodes,
    required this.isLandscape,
    required this.state,
    required this.onResetError,
    required this.onCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Wrap(
        alignment: WrapAlignment.center,
        spacing: SizeConfig.w(2),
        runSpacing: SizeConfig.h(1.5),
        children: List.generate(6, (index) {
          return OtpCodeField(
            isLandscape: isLandscape,
            controller: controllers[index],
            focusNode: focusNodes[index],
            onChanged: (value) {
              if (state is AuthError) {
                onResetError();
              }
              if (value.isNotEmpty && index < 5) {
                focusNodes[index + 1].requestFocus();
              } else if (value.isEmpty && index > 0) {
                focusNodes[index - 1].requestFocus();
              }
            },
          );
        }),
      ),
    );
  }
}
