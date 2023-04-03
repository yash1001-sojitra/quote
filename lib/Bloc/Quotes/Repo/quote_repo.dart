import 'package:dio/dio.dart';

import '../Model/quotes_model.dart';

class QuotesRepo {
  Dio _dio = Dio();
  Future<QuotesModel> getQuotesbyAuthor(String query) async {
    final response =
        await _dio.get('https://api.quotable.io/quotes?author=$query');

    return QuotesModel.fromMap(response.data);
  }

  Future<QuotesModel> getAllQuotes(String query, int pageid) async {
    final response = await _dio
        .get('https://api.quotable.io/quotes?quotes=$query&page=$pageid');

    response.data['results'];
    return QuotesModel.fromMap(response.data);
  }
}
