class Note {
  int id;
  String title;
  String content;
  DateTime modifiedTime;

  Note({
    required this.id,
    required this.title,
    required this.content,
    required this.modifiedTime,
  });
}


List<Note> sampleNotes = [
  Note(
    id: 0,
    title: 'Votre première note \n',
    content:
        'Vous pouvez écrire!\n',
    modifiedTime: DateTime(2022,1,1,34,5),
  ),
  Note(
    id: 1,
    title: 'Vous pouvez même modifier celle-ci',
    content:
        'Allez-y faites donc',
    modifiedTime: DateTime(2022,1,1,34,5),
  ),

];
