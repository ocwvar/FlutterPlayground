import 'dart:math';

class SimpleItemModel {
  final String text1;
  final String text2;

  SimpleItemModel(this.text1, this.text2);
}

class SimpleItemRepository {

  /// generate a new model
  SimpleItemModel create() {
    final String text1 = Random().nextInt(5000).toString();
    final String text2 = Random().nextInt(100).toString();

    return SimpleItemModel(text1, text2);
  }

}