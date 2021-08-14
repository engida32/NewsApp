import 'package:dio/dio.dart';
import 'package:newsapp/model/article_response.dart';
import 'package:newsapp/model/source_response.dart';

class NewsRepository {
  static String mainUrl = "https://newsapi.org/v2/";
  final String apiKey = "68fc81a3058546c59fcd4fef22cb005c";
  final Dio _dio = Dio();
  var getSourceUrl = '$mainUrl/sources';
  var getTopHeadlinesUrl = '$mainUrl/top-headlines';
  var everythingUrl = '$mainUrl/everything';
  var source2 = 'https://newsapi.org/v2/"top-headlines/sources';

  Future<SourceResponse> getSources() async {
    var params = {"apiKey": apiKey, "language": "en", "country": "us"};

    try {
      Response response = await _dio.get(getSourceUrl, queryParameters: params);
      print(response.data.toString());

      return SourceResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print(" Exception occured : $error stacktrace :$stacktrace");
      return SourceResponse.withError("$error");
    }
  }

//get top head lines from api
  Future<ArticleResponse> getTopHeadLines() async {
    var params = {
      "apiKey": apiKey,
      "country": "us",
      "publishedAt": "publishedAt"
    };
    try {
      Response response =
          await _dio.get(getTopHeadlinesUrl, queryParameters: params);
      return ArticleResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      print(
          "no result ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,");

      return ArticleResponse.withError("$error");
    }
  }

  ////////
  Future<ArticleResponse> search(String value) async {
    var params = {
     "apiKey": apiKey,
     "q": value,
     "sortBy": "Popularity"
      };
    try {
      Response response =
          await _dio.get(everythingUrl, queryParameters: params);
      return ArticleResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return ArticleResponse.withError("$error");
    }
  }

  //////// getting hot news from repository
  Future<ArticleResponse> getHotNews() async {
    var params = {
      "apiKey": apiKey,
      "q": "technology + politics ",
      "sortBy": "date",
      
      
      };

    try {
      Response response =
          await _dio.get(everythingUrl, queryParameters: params);
      return ArticleResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return ArticleResponse.withError("$error");
    }
  }

  Future<ArticleResponse> getSourceNews(String sourceId) async {
    var params = {"apiKey": apiKey, "sources": sourceId};
    try {
      Response response =
          await _dio.get(getTopHeadlinesUrl, queryParameters: params);
      return ArticleResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return ArticleResponse.withError("$error");
    }
  }
}
