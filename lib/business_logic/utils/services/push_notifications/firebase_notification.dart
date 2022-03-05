import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
   
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_core/firebase_core.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    // description
    importance: Importance.high,
    playSound: true);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A bg message just showed up :  ${message.messageId}');
}


 Future sendMessageUsingFcm({required String fcmToken,required String title,required message}) async {
   var func = FirebaseFunctions.instance.httpsCallable("notifySubscribers");
var res = await func.call(<String, dynamic>{
  "targetDevices": ["eq45nKAMQF6WvVrzsCDhBO:APA91bH3bjbe2_VQLK_g6QD9iSmMpOuAFOzWV2i7CKRn_oTkLt5dH2bnAHs9LCAuxwGd6m73wCi9gI6sCB0h9G7NTskBgR1BjZZHZm-0EBDNG1W-0J9VW1FxPT8gMo_crHNy0qHofDVb"],
  "messageTitle": "Test title",
  "messageBody": "hfsd",
});

print("message was ${res.data as bool ? "sent!" : "not sent!"}");
    print("message was ${res.data as bool ? "sent!" : "not sent!"}");
  }
