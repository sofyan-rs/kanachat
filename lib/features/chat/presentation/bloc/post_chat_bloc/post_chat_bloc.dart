import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanachat/features/chat/domain/usecases/post_chat.dart';
import 'package:kanachat/features/customization/domain/entities/chat_customization_entity.dart';

part 'post_chat_event.dart';
part 'post_chat_state.dart';

class PostChatBloc extends Bloc<PostChatEvent, PostChatState> {
  final PostChat postChat;

  PostChatBloc(this.postChat) : super(PostChatInitial()) {
    on<PostChatRequested>((event, emit) => _onPostChat(event, emit));
  }

  void _onPostChat(PostChatRequested event, Emitter<PostChatState> emit) async {
    emit(PostChatLoading());
    final res = await postChat(
      PostChatParams(
        userInput: event.userInput,
        customization: event.customization,
      ),
    );
    res.fold(
      (l) => emit(PostChatError(message: l.message)),
      (r) => emit(PostChatSuccess(message: r)),
    );
  }
}
