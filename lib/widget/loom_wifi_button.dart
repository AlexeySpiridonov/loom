import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loom/bloc/loom/loom_bloc.dart';
import 'package:loom/models/network_model.dart';
// ignore: implementation_imports
import 'package:provider/src/provider.dart';

class LoomWifiButton extends StatelessWidget {
  const LoomWifiButton({
    Key? key,
    required this.networkModel,
  }) : super(key: key);

  final NetworkModel networkModel;

  @override
  Widget build(BuildContext context) {
    final double devicePixelRatio = MediaQuery.of(context).devicePixelRatio / 2;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0 * devicePixelRatio),
      child: GestureDetector(
        onTap: () {
          context.read<LoomBloc>().add(
                LoomNetworksChooseEvent(
                  networkModel: networkModel,
                ),
              );
        },
        child: Container(
          decoration: BoxDecoration(
            color: const Color.fromRGBO(26, 47, 79, 1),
            borderRadius:
                BorderRadius.all(Radius.circular(6.0 * devicePixelRatio)),
          ),
          padding: EdgeInsets.symmetric(
              horizontal: 16.0 * devicePixelRatio,
              vertical: 8.0 * devicePixelRatio),
          child: Row(
            children: [
              Text(
                networkModel.wl_ss_ssid,
                style: TextStyle(fontSize: 16 * devicePixelRatio),
              ),
              const Spacer(),
              if (networkModel.wl_ss_sin >= 50)
                Image.asset("assets/images/wifi3.png",
                    height: 16 * devicePixelRatio)
              else if (networkModel.wl_ss_sin >= 30)
                Image.asset("assets/images/wifi2.png",
                    height: 16 * devicePixelRatio)
              else
                Image.asset("assets/images/wifi1.png",
                    height: 16 * devicePixelRatio),
            ],
          ),
        ),
      ),
    );
  }
}
