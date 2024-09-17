import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/chat_viewmodel.dart';
import '../../data/database/entity/chat.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  Widget _buildChatBubble(Chat chat) {
    return Align(
      alignment: chat.isFromUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.all(12),
        margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        decoration: BoxDecoration(
          color: chat.isFromUser ? Colors.blue : Colors.grey[300],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          chat.prompt,
          style: TextStyle(color: chat.isFromUser ? Colors.white : Colors.black),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatViewModel>(
      builder: (context, viewModel, child) {
        return Scaffold(
          appBar: AppBar(title: Text('Chat')),
          body: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  reverse: true,
                  itemCount: viewModel.chatList.length,
                  itemBuilder: (context, index) {
                    final chat = viewModel.chatList[index];
                    return _buildChatBubble(chat);
                  },
                ),
              ),
              if (viewModel.isLoading) LinearProgressIndicator(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: viewModel.textController,
                        onChanged: viewModel.updatePrompt,
                        decoration: InputDecoration(hintText: 'Type your message...'),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.send),
                      onPressed: viewModel.sendPrompt,
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
