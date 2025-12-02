import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: Calculator());
  }
}

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String input = "";
  String output = "";

  void buttonPressed(String value) {
    setState(() {
      if (value == "C") {
        input = "";
        output = "";
      } else if (value == "⌫") {
        if (input.isNotEmpty) {
          input = input.substring(0, input.length - 1);
        }
      } else if (value == "=") {
        try {
          String finalInput = input;
          finalInput = finalInput.replaceAll("×", "*");
          finalInput = finalInput.replaceAll("÷", "/");

          Parser p = Parser();
          Expression exp = p.parse(finalInput);
          ContextModel cm = ContextModel();
          double eval = exp.evaluate(EvaluationType.REAL, cm);

          output = eval.toString();
        } catch (e) {
          output = "ERROR";
        }
      } else {
        input += value;
      }
    });
  }

  Widget buildButton(String text, {Color color = Colors.black}) {
    return Expanded(
      child: InkWell(
        onTap: () => buttonPressed(text),
        child: Container(
          height: 70,
          alignment: Alignment.center,
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            text,
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      reverse: true, // Keeps bottom text visible
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(input, style: TextStyle(fontSize: 32)),
                          SizedBox(height: 10),
                          Text(
                            output,
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // BUTTONS
          Column(
            children: [
              Row(
                children: [
                  buildButton("C"),
                  buildButton("⌫"),
                  buildButton("%"),
                  buildButton("÷"),
                ],
              ),
              Row(
                children: [
                  buildButton("7"),
                  buildButton("8"),
                  buildButton("9"),
                  buildButton("×"),
                ],
              ),
              Row(
                children: [
                  buildButton("4"),
                  buildButton("5"),
                  buildButton("6"),
                  buildButton("-"),
                ],
              ),
              Row(
                children: [
                  buildButton("1"),
                  buildButton("2"),
                  buildButton("3"),
                  buildButton("+"),
                ],
              ),
              Row(
                children: [
                  buildButton("0"),
                  buildButton("."),
                  buildButton("("),
                  buildButton(")"),
                ],
              ),
              Row(children: [buildButton("=")]),
            ],
          ),
        ],
      ),
    );
  }
}
