import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

class DetailedScreen extends StatefulWidget {
  final String thumbImageURL;
  final String description;
  final String name;
  final String brand;
  final double rating;

  const DetailedScreen(
      this.thumbImageURL, this.description, this.name, this.brand, this.rating,
      {Key? key})
      : super(key: key);

  @override
  _DetailedScreenState createState() => _DetailedScreenState();
}

class _DetailedScreenState extends State<DetailedScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(),
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            margin:
                const EdgeInsets.only(top: 5, bottom: 5, left: 15, right: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ImageSlideshow(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 4,
                  initialPage: 0,
                  indicatorColor: Colors.blue,
                  indicatorBackgroundColor: Colors.grey,
                  autoPlayInterval: 3000,
                  isLoop: true,
                  children: [
                    Image.network(widget.thumbImageURL),
                    Image.network(widget.thumbImageURL),
                    Image.network(widget.thumbImageURL),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      widget.name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    Text(widget.brand,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black45)),
                    Text(widget.rating.toString(),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(widget.description)
              ],
            ),
          )),
    );
  }
}
