import 'package:spotify_ui/src/business_logic/models/author_stub.dart';
import 'package:spotify_ui/src/business_logic/models/playlist.dart';


Playlist myPlaylist = Playlist(
  id: 'v5LFk5fD15UCBRcIUCwv',
  imageUrl:
  'https://firebasestorage.googleapis.com/v0/b/spotifyui-bfaba.appspot.com/o/images%2Fv5LFk5fD15UCBRcIUCwv.jpeg?alt=media&token=92e5e96e-48a0-4804-ac49-27f6457f9954',
  imagePath: '/images/v5LFk5fD15UCBRcIUCwv.jpg',
  name: 'My Playlist',
  releaseYear: 2022,
  playlistType: PlaylistType.userPlaylist,
  songIds: [
    "KHOAL2QBIEf8sguI16mC",
    "zXsvITgeHBuhlcp6P55u",
    "ESWAdplhteEoeeQZ3cP9",
    "Vv0kUzqiPVAFuF7sLDBE",
    "ouL8bTPxxb2CoSm883Oc",
  ],
  authors: const [
    AuthorStub(
      id: "oRdyRNXgFXezoncEHVSGi6Gyzfw2",
      name: "Jakub Orliński",
      imageUrl:
      "https://firebasestorage.googleapis.com/v0/b/spotifyui-bfaba.appspot.com/o/images%2Fuser-placeholder.jpeg?alt=media&token=6068f4ca-51bc-4304-9064-e9988758f0f2",
    ),
  ],
  colorHex: 4293165188,
);

List<Playlist> playlists = [
  myPlaylist
];