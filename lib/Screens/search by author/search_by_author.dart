import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quote/Bloc/Quotes/bloc/quotes_bloc.dart';
import 'package:quote/Bloc/favourite/bloc/favourite_bloc.dart';

class SearchByAuthor extends StatelessWidget {
  const SearchByAuthor({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController searchcontroller = TextEditingController();
    List<Color> color = [
      Colors.pink,
      Colors.blue,
      Colors.green,
      Colors.yellow,
      Colors.orange,
      Colors.purple,
    ];
    BlocProvider.of<QuotesBloc>(context).add(QuotesEventLoad(1));
    return Scaffold(
        appBar: AppBar(
          title: const Text("Search by Author"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
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
                        context.read<QuotesBloc>().add(QuotesEventLoad(
                            Random().nextInt(3),
                            query: searchcontroller.text.isEmpty
                                ? "albert-einstein"
                                : searchcontroller.text.toString()));
                      },
                      icon: const Icon(Icons.search))
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              BlocBuilder<QuotesBloc, QuotesState>(
                builder: (context, state) {
                  if (state is QuotesLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is QuotesLoaded) {
                    final quote = state.quotes.results!;

                    return Container(
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: color[Random().nextInt(color.length)]
                                .withOpacity(0.1),
                            border: Border.all(color: Colors.grey, width: 0.5),
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.asset(
                                  "assets/images/double-quotes.png",
                                  height: 100,
                                  width: 100,
                                ),
                                IconButton(
                                    onPressed: () {
                                      BlocProvider.of<FavouriteBloc>(context)
                                          .add(AddtoFavourite(
                                              quotes:
                                                  state.quotes.results!.first));
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content: Text("Added to Favourite"),
                                      ));
                                    },
                                    icon: const Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                      size: 30,
                                    ))
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Text(
                                  quote.isEmpty
                                      ? "No Data found"
                                      : quote.first.content.toString(),
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold)),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Text(
                                  quote.isEmpty
                                      ? ""
                                      : "Author : ${quote.first.author.toString()}",
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold)),
                            ),
                            SizedBox(
                              height: 10,
                            )
                          ],
                        ));
                  } else if (state is QuotesError) {
                    return Center(child: Text(state.message));
                  }
                  return Container();
                },
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ));
  }
}
