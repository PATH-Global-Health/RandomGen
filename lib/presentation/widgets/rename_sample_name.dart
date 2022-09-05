import 'package:flutter/material.dart';

import '../../data/dao/sample_dao.dart';

class RenameSampleName extends StatefulWidget {
  final int sampleId;
  final String name;

  const RenameSampleName({Key? key, required this.sampleId, required this.name})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _RenameSampleNameState();
}

class _RenameSampleNameState extends State<RenameSampleName> {
  final _nameController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    _nameController.text = widget.name;
  }

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
                "Sample",
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
                        final sample = SampleDAO(
                            name: _nameController.text,
                            sampleId: widget.sampleId);
                        Navigator.of(context).pop(sample.toJson());
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
