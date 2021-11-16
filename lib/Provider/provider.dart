import 'package:app/model.dart';
import 'package:flutter/cupertino.dart';

class BookmarkBloc extends ChangeNotifier {
  int _count = 0;
  List<Post> post = [];

  void addCount() {
    _count++;
    notifyListeners();
  }

  void deleteCount() {
    _count--;
    notifyListeners();
  }

  void addItems(Post data) {
    post.add(data);
    notifyListeners();
  }

  void removeItem(Post data) {
    post.remove(data);
    notifyListeners();
  }

  int get count {
    return _count;
  }

  List<Post> get itemsList {
    return post;
  }
}
