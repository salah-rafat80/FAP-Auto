import 'package:flutter/material.dart';
import 'package:fap/core/utils/size_config.dart';

class PriceListBottomNotice extends StatelessWidget {
  const PriceListBottomNotice({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(SizeConfig.w(2)),
      padding: EdgeInsets.all(SizeConfig.w(2)),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.info_outline,
            color: Colors.blue[700],
            size: SizeConfig.w(5),
          ),
          SizedBox(width: SizeConfig.w(2)),
          Text(
            'يتم تحديث قوائم الأسعار شهرياً',
            style: TextStyle(
              fontSize: SizeConfig.sp(8),
              color: Colors.blue[700],
              fontWeight: FontWeight.w500,
              fontFamily: 'Tajawal',
            ),
          ),
        ],
      ),
    );
  }
}
