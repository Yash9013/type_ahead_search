import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class TypeAheadSearch extends StatefulWidget {
  const TypeAheadSearch({super.key});

  @override
  State<TypeAheadSearch> createState() => _TypeAheadSearchState();
}

class _TypeAheadSearchState extends State<TypeAheadSearch> {
  TextEditingController searchnation = TextEditingController();

  String? selecteduser;

  List countrylist = [
    'India',
    'America',
    'England',
    'Canada',
    'U.A.E',
    'Germany',
    'Russia',
    'Thailand',
  ];

  List getSuggetion(String query) {
    List search = [];
    search.addAll(countrylist);
    search.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return search;
  }

  @override
  void initState() {
    searchnation.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    searchnation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final heigth = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Search with Type Ahead Field',
          style:
              TextStyle(fontSize: heigth * 0.03, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(
              height: heigth * 0.025,
            ),
            SizedBox(
              height: heigth * 0.06,
              width: double.infinity,
              child: TypeAheadField(
                noItemsFoundBuilder: (context) => const Center(
                  child: Text('No item found'),
                ),
                suggestionsCallback: (value) {
                  return getSuggetion(value);
                },
                suggestionsBoxDecoration: SuggestionsBoxDecoration(
                  borderRadius: BorderRadius.circular(width * 0.02),
                  elevation: 3,
                ),
                debounceDuration: const Duration(milliseconds: 500),
                textFieldConfiguration: TextFieldConfiguration(
                    controller: searchnation,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(width * 0.35),
                      ),
                      hintText: 'Search',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: searchnation.text.isEmpty
                          ? Container()
                          : IconButton(
                              onPressed: () {
                                searchnation.clear();
                              },
                              icon: Icon(
                                Icons.close,
                                size: heigth * 0.025,
                              ),
                            ),
                    )),
                itemBuilder: (context, itemData) {
                  return ListTile(
                    title: Text(
                      itemData,
                      maxLines: 1,
                      style: TextStyle(fontSize: heigth * 0.03),
                    ),
                  );
                },
                onSuggestionSelected: (suggest) {
                  setState(() {
                    selecteduser = suggest;
                  });
                },
              ),
            ),
            SizedBox(
              height: heigth * 0.025,
            ),
            Center(
              child: Text(
                selecteduser ?? 'Search',
                style: TextStyle(fontSize: heigth * 0.03),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
