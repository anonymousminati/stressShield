import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CarouselWithTigerIndicator extends StatefulWidget {
  final String detectedLabel; // Add detectedLabel parameter
  const CarouselWithTigerIndicator({Key? key, required this.detectedLabel}) : super(key: key);

  @override
  _CarouselWithTigerIndicatorState createState() => _CarouselWithTigerIndicatorState();
}

class _CarouselWithTigerIndicatorState extends State<CarouselWithTigerIndicator> {
  int _currentIndex = 0;
  final CarouselController _carouselController = CarouselController();
  List<String> _imageUrls = []; // List to store fetched image URLs

  @override
  void initState() {
    super.initState();
    fetchCarouselImages(); // Fetch images when widget initializes
  }

  Future<void> fetchCarouselImages() async {
    try {
      final querySnapshot = await FirebaseFirestore.instance
          .collection('emotions') // Collection containing animal images
          .doc(widget.detectedLabel.toLowerCase()) // Document ID is the detected label
          .get();

      if (querySnapshot.exists) {
        final List<dynamic>? images = querySnapshot['images']; // Assuming 'images' is the array field name

        if (images != null && images.isNotEmpty) {
          final List<String> urls = images.cast<String>().toList();

          setState(() {
            _imageUrls = urls;
          });
        } else {
          print('No images found for label: ${widget.detectedLabel}');
        }
      } else {
        print('Document does not exist for label: ${widget.detectedLabel}');
      }
    } catch (e) {
      print('Error fetching carousel images: $e');
    }
  }



  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          widget.detectedLabel.toUpperCase(),
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontFamily: 'SF Pro',
            fontSize: 15,
          ),
        ),
        SizedBox(height: 10),
        CarouselSlider(
          carouselController: _carouselController,
          options: CarouselOptions(
            height: 200.0,
            enlargeCenterPage: true,
            aspectRatio: 16 / 9,
            autoPlayCurve: Curves.fastOutSlowIn,
            enableInfiniteScroll: true,
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            viewportFraction: 0.83,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          items: _imageUrls.map((imageUrl) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  margin: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: Colors.white, width: 0.5),
                    image: DecorationImage(
                      image: NetworkImage(imageUrl),
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),
        SizedBox(height: 20),
        AnimatedSmoothIndicator(
          activeIndex: _currentIndex,
          count: _imageUrls.length,
          effect: const ExpandingDotsEffect(
            dotWidth: 15.0,
            dotHeight: 5.0,
            activeDotColor: Colors.white,
          ),
        ),
      ],
    );
  }
}