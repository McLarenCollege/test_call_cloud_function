import 'package:flutter/material.dart';
import 'package:cloud_functions/cloud_functions.dart';

final HttpsCallable callable = CloudFunctions.instance.getHttpsCallable(
  functionName: 'myCallFunc',
);

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Callable Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  String status = 'Haven''t run it yet';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Callable Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              status,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()async{

          setState(() {
            status = 'Sending Request';
          });


//          try {
            HttpsCallableResult resp = await callable.call();
            setState(() {
              status = 'Response: ${resp.data}';
            });
//          }
//          catch (e) {
//            print('${e.code} ${e.message} ${e.details}');
//          }
        },
        tooltip: 'Send',
        child: Icon(Icons.send),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
