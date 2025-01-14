import 'package:flutter/material.dart';
import 'package:pembersih_kulkas/view/login_view.dart';
import 'package:pembersih_kulkas/view/signup_view.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: const Color(0xFF9FC5B2),
          ),

          SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.account_circle,
                    size: 80,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 20),

                  Text(
                    "Pembersih Kulkas",
                    style: TextStyle(
                      fontFamily: 'BalooChettan2',
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),

                  Text(
                    "Keep your fridge clean!",
                    style: TextStyle(
                      fontFamily: 'BalooChettan2',
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                  const SizedBox(height: 40),

                  SizedBox(
                    width: 180,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                      child: Text(
                        "Log In",
                        style: TextStyle(
                          fontFamily: 'BalooChettan2',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF9FC5B2),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  SizedBox(
                    width: 180,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignupPage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                          side: BorderSide(color: Colors.white, width: 2),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                      ),
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                          fontFamily: 'BalooChettan2',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}