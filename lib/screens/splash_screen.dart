import 'package:flutter/material.dart';
import 'package:xpresslite/screens/auth/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  final DecorationTween decorationTween = DecorationTween(
    begin: BoxDecoration(
      color: const Color(0xFFFFFFFF),
      border: Border.all(style: BorderStyle.none),
      borderRadius: BorderRadius.circular(60.0),
      boxShadow: const <BoxShadow>[
        BoxShadow(
          color: Color(0x66666666),
          blurRadius: 10.0,
          spreadRadius: 3.0,
          offset: Offset(0, 6.0),
        ),
      ],
    ),
    end: BoxDecoration(
      color: const Color(0xFFFFFFFF),
      border: Border.all(
        style: BorderStyle.none,
      ),
      borderRadius: BorderRadius.zero,
      // No shadow.
    ),
  );
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 3),
  )..repeat(reverse: true);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(
        const Duration(seconds: 3),
        () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child:
                // CircleAvatar(
                //   radius: 130,
                //   backgroundColor: Colors.grey.shade300,
                //   child: CircleAvatar(
                //     radius: 110,
                //     backgroundColor: Colors.white54,
                //     child: CircleAvatar(
                //       radius: 90,
                //       backgroundColor: Colors.white70,
                //       child: CircleAvatar(
                //         radius: 70,
                //         backgroundColor: Colors.white,
                //         child: CircleAvatar(
                //           radius: 50,
                //           backgroundImage: AssetImage('assets/app_logo.png'),
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                DecoratedBoxTransition(
              decoration: decorationTween.animate(_controller),
              child: Container(
                child:
                CircleAvatar(
                  radius: 130,
                  backgroundColor: Colors.grey.shade300,
                  child: CircleAvatar(
                    radius: 110,
                    backgroundColor: Colors.white54,
                    child: CircleAvatar(
                      radius: 90,
                      backgroundColor: Colors.white70,
                      child: CircleAvatar(
                        radius: 70,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage('assets/app_logo.png'),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            'Xpress Lite',
            style: TextStyle(
                fontSize: 40,
                fontStyle: FontStyle.italic,
                color: Colors.grey.shade800),
          ),
          Text(
            'For IndianOil People',
            style: TextStyle(fontSize: 15, color: Colors.grey.shade500),
          ),
        ],
      ),
    ));
  }
}
