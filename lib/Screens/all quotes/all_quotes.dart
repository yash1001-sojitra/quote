import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quote/Bloc/Quotes/bloc/quotes_bloc.dart';

import '../../Bloc/favourite/bloc/favourite_bloc.dart';

class AllQuotes extends StatefulWidget {
  const AllQuotes({super.key});

  @override
  State<AllQuotes> createState() => _AllQuotesState();
}

class _AllQuotesState extends State<AllQuotes> {
  int val = 10;
  TextEditingController searchcontroller = TextEditingController();
  List<DropdownMenuItem> dropdownButton = List.generate(100, (index) {
    return DropdownMenuItem<int>(
      child: Text("$index"),
      value: index,
    );
  });
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<QuotesBloc>(context)
        .add(allQuotesEventLoad(query: "love", 10));
    return Scaffold(
        appBar: AppBar(
          title: const Text("Search any quotes"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
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
                        BlocProvider.of<QuotesBloc>(context).add(
                            allQuotesEventLoad(
                                10,
                                query: searchcontroller.text.isEmpty
                                    ? "love"
                                    : searchcontroller.text.toString()));
                      },
                      icon: const Icon(Icons.search))
                ],
              ),
              Row(
                children: [
                  Text("set Limit : "),
                  DropdownButton(
                    items: dropdownButton.toList(),
                    onChanged: (value) {
                      val = value;
                      setState(() {
                        val;
                      });
                      BlocProvider.of<QuotesBloc>(context).add(
                          allQuotesEventLoad(value!,
                              query: searchcontroller.text.isEmpty
                                  ? "love"
                                  : searchcontroller.text.toString()));
                    },
                    value: val,
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              BlocBuilder<QuotesBloc, QuotesState>(
                builder: (context, state) {
                  if (state is QuotesLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is QuotesLoaded) {
                    return Expanded(
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemCount: state.quotes.results!.length,
                        itemBuilder: (context, index) {
                          return quotemodel(context, state, index);
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(
                            height: 10,
                          );
                        },
                      ),
                    );
                  } else if (state is QuotesError) {
                    return Center(child: Text(state.message));
                  }
                  return Center(
                    child: const Text("Search Quotes"),
                  );
                },
              ),
            ],
          ),
        ));
  }

  Widget quotemodel(BuildContext context, QuotesLoaded state, int index) {
    List<Color> color = [
      Colors.pink,
      Colors.blue,
      Colors.green,
      Colors.yellow,
      Colors.orange,
      Colors.purple,
    ];
    return Container(
        padding: EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: color[Random().nextInt(color.length)].withOpacity(0.1),
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
                      BlocProvider.of<FavouriteBloc>(context).add(
                          AddtoFavourite(quotes: state.quotes.results![index]));
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
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
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Text(state.quotes.results![index].content.toString(),
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Text(
                  "Author : ${state.quotes.results![index].author.toString()}",
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            ),
          ],
        ));
  }
}
