import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: SingleChildScrollView(
        child: Form(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                const Image(
                  image: AssetImage("assets/images/logo.png"),
                  height: 200,
                  width: 200,
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Sign in",
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF471AA0),
                        ),
                  ),
                ),
                const SizedBox(height: 46),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Email or User Name",
                    hintText: "Enter your email",
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFF9747FF), width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFF471AA0), width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
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
                  decoration: const InputDecoration(
                    labelText: "Password",
                    hintText: "Enter your password",
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFF9747FF), width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Color(0xFF471AA0), width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    ),
                    prefixIcon: Icon(
                      Icons.lock_outlined,
                      color: Color(0xFF471AA0),
                    ),
                    contentPadding: EdgeInsets.all(5.0),
                    suffixIcon: Icon(
                      Icons.remove_red_eye_outlined,
                      color: Color(0x33000000),
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
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
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
                  onPressed: () {},
                  child: const Text(
                    "Sign in",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 75),
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
                    Container(
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
                        image: AssetImage("assets/images/google_logo.png"),
                      ),
                    ),
                    const SizedBox(width: 24),
                    Container(
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
                        image: AssetImage("assets/images/facebook_logo.png"),
                      ),
                    ),
                    const SizedBox(width: 24),
                    Container(
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
                        image: AssetImage("assets/images/twitter_logo.png"),
                      ),
                    ),
                    const SizedBox(width: 24),
                    Container(
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
                        image: AssetImage("assets/images/linkedin_logo.png"),
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
                      onPressed: () {},
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