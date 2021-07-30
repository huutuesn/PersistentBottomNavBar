part of persistent_bottom_nav_bar;

class BottomNavStyle15Extra extends StatelessWidget {
  final NavBarEssentials? navBarEssentials;
  final NavBarDecoration? navBarDecoration;

  BottomNavStyle15Extra({
    Key? key,
    this.navBarEssentials = const NavBarEssentials(items: null),
    this.navBarDecoration = const NavBarDecoration(),
  });

  Widget _buildItem(BuildContext context, PersistentBottomNavBarItem item,
      bool isSelected, double? height) {
    return this.navBarEssentials!.navBarHeight == 0
        ? SizedBox.shrink()
        : Container(
            width: 150.0,
            height: height,
            color: Colors.transparent,
            padding: EdgeInsets.only(
                top: this.navBarEssentials!.padding?.top ??
                    this.navBarEssentials!.navBarHeight! * 0.15,
                bottom: this.navBarEssentials!.padding?.bottom ??
                    this.navBarEssentials!.navBarHeight! * 0.12),
            child: Container(
              alignment: Alignment.center,
              height: height,
              child: ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: IconTheme(
                          data: IconThemeData(
                              size: item.iconSize,
                              color: isSelected
                                  ? (item.activeColorSecondary == null
                                      ? item.activeColorPrimary
                                      : item.activeColorSecondary)
                                  : item.inactiveColorPrimary == null
                                      ? item.activeColorPrimary
                                      : item.inactiveColorPrimary),
                          child: isSelected
                              ? item.icon
                              : item.inactiveIcon ?? item.icon,
                        ),
                      ),
                      item.title == null
                          ? SizedBox.shrink()
                          : Padding(
                              padding: const EdgeInsets.only(top: 15.0),
                              child: Material(
                                type: MaterialType.transparency,
                                child: FittedBox(
                                    child: Text(
                                  item.title!,
                                  style: item.textStyle != null
                                      ? (item.textStyle!.apply(
                                          color: isSelected
                                              ? (item.activeColorSecondary ==
                                                      null
                                                  ? item.activeColorPrimary
                                                  : item.activeColorSecondary)
                                              : item.inactiveColorPrimary))
                                      : TextStyle(
                                          color: isSelected
                                              ? (item.activeColorSecondary ==
                                                      null
                                                  ? item.activeColorPrimary
                                                  : item.activeColorSecondary)
                                              : item.inactiveColorPrimary,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12.0),
                                )),
                              ),
                            )
                    ],
                  )
                ],
              ),
            ),
          );
  }

  Widget _buildMiddleItem(
      PersistentBottomNavBarItem item, bool isSelected, double? height) {
    return this.navBarEssentials!.navBarHeight == 0
        ? SizedBox.shrink()
        : Padding(
            padding: EdgeInsets.only(
                top: this.navBarEssentials!.padding?.top ?? 0.0,
                bottom: this.navBarEssentials!.padding?.bottom ?? 0.0),
            child: Stack(
              children: <Widget>[
                Transform.translate(
                  offset: Offset(0, -23),
                  child: Center(
                    child: Container(
                      width: 150.0,
                      height: height,
                      margin: EdgeInsets.only(top: 2.0),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/nav-btn-0.png')),
                        shape: BoxShape.circle,
                        color: item.activeColorPrimary,
                        border:
                            Border.all(color: Colors.transparent, width: 5.0),
                        boxShadow: this.navBarDecoration!.boxShadow,
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        height: height,
                        child: ListView(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Expanded(
                                  child: IconTheme(
                                    data: IconThemeData(
                                        size: item.iconSize,
                                        color: item.activeColorSecondary == null
                                            ? item.activeColorPrimary
                                            : item.activeColorSecondary),
                                    child: isSelected
                                        ? item.icon
                                        : item.inactiveIcon ?? item.icon,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                item.title == null
                    ? SizedBox.shrink()
                    : Padding(
                        padding: const EdgeInsets.only(bottom: 5.0),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Material(
                            type: MaterialType.transparency,
                            child: FittedBox(
                                child: Text(
                              item.title!,
                              style: item.textStyle != null
                                  ? (item.textStyle!.apply(
                                      color: isSelected
                                          ? (item.activeColorSecondary == null
                                              ? item.activeColorPrimary
                                              : item.activeColorSecondary)
                                          : item.inactiveColorPrimary))
                                  : TextStyle(
                                      color: isSelected
                                          ? (item.activeColorPrimary)
                                          : item.inactiveColorPrimary,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12.0),
                            )),
                          ),
                        ),
                      )
              ],
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    final midIndex = (this.navBarEssentials!.items!.length / 2).floor();
    return Container(
      width: double.infinity,
      height: this.navBarEssentials!.navBarHeight,
      child: Stack(
        children: <Widget>[
          // Positioned(top: -800, child: navBarEssentials!.items![0].icon),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: this.navBarEssentials!.items!.map((item) {
              int index = this.navBarEssentials!.items!.indexOf(item);
              //tueth - index == 0 aka FIRST HOME
              return (index == 0)
                  ? SizedBox.shrink()
                  : Flexible(
                      child: GestureDetector(
                        onTap: () {
                          if (this.navBarEssentials!.items![index].onPressed !=
                              null) {
                            this.navBarEssentials!.items![index].onPressed!(this
                                .navBarEssentials!
                                .selectedScreenBuildContext);
                          } else {
                            this.navBarEssentials!.onItemSelected!(index);
                          }
                        },
                        child: index == midIndex
                            ? Container(width: 150, color: Colors.transparent)
                            : _buildItem(
                                context,
                                item,
                                this.navBarEssentials!.selectedIndex == index,
                                this.navBarEssentials!.navBarHeight),
                      ),
                    );
            }).toList(),
          ),
          this.navBarEssentials!.navBarHeight == 0
              ? SizedBox.shrink()
              : Column(
                  children: [
                    Expanded(
                      child: Center(
                        child: GestureDetector(
                            onTap: () {
                              if (this
                                      .navBarEssentials!
                                      .items![midIndex]
                                      .onPressed !=
                                  null) {
                                this
                                        .navBarEssentials!
                                        .items![midIndex]
                                        .onPressed!(
                                    this
                                        .navBarEssentials!
                                        .selectedScreenBuildContext);
                              } else {
                                this
                                    .navBarEssentials!
                                    .onItemSelected!(midIndex);
                              }
                            },
                            child: _buildMiddleItem(
                                this.navBarEssentials!.items![midIndex],
                                this.navBarEssentials!.selectedIndex ==
                                    midIndex,
                                this.navBarEssentials!.navBarHeight)),
                      ),
                    ),
                  ],
                )
        ],
      ),
    );
  }
}
