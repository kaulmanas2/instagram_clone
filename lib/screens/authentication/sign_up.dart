import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:instagram_clone/services/auth.dart';
import 'package:instagram_clone/shared/loading.dart';

class SignUp extends StatefulWidget {

  final Function switchView;
  SignUp({this.switchView});

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final AuthenticationService _authService = AuthenticationService();

  String username = "";
  String email = "";
  String password = "";
  String confirmPassword = "";

  bool _obscureText = true;
  bool _isButtonEnabled = false;
  bool isLoading = false;

  String error = "";

  isEnabled() {
    setState(() {
      if (username.isNotEmpty && email.isNotEmpty && password.isNotEmpty && confirmPassword.isNotEmpty) {
        _isButtonEnabled = true;
      }
      else {
        _isButtonEnabled = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    var _pageSize = MediaQuery.of(context).size.height;
    var _notifySize = MediaQuery.of(context).padding.top;
    var _appBarSize = 0;
    // var _appBarSize = appBar.preferredSize.height;

    // TODO : Update textFields to form key type

    return SafeArea(
      child: Scaffold(
        body: isLoading ? Loading() : CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Container(
                color: Colors.white,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    userIcon(),   // change this to icon => Icons.account_circle_outlined
                    usernameField(),
                    emailField(),
                    passwordField(),
                    confirmPasswordField(),
                    signUpButton(),
                    Flexible(child: Container(), fit: FlexFit.loose),
                    bottomLogInBanner(),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Container userIcon() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      child: Icon(
        Icons.account_circle,
        size: 300.0,
        color: Colors.black,
      ),
    );
  }

  Container usernameField() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
      height: 60.0,
      child: TextFormField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: "Username",
        ),
        onChanged: (val) {
          setState(() {
            username = val.toString();
            isEnabled();
          });
        },
      ),
    );
  }

  Container emailField() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
      height: 60.0,
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
    );
  }

  Container passwordField() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
      height: 60.0,
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
    );
  }

  Container confirmPasswordField() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
      height: 60.0,
      child: TextFormField(
        obscureText: true,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          labelText: "Confirm Password",
        ),
        onChanged: (val) {
          setState(() {
            confirmPassword = val.toString();
            isEnabled();
          });
        },
      ),
    );
  }

  // TODO : Handle passwords do not match case
  Container signUpButton() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
      height: 75.0,
      width: double.infinity,
      child: FlatButton(
        child: Text(
          "Sign Up",
          style: TextStyle(
              color: Colors.white
          ),
        ),
        color: Colors.lightBlue[700],
        disabledColor: Colors.lightBlue[100],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        onPressed: _isButtonEnabled ? () async {
          if (password == confirmPassword) {
            print("$username $email $password, $confirmPassword");
            setState(() => isLoading = true);
            dynamic result = await _authService.signUpWithEmailAndPassword(
                email, password, username);
            if (result == null) {
              setState(() {
                error = "Error in Registration";
                isLoading = false;
              });
            }
          }
          else {
            setState(() {
              error = "Passwords do not match";
              print(error);
            });
          }
        }
        : null,
      ),
    );
  }

  Container bottomLogInBanner() {
    return Container(
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
                        setState(() {
                          print("Go get Sign In");
                          widget.switchView();
                        });
                      }
                    ),
                    TextSpan(
                      text: "Log in.",
                      style: TextStyle(
                        color: Colors.lightBlue[900],
                        fontWeight: FontWeight.bold,
                      ),
                      recognizer: TapGestureRecognizer()..onTap = () {
                        setState(() {
                          print("Go get Sign In");
                          widget.switchView();
                        });
                      }
                    ),
                  ]
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}