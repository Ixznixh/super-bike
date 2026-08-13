import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ApexSuperbikeApp());
}

class ApexSuperbikeApp extends StatelessWidget {
  const ApexSuperbikeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'APEX VELOCITY | Superbike Telemetry & Heritage',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const HomeScreen(),
    );
  }
}
