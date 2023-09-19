import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:projecthive/person.dart';

import 'boxs.dart';

void main() async{
  await Hive.initFlutter();
  Hive.registerAdapter(PersonAdapter());
   boxPersons = await Hive.openBox<Person>('personBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hive',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, });





  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
TextEditingController nameController=TextEditingController();
TextEditingController ageController=TextEditingController();


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 13, 31, 57),
      appBar: AppBar(

        title: Text('Flutter Mapp'),
      ),
      body:Column(
  children: [
    SizedBox(height: 10,),
    Image.network('https://avatars.githubusercontent.com/u/55202745?s=200&v=4',height: 100,),
    Padding(padding: EdgeInsets.all(5),
      child: Card(
        child: Padding(padding: EdgeInsets.all(10),
          child: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Name'
                ),
              ),
              TextField(
                controller: ageController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Age'
                ),
              ),
              SizedBox(height: 10,),
              TextButton(onPressed: (){
                setState(() {
                  boxPersons.put('kay_${nameController.text}', Person(name: nameController.text, age:int.parse( ageController.text)));
                });
              }, 
                  child:Text('Add') )
            ],
          ),
        ),
      ),
    ),
    Expanded(
        child: Padding(padding: EdgeInsets.all(5),
          child: Card(
            child: Padding(padding: EdgeInsets.all(10),
              child: ListView.builder(
                itemCount: boxPersons.length,
                  itemBuilder: (context,index){
                  Person person=boxPersons.getAt(index);
                  return ListTile(
                    leading: IconButton(
                      onPressed: (){
                        setState(() {
                          boxPersons.deleteAt(index);
                        });
                      },
                      icon: Icon(Icons.remove),
                    ),
                    title: Text(person.name),
                    subtitle: Text('Name'),
                    trailing: Text('age:${person.age.toString()}'),
                  );
                  }),
            ),
          ),
        ),

    ),
    TextButton.icon(onPressed: (){
      setState(() {
        boxPersons.clear();

      });
    }, label:Text('Delete all') ,icon:Icon(Icons.delete_outline) , ),
    SizedBox(height: 10,)
  ],


    )); // This trailing comma makes auto-formatting nicer for build methods.

  }
}
