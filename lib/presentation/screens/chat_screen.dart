import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hiki_flutter/utils/color.dart';
import 'package:provider/provider.dart';
import '../viewmodel/chat_viewmodel.dart';
import '../../data/database/entity/chat.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  Widget _buildModelChatItem(Chat chat, String prompt) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(right: 100, bottom: 16),
        decoration: BoxDecoration(
          color: primary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          prompt,
          style: const TextStyle(color: white, fontSize: 17),
        ),
      ),
    );
  }

  Widget _buildUserChatItem(Chat chat, String prompt) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(left: 100, bottom: 16),
        decoration: BoxDecoration(
          color: redLess,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          prompt,
          style: const TextStyle(color: white, fontSize: 17),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Consumer<ChatViewModel>(
      builder: (context, viewModel, child) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(96),
            child: AppBar(
              backgroundColor: primary,
              automaticallyImplyLeading: false,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
              ),
              flexibleSpace: Padding(
                padding: const EdgeInsets.only(top: 32, bottom: 4),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        iconSize: 20,
                        icon: const Icon(Icons.arrow_back_ios, color: white),
                      ),
                      SvgPicture.asset(
                        'assets/images/avatar_icon.svg',
                        width: 48,
                        height: 48,
                      ),
                      const SizedBox(width: 8),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Ana"  , style: TextStyle(color: black, fontSize: 20)),
                          Text(localizations.work, style: TextStyle(color: black, fontSize: 14)),
                        ],
                      ),
                      const Spacer(),
                      IconButton(
                        iconSize: 24,
                        onPressed: () {},
                        icon: const Icon(Icons.more_vert, color: white),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    reverse: true,
                    itemCount: viewModel.chatList.length,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    itemBuilder: (context, index) {
                      final chat = viewModel.chatList[index];
                      final prompt = chat.prompt; // Aqui pode ser necessário usar alguma lógica para tradução
                      if (chat.isFromUser) {
                        return _buildUserChatItem(chat, prompt);
                      } else {
                        return _buildModelChatItem(chat, prompt);
                      }
                    },
                  ),
                ),
                if (viewModel.isLoading)
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: LinearProgressIndicator(
                      color: redLess,
                    ),
                  ),
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    color: primary,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: viewModel.textController,
                          onChanged: viewModel.updatePrompt,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: white,
                            hintText: localizations.type_message_here,
                            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none,
                            ),
                            suffixIcon: viewModel.prompt.isNotEmpty
                                ? IconButton(
                              icon: const Icon(Icons.close, color: Colors.grey),
                              onPressed: () {
                                viewModel.textController.clear();
                                viewModel.updatePrompt('');
                              },
                            )
                                : null,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      IconButton(
                        icon: const Icon(Icons.send, color: white, size: 36),
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          viewModel.sendPrompt();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
