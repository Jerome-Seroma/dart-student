class MoblieApp {
  
  String appName;
  String version;

  MoblieApp(this.appName, this.version);

  void displayinfo(){
    print("App Name: $appName");
    print("Version: $version");
  }
}

class Student {
  String studentid;
  String name;
  String email;

  Student(this.studentid, this.name, this.email);

  void displayStudent(){
    print("Student ID: $studentid");
    print("Student Name: $name");
    print("Student email: $email");
  }

  void enrollCourse(){

  }
}

class course {
  String coursecode;
  String coursename;
  String units;

  course(this.coursecode, this.coursename, this.units);

  void displaycourse(){
    print("Course code: $coursecode");
    print("Course name: $coursename");
    print("Units: $units");
  }
}
// class UserAccount{
//   String username;
//   String email;
//   String _password;

//   UserAccount(this.username, this.email, this._password);
//   void setPassword(String newPassword){
//     _password = newPassword;
//   }

//   bool checkPassword(String password){
//     return _password == password;
//   }

//   void displayUserinfo(){
//     print("Username: $username");
//     print("Email: $email");
//   }
// }
// class MobileDevice{
//   String brand;
//   String model;

//   MobileDevice(this.brand, this.model);

//   void displayDeviceinfo(){
//     print("Brand: $brand");
//     print("Model: $model");
//   }

//   void showPlatform(){
//     print("Generic Mobile Platform");
//   }
  
// }

// class AndroidDevice extends MobileDevice{
//   String androidVersion;
//   AndroidDevice(
//     String brand,
//     String model,
//     this.androidVersion,
//   ):super(brand,model);
//   void displayAndroidinfo(){
//     displayDeviceinfo();
//     print("Android Version: $androidVersion");
//   }
//   @override
//   void showPlatform() {
//     print("Android platform");
//   }
// }

// class IOSDevice extends MobileDevice{
//   String IOSVersion;
//   IOSDevice(
//     String brand,
//     String model,
//     this.IOSVersion,
//   ):super(brand,model);
//   void displayIOSinfo(){
//     displayDeviceinfo();
//     print("IOS Version: $IOSVersion");
//   }
//   @override
//   void showPlatform() {
//     print("IOS platform");
//   }
//   }


void main() {

}