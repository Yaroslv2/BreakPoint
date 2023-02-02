import 'package:brandpoint/presentation/design.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          toolbarHeight: 100,
          backgroundColor: Colors.white10,
          elevation: 0,
          title: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: const BorderSide(color: Colors.grey, width: 0.5)),
              focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.black, width: 0.8),
                  borderRadius: BorderRadius.circular(25)),
              hintText: "Search",
              hintStyle: textStyleGray,
              prefixIcon: const Icon(Icons.search),
            ),
          ),
        ),
      ),
    );
  }
}
