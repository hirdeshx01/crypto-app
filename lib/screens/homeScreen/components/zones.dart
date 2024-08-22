import 'package:flutter/material.dart';

class ZoneCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final String change;
  final Color changeColor;
  final bool newTag;

  const ZoneCard({
    super.key,
    required this.title,
    required this.icon,
    required this.change,
    required this.changeColor,
    required this.newTag,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainer,
          borderRadius: BorderRadius.circular(10.0),
        ),
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(width: 8.0),
                Icon(
                  icon,
                  color: Colors.amber,
                ),
                if (newTag)
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6.0, vertical: 2.0),
                      decoration: BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: const Text(
                        'New',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            Text(
              change,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(color: changeColor),
            ),
          ],
        ),
      ),
    );
  }
}
