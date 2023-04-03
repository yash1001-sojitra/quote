part of 'favourite_bloc.dart';

@immutable
abstract class FavouriteEvent {}

class GetFavourite extends FavouriteEvent {}

class AddtoFavourite extends FavouriteEvent {
  final Results quotes;
  AddtoFavourite({required this.quotes});
}

class RemovefromFavourite extends FavouriteEvent {
  final Results quotes;
  RemovefromFavourite({required this.quotes});
}

class ClearFavourite extends FavouriteEvent {}

class SearchQuotesEvent extends FavouriteEvent {
  final String query;
  SearchQuotesEvent({required this.query});
}
