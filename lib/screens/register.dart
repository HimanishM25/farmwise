import 'dart:io';

import 'package:farmwise/screens/detailsPage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:intl/intl.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String farmerName = 'Not Mentioned';
  String address = 'Not Mentioned';
  DateTime dob = DateTime.now();
  String gender = 'Not Mentioned';
  double farmLandArea = 0.0;
  String locationCoordinates ='';
  File? image1;
  File? image2;
  File? video1;
  bool isPicked = false;
    

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: const Text(
                  'Register',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                  ),
                ),
            ),
            body: SingleChildScrollView(
                child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                        children: [
                            const Text(
                              'Please enter your details',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
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
                            Row(
                              children: [
                                

                                // ...

                                Text(
                                  'Date of Birth:',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(width: 16.0),
                                ElevatedButton(
                                    // ignore: unnecessary_null_comparison
                                    child: Text ('Select DOB'),
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
                              ],
                            ),
                            SizedBox(height: 16.0),
                            Text('Your birthdate is ${DateFormat('dd/MM/yyyy').format(dob)}'),
                            DropdownButtonFormField<String>(
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
                                labelText: 'Acres of Land (under 100)',
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
                            

                            Row(
                              children: [
                                Text(
                                  'Current Location:',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(width: 16.0),
                                ElevatedButton(
                                  child: const Text('Get Location'),
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
                                    
                                  },
                                ),
                              ],
                            ),
                            
                            SizedBox(height: 16.0),
                            Center(
                              child: Text('Your coordinates are $locationCoordinates'),
                            ),
                            SizedBox(height: 16.0),
                            Text(
                              'Please upload 2 images and 1 video of your farm',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(height: 16.0),
                            Row(
                              children: [
                                ElevatedButton(
                                    child: const Text('Upload 1st Image'),
                                    onPressed: () async {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text('Upload Image'),
                                            content: SingleChildScrollView(
                                              child: ListBody(
                                                children: <Widget>[
                                                  ElevatedButton(
                                                    child: Text('Upload from Gallery'),
                                                    onPressed: () async {
                                                      final ImagePicker picker = ImagePicker();
                                                      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
                                                      if (image != null) {
                                                        image1 = File(image.path);
                                                        setState(() {
                                                          isPicked = true;
                                                        });
                                                      }
                                                      Navigator.of(context).pop();
                                                    },
                                                  ),
                                                  SizedBox(height: 16.0),
                                                  ElevatedButton(
                                                    child: Text('Take a Picture'),
                                                    onPressed: () async {
                                                      final ImagePicker picker = ImagePicker();
                                                      final XFile? image = await picker.pickImage(source: ImageSource.camera);
                                                      if (image != null) {
                                                        image1 = File(image.path);
                                                        setState(() {
                                                          isPicked = true;
                                                        });
                                                      }
                                                      Navigator.of(context).pop();
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },

                                ),
                                SizedBox(width: 16.0),
                                 ElevatedButton(
                                    child: const Text('Upload 2nd Image'),
                                    onPressed: () async {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text('Upload Image'),
                                            content: SingleChildScrollView(
                                              child: ListBody(
                                                children: <Widget>[
                                                  ElevatedButton(
                                                    child: Text('Upload from Gallery'),
                                                    onPressed: () async {
                                                      final ImagePicker picker = ImagePicker();
                                                      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
                                                      if (image != null) {
                                                        image2 = File(image.path);
                                                        setState(() {
                                                          isPicked = true;
                                                        });
                                                      }
                                                      Navigator.of(context).pop();
                                                    },
                                                  ),
                                                  SizedBox(height: 16.0),
                                                  ElevatedButton(
                                                    child: Text('Take a Picture'),
                                                    onPressed: () async {
                                                      final ImagePicker picker = ImagePicker();
                                                      final XFile? image = await picker.pickImage(source: ImageSource.camera);
                                                      if (image != null) {
                                                        image2 = File(image.path);
                                                        setState(() {
                                                          isPicked = true;
                                                        });
                                                      }
                                                      Navigator.of(context).pop();
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },

                                ),
                              ],
                            ),
                            SizedBox(height: 16.0),
                             ElevatedButton(
                                    child: const Text('Upload video'),
                                    onPressed: () async {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: Text('Upload Video'),
                                            content: SingleChildScrollView(
                                              child: ListBody(
                                                children: <Widget>[
                                                  ElevatedButton(
                                                    child: Text('Upload from Gallery'),
                                                    onPressed: () async {
                                                      final ImagePicker picker = ImagePicker();
                                                      final XFile? video = await picker.pickImage(source: ImageSource.gallery);
                                                      if (video != null) {
                                                        video1 = File(video.path);
                                                        setState(() {
                                                          isPicked = true;
                                                        });
                                                      }
                                                      Navigator.of(context).pop();
                                                    },
                                                  ),
                                                  SizedBox(height: 16.0),
                                                  ElevatedButton(
                                                    child: Text('Take a video'),
                                                    onPressed: () async {
                                                      final ImagePicker picker = ImagePicker();
                                                      final XFile? video = await picker.pickVideo(source: ImageSource.camera);
                                                      if (video != null) {
                                                        video1 = File(video.path);
                                                        setState(() {
                                                          isPicked = true;
                                                        });
                                                      }
                                                      Navigator.of(context).pop();
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },

                                ),
                            SizedBox(height: 16.0),
                            ElevatedButton(
                                child: const Text('Submit'),
                                onPressed: () {
                                    // TODO: Perform form submission
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => DetailsPage(
                                        farmerName: farmerName,
                                        address: address,
                                        dob: dob,
                                        gender: gender,
                                        farmLandArea: farmLandArea,
                                        locationCoordinates: locationCoordinates,
                                        image1: image1,
                                        image2: image2,
                                        video1: video1,
                                        )),
                                    );
                                },
                            ),
                        ],
                    ),
                ),
            ),
        );
    }
}
