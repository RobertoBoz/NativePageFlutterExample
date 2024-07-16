import 'package:flutter/material.dart';

class SecondPantalla extends StatelessWidget {
  const SecondPantalla({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Pantalla 2'),
        ),
        body: MaterialButton(
          color: Colors.amber,
          onPressed: () {
          
          Navigator.pushNamedAndRemoveUntil(
            context,
            '1',
            (Route<dynamic> route) => false,
          );
        }));
  }
}
