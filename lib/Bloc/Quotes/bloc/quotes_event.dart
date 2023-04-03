part of 'quotes_bloc.dart';

@immutable
abstract class QuotesEvent {}

class QuotesEventLoad extends QuotesEvent {
  final String query;
  final int page;
  QuotesEventLoad(this.page, {this.query = 'albert-einstein'});
}
class allQuotesEventLoad extends QuotesEvent {
  final String query;
  final int limit;
  allQuotesEventLoad(this.limit, {this.query = 'albert-einstein'});
}

class QuotesEventRefresh extends QuotesEvent {}

class QuotesEventSearch extends QuotesEvent {
  final String query;
  QuotesEventSearch({required this.query});
}
