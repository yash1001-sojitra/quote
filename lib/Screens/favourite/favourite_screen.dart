import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../Bloc/favourite/bloc/favourite_bloc.dart';

class FavouriteQuotes extends StatefulWidget {
  const FavouriteQuotes({super.key});

  @override
  State<FavouriteQuotes> createState() => _FavouriteQuotesState();
}

class _FavouriteQuotesState extends State<FavouriteQuotes> {
  TextEditingController searchcontroller = TextEditingController();
  TextEditingController contentcontroller = TextEditingController();
  TextEditingController authorcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
                        return GestureDetector(
                          onTap: () {
                            updatemodel(
                                context,
                                contentcontroller
                                  ..text =
                                      state.quotes[index].content.toString(),
                                index);
                          },
                          child: Card(
                            child: ListTile(
                              title:
                                  Text(state.quotes[index].content.toString()),
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

  updatemodel(context, TextEditingController contentcontroller, int ind) {
    return showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10))),
        context: context,
        builder: (context) {
          return Container(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Text("Update Quote"),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: contentcontroller,
                  keyboardType: TextInputType.multiline,
                  decoration: const InputDecoration(
                      hintText: 'Content',
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                      ),
                      isDense: true),
                  toolbarOptions: const ToolbarOptions(
                      copy: true, paste: true, selectAll: true, cut: true),
                  maxLines: null,
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<FavouriteBloc>(context).add(
                          UpdateQuotesEvent(
                              quotes: contentcontroller.text.toString(),
                              index: ind));
                      Navigator.pop(context);
                    },
                    child: const Text("Update"))
              ],
            ),
          );
        });
  }
}
