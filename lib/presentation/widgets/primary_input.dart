import 'package:DENIS/presentation/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';


class PrimaryInput extends StatelessWidget {
  @Preview(name: 'Primary Input')
  const PrimaryInput({super.key});
  
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          borderSide: BorderSide(color: AppTheme.lightTheme.primaryColor, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          borderSide: BorderSide(color: AppTheme.lightTheme.primaryColor, width: 2),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          borderSide: BorderSide(color: AppTheme.lightTheme.primaryColor, width: 2),
        ),
        labelStyle: TextStyle(color: AppTheme.lightTheme.primaryColor),
        labelText: 'Username',
      ),
    );  
  }
}