import 'package:flutter/material.dart';
import 'package:initialize_firebase/main.dart';
import 'package:provider/provider.dart';

class PrivateWidget extends StatelessWidget {
  const PrivateWidget({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Consumer<UserNotifier>(
        builder: (context, data, _) {
          if (data.isLoggedin) {
            return child;
          }
          return OutlinedButton(
            onPressed: () {
              if (data.isLoggedin) {
                Provider.of<UserNotifier>(context, listen: false).logout();
              } else {
                Provider.of<UserNotifier>(context, listen: false).login();
              }
            },
            child:
                data.isLoggedin ? const Text('log out') : const Text('log in'),
          );
        },
      ),
    );
  }
}
