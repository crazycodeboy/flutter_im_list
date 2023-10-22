import 'package:flutter/material.dart';

import '../core/chat_controller.dart';
import '../models/message_model.dart';
import 'message_widget.dart';

class ChatList extends StatefulWidget {
  /// Provides controller for accessing few function for running chat.
  final ChatController chatController;

  /// The amount of space by which to inset the children.
  final EdgeInsetsGeometry? padding;

  /// Called when the user taps this part of the material.
  final OnBubbleClick? onBubbleTap;

  /// Called when the user long-presses on this part of the material.
  final OnBubbleClick? onBubbleLongPress;
  final HiSelectionArea? hiSelectionArea;

  const ChatList(
      {super.key,
      required this.chatController,
      this.padding,
      this.onBubbleTap,
      this.onBubbleLongPress,
      this.hiSelectionArea});

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  ChatController get chatController => widget.chatController;

  MessageWidgetBuilder? get messageWidgetBuilder =>
      chatController.messageWidgetBuilder;

  ScrollController get scrollController => chatController.scrollController;

  Widget get _chatStreamBuilder {
    return StreamBuilder<List<MessageModel>>(
      stream: chatController.messageStreamController.stream,
      builder: (context, snapshot) {
        return snapshot.connectionState == ConnectionState.active
            ? ListView.builder(
                reverse: true,
                shrinkWrap: true,
                padding: widget.padding,
                controller: scrollController,
                itemCount: snapshot.data?.length ?? 0,
                itemBuilder: (BuildContext buildContext, int index) {
                  var model = snapshot.data![index];
                  return DefaultMessageWidget(
                    key: model.key,
                    message: model,
                    hiSelectionArea: widget.hiSelectionArea,
                    messageWidget: messageWidgetBuilder,
                    onBubbleTap: widget.onBubbleTap,
                    onBubbleLongPress: widget.onBubbleLongPress,
                  );
                },
              )
            : const Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    chatController.widgetReady();
  }

  @override
  Widget build(context) {
    //配合shrinkWrap: true使用，解决数据少的时候数据底部对齐的问题
    return Align(
      alignment: Alignment.topCenter,
      child: _chatStreamBuilder,
    );
  }

  @override
  void dispose() {
    chatController.dispose();
    super.dispose();
  }
}
