import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';
import '../models/event_model.dart';

class EventController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebase = FirebaseAuth.instance;

// Observable list to store events
  RxList<EventModel> events = <EventModel>[].obs;

  // Stream for events (converted from the observable list)
  Stream<List<EventModel>> get eventsStream => events.stream;

  // User ID (use Firebase Authentication or generate a unique one)
  String currentUserId = "";

  Future<void> setCurrentUserId() async {
    currentUserId = await _firebase.currentUser?.uid ?? "0";
  } // Example: Replace with Firebase user ID if available

  // Fetch events from Firestore for the current user
  Future<void> fetchEvents() async {
    try {
      final snapshot = await _firestore
          .collection('events')
          .where('userId', isEqualTo: currentUserId) // Filter events by userId
          .get();
      events.value = snapshot.docs
          .map((doc) => EventModel.fromMap(doc.id, doc.data()))
          .toList();
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch events: $e');
    }
  }

  // Update event
  Future<void> updateEvent(String eventId, EventModel updatedEvent) async {
    try {
      EventModel updateUserCurrentId =
          updatedEvent.copyWith(userId: currentUserId);
      await _firestore
          .collection('events')
          .doc(eventId)
          .update(updateUserCurrentId.toMap());
      await fetchEvents(); // Refresh events after update
    } catch (e) {
      // Get.snackbar('Error', 'Failed to update event: $e');
    }
  }

  // Create event with image (base64 encoded)
  Future<void> createEvent(EventModel event) async {
    try {
      // Ensure the userId is attached before saving
      EventModel newEvent = event.copyWith(userId: currentUserId);

      await _firestore.collection('events').add(newEvent.toMap());
      fetchEvents(); // Refresh events after creation
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }

  // Delete event
  Future<void> deleteEvent(String eventId) async {
    try {
      await _firestore.collection('events').doc(eventId).delete();
      fetchEvents(); // Refresh events after deletion
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
  }
}
