import 'package:flutter/material.dart';
import 'package:fap/core/utils/size_config.dart';

class PdfLoadingView extends StatelessWidget {
  const PdfLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              SizedBox(height: SizeConfig.h(2)),
              Text(
                'جاري تحميل الملف...',
                style: TextStyle(
                  fontSize: SizeConfig.sp(8),
                  fontFamily: 'Tajawal',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
