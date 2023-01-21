import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/animations/bottom_animation.dart';
import 'package:news_app/configs/app.dart';
import 'package:news_app/configs/configs.dart';
import 'package:news_app/cubits/articles/cubit.dart';
import 'package:news_app/cubits/top_headlines/cubit.dart';
import 'package:news_app/models/article/article.dart';
import 'package:news_app/models/news.dart';
import 'package:news_app/providers/category_provider.dart';
import 'package:news_app/providers/tab_provider.dart';
import 'package:news_app/providers/theme_provider.dart';
import 'package:news_app/responsive/responsive.dart';
import 'package:news_app/widgets/article_card.dart';
import 'package:news_app/widgets/custom_text_field.dart';
import 'package:news_app/widgets/headlines_card.dart';
import 'package:news_app/utils/app_utils.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

part 'views/mobile.dart';
part 'views/desktop.dart';
part 'views/tablet.dart';

part 'views/widgets/_tablet_tabs.dart';
part 'views/widgets/_category_tabs.dart';
part 'views/widgets/_article_tablet.dart';
part 'views/widgets/_category_button.dart';
part 'views/widgets/_top_stories_tablet.dart';
part 'views/widgets/_shimmer_article_card.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    final newsCubit = BlocProvider.of<TopHeadlinesCubit>(context);
    final articleCubit = BlocProvider.of<ArticlesCubit>(context);

    final categoryProvider =
        Provider.of<CategoryProvider>(context, listen: false);

    if (newsCubit.state.data == null || newsCubit.state.data!.isEmpty) {
      newsCubit.fetch(
        AppUtils.categories[categoryProvider.categoryIndexGet],
      );
    }
    if (articleCubit.state.data == null || articleCubit.state.data!.isEmpty) {
      articleCubit.fetch(keyword: 'latest');
    }
    super.initState();
  }

  

  @override
  Widget build(BuildContext context) {
    return const Responsive(
      mobile: DashboardMobile(),
      tablet: DashboardTablet(),
      desktop: DashboardDesktop(),
    );
  }
}
