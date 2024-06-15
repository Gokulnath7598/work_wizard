import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';
import 'package:my_macos_app/constants/app_assets.dart';
import 'package:my_macos_app/views/home/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return MacosWindow(
      child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppAssets.bgImage),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            const Spacer(),
            const Text(
              'Work Wizard',
              style: TextStyle(
                  fontSize: 55,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 25,
                  color: Colors.black),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset(
                  AppAssets.arrowLeft,
                  width: size.width * 0.15,
                ),
                const Text(
                  'user friendly ET Sheet reminder and tracker',
                  style: TextStyle(
                      fontSize: 24,
                      fontStyle: FontStyle.italic,
                      // fontWeight: FontWeig,
                      color: Colors.black),
                ),
                Image.asset(
                  AppAssets.arrowRight,
                  width: size.width * 0.15,
                ),
              ],
            ),
            const Spacer(),
            Container(
                width: 280,
                height: 56,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.white),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage()));
                  },
                  child: const Text(
                    'Sign in with Microsoft',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                  ),
                )),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
