import 'package:flutter/material.dart';
import 'package:my_todo_app/presentation/widgets/app_theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test app',
      theme: AppTheme.themeDark,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My todo app'),
      ),
      body: Body(),
    );
  }
}

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  DateTime? _pickedDate;
  TextEditingController intialdateval = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
          children: [
            Row(
              children: [
                TextButton(
                  child: Text('Choose date'),
                  onPressed: () {
                    showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2022, 1, 1))
                        .then((pickedDate) {
                      if (pickedDate == null) return;
                      print('picked date: $pickedDate');
                      setState(() {
                        _pickedDate = pickedDate;
                      });
                    });
                  },
                ),
                Text(_pickedDate == null ? '' : '$_pickedDate'),
              ],
            ),
            SizedBox(height: 15),
            Column(children: [
              Text('Date'),
              TextFormField(
                controller: intialdateval,
                keyboardType: TextInputType.none,
                onTap: (){
                  showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2022, 1, 1))
                      .then((pickedDate) {
                    if (pickedDate == null) return;
                    print('picked date: $pickedDate');
                    setState(() {
                      _pickedDate = pickedDate;
                      intialdateval.text = pickedDate.toString();
                    });
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Choose date',
                  icon: const Icon(Icons.calendar_today),
                  labelStyle: TextStyle(decorationStyle: TextDecorationStyle.solid),
                ),

                onSaved: (value) {

                },
              ),
            ],)
          ],
        ));
  }
}
