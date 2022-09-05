import 'package:flutter/material.dart';

import '../../data/model/sample.dart';

class SampleRow extends StatelessWidget {
  final Sample sample;

  const SampleRow(this.sample, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Checkbox(
              checkColor: Colors.white,
              activeColor: Colors.grey,
              value: sample.completed,
              onChanged: (val) {
                // context
                //     .read<SampleBloc>()
                //     .add(ToogleSampleEvent(sample.key));
              }),
          title: Padding(
            padding: const EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
            child: Row(
              children: [
                Text(
                  sample.sample.toString(),
                  style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                ),
                Text(
                  sample.name,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                      decoration: sample.completed == true
                          ? TextDecoration.lineThrough
                          : null),
                ),
              ],
            ),
          ),
          enabled: sample.completed == false,
          trailing: IconButton(
            icon: const Icon(Icons.edit),
            tooltip: 'Edit',
            onPressed: () {
              // showDialog(
              //   context: context,
              //   builder: (context) => ConfirmDialog(
              //       title: 'Please Confirm',
              //       content: 'Are you sure to remove ${place.name}?'),
              // ).then((result) {
              //   if (result != null && result == 'Yes') {
              //     context
              //         .read<SampleBloc>()
              //         .add(RemovePlaceEvent(place.key, place.user));
              //   }
              // });
            },
          ),
        ),
        const Divider(
          color: Colors.grey,
        ),
        const Padding(padding: EdgeInsets.symmetric(vertical: 1.0))
      ],
    );
  }
}
