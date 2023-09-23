import 'package:threads_clone/models/user_model.dart';

class CommentModel {
  int? id;
  String? reply;
  String? createdAt;
  String? userId;
  UserModel? user;

  CommentModel({this.id, this.reply, this.createdAt, this.userId, this.user});

  CommentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    reply = json['reply'];
    createdAt = json['created_at'];
    userId = json['user_id'];
    user = json['user'] != null ? UserModel.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['reply'] = reply;
    data['created_at'] = createdAt;
    data['user_id'] = userId;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}
