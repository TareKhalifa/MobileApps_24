import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  final _formKey = GlobalKey<FormState>();
  bool valid = false;
  String pic = "";
  Map<String, String> mp = {
    'cat': 'cat.jpg',
    'dog': 'dog.jpg',
  };
  // Create a controller to retrieve the text input from the TextFormField
  final TextEditingController _nameController = TextEditingController();
  void _showImage(String text) {
    text = text.toLowerCase();
    if (mp.keys.any((key) => text.contains(key))) {
      pic = mp[mp.keys.firstWhere((key) => text.contains(key))]!;
      valid = true;
    } else {
      valid = false;
    }
    setState(() {});
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Form Example'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey, // Associate the form key
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Enter text here',
                ),
                // onChanged: (value)
                //   setState(() {
                //     // Update the value as the user types
                //   });
                // },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter text here';
                  }
                  return null;
                },
              ),
/*
              Text(_nameController.text.toUpperCase()),
*/
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Validate returns true if the form is valid, or false otherwise.
                  if (_formKey.currentState?.validate() == true) {
                    // Process data if the form is valid
                    _showImage(_nameController.text);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(_nameController.text)),
                    );
                  }
                },
                child: Text('Submit'),
              ),
              if (valid)
                Image.asset(
                  "assets/images/" + pic,
                  width: 100,
                  height: 100,
                )
            ],
          ),
        ),
      ),
    );
  }
}
