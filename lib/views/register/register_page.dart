import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:issues_tracker_app/commons/consts.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _password = TextEditingController();
  TextEditingController _confirmPassword = TextEditingController();
  TextEditingController _email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(context),
    );
  }

  Container _body(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.purpleAccent,
            Colors.purple,
          ],
        ),
      ),
      child: ListView(
        children: [
          Container(
            margin: EdgeInsets.only(top: 15, left: 15),
            child: Align(
              alignment: Alignment.topLeft,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back_outlined,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 40),
            alignment: Alignment.topCenter,
            child: Text(
              'Logo',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 30, right: 30, top: 40),
            padding: EdgeInsets.only(top: 45, bottom: 45),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.deepPurple.withOpacity(0.5),
                  spreadRadius: 15,
                  blurRadius: 15,
                  offset: Offset(10, 10),
                )
              ],
            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 30, right: 30),
                  child: TextField(
                    controller: _email,
                    decoration: InputDecoration(
                      hintText: 'Login',
                      icon: Icon(Icons.person),
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Container(
                  padding: EdgeInsets.only(left: 30, right: 30),
                  child: TextField(
                    controller: _password,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Senha',
                      icon: Icon(Icons.vpn_key_outlined),
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Container(
                  padding: EdgeInsets.only(left: 30, right: 30),
                  child: TextField(
                    controller: _confirmPassword,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Repita a senha',
                      icon: Icon(Icons.vpn_key_outlined),
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  color: Colors.purple,
                  child: TextButton(
                    onPressed: () {
                      _doRegister();
                    },
                    child: Text(
                      'Cadastrar-se',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                Container(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cancelar'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _doRegister() async {
    var url = baseUrl + 'api/signup';
    try {
      var data = {
        "name": "sem nome",
        "email": _email.text,
        "password": _password.text,
        "passwordConfirmation": _confirmPassword.text,
      };
      var response = await Dio().post(url, data: data);
      if (response.data.toString() == "account successfully created") {
        _showDialog(context, 'Enviamos um email para: ${_email.text}', returnToLogin: true);
      }
    } catch (e) {
      print("##########");
      print(e);
      print("##########");
      _showDialog(context, 'Este login já existe');
    }
  }

  _showDialog(BuildContext context, message, {bool returnToLogin=false}) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text("$message"),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (returnToLogin) {
                  Navigator.pop(context);
                  Navigator.pushNamedAndRemoveUntil(context, '', (route) => false);
                } else {
                  Navigator.pop(context);
                }
              },
              child: Text('Fechar'),
            ),
          ],
        );
      },
    );
  }
}
