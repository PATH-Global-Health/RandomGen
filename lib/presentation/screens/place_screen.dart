import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/services/place.dart';
import '../../logic/bloc/place/place_bloc.dart';

class PlaceScreen extends StatelessWidget {
  final String username;
  const PlaceScreen({Key? key, required this.username}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          PlaceBloc(RepositoryProvider.of<PlaceService>(context))
            ..add(LoadPlacesEvent(username)),
      child: Scaffold(
        appBar: AppBar(title: const Text('Places')),
        body: BlocBuilder<PlaceBloc, PlaceState>(
          builder: (context, state) {
            if (state is PlacesLoadedState) {
              return state.places.isNotEmpty
                  ? ListView(
                      children: state.places
                          .map(
                            (e) => ListTile(
                              title: Text(e.name),
                              trailing: Checkbox(
                                  value: e.completed, onChanged: (val) {}),
                            ),
                          )
                          .toList(),
                    )
                  : const Center(child: Text('No places'));
            }
            return Container();
          },
        ),
      ),
    );
  }
}
