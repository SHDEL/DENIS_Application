import 'package:denis/presentation/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';


class PrimaryInput extends StatefulWidget {
  @Preview(name: 'Primary Input')
  final String text;
  final TextEditingController? controller;
  final bool isPassword;
  const PrimaryInput({
    required this.text,
    this.controller,
    this.isPassword = false,
    super.key
  });
  
  @override
  State<PrimaryInput> createState() => _PrimaryInputState();
}

class _PrimaryInputState extends State<PrimaryInput> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    // ค่าเริ่มต้นเอามาจาก widget.isPassword ที่ส่งมาจากหน้า Sign In
    _obscureText = widget.isPassword;
  }
  
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: _obscureText,
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
        labelText: widget.text,
        // เพิ่มไอคอนรูปตา ถ้ากำหนด isPassword ให้แสดงไอคอนเปิด/ปิดรหัสผ่าน
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  color: AppTheme.lightTheme.primaryColor,
                ),
                onPressed: () {
                  // ถ้ากดให้สลับสถานะ
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : null,
      ),
    );
  }
}