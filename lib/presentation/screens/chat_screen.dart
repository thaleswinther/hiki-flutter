import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../viewmodel/chat_viewmodel.dart';
import '../../data/database/entity/chat.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  Widget _buildModelChatItem(Chat chat) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.only(right: 100, bottom: 16),
        decoration: BoxDecoration(
          color: Color(0xFFE4AB00),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          chat.prompt,
          style: TextStyle(color: Colors.white, fontSize: 17),
        ),
      ),
    );
  }

  Widget _buildUserChatItem(Chat chat) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.only(left: 100, bottom: 16),
        decoration: BoxDecoration(
          color: Color(0xFFE47444),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          chat.prompt,
          style: TextStyle(color: Colors.white, fontSize: 17),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatViewModel>(
      builder: (context, viewModel, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xFFE4AB00),
            title: Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                ),
                SvgPicture.asset(
                  'assets/images/avatar_icon.svg',
                  width: 48,
                  height: 48,
                ),
                SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Ana", style: TextStyle(color: Color(0xFF372900), fontSize: 20)),
                    Text("Work", style: TextStyle(color: Color(0xFF372900), fontSize: 14)),
                  ],
                ),
                Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.more_vert, color: Colors.white),
                ),
              ],
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  reverse: true,
                  itemCount: viewModel.chatList.length,
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  itemBuilder: (context, index) {
                    final chat = viewModel.chatList[index];
                    if (chat.isFromUser) {
                      return _buildUserChatItem(chat);
                    } else {
                      return _buildModelChatItem(chat);
                    }
                  },
                ),
              ),
              if (viewModel.isLoading)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: LinearProgressIndicator(),
                ),
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Color(0xFFE4AB00),
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
                          fillColor: Color(0xFFFFF7DF),
                          hintText: "Type your message here...",
                          contentPadding: EdgeInsets.symmetric(horizontal: 16),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          ),
                          suffixIcon: viewModel.prompt.isNotEmpty
                              ? IconButton(
                            icon: Icon(Icons.close, color: Colors.grey),
                            onPressed: () {
                              viewModel.updatePrompt('');
                            },
                          )
                              : null,
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    GestureDetector(
                      onTap: viewModel.sendPrompt,
                      child: Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Color(0xFFFFF7DF),
                          borderRadius: BorderRadius.circular(40),
                        ),
                        child: Icon(Icons.send, color: Colors.white, size: 24),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
