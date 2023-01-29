import 'package:flutter/material.dart';

class SearchEngine extends SearchDelegate {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.close),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => close(context, null),
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    //TODO: this will show the result of the search, and in our case this will take me to another screen which is the chosen app / website
    // }

    return Center(
      child: Text(query),
    );
  }

  /// TODO: create a list that stores the search suggestions then filter them
  /// I've create an example below
  /// this list stores the needed input for the search engine
  final List apps_names = [
    'Solo Learn',
    'Messenger',
    'Instagram',
    'Youtube',
    'Udemy',
  ];

  @override
  Widget buildSuggestions(BuildContext context) {
    /// here i will take applications names from the data in apps list
    ///

    /// this is the input filter
    List filteredInput = apps_names
        .where(
          (element) => element.toString().toLowerCase().contains(query),
        )
        .toList();
    // TODO: this will show the filtered search suggestions
    return ListView.builder(
      itemCount: query == '' ? apps_names.length : filteredInput.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            title: Text(
              query == '' ? apps_names[index] : '${filteredInput[index]}',
            ),
            onTap: () {
              query = query == '' ? apps_names[index] : filteredInput[index];
              showResults(context);
            },
          ),
        );
      },
    );
  }
}
