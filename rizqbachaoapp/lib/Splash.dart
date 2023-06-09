import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rizqbachaoapp/login_option_screen.dart';
import 'main_screen.dart';
import 'main.dart';

class AnimatedLogo extends AnimatedWidget {
  const AnimatedLogo({Key? key, required Animation<double> animation})
      : super(listenable: animation);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      height: animation.value,
      width: animation.value,
      child: Image.asset(
        'assets/images/logo1.png',
        scale: 0.7,
      ),
    );
  }
}

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;
  late Tween<double> turnsTween;
  late Animation<double> anim;
  late AnimationController controller1;

  @override
  dispose() {
    controller.dispose();
    controller1.dispose(); // you need this
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);
    controller1 = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    // animation = Tween<double>(begin: 0, end: 200).animate(controller);
    final alpha = CurvedAnimation(parent: controller, curve: Curves.linear);
    //animation = CurvedAnimation(parent: controller, curve: Curves.linear);
    animation = Tween<double>(begin: 0, end: 200).animate(alpha);
    turnsTween = Tween<double>(
      begin: 2,
      end: 0,
    );
    anim = turnsTween.animate(controller1);
    anim.addStatusListener((status) {
      print(status);
      if (status == AnimationStatus.completed) {
        turnsTween = Tween<double>(
          begin: 0,
          end: 2,
        );
        controller1.reverse();
      }
    });
    animation.addStatusListener((status) {
      print(status);
      // if (status == AnimationStatus.completed) {
      //   controller.reverse();//add a bool variable
      // }
      if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });
    controller.forward();
    Future.delayed(Duration(seconds: 4), _toNextScreen);
  }

  _toNextScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return MainScreen(); //MapLoader(); //if the user is logged in show home page
              } else {
                return LoginOptionScreen(); // else show login page
              }
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                RotationTransition(
                    turns: anim, child: AnimatedLogo(animation: animation)),
                Image.asset('assets/images/RBtext.png'),
              ],
            ),
            Image.asset('assets/images/RizqBachaotitle.png'),
          ],
        ),
      ),
    );
  }
}
