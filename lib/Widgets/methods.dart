import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:news_app/Pages/news_detail_page.dart';
import 'package:news_app/Provider/news_provider.dart';

Card newsCard(BuildContext context, NewsProvider value, int index) {
  return Card(
    child: InkWell(
      borderRadius: BorderRadius.circular(10),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NewsDetailPage(
              url: value.allNewsModel?.articles?[index].url ?? "",
              content: value.allNewsModel?.articles?[index].content ?? "",
              date: value.allNewsModel?.articles?[index].publishedAt ??
                  DateTime.now(),
              author: value.allNewsModel?.articles?[index].author ??
                  "Unknown Author",
              imageUrl: value.allNewsModel?.articles?[index].urlToImage ?? "",
              description: value.allNewsModel?.articles?[index].description ??
                  "No Description!",
            ),
          ),
        );
      },
      child: Column(
        children: [
          newsCardImage(value, index),
          /*
                        ListTile for News
                        */
          newsCardTitleAndDescription(value, index)
        ],
      ),
    ),
  );
}

ListTile newsCardTitleAndDescription(NewsProvider value, int index) {
  return ListTile(
    title: Text(value.allNewsModel?.articles?[index].title ?? "No title"),
    subtitle: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(value.allNewsModel?.articles?[index].description ??
            "No Description!"),
        const SizedBox(height: 10),
        Row(
          children: [
            Text(
              value.allNewsModel?.articles?[index].source?.name ??
                  "Unknown source!",
              style: const TextStyle(color: Colors.blue),
            ),
            const SizedBox(width: 10),
            Text(
              "${value.allNewsModel?.articles?[index].publishedAt?.hour} hour ago",
              style: const TextStyle(
                color: Colors.grey,
              ),
            )
          ],
        )
      ],
    ),
  );
}

ClipRRect newsCardImage(NewsProvider value, int index) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(10),
    child: CachedNetworkImage(
      errorWidget: (context, url, error) => Image.network(
          "https://archive.org/download/placeholder-image/placeholder-image.jpg"),
      progressIndicatorBuilder: (context, url, progress) {
        return Stack(
          alignment: Alignment.center,
          children: [
            Image.asset('assets/images/placeholder-image.jpg'),
            CircularProgressIndicator(
              value: progress.progress,
            )
          ],
        );
      },
      imageUrl: value.allNewsModel?.articles?[index].urlToImage ??
          "https://ichef.bbci.co.uk/news/1024/branded_news/1a2d/live/537ff930-6139-11ee-b101-6f93d6dfbcc2.png",
    ),
  );
}

Drawer buildDrawer(BuildContext context) {
  return Drawer(
    child: Column(
      children: [
        const DrawerHeader(
          child: Text(
            "N E W S",
            style: TextStyle(color: Colors.grey),
          ),
        ),
        ListTile(
          title: const Text("Theme"),
          trailing: Switch(
            value: AdaptiveTheme.of(context).mode.isDark,
            onChanged: (value) {
              AdaptiveTheme.of(context).toggleThemeMode();
            },
          ),
        )
      ],
    ),
  );
}

AppBar buildAppBar(
    TextEditingController searchController, Future<void> Function() onSearch) {
  return AppBar(
    toolbarHeight: 130,
    title: SearchBar(
      controller: searchController,
      onSubmitted: (value) {
        if (searchController.text.isEmpty) {
          value = "Economy";
        } else {
          onSearch();
        }
      },
      padding: const WidgetStatePropertyAll(EdgeInsets.all(8)),
      elevation: const WidgetStatePropertyAll(0),
      hintText: "Search News...",
      trailing: const [Icon(Icons.newspaper)],
    ),
  );
}
