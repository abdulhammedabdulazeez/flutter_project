import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class FoodCard extends StatefulWidget {
  const FoodCard({
    super.key,
    required this.imgPath,
    required this.dishName,
    required this.restaurant,
    required this.description,
    required this.attachment,
  });

  final String imgPath;
  final String dishName;
  final String restaurant;
  final String description;
  final Widget attachment;

  @override
  State<FoodCard> createState() => _FoodCardState();
}

class _FoodCardState extends State<FoodCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              children: [
                FadeInImage(
                  placeholder: MemoryImage(kTransparentImage),
                  image: NetworkImage(widget.imgPath),
                  width: 80,
                    // height: 80,
                  fit: BoxFit.cover,
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.dishName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'By: ${widget.restaurant}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        widget.description,
                        style: const TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // const SizedBox(height: 3),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [widget.attachment],
            ),
          ],
        ),
      ),
    );
  }
}
