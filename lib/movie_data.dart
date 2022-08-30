

class MovieData {
  late final List<Result> results;

  MovieData(this.results);

  MovieData.fromJson(Map<String, dynamic> json){
    if (json['results'] != null) {
      results = List<Result>.empty(growable: true);
      json["results"].forEach((e) => results.add(Result.fromJson(e)));
    }
  }
}

class Result{
  late final String language;
  late final String title;
  late final String date;
  late final String poster;
  late final String desc;


  Result(this.language, this.title, this.date, this.poster, this.desc);

  Result.fromJson(Map<String,dynamic> json){
   language = json['original_language'];
    title = json['title'];
    date = json['release_date'];
    poster = json['poster_path'];
   desc = json['overview'];
  }
}