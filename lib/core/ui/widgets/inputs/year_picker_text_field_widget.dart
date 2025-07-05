import 'package:auto_fin/core/ui/widgets/inputs/custom_text_field.dart';
import 'package:flutter/material.dart';

class YearPickerTextField extends StatefulWidget {
  final TextEditingController controller;
  final int startYear;
  final int endYear;
  final double height;
  final Function(int)? onYearSelected;

  const YearPickerTextField({
    super.key,
    required this.controller,
    this.startYear = 1990,
    this.endYear = 2030,
    this.height = 45,
    this.onYearSelected,
  });

  @override
  State<YearPickerTextField> createState() => _YearPickerTextFieldState();
}

class _YearPickerTextFieldState extends State<YearPickerTextField> {
  void _showYearPicker() async {
    int? picked = await showDialog<int>(
      context: context,
      builder: (context) {
        int selectedYear = DateTime.now().year;

        return AlertDialog(
          title: Text('Chọn năm'),
          content: SizedBox(
            height: 250,
            width: 300,
            child: YearPicker(
              firstDate: DateTime(widget.startYear),
              lastDate: DateTime(widget.endYear),
              selectedDate: DateTime(selectedYear),
              onChanged: (dateTime) {
                Navigator.pop(context, dateTime.year);
              },
            ),
          ),
        );
      },
    );

    if (picked != null) {
      widget.controller.text = picked.toString();
      widget.onYearSelected?.call(picked);
      setState(() {}); // Update UI if needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _showYearPicker,
      child: AbsorbPointer(
        child: CustomTextField(
          controller: widget.controller,
          hintText: 'Chọn năm',
          suffixIcon: const Icon(Icons.arrow_drop_down),
          backgroundColor: Colors.white,
          height: widget.height,
        ),
      ),
    );
  }
}
