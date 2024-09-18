import 'package:chatjob/screens/loginscreens/login.dart';
import 'package:chatjob/widget/buttonwid.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Introscreen extends StatelessWidget {
  const Introscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/introimage.png'),
                    fit: BoxFit.cover)),
          ),
          Container(
            color: Colors.black.withOpacity(0.7),
            child: const Center(
              child: SizedBox(
                width: 250,
                height: 200,
                child: Stack(
                  children: [
                    Align(
                        alignment: Alignment(-0.8, -0.95),
                        child: /*Text(
                        '❛',
                        style: TextStyle(
                            color: Color.fromRGBO(142, 112, 79, 1),
                            fontSize: 50),
                      ),*/
                            Image(
                                image: AssetImage(
                                    'assets/images/Text Element.png'))),
                    Text(
                      'Private\n Investment\nFund',
                      softWrap: true,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontFamily: 'spinwerad',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Custombuttom(
            onpress: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (_) {
                return const Loginscreen();
              }));
            },
            label: 'Login',
          )
        ],
      ),
    );
  }
}


 /* Text(
                        '❛',
                        style:
                            TextStyle(color: Color.fromRGBO(142, 112, 79, 1)),
                      ),*/