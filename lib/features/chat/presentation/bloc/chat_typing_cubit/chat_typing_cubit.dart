import 'package:flutter_bloc/flutter_bloc.dart';

class ChatTypingCubit extends Cubit<bool> {
  ChatTypingCubit() : super(false);

  void setTyping(bool isTyping) {
    emit(isTyping);
  }
}
