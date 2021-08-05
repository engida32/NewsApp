import 'package:newsapp/model/article_response.dart';
import 'package:newsapp/model/source.dart';

class SourceResponse {
  final List<SourceModel> sources;
  final String error;
  SourceResponse(this.sources, this.error);
  SourceResponse.fromjson(Map<String,dynamic> json)
    :sources =(json["sources"] as List).map((i) => new SourceModel.fromJson(i)).toList(),
    error ="";

    SourceResponse.withError(String errorValue)
      :sources=[],
      error =errorValue;
  
}
