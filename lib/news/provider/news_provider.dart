import 'package:flutter/material.dart';
import 'package:myapp/news/service/news_api_service.dart';

class NewsProvider with ChangeNotifier {
  NewsApiService newsApiService;

  NewsProvider({
    required this.newsApiService,
  });
}
