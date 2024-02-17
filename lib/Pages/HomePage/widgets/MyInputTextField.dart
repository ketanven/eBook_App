import 'package:ebook_app/Pages/SearchedBooksPage/SearchedBooksPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MyInputTextField extends StatefulWidget {
  final Function(String) onSubmitted;

  const MyInputTextField({Key? key, required this.onSubmitted})
      : super(key: key);

  @override
  _MyInputTextFieldState createState() => _MyInputTextFieldState();
}

class _MyInputTextFieldState extends State<MyInputTextField> {
  late TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Row(
        children: [
          SizedBox(width: 20),
          SvgPicture.asset("Assets/Icons/search.svg"),
          SizedBox(width: 15),
          Expanded(
            child: TextFormField(
              controller: _textController,
              decoration: InputDecoration(
                hintText: "SEARCH BOOKS",
                border: OutlineInputBorder(borderSide: BorderSide.none),
              ),
              onFieldSubmitted: (value) {
                // Navigate to the search results page with the search query
                _navigateToSearchResults(value);
              },
            ),
          ),
          TextButton(
            onPressed: () {
              // Get the value from the text field
              String searchQuery = _textController.text;
              // Navigate to the search results page with the search query
              _navigateToSearchResults(searchQuery);
            },
            child: Text(
              'Search',
              style: TextStyle(fontSize: 20, color: Colors.blue),
            ),
          ),
          SizedBox(width: 10),
        ],
      ),
    );
  }

  void _navigateToSearchResults(String searchQuery) {
    // Navigate to the search results page with the search query
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SearchedBooksPage(searchQuery: searchQuery),
      ),
    );
  }
}
