import 'package:flutter/material.dart';

const String ip = "192.168.0.65";
const String baseUrl = 'http://' + ip + ':5050/';

const defaultGradient = LinearGradient(
  begin: Alignment.topRight,
  end: Alignment.bottomLeft,
  colors: [
    Colors.purpleAccent,
    Colors.purple,
  ],
);