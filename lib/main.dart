import 'dart:io' show Platform; // Importing the Platform class to check the current platform (desktop, web, mobile)
import 'package:flutter/foundation.dart' show kIsWeb; // kIsWeb is used to check if the app is running in a web environment
import 'package:flutter/material.dart'; // Importing Flutter's Material library for UI components
import 'package:provider/provider.dart'; // Importing the Provider package for state management

// Commented out the import for window_size package since it's not needed for non-desktop platforms
// import 'package:window_size/window_size.dart'; // This package is used to manipulate window size on desktop platforms

void main() {
  // Ensures that Flutter has fully initialized before running the app. This is necessary for some setup operations.
  WidgetsFlutterBinding.ensureInitialized(); 

  // Check if the app is running on a desktop platform (Windows, Linux, macOS)
  if (!kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
    // setupWindow(); // Commented out: This function would be used to configure the window size on desktop platforms
  }

  // Run the app and use ChangeNotifierProvider to provide AgeCounter to the entire app.
  runApp(
    ChangeNotifierProvider(
      create: (context) => AgeCounter(), // Creates an instance of AgeCounter and provides it to the app
      child: const MyApp(), // MyApp is the root widget of the app
    ),
  );
}

// Commented out: This function would handle window configuration on desktop platforms
// void setupWindow() {
//   setWindowTitle('Age Counter'); // Sets the window title
//   setWindowMinSize(const Size(360, 640)); // Sets the minimum window size to 360x640 pixels
//   setWindowMaxSize(const Size(360, 640)); // Sets the maximum window size to 360x640 pixels
//   getCurrentScreen().then((screen) {
//     setWindowFrame(Rect.fromCenter(
//       center: screen!.frame.center,
//       width: 360,
//       height: 640,
//     )); // Centers the window on the screen
//   });
// }

// AgeCounter class that extends ChangeNotifier to manage state
// This class holds the current age and provides methods to increment and decrement it.
class AgeCounter with ChangeNotifier {
  int age = 7; // Initial age is set to 7

  // Method to increment the age
  void incrementAge() {
    age += 1; // Increases the age by 1
    notifyListeners(); // Notifies all widgets listening to this model about the change in state
  }

  // Method to decrement the age
  void decrementAge() {
    if (age > 0) { // Ensures that age does not go below 0
      age -= 1; // Decreases the age by 1
      notifyListeners(); // Notifies all widgets listening to this model about the change in state
    }
  }
}

// MyApp is the root widget of the application
class MyApp extends StatelessWidget {
  const MyApp({super.key}); // Default constructor

  @override
  Widget build(BuildContext context) {
    // Returns the MaterialApp widget which sets up the app's theme and routes
    return MaterialApp(
      title: 'Age Counter', // The title of the app, displayed in the task switcher
      theme: ThemeData(
        primarySwatch: Colors.blue, // The app's theme color
      ),
      home: const MyHomePage(), // The default route of the app, which points to MyHomePage
    );
  }
}

// MyHomePage is the main screen of the app where the age counter is displayed
class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key}); // Default constructor

  @override
  Widget build(BuildContext context) {
    // Scaffold provides the basic structure for the app screen, including an app bar and body
    return Scaffold(
      appBar: AppBar(
        title: const Text('Age Counter'), // AppBar title displayed at the top of the screen
      ),
      body: Center(
        // Center widget to center its child widgets vertically and horizontally
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Vertically centers the children in the column
          children: [
            // Consumer widget listens to changes in the AgeCounter model and rebuilds when the model changes
            Consumer<AgeCounter>(
              builder: (context, ageCounter, child) => Text(
                'I am ${ageCounter.age} years old', // Display the current age using the ageCounter model
                style: const TextStyle(
                  fontSize: 32, // Sets the font size to 32 for emphasis
                  fontWeight: FontWeight.bold, // Makes the text bold
                ),
              ),
            ),
            const SizedBox(height: 20), // Adds a space of 20 pixels between the text and the buttons
            // Button to increase the age
            ElevatedButton(
              onPressed: () {
                var ageCounter = context.read<AgeCounter>(); // Accesses the AgeCounter model
                ageCounter.incrementAge(); // Calls the incrementAge method to increase the age
              },
              child: const Text('Increase Age'), // Text displayed on the button
            ),
            const SizedBox(height: 10), // Adds a space of 10 pixels between the two buttons
            // Button to decrease the age
            ElevatedButton(
              onPressed: () {
                var ageCounter = context.read<AgeCounter>(); // Accesses the AgeCounter model
                ageCounter.decrementAge(); // Calls the decrementAge method to decrease the age
              },
              child: const Text('Reduce Age'), // Text displayed on the button
            ),
          ],
        ),
      ),
    );
  }
}
