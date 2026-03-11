import 'dart:ui';

import 'package:denis/presentation/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:gradient_elevated_button/gradient_elevated_button.dart';

class CategoryButton extends StatefulWidget {

  final int index;
  final String label;
  final bool isSelected;
  final VoidCallback? onTap;

  const CategoryButton({
    required this.index,
    required this.label,
    this.isSelected = false,
    this.onTap,
    super.key,
  });

  @override
  State<CategoryButton> createState() => _CategoryButtonState();
}

class _CategoryButtonState extends State<CategoryButton> {
  @override
  Widget build(BuildContext context) {
    if (widget.isSelected) {
      return GradientElevatedButton(
        onPressed: widget.onTap ?? () {},
        style: GradientElevatedButton.styleFrom(
          backgroundGradient: AppColors.gradprimary,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          foregroundColor: Colors.white,
          shadowColor: Colors.transparent,
        ),
        child: Text(
          widget.label,
          style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14),
        ),
      );
    }

    // Unselected — liquid glass / frosted glass
    return GestureDetector(
      onTap: widget.onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              color: Colors.white.withValues(alpha: 0.18),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.35),
                width: 1.2,
              ),
            ),
            child: Text(
              widget.label,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 14,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
    );
  }
}