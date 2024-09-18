import 'package:chatjob/Hive/localdata.dart';
import 'package:chatjob/helpers/router.dart';
import 'package:chatjob/screens/groupchat/chatscreen.dart';
import 'package:chatjob/screens/groupchat/comments.dart';
import 'package:chatjob/screens/mainscreen.dart';
import 'package:chatjob/screens/settings/settings.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

Future<String?> getDeviceToken() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  try {
    // Request permission for receiving push notifications (optional)
    NotificationSettings settings = await messaging.requestPermission(
        alert: true, badge: true, sound: true);

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      // Get the device token
      String? token = await messaging.getToken();
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        print(message.notification!.body);
      });
      FirebaseMessaging.onMessageOpenedApp.listen((event) {
        print(event.data);
      });
      return token;
    }
  } catch (e) {
    print('Error getting device token: $e');
  }
  return null;
}

//  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {

// });
class NotificationHandler {
  static void init() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("onMessage: $message");
      // Handle notification when app is in foreground
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('====FirebaseMessaging.onMessageOpenedApp===');
      print("message.data.isEmpty: ${message.data.isEmpty}");
      print("message.data.length: ${message.data.length}");
      print("message.data.type: ${message.data['recordType']}");
      print("message.data.id: ${message.data['recordId']}");
      for (var x in message.data.entries) {
        print('x.toString()$x');
        print('x.key.toString()${x.key}');
        print('x.value.toString()${x.value}');
      }

      // Handle notification when app is in background or terminated
      // Navigate to specific page
      // InChatScreen(
      // admin: loginbox!.get('Admin'),
      // id: message.data['recordId'],
      // name: 'name',
      // imageurl: 'imageurl',
      // saveimages: true)
      MagicRouter.navigateTo(message.data['recordType'] == 'group'
          ? InChatScreen(
              admin: loginbox!.get('Admin'),
              id: int.parse(message.data['recordId']),
              name: null,
              imageurl: null,
              saveimages: null)
          : CommentsScreen(
              groupid: int.parse(message.data['parentRecordId']),
              postid: int.parse(message.data['recordId']),
              admin: loginbox!.get('Admin'),
              save: null,
              gName: null,
              gImage: null));
    });
  }
}

Future<void> backgroundmessagehandel(RemoteMessage message) async {
  print('================================');
  print(message.data.entries);
  print(message.data.keys);
  print('================================');

  // loginbox!.put('message', message);
}

class FirebaseMessagingService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> setupFirebase(BuildContext context) async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('Firebase messaging has been granted permission.');
    }

    // ignore: use_build_context_synchronously
    NotificationHandler.init();
  }
}
