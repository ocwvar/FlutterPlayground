class SelectStateModel<T> {
  final T object;
  bool _selected = false;
  bool get isSelected => _selected;

  SelectStateModel(this.object);

  void updateSelectState(bool newState) {
    _selected = newState;
  }
}