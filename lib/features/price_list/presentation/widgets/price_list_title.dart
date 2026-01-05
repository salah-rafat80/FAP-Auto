import 'package:flutter/material.dart';
import 'package:fap/core/utils/size_config.dart';

class PriceListTitle extends StatelessWidget {
  const PriceListTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [

          SizedBox(width: SizeConfig.w(2)),
          Text(
            'اختر الكشف الشهري المطلوب',
            style: TextStyle(
              fontSize: SizeConfig.sp(9),
              fontWeight: FontWeight.w500,
              color: Colors.grey[600],
              fontFamily: 'Tajawal',
            ),
          ),
          Spacer(),
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_forward_ios,
              size: SizeConfig.w(7),
              color: Colors.grey[800],
            ),
          ),
        ],
      ),
    );
  }
}
