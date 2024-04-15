// class DateProvider with ChangeNotifier {
//   DateTime? _selectedDate = DateTime.now();

//   get selectedDate => _selectedDate;

//   Future<String?> selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//         context: context,
//         initialDate: _selectedDate!,
//         firstDate: DateTime(1900),
//         lastDate: DateTime(2099));

//     if (picked != null && picked != _selectedDate) {
//       _selectedDate = picked;
//       var dateValue = DateFormat("d/MM/yyyy HH:mm:ss").format(_selectedDate!);
//       notifyListeners();
//       return dateValue;
//     }
//     notifyListeners();
//     return null;
//   }
// }
