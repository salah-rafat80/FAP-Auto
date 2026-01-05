import 'package:flutter/material.dart';

import 'package:fap/core/utils/size_config.dart';
import 'package:fap/features/auth/presentation/cubit/auth_state.dart';

class OtpActionButton extends StatelessWidget {
  final AuthState state;
  final VoidCallback? onPressed;

  const OtpActionButton({
    super.key,
    required this.state,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(
          vertical: SizeConfig.h(0.5),
        ),
      ),
      onPressed: onPressed,
      child: state is AuthLoading
          ? SizedBox(
              height: SizeConfig.h(3),
              width: SizeConfig.h(3),
              child: const CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.white,
              ),
            )
          : Text(
              'تأكيد',
              style: TextStyle(
                fontSize: SizeConfig.sp(10),
                fontFamily: 'Tajawal',
              ),
            ),
    );
  }
}
