import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/dao/sample_dao.dart';
import '../../data/model/sample.dart';
import '../../logic/bloc/sample/sample_bloc.dart';
import 'rename_sample_name.dart';

class SampleRow extends StatelessWidget {
  final Sample sample;
  final int placeId;

  const SampleRow({Key? key, required this.sample, required this.placeId})
      : super(key: key);

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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
              showDialog(
                context: context,
                builder: (context) => Dialog(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                  child:
                      RenameSampleName(sampleId: sample.key, name: sample.name),
                ),
              ).then((result) {
                if (result != null) {
                  final s = SampleDAO.fromJson(result);
                  context
                      .read<SampleBloc>()
                      .add(EditSampleEvent(s.sampleId!, s.name!, placeId));
                }
              });
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
