//Packages
import 'package:flutter/material.dart';

//Constants
import '../Utils/constants.dart';

class EndpointCard extends StatelessWidget {
  final String endpoint;
  final String count;

  const EndpointCard({Key? key, required this.endpoint, required this.count})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '$endpoint',
                style: Theme.of(context).textTheme.headline5,
              ),
              Text(
                '$count',
                style: Theme.of(context).textTheme.headline6,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
