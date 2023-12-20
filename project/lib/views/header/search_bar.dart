import 'package:project/all_imports.dart';

class SearchBarApp extends StatefulWidget {
  const SearchBarApp({super.key});

  @override
  _SearchBarAppState createState() => _SearchBarAppState();
}

class _SearchBarAppState extends State<SearchBarApp> {
  final TextEditingController _searchController = TextEditingController();
  List<String> searchResults = [];

  void searchItems(String query) {
    CollectionReference itemsCollection =
        FirebaseFirestore.instance.collection('products');

    itemsCollection
        .where('name', isGreaterThanOrEqualTo: query)
        .where('name', isLessThanOrEqualTo: query + '\uf8ff')
        .get()
        .then((QuerySnapshot querySnapshot) {
      setState(() {
        searchResults =
            querySnapshot.docs.map((doc) => doc['name'] as String).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                searchItems(value);
              },
              decoration: InputDecoration(
                labelText: 'Search',
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: searchResults.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(searchResults[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
