import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  @override
  void initState() {
    
    super.initState();
  }

  void _handleCityChanges() {
   final eventChannel = EventChannel('channel/counter');
    eventChannel.receiveBroadcastStream().listen((data) {
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
        children: [
          Container(
            height: 200, 
            width: 400, color: Colors.red, child: Container( child: NativePage(),
          width: 100, height: 100, color: Colors.cyan,)),
          Text( '$_counter', style: Theme.of(context).textTheme.headlineMedium,),
        ],
        
      ),
      
      floatingActionButton: FloatingActionButton(
        onPressed: _handleCityChanges,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
