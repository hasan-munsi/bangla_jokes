import 'package:http/http.dart' as http;

class FetchJokes {
  final String url;
  FetchJokes(this.url);
  Future getJokes() async {
    http.Response response = await http.get(url);
    return response.body;
  }
}
