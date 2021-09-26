import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/wifi/wifi_bloc.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Test"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              initialValue: "",
              onChanged: (newValue) => context
                  .read<WifiBloc>()
                  .add(WifiLoginChangeEvent(data: newValue)),
              decoration: InputDecoration(
                labelText: "Network name",
                filled: true,
                fillColor: Colors.white,
                contentPadding:
                    const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              initialValue: "",
              onChanged: (newValue) => context
                  .read<WifiBloc>()
                  .add(WifiPasswordChangeEvent(data: newValue)),
              decoration: InputDecoration(
                labelText: "Network password",
                filled: true,
                fillColor: Colors.white,
                contentPadding:
                    const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 8.0),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 10),
            BlocBuilder<WifiBloc, WifiState>(
              builder: (context, state) {
                if (state is WifiConnectedState) return Text(state.result);
                return const Text("nothing");
              },
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                context.read<WifiBloc>().add(WifiConnectEvent());
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                child: Text("Connect"),
              ),
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(const Size(200, 40)),
                backgroundColor: MaterialStateProperty.all<Color>(
                    const Color.fromRGBO(255, 0, 92, 1)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
