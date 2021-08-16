import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> keyForm = new GlobalKey();

  TextEditingController _email = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();

  String email;
  String password;

  void dispose() {
    _email.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text('Bote Inteligente'),
          centerTitle: true,
        ),
        body: new SingleChildScrollView(
          child: new Container(
            margin: new EdgeInsets.all(20.0),
            child: new Form(
              key: keyForm,
              child: formUI(),
            ),
          ),
        ),
      ),
    );
  }

  formItemsDesign(icon, item) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 7),
      child: Card(child: ListTile(leading: Icon(icon), title: item)),
    );
  }

  Widget formUI() {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 60,
        ),
        formItemsDesign(
            Icons.email,
            TextFormField(
              controller: _email,
              decoration: new InputDecoration(
                labelText: 'Email',
              ),
              
              keyboardType: TextInputType.emailAddress,
              maxLength: 40,
              validator: validateEmail,
            )),
        formItemsDesign(
            Icons.remove_red_eye,
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Contraseña',
              ),
              validator: validatePassword,
            )),
        GestureDetector(
          onTap: () {
            save();
          },
          child: Container(
            margin: new EdgeInsets.all(30.0),
            alignment: Alignment.center,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0)),
              gradient: LinearGradient(colors: [
                Color(0xFF0EDED2),
                Color(0xFF03A0FE),
              ], 
              begin: Alignment.topLeft, end: Alignment.bottomRight),
            ),
            child: Text("Login",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500)),
            padding: EdgeInsets.only(top: 16, bottom: 16),
          ),
        ),
        FloatingActionButton.extended(
            label: Text('Registrate'),
            icon: Icon(Icons.login, color: Theme.of(context).primaryColor),
            onPressed: () {
              Navigator.pushNamed(context, 'registro');
            }),
      ],
    );
  }

  String validatePassword(String value) {
    print("valorrr $value passsword ${_passwordController.text}");
    if (value != _passwordController.text) {
      return "La contraseña es incorrecta";
    }
    return null;
  }

  String validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "El correo es necesario";
    } else if (!regExp.hasMatch(value)) {
      return "Correo invalido";
    } else {
      return null;
    }
  }

  save() {
    if (keyForm.currentState.validate()) {
      _getValues();
      print("Correo ${_email.text}");
      keyForm.currentState.reset();
    }
  }

  void _getValues() {
    setState(() {
      email = _email.text;
      password = _passwordController.text;
      authUser(email, password);
      print(email);
      print(password);
    });
  }

  void _alerta() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('¡¡¡Alerta!!!'),
          content: Text( "****Tu correo o contraseña no son correctos, verifica tus datos****")
        );
      },
    );
  }

  void authUser(
    String email,
    String password,
  ) async {
    try {
      var url = Uri.parse(
          'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyAEr4quM7HAGyLluK2Iqox3kqmIjSnKmaA');
      Map<String, dynamic> map = new Map<String, dynamic>();
      map['email'] = email;
      map['password'] = password;
      var response = await http.post(url, body: map);
      print('Response status: ${response.statusCode}');
      //print('Response body: ${response.body}');
      if (response.statusCode == 200) {
        //Navigator.popAndPushNamed(context, 'leer');
        Navigator.pushNamed(context, 'recomendaciones');
      }
      if (response.statusCode == 400) {
        _alerta();
      }
    } catch (error) {
      print(error.toString());
    }
  }
}
