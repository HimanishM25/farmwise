import 'package:flutter/material.dart';
import 'package:location/location.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String farmerName = '';
  String address = '';
  DateTime dob = DateTime.now();
  String gender = 'male';
  double farmLandArea = 0.0;
  String locationCoordinates = ''; // Added locationCoordinates variable
    

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: const Text('Register'),
            ),
            body: SingleChildScrollView(
                child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                        children: [
                            TextField(
                                decoration: const InputDecoration(
                                    labelText: 'Farmer Name',
                                ),
                                onChanged: (value) {
                                    setState(() {
                                        farmerName = value;
                                    });
                                },
                            ),
                            SizedBox(height: 16.0),
                            TextField(
                                decoration: const InputDecoration(
                                    labelText: 'Address',
                                ),
                                onChanged: (value) {
                                    setState(() {
                                        address = value;
                                    });
                                },
                                maxLines: null,
                            ),
                            SizedBox(height: 16.0),
                            ElevatedButton(
                                // ignore: unnecessary_null_comparison
                                child: Text(dob != null ? 'DOB: ${dob.toString()}' : 'Select DOB'),
                                onPressed: () async {
                                    final selectedDate = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(1900),
                                        lastDate: DateTime.now(),
                                    );
                                    if (selectedDate != null) {
                                        setState(() {
                                            dob = selectedDate;
                                        });
                                    }
                                },
                            ),
                            SizedBox(height: 16.0),
                            DropdownButtonFormField<String>(
                                //value: gender,
                                decoration: const InputDecoration(
                                    labelText: 'Gender',
                                ),
                                items: ['Male', 'Female', 'Other']
                                        .map((value) => DropdownMenuItem<String>(
                                                    value: value,
                                                    child: Text(value),
                                                ))
                                        .toList(),
                                onChanged: (value) {
                                    setState(() {
                                        gender = value!;
                                    });
                                },
                            ),
                            SizedBox(height: 16.0),
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Farm Land Area (in Acres)',
                              ),
                              keyboardType: TextInputType.number,
                              onChanged: (value) {
                                double? parsedValue = double.tryParse(value);
                                if (parsedValue != null && parsedValue <= 100) {
                                  setState(() {
                                    farmLandArea = parsedValue;
                                  });
                                }
                              },
                            ),
                            SizedBox(height: 16.0),
                            

                            ElevatedButton(
                              child: const Text('Get Current Location'),
                              onPressed: () async {
                                Location location = Location();
                                bool serviceEnabled;
                                PermissionStatus permissionGranted;

                                // Check if location services are enabled
                                serviceEnabled = await location.serviceEnabled();
                                if (!serviceEnabled) {
                                  serviceEnabled = await location.requestService();
                                  if (!serviceEnabled) {
                                    // Location services are not enabled, handle accordingly
                                    return;
                                  }
                                }

                                // Check if location permission is granted
                                permissionGranted = await location.hasPermission();
                                if (permissionGranted == PermissionStatus.denied) {
                                  permissionGranted = await location.requestPermission();
                                  if (permissionGranted != PermissionStatus.granted) {
                                    // Location permission not granted, handle accordingly
                                    return;
                                  }
                                }

                                // Get current location coordinates
                                LocationData? locationData = await location.getLocation();
                                double latitude = locationData.latitude!;
                                double longitude = locationData.longitude!;

                                // Update farmLandArea with coordinates
                                setState(() {
                                  locationCoordinates = '$latitude, $longitude';
                                });
                                print(locationCoordinates);
                              },
                            ),
                            SizedBox(height: 16.0),
                            ElevatedButton(
                                child: const Text('Capture Image 1'),
                                onPressed: () {
                                    // TODO: Capture image using camera app and set image1
                                },
                            ),
                            SizedBox(height: 16.0),
                            ElevatedButton(
                                child: const Text('Capture Image 2'),
                                onPressed: () {
                                    // TODO: Capture image using camera app and set image2
                                },
                            ),
                            SizedBox(height: 16.0),
                            ElevatedButton(
                                child: const Text('Capture Video'),
                                onPressed: () {
                                    // TODO: Capture video using camera app and set video
                                },
                            ),
                            SizedBox(height: 16.0),
                            ElevatedButton(
                                child: const Text('Submit'),
                                onPressed: () {
                                    // TODO: Perform form submission
                                },
                            ),
                        ],
                    ),
                ),
            ),
        );
    }
}
