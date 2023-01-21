import 'package:flutter/material.dart';
import 'package:news_app/animations/entrance_fader.dart';
import 'package:news_app/configs/app.dart';
import 'package:news_app/configs/configs.dart';
import 'package:news_app/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void _nextScreen() {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushNamed(context, '/dashboard');
    });
  }

  void initTheme() {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    themeProvider.init();
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      initTheme();
      _nextScreen();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    App.init(context);

    return Scaffold(
      body: Center(
        child: EntranceFader(
          duration: const Duration(milliseconds: 300),
          offset: const Offset(0, 20),
          child: Text(
            'News App',
            style: AppText.h1b!.copyWith(
              fontSize: AppDimensions.normalize(20),
            ),
          ),
        ),
      ),
    );
  }
}
