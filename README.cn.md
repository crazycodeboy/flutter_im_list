# `flutter_chat_list`

[ ![English](https://img.shields.io/badge/English-feb252.svg)](https://github.com/crazycodeboy/flutter_chat_list)
[![Download](https://img.shields.io/badge/Download-ff69b4.svg) ](https://pub.dartlang.org/packages/flutter_chat_list)
[ ![PRs Welcome](https://img.shields.io/badge/PRs-Welcome-brightgreen.svg)](https://github.com/crazycodeboy/flutter_chat_list/pulls)
[ ![flutter_chat_list release](https://img.shields.io/github/release/crazycodeboy/flutter_chat_list.svg?maxAge=2592000?style=flat-square)](https://github.com/crazycodeboy/flutter_chat_list/releases)
[![License MIT](http://img.shields.io/badge/license-MIT-orange.svg?style=flat)](https://raw.githubusercontent.com/crazycodeboy/flutter_chat_list/master/LICENSE)

[`flutter_chat_list`](https://github.com/crazycodeboy/flutter_chat_list)是一款高性能、轻量级的Flutter聊天列表插件。可以帮助你快速创建出类微信的聊天列表的效果。

## 目录

- [预览图](#预览图)
- [示例](#示例)
- [视频教程](https://coding.imooc.com/class/672.html)
- [如何使用](#如何使用)
- [API](#api)

## 预览图

整体 | 长按 | 输入中 | 动图
---|---|---|---
![flutter_chat_list](https://raw.githubusercontent.com/crazycodeboy/flutter_chat_list/master/example/Screenshots/1.pic.jpg)| ![flutter_chat_list](https://raw.githubusercontent.com/crazycodeboy/flutter_chat_list/master/example/Screenshots/2.pic.jpg)| ![flutter_chat_list](https://raw.githubusercontent.com/crazycodeboy/flutter_chat_list/master/example/Screenshots/4.pic.jpg)| ![flutter_chat_list](https://raw.githubusercontent.com/crazycodeboy/flutter_chat_list/master/example/Screenshots/4.gif)

## 示例
* [Examples](https://github.com/crazycodeboy/flutter_chat_list/tree/master/example)

## [视频教程](https://coding.imooc.com/class/672.html)
欢迎通过[视频教程](https://coding.imooc.com/class/672.html)学习交流。

## 如何使用

### 第一步添加依赖

在项目根目录下运行：

```bash
flutter pub add flutter_chat_list
```
### 第二步：初始化ChatController

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

### 第三步：在布局中添加ChatList

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

### 第四步：设置初始化数据

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
如果没有，可以将_messageList赋值为[]。

>**了解更多请查看[视频教程](https://coding.imooc.com/class/672.html)**

## API

### IChatController
```dart
abstract class IChatController {
  /// 在列表中添加消息
  void addMessage(MessageModel message);
  /// 在列表中删除消息
  void deleteMessage(MessageModel message);
  /// 批量添加消息（适用于下来加载更多的场景）
  void loadMoreData(List<MessageModel> messageList);
}
```

### ChatController

```dart
class ChatController implements IChatController {
  /// 列表的初始化数据可以为[]
  final List<MessageModel> initialMessageList;
  final ScrollController scrollController;

  ///支持提供一个MessageWidgetBuilder来自定义气泡样式
  final MessageWidgetBuilder? messageWidgetBuilder;

  ///设置显示的时间分组的间隔，单位秒
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
  /// ChatList的控制器
  final ChatController chatController;

  /// 插入子项的空间大小
  final EdgeInsetsGeometry? padding;

  /// 气泡点击事件
  final OnBubbleClick? onBubbleTap;

  /// 奇葩长按事件
  final OnBubbleClick? onBubbleLongPress;
  /// 文本选择回调
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
>**了解更多请查看[视频教程](https://coding.imooc.com/class/672.html)**

## Contribution

欢迎在[issues](https://github.com/crazycodeboy/flutter_chat_list/issues)上报告问题。请附上bug截图和代码片段。解决问题的最快方法是在示例中重现它。

欢迎提交拉取请求。如果您想更改API或执行重大操作，最好先创建一个问题并进行讨论。

---

**[MIT Licensed](https://github.com/crazycodeboy/flutter_chat_list/blob/master/LICENSE)**
