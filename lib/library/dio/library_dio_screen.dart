import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';
import 'package:flutter_velog_sample/library/dio/dio_services.dart';

class LibraryDioScreen extends StatefulWidget {
  const LibraryDioScreen({super.key});

  @override
  State<LibraryDioScreen> createState() => _LibraryDioScreenState();
}

class _LibraryDioScreenState extends State<LibraryDioScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(title: "Dio Library"),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () async {
              Dio _dio = DioServices().to();
              await _dio.get("https://picsum.photos/v2/list");
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 24),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: const Color.fromRGBO(125, 125, 125, 1)),
              child: const Center(
                child: Text(
                  "Dio Information",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
