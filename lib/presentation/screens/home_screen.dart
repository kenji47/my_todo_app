

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_todo_app/logic/bloc/app-tab/app_tab_bloc.dart';
import 'package:my_todo_app/logic/models/app_tab.dart';
import 'package:my_todo_app/presentation/constants.dart';
import 'package:my_todo_app/presentation/screens/stats.dart';
import 'package:my_todo_app/presentation/widgets/extra_actions.dart';
import 'package:my_todo_app/presentation/widgets/filter_button.dart';
import 'package:my_todo_app/presentation/widgets/filtered_todos.dart';
import 'package:my_todo_app/presentation/widgets/tab_selector.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppTabBloc, AppTab>(
      builder: (context, activeTab) {
        return Scaffold(
          appBar: AppBar(
            title: Text('My todo app'),
            actions: [
              FilterButton(visible: activeTab == AppTab.todos),
              ExtraActions(),
            ],
          ),
          body: activeTab == AppTab.todos ? FilteredTodos() : Stats(),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, Constants.addTodo);
            },
            child: Icon(Icons.add),
          ),
          bottomNavigationBar: TabSelector(
            activeTab: activeTab,
            onTabSelected: (tab) =>
                BlocProvider.of<AppTabBloc>(context).add(AppTabUpdated(tab)),
          ),
        );
      },
    );
  }
}