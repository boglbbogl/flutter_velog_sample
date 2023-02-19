import 'package:flutter/material.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';
import 'package:flutter_velog_sample/http/http/http_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';

class HttpWithHttpScreen extends StatelessWidget {
  const HttpWithHttpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HttpProvider>(
        create: (_) => HttpProvider()..started(),
        child: Consumer<HttpProvider>(builder: (context, state, child) {
          return Scaffold(
            appBar: appBar(title: "Http"),
            body: NotificationListener<ScrollUpdateNotification>(
              onNotification: (ScrollUpdateNotification notification) {
                state.scrollListerner(notification);
                return false;
              },
              child: ListView.builder(
                  itemCount: state.photos.length,
                  itemBuilder: ((context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 8),
                      child: Column(
                        children: [
                          SizedBox(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  height:
                                      MediaQuery.of(context).size.width * 0.2,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.network(
                                      state.photos[index].downloadUrl,
                                      fit: BoxFit.cover,
                                      frameBuilder: (BuildContext context,
                                          Widget child,
                                          int? frame,
                                          bool wasSynchronouslyLoaded) {
                                        return Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            color: const Color.fromRGBO(
                                                91, 91, 91, 1),
                                          ),
                                          child: child,
                                        );
                                      },
                                      loadingBuilder: (BuildContext context,
                                          Widget child,
                                          ImageChunkEvent? loadingProgress) {
                                        if (loadingProgress == null) {
                                          return child;
                                        }
                                        return Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            color: const Color.fromRGBO(
                                                91, 91, 91, 1),
                                          ),
                                          child: const Center(
                                            child: CircularProgressIndicator(
                                              color: Colors.amber,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    _content(
                                        url: state.photos[index].url,
                                        title: "ID : ",
                                        content: state.photos[index].id),
                                    _content(
                                        url: state.photos[index].url,
                                        title: "Author : ",
                                        content: state.photos[index].author),
                                    _content(
                                        url: state.photos[index].url,
                                        title: "Width : ",
                                        content:
                                            "${state.photos[index].width}"),
                                    _content(
                                        url: state.photos[index].url,
                                        title: "Height : ",
                                        content:
                                            "${state.photos[index].height}"),
                                  ],
                                )
                              ],
                            ),
                          ),
                          if (state.photos.length - 1 == index &&
                              state.isAdd) ...[
                            const SizedBox(
                              height: 100,
                              child: Center(
                                  child: CircularProgressIndicator(
                                color: Colors.deepOrange,
                              )),
                            ),
                          ],
                        ],
                      ),
                    );
                  })),
            ),
          );
        }));
  }

  GestureDetector _content({
    required String title,
    required String content,
    required String url,
  }) {
    return GestureDetector(
      onTap: () async {
        if (await canLaunchUrlString(url)) {
          await launchUrlString(url, mode: LaunchMode.externalApplication);
        }
      },
      child: Row(
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            content,
            style: const TextStyle(
                fontSize: 14, color: Color.fromRGBO(215, 215, 215, 1)),
          ),
        ],
      ),
    );
  }
}
