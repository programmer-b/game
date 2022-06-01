import 'package:flutter/material.dart';
import 'package:game/utils/number_validator.dart';

class EditGuess extends StatelessWidget {
  const EditGuess({Key? key, required this.controller}) : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    bool hasRepeatedDigits = false;
    return TextFormField(
      controller: controller,
      validator: (value) {
        hasRepeatedDigits = false;
        if (value!.isEmpty) {
          return 'Please enter a number';
        } else {
          if (value.length == 3) {
            if (NumberValidator.isNumeric(value)) {
              var input = value;
              var chars = input.toLowerCase().split('');
              var counts = <String, int>{};
              for (var char in chars) {
                counts[char] = (counts[char] ?? 0) + 1;
              }
              for (var value in counts.values) {
                if (value > 1) {
                  hasRepeatedDigits = true;
                }
              }

              if (hasRepeatedDigits) {
                return 'Invalid! Repeated digits not allowed';
              }
            } else {
              return 'Invalid! Only numbers allowed';
            }
          } else {
            return 'Invalid! Must be 3 digits';
          }
        }
        return null;
      },
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        hintText: 'Enter your guess (3 digits)',
        suffixIcon: _suffixIcon(controller),
        hintStyle: const TextStyle(
          fontSize: 20,
        ),
      ),
      style: const TextStyle(
        fontSize: 20,
      ),
    );
  }
}

Widget _suffixIcon(TextEditingController controller) {
  return IconButton(
    icon: const Icon(
      Icons.cancel,
      color: Colors.black54,
    ),
    onPressed: () {
      controller.clear();
    },
  );
}
