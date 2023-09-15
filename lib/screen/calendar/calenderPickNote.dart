import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:study_app_project/controllers/calenderController.dart';

class GetNote extends StatefulWidget {
  const GetNote({super.key, required this.dateNow});

  final DateTime dateNow;

  @override
  State<GetNote> createState() => _GetNoteState();
}

class _GetNoteState extends State<GetNote> {
  final _subjectController = TextEditingController();
  final _noteController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _subjectController.dispose();
    _noteController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TakeNoteController>();
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(builder: (ctx, constraints) {
      return SizedBox(
        height: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(16, 48, 16, keyboardSpace + 16),
            child: Column(
              children: [
                TextField(
                  controller: _subjectController,
                  maxLength: 50,
                  decoration: const InputDecoration(
                    label: Text('Subject'),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _noteController,
                  maxLength: 50,
                  decoration: const InputDecoration(
                    label: Text('Note'),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text("Back")),
                    TextButton(
                        onPressed: () {
                          if (_noteController.text != "" &&
                              _subjectController.text != "") {
                            controller.addNote(widget.dateNow,
                                _noteController.text, _subjectController.text);

                            Get.back();
                          }
                        },
                        child: const Text("Save")),
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
