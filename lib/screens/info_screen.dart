import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:wifi_app/bloc/nav/nav_bloc.dart';
import '../widget/steps_widget.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const StepsWidget(),
              Expanded(
                flex: 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      text,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Image.network("https://picsum.photos/80"),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Center(
                  child: TextButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.green),
                      minimumSize:
                          MaterialStateProperty.all(const Size(150, 2)),
                    ),
                    onPressed: () =>
                        context.read<NavBloc>().add(NavNextPageEvent()),
                    child: const Text(
                      "Далее",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
