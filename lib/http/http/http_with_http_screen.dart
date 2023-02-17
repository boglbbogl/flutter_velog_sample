import 'package:flutter/material.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';
import 'package:flutter_velog_sample/http/http/http_provider.dart';
import 'package:flutter_velog_sample/main.dart';
import 'package:provider/provider.dart';

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
              child: GridView.builder(
                  itemCount: state.photos.length,
                  padding: const EdgeInsets.only(bottom: 40),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 4,
                    crossAxisSpacing: 4,
                  ),
                  itemBuilder: ((context, index) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        state.photos[index].downloadUrl,
                        fit: BoxFit.cover,
                        frameBuilder: (BuildContext context, Widget child,
                            int? frame, bool wasSynchronouslyLoaded) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: const Color.fromRGBO(91, 91, 91, 1),
                            ),
                            child: child,
                          );
                        },
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          }
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: const Color.fromRGBO(91, 91, 91, 1),
                            ),
                            child: const Center(
                              child: CircularProgressIndicator(
                                color: Colors.amber,
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  })),
            ),
          );
        }));
  }
}
