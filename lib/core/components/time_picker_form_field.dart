import 'package:app/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TimePickerFormfield extends StatefulWidget {
  final Function validator;
  final String label;
  final TextEditingController timeController;
  const TimePickerFormfield({
    super.key,
    required this.validator,
    required this.label,
    required this.timeController,
  });

  @override
  State<TimePickerFormfield> createState() => _TimePickerFormfieldState();
}

class _TimePickerFormfieldState extends State<TimePickerFormfield> {
  TimeOfDay _selectedTime = TimeOfDay.now();

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = TimeOfDay(hour: picked.hour, minute: 0);
        widget.timeController.text = picked.format(context); // Formata a hora
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.timeController,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: StudieTheme.secondaryColor, width: 2),
        ),
        labelText: widget.label.tr,
        labelStyle: StudieTheme.textTheme.bodyMedium,
        suffixIcon: Icon(Icons.access_time),
      ),
      validator: (value) => widget.validator(_selectedTime),
      readOnly: true, // Impede a entrada manual
      onTap: () {
        _selectTime(context);
      },
    );
  }
}
