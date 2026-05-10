import 'package:vibration/vibration.dart';
import 'package:vibration/vibration_presets.dart';

class VibrationProviderCustom {
  static void vibrate() async {
    if (await Vibration.hasVibrator()) {
      Vibration.vibrate(duration: 50);
    }
  }

  static void vibrateNotify() async {
    if (await Vibration.hasVibrator()) {
      Vibration.vibrate(preset: VibrationPreset.dramaticNotification);
    }
  }
}
