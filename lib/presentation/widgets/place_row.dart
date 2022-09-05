import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/dao/sample_dao.dart';
import '../../data/model/place.dart';
import '../../logic/bloc/place/place_bloc.dart';
import '../screens/sample_screen.dart';
import 'confirm_dialog.dart';

class PlaceRow extends StatelessWidget {
  final Place place;

  const PlaceRow(this.place, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Column(
        children: [
          ListTile(
            leading: Checkbox(
                checkColor: Colors.white,
                activeColor: Colors.grey,
                value: place.completed,
                onChanged: (val) {
                  context
                      .read<PlaceBloc>()
                      .add(TooglePlaceEvent(place.key, place.user));
                }),
            title: Padding(
              padding: const EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    place.name,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                        decoration: place.completed == true
                            ? TextDecoration.lineThrough
                            : null),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 2.0),
                  ),
                  Text(
                    'Range (1 - ${place.maxLimit})',
                    style: TextStyle(
                        fontSize: 12.0,
                        decoration: place.completed == true
                            ? TextDecoration.lineThrough
                            : null),
                  ),
                  const Padding(padding: EdgeInsets.symmetric(vertical: 1.0)),
                  Text(
                    'Sample size - ${place.sampleSize}',
                    style: TextStyle(
                        fontSize: 12.0,
                        decoration: place.completed == true
                            ? TextDecoration.lineThrough
                            : null),
                  ),
                ],
              ),
            ),
            enabled: place.completed == false,
            trailing: IconButton(
              icon: const Icon(Icons.delete),
              tooltip: 'Remove',
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => ConfirmDialog(
                      title: 'Please Confirm',
                      content: 'Are you sure to remove ${place.name}?'),
                ).then((result) {
                  if (result != null && result == 'Yes') {
                    context
                        .read<PlaceBloc>()
                        .add(RemovePlaceEvent(place.key, place.user));
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
      ),
      onTap: () {
        final args = SampleDAO(sampleId: place.key);
        Navigator.of(context)
            .pushNamed(SampleScreen.routeName, arguments: args);
      },
    );
  }
}
