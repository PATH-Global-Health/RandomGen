import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../data/dao/place_dao.dart';

class CreateNewPlace extends StatefulWidget {
  const CreateNewPlace({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CreateNewPlaceState();
}

class _CreateNewPlaceState extends State<CreateNewPlace> {
  final _nameController = TextEditingController();
  final _maxLimitController = TextEditingController();
  final _sampleSizeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Text(
                "Place",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  hintText: 'Name',
                  labelText: 'Name',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.blue, width: 1),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Name is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                  controller: _maxLimitController,
                  decoration: InputDecoration(
                    hintText: 'Maximum Limit',
                    labelText: 'Maximum Limit',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:
                          const BorderSide(color: Colors.blue, width: 1),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  validator: (value) {
                    if (value == null || double.tryParse(value) == null) {
                      return "Maximum limit is required";
                    }
                    return null;
                  }),
              const SizedBox(height: 16),
              TextFormField(
                  controller: _sampleSizeController,
                  decoration: InputDecoration(
                    hintText: 'Sample Size',
                    labelText: 'Sample Size',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide:
                          const BorderSide(color: Colors.blue, width: 1),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  validator: (value) {
                    if (value == null || double.tryParse(value) == null) {
                      return "Sample size is required";
                    }
                    return null;
                  }),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.grey,
                    ),
                    child: const SizedBox(
                      height: 40,
                      child: Center(
                        child: Text(
                          "Cancel",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 40),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final place = PlaceDAO(
                            name: _nameController.text,
                            maxLimit: int.parse(_maxLimitController.text),
                            sampleSize: int.parse(_sampleSizeController.text));
                        Navigator.of(context).pop(place.toJson());
                      }
                    },
                    child: const SizedBox(
                      height: 40,
                      child: Center(
                        child: Text(
                          "SAVE",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
