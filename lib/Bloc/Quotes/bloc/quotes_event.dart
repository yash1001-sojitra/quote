part of 'quotes_bloc.dart';

@immutable
abstract class QuotesEvent {}

class QuotesEventLoad extends QuotesEvent {
  final String query;
  QuotesEventLoad({this.query = ''});
}

class QuotesEventRefresh extends QuotesEvent {}

class QuotesEventSearch extends QuotesEvent {
  final String query;
  QuotesEventSearch({required this.query});
}
