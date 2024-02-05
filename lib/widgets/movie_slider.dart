import 'package:flutter/material.dart';
import 'package:movies/models/movie.dart';

class MovieSlider extends StatefulWidget {
  const MovieSlider(
      {Key? key,
      this.title,
      required this.popularMovies,
      required this.onNextPage})
      : super(key: key);

  final String? title;
  final List<Movie> popularMovies;
  final Function onNextPage;

  @override
  State<MovieSlider> createState() => _MovieSliderState();
}

class _MovieSliderState extends State<MovieSlider> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 500) {
        widget.onNextPage();
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 270,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.title != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                '${widget.title}',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          const SizedBox(height: 5),
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: widget.popularMovies.length,
              itemBuilder: (_, int index) {
                final movie = widget.popularMovies[index];
                return MoviePoster(movie: movie);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class MoviePoster extends StatelessWidget {
  const MoviePoster({Key? key, required this.movie}) : super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 190,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'details',
                arguments: movie),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: const AssetImage('assets/no-image.jpg'),
                image: NetworkImage(
                  movie.fullPosterImg,
                ),
                fit: BoxFit.cover,
                width: 130,
                height: 190,
              ),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            movie.title,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.black),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
