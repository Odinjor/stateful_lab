import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stateful Lab',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: CounterWidget(),
    );
  }
}

class CounterWidget extends StatefulWidget {
  @override
  _CounterWidgetState createState() => _CounterWidgetState();
  
}

class _CounterWidgetState extends State<CounterWidget> {
  int _counter = 0; // This is our STATE
  Color get counterColor {
                  if (_counter == 0) return Colors.red;
                  if (_counter > 50) return Colors.green;
                  return Colors.black;
                }


   late final TextEditingController _controller;
  @override
  void initState() {
    super.initState();
    // Any initialization code can go here
    _controller = TextEditingController(
      text: _counter.toString(),
    ); 
  }
    @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Interactive Counter')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              color: Colors.blue.shade100,
              padding: EdgeInsets.all(20),
              child: Text(
                '$_counter',
                style:
                TextStyle(fontSize: 50.0, color: counterColor),
                
              ),
            ),
          ),
          SizedBox(height: 20),
          TextField(
      controller: _controller,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: "Enter a number",
      ),
    ),
      const SizedBox(height: 20), 
          Slider(
            min: 0, max: 100,
            value: _counter.toDouble(),
            onChanged: (double value) {
              // 👇 This triggers the UI rebuild
              setState(() {
                _counter = value.toInt();
                _controller.text = _counter.toString();
              });
            },
          ),
          ElevatedButton(
                onPressed: () {
                  setState(() {
                    _counter++;
                    _controller.text = _counter.toString();
                  });
                },
                child: const Text('Increment'),
              ),
              const SizedBox(height: 24),
           ElevatedButton(
                onPressed: () {
                  setState(() {
                    _counter = 0;
                    _controller.text = _counter.toString();
                  });
                },
                child: const Text('Reset'),
              ),
              const SizedBox(height: 24), 
              ElevatedButton(
                onPressed: () {
                  if (_counter >= 0) {
                  setState(() {
                    _counter--;
                    _controller.text = _counter.toString();
                  }); }
                },
                child: const Text('Decrement'),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
      onPressed: () {
        int value = int.tryParse(_controller.text) ?? 0;

        if (value > 100) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Limit Reached!"),
            ),
          );
        } else {
          setState(() {
            _counter = value;
            _controller.text = value.toString();
          });
        }
      },
      child: const Text("Set Value"),
    ),  
        ],
      ),
    );
  }
}