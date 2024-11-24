import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/event_model.dart';

class EventDetailsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final EventModel event = Get.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text('Event Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              event.title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              event.description,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Date: ${event.date}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 32),
            Text(
              'Location: ${event.location}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 32),

          ],
        ),
      ),
    );
  }
}
