import 'package:flutter/material.dart';

typedef onsave(String value);

class CustomTextField extends StatelessWidget {
  final String hintText;
  final Color fillColor;
  final TextInputType keyboardType;
  final bool isSearch;
  final TextEditingController controller;

  final onsave onValidator;
  final onsave onSave;

  CustomTextField(
      {this.hintText,
      this.fillColor,
      this.controller,
      this.keyboardType,
      this.isSearch = false,
      this.onSave,
      this.onValidator});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: fillColor,
      ),
      child: TextFormField(
        controller: controller,
        onSaved: (value) => onSave(value),
        validator: (value) => onValidator(value),
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelStyle:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
          labelText: hintText,
          fillColor: fillColor,
          suffixIcon: isSearch ? Icon(Icons.search) : Text(''),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.green),
            borderRadius: BorderRadius.circular(15),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }
}
