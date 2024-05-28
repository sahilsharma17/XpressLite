extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1).toLowerCase()}";
  }
}
String getStringInitials(String name) {
  if (name.isNotEmpty) {
    List<String> splittedNames = name.split(" ");
    String getInitial(String n) =>
        n.length > 0 ? n.substring(0, 1).toUpperCase() : n;
    if (splittedNames.length > 1)
      return "${getInitial(splittedNames[0])}${getInitial(splittedNames[1])} ";
    else
      return "${getInitial(name)}";
  } else {
    return "";
  }
}
