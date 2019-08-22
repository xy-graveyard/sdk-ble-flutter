import 'package:flutter/material.dart';
import 'package:sdk_ble_flutter/main.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'XYO SDK Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'XYO Flutter SDK Test Application'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var message = "";

  Future<bool> _startSentinel() async {
    final result = await XyoSdk.sentinel.start();
    message = result.toString();
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Padding(
          padding: EdgeInsets.all(5),
          child: ListView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(5),
                child: Container(
                  height: 100,
                  child: Text(message),
                ),
              ),
              MaterialButton(
                child: Text("Start Sentinel"),
                color: Colors.blue,
                textColor: Colors.white,
                padding: EdgeInsets.all(5),
                onPressed: _startSentinel,
              )
            ],
          ),
        ));
  }
}
