import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:testp/views/event/event_create_view.dart';
import '../../controllers/auth_controller.dart';
import '../../controllers/event_controller.dart';
import '../../controllers/theme_controller.dart';
import '../../models/event_model.dart';

class EventListView extends StatefulWidget {
  @override
  State<EventListView> createState() => _EventListViewState();
}

class _EventListViewState extends State<EventListView> {
  final EventController eventController = Get.find<EventController>();

  @override
  void initState() {
    super.initState();apiCall();
    // Ensure this method fetches events correctly
  }

  void apiCall() async {
    await eventController.setCurrentUserId();
    await eventController.fetchEvents();
  }

  final ThemeController themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Events'),
        actions: [
          Obx(() {
            return Switch(
              value: themeController.isDarkMode,
              onChanged: (value) {
                themeController.toggleTheme(value);
              },
            );
          }),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () => Get.find<AuthController>().logout(),
          ),
        ],
      ),
      body: StreamBuilder<List<EventModel>>(
        stream: eventController.eventsStream, // Stream of events
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No events available. Create one!'));
          }

          final events = snapshot.data!;

          return ListView.builder(
            itemCount: events.length,
            itemBuilder: (context, index) {
              print("event image ${events[index].imageUrl}");
              final event = events[index];
              return Card(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: FileImage(File(event.imageUrl ?? "")),
                    // Local file path
                    radius: 30, // Adjust radius for size
                  )
                  // In case there is no image, you can show a placeholder or an empty container

                  ,
                  title: Text(event.title),
                  subtitle: Text(event.description),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit, color: Colors.blue),
                        onPressed: () => Get.to(EventCreateView(
                          event: event,
                        )),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => eventController.deleteEvent(event.id),
                      ),
                    ],
                  ),
                  onTap: () => Get.toNamed('/event-details', arguments: event),
                ),
              );
            },
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Get.toNamed('/create-event'),
      ),
    );
  }


}
