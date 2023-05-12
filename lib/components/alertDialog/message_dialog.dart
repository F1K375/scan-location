import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessageDialog extends StatelessWidget {
  const MessageDialog({
    Key? key,
    required this.title,
    required this.description,
    required this.action,
    this.actionNegative,
    this.isSingleButton = false,
  }) : super(key: key);

  final String title;
  final String description;
  final VoidCallback action;
  final VoidCallback? actionNegative;
  final bool isSingleButton;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              description,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Divider(
            thickness: 2,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              isSingleButton
                  ? SizedBox()
                  : Expanded(
                      child: InkWell(
                        onTap: () {
                          Get.back();
                          // actionNegative != null ? actionNegative! ;
                        },
                        child: Container(
                          height: 32,
                          alignment: Alignment.center,
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
              isSingleButton
                  ? SizedBox()
                  : Container(
                      width: 2,
                      height: 30,
                      color: Colors.grey[300],
                      margin: const EdgeInsets.only(bottom: 10, top: 5),
                    ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    Get.back();
                    action();
                  },
                  child: Container(
                    alignment: Alignment.center,
                    height: 32,
                    child: Text(
                      "Ok",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.blue),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
