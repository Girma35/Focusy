import 'package:flutter/material.dart';
import 'app/workflow/presentation/screens/simple_focus_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const FocusyApp());
}

class FocusyApp extends StatelessWidget {
  const FocusyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Focusy',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0A0E1A),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF8B5CF6),
          surface: Color(0xFF131929),
        ),
        useMaterial3: true,
      ),
      home: const SimpleFocusScreen(),
    );
  }
}
