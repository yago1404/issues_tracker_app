import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:issues_tracker_app/commons/consts.dart';
import 'package:toast/toast.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _password = TextEditingController();
  TextEditingController _confirmPassword = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _name = TextEditingController();
  bool _isLoading = false;
  Dio dio = Dio();

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
                    controller: _name,
                    decoration: InputDecoration(
                      hintText: 'Nome',
                      icon: Icon(Icons.person),
                    ),
                    onEditingComplete: () {
                      FocusScope.of(context).nextFocus();
                    },
                    textInputAction: TextInputAction.next,
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Container(
                  padding: EdgeInsets.only(left: 30, right: 30),
                  child: TextField(
                    controller: _email,
                    decoration: InputDecoration(
                      hintText: 'E-mail',
                      icon: Icon(Icons.alternate_email),
                    ),
                    onEditingComplete: () {
                      FocusScope.of(context).nextFocus();
                    },
                    textInputAction: TextInputAction.next,
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
                    onEditingComplete: () {
                      FocusScope.of(context).nextFocus();
                    },
                    textInputAction: TextInputAction.next,
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
                    onEditingComplete: () {
                      _doRegister();
                    },
                    textInputAction: TextInputAction.done,
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
                    child: _isLoading ? CircularProgressIndicator.adaptive( backgroundColor: Colors.white,) : Text(
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
    setState(() {
      this._isLoading = true;
    });
    FocusScope.of(context).unfocus();
    var url = 'api/signup';
    dio.options.baseUrl = baseUrl;
    dio.options.connectTimeout = 5000;
    dio.options.receiveTimeout = 5000;
    try {
      var data = {
        "name": _name.text,
        "email": _email.text,
        "password": _password.text,
        "passwordConfirmation": _confirmPassword.text,
      };
      var response = await dio.post(url, data: data);
      if (response.data.toString() == "account successfully created") {
        _showDialog(context, 'Enviamos um email para: ${_email.text}',
            returnToLogin: true);
      }
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout) {
        Toast.show("Verifique a conexão com a internete", context, duration: 5);
      } else if(e.response.statusCode == 403) {
        print(e);
        Toast.show("Este login já existe", context, duration: 5);
      }
    } catch (e) {
      // Error
    }
    setState(() {
      _isLoading = false;
    });
  }

  _showDialog(BuildContext context, message, {bool returnToLogin = false}) {
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
                  Navigator.pushNamedAndRemoveUntil(
                      context, '', (route) => false);
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
