import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:instagram_clone/screens/authentication/sign_in.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  String email = "";
  String password = "";
  bool _obscureText = true;
  bool _isButtonEnabled = false;

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

    // return SafeArea(
    //   child: Scaffold(
    //     body: DefaultTabController(
    //       length: 2,
    //       child: Column(
    //           children: [
    //             TabBar(tabs: _kTabs, labelColor: Colors.black, indicatorColor: Colors.black),
    //             Expanded(child: TabBarView(children: _kTabPages)),
    //           ],
    //         ),
    //       ),
    //   ),
    // );

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Container(
                  child: Image.asset(
                    "assets/images/register_user_icon.png",
                    color: Colors.black,
                    height: 300.0,
                    width: 300.0,
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(25.0, 0.0, 25.0, 0.0),
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
                  padding: EdgeInsets.fromLTRB(25.0, 0.0, 25.0, 0.0),
                  height: 50.0,
                  child: TextFormField(
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Password",
                      suffixIcon: IconButton(
                        icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
                        onPressed: () {
                          setState(() => _obscureText = !_obscureText);
                        },
                      ),
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
                  padding: EdgeInsets.fromLTRB(25.0, 0.0, 25.0, 0.0),
                  height: 50.0,
                  width: double.infinity,
                  child: FlatButton(
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                          color: Colors.white
                      ),
                    ),
                    color: Colors.blue,
                    disabledColor: Colors.blue[200],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    onPressed: _isButtonEnabled ? () => print("Register") : null,
                  ),
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
                              text: "Already have an account? ",
                              style: TextStyle(color: Colors.grey),
                              recognizer: TapGestureRecognizer()..onTap = () {
                                print("Go get Sign Up");
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignIn()));
                              }
                            ),
                            TextSpan(
                              text: "Log in.",
                              style: TextStyle(
                                color: Colors.blue[900],
                                fontWeight: FontWeight.bold,
                              ),
                              recognizer: TapGestureRecognizer()..onTap = () {
                                print("Go get Log In");
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignIn()));
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
          ],
        ),
      ),
    );
  }
}

/*
Column(
  children: [
    Container(
      padding: EdgeInsets.fromLTRB(25.0, 0.0, 25.0, 0.0),
      height: 50.0,
      child: TextFormField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: "Phone number, email or username",
        ),
        onChanged: (_) {},
      ),
    ),

    Container(
      padding: EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 0.0),
      child: Text(
        "You may receive SMS updates from Instagram and can opt out at any time.",
        style: TextStyle(
          color: Colors.grey,
          fontSize: 12.0
        ),
        textAlign: TextAlign.center,
      ),
    ),
  ],
),
*/