import 'dart:async';

import 'package:flutter/material.dart';

import '../models/message_model.dart';
import '../widget/message_widget.dart';

class ChatController implements IChatController {
  /// Represents initial message list in chat which can be add by user.
  final List<MessageModel> initialMessageList;
  final ScrollController scrollController;

  ///Provide MessageWidgetBuilder to customize your bubble style.
  final MessageWidgetBuilder? messageWidgetBuilder;

  ///creation time group; unit second
  final int timePellet;
  List<int> pelletShow = [];

  ChatController(
      {required this.initialMessageList,
      required this.scrollController,
      required this.timePellet,
      this.messageWidgetBuilder}) {
    for (var message in initialMessageList.reversed) {
      inflateMessage(message);
    }
  }

  /// Represents message stream of chat
  StreamController<List<MessageModel>> messageStreamController =
      StreamController();

  /// Used to dispose stream.
  void dispose() {
    messageStreamController.close();
    scrollController.dispose();
    initialMessageList.clear();
    pelletShow.clear();
  }

  ///ChatList is init ok
  void widgetReady() {
    if (!messageStreamController.isClosed) {
      messageStreamController.sink.add(initialMessageList);
    }
  }

  /// Used to add message in message list.
  @override
  void addMessage(MessageModel message) {
    //fix Bad state: Cannot add event after closing
    if (messageStreamController.isClosed) return;
    inflateMessage(message);
    // initialMessageList.add(message);
    //List反转后列是从底部向上展示，所以新来的消息需要插入到数据第0个位置
    initialMessageList.insert(0, message);
    messageStreamController.sink.add(initialMessageList);
    scrollToLastMessage();
  }

  @override
  void deleteMessage(MessageModel message) {
    if (messageStreamController.isClosed) return;
    initialMessageList.remove(message);
    pelletShow.clear();
    //时间的标记是从最久的消息开始标
    for (var message in initialMessageList.reversed) {
      inflateMessage(message);
    }
    messageStreamController.sink.add(initialMessageList);
  }

  /// Function for loading data while pagination.
  @override
  void loadMoreData(List<MessageModel> messageList) {
    //List反转后列是从底部向上展示，所以消息顺序也需要进行反转
    messageList = List.from(messageList.reversed);
    List<MessageModel> tempList = [...initialMessageList, ...messageList];
    //Clear record and redo
    pelletShow.clear();
    //时间的标记是从最久的消息开始标
    for (var message in tempList.reversed) {
      inflateMessage(message);
    }
    initialMessageList.clear();
    initialMessageList.addAll(tempList);
    if (messageStreamController.isClosed) return;
    messageStreamController.sink.add(initialMessageList);
  }

  /// Function to scroll to last messages in chat view
  void scrollToLastMessage() {
    //fix ScrollController not attached to any scroll views.
    if (!scrollController.hasClients) {
      return;
    }
    scrollController.animateTo(0,
        duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
  }

  ///set showCreatedTime flag
  inflateMessage(MessageModel message) {
    int pellet = (message.createdAt / (timePellet * 1000)).truncate();
    if (!pelletShow.contains(pellet)) {
      pelletShow.add(pellet);
      message.showCreatedTime = true;
    } else {
      message.showCreatedTime = false;
    }
  }
}

abstract class IChatController {
  /// Used to add message in message list.
  void addMessage(MessageModel message);

  /// Delete message.
  void deleteMessage(MessageModel message);

  /// Function for loading data while pagination.
  void loadMoreData(List<MessageModel> messageList);
}
