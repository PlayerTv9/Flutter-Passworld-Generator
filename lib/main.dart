import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Passworld generator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const String letters = "QWERTYUIOPASDFGHJKLZXCVBNM";
  static const String numbers = "1234567890";
  static const String symbol = "!£%&/()=*+§ù°à#çò@éè€-_";

  double sliderValue = 5;

  String pass = "";
  var secureRandom = Random.secure();


  void createPassworld(){
    String passworld = "";
    for(int i = 0; i < sliderValue; i++){
      int choice = 1 + secureRandom.nextInt(3);
      switch(choice){
        case 1:
          int secondChoice = secureRandom.nextInt(letters.length);
          bool isCapsLetter = secureRandom.nextBool();
          isCapsLetter == false ? passworld+=letters[secondChoice].toLowerCase() : passworld+=letters[secondChoice];
          break;
        case 2:
          int secondChoice = secureRandom.nextInt(numbers.length);
          passworld += numbers[secondChoice];
          break;
        case 3:
          int secondChoice = secureRandom.nextInt(symbol.length);
          passworld += symbol[secondChoice];
          break;

      }
    }
    setState(() {
      pass = passworld;
    });

  }

  void copyClipboard(){
    Clipboard.setData(ClipboardData(text: pass));
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Align(
              alignment: Alignment.center,
              child: const Text(
                  "Passworld Generator",
                  style: TextStyle(fontSize: 30)),
            ),



           Slider(value: sliderValue,
               max:15,
               divisions: 15,
               label: sliderValue.round().toString(),
               onChanged: (double value){
                  setState(() {
                    sliderValue = value;
                  });
               }),
            Text("Passworld generata: $pass",style: TextStyle(fontSize: 15)),

            ElevatedButton(onPressed: copyClipboard,
              child: Text("Copia negli appuni"),

            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createPassworld,
        tooltip: 'Genera passworld',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
