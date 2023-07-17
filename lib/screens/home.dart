
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notepad_flutter/constants/colors.dart';

import '../models/note.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Note> filterNotes = [];
  bool sorted = false;

  @override
  void initState() {
    super.initState();
    filterNotes = sampleNotes;
  }

  List<Note> sortNotesByModifiedTime(List<Note> notes) {
    if(sorted) {
      notes.sort((a,b) =>  a.modifiedTime.compareTo(b.modifiedTime));
    } else {
      notes.sort((b,a) =>  a.modifiedTime.compareTo(b.modifiedTime));
    }

    sorted=!sorted;
    return notes;
  }



 /** getRandomColor(){
    Random random = Random();
    return backgroundColors[random.nextInt(backgroundColors.length)];
  }
*/

  void onSearchTextChanged(String searchText) {
    setState(() {
      filterNotes = sampleNotes
          .where((note) =>
          note.content.toLowerCase().contains(searchText.toLowerCase()) ||
          note.title.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    });
  }

  void deleteNote(int index){
    setState(() {
      filterNotes.removeAt(index);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16,40,16,0),
        child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Mes notes',
                    style: TextStyle(fontSize: 30, color: Colors.white),),
                  IconButton(onPressed: (){
                    setState(() {
                      filterNotes = sortNotesByModifiedTime(filterNotes);
                    });
                  },
                      padding: EdgeInsets.all(0),
                      icon: Container(
                        width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade800.withOpacity(.8),
                            borderRadius: BorderRadius.circular(10)),
                          child: Icon(
                            Icons.sort,
                            color: Colors.white,
                          ),
                      )
                  )
                ],
              ),
              SizedBox(height: 20,),
              TextField(
                onChanged: onSearchTextChanged,
                style: TextStyle(fontSize: 16,color: Colors.white),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 12),
                  hintText: "Rechercher",
                  hintStyle: TextStyle(color: Colors.grey),
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  fillColor: Colors.grey.shade800,
                  filled: true,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Colors.transparent)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Colors.transparent)),
                ),
              ),
              Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.only(top: 40),
                    itemCount: filterNotes.length,
                    itemBuilder: (context,index) {
                      return
                        Card(
                          margin: const EdgeInsets.only(bottom: 30),
                          color: Colors.orange.shade300,
                          elevation: 3,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              title: RichText(
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                                text: TextSpan(
                                    text: "${filterNotes[index].title} \n",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                        height: 1.5),
                                    children: [
                                      TextSpan(
                                        text: "${filterNotes[index].content}",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal,
                                            fontSize: 14,
                                            height: 1.5),
                                      ),
                                    ]
                                ),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text('Edité :  ${DateFormat('EEE MMM d,yyyy h:mm a').format(filterNotes[index].modifiedTime)}',
                                  style: TextStyle(
                                      fontSize: 10,
                                      fontStyle: FontStyle.italic,
                                      color: Colors.grey.shade800
                                  ),
                                ),
                              ),
                              trailing: IconButton(onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        backgroundColor: Colors.grey.shade900,
                                        icon: Icon(Icons.info, color: Colors.grey,),
                                        title: Text("Voulez-vous vraiment effacer cette note?",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        content: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                          ElevatedButton(
                                            onPressed: (){
                                            Navigator.pop(context,true);
                                          },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.green),
                                            child: SizedBox(
                                              width: 60,
                                            child: Text(
                                              "Oui",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(color: Colors.white),
                                            ),
                                          )),
                                          ElevatedButton(onPressed: (){
                                            Navigator.pop(context,false);
                                          },
                                            style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.red),
                                            child: SizedBox(
                                              width: 60,
                                              child: Text(
                                                "Non",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(color: Colors.white),
                                              ),
                                            )),
                                        ]),
                                      );
                                    });
                                deleteNote(index);
                              },icon: Icon(
                                Icons.delete,
                              ),
                              ),
                            ),
                          ),
                        );
                },
               )
              )
            ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed:() {},
        elevation: 10,
        backgroundColor: Colors.yellow.shade800,
        child: Icon(Icons.post_add, size: 34,color: Colors.black,),
      ),
    );
  }
}
