import "package:flutter/material.dart";
import 'package:webfeed/webfeed.dart';
import 'package:neplox_linkpreviewer/neplox_linkpreviewer.dart';
import 'package:http/http.dart' as http;

class LearningTabView extends StatefulWidget {
  const LearningTabView({super.key});

  @override
  State<LearningTabView> createState() {
    return _LearningTabView();
  }
}

class _LearningTabView extends State<LearningTabView> {
  static const String FEED_URL = "https://thechessworld.com/feed/";
  RssFeed? feed;

  List<String> feeds_link = [];
  @override
  void initState() {
    super.initState();

    loadFeedState();
  }

  void loadFeedState() async {
    feed = await loadFeed();
    //print(feed!.items!.length);
    setState(() {
      feed!.items!.forEach((element) {
        if (element.link != null) {
          feeds_link.add(element.link as String);
          print(element.link);
        }
      });
    });
  }

  Future<RssFeed?> loadFeed() async {
    try {
      final client = http.Client();
      final response = await client.get(Uri.parse(FEED_URL));
      return RssFeed.parse(response.body);
    } catch (e) {
      //Eat Exception
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const SizedBox(
        height: 20,
      ),
      Text(
        "LEARNING",
        style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w700,
            fontSize: 24,
            color: Colors.white),
      ),
      const SizedBox(
        height: 20,
      ),
      Expanded(
        child: feeds_link.length == 0
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircularProgressIndicator(),
                  const SizedBox(
                    height: 20,
                  )
                ],
              )
            : ListView.builder(
                itemCount: feeds_link.length,
                itemBuilder: ((context, index) => Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Container(
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 129, 31, 134),
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        margin: const EdgeInsets.all(15),
                        child: NeploxLinkPreviewer(
                          url: feeds_link[index],
                          linkPreviewOptions: NLinkPreviewOptions(
                              urlLaunch: NURLLaunch.enable,
                              urlLaunchIn: NURLLaunchIn.browser,
                              thumbnailPreviewDirection:
                                  NThumbnailPreviewDirection.bottom),
                        ),
                      ),
                    )),
              ),
      )
    ]);
  }
}
