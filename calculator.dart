import 'package:flutter/material.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  String inputValue = '';
  String result = '';
  String operator = '';

  Widget build(BuildContext context) {
    double size = MediaQuery.of(context).size.width / 5;
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Column(
              children: [
                Container(
                  alignment: Alignment.centerRight,
                  child: Text(
                    inputValue, style: TextStyle(color: Colors.white, fontSize: 80),
                  ),
                ),
                Row(                  
                  children: [
                    calcButton('7', const Color.fromARGB(255, 71, 71, 71), size),
                    calcButton('8', const Color.fromARGB(255, 71, 71, 71), size),
                    calcButton('9', const Color.fromARGB(255, 71, 71, 71), size),
                    calcButton('/', Colors.orange, size),
                  ],
                ),
                Row(                  
                  children: [
                    calcButton('4', const Color.fromARGB(255, 71, 71, 71), size),
                    calcButton('5', const Color.fromARGB(255, 71, 71, 71), size),
                    calcButton('6', const Color.fromARGB(255, 71, 71, 71), size),
                    calcButton('x', Colors.orange, size),
                  ],
                ),
                Row(                  
                  children: [
                    calcButton('1', const Color.fromARGB(255, 71, 71, 71), size),
                    calcButton('2', const Color.fromARGB(255, 71, 71, 71), size),
                    calcButton('3', const Color.fromARGB(255, 71, 71, 71), size),
                    calcButton('-', Colors.orange, size),
                  ],
                ),
                Row(                  
                  children: [
                    calcButton('0', const Color.fromARGB(255, 71, 71, 71), size),
                    calcButton('.', const Color.fromARGB(255, 71, 71, 71), size),
                    calcButton('=', Colors.orange, size),
                    calcButton('+', Colors.orange, size),
                  ],
                ),
                calcButton("clear", Colors.black, size)
              ],
            )
          ],
        ),
        ),
      );
  }

  Widget calcButton(String text, Color bgColor, double size) {
    return InkWell(
      onTap: (){
        if(text == "clear"){
          setState(() {
            inputValue = '';
            result = '';
            operator = '';
          });
        }
        else if(text == '+' || text == '-' || text == 'x' || text == '/'){
          setState(() {
            result = inputValue;
            inputValue = '';
            operator = text;
          });
        }
        else if(text == '='){
          setState(() {
            double input = double.parse(inputValue);
            double calc = double.parse(result);

            if(operator == '+'){
              inputValue = (calc + input).toString();
              calc = double.parse(inputValue);
            }
            else if(operator == '-'){
              inputValue = (calc - input).toString();
              calc = double.parse(inputValue);
            }
            else if(operator == 'x'){
              inputValue = (calc * input).toString();
              calc = double.parse(inputValue);
            }
            else{
              inputValue = (calc / input).toString();
              calc = double.parse(inputValue);
            }
          });
        }
        else{
          setState(() {          
            inputValue += text;
          });
        }
      },
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(100),
        ),
        margin: EdgeInsets.all(10),
        height: size,
        width: size,
        child: Text(text, 
        style: TextStyle(color: Colors.white, fontSize: 25), ),
      ),
    );
  }
}