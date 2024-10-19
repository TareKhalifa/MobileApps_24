import 'package:flutter/material.dart';
class CustomCard extends StatelessWidget {
  final String name;
  final String picturePath;
  CustomCard({required this.name, required this.picturePath});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(name),
          Image.asset(picturePath, width: 400, height: 400,),
          ElevatedButton(
              onPressed: ()=>Navigator.pop(context),
              child: Text("Return to first screen"))
        ],
      ) ,
    );
  }
}
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FirstScreen(),
    );
  }
}

class FirstScreen extends StatelessWidget {

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Screen'),
      ),
      body: Center(
        child: Form(
        key: _formKey, // Associate the form key
        child: Column(
          children: <Widget>[
          TextFormField(
          controller: _typeController,
          decoration: InputDecoration(
            labelText: 'Enter type here',
          ),
          validator: (value) {
            if (value=="cat" || value=='dog') {
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
                if (value==null || value.isEmpty) {
                  return "Please enter a name";
                }
                return null;
              },
            ),
            ElevatedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState?.validate() == true) {
                    Navigator.push(context,MaterialPageRoute(
                      builder: (context) =>
                          SecondScreen(name: _nameController.text,
                            imagePath:"assets/images/${_typeController.text}.jpg"),
                    ));
                }
              },
              child: Text('Submit'),
            ),
          ]
      ),
    )));
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
          child: CustomCard(name: name,
              picturePath: imagePath),
    ));
  }
}
