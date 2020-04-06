

class Details{

int _id;
int _dob;
String _firstName;
String _lastName;
String _userName;
String _passWord;
String _sex;
String _email;

  Details (this._dob,this._email,this._firstName,this._lastName,this._passWord,this._sex,this._userName);
  Details.withId (this._dob,this._email,this._firstName,this._lastName,this._passWord,this._sex,this._userName);

  int get id =>_id;
int get dob =>_dob;
String get firstName =>_firstName;
String get lastName =>_lastName;
String get userName =>_userName;
String get password =>_passWord;
String get sex =>_sex;
String get email =>_email;

set firstName(String newfirstName){
  this._firstName = newfirstName;
}

set lastName(String newlastName){
  this._lastName = newlastName;
}

set userName(String newuserName) {
  if (newuserName.length >= 9 ) {
    this._userName = newuserName;
  }
}

set passWord(String newpassWord) {
  if (newpassWord.length >= 6 ) {
    this._userName = newpassWord;
  }
  else{
    print('password have to be more than five letters');
  }
}

set sex(String newsex) {

    this._userName = newsex;
}


set email(String newemail) {

  this._email = newemail;
}

// ignore: missing_return
Map<String, dynamic> toMap(){
  var map = Map<String, dynamic>();
  if(id != null){
    map['id'] = _id;
  }
  map ['firstName'] =_firstName;
  map ['lastName'] =_lastName;
  map ['email'] =_email;
  map ['username'] =_userName;
  map ['password'] =_passWord;

  return map;

}

Details.fromMapObject(Map<String, dynamic> map){
  this._id = map['id'];
  this._firstName = map['firstName'];
  this._lastName = map ['lastName'];
  this._userName = map ['username'];
  this._email = map ['email'];
  this._passWord = map ['password'];


}





}