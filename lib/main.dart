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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Hallila Week 5'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  bool initialState = true;
  bool loadingItems = false;

  List<Customer> customers = [
    Customer("Dylan", "Hallila", 1, "Saver"),
    Customer("Mickey", "Mouse", 2, "Spender"),
    Customer("Bugs", "Bunny", 3, "Spender"),
    Customer("Daffy", "Duck", 4, "Spender"),
    Customer("Goofy", "Goof", 5, "Saver"),
    Customer("Marvin", "Martian", 6, "Saver"),
    Customer("Wile", "Coyote", 7, "Spender"),
    Customer("Jerry", "Mouse", 8, "Saver"),
    Customer("George", "Costanza", 9, "Spender"),
    Customer("Yakko", "Warner", 10, "Spender")
  ];

  void _handleButtonPress() {
    setState(() {
      initialState = false;
      loadingItems = true;
    });

    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        loadingItems = false;
      });
    });
  }

  void _resetApp() {
    setState(() {
      initialState = true;
      loadingItems = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: initialState
            ? ElevatedButton(
                onPressed: _handleButtonPress,
                child: Text("Load Items or something similar :)"))
            : loadingItems
                ? const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[CircularProgressIndicator()],
                  )
                : SingleChildScrollView(
                    child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: customers.map((customer) {
                      return Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(customer.FirstName +
                                    " " +
                                    customer.LastName),
                                Text("ID: " + customer.CustomerID.toString()),
                                Text("Type: " + customer.Type),
                                Divider(),
                              ]));
                    }).toList(),
                  )),
      ),
      floatingActionButton: loadingItems || initialState
          ? null
          : FloatingActionButton(
              onPressed: _resetApp,
              child: Text("Reset"),
            ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class Customer {
  String FirstName, LastName, Type;
  int CustomerID;

  Customer(this.FirstName, this.LastName, this.CustomerID, this.Type);
}
