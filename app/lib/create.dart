import 'package:app/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

const String url = "http://10.0.2.2:8000";

class CreatePage extends StatefulWidget {
  final Client client;
  const CreatePage({Key? key, required this.client}) : super(key: key);

  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create"),
      ),
      body: Column(
        children: [
          TextField(
            controller: controller,
          ),
          ElevatedButton(
              onPressed: () {
                widget.client.post(Uri.parse("$url/notes/create/"),
                    body: {'body': controller.text});
                Navigator.pop(context);
              },
              child: Text("Create Note"))
        ],
      ),
    );
  }
}
