import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:quote/Bloc/Quotes/Model/quotes_model.dart';

part 'favourite_event.dart';
part 'favourite_state.dart';

class FavouriteBloc extends Bloc<FavouriteEvent, FavouriteState> {
  FavouriteBloc() : super(FavouriteInitial()) {
    List<Results> listquotes = [];
    on<FavouriteEvent>((event, emit) {
      if (event is GetFavourite) {
        emit(FavouriteLoading());
        emit(FavouriteLoaded(quotes: listquotes));
      } else if (event is AddtoFavourite) {
        if (!listquotes.contains(event.quotes)) {
          listquotes.add(event.quotes);
          print("Added to Favourite ${event.quotes.content}}");
          print("Added to Favourite ${listquotes.length}}");
        }
        print(listquotes.toList());
        emit(FavouriteLoaded(quotes: listquotes));
      } else if (event is RemovefromFavourite) {
        listquotes.remove(event.quotes);
        print(listquotes.toList());

        emit(FavouriteLoaded(quotes: listquotes));
      } else if (event is ClearFavourite) {
        listquotes.clear();
        emit(FavouriteLoaded(quotes: listquotes));
      } else if (event is SearchQuotesEvent) {
        emit(FavouriteLoading());
        List<Results> searchResults = listquotes.where((data) {
          return data.author
                  .toString()
                  .toLowerCase()
                  .contains(event.query.toString().toLowerCase()) ||
              data.content
                  .toString()
                  .contains(event.query.toString().toLowerCase());
        }).toList();
        emit(FavouriteLoaded(quotes: searchResults));
      }
    });
  }
}
