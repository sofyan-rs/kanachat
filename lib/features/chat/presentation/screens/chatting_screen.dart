import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanachat/core/common/bloc/app_theme_cubit/app_theme_cubit.dart';
import 'package:kanachat/core/common/entities/app_theme_entity.dart';
import 'package:kanachat/core/themes/app_colors.dart';
import 'package:kanachat/core/utils/show_snackbar.dart';
import 'package:kanachat/features/chat/domain/entities/chat_message_entity.dart';
import 'package:kanachat/features/chat/presentation/bloc/chat_list_bloc/chat_list_bloc.dart';
import 'package:kanachat/features/chat/presentation/bloc/chat_messages_cubit/chat_messages_cubit.dart';
import 'package:kanachat/features/chat/presentation/bloc/post_chat_bloc/post_chat_bloc.dart';
import 'package:kanachat/features/chat/presentation/widgets/chat_bubble.dart';
import 'package:kanachat/features/customization/domain/entities/chat_customization_entity.dart';
import 'package:kanachat/features/customization/presentation/bloc/chat_customization_bloc.dart';
import 'package:kanachat/features/customization/presentation/screens/customization_screen.dart';
import 'package:solar_icons/solar_icons.dart';

class ChattingScreen extends StatefulWidget {
  const ChattingScreen({super.key});

  @override
  State<ChattingScreen> createState() => _ChattingScreenState();
}

class _ChattingScreenState extends State<ChattingScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final _inputChatController = TextEditingController();
  final _chatScrollController = ScrollController();

  void _onSendMessage() {
    context.read<ChatCustomizationBloc>().add(ChatCustomizationRequested());
    final customization = context.read<ChatCustomizationBloc>().state;
    if (_inputChatController.text.isNotEmpty) {
      final message = ChatMessageEntity(
        message: _inputChatController.text.trim(),
        isUser: true,
        createdAt: DateTime.now(),
        // chatHistoryId: '',
      );
      context.read<ChatListBloc>().add(ChatListMessageAdded(message: message));
      context.read<PostChatBloc>().add(
        PostChatRequested(
          userInput: _inputChatController.text.trim(),
          customization:
              customization is ChatCustomizationLoaded
                  ? customization.customization
                  : ChatCustomizationEntity(
                    name: null,
                    occupation: null,
                    traits: null,
                    additionalInfo: null,
                  ),
        ),
      );
      _inputChatController.clear();
    }
  }

  void _goToBottom() {
    if (_chatScrollController.hasClients) {
      _chatScrollController.animateTo(
        _chatScrollController.position.maxScrollExtent + 1000,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void initState() {
    context.read<ChatListBloc>().add(ChatListRequested());
    super.initState();
  }

  @override
  void dispose() {
    _inputChatController.dispose();
    _chatScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        toolbarHeight: 80,
        title: Row(
          children: [
            Icon(
              SolarIconsOutline.chatRoundDots,
              size: 24,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(width: 8),
            const Text(
              'KanaChat',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
            ),
          ],
        ),
        actions: [
          BlocBuilder<AppThemeCubit, AppThemeEntity>(
            builder: (context, state) {
              return IconButton(
                icon: Icon(
                  state.isDarkMode ? SolarIconsBold.moon : SolarIconsBold.sun,
                ),
                onPressed: () {
                  context.read<AppThemeCubit>().toggleTheme();
                },
              );
            },
          ),
          IconButton(
            onPressed: () {
              _scaffoldKey.currentState!.openEndDrawer();
            },
            icon: Icon(SolarIconsOutline.sidebar),
          ),
          SizedBox(width: 10),
        ],
      ),
      endDrawer: Drawer(
        backgroundColor: Theme.of(context).colorScheme.surface,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                    width: 2,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    SolarIconsOutline.chatRoundDots,
                    size: 24,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'KanaChat',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(SolarIconsOutline.history, size: 20),
              horizontalTitleGap: 8,
              title: Text('History Chat'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(SolarIconsOutline.tuning, size: 20),
              horizontalTitleGap: 8,
              title: Text('Customization'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CustomizationScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          BlocBuilder<ChatMessagesCubit, List<ChatMessageEntity>>(
            builder: (context, state) {
              if (state.isNotEmpty) {
                return Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    controller: _chatScrollController,
                    itemCount: state.length,
                    itemBuilder: (context, index) {
                      return ChatBubble(
                        message: state[index].message,
                        isMe: state[index].isUser,
                        time: state[index].createdAt,
                        isTyping:
                            state[index].isUser == false &&
                            state.length - 1 == index,
                      );
                    },
                  ),
                );
              }
              return Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        SolarIconsOutline.chatRoundDots,
                        size: 70,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Start Chat',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text.rich(
                        TextSpan(
                          text: 'with ',
                          style: TextStyle(fontSize: 16),
                          children: [
                            TextSpan(
                              text: 'KanaAI',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          LinearProgressIndicator(
            value:
                context.watch<PostChatBloc>().state is PostChatLoading
                    ? null
                    : 0,
            color: Theme.of(context).colorScheme.primary,
            backgroundColor: Theme.of(context).colorScheme.surface,
          ),
          Container(
            color: Theme.of(context).colorScheme.surface,
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: BlocBuilder<AppThemeCubit, AppThemeEntity>(
                    builder: (context, state) {
                      return TextField(
                        controller: _inputChatController,
                        decoration: InputDecoration(
                          hintText: 'Type a message...',
                          fillColor:
                              state.isDarkMode
                                  ? AppColors.darkBackground
                                  : AppColors.lightBackground,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            borderSide: BorderSide(
                              color: AppColors.primary,
                              width: 1.5,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 20,
                          ),
                        ),
                        onTapOutside: (event) {
                          FocusScope.of(context).unfocus();
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(width: 8),
                BlocListener<ChatListBloc, ChatListState>(
                  listener: (context, state) {
                    if (state is ChatListError) {
                      showSnackBar(context: context, message: state.message);
                    }
                    if (state is ChatListLoaded) {
                      _goToBottom();
                    }
                  },
                  child: BlocListener<PostChatBloc, PostChatState>(
                    listener: (context, state) {
                      if (state is PostChatSuccess) {
                        context.read<ChatListBloc>().add(
                          ChatListMessageAdded(
                            message: ChatMessageEntity(
                              message: state.message,
                              isUser: false,
                              createdAt: DateTime.now(),
                              // chatHistoryId: '',
                            ),
                          ),
                        );
                        // context.read<ChatTypingCubit>().setTyping(true);
                      }
                    },
                    child: FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(16),
                      ),
                      onPressed: _onSendMessage,
                      child: Icon(SolarIconsOutline.plain3, size: 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
