import 'package:animated_widgets/widgets/switcher_animated_wid.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animations Demo',
      theme: ThemeData(primaryColor: Colors.greenAccent[400]),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final duration = const Duration(milliseconds: 700);
  bool isOn = false;

  void onChangeState() {
    setState(() {
      isOn = !isOn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE5E5E5),
      body: AnimatedContainer(
        duration: duration,
        color: isOn ? const Color(0xFF171717) : const Color(0xFFE5E5E5),
        child: Center(
          child: Switcher(
              isOn: isOn, duration: duration, onChangeState: onChangeState),
        ),
      ),
    );
  }
}
