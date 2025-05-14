
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanachat/core/common/bloc/app_theme_cubit/app_theme_cubit.dart';
import 'package:kanachat/core/common/entities/app_theme_entity.dart';
import 'package:kanachat/core/themes/app_colors.dart';
import 'package:kanachat/features/settings/presentation/screens/customization_screen.dart';
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
              leading: Icon(SolarIconsOutline.settings, size: 20),
              horizontalTitleGap: 8,
              title: Text('Settings'),
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
          Expanded(
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
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
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

            // child: ListView.builder(
            //   padding: const EdgeInsets.all(16),
            //   controller: _chatScrollController,
            //   itemCount: 100,
            //   itemBuilder: (context, index) {
            //     return ChatBubble(
            //       message:
            //           'message $index - lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
            //       isMe: Random().nextBool(),
            //       time: '12:00',
            //     );
            //   },
            // ),
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
                FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(16),
                  ),
                  onPressed: () {},
                  child: Icon(SolarIconsOutline.plain3, size: 20),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
