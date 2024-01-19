import 'package:ebook_app/Components/BackButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BookDetailsHeader extends StatelessWidget {
  final String coverUrl;
  final String title;
  final String author;
  final String description;
  final String rating;
  final String category;
  final int? pages;
  final String language;

  const BookDetailsHeader(
      {super.key,
      required this.coverUrl,
      required this.title,
      required this.author,
      required this.description,
      required this.rating,
      required this.category,
      required this.pages,
      required this.language,
      required numberofRating});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 50),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MyBackButton(),
            SvgPicture.asset("Assets/Icons/heart.svg",
                color: Theme.of(context).colorScheme.background),
          ],
        ),
        SizedBox(height: 40),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                coverUrl,
                width: 160,
              ),
            )
          ],
        ),
        SizedBox(height: 10),
        Text(
          title,
          maxLines: 1,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w900,
            color: Colors.white,
          ),
        ),
        Text(
          "Author: $author",
          style: Theme.of(context)
              .textTheme
              .labelLarge
              ?.copyWith(color: Colors.white),
        ),
        SizedBox(
          height: 5,
        ),
        Text(
          description,
          maxLines: 2,
          style: Theme.of(context)
              .textTheme
              .labelLarge
              ?.copyWith(color: Colors.white),
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(
                  "Rating",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
                Text(
                  rating,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Text(
                  "Pages",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
                Text(
                  pages.toString(),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                )
              ],
            ),
            Column(
              children: [
                Text(
                  "Language",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
                Text(
                  language,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                )
              ],
            ),
            Column(
              children: [
                Text(
                  "Offline Reading",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "logo",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ],
        ),
      ],
    );
  }
}
