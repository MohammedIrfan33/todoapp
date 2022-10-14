import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_basics/provider/sample.dart';
import 'package:provider_basics/provider/todo_opertaion.dart';
import 'package:provider_basics/provider/user.dart';
import 'package:provider_basics/registrations.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return
      // ChangeNotifierProvider(create: (context)=>Sample(),
      // single provider
      MultiProvider(providers: [
        ChangeNotifierProvider(create: (context)=>Sample()),
        ChangeNotifierProvider(create: (context)=>TodoOperations()),
        ChangeNotifierProvider(create: (context)=>User()),
      ],
      child:MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
       home: RegisterScreen(),
    )
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(' rebuild');
    return Scaffold(
      appBar: AppBar(

        title: const Text('counter'),
      ),
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
          Consumer<Sample>(builder: (context,value,child){
            print('rebuil text widget');
            return Text(value.counter.toString());
          })
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:(){
          Provider.of<Sample>(context,listen: false).counterIncrement();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

