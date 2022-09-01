class Comm {
  static String getNameFromBlogUrl(String url) {
    return url.replaceFirst("https://www.cnblogs.com/", "").split("/")[0];
  }
}
