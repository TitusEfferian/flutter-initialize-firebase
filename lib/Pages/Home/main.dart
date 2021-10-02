import 'package:flutter/material.dart';
import 'package:initialize_firebase/GlobalWidget/PrivateWidget/main.dart';
import 'package:initialize_firebase/main.dart';
import 'package:provider/provider.dart';

class PageContent extends StatelessWidget {
  const PageContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: OutlinedButton(
        child: Consumer<RealtimeNotifier>(builder: (context, data, child) {
          return Text('hello this is login mode, click for log out ${data.data}');
        },),
        onPressed: () {
          Provider.of<UserNotifier>(context, listen: false).logout();
          // Provider.of<RealtimeNotifier>(context,listen: false).fetchData();
        },
      ),
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: PrivateWidget(
      child: PageContent(),
    ));
  }
}
