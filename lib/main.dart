import 'package:flutter/material.dart';
import 'package:book_beacon/pages/home.dart';
import 'package:book_beacon/pages/book_list.dart';
import 'package:book_beacon/pages/nearby.dart';
import 'package:book_beacon/pages/bookInfo.dart';

import 'package:flutter/services.dart';
import 'package:flutter_beacon/flutter_beacon.dart';

void main() => runApp(MaterialApp(
  initialRoute: '/home',
  routes: {
    '/home': (context) => Home(),
    '/list': (context) => BookList(),
    '/nearby': (context) => Nearby(),
    '/bookInfo': (context) => Info(),
  },
));
