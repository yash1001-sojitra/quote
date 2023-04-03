part of 'quotes_bloc.dart';

@immutable
abstract class QuotesState {}

class QuotesInitial extends QuotesState {}

class QuotesLoading extends QuotesState {}

class QuotesLoaded extends QuotesState {
  final QuotesModel quotes;
  QuotesLoaded({required this.quotes});
}

class QuotesError extends QuotesState {
  final String message;
  QuotesError({required this.message});
}
