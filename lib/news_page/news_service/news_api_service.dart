// import 'dart:convert';
// import 'package:flutter/foundation.dart';
// import 'package:http/http.dart' as http;
// import 'package:myapp/news_page/model/news_model.dart';
//
// class NewsApiService {
//   static Future<List<News>> getNewsInfo() async {
//     http.Response response = await http.get(
//       Uri.parse('https://newsapi.org/v2/everything?q=tesla&from=2023-12-08&sortBy=publishedAt&apiKey=3d35725aaa9849fb9207be981a790b27'),
//     );
//
//     if (response.statusCode == 200) {
//       List<dynamic> mapList = jsonDecode(response.body);
//       List<News> newsList = [];
//
//       for (int i = 0; i < mapList.length; i++) {
//         News news = News.fromJson(mapList[i]);
//         newsList.add(news);
//       }
//       return newsList;
//     }
//     throw 'Something went wrong';
//   }
// }
//
// // class NewsApiService{
// //
// //   static Future<List<News>> getNewsInfo() async {
// //     const url = 'https://newsapi.org/v2/everything?q=tesla&from=2023-12-08&sortBy=publishedAt&apiKey=3d35725aaa9849fb9207be981a790b27';
// //
// //     try {
// //       final response =
// //       await http.get(Uri.parse(url),);
// //
// //       if (response.statusCode == 200) {
// //         final responseData = jsonDecode(response.body);
// //         if (responseData['articles'] is List) {
// //           return List<News>.from(responseData['articles']);
// //         } else {
// //           return [];
// //         }
// //       } else {
// //         if (kDebugMode) {
// //           print(
// //               'Failed to load template response. Status code: ${response.statusCode}');
// //         }
// //         return [];
// //       }
// //     } catch (e) {
// //       if (kDebugMode) {
// //         print('Error fetching template response: $e');
// //       }
// //       return [];
// //     }
// //   }
// //
// //
// // }
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:myapp/news_page/model/articles_model.dart';
import 'package:myapp/news_page/shared/api_end_point.dart';

class NewsApiService {
  Future<List<NewsArticle>> fetchTeslaNews() async {
    final response = await http.get(
      Uri.parse(ApiEndPoint.newsUrl),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);

      if (data['status'] == "ok") {
        List<dynamic> articles = data['articles'];
        return articles
            .map((article) => NewsArticle.fromJson(article))
            .toList();
      } else {
        throw Exception("Failed to load articles");
      }
    } else {
      throw Exception("Failed to load articles");
    }
  }
}
