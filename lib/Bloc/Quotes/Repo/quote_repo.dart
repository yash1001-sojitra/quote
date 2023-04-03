import 'package:dio/dio.dart';

import '../Model/quotes_model.dart';

class QuotesRepo {
  Dio _dio = Dio();
  Future<QuotesModel> getQuotesbyAuthor(String query, int page) async {
    final response = await _dio
        .get('https://api.quotable.io/quotes?author=$query&page=$page');

    return QuotesModel.fromMap(response.data);
  }

  Future<QuotesModel> getAllQuotes(String query, int pageid, int limit) async {
    final response = await _dio.get(
        'https://api.quotable.io/quotes?quotes=$query&page=$pageid&limit=$limit');

    return QuotesModel.fromMap(response.data);
  }
}
