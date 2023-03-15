import 'package:flutter/material.dart';

class DropdownList extends StatefulWidget {
  final List<String> choices;
  final Function change;

  DropdownList(this.choices, this.change, {Key? key}) : super(key: key){
    change(choices[0]);
  }

  @override
  State<DropdownList> createState() => _DropdownListState(choices[0]);
}

class _DropdownListState extends State<DropdownList> {
  _DropdownListState(this.dropdownValue);

  String? dropdownValue;

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue;
        });
        widget.change(dropdownValue);
      },
      items: widget.choices.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
