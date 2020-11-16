import 'dart:io';

import 'package:covid19/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  List<Widget> _text = [];
  final GlobalKey<AnimatedListState> _key = GlobalKey<AnimatedListState>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _addText();
    });
    Future.delayed(Duration(milliseconds: 3500), () {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => HomeScreen(),

        ),
      );
    });
  }

  void _addText() {
    List<String> _texts = [
      'CORONA VIRUS',
      '#STAY HOME',
      '#STAY SAFE',
    ];
    Future ft = Future(() {});
    _texts.forEach((i) {
      ft = ft.then(
        (_) {
          return Future.delayed(
            const Duration(milliseconds: 600),
            () {
              _text.add(_buildText(i));
              _key.currentState.insertItem(_text.length - 1);
            },
          );
        },
      );
    });
  }

  Widget _buildText(String text) {
    return Column(
      children: <Widget>[
        Text(
          text,
          style: GoogleFonts.robotoSlab(
            textStyle: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 10),
      ],
    );
  }

  Tween<Offset> _offset = Tween(begin: Offset(0, 9), end: Offset(0, 0));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF101a35),
      body: SafeArea(
        child: Container(
          color: Color(0xFF101a35).withOpacity(0.6),
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.5,
                child: Image.asset('assets/images/corona.png', fit: BoxFit.cover,),
              ),
              SizedBox(height: 30),
              Expanded(
                child: Container(
                  width: double.infinity,
                  child: AnimatedList(
                    scrollDirection: Axis.vertical,
                    key: _key,
                    initialItemCount: _text.length,
                    itemBuilder: (context, index, animation) {
                      return SlideTransition(
                        child: _text[index],
                        position: animation.drive(_offset),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
