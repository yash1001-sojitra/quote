part of 'favourite_bloc.dart';

@immutable
abstract class FavouriteState {}

class FavouriteInitial extends FavouriteState {}

class FavouriteLoading extends FavouriteState {}

class FavouriteLoaded extends FavouriteState {
  final List<Results> quotes;
  FavouriteLoaded({required this.quotes});
}

class FavouriteError extends FavouriteState {
  final String message;
  FavouriteError({required this.message});
}

class FavouriteEmpty extends FavouriteState {}

// class AddtoFavouriteState extends FavouriteState {
//   final QuotesModel quotes;
//   AddtoFavouriteState({required this.quotes});
// }

// class RemovefromFavouriteState extends FavouriteState {
//   final QuotesModel quotes;
//   RemovefromFavouriteState({required this.quotes});
// }
