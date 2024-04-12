import 'package:get/get.dart';

class PostModel {
  PostModel({
      List<PostData>? data,}){
    _data = data;
}

  PostModel.fromJson(dynamic json) {
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data?.add(PostData.fromJson(v));
      });
    }
  }
  List<PostData>? _data;

  List<PostData>? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_data != null) {
      map['data'] = _data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class PostData {
  PostData({
      int? userId,
      int? id,
      String? title, 
      String? body,
    Rx<bool>? isLiked
  }){
    _userId = userId;
    _id = id;
    _title = title;
    _body = body;
    _isLiked = isLiked;
}

  PostData.fromJson(dynamic json) {
    _userId = json['userId'];
    _id = json['id'];
    _title = json['title'];
    _body = json['body'];
    _isLiked = false.obs;
  }
  int? _userId;
  int? _id;
  String? _title;
  String? _body;
  Rx<bool>? _isLiked;

  int? get userId => _userId;
  int? get id => _id;
  String? get title => _title;
  String? get body => _body;

  set setIsLiked(Rx<bool>? val) {
    _isLiked = val;
  }

  Rx<bool>? get isLiked => _isLiked;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userId'] = _userId;
    map['id'] = _id;
    map['title'] = _title;
    map['body'] = _body;
    return map;
  }



}