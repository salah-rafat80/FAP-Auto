import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fap/core/utils/size_config.dart';
import 'package:fap/core/utils/auth_session.dart';
import 'package:fap/injection_container.dart';
import 'package:fap/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:fap/features/auth/presentation/cubit/auth_state.dart';
import 'package:fap/features/auth/presentation/screens/login_screen/login_screen.dart';
import 'package:fap/features/price_list/presentation/screens/price_list_screen.dart';

/// Home screen - main dashboard
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _userName;

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  void _loadUserName() {
    final authSession = sl<AuthSession>();
    setState(() {
      _userName = authSession.userName;
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);

    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthLoggedOut) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const LoginScreen()),
            (route) => false,
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.logout, color: Colors.red),
            onPressed: () => _showLogoutDialog(context),
          ),

          // centerTitle: true,
          title: Image.asset(
            'assets/Image (FAP Logo).png',
            height: 40,
            fit: BoxFit.contain,
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Welcome message with user name
              if (_userName != null && _userName!.isNotEmpty)
                Padding(
                  padding: EdgeInsets.all(SizeConfig.w(5)),
                  child: Row(
                    children: [
                      Text(
                        'مرحباً،  ',
                        style: TextStyle(
                          fontSize: SizeConfig.sp(7),
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          fontFamily: 'Tajawal',
                        ),
                      ),
                      Text(
                        '$_userName 👋',
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: SizeConfig.sp(7),
                          fontWeight: FontWeight.w600,
                          color: Colors.red,
                          fontFamily: 'Tajawal',
                        ),
                      ),
                    ],
                  ),
                ),
              SizedBox(height: SizeConfig.h(2)),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: SizeConfig.w(4)),
                child: Column(
                  children: [
                    _buildMenuItem(
                      context: context,
                      title: 'عروض الاسعار',
                      icon: Icons.description_outlined,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const PriceListScreen(),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: SizeConfig.h(2)),
                    // _buildMenuItem(
                    //   context: context,
                    //   title: 'طلباتي ومواقيتي',
                    //   icon: Icons.description_outlined,
                    //   onTap: () {},
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text(
          'تسجيل الخروج',
          textAlign: TextAlign.right,
          style: TextStyle(fontFamily: 'Tajawal'),
        ),
        content: const Text(
          'هل أنت متأكد من تسجيل الخروج؟',
          textAlign: TextAlign.right,
          style: TextStyle(fontFamily: 'Tajawal'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              context.read<AuthCubit>().logout();
            },
            child: const Text(
              'تسجيل الخروج',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required BuildContext context,
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: EdgeInsets.all(SizeConfig.w(4)),
        decoration: BoxDecoration(
          // color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.red[300]!),
        ),
        child: Row(
          children: [
            Icon(icon, size: SizeConfig.w(10), color: Colors.red),
            Expanded(
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: SizeConfig.sp(9),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(width: SizeConfig.w(8)),
          ],
        ),
      ),
    );
  }
}
