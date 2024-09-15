import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:news_app/Provider/news_provider.dart';
import 'package:news_app/Widgets/methods.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController searchController = TextEditingController();
  final RefreshController refreshController = RefreshController();

  @override
  void initState() {
    Future.delayed(Duration.zero).then(
      (value) {
        // ignore: use_build_context_synchronously
        final allNews = Provider.of<NewsProvider>(context, listen: false);
        allNews.provideAllNews();
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  Future<void> onSearch() async {
    final query = searchController.text;
    final searchQuery = Provider.of<NewsProvider>(context, listen: false);
    searchQuery.provideAllNews(query: query);
  }

  Future<void> _onRefresh() async {
    Provider.of<NewsProvider>(context, listen: false)
        .provideAllNews(query: searchController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*
      AppBar
       */
      appBar: buildAppBar(searchController, onSearch),
      /*
      Drawer
      */
      drawer: buildDrawer(context),
      /*
      Body
      */
      body: Consumer<NewsProvider>(
        builder: (context, value, child) {
          if (value.isLoading) {
            return Center(
              child: LoadingAnimationWidget.horizontalRotatingDots(
                  color: Colors.blueAccent, size: 50),
            );
          } else {
            /*
            ListView.builder
            */
            return SmartRefresher(
              controller: refreshController,
              onRefresh: _onRefresh,
              child: ListView.builder(
                itemCount: value.allNewsModel?.articles?.length,
                padding: const EdgeInsets.all(11),
                itemBuilder: (context, index) {
                  /*
                  News Card
                  */
                  return newsCard(context, value, index);
                },
              ),
            );
          }
        },
      ),
    );
  }
}
