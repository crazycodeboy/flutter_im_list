import 'package:flutter/widgets.dart';

enum OwnerType { receiver, sender }

OwnerType _of(String name) {
  if (name == OwnerType.receiver.toString()) {
    return OwnerType.receiver;
  } else {
    return OwnerType.sender;
  }
}

class MessageModel {
  /// Provides id
  final int? id;

  /// Avoid rebuilding the message widget when new incoming messages refresh the list.
  final GlobalKey key;

  /// Controls who is sending or receiving a message.
  /// Used to handle in which side of the screen the message
  /// will be displayed.
  final OwnerType ownerType;

  /// Name to be displayed with the initials.
  /// egg.: Higor Lapa will be H
  final String? ownerName;

  /// avatar url
  final String? avatar;

  /// The content to be displayed as a message.
  final String content;

  /// Provides message created time,milliseconds since.
  final int createdAt;

  ///Whether to display the creation time.
  bool showCreatedTime = false;

  MessageModel(
      {this.id,
      required this.ownerType,
      this.ownerName,
      this.avatar,
      required this.content,
      required this.createdAt})
      : key = GlobalKey();

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        id: json["id"],
        content: json["content"],
        createdAt: json["createdAt"],
        ownerType: _of(json["ownerType"]),
        avatar: json["avatar"],
        ownerName: json["ownerName"],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'content': content,
        'createdAt': createdAt,
        'ownerName': ownerName,
        //数据库存储不支持复合类型
        'ownerType': ownerType.toString(),
        'avatar': avatar
      };
}
