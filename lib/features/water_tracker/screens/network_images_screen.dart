import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class NetworkImagesScreen extends StatelessWidget {
  const NetworkImagesScreen({super.key});

  final List<Map<String, String>> images = const [
    {
      'url': 'https://via.placeholder.com/400x300/00B4D8/FFFFFF',
      'title': 'Чистая вода',
    },
    {
      'url': 'https://via.placeholder.com/400x300/00A86B/FFFFFF',
      'title': 'Ароматный чай',
    },
    {
      'url': 'https://via.placeholder.com/400x300/6F4E37/FFFFFF',
      'title': 'Свежий кофе',
    },
    {
      'url': 'https://via.placeholder.com/400x300/FFA500/FFFFFF',
      'title': 'Фруктовый сок',
    },
    {
      'url': 'https://via.placeholder.com/400x300/1E90FF/FFFFFF',
      'title': 'Минеральная вода',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Галерея напитков'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: images.length,
        itemBuilder: (context, index) {
          final image = images[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: Column(
              children: [
                SizedBox(
                  height: 200,
                  width: double.infinity,
                  child: CachedNetworkImage(
                    imageUrl: image['url']!,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) => const Center(
                      child: Icon(Icons.error),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    image['title']!,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}