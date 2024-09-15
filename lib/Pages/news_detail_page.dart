import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetailPage extends StatefulWidget {
  final String imageUrl, description, author, content, url;
  final DateTime date;

  const NewsDetailPage(
      {super.key,
      required this.imageUrl,
      required this.description,
      required this.author,
      required this.date,
      required this.content,
      required this.url});

  @override
  State<NewsDetailPage> createState() => _NewsDetailPageState();
}

class _NewsDetailPageState extends State<NewsDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Share.shareUri(
                Uri.parse(widget.url),
              );
            },
            icon: const Icon(CupertinoIcons.share),
          ),
        ],
      ),
      /*
      Body
      */
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CachedNetworkImage(
                errorWidget: (context, url, error) => Image.network(
                    "https://archive.org/download/placeholder-image/placeholder-image.jpg"),
                progressIndicatorBuilder: (context, url, progress) {
                  return CircularProgressIndicator(
                    value: progress.progress,
                  );
                },
                imageUrl: widget.imageUrl,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  widget.description,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("By ${widget.author}"),
                    Text("${widget.date.hour} hour ago"),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              const Divider(
                thickness: 2,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  widget.content,
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w700),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  final Uri url = Uri.parse(widget.url);
                  if (!await launchUrl(url)) {
                    throw Exception('Could not launch $url');
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    widget.url,
                    style: const TextStyle(color: Colors.blue),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
