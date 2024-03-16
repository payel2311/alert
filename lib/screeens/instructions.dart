import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_markdown/flutter_markdown.dart';
import 'widget.dart';

class Instructions extends StatefulWidget {
  @override
  _InstructionsState createState() => _InstructionsState();
}

class _InstructionsState extends State<Instructions> {
  late Future<String> _instructionsContent;

  @override
  void initState() {
    super.initState();
    _instructionsContent = _loadInstructions();
  }

  Future<String> _loadInstructions() async {
    return await rootBundle.loadString('assets/instructions.md');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Instructions'),
      ),
      body: FutureBuilder<String>(
        future: _instructionsContent,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error loading instructions'),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Markdown(data: snapshot.data ?? ''),
            );
          }
        },
      ),
    );
  }
}

