import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ЭФБО-03-22',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      // appBar: AppBar(title: Text('ыыыыыыыыыыы')
      // ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          
          Image.network('https://avatars.mds.yandex.net/i?id=933785ad420e31212f9ba13fc2c62efacb081a40-7755612-images-thumbs&n=13', width: 300, height: 200,),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(decoration: InputDecoration(
              hintText: 'Login',
              border: OutlineInputBorder(),
            ),),
          ),

          ElevatedButton(onPressed: (){}, child: const Text('Login'),
          ),

          ElevatedButton(onPressed: (){}, child: const Text('Registration'),
          ),

         /* Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Container(color: Colors.blueAccent, width: 200, height: 100,
                child: Center(child: Text('1', style: TextStyle(fontSize: 30)
                ,)
                  ,)
                ,),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Container(color: Colors.blueAccent, width: 200, height: 100,
                child: Center(child: Text('2', style: TextStyle(fontSize: 30)
                  ,)
                  ,)
                ,),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Container(color: Colors.blueAccent, width: 200, height: 100,
                child: Center(child: Text('3', style: TextStyle(fontSize: 30)
                  ,)
                  ,)
                ,),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Container(color: Colors.blueAccent, width: 200, height: 100,
                child: Center(child: Text('4', style: TextStyle(fontSize: 30)
                  ,)
                  ,)
                ,),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Container(color: Colors.blueAccent, width: 200, height: 100,
                child: Center(child: Text('5', style: TextStyle(fontSize: 30)
                  ,)
                  ,)
                ,),
            ),
          ),*/
        ],
      ),

    );
  }



}

