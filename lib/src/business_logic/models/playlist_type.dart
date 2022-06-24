
enum PlaylistType { album, userPlaylist, single, podcast, artistPlaylist }

extension PlaylistTypeExtension on PlaylistType {
  String get string {
    switch (this) {
      case PlaylistType.album:
        return "Album";
      case PlaylistType.userPlaylist:
        return "Playlist";
      case PlaylistType.single:
        return "EP";
      case PlaylistType.podcast:
        return "Podcast";
      case PlaylistType.artistPlaylist:
        return "Artist Playlist";
      default:
        return "";
    }
  }

  String get header {
    switch (this) {
      case PlaylistType.album:
        return "album";
      case PlaylistType.userPlaylist:
        return "playlist";
      case PlaylistType.single:
        return "EP";
      case PlaylistType.podcast:
        return "podcast";
      case PlaylistType.artistPlaylist:
        return "artist";
      default:
        return "";
    }
  }

  int get integer {
    switch (this) {
      case PlaylistType.album:
        return 0;
      case PlaylistType.userPlaylist:
        return 1;
      case PlaylistType.single:
        return 2;
      case PlaylistType.podcast:
        return 3;
      case PlaylistType.artistPlaylist:
        return 4;
      default:
        return -1;
    }
  }


}