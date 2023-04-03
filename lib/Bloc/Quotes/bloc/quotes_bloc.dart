import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:quote/Bloc/Quotes/Repo/quote_repo.dart';

import '../Model/quotes_model.dart';

part 'quotes_event.dart';
part 'quotes_state.dart';

class QuotesBloc extends Bloc<QuotesEvent, QuotesState> {
  QuotesRepo _quotesRepo;
  QuotesBloc(
    this._quotesRepo,
  ) : super(QuotesInitial()) {
    on<QuotesEvent>((event, emit) async {
      if (event is QuotesEventLoad) {
        emit(QuotesLoading());
        try {
          final quote = await _quotesRepo.getQuotesbyAuthor(event.query , event.page);
          emit(QuotesLoaded(quotes: quote));
        } catch (e) {
          emit(QuotesError(message: e.toString()));
        }
      }
      if (event is allQuotesEventLoad) {
        emit(QuotesLoading());
        try {
          final quote = await _quotesRepo.getAllQuotes(event.query, 1 ,event.limit);
          emit(QuotesLoaded(quotes: quote));
        } catch (e) {
          emit(QuotesError(message: e.toString()));
        }
      }
    });
  }
}
