import 'package:chat_message/core/chat_controller.dart';
import 'package:chat_message/models/message_model.dart';
import 'package:chat_message/widget/chat_list_widget.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ChatMessage Example',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'ChatMessage Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, this.title = ""}) : super(key: key);
  final String title;

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  int count = 0;
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
  late ChatController chatController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
          children: [
            Expanded(
                child: ChatList(
              chatController: chatController,
            )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                    onPressed: _loadMore, child: const Text('loadMore')),
                ElevatedButton(onPressed: _send, child: const Text('Send'))
              ],
            ),
            const SizedBox(
              height: 20,
            )
          ],
        ));
  }

  @override
  void initState() {
    super.initState();
    chatController = ChatController(
        initialMessageList: _messageList,
        timePellet: 60,
        // messageWidgetBuilder: _diyMessageWidget,
        scrollController: ScrollController());
  }

  void _send() {
    chatController.addMessage(MessageModel(
        content: "I'm just a copy,${count++}",
        ownerType: OwnerType.sender,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        avatar: 'https://o.devio.org/images/o_as/avatar/tx18.jpeg',
        ownerName: "Higor"));
    Future.delayed(const Duration(milliseconds: 2000), () {
      chatController.addMessage(
        MessageModel(
            content: "Nice",
            createdAt: DateTime.now().millisecondsSinceEpoch,
            ownerType: OwnerType.receiver,
            avatar: 'https://o.devio.org/images/o_as/avatar/tx2.jpeg',
            ownerName: "Bill Gates,${count++}"),
      );
    });
  }

  int _counter = 0;

  void _loadMore() {
    var tl = 1696142392000;
    tl = tl - ++_counter * 1000000;
    final List<MessageModel> messageList = [
      MessageModel(
          id: 3,
          content: "讲一个笑话",
          ownerType: OwnerType.sender,
          createdAt: tl,
          avatar: 'https://o.devio.org/images/o_as/avatar/tx18.jpeg',
          ownerName: "Jack"),
      MessageModel(
          id: 4,
          content: "那年愚人节，班上女神给了我一个奥利奥，我二话不说就咬了一口，才发现里面是牙膏。 ",
          ownerType: OwnerType.receiver,
          createdAt: tl,
          avatar: 'https://o.devio.org/images/o_as/avatar/tx2.jpeg',
          ownerName: "ChatGPT")
    ];
    chatController.loadMoreData(messageList);
  }

  ///Provide MessageWidgetBuilder to customize your bubble style.
  Widget _diyMessageWidget(MessageModel message) {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      padding: const EdgeInsets.only(top: 30, bottom: 30),
      decoration: BoxDecoration(
          color: message.ownerType == OwnerType.sender
              ? Colors.amberAccent
              : Colors.redAccent),
      child: Text('${message.ownerName}: ${message.content}'),
    );
  }
}
