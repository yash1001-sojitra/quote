import 'package:dio/dio.dart';

import '../Model/quotes_model.dart';

class QuotesRepo {
  Dio _dio = Dio();
  Future<QuotesModel> getQuotesbyAuthor(String query) async {
    final response =
        await _dio.get('https://api.quotable.io/search/authors?query=$query');

    response.data['results'];
    return QuotesModel.fromMap(response.data);
  }

  Future<QuotesModel> getAllQuotes(String query) async {
    final response = await _dio
        .get('https://api.quotable.io/search/quotes?query=$query&limit=10');

    response.data['results'];
    return QuotesModel.fromMap(response.data);
  }
}
