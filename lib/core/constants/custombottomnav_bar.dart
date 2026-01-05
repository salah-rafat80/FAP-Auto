import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomBottomNavBar extends StatefulWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  State<CustomBottomNavBar> createState() => _CustomBottomNavBarState();
}

class _CustomBottomNavBarState extends State<CustomBottomNavBar> {
  // تعريف البيانات الخاصة بكل عنصر
  final List<Map<String, dynamic>> _navItems = [
    {'label': 'الرئيسية', 'icon': 'assets/icons/home.svg'}, // index 0
    {'label': 'الأسعار', 'icon': 'assets/icons/prices.svg'}, // index 1
    {'label': 'طلباتي', 'icon': 'assets/icons/orders.svg'}, // index 2
    {'label': 'الإشعارات', 'icon': 'assets/icons/notifications.svg'}, // index 3
    {'label': 'الملف', 'icon': 'assets/icons/profile.svg'}, // index 4
  ];

  @override
  Widget build(BuildContext context) {
    // التأكد من اتجاه النص للعربية لترتيب العناصر من اليمين لليسار
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(_navItems.length, (index) {
              final bool isSelected = widget.currentIndex == index;
              return _buildNavItem(
                index: index,
                isSelected: isSelected,
                item: _navItems[index],
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required bool isSelected,
    required Map<String, dynamic> item,
  }) {
    return GestureDetector(
      onTap: () => widget.onTap(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        padding: isSelected
            ? const EdgeInsets.symmetric(horizontal: 16, vertical: 8)
            : const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: isSelected
            ? BoxDecoration(
                color: const Color(0xFFE61E25), // اللون الأحمر حسب الصورة
                borderRadius: BorderRadius.circular(16),
              )
            : null,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // الأيقونة
            SvgPicture.asset(
              item['icon'],
              width: 24,
              height: 24,
              // إذا كان العنصر نشطاً، اللون أبيض، وإلا رمادي غامق
              colorFilter: ColorFilter.mode(
                isSelected ? Colors.white : const Color(0xFF4A4A4A),
                BlendMode.srcIn,
              ),
            ),
            // Icon(
            //   Icons.home,
            //   color: isSelected ? Colors.white : const Color(0xFF4A4A4A),
            // ),
            const SizedBox(height: 6),
            // النص
            Text(
              item['label'],
              style: TextStyle(
                color: isSelected ? Colors.white : const Color(0xFF4A4A4A),
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                fontFamily: 'Tajawal', // أو الخط المستخدم في تطبيقك
              ),
            ),
          ],
        ),
      ),
    );
  }
}
