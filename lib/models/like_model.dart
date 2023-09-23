class LikeModel {
  String? userId;
  int? postId;

  LikeModel({this.userId, this.postId});

  LikeModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    postId = json['post_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['post_id'] = postId;
    return data;
  }
}
