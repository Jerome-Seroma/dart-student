import 'dart:io';

List<Map<String,dynamic>> students = [];
int counter = 1;
void main () {
while(true){

print("1.add:");
print("2.view students:");
print("3.edit:");
print("4.delete:");
print("5.exit:");

stdout.write("Enter Number of Choice:");
int Choice = int.parse(stdin.readLineSync()!);

switch(Choice){
    case 1:
        addStudent();
    case 2:
        viewStudent();
    case 3:
        searchStudent();
}
}
}

void addStudent(){
stdout.write("Enter Student Name:");
String? name = stdin.readLineSync();
stdout.write("Enter Course:");
String? course = stdin.readLineSync();
stdout.write("Enter Year Level:");
String? yearlevel = stdin.readLineSync();

students.add({
    "id":counter,
    "name":name,
    "course":course,
    "yearlevel":yearlevel
});
print("Student has been Added");
counter ++;
}

void viewStudent() {

  if (students.isEmpty) {
    print("No students available.");
    return;
  }
  for (int i = 0; i < students.length; i++) {
    print("${students[i]["name"]}");
    print("${students[i]["course"]}");
    print("${students[i]["yearlevel"]}");
  }

}

void searchStudent() {
    if(students.isEmpty){
    print("No students available");
    return;
    }
    stdout.write("Enter Student Name:");
    String? name = stdin.readLineSync();
}
