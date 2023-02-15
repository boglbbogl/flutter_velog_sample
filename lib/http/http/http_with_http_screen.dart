import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_velog_sample/http/http/http_provider.dart';
import 'package:provider/provider.dart';

class HttpWithHttpScreen extends StatelessWidget {
  const HttpWithHttpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HttpProvider>(
        create: (_) => HttpProvider()..started(),
        child: Consumer(builder: (context, state, child) {
          return Scaffold();
        }));
  }
}
