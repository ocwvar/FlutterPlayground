class HomeModel {
  /// page type list
  final List<PageModel> pages = [
    PageModel("Text styles", PageType.textStyles),
    PageModel("System information", PageType.systemInfo),
    PageModel("Dynamic list content", PageType.dynamicList),
    PageModel("Remote image fetching", PageType.remoteImage),
    PageModel("Multi language support", PageType.multiLanguage),
    PageModel("Platform specific code calling", PageType.platformSpecific),
    PageModel("Accessibility", PageType.accessibility),
    PageModel("Page state keeping", PageType.keepState),
  ];
}

class PageModel {
  final String title;
  final PageType pageType;

  PageModel(this.title, this.pageType);
}

enum PageType {
  textStyles,
  systemInfo,
  dynamicList,
  remoteImage,
  multiLanguage,
  platformSpecific,
  accessibility,
  keepState
}


