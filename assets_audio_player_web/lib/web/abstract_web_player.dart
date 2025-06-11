import 'dart:async';

import 'package:web/web.dart' as web;
import 'package:flutter/services.dart';

/// Web Player
abstract class WebPlayer {
  final MethodChannel channel;

  static const methodPosition = 'player.position';
  static const methodVolume = 'player.volume';
  static const methodPlaySpeed = 'player.playSpeed';
  static const methodFinished = 'player.finished';
  static const methodIsPlaying = 'player.isPlaying';
  static const methodIsBuffering = 'player.isBuffering';
  static const methodCurrent = 'player.current';
  static const methodForwardRewindSpeed = 'player.forwardRewind';

  WebPlayer({required this.channel});

  num get volume;

  set volume(num volume);

  num get playSpeed;

  set playSpeed(num playSpeed);

  bool get isPlaying;

  set isPlaying(bool value);

  num get currentPosition;

  void play();

  void pause();

  void stop();

  String findAssetPath(String path, String audioType, {String? package}) {
    if (audioType == 'network' ||
        audioType == 'liveStream' ||
        audioType == 'file') {
      return path;
    }
    // in web, assets are packaged in a /assets/ folder
    // if you want '/asset/3' as described in pubspec
    // it will be in /assets/asset/3

    /* for release mode, need to change the 'url', remove the /#/ and add /asset before */
    if (path.startsWith('/')) {
      path = path.replaceFirst('/', '');
    }
    if (package != null) {
      path = 'packages/$package/$path';
    }

    path = ('${web.window.location.href.replaceAll('/#/', '')}/assets/$path');
    return path;
  }

  Future<void> open({
    required String path,
    required String audioType,
    bool autoStart = false,
    double volume = 1,
    double? seek,
    double? playSpeed,
    Map? networkHeaders,
    String? package,
  });

  void seek({double to});

  void forwardRewind(double speed);

  void loopSingleAudio(bool loop);
}
