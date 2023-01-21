part of 'cubit.dart';

class NewsDataProvider {
  static final dio = Dio();
  
  /// [apiKey] is required, you can get it from newsapi.org
  static final apiKey = dotenv.env['apiKey'];
  static final cache = Hive.box('newsBox');
  static final appCache = Hive.box('app');

  static Future<List<News>> fetchApi(String category) async {
    try {
      final response = await dio.get(
        'https://newsapi.org/v2/top-headlines/sources?category=$category',
        options: Options(
          headers: {
            'Authorization': apiKey,
          },
        ),
      );

      Map raw = response.data;

      List newsList = raw['sources'];

      List<News> news = List.generate(
        newsList.length,
        (index) => News.fromMap(
          newsList[index],
        ),
      );

      await cache.put(category, news);
      await appCache.put('categoryTime', DateTime.now());

      return news;
    } on DioError catch (e) {
      if (DioErrorType.other == e.type) {
        if (e.message.contains('SocketException')) {
          throw Exception('Poor internet connection. Please try again!');
        } else {
          throw Exception(e.message);
        }
      } else {
        throw Exception('Problem connecting to the server. Please try again.');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<List<News>?> fetchHive(String category) async {
    try {
      List? cachedNews = cache.get(category);

      if (cachedNews == null) return null;

      List<News>? news = List.generate(
        cachedNews.length,
        (index) => cachedNews[index],
      );
      return news;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
