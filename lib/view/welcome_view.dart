// import 'package:flutter/material.dart';
// import 'package:pembersih_kulkas/view/login_view.dart';
// import 'package:pembersih_kulkas/view/signup_view.dart';

// class WelcomeView extends StatelessWidget {
//   const WelcomeView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           // Background Image or Gradient
//           Positioned.fill(
//             child: Container(
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                   colors: [Colors.blue.shade300, Colors.blue.shade900],
//                 ),
//               ),
//             ),
//           ),

//           // Content
//           SafeArea(
//             child: Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   // App Logo or Icon
//                   Icon(
//                     Icons.account_circle,
//                     size: 100,
//                     color: Colors.white,
//                   ),
//                   const SizedBox(height: 20),

//                   // App Name
//                   Text(
//                     "Pembersih Kulkas",
//                     style: TextStyle(
//                       fontFamily: 'BalooChettan2',
//                       fontSize: 32,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white,
//                       shadows: [
//                         Shadow(
//                           offset: const Offset(2.0, 2.0),
//                           blurRadius: 4.0,
//                           color: Colors.black54,
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(height: 10),

//                   // App Tagline
//                   Text(
//                     "Keep your fridge clean and organized!",
//                     style: TextStyle(
//                       fontFamily: 'BalooChettan2',
//                       fontSize: 16,
//                       color: Colors.white.withOpacity(0.8),
//                     ),
//                   ),
//                   const SizedBox(height: 40),

//                   // Login Button
//                   SizedBox(
//                     width: 200,
//                     child: ElevatedButton(
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) =>
//                                 const LoginPage(), // Navigate to LoginPage
//                           ),
//                         );
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.white,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(25),
//                         ),
//                         padding: const EdgeInsets.symmetric(vertical: 15),
//                       ),
//                       child: Text(
//                         "Log In",
//                         style: TextStyle(
//                           fontFamily: 'BalooChettan2',
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.blue.shade900,
//                         ),
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 20),

//                   // Sign Up Button
//                   SizedBox(
//                     width: 200,
//                     child: ElevatedButton(
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) =>
//                                 const SignupPage(), // Navigate to SignupPage
//                           ),
//                         );
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.transparent,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(25),
//                           side: BorderSide(color: Colors.white, width: 2),
//                         ),
//                         padding: const EdgeInsets.symmetric(vertical: 15),
//                       ),
//                       child: Text(
//                         "Sign Up",
//                         style: TextStyle(
//                           fontFamily: 'BalooChettan2',
//                           fontSize: 18,
//                           fontWeight: FontWeight.bold,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

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
          // Background Color
          Container(
            color: const Color(0xFF9FC5B2),
          ),

          // Content
          SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // App Logo or Icon
                  Icon(
                    Icons.account_circle,
                    size: 80,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 20),

                  // App Name
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

                  // App Tagline
                  Text(
                    "Keep your fridge clean!",
                    style: TextStyle(
                      fontFamily: 'BalooChettan2',
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                  const SizedBox(height: 40),

                  // Login Button
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

                  // Sign Up Button
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