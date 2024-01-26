import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailsPage extends StatelessWidget {
  final String farmerName;
  final String address;
  final DateTime dob;
  final String gender;
  final double farmLandArea;
  final String locationCoordinates;
  final File? image1;
  final File? image2;
  final File? video1;

  DetailsPage( {
    required this.farmerName,
    required this.address,
    required this.dob,
    required this.gender,
    required this.farmLandArea,
    required this.locationCoordinates,
    this.image1,
    this.image2,
    this.video1,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Summary'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Please verify the details entered:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              'Farmer Name: $farmerName',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 16),
            Text(
              'Address: $address',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 16),
            Text(
              'Date of Birth:  ${DateFormat('dd/MM/yyyy').format(dob)}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 16),
            Text(
              'Gender: $gender',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 16),
            Text(
              'Farm Land Area: $farmLandArea',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 16),
            Text(
              'Location Coordinates: \n $locationCoordinates',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 16),
            if (image1 != null) Image.file(image1!),
            if (image2 != null) Image.file(image2!),
            if (video1 != null) Text('Video: $video1'),
          ],
        ),
      ),
    );
  }
}
