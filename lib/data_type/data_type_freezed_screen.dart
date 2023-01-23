import 'package:flutter/material.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';
import 'package:flutter_velog_sample/data_type/data_type_freezed_provider.dart';
import 'package:provider/provider.dart';

class DataTypeFreezedScreen extends StatelessWidget {
  const DataTypeFreezedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DataTypeFreezedProvider>(
      create: (_) => DataTypeFreezedProvider()..started(),
      child:
          Consumer<DataTypeFreezedProvider>(builder: (context, state, child) {
        return Scaffold(
          appBar: appBar(title: 'Freezed'),
          body: ListView.builder(
              itemCount: state.data.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: const Color.fromRGBO(71, 71, 71, 1)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          _item(
                              context: context,
                              title: '번      호',
                              description: "${index + 1}"),
                          _item(
                              context: context,
                              title: '이      름',
                              description: state.data[index].name),
                          _item(
                              context: context,
                              title: '나      이',
                              description: state.data[index].age.toString()),
                          _item(
                              context: context,
                              title: '성      별',
                              description:
                                  state.data[index].sex == 0 ? '남자' : '여자'),
                          _item(
                              context: context,
                              title: '결혼유무',
                              description:
                                  state.data[index].isMarried ? '기혼' : '미혼'),
                          _item(
                              context: context,
                              title: '주      소',
                              description: state.data[index].address),
                        ],
                      ),
                    ),
                  ),
                );
              }),
        );
      }),
    );
  }

  Padding _item({
    required BuildContext context,
    required String title,
    required String description,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: DefaultTextStyle(
        style: const TextStyle(
            fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
        child: Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.15,
              child: Text(title),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 8),
              child: Text(":"),
            ),
            Flexible(
              child: Text(description),
            )
          ],
        ),
      ),
    );
  }
}
