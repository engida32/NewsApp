import 'package:newsapp/model/article_response.dart';
import 'package:newsapp/repository/repository.dart';
import 'package:rxdart/subjects.dart';

class GetSourcesNewsBloc {
  final NewsRepository repository = NewsRepository();
  final BehaviorSubject<ArticleResponse> _subject =
      BehaviorSubject<ArticleResponse>();

        getSourceNews(String sourceId) async {
    ArticleResponse response = await repository.getSourceNews(sourceId);
    _subject.sink.add(response);
  }

  void drainStreams() {
    _subject.value = null;
    
  }


  void dispose() async {
    await _subject.drain();
    _subject.close();
  }

  BehaviorSubject<ArticleResponse> get subject => _subject;
}

final getSourceNewsBloc = GetSourcesNewsBloc();