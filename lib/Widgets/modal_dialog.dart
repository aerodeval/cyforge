import 'package:flutter/material.dart';

void imagePickerModal(BuildContext context,
    { VoidCallback? onGalleryTap}) {
  showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          height: 150,
          child: Column(
            children: [
        
              GestureDetector(
                onTap: onGalleryTap,
                child: Card(
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(15),
                    decoration: const BoxDecoration(color: Colors.grey),
                    child: const Text("Gallery",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                  ),
                ),
              ),
            ],
          ),
        );
      });
}
void filePickerModal(BuildContext context,
    { VoidCallback? onGalleryTap}) {
  showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          height: 150,
          child: Column(
            children: [
        
              GestureDetector(
                onTap: onGalleryTap,
                child: Card(
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(15),
                    decoration: const BoxDecoration(color: Colors.grey),
                    child: const Text("File",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                  ),
                ),
              ),
            ],
          ),
        );
      });
}