import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sandovalportfolio/Screens/loginPage.dart';
import 'package:sandovalportfolio/Screens/signup.dart';

class WelcomePage extends StatefulWidget {
  final String title;

  WelcomePage({Key key, this.title}) : super(key: key);

  _WelcomePage createState() => _WelcomePage();
}

class _WelcomePage extends State<WelcomePage> {
  static const MethodChannel methodChannel =
      MethodChannel('com.sandoval.sandovalporfolio/isHmsGmsAvailable');

  bool _isHmsAvailable;
  bool _isGmsAvailable;

  @override
  void initState() {
    checkHmsGms();
    super.initState();
  }

  void checkHmsGms() async {
    await _isHMS();
    await _isGMS();
  }

  Future<void> _isHMS() async {
    bool status;
    try {
      bool result = await methodChannel.invokeMethod('isHmsAvailable');
      status = result;
      print('status: ${status.toString()}');
    } on PlatformException {
      print('failed to get _isHmsAvailable');
    }

    setState(() {
      _isHmsAvailable = status;
    });
  }

  Future<void> _isGMS() async {
    bool status;
    try {
      bool result = await methodChannel.invokeMethod('isGmsAvailable');
      status = result;
      print('status: ${status.toString()}');
    } on PlatformException {
      print('failed to get _isHmsAvailable');
    }

    setState(() {
      _isGmsAvailable = status;
    });
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: 'Sandoval Portfolio',
        style: GoogleFonts.lato(
            textStyle: Theme.of(context).textTheme.headline4,
            fontSize: 27,
            fontWeight: FontWeight.w700,
            color: Colors.white),
      ),
    );
  }

  Widget _submitButton() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 13.0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            boxShadow: [
              BoxShadow(
                  color: Colors.blueAccent.withAlpha(100),
                  offset: Offset(2, 4),
                  blurRadius: 8,
                  spreadRadius: 2)
            ],
            color: Colors.white),
        child: Text(
          "Login",
          style: TextStyle(
              fontSize: 20,
              color: Colors.blue[700],
              fontWeight: FontWeight.w800),
        ),
      ),
    );
  }

  Widget _signUpButtom() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => SignUpPage()));
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 13.0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          border: Border.all(color: Colors.white, width: 2),
        ),
        child: Text(
          "Register Now",
          style: TextStyle(
              fontSize: 20, color: Colors.white, fontWeight: FontWeight.w800),
        ),
      ),
    );
  }

  Widget _label() {
    return Container(
      margin: EdgeInsets.only(top: 40, bottom: 20),
      child: Column(
        children: [
          Text(
            'Quick login with Touch ID',
            style: TextStyle(color: Colors.white, fontSize: 17),
          ),
          SizedBox(height: 20),
          Icon(Icons.fingerprint, size: 90, color: Colors.white),
          SizedBox(
            height: 20,
          ),
          Text(
            'Touch ID',
            style: TextStyle(
                color: Colors.white,
                fontSize: 15,
                decoration: TextDecoration.underline),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          height: MediaQuery.of(context).size.height,
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
              colors: [Colors.blue[900], Colors.blue[800], Colors.blue[700]],
              center: Alignment(0.6, -0.3),
              focal: Alignment(0.3, -0.1),
              focalRadius: 1.0,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _title(),
              SizedBox(height: 80),
              _submitButton(),
              SizedBox(height: 20),
              _signUpButtom(),
              SizedBox(height: 20),
              _label(),
            ],
          ),
        ),
      ),
    );
  }
}
