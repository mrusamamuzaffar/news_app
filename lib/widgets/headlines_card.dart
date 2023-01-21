import 'package:flutter/material.dart';
import 'package:news_app/configs/app.dart';
import 'package:news_app/configs/configs.dart';
import 'package:news_app/models/news.dart';
import 'package:url_launcher/url_launcher.dart';

class HeadlinesCard extends StatelessWidget {
  final News news;
  const HeadlinesCard({
    Key? key,
    required this.news,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: Space.all(0, 0.5),
      padding: Space.all(0.5, 1),
      decoration: BoxDecoration(
        color: AppTheme.c!.background,
        borderRadius: BorderRadius.circular(
          AppDimensions.normalize(3),
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 10),
            blurRadius: 12,
            spreadRadius: 6.0,
          )
        ],
      ),
      child: InkWell(
        onTap: () => launchUrl(
          Uri.parse(news.url),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: AppDimensions.normalize(35),
              height: AppDimensions.normalize(35),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(
                  AppDimensions.normalize(3),
                ),
              ),
              child: Center(
                child: Text(
                  news.name.substring(0, 1),
                  style: AppText.h1b!.copyWith(
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
            Space.x1!,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    news.description.length > 50
                        ? '${news.description.substring(0, 50)}...'
                        : news.description,
                    style: AppText.h3b!.copyWith(
                      height: 1.1,
                    ),
                  ),
                  Space.y!,
                  Row(
                    children: [
                      Text(
                        '${App.flag(news.country)} ${news.name}',
                        style: AppText.b2,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
