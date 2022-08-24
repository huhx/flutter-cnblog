import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CustomLoadFooter extends StatelessWidget {
  const CustomLoadFooter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ClassicFooter(
      loadingIcon: SizedBox(
        width: 25.0,
        height: 25.0,
        child: CupertinoActivityIndicator(),
      ),
      loadStyle: LoadStyle.ShowWhenLoading,
    );
  }
}
