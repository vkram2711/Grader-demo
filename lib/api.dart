import 'dart:convert';
import 'package:http/http.dart' as http;

class GraderApi {
  static Future<Map<String, dynamic>> getFeedback(
    String year,
    String course,
    String question,
    String answer,
    String key
  ) async {
    final url = Uri.https('grader-demo-5bb3b245d4b8.herokuapp.com', '/get_feedback');
    final headers = {
      'Access-Control-Allow-Origin': '*',
      'Accept': '*/*',
      //      'Access-Control-Allow-Credentials': true, // Required for cookies, authorization headers with HTTPS
      'Access-Control-Allow-Headers': 'Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale',
      'Content-Type': 'application/json'};
    final body = jsonEncode({
      'year': year,
      'course': course,
      'question': question,
      'answer': answer,
      'key': key,
    });

    print(year);
    print(course);
    print(question);
    print(answer);
    print(body);
    final response = await http.post(url, headers: headers, body: body);
    print(response);
    if (response.statusCode == 200) {
      print('Data posted successfully!');
    } else {
      print('Error posting data: ${response.statusCode}');
    }

    final jsonResponse = jsonDecode(response.body);
    print(jsonResponse);
    return jsonResponse;
  }
}
