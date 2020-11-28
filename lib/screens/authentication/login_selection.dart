import 'package:flutter/material.dart';
import 'package:instagram_clone/screens/authentication/sign_in.dart';
import 'package:instagram_clone/screens/authentication/sign_up.dart';

class LoginSelection extends StatefulWidget {

  @override
  _LoginSelectionState createState() => _LoginSelectionState();
}

class _LoginSelectionState extends State<LoginSelection> {
  final List<String> languages = ["English (United States)", "Hindi"];

  bool isLoginSelectionSelected = true;
  bool showSignIn = false;

  void switchSignInRegisterView() {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (isLoginSelectionSelected) {
      return SafeArea(
        child: Scaffold(
            body: Column(
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

                SizedBox(height: 175.0),

                Image.asset(
                  "assets/images/instagram_typography.png",
                  height: 100.0,
                  width: 200.0,
                ),

                SizedBox(height: 40.0),

                Container(
                  padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
                  height: 50.0,
                  width: double.infinity,
                  child: FlatButton(
                    child: Text(
                      "Create New Account",
                      style: TextStyle(
                          color: Colors.white
                      ),
                    ),
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    onPressed: () {
                      setState(() {
                        print("Create new Account");
                        isLoginSelectionSelected = false;
                        showSignIn = false;
                      });
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
                    },
                  ),
                ),

                SizedBox(height: 15.0),

                TextButton(
                  child: Text(
                    "Log In",
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      print("Log In");
                      isLoginSelectionSelected = false;
                      showSignIn = true;
                    });
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => SignIn()),);
                  },
                ),
              ],
            )
        ),
      );
    }
    else {
      return showSignIn ? SignIn(switchView: switchSignInRegisterView) : SignUp(switchView: switchSignInRegisterView);
    }
  }
}