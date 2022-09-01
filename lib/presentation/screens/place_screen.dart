import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:randomgen/data/dao/place_dao.dart';

import '../../data/services/place.dart';
import '../../logic/bloc/place/place_bloc.dart';
import '../widgets/create_new_task.dart';

class PlaceScreen extends StatelessWidget {
  static const routeName = '/places';

  final String username;
  const PlaceScreen({Key? key, required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Places')),
      body: BlocBuilder<PlaceBloc, PlaceState>(
        builder: (context, state) {
          if (state is PlacesLoadedState) {
            return state.places.isNotEmpty
                ? ListView(
                    children: [
                      ...state.places.map(
                        (e) => ListTile(
                          title: Text(e.name),
                          trailing:
                              Checkbox(value: e.completed, onChanged: (val) {}),
                        ),
                      ),
                    ],
                  )
                : const Center(child: Text('No places'));
          }
          return Container();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog<String>(
            context: context,
            builder: (context) => const Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
              child: CreateNewPlace(),
            ),
          ).then((result) {
            if (result != null) {
              final place = PlaceDAO.fromJson(result);
              context.read<PlaceBloc>().add(AddPlaceEvent(
                  place.name!, place.maxLimit!, place.sampleSize!, username));
            }
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
