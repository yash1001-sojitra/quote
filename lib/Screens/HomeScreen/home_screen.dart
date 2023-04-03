import 'package:flutter/material.dart';
import 'package:quote/Screens/all%20quotes/all_quotes.dart';
import 'package:quote/Screens/favourite/favourite_screen.dart';

import '../search by author/search_by_author.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: const Text(
            'Quote Mobile App',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return const SearchByAuthor();
                        },
                      ));
                    },
                    child: CategoryCard(
                      categoryname: " Search by Author",
                      categoryImage: "assets/images/writer.png",
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return const AllQuotes();
                        },
                      ));
                    },
                    child: CategoryCard(
                      categoryname: " All Quote",
                      categoryImage: "assets/images/search.png",
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return const FavouriteQuotes();
                        },
                      ));
                    },
                    child: CategoryCard(
                      categoryname: " Favoirte Quotes",
                      categoryImage: "assets/images/favourite.png",
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}

class CategoryCard extends StatelessWidget {
  String categoryname;
  String categoryImage;
  CategoryCard({
    Key? key,
    required this.categoryname,
    required this.categoryImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Container(
          height: 150,
          width: 140,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey, width: 0.5)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  categoryImage,
                  height: 40,
                  width: 40,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  categoryname,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
