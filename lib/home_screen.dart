import 'package:app/detail_screen.dart';
import 'package:app/Provider/provider.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Post>> futurePost;

  String? text;
  bool isExpanded = false;

  @override
  void initState() {
    super.initState();
    futurePost = fetchPost();
  }

  @override
  Widget build(BuildContext context) {
    var bookmarkBloc = Provider.of<BookmarkBloc>(context);
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: FutureBuilder<List<Post>>(
                future: futurePost,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (_, index) {
                        final desc = snapshot.data![index].description;
                        return ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailedScreen(
                                          snapshot.data![index].thumbImageURL,
                                          snapshot.data![index].description,
                                          snapshot.data![index].name,
                                          snapshot.data![index].brand,
                                          snapshot.data![index].rating,
                                        )));
                          },
                          leading: Image.network(
                              snapshot.data![index].thumbImageURL),
                          title: Text(snapshot.data![index].name),
                          subtitle: Column(
                            children: [
                              ExpandableText(
                                desc,
                                expandText: 'show more',
                                collapseText: 'show less',
                                maxLines: 4,
                              ),
                              const SizedBox(height: 10.0),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    String.fromCharCodes(Runes(
                                      'Price: \u0024${snapshot.data![index].price}',
                                    )),
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    'Rating :${snapshot.data![index].rating}',
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          trailing: IconButton(
                              onPressed: () {
                                setState(() {
                                  if (snapshot.data![index].fav = false) {
                                    const Icon(Icons.favorite);
                                  } else {
                                    const Icon(Icons.favorite_border);
                                  }

                                  bookmarkBloc.addCount();
                                  bookmarkBloc.addItems(snapshot.data![index]);
                                });
                              },
                              icon: snapshot.data![index].fav == false
                                  ? const Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                    )
                                  : const Icon(
                                      Icons.favorite_border,
                                    )),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text('${snapshot.error}'));
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
