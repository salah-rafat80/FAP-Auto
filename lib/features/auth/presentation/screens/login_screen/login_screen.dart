import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fap/core/utils/size_config.dart';
import 'package:fap/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:fap/features/auth/presentation/cubit/auth_state.dart';
import 'package:fap/features/auth/presentation/screens/otp_screen/otp_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _mobileController = TextEditingController();

  @override
  void dispose() {
    _mobileController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: SafeArea(
          child: BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is AuthOtpSent) {
                // if (state.response.otp != null) {
                //   ScaffoldMessenger.of(context).showSnackBar(
                //     SnackBar(
                //       content: Text('OTP: ${state.response.otp}'),
                //       duration: const Duration(seconds: 10),
                //       backgroundColor: Colors.green,
                //     ),
                //   );
                // }
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => OtpScreen(otp: state.response.otp),
                  ),
                );
              } else if (state is AuthError) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
            builder: (context, state) {
              return LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: IntrinsicHeight(
                        child: Padding(
                          padding: EdgeInsets.all(SizeConfig.w(6)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Spacer(),
                              Image(
                                image: const AssetImage(
                                  'assets/Image (FAP Logo).png',
                                ),
                              ),

                              SizedBox(
                                height: isLandscape
                                    ? SizeConfig.h(2)
                                    : SizeConfig.h(5),
                              ),
                              Text(
                                'مرحباً بك',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: SizeConfig.sp(12),
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFFE81923),
                                  fontFamily: 'Tajawal',
                                ),
                              ),
                              SizedBox(height: SizeConfig.h(1)),
                              Text(
                                'الرجاء إدخال رقم جوالك للمتابعة',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: SizeConfig.sp(8),
                                  color: Color(0xff4A5565),
                                  fontFamily: 'Tajawal',
                                ),
                              ),
                              SizedBox(
                                height: isLandscape
                                    ? SizeConfig.h(3)
                                    : SizeConfig.h(5),
                              ),
                              TextField(
                                controller: _mobileController,
                                keyboardType: TextInputType.phone,
                                textDirection: TextDirection.ltr,
                                style: TextStyle(
                                  fontSize: SizeConfig.sp(8),
                                  fontFamily: 'Tajawal',
                                ),
                                decoration: InputDecoration(
                                  labelText: 'رقم الجوال',
                                  labelStyle: TextStyle(
                                    fontSize: SizeConfig.sp(8),
                                    fontFamily: 'Tajawal',
                                  ),
                                  hint: Directionality(
                                    textDirection: TextDirection.ltr,
                                    child: Text(
                                      '012xxxxxxxx',
                                      style: TextStyle(
                                        fontSize: SizeConfig.sp(8),
                                        color: Colors.grey,
                                        fontFamily: 'Tajawal',
                                      ),
                                    ),
                                  ),
                                  suffixIcon: Icon(
                                    Icons.phone,
                                    size: SizeConfig.w(6),
                                  ),
                                ),
                              ),
                              SizedBox(height: SizeConfig.h(3)),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                    vertical: SizeConfig.h(0.5),
                                  ),
                                ),
                                onPressed: state is AuthLoading
                                    ? null
                                    : () {
                                        context.read<AuthCubit>().login(
                                          _mobileController.text,
                                        );
                                      },
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
                                        'متابعة',
                                        style: TextStyle(
                                          fontSize: SizeConfig.sp(10),
                                          fontFamily: 'Tajawal',
                                        ),
                                      ),
                              ),
                              SizedBox(height: SizeConfig.h(2)),
                              Text(
                                "سيتم إرسال رمز التحقق عبر الواتساب",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: SizeConfig.sp(6),
                                  color: Colors.grey,
                                  fontFamily: 'Tajawal',
                                ),
                              ),
                              Spacer(),
                              Spacer(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
