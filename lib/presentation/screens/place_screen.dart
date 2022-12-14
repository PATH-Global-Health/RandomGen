import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/dao/place_dao.dart';
import '../../logic/bloc/place/place_bloc.dart';
import '../widgets/create_new_place.dart';
import '../widgets/place_row.dart';
import '../widgets/progress_indicator.dart';

class PlaceScreen extends StatefulWidget {
  static const routeName = '/places';

  final String username;
  const PlaceScreen({Key? key, required this.username}) : super(key: key);

  @override
  State<PlaceScreen> createState() => _PlaceScreenState();
}

class _PlaceScreenState extends State<PlaceScreen> {
  bool _isNotInit = true;

  @override
  void didChangeDependencies() {
    if (_isNotInit) {
      context.read<PlaceBloc>().add(LoadPlacesEvent(widget.username));
      _isNotInit = false;
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Places')),
      body: BlocBuilder<PlaceBloc, SampleState>(
        builder: (context, state) {
          if (state is PlacesLoadedState) {
            return state.places.isNotEmpty
                ? ListView(
                    children: [
                      ...state.places.map((place) => PlaceRow(place)),
                    ],
                  )
                : const Center(child: Text('No places'));
          }
          return const Center(
            child: IndicateProgress(message: 'Loading...'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
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
              context.read<PlaceBloc>().add(AddPlaceEvent(place.name!,
                  place.maxLimit!, place.sampleSize!, widget.username));
            }
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
