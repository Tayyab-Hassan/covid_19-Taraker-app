import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Row1 extends StatelessWidget {
  String title, value;
  Row1({Key? key, required this.title, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title,
                  style: const TextStyle(fontFamily: 'Pacifico', fontSize: 20)),
              Text(value,
                  style: const TextStyle(fontFamily: 'Pacifico', fontSize: 17)),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          const Divider(),
        ],
      ),
    );
  }
}
