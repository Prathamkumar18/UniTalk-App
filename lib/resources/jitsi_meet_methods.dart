import 'package:jitsi_meet/feature_flag/feature_flag.dart';
import 'package:jitsi_meet/jitsi_meet.dart';
import 'package:uni_talk/resources/auth_method.dart';
import 'package:uni_talk/resources/firestore_methods.dart';

class JitsiMeetMethods {
  final FirestoreMethods _firestoreMethods = FirestoreMethods();
  final AuthMethods _authMethods = AuthMethods();
  void createMeeting(
      {required String roomName,
      required bool isAudioMuted,
      required bool isVideoMuted,
      String username = ''}) async {
    try {
      FeatureFlag featureFlag = FeatureFlag();
      featureFlag.welcomePageEnabled = false;
      featureFlag.resolution = FeatureFlagVideoResolution.MD_RESOLUTION;
      String name;
      if (username.isEmpty) {
        name = _authMethods.user.displayName.toString();
      } else {
        name = username;
      }
      var options = JitsiMeetingOptions(room: roomName)
        ..userDisplayName = name
        ..userEmail = _authMethods.user.email
        ..userAvatarURL = _authMethods.user.photoURL
        ..audioMuted = isAudioMuted
        ..videoMuted = isVideoMuted;
      _firestoreMethods.addToMeetHistory(roomName);
      await JitsiMeet.joinMeeting(options, listener: JitsiMeetingListener());
    } catch (error) {
      print("error: $error");
    }
  }
}