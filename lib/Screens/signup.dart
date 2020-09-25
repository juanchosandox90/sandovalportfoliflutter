import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sandovalportfolio/Screens/loginPage.dart';
import 'package:sandovalportfolio/Widgets/bezierContainer.dart';

class SignUpPage extends StatefulWidget {
  final String title;

  SignUpPage({Key key, this.title}) : super(key: key);

  _SignUpPage createState() => _SignUpPage();
}

class _SignUpPage extends State<SignUpPage> {
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

  Widget _entryField(String title, {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(height: 10),
          TextField(
            obscureText: isPassword,
            decoration: InputDecoration(
                border: InputBorder.none,
                fillColor: Colors.grey[350],
                filled: true),
          )
        ],
      ),
    );
  }

  Widget _submitButton() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 15),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade200,
                offset: Offset(2, 4),
                blurRadius: 5,
                spreadRadius: 2)
          ],
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Colors.blue[900], Colors.blue[500]])),
      child: Text(
        "Register Now",
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),
    );
  }

  Widget _loginAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20.0),
        padding: EdgeInsets.all(15.0),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Already have an account ?",
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87)),
            SizedBox(width: 10),
            Text(
              "Login",
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
        _entryField("Username"),
        _entryField("Email id"),
        _entryField("Password", isPassword: true),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: height * 0.2),
                    _title(),
                    SizedBox(height: 50),
                    _emailPasswordWidget(),
                    SizedBox(height: 20),
                    _submitButton(),
                    SizedBox(height: height * 0.14),
                    _loginAccountLabel(),
                  ],
                ),
              ),
            ),
            Positioned(top: 40, left: 0, child: _backButton()),
          ],
        ),
      ),
    );
  }
}
