class Model{
  int id;
  String date,title,content;
  Model({this.id,this.date,this.title,this.content});

  setDate(){
    DateTime now=DateTime.now();
    String date=now.hour.toString()+now.minute.toString()+now.second.toString()+now.day.toString()+now.month.toString()+now.year.toString();
    return int.parse(date);
  }

  Model.fromMap(Map<String,dynamic>map){
    id=map['id'];
    date=map['date'];
    title=map['title'];
    content=map['content'];
  }

  toMap(){
    return <String,dynamic>{
      "id":id,
      "date":date,
      "title":title,
      "content":content,
    };
  }

}