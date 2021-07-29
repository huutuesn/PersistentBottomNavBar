import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:persistent_bottom_nav_bar_example_project/modal-tab.dart';
import 'package:persistent_bottom_nav_bar_example_project/payment.dart';

import 'custom-widget-tabs.widget.dart';
import 'global.dart';
import 'modal-screen.dart';
import 'screens.dart';

void main() async {
  MemoryImage appBackgroundMemImage = MemoryImage(Uint8List.fromList(<int>[0]));
  try {
    appBackgroundMemImage = await loadBackgroundImage();
    homeBackgroundDecoration = BoxDecoration(
      image: DecorationImage(
        image: appBackgroundMemImage,
        fit: BoxFit.cover,
      ),
    );
  } catch (e) {
    print('errrrrrrrrrr $e');
  }

  runApp(MyApp());
}

BuildContext testContext;

Future<MemoryImage> loadBackgroundImage() async {
  try {
    Uint8List data =
        (await rootBundle.load('assets/images/BG.png')).buffer.asUint8List();
    return MemoryImage(data);
  } catch (e) {
    print('load fail $e');
  }

  return null;
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Persistent Bottom Navigation Bar example project',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProvidedStylesExample(),
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        // '/first': (context) => MainScreen2(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        //  '/second': (context) => MainScreen3(),
      },
    );
  }
}

class Test extends StatefulWidget {
  Test({Key key}) : super(key: key);

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image:
              DecorationImage(image: AssetImage('assets/images/nav-btn-0.png')),
          // shape: BoxShape.circle,
          border: Border.all(color: Colors.transparent, width: 5.0),
        ),
      ),
    );
  }
}

class MainMenu extends StatefulWidget {
  MainMenu({Key key}) : super(key: key);

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sample Project"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: ElevatedButton(
              child: Text("Custom widget example"),
              onPressed: () => pushNewScreen(
                context,
                screen: CustomWidgetExample(
                  menuScreenContext: context,
                ),
              ),
            ),
          ),
          SizedBox(height: 20.0),
          Center(
            child: ElevatedButton(
              child: Text("Built-in styles example"),
              onPressed: () => pushNewScreen(
                context,
                screen: ProvidedStylesExample(
                  menuScreenContext: context,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ----------------------------------------- Provided Style ----------------------------------------- //

class ProvidedStylesExample extends StatefulWidget {
  final BuildContext menuScreenContext;
  ProvidedStylesExample({Key key, this.menuScreenContext}) : super(key: key);

  @override
  _ProvidedStylesExampleState createState() => _ProvidedStylesExampleState();
}

class _ProvidedStylesExampleState extends State<ProvidedStylesExample> {
  PersistentTabController _controller;
  bool _hideNavBar;

  String title = 'demo';
  double appBarHeight = kToolbarHeight;
  bool isExtra = false;
  @override
  void initState() {
    super.initState();
    _controller = PersistentTabController(initialIndex: 0);
    _controller.addListener(_tabChange);
    _hideNavBar = false;
  }

  _tabChange() {
    print('tab change =-==========');
    if (_controller.index != 2)
      setState(() {
        title = 'HOME';
        isExtra = false;
        appBarHeight = kToolbarHeight;
      });
    else {
      setState(() {
        title = 'NOO';
        isExtra = true;
        appBarHeight = 0;
      });
    }
  }

  List<Widget> _buildScreens() {
    return [
      MainScreen(
        menuScreenContext: widget.menuScreenContext,
        hideStatus: _hideNavBar,
        onScreenHideButtonPressed: () {
          setState(() {
            _hideNavBar = !_hideNavBar;
          });
        },
        backgroundColor: Colors.yellow,
      ),
      MainScreen(
        menuScreenContext: widget.menuScreenContext,
        hideStatus: _hideNavBar,
        onScreenHideButtonPressed: () {
          setState(() {
            _hideNavBar = !_hideNavBar;
          });
        },
        backgroundColor: Colors.transparent,
      ),
      PaymentPage(
        menuScreenContext: widget.menuScreenContext,
        hideStatus: _hideNavBar,
        onScreenHideButtonPressed: () {
          setState(() {
            _hideNavBar = !_hideNavBar;
          });
        },
      ),
      MainScreen(
        menuScreenContext: widget.menuScreenContext,
        hideStatus: _hideNavBar,
        onScreenHideButtonPressed: () {
          setState(() {
            _hideNavBar = !_hideNavBar;
          });
        },
        backgroundColor: Colors.yellow,
      ),
      MainScreen(
        menuScreenContext: widget.menuScreenContext,
        hideStatus: _hideNavBar,
        onScreenHideButtonPressed: () {
          setState(() {
            _hideNavBar = !_hideNavBar;
          });
        },
      ),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: Icon(Icons.home),
        title: "Home",
        activeColorPrimary: Colors.blue,
        inactiveColorPrimary: Colors.grey,
        inactiveColorSecondary: Colors.purple,
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.search),
        title: ("Search"),
        activeColorPrimary: Colors.teal,
        inactiveColorPrimary: Colors.grey,
        routeAndNavigatorSettings: RouteAndNavigatorSettings(
          initialRoute: '/',
          routes: {
            '/first': (context) => MainScreen2(),
            '/second': (context) => MainScreen3(),
          },
        ),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.add),
        title: ("Add"),
        activeColorPrimary: Colors.redAccent,
        activeColorSecondary: Colors.white,
        inactiveColorPrimary: Colors.white,
        routeAndNavigatorSettings: RouteAndNavigatorSettings(
          initialRoute: '/',
          routes: {
            '/first': (context) => MainScreen2(),
            '/second': (context) => MainScreen3(),
          },
        ),
        /* onPressed: (context) {
            pushDynamicScreen(context,
                screen: SampleModalScreenTab(), withNavBar: true);
            setState(() {
              title = 'barco';
            });
          } */
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.message),
        title: ("Messages"),
        activeColorPrimary: Colors.deepOrange,
        inactiveColorPrimary: Colors.grey,
        routeAndNavigatorSettings: RouteAndNavigatorSettings(
          initialRoute: '/',
          routes: {
            '/first': (context) => MainScreen2(),
            '/second': (context) => MainScreen3(),
          },
        ),
      ),
      PersistentBottomNavBarItem(
        icon: Icon(Icons.settings),
        title: ("Settings"),
        activeColorPrimary: Colors.indigo,
        inactiveColorPrimary: Colors.grey,
        routeAndNavigatorSettings: RouteAndNavigatorSettings(
          initialRoute: '/',
          routes: {
            '/first': (context) => MainScreen2(),
            '/second': (context) => MainScreen3(),
          },
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/background.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Scaffold(
          // extendBody: true,
          extendBodyBehindAppBar: isExtra,
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            toolbarHeight: appBarHeight,
            title: Text(title),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          /*       drawer: Drawer(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text('This is the Drawer'),
                    ],
                  ),
                ),
              ), */
          body:
              /*  Stack(
              children: [
                Container(
                  height: 800,
                  width: 300,
                  color: Colors.blue,
                ), */
              Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                // color: Colors.transparent,

                // height: MediaQuery.of(context).size.height -
                //     44 -
                //     appBarHeight -
                //     appBarHeight,

                // decoration: BoxDecoration(
                //   image: DecorationImage(
                //     image: AssetImage('assets/images/background.png'),
                //     fit: BoxFit.fill,
                //   ),
                // ),
                child: PersistentTabView(
                  context,

                  controller: _controller,
                  screens: _buildScreens(),
                  items: _navBarsItems(),
                  // margin: EdgeInsets.only(bottom: 20),
                  backgroundColor: Colors.yellow,
                  handleAndroidBackButtonPress: true,
                  resizeToAvoidBottomInset: true,
                  stateManagement: true,
                  navBarHeight: MediaQuery.of(context).viewInsets.bottom > 0
                      ? 0.0
                      : kBottomNavigationBarHeight, //56
                  hideNavigationBarWhenKeyboardShows: true,
                  margin: EdgeInsets.all(16.0),
                  popActionScreens: PopActionScreensType.all,
                  //bottomScreenMargin: kBottomNavigationBarHeight,
                  confineInSafeArea: false,
                  onWillPop: (context) async {
                    await showDialog(
                      context: context,
                      useSafeArea: true,
                      builder: (context) => Container(
                        height: 50.0,
                        width: 50.0,
                        color: Colors.white,
                        child: ElevatedButton(
                          child: Text("Close"),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    );
                    return false;
                  },
                  selectedTabScreenContext: (context) {
                    testContext = context;
                  },
                  hideNavigationBar: _hideNavBar,
                  bottomScreenMargin: 16.0 + 56.0 + 26,
                  decoration: NavBarDecoration(
                      colorBehindNavBar: Colors.transparent,
                      borderRadius: BorderRadius.circular(16.0)),
                  popAllScreensOnTapOfSelectedTab: true,
                  itemAnimationProperties: ItemAnimationProperties(
                    duration: Duration(milliseconds: 400),
                    curve: Curves.bounceIn,
                  ),
                  screenTransitionAnimation: ScreenTransitionAnimation(
                    animateTabTransition: false,
                    curve: Curves.easeOut,
                    duration: Duration(milliseconds: 300),
                  ),
                  navBarStyle: NavBarStyle
                      .style15, // Choose the nav bar style with this property
                ),
              ),
            ],
          ),
          /*    ],
            ), */
        ),
      ],
    );
  }
}

// ----------------------------------------- Custom Style ----------------------------------------- //

class CustomNavBarWidget extends StatelessWidget {
  final int selectedIndex;
  final List<PersistentBottomNavBarItem> items;
  final ValueChanged<int> onItemSelected;

  CustomNavBarWidget({
    Key key,
    this.selectedIndex,
    @required this.items,
    this.onItemSelected,
  });

  Widget _buildItem(PersistentBottomNavBarItem item, bool isSelected) {
    return Container(
      alignment: Alignment.center,
      height: kBottomNavigationBarHeight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Flexible(
            child: IconTheme(
              data: IconThemeData(
                  size: 26.0,
                  color: isSelected
                      ? (item.activeColorSecondary == null
                          ? item.activeColorPrimary
                          : item.activeColorSecondary)
                      : item.inactiveColorPrimary == null
                          ? item.activeColorPrimary
                          : item.inactiveColorPrimary),
              child: isSelected ? item.icon : item.inactiveIcon ?? item.icon,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Material(
              type: MaterialType.transparency,
              child: FittedBox(
                  child: Text(
                item.title,
                style: TextStyle(
                    color: isSelected
                        ? (item.activeColorSecondary == null
                            ? item.activeColorPrimary
                            : item.activeColorSecondary)
                        : item.inactiveColorPrimary,
                    fontWeight: FontWeight.w400,
                    fontSize: 12.0),
              )),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Container(
        width: double.infinity,
        height: kBottomNavigationBarHeight,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: items.map((item) {
            int index = items.indexOf(item);
            return Flexible(
              child: GestureDetector(
                onTap: () {
                  this.onItemSelected(index);
                },
                child: _buildItem(item, selectedIndex == index),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
