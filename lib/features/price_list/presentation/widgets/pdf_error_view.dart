import 'package:flutter/material.dart';
import 'package:fap/core/utils/size_config.dart';

class PdfErrorView extends StatelessWidget {
  final String? errorMessage;
  final String pdfPath;
  final VoidCallback onRetry;
  final VoidCallback onBack;

  const PdfErrorView({
    super.key,
    required this.errorMessage,
    required this.pdfPath,
    required this.onRetry,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: IntrinsicHeight(
              child: Padding(
                padding: EdgeInsets.all(SizeConfig.w(6)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: isLandscape ? SizeConfig.w(12) : SizeConfig.w(18),
                      color: Colors.red,
                    ),
                    SizedBox(height: SizeConfig.h(2)),
                    Text(
                      'فشل تحميل الملف',
                      style: TextStyle(
                        fontSize: SizeConfig.sp(6),
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Tajawal',
                      ),
                    ),
                    SizedBox(height: SizeConfig.h(1)),
                    Text(
                      errorMessage ?? 'تأكد من اتصالك بالإنترنت',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: SizeConfig.sp(4.5),
                        color: Colors.grey,
                        fontFamily: 'Tajawal',
                      ),
                    ),
                    SizedBox(height: SizeConfig.h(1)),
                    Text(
                      'الرابط: $pdfPath',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: SizeConfig.sp(3.5),
                        color: Colors.grey,
                        fontFamily: 'Tajawal',
                      ),
                    ),
                    SizedBox(height: SizeConfig.h(3)),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          vertical: SizeConfig.h(2),
                          horizontal: SizeConfig.w(6),
                        ),
                      ),
                      onPressed: onRetry,
                      icon: Icon(Icons.refresh, size: SizeConfig.w(6)),
                      label: Text(
                        'إعادة المحاولة',
                        style: TextStyle(
                          fontSize: SizeConfig.sp(4.5),
                          fontFamily: 'Tajawal',
                        ),
                      ),
                    ),
                    SizedBox(height: SizeConfig.h(1.5)),
                    TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          vertical: SizeConfig.h(1.5),
                          horizontal: SizeConfig.w(6),
                        ),
                      ),
                      onPressed: onBack,
                      child: Text(
                        'العودة للقائمة',
                        style: TextStyle(
                          fontSize: SizeConfig.sp(6),
                          fontFamily: 'Tajawal',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
