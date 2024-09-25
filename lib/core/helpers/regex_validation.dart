
extension StringValidator on String {
  bool containsUpperCase() {
    RegExp regEx = RegExp(r"(?=.*?[A-Z])\w+");
    return regEx.hasMatch(this);
  }

  bool containsSpecialChars() {
    RegExp regEx = RegExp(r'[@#!*&]');
    return regEx.hasMatch(this);
  }
  bool containsLowerCase(){
     RegExp regEx = RegExp(r"(?=.*[a-z])\w+");
    return regEx.hasMatch(this);
  }
  
   bool passwordValidator() {
    RegExp regEx = RegExp(r"(?=.*?[A-Z])(?=.*[a-z])(?=.*?[!@#&*]).{7,}\w+");
    return regEx.hasMatch(this);
  }
   bool containsSpace(){
    RegExp regEx = RegExp("[\\s]");
    return regEx.hasMatch(this);
   }

   bool emailIsValidated (){
     RegExp regEx = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return regEx.hasMatch(this);
   }

   String get capitalize =>
      "${this[0].toUpperCase()}${substring(1).toLowerCase()}";

  String get capitalizeFirstofEach =>
      split(" ").map((str) => str.capitalize).join(" ");

      String get addCommasToNumber => replaceAllMapped(
        RegExp(
          r'(\d{1,3})(?=(\d{3})+(?!\d))',
        ),
        (Match m) => '${m[1]},',
      );
}
