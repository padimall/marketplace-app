import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:padimall_app/widgets/loading_widget.dart';

Widget buildFutureBuilder(Future<dynamic> _future, Widget _widget) {
  return FutureBuilder(
    future: _future,
    builder: (ctx, dataSnapshot) {
      if (dataSnapshot.connectionState == ConnectionState.waiting) {
        return LoadingWidget();
      } else {
        if (dataSnapshot.error != null) {
          print(dataSnapshot.error);
          print('is ${dataSnapshot.error == SocketException}');
          if (dataSnapshot.error == SocketException) {
            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    SvgPicture.asset(
                      'assets/images/lost_connection.svg',
                      height: 150,
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 24),
                      child: Text(
                        'Whoops!',
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 16
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 8),
                      child: Text(
                        'Mohon periksa koneksi kamu yah..',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          fontSize: 14,
                          color: Colors.grey[500],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Scaffold(
              body: Center(
                child: Text('Terjadi kesalahan'),
              ),
            );
          }
        } else {
          return _widget;
        }
      }
    },
  );
}
