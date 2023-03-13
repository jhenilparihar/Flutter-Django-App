import 'package:app/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

const String url = "http://10.0.2.2:8000";

class UpdatePage extends StatefulWidget {
  final Client client;
  final int id;
  final String note;
  const UpdatePage({
    Key? key,
    required this.client,
    required this.id,
    required this.note,
  }) : super(key: key);

  @override
  _UpdatePageState createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    controller.text = widget.note;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final int id = widget.id;
    return Scaffold(
      appBar: AppBar(
        title: Text("Update"),
      ),
      body: Column(
        children: [
          TextField(
            controller: controller,
          ),
          ElevatedButton(
              onPressed: () {
                widget.client.put(Uri.parse("$url/notes/$id/update"),
                    body: {'body': controller.text});
                Navigator.pop(context);
              },
              child: Text("Update Note"))
        ],
      ),
    );
  }
}
