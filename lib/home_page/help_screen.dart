import 'package:flutter/material.dart';
import 'package:myapp/shared/colors_const.dart';
import 'package:myapp/utils.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsConst.whiteColor,
      appBar: AppBar(
        backgroundColor: const Color(0xffffffff),
        foregroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.only(left: 0, top: 18, bottom: 18),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Image.asset(
              'assets/page-1/images/back.png',
              color: Color(0xff1F0A68),
            ),
          ),
        ),
        titleSpacing: -1,
        title: Text(
          "Help",
          style: SafeGoogleFont("Inter",
              fontSize: 20, fontWeight: FontWeight.w600,color: Color(0xff1F0A68)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30, top: 20,bottom: 1),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Submit a query',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              const Text(
                'Love something or facing an issue? Share your feedback or report a problem. Your insights help shape our future updates!',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(
                height: 30,
              ),
              const TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Subject',
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              const TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Description',
                ),
                maxLines: 4,
              ),
               SizedBox(
                height: MediaQuery.of(context).size.height *0.1,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                    onPressed: () {
                    },
                    style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.all(15),
                        backgroundColor: const Color(0xff1F0A68)),
                    child: const Text('Submit Query')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
