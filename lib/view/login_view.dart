import 'package:flutter/material.dart';
import 'package:pembersih_kulkas/services/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _loginKey = GlobalKey<FormState>();
  final ctrlEmail = TextEditingController();
  final ctrlPass = TextEditingController();
  bool isHide = true;

  Future<void> _login() async {
    if (_loginKey.currentState?.validate() ?? false) {
      final email = ctrlEmail.text;
      final password = ctrlPass.text;

      try {
        await AuthService().signin(
          email: email,
          password: password,
          context: context,
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Login gagal: ${e.toString()}")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background with a gradient
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFF9FC5B2).withOpacity(0.8), Color(0xFF9FC5B2)],
                ),
              ),
            ),
          ),
          SafeArea(
            bottom: false,
            child: ListView(
              padding: EdgeInsets.all(20.0),
              children: [
                // Logo replaced with an icon
                Center(
                  child: Icon(
                    Icons.account_circle,
                    size: 100,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 20),

                // Title
                Text(
                  "Masuk",
                  style: TextStyle(
                    fontFamily: 'BalooChettan2',
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        offset: Offset(2.0, 2.0),
                        blurRadius: 4.0,
                        color: Colors.black54,
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),

                // Profile Form
                Form(
                  key: _loginKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),

                      // Email
                      Container(
                        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                        height: 80,
                        child: TextFormField(
                          controller: ctrlEmail,
                          keyboardType: TextInputType.emailAddress,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Email tidak boleh kosong!";
                            }
                            final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
                            if (!emailRegex.hasMatch(value)) {
                              return "Masukkan Email yang valid!";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            labelText: "Email",
                            hintText: "Masukkan Email",
                            hintStyle: TextStyle(color: Colors.grey),
                            prefixIcon: Icon(
                              Icons.mail_outlined,
                              color: Colors.grey,
                              size: 24,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 15),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),

                      // Password Field
                      Container(
                        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                        height: 80,
                        child: TextFormField(
                          obscureText: isHide,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          controller: ctrlPass,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            labelText: "Kata Sandi",
                            hintText: "Masukkan Kata Sandi",
                            hintStyle: TextStyle(color: Colors.grey),
                            prefixIcon: Icon(
                              Icons.lock,
                              color: Colors.grey,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 15),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  isHide = !isHide;
                                });
                              },
                              child: Icon(
                                color: Colors.grey,
                                size: 24,
                                isHide
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                              ),
                            ),
                          ),
                          validator: (value) {
                            return value!.length < 6
                                ? "Kata Sandi harus berisi minimal 6 kata"
                                : null;
                          },
                        ),
                      ),
                      SizedBox(height: 30),

                      // Submit Button
                      Align(
                        alignment: Alignment.center,
                        child: Container(
                          height: 50,
                          width: 150,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                              elevation: 5,
                            ),
                            onPressed: _login,
                            child: Text(
                              "Masuk",
                              style: TextStyle(
                                color: Color(0xFF9FC5B2),
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
