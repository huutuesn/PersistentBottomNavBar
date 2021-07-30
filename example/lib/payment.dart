import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:persistent_bottom_nav_bar_example_project/global.dart';
import 'package:persistent_bottom_nav_bar_example_project/main.dart';

import 'modal-screen.dart';
import 'package:flutter_colorful_tab/flutter_colorful_tab.dart';

class PaymentPage extends StatefulWidget {
  final BuildContext menuScreenContext;
  final Function onScreenHideButtonPressed;
  final bool hideStatus;
  final Color backgroundColor;
  const PaymentPage(
      {Key key,
      this.menuScreenContext,
      this.onScreenHideButtonPressed,
      this.hideStatus = false,
      this.backgroundColor = Colors.white})
      : super(key: key);

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: 4);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('home decor------xxx ${MediaQuery.of(context).devicePixelRatio}');
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width * 429 / 747,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/bg2.png'),
              fit: BoxFit.fill,
            ),
          ),
        ),
        Positioned(
          top: kToolbarHeight + MediaQuery.of(context).padding.top,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              ColorfulTabBar(
                selectedHeight: 48,
                unselectedHeight: 48,
                tabs: [
                  TabItem(
                      title: Container(
                        width: 60,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.home_outlined),
                              SizedBox(width: 8),
                              Text('Home')
                            ]),
                      ),
                      color: Colors.red.shade600,
                      unselectedColor: Colors.blue),
                  TabItem(
                      title: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.favorite_outline),
                            SizedBox(width: 8),
                            Text('Favorite')
                          ]),
                      color: Colors.red.shade600,
                      unselectedColor: Colors.blue),
                  TabItem(
                      title: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.search_outlined),
                            SizedBox(width: 8),
                            Text('Search')
                          ]),
                      color: Colors.red.shade600,
                      unselectedColor: Colors.blue),
                  TabItem(
                      title: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.settings_outlined),
                            SizedBox(width: 8),
                            Text('Settings')
                          ]),
                      color: Colors.red.shade600,
                      unselectedColor: Colors.blue),
                ],
                controller: _tabController,
              ),
              Expanded(
                child: Container(
                  //height: 60,
                  //width: 300,
                  // color: Colors.blue,
                  child: TabBarView(
                      controller: _tabController,
                      children: List.generate(
                          4,
                          (index) => Container(
                                // height: 60,
                                // width: 300,
                                color: Colors.transparent,
                              ))),
                ),
              ),
            ],
          ),
        ),
      ],
    );
    /* DefaultTabController(
      length: 3,
      child: Container(
        color: Colors.blue,
        width: 375,
        height: 800,
        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //     image: AssetImage('assets/images/background.png'),
        //     fit: BoxFit.cover,
        //   ),
        // ),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            flexibleSpace: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TabBar(
                  indicatorWeight: 10,
                  indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(50), // Creates border
                      color: Colors.greenAccent),
                  tabs: [
                    Tab(icon: Icon(Icons.flight)),
                    Tab(icon: Icon(Icons.directions_transit)),
                    Tab(icon: Icon(Icons.directions_car)),
                  ],
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Icon(Icons.flight, size: 350),
              Icon(Icons.directions_transit, size: 350),
              Icon(Icons.directions_car, size: 350),
            ],
          ),
        ),
      ),
    ); */
  }

  Widget _pageView(int index) {
    return ListView.builder(
      itemCount: 1,
      itemBuilder: (context, i) => Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(child: Text('Tab ${index + 1} - item no $i')),
        ),
      ),
    );
  }
}
