import 'package:flutter/material.dart';

class AlertErrorWidget extends StatelessWidget {
  final String errorMessage;

  const AlertErrorWidget({super.key, required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        content: SizedBox(
            height: MediaQuery.of(context).size.height / 4,
            child: SingleChildScrollView(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline,
                  color: Colors.red,
                  size: 50.0,
                ),
                const SizedBox(height: 10.0),
                Text(
                  errorMessage,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 16.0),
                ),
              ],
            ))));
  }
}
