import 'package:flutter/material.dart';

void main() {
  runApp(ViewAppointment());
}

class ViewAppointment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Patient Timeline'),
        backgroundColor: Colors.blue,
      ),

      body: ListView(
        children: [
          _buildTimelineItem(
            title: 'Register',
            onPressed: () {
              // Action for Register
            },
            isFirst: true,
            icon: Icons.article,

             // Add checkbox for Register
          ),
          _buildTimelineItem(
            title: 'Appointment',
            onPressed: () {
              // Action for Appointment
            },
            isFirst: true,
            icon: Icons.calendar_today,
            hasCheckbox: true,
          ),
          _buildTimelineItem(
            title: 'Admit',
            onPressed: () {
              // Action for Admit
            },
            isFirst: true,
            icon: Icons.local_hospital, // Add icon for Admit
            hasCheckbox: true,
          ),
          _buildTimelineItem(
            title: 'Treatment',
            onPressed: () {
              // Action for Treatment
            },
            isFirst: true,
            icon: Icons.healing, // Add icon for Treatment
            hasCheckbox: true,
          ),
          _buildTimelineItem(
            title: 'Release',
            onPressed: () {
              // Action for Release
            },
            isFirst: true,
            icon: Icons.check_box, // Add icon for Release
            hasCheckbox: true,
            isLast: true,
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineItem({
    required String title,
    required VoidCallback onPressed,
    bool isFirst = false,
    bool isLast = false,
    IconData? icon,
    bool hasCheckbox = false,
  }) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              margin: EdgeInsets.only(left: 20.0, top: 60.0),
              height: 24.0,
              width: 24.0,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: Colors.purpleAccent,
              ),
              child: isFirst ? Icon(icon, color: Colors.white) : null,
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                height: 3.0,
                color: Colors.purple,
              ),
            ),
          ],
        ),
        ListTile(
          title: Text(title),
          onTap: onPressed,
          trailing: hasCheckbox
              ? Checkbox(
            value: false, // Change this value according to the state
            onChanged: (newValue) {
              // Handle checkbox state change
            },
          )
              : null,
        ),
      ],
    );
  }
}
