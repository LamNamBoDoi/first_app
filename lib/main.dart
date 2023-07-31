import 'dart:async';

import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: FutureWidget(),
    );
  }
}

class FutureWidget extends StatefulWidget {
  const FutureWidget({super.key});

  @override
  State<FutureWidget> createState() => _FutureWidgetState();
}

class _FutureWidgetState extends State<FutureWidget> {
  StreamController<String> timerStreamController = StreamController<String>();

  void initState() {
    Stream.periodic(Duration(seconds: 1), (value) {
      return value;
    }).take(10).listen((event) {
      timerStreamController.sink.add(event.toString());
      if (event == 9) timerStreamController.close();
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder(
                stream: timerStreamController.stream,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text(
                      snapshot.error.toString(),
                      style: TextStyle(fontSize: 40),
                    );
                  }
                  switch (snapshot.connectionState) {
                    case ConnectionState.none:
                      return Text('Not connected to the Stream or null');
                    case ConnectionState.waiting:
                      return Text('Awaiting interaction');
                    case ConnectionState.active:
                      return Text(
                        '${snapshot.data}',
                        style: TextStyle(fontSize: 40),
                      );
                    case ConnectionState.done:
                      return Text('Stream has finished');
                    default:
                      return Text('');
                  }
                }),
          ],
        ),
      ),
    );
  }
}
