import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DynamicCard extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final String onPress;

  const DynamicCard({
    required this.image,
    required this.title,
    required this.description,
    required this.onPress,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, onPress);
      },
      child: Card(
        // Set the shape of the card using a rounded rectangle border with a 8 pixel radius
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        // Set the clip behavior of the card
        clipBehavior: Clip.antiAliasWithSaveLayer,
        // Define the child widgets of the card
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Display an image at the top of the card that fills the width of the card and has a height of 160 pixels
            Image.asset(
              image,
              height: 160,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            // Add a container with padding that contains the card's title, text, and buttons
            Container(
              padding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Display the card's title using a font size of 24 and a dark grey color
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.grey[800],
                    ),
                  ),
                  // Add a space between the title and the text
                  Container(height: 10),
                  // Display the card's text using a font size of 15 and a light grey color
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          softWrap: true,
                          description,
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                      //create a Icon Button with next arrow and make it round
                      Container(
                        width: 50.0,
                        height: 50.0,
                        padding: EdgeInsets.all(2.0),
                        // Adjust padding as needed
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.0),
                          border: Border.all(
                            color: Colors.grey,
                            width: 1.0,
                          ),
                        ),
                        child: IconButton(
                          onPressed: (){
                            Navigator.pushNamed(context, onPress);
                            print("Pressed");

                            // Navigate to the article page
                                             },
                          icon: Icon(
                            Icons.arrow_forward,
                            size: 24.0,
                            color: Colors.grey,
                          ),
                          splashRadius:
                          24.0, // Adjust the splash radius as needed
                        ),
                      ),
                    ],
                  ),

                ],
              ),
            ),
            Container(height: 10),
          ],
        ),
      ),
    );
  }
}
