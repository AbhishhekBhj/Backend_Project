import 'package:http/http.dart' as http;
import 'dart:developer';

class RemindersRepository {
  static Future<bool> setReminder(
      {required String? username,
      required String? title,
      required String? description,
      required String? dueDate}) async {
    var client = http.Client();
    try {
      var url = Uri.parse('http://10.0.2.2:8000/reminders/set/');
      var response = await client.post(url, body: {
        'username': username!,
        'title': title!,
        'description': description!,
        'due_date': dueDate!
      });
      log(response.body);
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString() + "exception");
      return false;
    }
  }
}
