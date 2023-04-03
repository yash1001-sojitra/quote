import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Bloc/Quotes/bloc/quotes_bloc.dart';
import '../../Bloc/favourite/bloc/favourite_bloc.dart';

class FavouriteQuotes extends StatelessWidget {
  const FavouriteQuotes({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController searchcontroller = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favourite Quotes"),
        actions: [
          IconButton(
              onPressed: () {
                BlocProvider.of<FavouriteBloc>(context).add(ClearFavourite());
              },
              icon: const Icon(Icons.delete))
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Flexible(
                  child: TextFormField(
                    controller: searchcontroller,
                    cursorColor: Colors.black,
                    keyboardType: TextInputType.name,
                    textAlign: TextAlign.start,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.black,
                      ),
                      hintText: 'Search',
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      context.read<FavouriteBloc>().add(SearchQuotesEvent(
                          query: searchcontroller.text.toString()));
                    },
                    icon: const Icon(Icons.search))
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          BlocBuilder<FavouriteBloc, FavouriteState>(
            builder: (context, state) {
              if (state is FavouriteInitial) {
                context.read<FavouriteBloc>().add(GetFavourite());
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is FavouriteLoaded) {
                return Expanded(
                  child: ListView.builder(
                      itemCount: state.quotes.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            title: Text(state.quotes[index].content.toString()),
                            subtitle:
                                Text(state.quotes[index].author.toString()),
                            trailing: IconButton(
                                onPressed: () {
                                  BlocProvider.of<FavouriteBloc>(context).add(
                                      RemovefromFavourite(
                                          quotes: state.quotes[index]));
                                },
                                icon: const Icon(Icons.delete)),
                          ),
                        );
                      }),
                );
              } else {
                return const Center(
                  child: Text("No Quotes"),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
