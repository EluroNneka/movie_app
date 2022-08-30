import 'package:flutter/material.dart';

class DetailsView extends StatelessWidget {
  final String image;
  final String title;
  final String desc;
  final String date;

  const DetailsView(
      {Key? key,
      required this.image,
      required this.title,
      required this.desc,
      required this.date})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.grey,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  clipBehavior: Clip.hardEdge,
                  height: 180,
                  width: 350,
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Image.network(
                    'https://image.tmdb.org/t/p/w600_and_h900_bestv2/$image',
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
            const SizedBox(
              height: 20,
            ),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w900,
                color: Colors.black,
              ),
              softWrap: true,
              overflow: TextOverflow.clip,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Release Date: $date',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
            ),
            const Divider(),
            Text(
              desc,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.normal,
                color: Colors.black54,
              ),
              softWrap: true,
              overflow: TextOverflow.clip,
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }
}
