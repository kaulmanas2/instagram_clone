import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/services/auth.dart';
import 'package:instagram_clone/shared/loading.dart';

class SignIn extends StatefulWidget {

  final Function switchView;
  SignIn({this.switchView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthenticationService _authService = AuthenticationService();

  final List<String> languages = ["English (United States)", "Hindi"];

  String email = "";
  String password = "";
  bool _obscureText = true;
  bool _isButtonEnabled = false;
  bool isLoading = false;

  isEnabled() {
    setState(() {
      if (email.isNotEmpty && password.isNotEmpty) {
        _isButtonEnabled = true;
      }
      else {
        _isButtonEnabled = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: isLoading ? Loading() : Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.center,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    items: languages.map((String value) {
                      return new DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      );
                    }).toList(),
                    value: languages[0],
                    onChanged: (_) {},
                  ),
                ),
              ),

              Column(
                children: [
                  Image.asset(
                    "assets/images/instagram_typography.png",
                    height: 100.0,
                    width: 200.0,
                  ),

                  Container(
                    padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                    height: 50.0,
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Email",
                      ),
                      onChanged: (val) {
                        setState(() {
                          email = val.toString();
                          isEnabled();
                        });
                      },
                    ),
                  ),

                  SizedBox(height: 15.0),

                  Container(
                    padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                    height: 50.0,
                    child: TextFormField(
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Password",
                        suffixIcon: GestureDetector(
                          child: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
                          onTap: () {
                            setState(() => _obscureText = !_obscureText);
                          },
                        )
                      ),
                      onChanged: (val) {
                        setState(() {
                          password = val.toString();
                          isEnabled();
                        });
                      },
                    ),
                  ),

                  SizedBox(height: 15.0),

                  Container(
                    padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                    height: 50.0,
                    width: double.infinity,
                    child: FlatButton(
                      child: Text(
                        "Log In",
                        style: TextStyle(
                          color: Colors.white
                        ),
                      ),
                      color: Colors.blue,
                      disabledColor: Colors.blue[200],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      onPressed: _isButtonEnabled
                        ? () async {
                          setState(() {
                            print("$email $password");
                            isLoading = true;
                          });
                          dynamic result = await _authService.signInWithEmailAndPassword(email, password);
                          if (result == null) {
                            setState(() {
                              print("Error Logging In");
                              isLoading = false;
                            });
                          }
                        }
                        : null,
                    ),
                  ),

                  SizedBox(height: 15.0),

                  Container(
                    alignment: Alignment.center,
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Forgot your login details? ",
                            style: TextStyle(color: Colors.grey),
                            recognizer: TapGestureRecognizer()..onTap = () {
                              print("Go get Help");
                            }
                          ),
                          TextSpan(
                            text: "Get help logging in.",
                            style: TextStyle(
                              color: Colors.blue[900],
                              fontWeight: FontWeight.bold,
                            ),
                            recognizer: TapGestureRecognizer()..onTap = () {
                              print("Go get Help");
                            }
                          ),
                        ]
                      ),
                    ),
                  ),

                  SizedBox(height: 15.0),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                    child: Row(
                      children: [
                        Expanded(child: Divider(endIndent: 15.0, thickness: 1.0)),
                        Text(
                          "OR",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Expanded(child: Divider(indent: 15.0, thickness: 1.0)),
                      ],
                    ),
                  ),

                  TextButton(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ImageIcon(AssetImage("assets/images/fb_logo.png")),
                        Text("  Log In with facebook")
                      ],
                    ),
                    onPressed: () {
                      print("Log In with facebook");
                    },
                  ),
                ],
              ),

              Container(
                child: Column(
                  children: [
                    Divider(thickness: 2.0),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 15.0),
                      child: Container(
                        alignment: Alignment.center,
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                  text: "Don't have an account? ",
                                  style: TextStyle(color: Colors.grey),
                                  recognizer: TapGestureRecognizer()..onTap = () {
                                    setState(() {
                                      print("Go get Sign Up");
                                      widget.switchView();
                                    });
                                    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignUp()));
                                  }
                              ),
                              TextSpan(
                                  text: "Sign up.",
                                  style: TextStyle(
                                    color: Colors.blue[900],
                                    fontWeight: FontWeight.bold,
                                  ),
                                  recognizer: TapGestureRecognizer()..onTap = () {
                                    setState(() {
                                      print("Go get Sign Up");
                                      widget.switchView();
                                    });
                                    // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignUp()));
                                  }
                              ),
                            ]
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ]
          ),
        ),
      ),
    );
  }
}
