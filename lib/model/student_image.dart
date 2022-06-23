class StudentImage{
  late String image ;
  late String studentId;
  late int id ;

  StudentImage.fromJson(Map<String,dynamic> json){
   image = json['image'];
   studentId = json['student_id'];
   id = json['id'];
  }
}