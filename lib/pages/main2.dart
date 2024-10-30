import 'package:flutter/material.dart';
import 'package:windsor_caesar_hub/models/news.dart';
import 'package:windsor_caesar_hub/utils/utils.dart';

class Main2 extends StatefulWidget {
  const Main2({super.key});

  @override
  _Main2State createState() => _Main2State();
}

class _Main2State extends State<Main2> with TickerProviderStateMixin {
  late TabController _tabController;

  Widget _buildNewsCard(News newsInfo) {
    return Container(
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Text(
            newsInfo.title,
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.w500),
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image.asset(
                "images/arrow.png",
                width: 30,
                height: 30,
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Main",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ]),
                  child: TabBar(
                    onTap: (value) {
                      setState(() {});
                    },
                    controller: _tabController,
                    indicatorColor: Colors.transparent,
                    indicatorWeight: 0.0,
                    dividerColor: Colors.transparent,
                    indicator: BoxDecoration(
                      color: Colors.yellow,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    labelPadding: EdgeInsets.zero,
                    tabs: [
                      Container(
                        width: size.width * 0.5,
                        height: size.height * 0.06,
                        alignment: Alignment.center,
                        child: const Text("News"),
                      ),
                      Container(
                        width: size.width * 0.5,
                        height: size.height * 0.06,
                        alignment: Alignment.center,
                        child: const Text("Maps"),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                _tabController.index == 0
                    ? Container(
                        child: Expanded(
                          child: GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                              childAspectRatio: 3 / 2,
                            ),
                            itemCount: windsorNews.length,
                            itemBuilder: (context, index) {
                              return _buildNewsCard(windsorNews[index]);
                            },
                          ),
                        ),
                      )
                    : Container(
                        child: const Text("Second page"),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
