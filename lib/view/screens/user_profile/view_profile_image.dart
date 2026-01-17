import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewProfileImage extends StatelessWidget {
  final String imageSource;

  const ViewProfileImage({Key? key, required this.imageSource})
    : super(key: key);

  // Determine the type of image source
  ImageProvider _getImageProvider() {
    // Check if it's a network URL
    if (imageSource.startsWith('http://') ||
        imageSource.startsWith('https://')) {
      return NetworkImage(imageSource);
    }
    // Check if it's a file path
    else if (imageSource.startsWith('/')) {
      return FileImage(File(imageSource));
    }
    // Otherwise, treat it as an asset path
    else {
      return AssetImage(imageSource);
    }
  }

  Widget _buildImage() {
    // Check if it's a network URL
    if (imageSource.startsWith('http://') ||
        imageSource.startsWith('https://')) {
      return Image.network(
        imageSource,
        fit: BoxFit.contain,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: CircularProgressIndicator(
              value:
                  loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
              color: Colors.white,
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return const Center(
            child: Icon(Icons.error_outline, color: Colors.white, size: 50),
          );
        },
      );
    }
    // Check if it's a file path
    else if (imageSource.startsWith('/')) {
      return Image.file(
        File(imageSource),
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return const Center(
            child: Icon(Icons.error_outline, color: Colors.white, size: 50),
          );
        },
      );
    }
    // Otherwise, treat it as an asset path
    else {
      return Image.asset(
        imageSource,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return const Center(
            child: Icon(Icons.error_outline, color: Colors.white, size: 50),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            // Full screen image with pinch to zoom
            Center(
              child: InteractiveViewer(
                minScale: 0.5,
                maxScale: 4.0,
                child: _buildImage(),
              ),
            ),

            // Close button
            Positioned(
              top: 16,
              right: 16,
              child: GestureDetector(
                onTap: () => Get.close(1),
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.close, color: Colors.white, size: 28),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Example usage:
// Get.to(() => ViewProfileImage(imageSource: 'https://example.com/profile.jpg'));
// Get.to(() => ViewProfileImage(imageSource: '/storage/emulated/0/image.jpg'));
// Get.to(() => ViewProfileImage(imageSource: 'assets/images/profile.png'));
