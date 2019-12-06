
class Note{
  int _id,_priority;
  String _title,_description,_date;

  Note(this._priority, this._title, this._date, [this._description]);
  Note.withId(this._id, this._priority, this._title, this._date,[this._description]);

// Getter Functions
  get date => _date;
  get description => _description;
  // ignore: unnecessary_getters_setters
  String get title => _title;
  get priority => _priority;
  int get id => _id;


// Setter Functions
  set date(value) {
    _date = value;
  }

  set description(value) {
    _description = value;
  }

  // ignore: unnecessary_getters_setters
  set title(String value) {
    _title = value;
  }

  set priority(value) {
    _priority = value;
  }

  Map<String, dynamic> toMap(){
    var map = Map<String,dynamic>();
    map['id'] = this._id;
    map['title'] = this._title;
    map['description'] = this._description;
    map['priority'] = this._priority;
    map['date'] = this._date;
    return map;
  }

  Note.mapToObject(Map<String,dynamic> map){
    this._id = map['id'];
    this._title = map['title'];
    this._description = map['description'];
    this._priority = map['priority'];
    this._date = map['date'];
  }
}