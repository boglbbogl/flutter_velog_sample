import 'package:flutter/material.dart';

class PerformanceImageTabWidget extends StatefulWidget {
  final List<String> images;
  const PerformanceImageTabWidget({
    super.key,
    required this.images,
  });

  @override
  State<PerformanceImageTabWidget> createState() =>
      _PerformanceImageTabWidgetState();
}

class _PerformanceImageTabWidgetState extends State<PerformanceImageTabWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView.builder(
        key: const PageStorageKey("velog/sample/performance/list_builder"),
        itemCount: widget.images.length,
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 8),
            width: MediaQuery.of(context).size.width / 2,
            height: MediaQuery.of(context).size.width / 2,
            child: Image.network(
              _url(widget.images[index]),
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.deepOrange,
                  ),
                );
              },
            ),
          );
        });
  }

  String _url(String url) {
    return url;
  }

  @override
  bool get wantKeepAlive => true;
}
