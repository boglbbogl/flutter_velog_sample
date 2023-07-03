import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';

class NetworkImageScreen extends StatelessWidget {
  const NetworkImageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: "Network Images"),
      body: ListView(
        children: [
          CachedNetworkImage(
            imageUrl: "https://picsum.photos/id/28/5000/5000",
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width,
            memCacheHeight: 300,
            memCacheWidth: 300,
            cacheManager: CacheManager(Config(
              "customCache",
              stalePeriod: const Duration(days: 7),
              maxNrOfCacheObjects: 100,
              repo: JsonCacheInfoRepository(databaseName: "customCache"),
              fileService: HttpFileService(),
            )),
          ),
        ],
      ),
    );
  }
}
