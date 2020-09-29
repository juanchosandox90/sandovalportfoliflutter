import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sandovalportfolio/main.dart';
import 'package:huawei_account/hms_account.dart';

class Home extends StatefulWidget {
  final String title = "Home";
  final bool hmsAvailable;
  final bool gmsAvailable;
  final String userName;

  Home({Key key, this.hmsAvailable, this.gmsAvailable, this.userName})
      : super(key: key);

  _Home createState() => _Home();
}

class _Home extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () => Future.value(false),
        child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Text(widget.title),
              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.exit_to_app,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    if (widget.gmsAvailable) {
                      FirebaseAuth auth = FirebaseAuth.instance;
                      auth.signOut().then((res) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => MyApp()),
                        );
                      });
                    } else if (widget.hmsAvailable) {
                      _signOutHuawei();
                    }
                  },
                )
              ],
            ),
            body: Center(child: Text('Welcome!: ${widget.userName}'))));
  }

  _signOutHuawei() async {
    final signOutResult = await HmsAccount.signOut();
    if (signOutResult) {
      setState(() {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MyApp()),
        );
      });
    } else {
      setState(() {});
    }
  }
}
