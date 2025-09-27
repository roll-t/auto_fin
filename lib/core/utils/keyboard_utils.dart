import 'package:flutter/material.dart';

class KeyboardUtils {
  static void hiddenKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}

// class QuickNumberButton extends StatelessWidget {
//   final String value;
//   final TextEditingController controller;

//   const QuickNumberButton(this.value, this.controller);

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       style: ElevatedButton.styleFrom(
//         padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//         backgroundColor: AppThemeColors.primary,
//         foregroundColor: Colors.white,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//       ),
//       onPressed: () {
//         controller.text = controller.text + value;
//         controller.selection = TextSelection.fromPosition(
//           TextPosition(offset: controller.text.length),
//         );
//       },
//       child: Text(value, style: const TextStyle(fontSize: 14)),
//     );
//   }
// }
