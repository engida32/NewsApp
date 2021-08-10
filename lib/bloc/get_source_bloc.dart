import 'package:newsapp/model/source_response.dart';
import 'package:newsapp/repository/repository.dart';
import 'package:rxdart/rxdart.dart';

class GetSourcesBloc {
  final NewsRepository repository = NewsRepository();
  final BehaviorSubject<SourceResponse> subject =
      BehaviorSubject<SourceResponse>();
  getSources() async {
    SourceResponse response = await repository.getSources();
    subject.sink.add(response);
  }
}
 final getSourcesBloc = GetSourcesBloc();