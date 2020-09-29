import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sandovalportfolio/Screens/signup.dart';
import 'package:sandovalportfolio/Widgets/bezierContainer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sandovalportfolio/Screens//home.dart';
import 'package:huawei_account/helpers/auth_param_helper.dart';
import 'package:huawei_account/hms_account.dart';
import 'package:huawei_account/auth/auth_huawei_id.dart';

class LoginPage extends StatefulWidget {
  final String title;
  final bool hmsAvailable;
  final bool gmsAvailable;

  LoginPage({Key key, this.title, this.hmsAvailable, this.gmsAvailable})
      : super(key: key);

  _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  Widget _huaweiAuthButton(String text, Function function) {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(vertical: 20),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10))),
      child: InkWell(
        onTap: function,
        splashColor: Colors.red,
        highlightColor: Colors.red,
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.red[900],
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(5),
                    topLeft: Radius.circular(5),
                  ),
                ),
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/logo.png',
                  height: 45,
                  width: 45,
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.red[900],
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(5),
                    topRight: Radius.circular(5),
                  ),
                ),
                alignment: Alignment.center,
                child: Text("Log in with Huawei ID",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w400)),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(Icons.keyboard_arrow_left, color: Colors.black87),
            ),
            Text("Back",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87))
          ],
        ),
      ),
    );
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: 'Sandoval Portfolio',
        style: GoogleFonts.lato(
            textStyle: Theme.of(context).textTheme.bodyText1,
            fontSize: 27,
            fontWeight: FontWeight.w700,
            color: Colors.black87),
      ),
    );
  }

  Widget _emailWidget() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Email',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(height: 10),
          TextFormField(
            controller: emailController,
            decoration: InputDecoration(
                labelText: 'Enter Email',
                border: InputBorder.none,
                fillColor: Colors.grey[350],
                filled: true),
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value.isEmpty) {
                return 'Enter an Email Address';
              } else if (!value.contains('@')) {
                return 'Please enter a valid email address';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _passwordWidget() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Password',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(height: 10),
          TextFormField(
            obscureText: true,
            controller: passwordController,
            decoration: InputDecoration(
                labelText: 'Enter Password',
                border: InputBorder.none,
                fillColor: Colors.grey[350],
                filled: true),
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value.isEmpty) {
                return 'Enter Password';
              } else if (value.length < 6) {
                return 'Password must be atleast 6 characters!';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _submitButton() {
    return Container(
        child: isLoading
            ? CircularProgressIndicator()
            : InkWell(
                onTap: () {
                  if (_formKey.currentState.validate()) {
                    setState(() {
                      isLoading = true;
                    });
                    logInToFb();
                  }
                },
                splashColor: Colors.blue,
                highlightColor: Colors.blue,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [Colors.blue[900], Colors.blue[500]])),
                  child: Text(
                    "Login",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ));
  }

  Widget _divider() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          SizedBox(width: 20),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          Text("or"),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Divider(
                thickness: 1,
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
    );
  }

  Widget _facebookButton() {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(vertical: 20),
      decoration:
          BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xff1959a9),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(5),
                  topLeft: Radius.circular(5),
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                "f",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.w400),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xff2872ba),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(5),
                  topRight: Radius.circular(5),
                ),
              ),
              alignment: Alignment.center,
              child: Text("Log in with Facebook",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w400)),
            ),
          )
        ],
      ),
    );
  }

  Widget _createAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SignUpPage(
                      gmsAvailable: widget.gmsAvailable,
                      hmsAvailable: widget.hmsAvailable,
                    )));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20.0),
        padding: EdgeInsets.all(15.0),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Don\'t have an account ?",
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87)),
            SizedBox(width: 10),
            Text(
              "Register",
              style: TextStyle(
                  color: Colors.blue[700],
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            )
          ],
        ),
      ),
    );
  }

  Widget _emailPasswordWidget() {
    return Column(
      children: [
        _emailWidget(),
        _passwordWidget(),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void logInToFb() {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: emailController.text, password: passwordController.text)
        .then((result) {
      FirebaseAuth.instance.currentUser().then((FirebaseUser user) {
        final userName = user.email;
        isLoading = false;
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => Home(
                      gmsAvailable: widget.gmsAvailable,
                      hmsAvailable: widget.hmsAvailable,
                      userName: userName,
                    )));
      });
    }).catchError((err) {
      isLoading = false;
      print(err.message);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Error"),
              content: Text(err.message),
              actions: [
                FlatButton(
                  child: Text("Ok"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          });
    });
  }

  _signInWithAuthorizationCode() async {
    AuthParamHelper authParamHelper = new AuthParamHelper();
    authParamHelper
      ..setAuthorizationCode()
      ..setRequestCode(1002);
    try {
      final AuthHuaweiId accountInfo =
          await HmsAccount.signInWithAuthorizationCode(authParamHelper);
      setState(() {
        print(accountInfo.displayName);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => Home(
                    gmsAvailable: widget.gmsAvailable,
                    hmsAvailable: widget.hmsAvailable,
                    userName: accountInfo.displayName,
                  )),
        );
      });
    } on Exception catch (exception) {
      print(exception.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    Widget child;
    // GMS Available
    if (widget.gmsAvailable) {
      child = Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: height * 0.22),
          _title(),
          SizedBox(height: 50),
          _emailPasswordWidget(),
          SizedBox(height: 20),
          _submitButton(),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            alignment: Alignment.centerRight,
            child: Text("Forgot Password ?",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87)),
          ),
          _divider(),
          _facebookButton(),
          SizedBox(height: height * 0.01),
          _createAccountLabel(),
        ],
      );
      //HMS Available
    } else if (widget.hmsAvailable) {
      child = Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: height * 0.2),
          _title(),
          SizedBox(height: 70),
          _huaweiAuthButton(
              "SIGN IN WITH AUTHORIZATION CODE", _signInWithAuthorizationCode),
          Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            alignment: Alignment.centerRight,
            child: Text("",
                style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87)),
          ),
          SizedBox(height: height * 0.01),
          _createAccountLabel(),
        ],
      );
    }
    return Scaffold(
        body: Form(
      key: _formKey,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade200,
                offset: Offset(2, 4),
                blurRadius: 5,
                spreadRadius: 2)
          ],
          gradient: RadialGradient(
            colors: [Colors.grey[400], Colors.grey[300], Colors.grey[100]],
            center: Alignment(0.6, -0.3),
            focal: Alignment(0.3, -0.1),
            focalRadius: 1.0,
          ),
        ),
        height: height,
        child: Stack(
          children: [
            Positioned(
              top: -height * .15,
              right: -MediaQuery.of(context).size.width * 0.4,
              child: BezierContainer(),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: child,
              ),
            ),
            Positioned(top: 40, left: 0, child: _backButton()),
          ],
        ),
      ),
    ));
  }
}
