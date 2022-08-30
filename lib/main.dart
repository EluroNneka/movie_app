import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:movie_app/details_view.dart';
import 'package:movie_app/movie_data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<MovieData>? movie;

  @override
  void initState() {
    super.initState();
    movie = fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 40,
            ),
            const Text(
              'Hi Nneka,',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Choose a movie below for its details',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.normal,
                color: Colors.black54,
              ),
            ),
            Expanded(
              child: FutureBuilder<MovieData>(
                  future: movie,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 20,
                          crossAxisSpacing: 20,
                        ),
                        itemCount: snapshot.data!.results.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) => movieItem(
                            snapshot.data!.results[index].poster,
                            snapshot.data!.results[index].title,
                            snapshot.data!.results[index].desc,
                            snapshot.data!.results[index].date),
                      );
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    return const Center(child: CircularProgressIndicator());
                  }),
            ),
          ],
        ),
      ),
    );
  }

  Future<MovieData> fetch() async {
    final response = await http.get(Uri.parse(
        "https://api.themoviedb.org/3/movie/popular?api_key=1ac13dee31920a8c8fcfd82d1e5cd966&language=en-US&page=1"));

    // print("The response: ${response.body}");
    return MovieData.fromJson(jsonDecode(response.body));
  }

  Widget movieItem(
      String imageUrl, String title, String description, String date) {
    return InkWell(
      child: Container(
        clipBehavior: Clip.hardEdge,
        height: 150,
        width: 150,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Image.network(
          'https://image.tmdb.org/t/p/w600_and_h900_bestv2/$imageUrl',
          fit: BoxFit.cover,
          width: 150,
          height: 150,
        ),
      ),
      onTap: () {
        openBottomSheet(imageUrl, title, description, date);
      },
    );
  }

  void openBottomSheet(
      String imageUrl, String title, String description, String date) {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(10), topLeft: Radius.circular(10))),
      clipBehavior: Clip.hardEdge,
      isDismissible: false,
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.only(left: 5, bottom: 20),
        height: 180,
        width: 300,
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  clipBehavior: Clip.hardEdge,
                  height: 140,
                  width: 100,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Image.network(
                    'https://image.tmdb.org/t/p/w600_and_h900_bestv2/$imageUrl',
                    fit: BoxFit.cover,
                    width: 50,
                    height: 70,
                  ),
                ),
                const Icon(
                  Icons.play_circle_fill_rounded,
                  color: Colors.grey,
                  size: 40,
                ),
              ],
            ),

            Column(children: [
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 200,
                    child: Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w900,
                        color: Colors.black,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.clip,
                    ),
                  ),
                  InkWell(
                      child: const Icon(
                        Icons.cancel_outlined,
                        color: Colors.red,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      }),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                width: 220,
                child: Text(
                  description.length >= 100
                      ? description.substring(0, 100) + '....'
                      : description.substring(0, 80) + '....',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.normal,
                    color: Colors.black54,
                  ),
                  softWrap: true,
                  overflow: TextOverflow.clip,
                  textAlign: TextAlign.justify,
                ),
              ),
              const Divider(
                indent: 40,
                endIndent: 40,
              ),
              InkWell(
                child: Row(
                  children: const [
                    Icon(
                      Icons.info_outline,
                      color: Colors.grey,
                      size: 20,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'View Details',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        color: Colors.black54,
                      ),
                    ),
                    SizedBox(
                      width: 100,
                    ),
                    Icon(
                      Icons.arrow_forward,
                      color: Colors.grey,
                      size: 15,
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailsView(
                                image: imageUrl,
                                title: title,
                                desc: description,
                                date: date,
                              )));
                },
              ),
            ]),
            // const SizedBox(width: 5,),
          ],
        ),
      ),
    );
  }
}
