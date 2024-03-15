import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myapp/news/model/news_response.dart';
import 'package:myapp/news/provider/news_provider.dart';
import 'package:myapp/news/ui/news_all_detail_screen.dart';
import 'package:myapp/shared/colors_const.dart';
import 'package:myapp/shared/string_const.dart';
import 'package:myapp/utils.dart';
import 'package:provider/provider.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  _NewsScreen createState() => _NewsScreen();
}

class _NewsScreen extends State<NewsScreen> {
  late NewsProvider newsProvider;

  @override
  void initState() {
    newsProvider = Provider.of<NewsProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: ColorsConst.whiteColor,
        automaticallyImplyLeading: false,
        backgroundColor: ColorsConst.whiteColor,
        foregroundColor: ColorsConst.whiteColor,
        // leading: Padding(
        //   padding: const EdgeInsets.only(left: 0, top: 18, bottom: 18),
        //   child: GestureDetector(
        //     onTap: () {
        //       Navigator.pushReplacement(
        //           context,
        //           MaterialPageRoute(
        //               builder: (context) => const HomePageContainer()));
        //     },
        //     child: Image.asset(
        //       'assets/page-1/images/back.png',
        //     ),
        //   ),
        // ),
        //titleSpacing: 120,
        title: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            StringConst.newsTitle,
            style: SafeGoogleFont("Inter",
                fontSize: 18, fontWeight: FontWeight.w600,color: ColorsConst.appBarColor),
          ),
        ),
      ),
      body: FutureBuilder<List<NewsArticle>>(
        future: newsProvider.newsApiService.fetchCollegeNews(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            List<NewsArticle>? articles = snapshot.data;
            articles?.sort((a, b) => b.publishedAt!.compareTo(a.publishedAt!));
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 18, top: 8, bottom: 6),
                  child: GestureDetector(
                    onTap: () {},
                    child: Row(
                      children: [
                        Card(
                          color: Colors.white,
                          surfaceTintColor: Colors.white,
                          elevation: 2,
                          shadowColor: ColorsConst.whiteColor,
                          child: TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Top News',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: articles?.length,
                    itemBuilder: (context, index) {

                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (articles?[index].urlToImage != null)
                              ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  bottomRight: Radius.circular(80),
                                  bottomLeft: Radius.circular(10),
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                ),
                                child: Image.network(
                                  articles![index].urlToImage ?? '',
                                  fit: BoxFit.cover,
                                  height: 240.0,
                                ),
                              ),
                            const SizedBox(
                              height: 16,
                            ),
                            Text(formatTime(articles![index].publishedAt ?? '')),
                            const SizedBox(
                              height: 16,
                            ),
                            Text(
                              articles[index].title ?? '',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Text(
                              articles[index].description ?? '',
                              maxLines: 4,
                              style: const TextStyle(fontSize: 16),
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => NewsAllDetailScreen(
                                      newsArticle: articles[index],
                                    ),
                                  ),
                                );
                              },
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    'Read More',
                                    style: TextStyle(
                                      color: ColorsConst.appBarColor,
                                    ),
                                  ),
                                  // Icon(
                                  //   Icons.arrow_forward_ios_sharp,
                                  //   color: ColorsConst.redColor,
                                  //   size: 14,
                                  // ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
      backgroundColor: ColorsConst.whiteColor,
    );
  }
  String formatTime(String timestamp) {
    DateTime dateTime = DateTime.parse(timestamp);
    String formattedTime = DateFormat('MMM dd, yyyy').format(dateTime);
    return formattedTime;
  }
}


