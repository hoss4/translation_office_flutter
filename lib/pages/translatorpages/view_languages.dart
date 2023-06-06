// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:translation_office_flutter/languages.dart';
import 'package:translation_office_flutter/services/translator_api.dart';

// ignore: must_be_immutable
class ViewLangs extends StatefulWidget {
  List<dynamic> languages;
  String translatorid;
  ViewLangs({
    required this.languages,
    required this.translatorid,
    super.key,
  });

  @override
  State<ViewLangs> createState() => _ViewLangsState();
}

class _ViewLangsState extends State<ViewLangs> {
  int index = 5;
  List<String> languages = Languages.languages;
  late FixedExtentScrollController scrollController;

  @override
  void initState() {
    super.initState();
    scrollController = FixedExtentScrollController(initialItem: index);
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Languages"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.65,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: widget.languages.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: ListTile(
                      title: Text(widget.languages[index],
                          style: const TextStyle(fontSize: 25)),
                      leading: const Icon(
                        Icons.circle_rounded,
                        color: Colors.blue,
                        size: 15,
                      ),
                      horizontalTitleGap: 20,
                      trailing: IconButton(
                        icon: const Icon(
                          CupertinoIcons.minus_circled,
                          color: Colors.red,
                          size: 30,
                        ),
                        onPressed: () async {
                          var res = await TranslatorApi.removelanguage(
                              languages[index]);
                          if (res["status"] == "200") {
                            setState(() {
                              widget.languages.removeAt(index);
                            });
                            showCupertinoDialog(
                              context: context,
                              builder: (context) => createDialog(
                                  context, "Language Removed successfully"),
                            );
                          } else {
                            showCupertinoDialog(
                              context: context,
                              builder: (context) =>
                                  failureDialog(context, res['message']),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              child: CupertinoButton.filled(
                padding: const EdgeInsets.symmetric(vertical: 15),
                onPressed: () {
                  scrollController.dispose();
                  scrollController =
                      FixedExtentScrollController(initialItem: index);
                  showCupertinoModalPopup(
                    context: context,
                    builder: (context) => CupertinoActionSheet(
                        title: const Text("Pick a Language"),
                        actions: [
                          buildPicker(),
                        ],
                        cancelButton: CupertinoActionSheetAction(
                          child: const Text("Confirm"),
                          onPressed: () async {
                            var res = await TranslatorApi.addlanguage(
                                languages[index]);
                            if (res["status"] == "200") {
                              setState(() {
                                widget.languages.add(languages[index]);
                              });
                              showCupertinoDialog(
                                context: context,
                                builder: (context) => createDialog(
                                    context, "Language Added successfully"),
                              );
                            } else {
                              showCupertinoDialog(
                                context: context,
                                builder: (context) =>
                                    failureDialog(context, res['message']),
                              );
                            }
                          },
                        )),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      CupertinoIcons.add,
                      color: Colors.white,
                      size: 25,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text("Add Language", style: TextStyle(fontSize: 18)),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPicker() => SizedBox(
        height: 350,
        child: CupertinoPicker(
          scrollController: scrollController,
          itemExtent: 64,
          selectionOverlay: CupertinoPickerDefaultSelectionOverlay(
            background: CupertinoColors.activeBlue.withOpacity(0.2),
          ),
          onSelectedItemChanged: (index) {
            setState(() {
              this.index = index;
            });
          },
          children: languages
              .map(
                (item) => Center(
                  child: Text(
                    item,
                    style: const TextStyle(
                      fontSize: 25,
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      );

  Widget createDialog(BuildContext context, String message) =>
      CupertinoAlertDialog(
          title: const Text(
            "Success",
            style: TextStyle(
              fontSize: 22,
            ),
          ),
          content: Text(
            message,
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
          actions: [
            CupertinoDialogAction(
                child: const Text("Done"),
                onPressed: () {
                  Navigator.pop(context);
                })
          ]);
  Widget failureDialog(BuildContext context, String message) =>
      CupertinoAlertDialog(
          title: const Text(
            "Error",
            style: TextStyle(
              fontSize: 22,
            ),
          ),
          content: Text(
            message,
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
          actions: [
            CupertinoDialogAction(
                child: const Text("Done"),
                onPressed: () {
                  Navigator.pop(context);
                })
          ]);
}
