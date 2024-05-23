import 'package:fieldz/views/supplier_chat_view.dart';
import 'package:flutter/material.dart';
import 'package:fieldz/views/supplier/Menu/Help/supplier_bug_view.dart';

class SupplierHelpView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        SupplierReportView(), // Navigate to Report page
                  ),
                );
              },
              child: Text('Report a Bug'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        SupplierChatView(), // Navigate to Chat page
                  ),
                );
              },
              child: Text('Chat with Us'),
            ),
          ],
        ),
      ),
    );
  }
}
