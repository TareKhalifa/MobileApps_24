import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final String name;
  final String picturePath;
  final TextEditingController _animalScore = TextEditingController();

  CustomCard({required this.name, required this.picturePath});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(name),
          Image.asset(picturePath, width: 400, height: 400,),
          TextFormField(
            controller: _animalScore,
            decoration: InputDecoration(
              labelText: 'Enter the rating here',
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter a rating";
              }
              return null;
            },
          ),
          ElevatedButton(
            onPressed: () {
              if (_animalScore.text.isNotEmpty) {
                Navigator.pop(context, {"currentRating": _animalScore.text});
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Please enter a rating")),
                );
              }
            },
            child: Text("Return to first screen"),
          )
        ],
      ),
    );
  }
}

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FirstScreen("None"),
    );
  }
}

class FirstScreen extends StatefulWidget {
  final String currentRating;

  FirstScreen(this.currentRating);

  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();
  String currentRating = "None";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Screen'),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _typeController,
                decoration: InputDecoration(
                  labelText: 'Enter type here',
                ),
                validator: (value) {
                  if (value == "cat" || value == 'dog') {
                    return null;
                  }
                  return "Please enter cat or dog";
                },
              ),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Enter the name here',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter a name";
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: () async {
                  // Validate returns true if the form is valid, or false otherwise.
                  if (_formKey.currentState?.validate() == true) {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SecondScreen(
                          name: _nameController.text,
                          imagePath: "assets/images/${_typeController.text}.jpg",
                        ),
                      ),
                    );

                    if (result != null && result.containsKey('currentRating')) {
                      setState(() {
                        currentRating = result['currentRating'];
                      });
                    }
                  }
                },
                child: Text('Submit'),
              ),
              Text('Current Rating: $currentRating'),
            ],
          ),
        ),
      ),
    );
  }
}

class SecondScreen extends StatefulWidget {
  final String name;
  final String imagePath;

  const SecondScreen({required this.name, required this.imagePath});

  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  late String name;
  late String imagePath;

  @override
  void initState() {
    super.initState();
    // Initialize state with the values passed from the first screen
    name = widget.name;
    imagePath = widget.imagePath;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Screen'),
      ),
      body: Center(
        child: CustomCard(
          name: name,
          picturePath: imagePath,
        ),
      ),
    );
  }
}
