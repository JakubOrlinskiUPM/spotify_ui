import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import 'package:audioplayers/audioplayers.dart';
import 'package:path_provider/path_provider.dart';
import 'package:spotify_ui/src/business_logic/models/playlist.dart';
import 'package:spotify_ui/src/business_logic/models/song.dart';

class CustomAudioCache {
  late String songPath;
  late String tempPath;
  late Map<String, String> cache;

  final int CACHE_EXTENT = 2;

  CustomAudioCache() {
    getApplicationDocumentsDirectory().then((directory) {
      songPath = directory.path;
    });

    getTemporaryDirectory().then((directory) {
      tempPath = directory.path;
    });

    cache = {};
  }

  setSongHandler(int currentIndex, Playlist playlist) {
    Song song = playlist.songs[currentIndex];
    if (cache.containsKey(song.storageUrl)) {
      return;
    }
    List<Song> songsToCache =
        playlist.songs.sublist(currentIndex, currentIndex + CACHE_EXTENT);

    songsToCache.forEach((Song song) async {
      String tmpFilePath = '${tempPath}/${song.id}.mp3';
      String persistentFilePath = '${songPath}/${song.id}.mp3';

      if (File(tmpFilePath).existsSync()) {
        cache[song.storageUrl] = tmpFilePath;
        return;
      }
      if (File(persistentFilePath).existsSync()) {
        cache[song.storageUrl] = persistentFilePath;
        return;
      }

      fetchSong(song, tmpFilePath);
    });
  }

  fetchSong(Song song, String filePath) async {
    final http.Response responseData =
        await http.get(Uri.parse(song.storageUrl));

    if (!kIsWeb) {
      var uint8list = responseData.bodyBytes;
      var buffer = uint8list.buffer;
      ByteData byteData = ByteData.view(buffer);
      File file = await File(filePath).writeAsBytes(
          buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

      cache[song.storageUrl] = file.path;
    }
  }


  Source getSongSource(String url) {
    if (cache.containsKey(url) && File(cache[url]!).existsSync()) {
      return DeviceFileSource(cache[url]!);
    } else {
      return UrlSource(url);
    }
  }

  saveSongToDisc(Song song) {
    String persistentFilePath = '${songPath}/${song.id}.mp3';
    fetchSong(song, persistentFilePath);
  }
}
