import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'Fetching_Jokes.dart';
import 'JokePage.dart';
import 'const.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoadingChildScreen(),
    );
  }
}

class LoadingChildScreen extends StatefulWidget {
  @override
  _LoadingChildScreenState createState() => _LoadingChildScreenState();
}

class _LoadingChildScreenState extends State<LoadingChildScreen> {
  @override
  void initState() {
    super.initState();
    getAllJokes();
  }

  FetchJokes fetchJokes =
      FetchJokes("https://bdjokesapi.herokuapp.com/jokes/random");

  getAllJokes() async {
    var allJokes = await fetchJokes.getJokes();
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return JokePage(jsonDecode(allJokes.toString()));
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: neoDarkShadow,
      body: Center(
        child: SpinKitChasingDots(
          color: neoWhite,
          size: 100.0,
        ),
      ),
    );
  }
}
