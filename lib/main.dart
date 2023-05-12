import 'dart:math';
import 'package:provider/src/provider.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import './bloc/counter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (ctx) => CounterBloc(),
      child: MaterialApp(
        title: 'Flutter Counter',
        theme: ThemeData(
        
          primarySwatch: Colors.blue,
        ),
        home: const CounterApp(title: 'Counter Page'),
      ),
    );
  }
}

class CounterApp extends StatelessWidget {
  final String title;

  const CounterApp({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    print('build () => called');

    Widget _actionButtons(){
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton(
            onPressed: () {
              context.read<CounterBloc>().add(Decrement());
            },
            tooltip: 'Decrement',
            child: const Icon(Icons.remove),
          ),
          FloatingActionButton(
            onPressed: () {
              context.read<CounterBloc>().add(Increment());
            },
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
        ],
      );
    }

    return Scaffold(
      appBar: _appBarContent(),
      body: _bodyContent(),
      floatingActionButton: _actionButtons(), 
    );
  }

  AppBar _appBarContent(){
    return AppBar(
        
        title: Text(title),
      );
  }

  Widget _bodyContent(){
    return Center( 
        child: Column(
         
          
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Counting',
            ),
            BlocBuilder<CounterBloc, CounterState>(
              builder: (context, state) {
                print('blockbuilder => called');
                return Text(
                  '${state.count}',
                  style: Theme.of(context).textTheme.headlineMedium,
                );
              },
            ),
          ],
        ),
      );
  }
}