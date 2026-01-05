import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fap/features/home/presentation/screens/home_screen.dart';
// import 'package:fap/features/main/presentation/main_screen.dart';

import 'package:fap/core/utils/size_config.dart';
import 'package:fap/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:fap/features/auth/presentation/cubit/auth_state.dart';
import 'package:fap/features/auth/presentation/screens/otp_screen/widgets/otp_action_button.dart';
import 'package:fap/features/auth/presentation/screens/otp_screen/widgets/otp_app_bar.dart';
import 'package:fap/features/auth/presentation/screens/otp_screen/widgets/otp_code_inputs.dart';
import 'package:fap/features/auth/presentation/screens/otp_screen/widgets/otp_header.dart';

/// OTP verification screen
class OtpScreen extends StatefulWidget {
  final String? otp;
  const OtpScreen({super.key, this.otp});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final List<TextEditingController> _controllers = List.generate(
    6,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  String get _otp => _controllers.map((c) => c.text).join();

  Future<void> _verifyOtp() async {
    context.read<AuthCubit>().verifyOtp(_otp);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: const OtpAppBar(),
        body: SafeArea(
          child: BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is AuthError) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Text(state.message),
                      backgroundColor: Colors.red,
                    ),
                  );
              } else if (state is AuthVerified) {
                if (state.response.messageAr != null) {
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      SnackBar(
                        content: Text(state.response.messageAr!),
                        backgroundColor: Colors.green,
                      ),
                    );
                }
                //////////////////////////////////////////////////////////////////////////////////////
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (_) =>
                        // MainScreen()
                        HomeScreen(),
                  ),
                  (route) => false,
                );
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
                              OtpHeader(otp: widget.otp),
                              SizedBox(height: SizeConfig.h(1)),
                              OtpCodeInputs(
                                controllers: _controllers,
                                focusNodes: _focusNodes,
                                isLandscape: isLandscape,
                                state: state,
                                onResetError: () {
                                  context.read<AuthCubit>().reset();
                                },
                                onCompleted: _verifyOtp,
                              ),
                              SizedBox(
                                height: isLandscape
                                    ? SizeConfig.h(2)
                                    : SizeConfig.h(4),
                              ),
                              OtpActionButton(
                                state: state,
                                onPressed: state is AuthLoading
                                    ? null
                                    : _verifyOtp,
                              ),
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
