// ignore_for_file: prefer_const_constructors, type_literal_in_constant_pattern, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_media/features/prompt/bloc/prompt_bloc.dart';
import 'package:social_media/features/prompt/ui/save_prompt.dart';

class PromptScreen extends StatefulWidget {
  const PromptScreen({super.key});

  @override
  State<PromptScreen> createState() => _PromptScreenState();
}

class _PromptScreenState extends State<PromptScreen> {
  TextEditingController controller = TextEditingController();
  final PromptBloc promptBloc = PromptBloc();

  @override
  void initState() {
    promptBloc.add(PromptInitalEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'AI Image Generator',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
          ),
        ),
        body: BlocConsumer<PromptBloc, PromptState>(
          bloc: promptBloc,
          listener: (context, state) {},
          builder: (context, state) {
            switch (state.runtimeType) {
              case PromptGeneratingImageLoadState:
                return Center(
                  child: CircularProgressIndicator(),
                );

              case PromptGeneratingImageFailedState:
                return Center(
                  child: Text('Error'),
                );

              case PromptGeneratingImageSucessState:
                final successState = state as PromptGeneratingImageSucessState;
                return Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Container(
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: MemoryImage(successState.uint8List),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.grey.withOpacity(0.6)),
                        ),
                        height: 300,
                        padding: EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Generate an image',
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            TextField(
                              cursorColor: Colors.deepPurple,
                              controller: controller,
                              decoration: InputDecoration(
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never,
                                  labelText: 'What would you like to generate?',
                                  labelStyle: TextStyle(
                                      color: Colors.grey.withOpacity(0.8),
                                      fontWeight: FontWeight.w300),
                                  hintText: 'github.com/GevorkG',
                                  hintStyle: TextStyle(
                                      color: Colors.grey.withOpacity(0.8),
                                      fontWeight: FontWeight.w300),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.deepPurple),
                                      borderRadius: BorderRadius.circular(12)),
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.deepPurple),
                                      borderRadius: BorderRadius.circular(12))),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              height: 48,
                              width: double.maxFinite,
                              child: ElevatedButton.icon(
                                  style: ButtonStyle(
                                      shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5)),
                                        ),
                                      ),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.deepPurple)),
                                  onPressed: () {
                                    if (controller.text.isNotEmpty) {
                                      promptBloc.add(PromptEnteredEvent(
                                          prompt: controller.text));
                                    }
                                  },
                                  icon: Icon(
                                    Icons.image,
                                    color: Colors.white,
                                  ),
                                  label: Text(
                                    'Generate',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16),
                                  )),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            SizedBox(
                              height: 48,
                              width: double.maxFinite,
                              child: ElevatedButton.icon(
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                      ),
                                    ),
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.green)),
                                onPressed: () {
                                  saveImage(successState.uint8List, context);
                                },
                                icon: Icon(
                                  Icons.download,
                                  color: Colors.white,
                                ),
                                label: Text('Download',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16)),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );

              default:
                return SizedBox();
            }
          },
        ));
  }
}
