import 'package:flutter/material.dart';

void main() {
  runApp(const StudentInformationSystem());
}

// ==========================================
// STUDENT CLASS
// ==========================================

class Student {
  String name;
  int age;
  String course;
  double gwa;

  Student(this.name, this.age, this.course, this.gwa);
}

// ==========================================
// STUDENT MANAGER CLASS
// ==========================================

class StudentManager {
  List<Student> students = [];

  void addStudent(Student student) {
    students.add(student);
  }

  Student? searchStudent(String name) {
    for (var student in students) {
      if (student.name.toLowerCase() == name.toLowerCase()) {
        return student;
      }
    }
    return null;
  }

  bool deleteStudent(String name) {
    Student? student = searchStudent(name);

    if (student != null) {
      students.remove(student);
      return true;
    }

    return false;
  }

  double getClassAverage() {
    if (students.isEmpty) {
      return 0;
    }

    double total = 0;

    for (var student in students) {
      total += student.gwa;
    }

    return total / students.length;
  }

  Student? getHighest() {
    if (students.isEmpty) {
      return null;
    }

    Student highest = students[0];

    for (var student in students) {
      if (student.gwa > highest.gwa) {
        highest = student;
      }
    }

    return highest;
  }

  Student? getLowest() {
    if (students.isEmpty) {
      return null;
    }

    Student lowest = students[0];

    for (var student in students) {
      if (student.gwa < lowest.gwa) {
        lowest = student;
      }
    }

    return lowest;
  }
}

// ==========================================
// FLUTTER APP
// ==========================================

class StudentInformationSystem extends StatelessWidget {
  const StudentInformationSystem({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Student Information System",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
        useMaterial3: true,
      ),
      home: const StudentHomePage(),
    );
  }
}

// ==========================================
// HOME PAGE
// ==========================================

class StudentHomePage extends StatefulWidget {
  const StudentHomePage({super.key});

  @override
  State<StudentHomePage> createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State<StudentHomePage> {
  final StudentManager manager = StudentManager();

  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final courseController = TextEditingController();
  final gwaController = TextEditingController();

  final searchController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    courseController.dispose();
    gwaController.dispose();
    searchController.dispose();
    super.dispose();
  }

  // ========================================
  // ADD STUDENT
  // ========================================

  void addStudent() {
    String name = nameController.text.trim();
    int? age = int.tryParse(ageController.text.trim());
    String course = courseController.text.trim();
    double? gwa = double.tryParse(gwaController.text.trim());

    if (name.isEmpty ||
        age == null ||
        course.isEmpty ||
        gwa == null) {
      showMessage("Please enter valid student information.");
      return;
    }

    manager.addStudent(
      Student(name, age, course, gwa),
    );

    nameController.clear();
    ageController.clear();
    courseController.clear();
    gwaController.clear();

    setState(() {});

    showMessage("Student has been added!");
  }

  // ========================================
  // SEARCH STUDENT
  // ========================================

  void searchStudent() {
    String name = searchController.text.trim();

    if (name.isEmpty) {
      showMessage("Please enter a student name.");
      return;
    }

    Student? student = manager.searchStudent(name);
    if (student == null) {
      showMessage("Student not found.");
      return;
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Student Found!"),
          content: Text(
            "Name   : ${student.name}\n"
            "Age    : ${student.age}\n"
            "Course : ${student.course}\n"
            "GWA    : ${student.gwa}",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  // ========================================
  // DELETE STUDENT
  // ========================================

  void deleteStudent() {
    String name = searchController.text.trim();

    if (name.isEmpty) {
      showMessage("Enter the student name first.");
      return;
    }

    bool deleted = manager.deleteStudent(name);

    if (deleted) {
      setState(() {});
      searchController.clear();
      showMessage("Student deleted successfully!");
    } else {
      showMessage("Student not found.");
    }
  }

  // ========================================
  // UPDATE STUDENT
  // ========================================

  void updateStudent() {
    String name = searchController.text.trim();

    if (name.isEmpty) {
      showMessage("Enter the student name first.");
      return;
    }

    Student? student = manager.searchStudent(name);

    if (student == null) {
      showMessage("Student not found.");
      return;
    }

    final updateName =
        TextEditingController(text: student.name);

    final updateAge =
        TextEditingController(text: student.age.toString());

    final updateCourse =
        TextEditingController(text: student.course);

    final updateGwa =
        TextEditingController(text: student.gwa.toString());

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Update Student"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: updateName,
                  decoration: const InputDecoration(
                    labelText: "Name",
                  ),
                ),
                TextField(
                  controller: updateAge,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "Age",
                  ),
                ),
                TextField(
                  controller: updateCourse,
                  decoration: const InputDecoration(
                    labelText: "Course",
                  ),
                ),
                TextField(
                  controller: updateGwa,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: const InputDecoration(
                    labelText: "GWA",
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                int? age =
                    int.tryParse(updateAge.text.trim());

                double? gwa =
                    double.tryParse(updateGwa.text.trim());

                if (updateName.text.trim().isEmpty ||
                    age == null ||
                    updateCourse.text.trim().isEmpty ||
                    gwa == null) {
                  showMessage("Please enter valid information.");
                  return;
                }
                student.name = updateName.text.trim();
                student.age = age;
                student.course = updateCourse.text.trim();
                student.gwa = gwa;

                Navigator.pop(context);

                setState(() {});

                showMessage(
                  "Student information updated!",
                );
              },
              child: const Text("Update"),
            ),
          ],
        );
      },
    );
  }

  // ========================================
  // CLASS AVERAGE
  // ========================================

  void showAverage() {
    if (manager.students.isEmpty) {
      showMessage("No students available.");
      return;
    }

    double average = manager.getClassAverage();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Class Average"),
          content: Text(
            "Class Average GWA: "
            "${average.toStringAsFixed(2)}",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  // ========================================
  // HIGHEST & LOWEST
  // ========================================

  void showHighestLowest() {
    if (manager.students.isEmpty) {
      showMessage("No students available.");
      return;
    }

    Student? highest = manager.getHighest();
    Student? lowest = manager.getLowest();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Grade Information"),
          content: Text(
            "HIGHEST GRADE\n"
            "Name: ${highest!.name}\n"
            "GWA: ${highest.gwa}\n\n"
            "LOWEST GRADE\n"
            "Name: ${lowest!.name}\n"
            "GWA: ${lowest.gwa}",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  // ========================================
  // MESSAGE
  // ========================================

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  // ========================================
  // TEXT FIELD
  // ========================================

  Widget inputField(
    String label,
    TextEditingController controller, {
    bool number = false,
    bool decimal = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextField(
        controller: controller,
        keyboardType: number
            ? TextInputType.numberWithOptions(
                decimal: decimal,
              )
            : TextInputType.text,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  // ========================================
  // BUILD UI
  // ========================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Student Information System",
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [

            // ADD STUDENT
            const Text(
              "Add Student",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            inputField(
              "Student Name",
              nameController,
            ),
            inputField(
              "Student Age",
              ageController,
              number: true,
            ),

            inputField(
              "Student Course",
              courseController,
            ),

            inputField(
              "Student GWA",
              gwaController,
              number: true,
              decimal: true,
            ),

            ElevatedButton.icon(
              onPressed: addStudent,
              icon: const Icon(Icons.person_add),
              label: const Text("Add Student"),
            ),

            const SizedBox(height: 30),

            // SEARCH / MANAGE
            const Text(
              "Search / Manage Student",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            inputField(
              "Enter Student Name",
              searchController,
            ),

            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElevatedButton.icon(
                  onPressed: searchStudent,
                  icon: const Icon(Icons.search),
                  label: const Text("Search"),
                ),

                ElevatedButton.icon(
                  onPressed: updateStudent,
                  icon: const Icon(Icons.edit),
                  label: const Text("Update"),
                ),

                ElevatedButton.icon(
                  onPressed: deleteStudent,
                  icon: const Icon(Icons.delete),
                  label: const Text("Delete"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            // STATISTICS
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: showAverage,
                    icon: const Icon(Icons.calculate),
                    label: const Text("Class Average"),
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: showHighestLowest,
                    icon: const Icon(Icons.grade),
                    label: const Text("Highest / Lowest"),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            // STUDENT LIST
            const Text(
              "Student List",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            if (manager.students.isEmpty)
              const Card(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    "No students available.",
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            else
              ...manager.students.asMap().entries.map(
                (entry) {
                  int index = entry.key;
                  Student student = entry.value;

                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text(
                          "${index + 1}",
                        ),
                      ),

                      title: Text(
                        student.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        "Age: ${student.age}\n"
                        "Course: ${student.course}\n"
                        "GWA: ${student.gwa}",
                      ),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}