import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:randomgen/data/dao/place_dao.dart';

import '../../logic/bloc/place/place_bloc.dart';
import '../widgets/create_new_task.dart';

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
      body: BlocBuilder<PlaceBloc, PlaceState>(
        builder: (context, state) {
          if (state is PlacesLoadedState) {
            return state.places.isNotEmpty
                ? ListView(
                    children: [
                      ...state.places.map(
                        (e) => Column(
                          children: [
                            ListTile(
                              leading: Checkbox(
                                  value: e.completed, onChanged: (val) {}),
                              title: Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    5.0, 0.0, 0.0, 0.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      e.name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16.0,
                                      ),
                                    ),
                                    const Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 2.0)),
                                    Text(
                                      'Range (1 - ${e.maxLimit})',
                                      style: const TextStyle(fontSize: 12.0),
                                    ),
                                    const Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 1.0)),
                                    Text(
                                      'Sample size - ${e.sampleSize}',
                                      style: const TextStyle(fontSize: 12.0),
                                    ),
                                  ],
                                ),
                              ),
                              enabled: e.completed == false,
                              trailing: const Icon(Icons.delete),
                            ),
                            const Divider(
                              color: Colors.grey,
                            ),
                            const Padding(
                                padding: EdgeInsets.symmetric(vertical: 1.0))
                          ],
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
