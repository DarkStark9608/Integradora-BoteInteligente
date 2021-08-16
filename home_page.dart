import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      floatingActionButton: FloatingActionButton.extended(
          label: Text('Login'),
          icon: Icon(Icons.login_outlined, color: Theme.of(context).primaryColor),
          onPressed: () {
            Navigator.pushNamed(context, 'login');
          }),
    );
  }
}

