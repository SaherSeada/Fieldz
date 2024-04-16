import 'package:flutter/material.dart';

class CoachProfilePage extends StatelessWidget {
  final Map<String, dynamic> coach;

  CoachProfilePage({Key? key, required this.coach}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Dummy data for design matching
    String name = coach['name'] ?? 'John Doe';
    String email = coach['email'] ?? 'example@mail.com';
    String userName = coach['userName'] ?? 'JohnDoe01';
    String phone = coach['phone'] ?? '0101234567';
    String status = coach['status'] ?? 'Verified';
    int rating = coach['rating'] ?? 5;
    String imageUrl = coach['imageUrl'] ?? 'assets/Coach.png';
    String sportIcon = coach['sportIcon'] ?? 'assets/Padel.png';

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.black),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
        backgroundColor: Colors.white,
        elevation: 0, // Removes the shadow from the app bar.
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage(imageUrl),
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sport',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                      ),
                    ),
                    _buildRatingStars(rating),
                  ],
                ),
                Spacer(),
                Image.asset('assets/Verify.png', width: 24),
              ],
            ),
            SizedBox(height: 32),
            _buildProfileInfo('Name', name),
            _buildProfileInfo('Email', email),
            _buildProfileInfo('User Name', userName),
            _buildProfileInfo('Phone Number', phone),
            SizedBox(height: 24),
            DropdownButtonFormField<String>(
              value: status,
              icon: Icon(Icons.keyboard_arrow_down, color: Colors.black54),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                border: OutlineInputBorder(),
                labelText: 'Status',
              ),
              items: <String>['Verified', 'Pending', 'Not Verified']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileInfo(String title, String info) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        TextField(
          controller: TextEditingController(text: info),
          decoration: InputDecoration(
            isDense: true,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black54),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black87),
            ),
          ),
          style: TextStyle(fontSize: 16, color: Colors.black87),
        ),
        SizedBox(height: 16),
      ],
    );
  }

  Widget _buildRatingStars(int rating) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        return Icon(
          index < rating ? Icons.star : Icons.star_border,
          color: index < rating ? Colors.amber : Colors.grey,
          size: 20,
        );
      }),
    );
  }
}
