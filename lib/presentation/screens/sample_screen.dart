import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../logic/bloc/sample/sample_bloc.dart';
import '../widgets/progress_indicator.dart';
import '../widgets/sample_row.dart';

class SampleScreen extends StatefulWidget {
  static const routeName = '/samples';

  final int placeId;
  const SampleScreen({Key? key, required this.placeId}) : super(key: key);

  @override
  State<SampleScreen> createState() => _SampleScreenState();
}

class _SampleScreenState extends State<SampleScreen> {
  bool _isNotInit = true;

  @override
  void didChangeDependencies() {
    if (_isNotInit) {
      context.read<SampleBloc>().add(LoadSamplesEvent(widget.placeId));
      _isNotInit = false;
    }

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Samples')),
      body: BlocBuilder<SampleBloc, SampleState>(
        builder: (context, state) {
          if (state is SamplesLoadedState) {
            return state.samples.isNotEmpty
                ? ListView(
                    children: [
                      ...state.samples.map((sample) => SampleRow(sample)),
                    ],
                  )
                : const Center(child: Text('No samples'));
          }
          return const Center(
            child: IndicateProgress(message: 'Loading...'),
          );
        },
      ),
    );
  }
}
