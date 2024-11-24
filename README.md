<h1>Event Management App</h1>

<h2>Overview</h2>
<p>This is a fully functional, multi-feature Flutter application designed for managing events. The app supports both iOS and Android platforms and integrates Firebase Authentication, event management features, live updates through WebSockets, and notifications. It also includes a custom UI with light and dark themes, adaptive layouts, and reusable components for a seamless user experience.</p>

<h3>Key Features:</h3>
<ul>
  <li><strong>User Authentication</strong>: Firebase authentication (email/password and Google sign-in).</li>
  <li><strong>Event Management</strong>: Create, edit, delete events with recurring event support.</li>
  <li><strong>Notifications</strong>: Reminders for upcoming events and push notifications for real-time updates.</li>
  <li><strong>Custom UI</strong>: Light/Dark themes, adaptive layout, reusable UI components.</li>
</ul>

<h2>Requirements</h2>
<ul>
  <li>Flutter 3.24.5 (or higher)</li>
  <li>Firebase project for authentication</li>
  <li>Flutter Local Notifications package</li>
</ul>

<h2>Installation</h2>

<h3>1. Clone the Repository</h3>
<pre><code>git clone https://github.com/ronak3250/event-management-app.git
cd event-management-app</code></pre>

<h3>2. Install Dependencies</h3>
<p>Run the following command to install the required dependencies:</p>
<pre><code>flutter pub get</code></pre>

<h3>3. Firebase Setup</h3>
<ol>
  <li>Create a Firebase project at <a href="https://console.firebase.google.com/" target="_blank">Firebase Console</a>.</li>
  <li>Set up Firebase Authentication for email/password and Google sign-in.</li>
  <li>Add your Android and iOS apps to Firebase and download the configuration files:
    <ul>
      <li><strong>Android</strong>: <code>google-services.json</code></li>
      <li><strong>iOS</strong>: <code>GoogleService-Info.plist</code></li>
    </ul>
  </li>
  <li>Place the configuration files in the following directories:
    <ul>
      <li><code>android/app/google-services.json</code></li>
      <li><code>ios/Runner/GoogleService-Info.plist</code></li>
    </ul>
  </li>
</ol>

<h3>4. Platform-specific Configuration</h3>

<h4>Android Setup</h4>
<ol>
  <li>Add Firebase services to your project by updating <code>android/build.gradle</code>:
    <pre><code>classpath 'com.google.gms:google-services:4.3.15'</code></pre>
  </li>
  <li>Apply the plugin in <code>android/app/build.gradle</code>:
    <pre><code>apply plugin: 'com.google.gms.google-services'</code></pre>
  </li>
</ol>

<h4>iOS Setup</h4>
<ol>
  <li>Open <code>ios/Runner.xcworkspace</code> in Xcode.</li>
  <li>Set the iOS deployment target to 11.0 or higher.</li>
  <li>Ensure the <code>GoogleService-Info.plist</code> file is included and properly configured.</li>
</ol>

<h3>5. Run the App</h3>
<p>Run the app on an emulator or physical device:</p>
<pre><code>flutter run</code></pre>



<h2>Code Structure</h2>
<ul>
  <li><strong>lib/</strong>: Main application code.
    <ul>
      <li><strong>controller/</strong>: Contains the business logic and state management.</li>
      <li><strong>models/</strong>: Data models for events, users, and other entities.</li>
      <li><strong>utils/</strong>: Utility functions, including:
        <ul>
          <li><strong>widgets/</strong>: Custom reusable widgets used across the app.</li>
          <li><code>theme.dart</code>: Theme configuration for the app, including light and dark modes.</li>
        </ul>
      </li>
      <li><strong>view/</strong>: Contains UI screens and the overall layout of the app.</li>
    </ul>
  </li>
  <li><strong>assets/</strong>: Images and static assets.</li>
  <li><strong>android/</strong>: Android-specific configuration.</li>
  <li><strong>ios/</strong>: iOS-specific configuration.</li>
</ul>

<h2>Contributing</h2>
<ol>
  <li>Fork the repository and create a new branch.</li>
  <li>Make sure your code follows Flutter best practices.</li>
  <li>Include unit tests where applicable.</li>
  <li>Submit a pull request when your feature or fix is ready.</li>
</ol>

<h2>Demo Video</h2>
<p>A demo video demonstrating the app functionality is available in the repository.</p>

<h2>License</h2>
<p>This project is licensed under the MIT License. See the <a href="LICENSE" target="_blank">LICENSE</a> file for details.</p>

