import 'package:flutter/material.dart';

void main() {
  runApp(const MandarinApp());
}

class MandarinApp extends StatelessWidget {
  const MandarinApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mandarin',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFAD185F),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFAD7E7),
              Color(0xFFF0DCD7),
              Color(0xFFDDE3BF),
            ],
          ),
        ),
        child: SizedBox.expand(
          child: SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'MANDARIN',
                      style: theme.textTheme.headlineLarge?.copyWith(
                        color: const Color(0xFFAD185F),
                        fontWeight: FontWeight.w800,
                        letterSpacing: 3,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Enjoy the Taste of Mandarin at Home',
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: const Color(0xFF2E6935),
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}