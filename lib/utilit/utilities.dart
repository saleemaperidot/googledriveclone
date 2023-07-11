import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle textStyle(double fz, Color color, FontWeight fw) {
  return GoogleFonts.montserrat(
    fontSize: fz,
    color: color,
    fontWeight: fw,
  );
}

//FirebaseFirestore firestore = FirebaseFirestore.instance;
CollectionReference<Map<String, dynamic>> firebasecollection =
    FirebaseFirestore.instance.collection('users');
