import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:techtime/Controllers/Cubits/NetworkCubit/internet_cubit.dart';
import 'package:techtime/screens/shared/ConnectivityView/connectivity_page.dart';

class NetworkSensitive extends StatelessWidget {
  final Widget? child;

  const NetworkSensitive({
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    // Get our connection status from the provider

    return BlocListener<InternetCubit, InternetState>(
        listener: (context, state) {
          if (state is InternetDisconnected) {
            print("Dialog page Change state");
            Timer(
                const Duration(milliseconds: 900),
                () => showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (BuildContext context) {
                      return ConnectivityPage(
                        parent: this,
                      );
                    }));
          }
        },
        child: Opacity(
          opacity: 1,
          child: child,
        ));
  }
}
