// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

import 'package:movies/models/movie.dart';

NowPlayingResponse welcomeFromJson(String str) => NowPlayingResponse.fromJson(json.decode(str));

String welcomeToJson(NowPlayingResponse data) => json.encode(data.toJson());

class NowPlayingResponse {
    int page;
    List<Movie> results;
    int totalPages;
    int totalResults;

    NowPlayingResponse({
        required this.page,
        required this.results,
        required this.totalPages,
        required this.totalResults,
    });

    factory NowPlayingResponse.fromJson(Map<String, dynamic> json) => NowPlayingResponse(
        page: json["page"],
        results: List<Movie>.from(json["results"].map((x) => Movie.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
    );

    Map<String, dynamic> toJson() => {
        "page": page,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
        "total_pages": totalPages,
        "total_results": totalResults,
    };
}

