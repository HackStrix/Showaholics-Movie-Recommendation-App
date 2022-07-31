import 'package:flutter/material.dart';
import 'package:project_flix/screens/home/favouriteMovies.dart';
import 'package:project_flix/screens/home/favouriteTv.dart';

class FavouriteTabbedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.live_tv)),
                Tab(icon: Icon(Icons.movie)),
              ],
              indicatorColor: Colors.orange,
            ),
            title: Text('Favourites'),
          ),
          body: TabBarView(
            children: [
              FavouriteTv(),
              FavouriteMovies(),
            ],
          ),
        ),
      );
  }
}