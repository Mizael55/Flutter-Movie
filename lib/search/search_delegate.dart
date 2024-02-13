import 'package:flutter/material.dart';
import 'package:movies/models/movie.dart';
import 'package:provider/provider.dart';

import '../providers/movies_provider.dart';

class MovieSearchDelegate extends SearchDelegate {
  @override
  String get searchFieldLabel => 'Buscar pelicula';

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () => query = '',
        icon: const Icon(
          Icons.clear,
          color: Colors.black,
        ),
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null),
      icon: const Icon(
        Icons.arrow_back,
        color: Colors.black,
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text('buildResults');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return const Center(
        child: Icon(
          Icons.movie_creation_outlined,
          color: Colors.black,
          size: 130,
        ),
      );
    }






    final moviesProvider = Provider.of<MoviesProvider>(context, listen: false);
    moviesProvider.getSuggestionsByQuery(query);

    return StreamBuilder(
      stream: moviesProvider.suggestionStream,
      builder: (_, AsyncSnapshot<List<Movie>> snapshot) {
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        final movies = snapshot.data!;

        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (_, int index) => ListTile(
            leading: FadeInImage(
              placeholder: const AssetImage('assets/no-image.jpg'),
              image: NetworkImage(movies[index].fullPosterImg),
              width: 50,
              fit: BoxFit.contain,
            ),
            title: Text(movies[index].title),
            subtitle: Text(movies[index].originalTitle),
            onTap: () {
              close(context, null);
              Navigator.pushNamed(context, 'details', arguments: movies[index]);
            },
          ),
        );
      },
    );
  }
}
