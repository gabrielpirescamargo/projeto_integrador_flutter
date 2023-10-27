import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final IconData icon;
  final Color color;
  final Color color2;
  final String title;
  final VoidCallback onPressed;

  const CustomButton({
    required this.icon,
    required this.color,
    required this.color2,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 160,
        height: 150,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 16,
              left: 16,
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: color2,
                  borderRadius: BorderRadius.circular(100),
                ),
                child: Icon(icon, size: 30, color: Colors.white),
              ),
            ),
            Positioned(
              bottom: 16,
              left: 16,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  DefaultTextStyle(
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontStyle: null,
                        color: const Color(0xff030303)),
                    child: Text(title),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
