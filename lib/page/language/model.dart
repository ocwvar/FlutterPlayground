class LanguagePlaceHolderModel {

  final Map<int, String> _placeHolders = {};

  void updatePlaceHolder(int index, String value) {
    _placeHolders[index] = value;
  }

  String get(int index) {
    final String? value = _placeHolders[index];
    if (value == null) return "";
    return value;
  }

}