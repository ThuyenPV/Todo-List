import 'package:flutter/material.dart';

class AddNewTask extends StatelessWidget {
  final ValueChanged<String>? onTitleChanged;
  final ValueChanged<String>? onDescriptionChanged;

  const AddNewTask({
    Key? key,
    this.onTitleChanged,
    this.onDescriptionChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const _inputBorder = UnderlineInputBorder(
      borderSide: BorderSide(color: Color(0xffcfcfcf)),
    );
    return Column(
      children: [
        const Text(
          'ADD TASK',
          style: TextStyle(
            color: Color(0xff595959),
            fontSize: 20,
            fontWeight: FontWeight.w800,
          ),
        ),
        Container(
          height: 70,
          alignment: Alignment.bottomLeft,
          margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 3,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 25, right: 25, top: 5),
            child: TextFormField(
              onChanged: onTitleChanged,
              decoration: const InputDecoration(
                hintText: 'Title here',
                hintStyle: TextStyle(
                  color: Color(0xffcfcfcf),
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
                border: InputBorder.none,
              ),
              textInputAction: TextInputAction.next,
            ),
          ),
        ),
        Container(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 30, right: 30, top: 5, bottom: 30),
            child: TextFormField(
              maxLines: 4,
              onChanged: onDescriptionChanged,
              decoration: const InputDecoration(
                hintText: 'Description',
                contentPadding: EdgeInsets.only(left: 20),
                hintStyle: TextStyle(
                  color: Color(0xffcfcfcf),
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
                border: _inputBorder,
                enabledBorder: _inputBorder,
                focusedBorder: _inputBorder,
              ),
              textInputAction: TextInputAction.done,
            ),
          ),
        ),
      ],
    );
  }
}
