import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fap/core/constants/app_theme.dart';
import 'package:fap/core/utils/auth_session.dart';
import 'package:fap/core/utils/security_service.dart';
import 'package:fap/core/widgets/app_error_screen.dart';
import 'package:fap/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:fap/features/auth/presentation/screens/login_screen/login_screen.dart';
import 'package:fap/features/home/presentation/screens/home_screen.dart';
import 'package:fap/injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set custom error widget to replace red screen of death
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return customErrorWidget(details);
  };

  // Enable screen security to prevent screenshots and screen recording - MANDATORY
  if (Platform.isAndroid) {
    await SecurityService.enableScreenSecurity();
  }

  await di.init();
  runApp(const FapApp());
}

class FapApp extends StatelessWidget {
  const FapApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SecureWrapper(
      child: MaterialApp(
        title: 'FAP',
        theme: appTheme,
        debugShowCheckedModeBanner: false,
        locale: const Locale('ar'),
        supportedLocales: const [Locale('ar')],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        home: di.sl<AuthSession>().isLoggedIn
            ? const HomeScreen()
            : const LoginScreen(),
        builder: (context, child) {
          final mq = MediaQuery.of(context);
          final current = mq.textScaler.scale(1.0);
          final clamped = current.clamp(0.9, 1.3);
          return MultiBlocProvider(
            providers: [BlocProvider(create: (_) => di.sl<AuthCubit>())],
            child: MediaQuery(
              data: mq.copyWith(
                textScaler: TextScaler.linear(clamped.toDouble()),
              ),
              child: child ?? const SizedBox.shrink(),
            ),
          );
        },
      ),
    );
  }
}

/// Wrapper widget to ensure screen security on every screen
class SecureWrapper extends StatefulWidget {
  final Widget child;
  const SecureWrapper({super.key, required this.child});

  @override
  State<SecureWrapper> createState() => _SecureWrapperState();
}

class _SecureWrapperState extends State<SecureWrapper>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // Re-enable security when app comes to foreground
    _ensureSecurity();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // Re-enable security when app comes back to foreground
      _ensureSecurity();
    }
  }

  Future<void> _ensureSecurity() async {
    if (Platform.isAndroid || Platform.isIOS) {
      await SecurityService.enableScreenSecurity();
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
