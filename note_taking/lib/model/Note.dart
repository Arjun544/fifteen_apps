class Note {
  String text;
  bool done;

  Note({this.text= 'note', this.done = false});

  factory Note.fromJson(Map<String, dynamic> json) =>
      Note(text: json['text'], done: json['done']);

  Map<String, dynamic> toJson() => {'text': text, 'done': done};
}