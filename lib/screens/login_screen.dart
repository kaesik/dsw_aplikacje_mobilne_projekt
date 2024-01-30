import 'package:dsw_aplikacje_mobilne_projekt/database/user_db.dart';
import 'package:dsw_aplikacje_mobilne_projekt/models/user_model.dart';
import 'package:dsw_aplikacje_mobilne_projekt/screens/landing_screen.dart';
import 'package:dsw_aplikacje_mobilne_projekt/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> {
  late User user;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass = TextEditingController();

  var _showPassword = false;

  bool _isLogin = false;
  _checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLogin = (prefs.getBool('isLogin') ?? false);

    setState(() {
      _isLogin = isLogin;
    });
  }

  @override
  void initState() {
    _checkLogin();
    super.initState();
  }

  login() async {
    String email = _email.text;
    String password = _pass.text;
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
    }
    await UserDatabase.getLoginUser(
      email,
      password,
    ).then(
      (value) async {
        if (value != null) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setBool('isLogin', true);
          setState(() {
            _isLogin = true;
          });

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const LandingScreen();
              },
            ),
          );

          user = value;
          print('kaesik/ User: $user');

          return ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Successfully Login'),
            ),
          );
        } else {
          return ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Error: User Not Found'),
            ),
          );
        }
      },
    ).catchError(
      (error) {
        print('kaesik/ Error: $error');
        return ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Error: Login Fail'),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return _isLogin
        ? const LandingScreen()
        : Scaffold(
            backgroundColor: const Color(0xFFFFFFFF),
            body: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      const SizedBox(height: 60),
                      const Image(
                        image: AssetImage("assets/images/logo.png"),
                        height: 130,
                        fit: BoxFit.fitHeight,
                      ),
                      const SizedBox(height: 20),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Sign in",
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF471AA0),
                              ),
                        ),
                      ),
                      const SizedBox(height: 46),
                      TextFormField(
                        controller: _email,
                        keyboardType: TextInputType.emailAddress,
                        autocorrect: false,
                        textCapitalization: TextCapitalization.none,
                        validator: (value) {
                          if (value!.isEmpty ||
                              value.contains('@') == false ||
                              value.contains('.') == false) {
                            return "Please enter email";
                          } else {
                            return null;
                          }
                        },
                        decoration: const InputDecoration(
                          labelText: "Email or User Name",
                          hintText: "Enter your email",
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF9747FF),
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFF471AA0),
                              width: 2.0,
                            ),
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                          ),
                          prefixIcon: Icon(
                            Icons.person_outlined,
                            color: Color(0xFF471AA0),
                          ),
                          contentPadding: EdgeInsets.all(5.0),
                        ),
                      ),
                      const SizedBox(height: 40),
                      TextFormField(
                        controller: _pass,
                        obscureText: !_showPassword,
                        textCapitalization: TextCapitalization.none,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter password";
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          labelText: "Password",
                          hintText: "Enter your password",
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xFF9747FF), width: 2.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xFF471AA0), width: 2.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0)),
                          ),
                          prefixIcon: const Icon(
                            Icons.lock_outlined,
                            color: Color(0xFF471AA0),
                          ),
                          contentPadding: const EdgeInsets.all(5.0),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _showPassword = !_showPassword;
                              });
                            },
                            icon: Icon(
                              _showPassword
                                  ? Icons.visibility_outlined
                                  : Icons.visibility_off_outlined,
                              color: const Color(0x33000000),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      Container(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            "Forgot password?",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: const Color(0xFF471AA0),
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(50),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          backgroundColor: const Color(0xFFBB84E8),
                        ),
                        onPressed: login,
                        child: const Text(
                          "Sign in",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 60),
                      Text(
                        "Or sign in with",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: const Color(0xFF471AA0),
                            ),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: ShapeDecoration(
                                shadows: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 10,
                                    offset: const Offset(0, 5),
                                  ),
                                ],
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              child: const Image(
                                image:
                                    AssetImage("assets/images/google_logo.png"),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          TextButton(
                            onPressed: () {},
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: ShapeDecoration(
                                shadows: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 10,
                                    offset: const Offset(0, 5),
                                  ),
                                ],
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              child: const Image(
                                image: AssetImage(
                                    "assets/images/facebook_logo.png"),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          TextButton(
                            onPressed: () {},
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: ShapeDecoration(
                                shadows: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 10,
                                    offset: const Offset(0, 5),
                                  ),
                                ],
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              child: const Image(
                                image: AssetImage(
                                    "assets/images/twitter_logo.png"),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          TextButton(
                            onPressed: () {},
                            child: Container(
                              width: 50,
                              height: 50,
                              decoration: ShapeDecoration(
                                shadows: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 10,
                                    offset: const Offset(0, 5),
                                  ),
                                ],
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              child: const Image(
                                image: AssetImage(
                                    "assets/images/linkedin_logo.png"),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 60),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don't have an account?",
                            style: TextStyle(
                              color: Color(0xFF471AA0),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const RegisterScreen()));
                            },
                            child: const Text(
                              "Sing Up",
                              style: TextStyle(
                                color: Color(0xFF471AA0),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
