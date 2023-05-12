import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreenWidget extends StatelessWidget {
  const LoadingScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black38,
      child: const SpinKitFoldingCube(
        color: Colors.blue,
      ),
    );
  }
}
