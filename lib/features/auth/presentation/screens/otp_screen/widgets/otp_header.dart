import 'package:flutter/material.dart';

import 'package:fap/core/utils/size_config.dart';

class OtpHeader extends StatelessWidget {
  final String? otp;

  const OtpHeader({super.key, required this.otp});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Image(image: AssetImage('assets/Image (FAP Logo).png')),
        Text(
          'رمز التحقق',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: SizeConfig.sp(12),
            color: const Color(0xFFE81923),
            fontFamily: 'Tajawal',
          ),
        ),
        SizedBox(height: SizeConfig.h(1)),
        Text(
          'تم إرسال الكود إلى رقمك على واتساب',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: SizeConfig.sp(8),
            fontWeight: FontWeight.w500,
            fontFamily: 'Tajawal',
          ),
        ),
        // if (otp != null) ...[
        //   SizedBox(height: SizeConfig.h(1)),
        //   Text(
        //     'OTP: $otp',
        //     textAlign: TextAlign.center,
        //     style: TextStyle(
        //       fontSize: SizeConfig.sp(8),
        //       fontWeight: FontWeight.bold,
        //       color: Colors.green,
        //       fontFamily: 'Tajawal',
        //     ),
        //   ),
        // ],
      ],
    );
  }
}
