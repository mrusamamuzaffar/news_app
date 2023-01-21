import 'dart:math' as math;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/configs/configs.dart';
import 'package:news_app/models/article/article.dart';
import 'package:url_launcher/url_launcher.dart';

class ArticleContentScreen extends StatelessWidget {
  final Article article;
  const ArticleContentScreen({
    Key? key,
    required this.article,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: Space.all(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: BackButton(
                  onPressed: () => Navigator.pop(context),
                ),
              ),
              Space.y!,
              Text(
                article.title!,
                style: AppText.h1b,
              ),
              Space.y!,
              CachedNetworkImage(
                imageUrl: article.urlToImage!,
              ),
              Space.y1!,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    article.author!,
                    style: AppText.b2b,
                  ),
                  TextButton(
                    onPressed: () => launchUrl(Uri.parse(article.url!)),
                    child: Row(
                      children: [
                        Transform.rotate(
                          angle: math.pi * 0.70,
                          child: const Icon(Icons.link_rounded),
                        ),
                        Space.xf(0.25),
                        Text(
                          article.source!.name!,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Space.y1!,
              Text(
                article.content!,
              )
            ],
          ),
        ),
      ),
    );
  }
}
