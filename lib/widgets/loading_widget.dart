import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
//          SpinKitWave(
//            color: Theme.of(context).primaryColor,
//            type: SpinKitWaveType.center,
//          ),
          SpinKitWanderingCubes(
            color: Theme.of(context).primaryColor,
            duration: Duration(seconds: 1),
          ),
        ],
      ),
    );
  }
}
