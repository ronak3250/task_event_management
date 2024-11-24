// /**
//  * Import function triggers from their respective submodules:
//  *
//  * const {onCall} = require("firebase-functions/v2/https");
//  * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
//  *
//  * See a full list of supported triggers at https://firebase.google.com/docs/functions
//  */

// // const {onRequest} = require("firebase-functions/v2/https");
// // const logger = require("firebase-functions/logger");

// // Create and deploy your first functions
// // https://firebase.google.com/docs/functions/get-started

// // exports.helloWorld = onRequest((request, response) => {
// //   logger.info("Hello logs!", {structuredData: true});
// //   response.send("Hello from Firebase!");
// // });


// const functions = require("firebase-functions");
// const admin = require("firebase-admin");

// // Initialize Firebase Admin
// admin.initializeApp();

// // Cloud Function to send push notifications
// exports.sendNotification = functions.firestore
//   .document("todos/{todoId}") // Triggers on any changes to "todos" collection
//   .onWrite((change, context) => {
//     const newData = change.after.data(); // Data after the write
//     const oldData = change.before.data(); // Data before the write (if any)

//     if (!newData) {
//       console.log("No data found!");
//       return null;
//     }

//     const payload = {
//       notification: {
//         title: newData.title || "Reminder!",
//         body: newData.description || "You have an update in your To-Do List.",
//       },
//       data: {
//         todoId: context.params.todoId,
//       },
//     };

//     // Optional: Use a specific topic or targeted device tokens
//     return admin.messaging().sendToTopic("todo_notifications", payload)
//       .then((response) => {
//         console.log("Notification sent successfully:", response);
//       })
//       .catch((error) => {
//         console.error("Error sending notification:", error);
//       });
//   });
const functions = require("firebase-functions");
const admin = require("firebase-admin");

// Initialize Firebase Admin
admin.initializeApp();

// Cloud Function to send push notifications for `events`
exports.sendNotification = functions.firestore
    .document("events/{eventId}") // Triggers on any changes to "events" collection
    .onWrite((change, context) => {
      const newData = change.after.data(); // Data after the write
      const oldData = change.before.data(); // Data before the write (if any)

      if (!newData) {
        console.log("No data found!");
        return null;
      }
      const payload = {
        notification: {
            title: newData.title || "Event Update!",
            body: newData.description || "An event has been updated.",
        },
        data: {
            eventId: context.params.eventId,
            title: newData.title,
            description: newData.description,
            location: newData.location,
            date: newData.date,
            time: newData.time,
            imageUrl: newData.imageUrl || "",
            recurrence: newData.recurrence || "",
        },
    };
    

      // Send notification to a specific topic
      return admin.messaging().sendToTopic("event_notifications", payload)
          .then((response) => {
            console.log("Notification sent successfully:", response);
          })
          .catch((error) => {
            console.error("Error sending notification:", error);
          });
    });
