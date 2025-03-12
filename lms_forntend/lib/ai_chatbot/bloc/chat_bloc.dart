import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:learn_management_system/ai_chatbot/models/chat_message_models.dart';
import 'package:learn_management_system/ai_chatbot/repo/chat_repo.dart';
import 'package:meta/meta.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc() : super(ChatSuccessState(messages: [])) {
    //Creating Method
    on<ChatGenerateNewTextMessageEvent>(chatGenerateTextMessageEvent);
  }
  List<ChatMessageModel> messages = [];

  FutureOr<void> chatGenerateTextMessageEvent(
      ChatGenerateNewTextMessageEvent event, Emitter<ChatState> emit) async {
    messages.add(ChatMessageModel(
        role: 'user', parts: [ChatPartModel(text: event.inputMessage)]));
    emit(ChatSuccessState(messages: messages));
    String generatedText = await ChatRepo.chatTextGenerationRepo(messages);
    if (generatedText.length > 0) {
      messages.add(ChatMessageModel(
          role: 'model', parts: [ChatPartModel(text: generatedText)]));
      emit(ChatSuccessState(messages: messages));
    }
  }
}
