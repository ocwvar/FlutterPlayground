import 'package:flutter/material.dart';
import 'package:flutter_playground/page/dynamic_list/repository.dart';

class DynamicListViewModel extends ChangeNotifier {

  final SimpleItemRepository _repository = SimpleItemRepository();
  final List<SimpleItemModel> _models = [];

  /// current model list length
  int count() {
    return _models.length;
  }

  SimpleItemModel index(int index) {
    return _models[index];
  }

  /// create and add new item into model list
  void add() {
    _models.add(_repository.create());
    _update();
  }

  /// remove last item in model list
  void remove() {
    if (_models.isNotEmpty) {
      _models.removeLast();
      _update();
    }
  }

  /// notify data changed
  void _update() {
    notifyListeners();
  }

}