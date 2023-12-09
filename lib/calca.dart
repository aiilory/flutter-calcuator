

import 'package:ailana_calca/btn.dart';
import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String number1 = '';
  String operand = '';
  String number2 = '';
  var answear = ' ';
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              reverse: true,
              child: Padding(
                padding: EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      '$number1$operand$number2'.isEmpty
                          ? '0'
                          : '$number1$operand$number2',
                      style: TextStyle(color: Colors.white, fontSize: 45),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Wrap(
              children: Btn.btnValues
                  .map((value) => SizedBox(
                      height: screenSize.height / 10,
                      width: value == Btn.num0
                          ? screenSize.width / 2
                          : screenSize.width / 4,
                      child: ButtonCustome(value)))
                  .toList(),
            ),
          )
        ],
      ),
    );
  }

  Widget ButtonCustome(value) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        clipBehavior: Clip.hardEdge,
        color: [Btn.clear, Btn.del, Btn.per].contains(value)
            ? Colors.redAccent
            : [Btn.plus, Btn.minus, Btn.divide, Btn.multiply].contains(value)
                ? Colors.yellowAccent
                : Btn.eqaual == value
                    ? Colors.blue
                    : Colors.pinkAccent,
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),
            borderSide: BorderSide(color: Colors.transparent)),
        child: InkWell(
          onTap: () {
            tapping(value);
          },
          child: Center(
              child: Text(
            value,
            style: TextStyle(
                fontSize: 20,
                color: [Btn.plus, Btn.minus, Btn.divide, Btn.multiply]
                        .contains(value)
                    ? Colors.black
                    : Colors.white),
          )),
        ),
      ),
    );
  }

  void tapping(String value) {
    if (value == Btn.del) {
      delete();
      return;
    }

    if (value == Btn.clear) {
      clear();
      return;
    }
    if (value == Btn.per) {
      percentage();
      return;
    }

    if (value == Btn.eqaual) {
      equality();
      return;
    }

    join(value);

  }

   void equality() {
    if (number1.isEmpty || number2.isEmpty || operand.isEmpty) {
      return;
    } else if (operand.isNotEmpty && number2.isNotEmpty) {
      double num1 = double.parse(number1);
      double num2 = double.parse(number2);
      double result = 0.0;
      switch (operand) {
        case Btn.plus:
          result = num1 + num2;
          break;
        case Btn.minus:
          result = num1 - num2;
          break;
        case Btn.multiply:
          result = num1 * num2;
          break;
        case Btn.divide:
          result = num1 / num2;
          break;
        default:
      }

      
      setState(() {
        if (number1.endsWith('.0')) {
          number1 = number1.substring(0, number1.length - 2);
        }
        number1 = '$result';
        operand = '';
        number2 = '';
      });
    }
  }

  void percentage() {
    if (number1.isNotEmpty && operand.isNotEmpty && number2.isNotEmpty) {
      equality();
      return; //jwidwidiwd
    }

    if (operand.isNotEmpty) {
      return;
    }
    final number = double.parse(number1);

    setState(() {
      number1 = '${(number / 100)}';
    });
  }
  void clear() {
    number1 = '';
    operand = '';
    number2 = '';
    
    setState(() {});
  }
  void delete() {
    if (number1.isNotEmpty && operand.isEmpty) {
      number1 = number1.substring(0, number1.length - 1);
    } else if (number2.isNotEmpty && operand.isNotEmpty) {
      number2 = number2.substring(0, number2.length - 1);
    } else if (number1.isNotEmpty && operand.isNotEmpty && number2.isEmpty) {
      operand = '';
    }
    setState(() {});
  }

  void join(String value) {
     if (value != Btn.dot && int.tryParse(value) == null) {
      operand = value;
      // if (operand.isNotEmpty && number2.isNotEmpty) {
      //   equal();
      // }
    } else if (number1.isEmpty || operand.isEmpty) {
      if (value == Btn.dot && number1.contains(Btn.dot)) {
        return;
      }
      if (value == Btn.dot && number1.isEmpty || number1 == Btn.dot) {
        value = '0.';
      }
      number1 += value;
    } else if (number2.isEmpty || operand.isNotEmpty) {
      if (value == Btn.dot && number2.contains(Btn.dot)) {
        return;
      }
      if (value == Btn.dot && number2.isEmpty || number2 == Btn.dot) {
        value = '0.';
      }
      number2 += value;
    }
    setState(() {});
  }
}
