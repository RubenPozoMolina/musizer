import 'package:flutter/material.dart';

class SoundCreationForm extends StatefulWidget {
  const SoundCreationForm({super.key});

  @override
  State<SoundCreationForm> createState() => _SoundCreationFormState();
}

class _SoundCreationFormState extends State<SoundCreationForm> {
  final _formKey = GlobalKey<FormState>();
  final _soundNameController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _selectedInstrument = 'Piano';
  double _volume = 0.7;
  double _tempo = 120.0;
  String _selectedKey = 'C Major';

  final List<String> _instruments = [
    'Piano',
    'Guitar',
    'Violin',
    'Drums',
    'Synthesizer',
    'Flute',
    'Saxophone',
    'Bass'
  ];

  final List<String> _musicalKeys = [
    'C Major',
    'D Major',
    'E Major',
    'F Major',
    'G Major',
    'A Major',
    'B Major',
    'C Minor',
    'D Minor',
    'E Minor',
    'F Minor',
    'G Minor',
    'A Minor',
    'B Minor'
  ];

  @override
  void dispose() {
    _soundNameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _saveSound() {
    if (_formKey.currentState!.validate()) {
      // Here you would typically save the sound data
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Sound "${_soundNameController.text}" created successfully!'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create New Sound'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          TextButton(
            onPressed: _saveSound,
            child: const Text(
              'SAVE',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Sound Name
              TextFormField(
                controller: _soundNameController,
                decoration: const InputDecoration(
                  labelText: 'Sound Name *',
                  hintText: 'Enter a name for your sound',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.music_note),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a sound name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Description
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  hintText: 'Describe your sound...',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.description),
                ),
                maxLines: 3,
              ),
              const SizedBox(height: 16),

              // Instrument Selection
              DropdownButtonFormField<String>(
                value: _selectedInstrument,
                decoration: const InputDecoration(
                  labelText: 'Instrument',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.piano),
                ),
                items: _instruments.map((String instrument) {
                  return DropdownMenuItem<String>(
                    value: instrument,
                    child: Text(instrument),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedInstrument = newValue!;
                  });
                },
              ),
              const SizedBox(height: 16),

              // Musical Key Selection
              DropdownButtonFormField<String>(
                value: _selectedKey,
                decoration: const InputDecoration(
                  labelText: 'Musical Key',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.key),
                ),
                items: _musicalKeys.map((String key) {
                  return DropdownMenuItem<String>(
                    value: key,
                    child: Text(key),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedKey = newValue!;
                  });
                },
              ),
              const SizedBox(height: 24),

              // Volume Slider
              Text(
                'Volume: ${(_volume * 100).round()}%',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Slider(
                value: _volume,
                min: 0.0,
                max: 1.0,
                divisions: 100,
                label: '${(_volume * 100).round()}%',
                onChanged: (double value) {
                  setState(() {
                    _volume = value;
                  });
                },
              ),
              const SizedBox(height: 16),

              // Tempo Slider
              Text(
                'Tempo: ${_tempo.round()} BPM',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Slider(
                value: _tempo,
                min: 60.0,
                max: 200.0,
                divisions: 140,
                label: '${_tempo.round()} BPM',
                onChanged: (double value) {
                  setState(() {
                    _tempo = value;
                  });
                },
              ),
              const SizedBox(height: 32),

              // Action Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () {
                      // Preview functionality would go here
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Preview functionality coming soon!'),
                        ),
                      );
                    },
                    icon: const Icon(Icons.play_arrow),
                    label: const Text('Preview'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: _saveSound,
                    icon: const Icon(Icons.save),
                    label: const Text('Save Sound'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
