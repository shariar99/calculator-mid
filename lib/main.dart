import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Calculator(),
      theme: ThemeData(
        textTheme: const TextTheme(
          bodyText1: TextStyle(
            fontFamily: 'Calf', // Use the custom font family
            fontSize: 48.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String _output = '';

  void _onButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        _output = '';
      } else if (buttonText == '=') {
        _calculateResult();
      } else if (buttonText == '%') {
        _calculatePercentage();
      } else {
        _output += buttonText;
      }
    });
  }

  void _calculateResult() {
    try {
      double result = 0.0;
      List<String> operators = ['+', '-', '*', '/'];

      for (String operator in operators) {
        List<String> parts = _output.split(operator);
        if (parts.length == 2) {
          double num1 = double.parse(parts[0]);
          double num2 = double.parse(parts[1]);

          switch (operator) {
            case '+':
              result = num1 + num2;
              break;
            case '-':
              result = num1 - num2;
              break;
            case '*':
              result = num1 * num2;
              break;
            case '/':
              result = num1 / num2;
              break;
          }

          setState(() {
            _output = result.toString();
          });
          return;
        }
      }

      // If no operator is found, display an error.
      setState(() {
        _output = 'Error';
      });
    } catch (e) {
      setState(() {
        _output = 'Error';
      });
    }
  }

  void _calculatePercentage() {
    try {
      double input = double.parse(_output);
      double result = input / 100.0;
      setState(() {
        _output = result.toString();
      });
    } catch (e) {
      setState(() {
        _output = 'Error';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator id 201071012'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Container(
              alignment: Alignment.bottomRight,
              padding:
              const EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
              child: Text(
                _output,
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
          ),
          const Divider(),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                _buildRow(['7', '8', '9', '/']),
                _buildRow(['4', '5', '6', '*']),
                _buildRow(['1', '2', '3', '-']),
                _buildRow(['0', '.', '=', '+']),
                _buildRow(['%', 'C'], color: Colors.red), // Added '%' button
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(List<String> buttons, {Color? color}) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: buttons.map((buttonText) {
          return ElevatedButton(
            onPressed: () => _onButtonPressed(buttonText),
            style: ButtonStyle(
              backgroundColor: color != null
                  ? MaterialStateProperty.all<Color>(color)
                  : null,
            ),
            child: Text(
              buttonText,
              style: const TextStyle(fontSize: 24.0),
            ),
          );
        }).toList(),
      ),
    );
  }
}
