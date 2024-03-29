import 'package:dsw_aplikacje_mobilne_projekt/database/user_db.dart';
import 'package:dsw_aplikacje_mobilne_projekt/models/user_model.dart';
import 'package:dsw_aplikacje_mobilne_projekt/screens/login_screen.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  final User? user;
  const RegisterScreen({super.key, this.user});

  @override
  State<RegisterScreen> createState() {
    return _RegisterScreenState();
  }
}

class _RegisterScreenState extends State<RegisterScreen> {
  User? user;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();

  var _showPassword = false;
  var _showConfirmPassword = false;

  signUp() async {
    _formKey.currentState!.validate();
    String name = _name.text;
    String email = _email.text;
    String password = _pass.text;
    String cpassword = _confirmPass.text;

    if (user != null) {
      _name.text = user!.name;
      _email.text = user!.email;
      _pass.text = user!.password;
      _confirmPass.text = user!.password;
    }

    if (_formKey.currentState!.validate()) {
      if (password != cpassword) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Password Mismatch'),
          ),
        );
      } else {
        _formKey.currentState!.save();

        print('name: $name');
        print('email: $email');
        print('password: $password');
        print('cpassword: $cpassword');

        User model = User(
          name: name,
          email: email,
          password: password,
          id: user?.id,
        );
        await UserDatabase.addUser(model).then(
          (value) {
            Navigator.pop(context);
            return ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Successfully Registered'),
              ),
            );
          },
        ).catchError(
          (error) {
            print('kaesik/ Error: $error');
            return ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Error: Data Save Fail'),
              ),
            );
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        const Image(
          image: AssetImage("assets/images/register_background.png"),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const SizedBox(height: 60),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Row(
                        children: [
                          Icon(
                            Icons.arrow_back_ios,
                            color: Color(0xFF471AA0),
                            size: 20,
                          ),
                          Text(
                            "Back",
                            style: TextStyle(
                              color: Color(0xFF471AA0),
                              fontSize: 12,
                              fontFamily: "Inter",
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Sign up",
                        style:
                            Theme.of(context).textTheme.headlineLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF471AA0),
                                ),
                      ),
                    ),
                    const SizedBox(height: 46),
                    TextFormField(
                      controller: _name,
                      autocorrect: false,
                      textCapitalization: TextCapitalization.none,
                      decoration: const InputDecoration(
                        labelText: "Full Name",
                        hintText: "Enter your name",
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
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter your name.';
                        }
                        return null;
                      },
                    ), // Full Name
                    const SizedBox(height: 40),
                    TextFormField(
                      controller: _email,
                      keyboardType: TextInputType.emailAddress,
                      autocorrect: false,
                      textCapitalization: TextCapitalization.none,
                      decoration: const InputDecoration(
                        labelText: "Email",
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
                          Icons.email_outlined,
                          color: Color(0xFF471AA0),
                        ),
                        contentPadding: EdgeInsets.all(5.0),
                      ),
                      validator: (value) {
                        if (value == null ||
                            value.trim().isEmpty ||
                            !value.contains('@') ||
                            !value.contains('.')) {
                          return 'Please enter a valid email address.';
                        }
                        return null;
                      },
                    ), // Email
                    const SizedBox(height: 40),
                    TextFormField(
                      controller: _pass,
                      obscureText: !_showPassword,
                      textCapitalization: TextCapitalization.none,
                      decoration: InputDecoration(
                        labelText: "Password",
                        hintText: "Enter your password",
                        focusedBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFF9747FF), width: 2.0),
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFF471AA0), width: 2.0),
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
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
                            color: Color(0x33000000),
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null ||
                            value.trim().isEmpty ||
                            value.trim().length < 6) {
                          return 'Password must be at least 6 characters long.';
                        }
                        return null;
                      },
                    ), // Password
                    const SizedBox(height: 40),
                    TextFormField(
                      controller: _confirmPass,
                      obscureText: !_showConfirmPassword,
                      textCapitalization: TextCapitalization.none,
                      decoration: InputDecoration(
                        labelText: "Confirm Password",
                        hintText: "Confirm your password",
                        focusedBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFF9747FF), width: 2.0),
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xFF471AA0), width: 2.0),
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        ),
                        prefixIcon: const Icon(
                          Icons.lock_outlined,
                          color: Color(0xFF471AA0),
                        ),
                        contentPadding: const EdgeInsets.all(5.0),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _showConfirmPassword = !_showConfirmPassword;
                            });
                          },
                          icon: Icon(
                            _showConfirmPassword
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: Color(0x33000000),
                          ),
                        ),
                      ),
                      validator: (value) {
                        if (value == null ||
                            value.trim().isEmpty ||
                            value != _pass.text) {
                          return 'Passwords do not match.';
                        }
                        return null;
                      },
                    ), // Confirm Password
                    const SizedBox(height: 80),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        backgroundColor: const Color(0xFFBB84E8),
                      ),
                      onPressed: signUp,
                      child: const Text(
                        "Sign up",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 190),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an account?",
                          style: TextStyle(
                            color: Color(0xFF471AA0),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginScreen()));
                          },
                          child: const Text(
                            "Sing In",
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
        ),
      ],
    );
  }
}
