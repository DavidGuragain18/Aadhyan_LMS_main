import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_management_system/ai_chatbot/bloc/chat_bloc.dart';
import 'package:learn_management_system/ai_chatbot/models/chat_message_models.dart';
import 'package:learn_management_system/config/common/app_color.dart';
import 'package:learn_management_system/config/common/reusable_text.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final ChatBloc chatBloc = ChatBloc();
  TextEditingController textEditingController = TextEditingController();
  // @override
  // void dispose() {
  //   chatBloc.close();
  //   textEditingController.dispose();
  //   super.dispose();
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(kButton.value),
          title: ReusableText(
              text: 'LearnEase ChatBOt',
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: kLight),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              )),
        ),
        body: BlocConsumer<ChatBloc, ChatState>(
          bloc: chatBloc,
          listener: (context, state) {
            if (state is ChatSuccessState) {
              textEditingController.clear();
            }
          },
          builder: (context, state) {
            switch (state.runtimeType) {
              case ChatSuccessState:
                List<ChatMessageModel> messages =
                    (state as ChatSuccessState).messages;
                return Container(
                  // decoration: const BoxDecoration(
                  //     image: DecorationImage(image: AssetImage('assets/dark Ai.jpeg'))),
                  child: Column(
                    children: [
                      Expanded(
                          child: ListView.builder(
                              itemCount: messages.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Container(
                                      padding: EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        // border: Border.all(
                                        //     color: Colors.white, width: 1)
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            messages[index].role == 'user'
                                                ? 'Question'
                                                : "Answer",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            messages[index].parts.first.text,
                                            style: TextStyle(fontSize: 18),
                                          ),
                                        ],
                                      )),
                                );
                              })),
                      Container(
                        height: 120,
                        // color: Colors.blue,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 30, horizontal: 20),
                          child: Row(
                            children: [
                              Expanded(
                                  child: TextField(
                                onSubmitted: (value) {
                                  chatBloc.add(ChatGenerateNewTextMessageEvent(
                                      inputMessage:
                                          textEditingController.text));
                                },
                                controller: textEditingController,
                                // enabled: false,
                                decoration: InputDecoration(
                                  fillColor: kButton,
                                  // filled: true,
                                  hintText: 'Ask Something you want?',
                                  hintStyle: TextStyle(color: Colors.black),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(120)),
                                ),
                              )),
                              SizedBox(
                                width: 10,
                              ),
                              IconButton(
                                  onPressed: () {
                                    if (textEditingController.text.isNotEmpty) {
                                      chatBloc.add(
                                          ChatGenerateNewTextMessageEvent(
                                              inputMessage:
                                                  textEditingController.text));
                                    }
                                  },
                                  icon: Icon(
                                    Icons.send,
                                    size: 30,
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              default:
                return SizedBox(
                  child: Center(
                    child: Text(
                      'Something Went Wrong',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                );
            }
          },
        ));
  }
}
