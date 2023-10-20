import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

import '../widgets/calculator_button.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({Key? key}) : super(key: key);

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String equation = "0";
  String result = "0";
  String expression = "";

  buttonPressed(String buttonText) {
    String doesContainDecimal(dynamic result) {
      if (result.toString().contains('.')) {
        List<String> splitDecimal = result.toString().split('.');
        if (!(int.parse(splitDecimal[1]) > 0)) {
          return result = splitDecimal[0].toString();
        }
      }
      return result;
    }

    setState(() {
      if (buttonText == "AC") {
        equation = "0";
        result = "0";
      } else if (buttonText == "⌫") {
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "0";
        }
      } else if (buttonText == "+/-") {
        if (equation[0] != '-') {
          equation = '-$equation';
        } else {
          equation = equation.substring(1);
        }
      } else if (buttonText == "=") {
        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');

        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);

          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
          if (expression.contains('%')) {
            result = doesContainDecimal(result);
          }
        } catch (e) {
          result = "Error";
        }
      } else {
        if (equation == "0") {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Align(
              alignment: Alignment.bottomRight,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.only(right: 22),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          result,
                          textAlign: TextAlign.left,
                          style: const TextStyle(color: Colors.black, fontSize: 80),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Text(
                          equation,
                          style: const TextStyle(
                            fontSize: 40,
                            color: Colors.black26,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcButton('÷', const Color(0xFFA0A0A0), () => buttonPressed('÷')),
                calcButton("×", const Color(0xFFA0A0A0), () => buttonPressed('×')),
                calcButton('-', const Color(0xFFA0A0A0), () => buttonPressed('-')),
                calcButton('+', const Color(0xFFA0A0A0), () => buttonPressed('+')),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcButton('7', const Color(0xFF2D2D2D), () => buttonPressed('7')),
                calcButton('8', const Color(0xFF2D2D2D), () => buttonPressed('8')),
                calcButton('9', const Color(0xFF2D2D2D), () => buttonPressed('9')),
                calcButton('AC', const Color(0xFFA0A0A0), () => buttonPressed('AC')),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcButton('4', const Color(0xFF2D2D2D), () => buttonPressed('4')),
                calcButton('5', const Color(0xFF2D2D2D), () => buttonPressed('5')),
                calcButton('6', const Color(0xFF2D2D2D), () => buttonPressed('6')),
                calcButton('⌫', const Color(0xFFA0A0A0), () => buttonPressed('⌫')),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        calcButton('1', const Color(0xFF2D2D2D), () => buttonPressed('1')),
                        SizedBox(width: MediaQuery.of(context).size.width * 0.04),
                        calcButton('2', const Color(0xFF2D2D2D), () => buttonPressed('2')),
                        SizedBox(width: MediaQuery.of(context).size.width * 0.04),
                        calcButton('3', const Color(0xFF2D2D2D), () => buttonPressed('3')),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        calcButton('0', const Color(0xFF2D2D2D), () => buttonPressed('0')),
                        SizedBox(width: MediaQuery.of(context).size.width * 0.04),
                        calcButton('.', const Color(0xFF2D2D2D), () => buttonPressed('.')),
                      ],
                    ),
                  ],
                ),
                calcButton('=', Colors.deepPurpleAccent, () => buttonPressed('=')),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
