import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth auth = FirebaseAuth.instance;
FirebaseFirestore fireStore = FirebaseFirestore.instance;

// ----- User -----

var userCollection = fireStore.collection('user');

// ----- Plans -----

var plansCollection = fireStore.collection('plans');

// ----- My Games -----

var myGamesCollection = fireStore.collection('myGames');
