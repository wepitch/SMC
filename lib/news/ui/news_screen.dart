// // // ignore_for_file: library_private_types_in_public_api
// //
// // import 'package:flutter/material.dart';
// // import 'package:myapp/news_page/model/articles_model.dart';
// // import 'package:myapp/news_page/news_service/news_api_service.dart';
// // import 'package:myapp/news_page/provider/news_provider.dart';
// // import 'package:myapp/news_page/shared/colors_const.dart';
// // import 'package:myapp/news_page/shared/string_const.dart';
// // import 'package:myapp/news_page/ui/news_all_detail_screen.dart';
// // import 'package:myapp/utils.dart';
// // import 'package:provider/provider.dart';
// //
// // class NewsListWidget extends StatefulWidget {
// //   const NewsListWidget({
// //     required this.newsService,
// //     super.key,
// //   });
// //
// //   final NewsApiService newsService;
// //
// //   @override
// //   _NewsListWidgetState createState() => _NewsListWidgetState();
// // }
// //
// // class _NewsListWidgetState extends State<NewsListWidget> {
// //   late Future<List<NewsArticle>> articles;
// //   late NewsProvider newsProvider;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     articles = widget.newsService.fetchTeslaNews();
// //     newsProvider = Provider.of<NewsProvider>(context, listen: false);
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         automaticallyImplyLeading: false,
// //         backgroundColor: ColorsConst.blueColor,
// //         foregroundColor: ColorsConst.whiteColor,
// //         titleSpacing: 20,
// //         title: Center(
// //           child: Text(
// //             StringConst.newsTitle,
// //             style: SafeGoogleFont("Inter",
// //                 fontSize: 18, fontWeight: FontWeight.w600),
// //           ),
// //         ),
// //       ),
// //       body: FutureBuilder<List<NewsArticle>>(
// //         future: articles,
// //         builder: (context, snapshot) {
// //           if (snapshot.hasData) {
// //             List<NewsArticle> newsList = snapshot.data!;
// //             return ListView.builder(
// //               itemCount: newsList.length,
// //               itemBuilder: (context, index) {
// //                 NewsArticle article = newsList[index];
// //                 return Padding(
// //                   padding: const EdgeInsets.all(16),
// //                   child: GestureDetector(
// //                     // onTap: () {
// //                     //   Navigator.push(
// //                     //     context,
// //                     //     MaterialPageRoute(
// //                     //       builder: (context) => NewsAllDetailScreen(
// //                     //         newsArticle: newsList[index],
// //                     //       ),
// //                     //     ),
// //                     //   );
// //                     // },
// //                     child: Column(
// //                       crossAxisAlignment: CrossAxisAlignment.start,
// //                       children: [
// //                         ClipRRect(
// //                           borderRadius: const BorderRadius.only(
// //                             bottomRight: Radius.circular(100),
// //                           ),
// //                           child: Column(
// //                             children: [
// //                               if (article.urlToImage.isNotEmpty)
// //                                 Image.network(
// //                                   article.urlToImage,
// //                                   height: 240,
// //                                   width: double.infinity,
// //                                   fit: BoxFit.cover,
// //                                 ),
// //                             ],
// //                           ),
// //                         ),
// //                         const SizedBox(
// //                           height: 16,
// //                         ),
// //                         const Center(
// //                           child: Text(
// //                             StringConst.headline,
// //                             style: TextStyle(
// //                               fontSize: 20,
// //                               fontWeight: FontWeight.bold,
// //                               color: ColorsConst.redColor,
// //                             ),
// //                           ),
// //                         ),
// //                         const SizedBox(
// //                           height: 12,
// //                         ),
// //                         Text(
// //                           article.title,
// //                           style: const TextStyle(
// //                               fontWeight: FontWeight.bold, fontSize: 18),
// //                           maxLines: 2,
// //                         ),
// //                         const SizedBox(
// //                           height: 16,
// //                         ),
// //                         Text(
// //                           article.description,
// //                           maxLines: 5,
// //                           style: const TextStyle(fontSize: 16),
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                 );
// //               },
// //             );
// //           } else if (snapshot.hasError) {
// //             return const Center(
// //               child: Text(StringConst.errorText),
// //             );
// //           }
// //
// //           return const Center(
// //             child: CircularProgressIndicator(),
// //           );
// //         },
// //       ),
// //     );
// //   }
// // }
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:myapp/utils.dart';
//
// class Newsscreen extends StatefulWidget {
//   @override
//   _NewsscreenState createState() => _NewsscreenState();
// }
//
// class _NewsscreenState extends State<Newsscreen> {
//   final String apiKey = '608162a7221647ee988aae17953ad92f';
//
//   Future<List<dynamic>> fetchCollegeNews() async {
//     final response = await http.get(
//       Uri.parse(
//           'https://newsapi.org/v2/everything?q=indian%20college&apiKey=$apiKey'),
//     );
//     if (response.statusCode == 200) {
//       return json.decode(response.body)['articles'];
//     } else {
//       throw Exception('Failed to load news');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         backgroundColor: const Color(0xff1F0A68),
//         foregroundColor: Colors.white,
//         // leading: Padding(
//         //   padding: const EdgeInsets.only(left: 0, top: 18, bottom: 18),
//         //   child: GestureDetector(
//         //     onTap: () {
//         //       Navigator.pushReplacement(
//         //           context,
//         //           MaterialPageRoute(
//         //               builder: (context) => const HomePageContainer()));
//         //     },
//         //     child: Image.asset(
//         //       'assets/page-1/images/back.png',
//         //     ),
//         //   ),
//         // ),
//         titleSpacing: 20,
//         title: Center(
//           child: Text(
//             "News",
//             style: SafeGoogleFont("Inter",
//                 fontSize: 18, fontWeight: FontWeight.w600),
//           ),
//         ),
//       ),
//       body: FutureBuilder(
//         future: fetchCollegeNews(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Text('Error: ${snapshot.error}');
//           } else {
//             List? articles = snapshot.data;
//             return ListView.builder(
//               itemCount: articles?.length,
//               itemBuilder: (context, index) {
//                 return Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     children: [
//                       if (articles?[index]['urlToImage'] != null)
//                         ClipRRect(
//                           borderRadius: const BorderRadius.only(
//                             bottomRight: Radius.circular(80),
//                             topLeft: Radius.circular(80),
//                           ),
//                           child: Image.network(
//                             articles?[index]['urlToImage'],
//                             fit: BoxFit.cover,
//                             height: 200.0,
//                           ),
//                         ),
//                       const SizedBox(
//                         height: 16,
//                       ),
//                       Text(
//                         articles?[index]['title'],
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold, fontSize: 18),
//                       ),
//                       const SizedBox(
//                         height: 16,
//                       ),
//                       Text(
//                         articles?[index]['description'],
//                         style: const TextStyle(fontSize: 16),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
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
        automaticallyImplyLeading: false,
        backgroundColor: ColorsConst.appBarColor,
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
          padding: const EdgeInsets.only(left: 140),
          child: Text(
            StringConst.newsTitle,
            style: SafeGoogleFont("Inter",
                fontSize: 18, fontWeight: FontWeight.w600),
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
                          elevation: 10,
                          child: TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Top News',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        )
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
                                  articles![index].urlToImage!,
                                  fit: BoxFit.cover,
                                  height: 240.0,
                                ),
                              ),
                            const SizedBox(
                              height: 16,
                            ),
                            Text(
                              articles![index].title!,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Text(
                              articles[index].description!,
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
                                      color: ColorsConst.redColor,
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
    );
  }
}
