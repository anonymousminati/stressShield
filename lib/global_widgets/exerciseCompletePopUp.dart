import 'package:flutter/material.dart';

class ShowDialogPopup {
  void showImageAlertDialog(
    BuildContext context,
    String imagePath,
    String title,
    String description,
    VoidCallback onPressed,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // Image.asset(
              //   imagePath,
              //   width: 150, // Adjust image width as needed
              // ),
              // SizedBox(height: 16), // Adjust spacing as needed
              // Text(description),
              Card(
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    Image.asset(imagePath),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4F3422),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        description,
                        style: TextStyle(color: Colors.black.withOpacity(0.6)),
                      ),
                    ),
                    //create a button with text "Great. Thanks!" with color white and background color 0xFF4F3422
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: Color(0xFF4F3422),
                        borderRadius: BorderRadius.circular(
                            50), // Adjust corner radius as needed
                      ),
                      child: TextButton.icon(
                        onPressed: onPressed,
                        style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(
                              Colors.white), // Icon color
                        ),
                        icon: Icon(
                          Icons.check,
                          color: Colors.white, // Icon color
                        ),
                        label: Text(
                          'Great. Thanks!',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
