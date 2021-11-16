import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Provider/provider.dart';

class Favourite extends StatefulWidget {
  const Favourite({Key? key}) : super(key: key);

  @override
  _FavouriteState createState() => _FavouriteState();
}

class _FavouriteState extends State<Favourite> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body:
          Consumer<BookmarkBloc>(builder: (context, BookmarkBloc block, child) {
        return Column(
          children: [
            Expanded(
                child: ListView.separated(
              itemCount: block.post.length,
              itemBuilder: (context, index) {
                final item = block.post[index];
                return ListTile(
                  leading: Image.network(item.thumbImageURL),
                  title: Text(item.name),
                  subtitle: Text(item.price.toString()),
                  trailing: IconButton(
                    onPressed: () {
                      setState(() {
                        if (item.fav = true) {
                          const Icon(Icons.favorite_border);
                        } else {
                          const Icon(Icons.favorite);
                        }

                        block.deleteCount();
                        block.removeItem(block.post[index]);
                      });
                    },
                    icon: const Icon(
                      Icons.favorite,
                      color: Colors.red,
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const Divider(
                  height: 4,
                  thickness: 3,
                );
              },
            )),
          ],
        );
      }),
    ));
  }
}
