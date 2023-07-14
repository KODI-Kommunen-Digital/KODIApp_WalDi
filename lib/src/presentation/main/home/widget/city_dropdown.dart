import 'package:flutter/material.dart';
import 'package:heidi/src/utils/translate.dart';

class CitiesDropDown extends StatefulWidget {
  final ValueSetter<String>? setLocationCallback;
  final List<String>? cityTitlesList;

  const CitiesDropDown({
    Key? key,
    required this.setLocationCallback,
    required this.cityTitlesList,
  }) : super(key: key);

  @override
  State<CitiesDropDown> createState() => _CitiesDropDownState();
}

class _CitiesDropDownState extends State<CitiesDropDown> {
  @override
  Widget build(BuildContext context) {
    String? selectedOption;
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
        child: Card(
          margin: const EdgeInsets.all(10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
          child: DropdownButtonFormField<String>(
            value: selectedOption,
            onChanged: (newValue) {
              setState(() {
                widget.setLocationCallback!(newValue!);
                selectedOption = newValue;
              });
            },
            items: widget.cityTitlesList?.map((String option) {
              return DropdownMenuItem<String>(
                value: option,
                child: Text(option),
              );
            }).toList(),
            decoration: InputDecoration(
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              labelText: Translate.of(context).translate('select_city'),
              labelStyle: const TextStyle(color: Colors.white),
              border: const OutlineInputBorder(),
            ),
          ),
        ),
      ),
    );
  }
}
