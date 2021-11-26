import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_todo_app/logic/models/todo.dart';
import 'package:my_todo_app/presentation/constants.dart';

typedef OnSaveCallback = Function(String task, String note, DateTime? date);

class AddEditScreen extends StatefulWidget {
  final bool isEditing;
  final OnSaveCallback onSave;
  final Todo? todo;

  AddEditScreen({
    Key? key,
    required this.onSave,
    required this.isEditing,
    required this.todo,
  }) : super(key: key);

  @override
  _AddEditScreenState createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  static final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? _task;
  String? _note;
  DateTime? _date;

  TextEditingController _dateController = TextEditingController();

  bool get isEditing => widget.isEditing;


  @override
  void initState() {
    if (isEditing && widget.todo!.date != null) {
      final formattedDate = DateFormat.yMMMd().format(widget.todo!.date!);
      _dateController = new TextEditingController(text: formattedDate);
    }
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isEditing ? Constants.screen_edit_todo_title : Constants.screen_add_todo_title,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: isEditing ? widget.todo!.task : '', //todo
                autofocus: !isEditing,
                style: textTheme.headline5,
                decoration: InputDecoration(
                  hintText: 'What needs to be done?',
                ),
                validator: (val) {
                  return val!.trim().isEmpty
                      ? 'Please enter some text'
                      : null;
                },
                onSaved: (value) => _task = value!,
              ),
              TextFormField(
                initialValue: isEditing ? widget.todo!.note : '', //todo
                maxLines: 10,
                style: textTheme.subtitle1,
                decoration: InputDecoration(
                  hintText: 'Additional Notes...',
                ),
                onSaved: (value) => _note = value!,
              ),
              TextFormField(
                controller: _dateController,
                maxLines: 1,
                keyboardType: TextInputType.none,
                onTap: (){
                  showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2030, 1, 1))
                      .then((pickedDate) {
                    if (pickedDate == null) return;
                    print('picked date: $pickedDate');
                    setState(() {
                      _dateController.text = DateFormat.yMMMd().format(pickedDate);
                      _date = pickedDate;
                    });
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Choose date',
                  icon: const Icon(Icons.calendar_today),
                  labelStyle: TextStyle(decorationStyle: TextDecorationStyle.solid),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(isEditing ? Icons.check : Icons.add),
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
            //todo
            widget.onSave(_task!, _note!, _date);
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}