import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toss_clone/pages/home/components/listmenu.dart';

import '../../style.dart';
import 'components/creditmenu.dart';

class HomePage extends StatefulWidget {
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  final _scrollController = ScrollController();
  double scrollOpacity = 0;

  onScroll() {
    setState(() {
      //opacity = _scrollController.offset;
      double offset = _scrollController.offset;
      if (offset < 0) {
        offset = 0;
      } else if (offset > 100) {
        offset = 100;
      }
      scrollOpacity = offset / 100;
    });
  }

  @override
  void initState() {
    _scrollController.addListener(onScroll);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(onScroll);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        child: CustomScrollView(
          physics: BouncingScrollPhysics(),
          controller: _scrollController,
          slivers: <Widget>[
            SliverAppBar(
              pinned: true,
              bottom: PreferredSize(
                child: Opacity(
                    opacity: scrollOpacity,
                    child: Container(
                      color: colorLine,
                      height: 1,
                    )),
                preferredSize: Size.fromHeight(0),
              ),
              backgroundColor: Theme.of(context).scaffoldBackgroundColor.withOpacity(scrollOpacity),
              title: Opacity(
                  opacity: scrollOpacity,
                  child: Text("홈",
                      style: TextStyle(
                        fontSize: 19.0,
                        fontWeight: FontWeight.w500,
                      ))),
              actions: <Widget>[
                Center(
                    child: Text(
                  "QR 체크인",
                  style: Theme.of(context).primaryTextTheme.bodyText2,
                )),
                SizedBox(
                  width: 12,
                ),
                IconButton(
                  onPressed: null,
                  icon: Icon(Icons.chat),
                  iconSize: 24,
                  disabledColor: colorTopIcon,
                ),
                IconButton(
                  onPressed: null,
                  icon: Icon(Icons.notifications),
                  iconSize: 24,
                  disabledColor: colorTopIcon,
                ),
              ],
            ),
            SliverToBoxAdapter(
              child: CreditMenu(),
            ),
            SliverList(
                delegate: SliverChildListDelegate(
              [
                ListMenu(),
              ],
            )),
          ],
        ),
        onRefresh: () => Future.value(true));
  }

  void onRefresh() {}
}
