import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:issues_tracker_app/commons/consts.dart';
import 'package:toast/toast.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _login = TextEditingController();
  TextEditingController _password = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    this._isLoading = false;
    super.initState();
  }

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
                    controller: _login,
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
                  width: MediaQuery.of(context).size.width * 0.7,
                  color: Colors.purple,
                  child: TextButton(
                    onPressed: () {
                      _doLogin(context);
                    },
                    child: this._isLoading
                        ? SizedBox(
                            height: 25,
                            width: 25,
                            child: CircularProgressIndicator.adaptive(
                              backgroundColor: Colors.white,
                            ),
                          )
                        : Text(
                            'Entrar',
                            style: TextStyle(color: Colors.white),
                          ),
                  ),
                ),
                Container(
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'registerPage');
                    },
                    child: Text('Cadastrar-se'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _doLogin(BuildContext context) async {
    setState(() {
      _isLoading = true;
    });
    var url = baseUrl + 'api/login';
    try {
      print(url);
      var data = {
        "email": this._login.text,
        "password": this._password.text,
      };
      var response = await Dio().post(url, data: data);
      print(response.data.toString());
    } on DioError catch (e) {
      if (e.response.statusCode == 401) {
        print("não autorizado");
        Toast.show("Confirmação de email pendente", context, duration: 3);
      }
    }
    setState(() {
      _isLoading = false;
    });
  }
}
