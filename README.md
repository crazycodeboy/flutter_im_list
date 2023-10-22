# `flutter_im_list`

[ ![语言 中文](https://img.shields.io/badge/语言-中文-feb252.svg)](https://github.com/crazycodeboy/flutter_im_list/blob/master/README.cn.md)
[![Download](https://img.shields.io/badge/Download-ff69b4.svg) ](https://pub.dartlang.org/packages/flutter_im_list)
[ ![PRs Welcome](https://img.shields.io/badge/PRs-Welcome-brightgreen.svg)](https://github.com/crazycodeboy/flutter_im_list/pulls)
[ ![flutter_im_list release](https://img.shields.io/github/release/crazycodeboy/flutter_im_list.svg?maxAge=2592000?style=flat-square)](https://github.com/crazycodeboy/flutter_im_list/releases)
[![License MIT](http://img.shields.io/badge/license-MIT-orange.svg?style=flat)](https://raw.githubusercontent.com/crazycodeboy/flutter_im_list/master/LICENSE)

[`flutter_im_list`](https://github.com/crazycodeboy/flutter_im_list) is a high-performance, lightweight Flutter chat list package. It can help you quickly create a WeChat-like chat list effect.

## Content

- [Screenshots](#screenshots)
- [Examples](#examples)
- [Video tutorial](https://coding.imooc.com/class/672.html)
- [Getting started](#getting-started)
- [API](#api)
- [Contribution](#contribution)

## Screenshots

Overall | Long press | Inputting                                                                                                                   | GIF
---|---|-----------------------------------------------------------------------------------------------------------------------------|---
![flutter_im_list](https://raw.githubusercontent.com/crazycodeboy/flutter_im_list/master/example/Screenshots/1.pic.jpg)| ![flutter_im_list](https://raw.githubusercontent.com/crazycodeboy/flutter_im_list/master/example/Screenshots/2.pic.jpg)| ![flutter_im_list](https://raw.githubusercontent.com/crazycodeboy/flutter_im_list/master/example/Screenshots/3.pic.jpg) | ![flutter_im_list](https://raw.githubusercontent.com/crazycodeboy/flutter_im_list/master/example/Screenshots/4.gif)

## Examples

* [Examples](https://github.com/crazycodeboy/flutter_im_list/tree/master/example)

## [Video tutorial](https://coding.imooc.com/class/672.html)
Welcome to learn and communicate through [Video tutorial](https://coding.imooc.com/class/672.html).

## Getting started

### Step 1: Add dependencies

Run in the project root directory:

```bash
flutter pub add flutter_im_list
```
### Step 2: Initialize ChatController

```dart
@override
void initState() {
super.initState();
chatController = ChatController(
    initialMessageList: _messageList,
    timePellet: 60,
    scrollController: ScrollController());
}
```

### Step 3: Add ChatList to the layout

```dart
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: ChatList(
          chatController: chatController,
        ));
  }
```

### Step 4: Set initialization data

```dart
final List<MessageModel> _messageList = [
MessageModel(
    id: 1,
    content: "介绍下《ChatGPT + Flutter快速开发多端聊天机器人App》",
    ownerType: OwnerType.sender,
    createdAt: 1696142392000,
    avatar: 'https://o.devio.org/images/o_as/avatar/tx18.jpeg',
    ownerName: "Jack"),
MessageModel(
    id: 2,
    content:
        "当前ChatGPT应用如雨后春笋般应运而生，给移动端开发者也带来了极大的机会。本课程将整合ChatGPT与Flutter高级技术，手把手带你从0到1开发一款可运行在多端的聊天机器人App，帮助你抓住机遇，快速具备AI运用能力，成为移动端领域的AI高手。@https://coding.imooc.com/class/672.html",
    ownerType: OwnerType.receiver,
    createdAt: 1696142393000,
    avatar: 'https://o.devio.org/images/o_as/avatar/tx2.jpeg',
    ownerName: "ChatGPT"),
];
```
If not, you can assign _messageList to []。

>**To learn more see [Video tutorial](https://coding.imooc.com/class/672.html)**


## API

### IChatController
```dart
abstract class IChatController {
  /// Used to add message in message list.
  void addMessage(MessageModel message);

  /// Delete message.
  void deleteMessage(MessageModel message);
  /// Function for loading data while pagination.
  void loadMoreData(List<MessageModel> messageList);
}

```

### ChatController

```dart
class ChatController implements IChatController {
  /// Represents initial message list in chat which can be add by user.
  final List<MessageModel> initialMessageList;
  final ScrollController scrollController;

  ///Provide MessageWidgetBuilder to customize your bubble style.
  final MessageWidgetBuilder? messageWidgetBuilder;

  ///creation time group; unit second
  final int timePellet;
  List<int> pelletShow = [];

  ChatController({required this.initialMessageList,
    required this.scrollController,
    required this.timePellet,
    this.messageWidgetBuilder}) {
    for (var message in initialMessageList.reversed) {
      inflateMessage(message);
    }
  }
...
```

### ChatList

```dart
class ChatList extends StatefulWidget {
  /// Provides controller for accessing few function for running chat.
  final ChatController chatController;

  /// The amount of space by which to inset the children.
  final EdgeInsetsGeometry? padding;

  /// Called when the user taps this part of the material.
  final OnBubbleClick? onBubbleTap;

  /// Called when the user long-presses on this part of the material.
  final OnBubbleClick? onBubbleLongPress;
  /// support text select
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
```
>**To learn more see [Video tutorial](https://coding.imooc.com/class/672.html)**

## Contribution

Issues are welcome. Please add a screenshot of you bug and a code snippet. Quickest way to solve
issue is to reproduce it in one of the examples.

Pull requests are welcome. If you want to change the API or do something big it is best to create an
issue and discuss it first.

---

**[MIT Licensed](https://github.com/crazycodeboy/flutter_im_list/blob/master/LICENSE)**
