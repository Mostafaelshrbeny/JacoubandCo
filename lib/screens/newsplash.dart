import 'package:chatjob/main.dart';
import 'package:chatjob/screens/loginscreens/into.dart';
import 'package:chatjob/screens/mainscreen.dart';
import 'package:flutter/material.dart';

class NewSplashScreen extends StatefulWidget {
  const NewSplashScreen({super.key});

  @override
  State<NewSplashScreen> createState() => _NewSplashScreenState();
}

class _NewSplashScreenState extends State<NewSplashScreen> {
  @override
  void initState() {
    remove();
    super.initState();
  }

  remove() async {
    Future.delayed(const Duration(milliseconds: 3000))
        .then((value) => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => pref.getString('UserName') == null
                  ? const Introscreen()
                  : const Mainscreen(),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/LOGO_STORY.01 (1).gif'),
                fit: BoxFit.cover)),
      ),
    );
  }
}
