import 'package:flutter/material.dart';
import 'package:movies/models/movie.dart';
import 'package:movies/widgets/widgets.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;

    return Scaffold(
        body: CustomScrollView(
      slivers: [
        _CustomAppBar(
          img: movie.fullBackdropPath,
          title: movie.title,
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            _PosterAndTitle(
              img: movie.fullPosterImg,
              title: movie.title,
              originalTitle: movie.originalTitle,
              voteAverage: movie.voteAverage,
            ),
            _OverView(
              overview: movie.overview,
            ),
            _OverView(
              overview: movie.overview,
            ),
            _OverView(
              overview: movie.overview,
            ),
            CastingCards(movieId: movie.id)
          ]),
        ),
      ],
    ));
  }
}

class _CustomAppBar extends StatelessWidget {
  const _CustomAppBar({Key? key, required this.img, required this.title})
      : super(key: key);

  final String img;
  final String title;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.indigo,
      expandedHeight: 200,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          padding: const EdgeInsets.only(bottom: 10),
          color: Colors.black12,
          alignment: Alignment.bottomCenter,
          width: double.infinity,
          child: Text(
            title,
            style: const TextStyle(fontSize: 16),
          ),
        ),
        background: FadeInImage(
          placeholder: const AssetImage('assets/loading.gif'),
          image: NetworkImage(img),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {
  const _PosterAndTitle(
      {required this.img,
      required this.title,
      required this.originalTitle,
      required this.voteAverage});

  final String img;
  final String title;
  final String originalTitle;
  final double voteAverage;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            child: FadeInImage(
              placeholder: const AssetImage('assets/no-image.jpg'),
              image: NetworkImage(img),
              height: 150,
              width: 110,
            ),
          ),
          const SizedBox(width: 20),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: size.width - 190),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      fontSize: 26, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                Text(
                  originalTitle,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                Row(
                  children: [
                    const Icon(Icons.star_outline,
                        size: 15, color: Colors.grey),
                    const SizedBox(width: 5),
                    Text(
                      voteAverage.toString(),
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _OverView extends StatelessWidget {
  const _OverView({required this.overview});

  final String overview;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      child: Text(
        overview,
        textAlign: TextAlign.justify,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}
