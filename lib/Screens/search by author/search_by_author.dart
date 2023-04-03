import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quote/Bloc/Quotes/bloc/quotes_bloc.dart';

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
    return Scaffold(
        appBar: AppBar(
          title: const Text("Search by Author"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextFormField(
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
                SizedBox(
                  height: 20,
                ),
                BlocBuilder<QuotesBloc, QuotesState>(
                  builder: (context, state) {
                    if (state is QuotesInitial) {
                      context.read<QuotesBloc>().add(QuotesEventLoad(
                          query: searchcontroller.text.isEmpty
                              ? "Einstein"
                              : searchcontroller.text));
                    } else if (state is QuotesLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is QuotesLoaded) {
                      return Container(
                          width: MediaQuery.of(context).size.width,
                          height: 300,
                          decoration: BoxDecoration(
                              color: color[Random().nextInt(color.length)]
                                  .withOpacity(0.1),
                              border:
                                  Border.all(color: Colors.grey, width: 0.5),
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image.asset(
                                      "assets/images/double-quotes.png",
                                      height: 100,
                                      width: 100,
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          context.read<QuotesBloc>().add(
                                              QuotesEventLoad(
                                                  query: searchcontroller
                                                          .text.isEmpty
                                                      ? "Einstein"
                                                      : searchcontroller.text));
                                        },
                                        icon: const Icon(Icons.favorite))
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: Flexible(
                                    child: Text(
                                        state.quotes.results!.toString(),
                                        textAlign: TextAlign.start,
                                        style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ),
                              ],
                            ),
                          ));
                    } else if (state is QuotesError) {
                      return Center(child: Text(state.message));
                    }
                    return Container(
                        width: MediaQuery.of(context).size.width,
                        height: 300,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                "assets/images/quote.png",
                                height: 100,
                                width: 100,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: Flexible(
                                  child: Text("",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                            ],
                          ),
                        ));
                  },
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ));
  }
}
