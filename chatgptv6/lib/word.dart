class Word {
  String word;
  String meaning;
  String example;
  String id;
  Word({ this.word = "", this. meaning = "",this.example = "", this.id = ""});

  // Word.fromJson(Map<String, dynamic> jsonData){
  //   word = jsonData['word'];
  //   meaning = jsonData['meaning'];
  //   example = jsonData['example'];
  // }
  //
  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['word'] = this.word;
  //   data['meaning'] = this.meaning;
  //   data['example'] = this.example;
  //   return data;
  // }
}