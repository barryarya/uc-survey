import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/form.dart';

class FormController {
  final void Function(String) callback;

  static const String url =
      "https://script.google.com/macros/s/AKfycbw0G3oajpNujPYc2H8pcGjXqTlxjGsRLVP0-MsGBYl2-exIOfoK3KAtdsOpw8gfTWZsPA/exec";
  static const String statusSuccess = "SUCCESS";

  FormController(this.callback);

  void submitForm(FormFeedback formFeedback) async {
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body: formFeedback.toParams(), // kirim sebagai form-urlencoded
      );

      final responseData = jsonDecode(response.body);
      callback(responseData['status']);
    } catch (e) {
      print("Submit error: $e");
      callback("FAILED");
    }
  }
}
