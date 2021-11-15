import 'package:spotify_ui/src/business_logic/models/song.dart';
import 'package:spotify_ui/src/data/providers/song_provider.dart';

class SongRepository {
  final SongProvider songProvider = SongProvider();

  Future<List<Song>> getAllSongs() async {
    final List<Song> songs = await songProvider.readSongs();

    return songs;
  }
}