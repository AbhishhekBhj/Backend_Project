import 'package:audioplayers/audioplayers.dart';

class PlayNotificiationSound {
  final player = AudioPlayer();
  void playNotification() {
    player.play(AssetSource('assets/audio/chime.wav'));
  }
}
