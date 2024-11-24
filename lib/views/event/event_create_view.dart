import 'dart:convert';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../controllers/event_controller.dart';
import '../../controllers/theme_controller.dart';
import '../../main.dart';
import '../../models/event_model.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:http/http.dart' as http;

class EventCreateView extends StatefulWidget {
  final EventModel? event;

  EventCreateView({this.event});

  @override
  State<EventCreateView> createState() => _EventCreateViewState();
}

class _EventCreateViewState extends State<EventCreateView> {
  final EventController eventController = Get.find<EventController>();

  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late TextEditingController locationController;
  late TextEditingController dateController;
  late TextEditingController timeController;

  final RxString recurrence = 'None'.obs;
  final Rx<XFile?> pickedImage = Rx<XFile?>(null);
  final RxBool isLoading = false.obs;
  final RxString imageError = ''.obs;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    // Initialize controllers with existing event data if available
    titleController = TextEditingController(text: widget.event?.title ?? '');
    descriptionController =
        TextEditingController(text: widget.event?.description ?? '');
    locationController =
        TextEditingController(text: widget.event?.location ?? '');
    dateController = TextEditingController(
        text: widget.event?.date?.toIso8601String().split('T')[0] ?? '');
    timeController = TextEditingController(text: widget.event?.time ?? '');
    recurrence.value = widget.event?.recurrence ?? 'None';

    if (widget.event?.imageUrl != null) {
      pickedImage.value = XFile(widget.event!.imageUrl!);
    }
  }

  final ThemeController themeController = Get.find<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.event == null ? 'Create Event' : 'Edit Event'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title Field
                _buildTextField(
                  controller: titleController,
                  label: 'Title',
                  validator: (value) => value == null || value.isEmpty
                      ? 'Title is required'
                      : null,
                ),
                const SizedBox(height: 16),

                // Description Field
                _buildTextField(
                  controller: descriptionController,
                  label: 'Description',
                  validator: (value) => value == null || value.isEmpty
                      ? 'Description is required'
                      : null,
                ),
                const SizedBox(height: 16),

                // Location Field
                _buildTextField(
                  controller: locationController,
                  label: 'Location',
                  validator: (value) => value == null || value.isEmpty
                      ? 'Location is required'
                      : null,
                ),
                const SizedBox(height: 16),

                // Date Picker
                _buildDateTimeField(
                  controller: dateController,
                  label: 'Date',
                  icon: Icons.calendar_today,
                  isDate: true,
                  context: context,
                ),
                const SizedBox(height: 16),

                // Time Picker
                _buildDateTimeField(
                  controller: timeController,
                  label: 'Time',
                  icon: Icons.access_time,
                  isDate: false,
                  context: context,
                ),
                const SizedBox(height: 16),

                // Recurrence Dropdown
                _buildDropdownField(),
                const SizedBox(height: 16),

                // Image Upload Section
                Text(
                  'Upload an Image',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 8),
                Obx(() {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (pickedImage.value != null)
                        Card(
                          elevation: 4,
                          child: Image.file(
                            File(pickedImage.value!.path),
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 200,
                          ),
                        ),
                      Center(
                        child: OutlinedButton(
                            style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            onPressed: _pickImage,
                            child: Text(
                              pickedImage.value == null
                                  ? 'Choose Image'
                                  : 'Change Image',
                            )),
                      ),
                      if (imageError.value.isNotEmpty)
                        Center(
                          child: Text(
                            imageError.value,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                    ],
                  );
                }),
                const SizedBox(height: 32),

                // Submit Button
                Obx(() {
                  return isLoading.value
                      ? const Center(child: CircularProgressIndicator())
                      : Center(
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              onPressed: _submitEvent,
                              child: Text(
                                  widget.event == null
                                      ? 'Create Event'
                                      : 'Update Event',
                                  style: TextStyle(color: Colors.white))),
                        );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      ),
      validator: validator,
    );
  }

  Widget _buildDateTimeField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required bool isDate,
    required BuildContext context,
  }) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        suffixIcon: Icon(icon),
      ),
      onTap: () async {
        if (isDate) {
          final picked = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now(),
            lastDate: DateTime(2100),
          );
          if (picked != null) {
            controller.text = picked.toIso8601String().split('T')[0];
          }
        } else {
          final picked = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.now(),
          );
          if (picked != null) {
            controller.text = picked.format(context);
          }
        }
      },
      validator: (value) =>
          value == null || value.isEmpty ? '$label is required' : null,
    );
  }

  Widget _buildDropdownField() {
    return DropdownButtonFormField<String>(
      value: recurrence.value,
      decoration: const InputDecoration(
        labelText: 'Recurrence',
        border: OutlineInputBorder(),
      ),
      items: ['None', '1 Minute', '2 Minutes', '5 Minutes']
          .map((e) => DropdownMenuItem(
          value: e,
          child: Text(
            e,
            style: TextStyle(
                color: themeController.isDarkMode
                    ? Colors.white
                    : Colors.black),
          )))
          .toList(),
      onChanged: (value) => recurrence.value = value!,
      validator: (value) =>
      value == null || value.isEmpty ? 'Please select a recurrence option' : null,
    );
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    pickedImage.value = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage.value != null) {
      final imageFile = File(pickedImage.value!.path);
      final imageSize = await imageFile.length();
      if (imageSize > 23000 * 1024) {
        // 300 KB
        imageError.value = 'Image size must be less than 300 KB';
        pickedImage.value = null;
      } else {
        imageError.value = '';
      }
    }
  }

  Future<void> _submitEvent() async {
    if (_formKey.currentState!.validate()) {
      isLoading.value = true;

      final event = EventModel(
        id: widget.event?.id ?? '',
        title: titleController.text,
        description: descriptionController.text,
        location: locationController.text,
        date: DateTime.parse(dateController.text),
        time: timeController.text,
        recurrence: recurrence.value,
        imageUrl: pickedImage.value?.path,
      );

      try {
        if (widget.event == null) {
          await eventController.createEvent(event);
        } else {
          await eventController.updateEvent(event.id, event);
        }

        await scheduleEventNotification(event);
        Get.back();
      } catch (e) {
        print('Error: $e');
        Get.snackbar(
          'Error',
          'Failed to save event',
          snackPosition: SnackPosition.BOTTOM,
        );
      }

      isLoading.value = false;
    }
  }
}
Future<void> scheduleEventNotification(EventModel event) async {
  // 1. Set up recurrence interval
  Duration interval = _getRecurrenceInterval(event.recurrence??"");
  if (interval == Duration.zero) return;

  // 2. Initialize timezone data
  tz.initializeTimeZones();
  final mumbaiTimeZone = tz.getLocation('Asia/Kolkata');

  // 3. Configure notification details
  const NotificationDetails platformDetails = NotificationDetails(
    android: AndroidNotificationDetails(
      'event_channel',
      'Event Notifications',
      importance: Importance.high,
      priority: Priority.high,
      enableVibration: true,
      playSound: true,
      channelShowBadge: true,
    ),
  );

  // 4. Calculate notification time
  DateTime currentTime = DateTime.now();
  DateTime notificationTime = currentTime.add(interval);
  tz.TZDateTime scheduledTime = tz.TZDateTime.from(notificationTime, mumbaiTimeZone);

  // 5. Ensure scheduled time is in the future
  if (scheduledTime.isBefore(tz.TZDateTime.now(mumbaiTimeZone))) {
    scheduledTime = tz.TZDateTime.now(mumbaiTimeZone).add(interval);
  }

  // 6. Schedule the notification
  try {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      event.id.hashCode,
      event.title,
      event.description,
      scheduledTime,
      platformDetails,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
    print('Notification scheduled successfully for: $scheduledTime');
  } catch (e) {
    print('Error scheduling notification: $e');
    rethrow;
  }
}

Duration _getRecurrenceInterval(String recurrence) {
  switch (recurrence) {
    case '1 Minute':
      return const Duration(minutes: 1);
    case '2 Minutes':
      return const Duration(minutes: 2);
    case '5 Minutes':
      return const Duration(minutes: 5);
    default:
      return Duration.zero;
  }
}
