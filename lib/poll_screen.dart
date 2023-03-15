import 'package:flutter/material.dart';
import 'package:grader_demo/api.dart';
import 'package:grader_demo/dropdown_list.dart';

class PollScreen extends StatefulWidget {
  const PollScreen({Key? key}) : super(key: key);

  @override
  State<PollScreen> createState() => _PollScreenState();
}

class _PollScreenState extends State<PollScreen> {
  String year = "";
  String course = "";
  String question = "";
  String answer = "";
  String? feedback;
  int? grade;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 64, right: 64, top: 28),
        child: Column(
          children: [
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: Text("Year:"),
                ),
                DropdownList(
                    const ["freshman", "sophomore", "junior", "senior"],
                    (value) {
                  year = value;
                }),
              ],
            ),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: Text("Course:"),
                ),
                DropdownList(const [
                  "Arts and Humanities",
                  "Social Science",
                  "Computer Science",
                  "Natural Science"
                ], (value) {
                  course = value;
                }),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                          labelText: "Question prompt",
                          hintText: "Enter question",
                          labelStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      cursorColor: Colors.black,
                      onChanged: (value) {
                        setState(() {
                          question = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    minLines: 10,
                    decoration: InputDecoration(
                      hintText: "Enter student's answer",
                      border: InputBorder.none,
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                    cursorColor: Colors.black,
                    onChanged: (value) {
                      setState(() {
                        answer = value;
                      });
                    },
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16, bottom: 16),
              child: ElevatedButton(
                onPressed: () async {
                  setState(() {
                    feedback = null;
                    grade = null;
                    loading = true;
                  });

                  final response = await GraderApi.getFeedback(year, course, question, answer);

                  setState(() {
                    loading = false;
                    feedback = response['feedback'];
                    grade = response['grade'];
                  });
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue, // Set button color
                  textStyle: const TextStyle(
                    color: Colors.white, // Set text color
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 8), // Set button padding
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(2), // Set rounded corners
                  ),
                ),
                child: const Text('Get feedback'),
              ),
            ),

            if(loading) const CircularProgressIndicator(),
            if(feedback != null) Text("Feedback: ${feedback!}"),
            if(grade != null) Text("Grade: ${grade!}"),
          ],
        ),
      ),
    );
  }
}
