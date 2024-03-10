import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ReusableButton extends StatelessWidget {
  ReusableButton({
    Key? key,
    this.text,
    required this.onPressed,
    this.icon,
  }) : super(key: key);

  String? text;
  final Function onPressed;
  Icon? icon;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onPressed(),
      child: Container(
        constraints: BoxConstraints(
          minWidth: 0, // Allows the container to shrink to fit its child
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text ?? '',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontFamily: GoogleFonts.urbanist().fontFamily,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              width: 8.0,
            ),
            if (icon != null) icon!,
          ],
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF4E3321),
        padding: EdgeInsets.symmetric(
          horizontal: 24.0,
          vertical: 12.0,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40.0),
        ),
      ),
    );
  }
}
