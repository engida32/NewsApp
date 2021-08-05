import 'package:newsapp/model/source.dart';

class SourceResponse {

  final List<SourceModel> source;
  final String error;
  SourceResponse.withError(String errorValue)
      : source = [],
        error = errorValue;
}
