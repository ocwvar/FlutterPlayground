class HomeModel {
  /// page type list
  final List<PageModel> pages = [
    PageModel("Dynamic list content", PageType.dynamicList),
    PageModel("Remote image fetching", PageType.remoteImage),
  ];
}

class PageModel {
  final String title;
  final PageType pageType;

  PageModel(this.title, this.pageType);
}

enum PageType { dynamicList, remoteImage }


