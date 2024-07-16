import 'package:bookingengine_frontend/gen/fonts.gen.dart';
import 'package:flutter/material.dart';

class ImgSlideDialog extends StatefulWidget {
  const ImgSlideDialog({super.key});

  @override
  State<ImgSlideDialog> createState() => _ImgSlideDialogState();
}

class _ImgSlideDialogState extends State<ImgSlideDialog> {
  final List<String> imageUrls = [
    'https://firebasestorage.googleapis.com/v0/b/neutron-pms.appspot.com/o/img_booking_engine%2Fanh1.jpg?alt=media&token=932859eb-ec17-434e-b933-4ef3089c9cee',
    'https://firebasestorage.googleapis.com/v0/b/neutron-pms.appspot.com/o/img_booking_engine%2Fanh2.jpg?alt=media&token=22459229-f0b1-4d3f-8420-a384a04aac7b',
    'https://firebasestorage.googleapis.com/v0/b/neutron-pms.appspot.com/o/img_booking_engine%2Fanh3.jpg?alt=media&token=a59b4053-f328-4fb1-8e27-e81b1dd8da9f',
    'https://firebasestorage.googleapis.com/v0/b/neutron-pms.appspot.com/o/img_booking_engine%2Fanh4.jpg?alt=media&token=a7a232f5-9c67-4278-8418-d4a6a524cc74',
    'https://firebasestorage.googleapis.com/v0/b/neutron-pms.appspot.com/o/img_booking_engine%2Fanh5.jpg?alt=media&token=86296279-4f66-47e7-a98f-eb5793ad3c5b'
  ];
  final List<String> nameImg = [
    'Phòng Ốc',
    'Phòng Tắm',
    'Giường',
    'Cảnh Quan',
    'View'
  ];
  int currentIndex = 0;
  PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.black,
      child: Stack(
        children: [
          SizedBox(
            width: double.infinity,
            height: 600,
            child: PageView.builder(
              controller: pageController,
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemCount: imageUrls.length,
              itemBuilder: (context, index) {
                return Image.network(
                  imageUrls[index],
                );
              },
            ),
          ),
          Positioned(
            top: 250,
            left: 20,
            child: Center(
              child: Container(
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.white),
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    if (currentIndex == 0) {
                      currentIndex = imageUrls.length - 1;
                      pageController.animateToPage(
                        currentIndex,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                      return;
                    }
                    if (currentIndex > 0) {
                      currentIndex--;
                      pageController.animateToPage(
                        currentIndex,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                ),
              ),
            ),
          ),
          Positioned(
            top: 250,
            right: 20,
            child: Container(
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.white),
              child: Center(
                child: IconButton(
                  icon:
                      const Icon(Icons.arrow_forward_ios, color: Colors.black),
                  onPressed: () {
                    if (currentIndex == imageUrls.length - 1) {
                      currentIndex = 0;
                      pageController.animateToPage(
                        currentIndex,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                      return;
                    }
                    if (currentIndex < imageUrls.length - 1) {
                      currentIndex++;

                      pageController.animateToPage(
                        currentIndex,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                ),
              ),
            ),
          ),
          Positioned(
              bottom: 20,
              right: 20,
              child: Text(
                '${currentIndex + 1}/${imageUrls.length}',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: FontFamily.aria),
              )),
          Positioned(
              bottom: 20,
              left: 20,
              child: Text(
                nameImg[currentIndex],
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: FontFamily.aria),
              )),
          Positioned(
            top: 20,
            right: 20,
            child: Container(
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.white),
              child: Center(
                child: IconButton(
                  icon: const Icon(Icons.close, color: Colors.black),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
