import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/animations/bottom_animation.dart';
import 'package:news_app/configs/configs.dart';
import 'package:news_app/cubits/top_headlines/cubit.dart';
import 'package:news_app/widgets/headlines_card.dart';
import 'package:intl/intl.dart' show toBeginningOfSentenceCase;

class TopStoriesScreen extends StatelessWidget {
  const TopStoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;

    final newsCubit = BlocProvider.of<TopHeadlinesCubit>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          toBeginningOfSentenceCase(
            args['title'].toString(),
          )!,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: Space.all(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: newsCubit.state.data!
                .map(
                  (e) => BottomAnimator(
                    child: HeadlinesCard(
                      news: e!,
                    ),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
