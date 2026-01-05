import 'package:flutter/material.dart';
import 'package:fap/core/utils/size_config.dart';

class PriceListErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const PriceListErrorView({
    super.key,
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(SizeConfig.w(6)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: SizeConfig.w(14),
              color: Colors.red,
            ),
            SizedBox(height: SizeConfig.h(2)),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: SizeConfig.sp(8),
                fontFamily: 'Tajawal',
              ),
            ),
            SizedBox(height: SizeConfig.h(2)),
            ElevatedButton(
              onPressed: onRetry,
              child: const Text('إعادة المحاولة'),
            ),
          ],
        ),
      ),
    );
  }
}
