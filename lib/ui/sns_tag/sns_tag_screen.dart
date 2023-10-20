import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_velog_sample/_core/app_bar.dart';
import 'package:flutter_velog_sample/ui/sns_tag/custom_tag_controller.dart';
import 'package:flutter_velog_sample/ui/sns_tag/sns_tag_service.dart';

class SnsTagScreen extends StatelessWidget {
  SnsTagScreen({super.key});
  final CustomTagController controller = CustomTagController();

  final List<String> names = ["James", "John", "Robert", "Michael", "Oliver"];

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: SnsTagService.current,
        builder: (BuildContext context, String current, Widget? child) {
          return Scaffold(
            appBar: appBar(title: "SNS Tag"),
            body: Column(
              children: [
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.amber),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TextFormField(
                    controller: controller,
                    onChanged: (String value) {
                      if (current.isNotEmpty) {
                        if (current.substring(0, current.length - 1) == value) {
                          controller.text = "";
                          SnsTagService.instance.chaged("");
                          SnsTagService.instance.canceled(false);
                        } else if (current == value) {
                          SnsTagService.instance.canceled(true);
                        } else if (current.length < value.length) {
                          SnsTagService.instance.canceled(false);
                        }
                      }
                    },
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(left: 8, right: 8),
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                    ),
                  ),
                ),
                ...List.generate(
                    names.length,
                    (index) => GestureDetector(
                          onTap: () {
                            HapticFeedback.mediumImpact();
                            SnsTagService.instance.chaged(names[index]);
                            controller.text = "${names[index]} ";
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 24),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            width: MediaQuery.of(context).size.width,
                            height: 40,
                            child: Text(
                              names[index],
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: current == names[index]
                                      ? Colors.white
                                      : const Color.fromRGBO(155, 155, 155, 1)),
                            ),
                          ),
                        ))
              ],
            ),
          );
        });
  }
}
