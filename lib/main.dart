import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pchostinnativepage/after_first_layout_mixin.dart';
import 'package:pchostinnativepage/fl_plugin_imports.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with AfterFirstLayoutMixin<MyHomePage> {
  int _counter = 0;
 late StreamSubscription<dynamic> _streamSubscription;



  void _handleCityChanges() {
   final eventChannel = EventChannel('channel/counter');
     _streamSubscription = eventChannel.receiveBroadcastStream().listen(
      (data) {
        setState(() {
          _counter = _counter + data as int;
        });
      });
  
  }



  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(
    
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: 
            [
              Container(
                height: 300,
                width: 300,
                child: NativePage()
              ),
            ],
          ),
          SizedBox(height: 20),
          Text( '$_counter', style: Theme.of(context).textTheme.headlineMedium,),
          MaterialButton(
            color: Colors.amber,
            onPressed: (){_streamSubscription.cancel();}, 
            child: Text('Cancelar stream'),
          ),

          MaterialButton(
            color: Colors.amber,
            onPressed: _handleCityChanges, 
            child: Text('Iniciar stream'),
          )

        ],
        
      ),
      
      
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          setState(() {
            _counter++;
          });
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  @override
  FutureOr<void> onAfterFirstLayout() {
    _handleCityChanges();
  }
}
