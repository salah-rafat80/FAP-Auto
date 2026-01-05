import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fap/core/utils/size_config.dart';
import 'package:fap/features/price_list/domain/entities/category.dart';
import 'package:fap/features/price_list/presentation/screens/pdf_viewer_screen.dart';
// import 'package:fap/features/price_list/presentation/screens/price_list_details_screen.dart';

class MonthlyReportCard extends StatelessWidget {
  final Category category;

  const MonthlyReportCard({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) =>

                PdfViewerScreen(
                  title: category.name,
                  pdfAssetPath: category.pdfAssetPath,
                ),
          ),
        );
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: EdgeInsets.all(SizeConfig.w(3)),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // PDF Icon with red background
            Container(
              padding: EdgeInsets.all(SizeConfig.w(3)),
              decoration: BoxDecoration(
                color: Colors.red[50],
                borderRadius: BorderRadius.circular(12),
              ),
              child: SvgPicture.asset(
                "assets/icons/prices.svg",
                width: SizeConfig.w(5),
                height: SizeConfig.h(5),
                // إذا كان العنصر نشطاً، اللون أبيض، وإلا رمادي غامق
                colorFilter: const ColorFilter.mode(
                  Colors.red,
                  BlendMode.srcIn,
                ),
              ),
            ),
            SizedBox(width: SizeConfig.w(2)),

            // Title and subtitle
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    category.name,
                    style: TextStyle(
                      fontSize: SizeConfig.sp(6.5),
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Tajawal',
                    ),
                    textAlign: TextAlign.right,
                  ),
                  SizedBox(height: SizeConfig.h(0.5)),
                  Text(
                    category.message,
                    style: TextStyle(
                      fontSize: SizeConfig.sp(5.5),
                      color: Colors.grey[600],
                      fontFamily: 'Tajawal',
                    ),
                    textAlign: TextAlign.right,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            // Arrow icon
            Icon(
              Icons.arrow_forward_ios,
              size: SizeConfig.w(4),
              color: Colors.grey[400],
            ),
          ],
        ),
      ),
    );
  }
}
