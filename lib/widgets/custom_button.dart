import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {

  const CustomButton({
    super.key, 
    required this.buttonText, 
    required this.icon, 
    required this.onPressed, 
    required this.width, 
    required this.height, 
    required this.customFontSize, 
    required this.color,
  });

  final String buttonText;
  final IconData icon;
  final VoidCallback onPressed;
  final double width;
  final double height;
  final double customFontSize;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(25),
          // gradient: const LinearGradient(
          //   begin: Alignment.topLeft,
          //   end: Alignment.bottomRight,
          //   colors: [
          //     Color.fromARGB(255, 39,175,97),
          //     Color.fromARGB(255, 38, 167, 94),
          //   ],
          // ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: const Color.fromARGB(255, 172,202,58),
            ),
            const SizedBox(width: 10),
            Text(
              buttonText,
              style: TextStyle(
                fontSize: customFontSize,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 172,202,58),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
