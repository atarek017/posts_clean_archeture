abstract class Constants {
  /// api
  static const String BASE_URL = "https://jsonplaceholder.typicode.com";
  static const Map<String, String> HEADERS = {"content_type": "json"};

  /// api routes
  static const String postsRoute = "/posts/";

  /// shard pref
  static const String CACHED_POSTS = "CACHED_POSTS";
}
