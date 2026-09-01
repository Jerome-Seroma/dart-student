// ==========================================
// STUDENT INFORMATION SYSTEM
// VERSION 1 - BASIC DART
// ==========================================

class Student {
  String name;
  int age;
  String course;
  double gwa;

  Student(this.name, this.age, this.course, this.gwa);
}

// Add Student
void addStudent(
  List<Student> students,
  String name,
  int age,
  String course,
  double gwa,
) {
  students.add(Student(name, age, course, gwa));
  print("$name has been added!");
}

// Search Student
void searchStudent(List<Student> students, String name) {
  bool found = false;

  for (var student in students) {
    if (student.name.toLowerCase() == name.toLowerCase()) {
      print("Student Found!");
      print("Name   : ${student.name}");
      print("Age    : ${student.age}");
      print("Course : ${student.course}");
      print("GWA    : ${student.gwa}");

      found = true;
      break;
    }
  }

  if (!found) {
    print("Student not found.");
  }
}

// View Students
void viewStudents(List<Student> students) {
  print("========== STUDENT LIST ==========");

  if (students.isEmpty) {
    print("No students available.");
    return;
  }

  for (int i = 0; i < students.length; i++) {
    print("Student ${i + 1}");
    print("Name   : ${students[i].name}");
    print("Age    : ${students[i].age}");
    print("Course : ${students[i].course}");
    print("GWA    : ${students[i].gwa}");
  }
}

// Update Student
void updateStudent(
  List<Student> students,
  String searchName,
  String newName,
  int newAge,
  String newCourse,
  double newGwa,
) {
  for (var student in students) {
    if (student.name.toLowerCase() == searchName.toLowerCase()) {
      student.name = newName;
      student.age = newAge;
      student.course = newCourse;
      student.gwa = newGwa;

      print("Student information updated!");
      return;
    }
  }

  print("Student not found.");
}

// Delete Student
void deleteStudent(List<Student> students, String name) {
  for (int i = 0; i < students.length; i++) {
    if (students[i].name.toLowerCase() == name.toLowerCase()) {
      students.removeAt(i);
      print("Student deleted successfully!");
      return;
    }
  }

  print("Student not found.");
}

// Class Average
void classAverage(List<Student> students) {
  if (students.isEmpty) {
    print("No students available.");
    return;
  }

  double total = 0;

  for (var student in students) {
    total += student.gwa;
  }

  double average = total / students.length;

  print("Class Average GWA: ${average.toStringAsFixed(2)}");
}

// Highest and Lowest
void highestLowest(List<Student> students) {
  if (students.isEmpty) {
    print("No students available.");
    return;
  }

  Student highest = students[0];
  Student lowest = students[0];

  for (var student in students) {
    if (student.gwa > highest.gwa) {
      highest = student;
    }

    if (student.gwa < lowest.gwa) {
      lowest = student;
    }
  }

  print("===== HIGHEST GRADE =====");
  print("Name : ${highest.name}");
  print("GWA  : ${highest.gwa}");

  print("===== LOWEST GRADE =====");
  print("Name : ${lowest.name}");
  print("GWA  : ${lowest.gwa}");
}

void main() {
  List<Student> students = [];

  // Add sample students
  addStudent(students, "Juan Dela Cruz", 20, "BSIT", 1.75);
  addStudent(students, "Maria Santos", 21, "BSCS", 1.50);
  addStudent(students, "Pedro Reyes", 19, "BSIT", 2.00);

  // View students
  viewStudents(students);

  // Search
  searchStudent(students, "Maria Santos");

  // Update
  updateStudent(
    students,
    "Pedro Reyes",
    "Pedro Reyes",
    20,
    "BSIT",
    1.75,
  );

  // Delete
  deleteStudent(students, "Juan Dela Cruz");

  // View again
  viewStudents(students);

  // Average
  classAverage(students);

  // Highest and lowest
  highestLowest(students);
}