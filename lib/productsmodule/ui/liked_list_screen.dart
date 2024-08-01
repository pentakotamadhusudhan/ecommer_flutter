import 'package:flutter/material.dart';

class LikedListScrreen extends StatefulWidget {
  const LikedListScrreen({super.key});

  @override
  State<LikedListScrreen> createState() => _LikedListScrreenState();
}

class _LikedListScrreenState extends State<LikedListScrreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Liked products"),
      ),
      body: Center(child: Text("Liked list"),),
    );
  }
}