import 'package:spotify_ui/src/business_logic/models/author_stub.dart';
import 'package:spotify_ui/src/business_logic/models/playlist.dart';

Playlist yachtWorld = Playlist(
  id: 'Pwsj8yWWxLMSiy0bvXiW',
  imageUrl:
      'https://firebasestorage.googleapis.com/v0/b/spotifyui-bfaba.appspot.com/o/images%2Fengelwood-yacht.jpeg?alt=media&token=2d09e554-7ddb-4219-8cb4-df27a657b121',
  imagePath: '/images/engelwood-yacht.jpeg',
  name: 'Yacht World',
  releaseYear: 2020,
  playlistType: PlaylistType.album,
  songIds: [
    "zXsvITgeHBuhlcp6P55u",
    "ESWAdplhteEoeeQZ3cP9",
  ],
  authors: const [
    AuthorStub(
      id: "meOehGHl0z6VzK6EtKyn",
      name: "Engelwood",
      imageUrl:
          "https://firebasestorage.googleapis.com/v0/b/spotifyui-bfaba.appspot.com/o/images%2Fengelwood.jpeg?alt=media&token=1021bf8a-881f-47b6-95e2-998e8f470570",
    ),
  ],
  colorHex: 4281314204,
);

Playlist theSwap = Playlist(
  id: 'ZfnXoGPtUNVy3fYhmpJV',
  imageUrl:
      'https://firebasestorage.googleapis.com/v0/b/spotifyui-bfaba.appspot.com/o/images%2Fmoose-dowa-the-swap.jpeg?alt=media&token=78967e10-62f9-4557-890e-6f937489f66f',
  imagePath: '/images/moose-dowa-the-swap.jpeg',
  name: 'The Swap',
  releaseYear: 2020,
  playlistType: PlaylistType.album,
  songIds: [
    "Vv0kUzqiPVAFuF7sLDBE",
  ],
  authors: const [
    AuthorStub(
      id: "j2ipLk5IQOshIGo805ZA",
      name: "Moose Dawa",
      imageUrl:
          "https://firebasestorage.googleapis.com/v0/b/spotifyui-bfaba.appspot.com/o/images%2Fmoose-dowa.jpeg?alt=media&token=0826467c-7c6b-4aed-a6b1-fb136173c68e",
    ),
  ],
  colorHex: 4293701725,
);

Playlist reign = Playlist(
  id: 'dutOpDGeTAjvMNUEbKvS',
  imageUrl:
      'https://firebasestorage.googleapis.com/v0/b/spotifyui-bfaba.appspot.com/o/images%2Fprinzhorn-reign.jpeg?alt=media&token=d195c732-d6c1-4ab4-bc70-46766a4a1284',
  imagePath: '/images/prinzhorn-reign.jpeg',
  name: 'Reign',
  releaseYear: 2015,
  playlistType: PlaylistType.album,
  songIds: [
    "ESWAdplhteEoeeQZ3cP9",
  ],
  authors: const [
    AuthorStub(
      id: "1VIY63seMYeiHSx3meqg",
      name: "Prinzhorn Dance School",
      imageUrl:
          "https://firebasestorage.googleapis.com/v0/b/spotifyui-bfaba.appspot.com/o/images%2Fprinzhorn-dance-school.jpeg?alt=media&token=af4704df-41bc-4e0e-8e28-eff45d876582",
    ),
  ],
  colorHex: 4290464071,
);

Playlist pureLuxury = Playlist(
  id: 'e5Jvp3NKRv9OsGBaFJ0j',
  imageUrl:
      'https://firebasestorage.googleapis.com/v0/b/spotifyui-bfaba.appspot.com/o/images%2Fnzca-lines-pure.jpeg?alt=media&token=3a72d6cf-b9ea-43d0-884c-f5fd3682c05b',
  imagePath: '/images/nzca-lines-pure.jpeg',
  name: 'Pure Luxury',
  releaseYear: 2017,
  playlistType: PlaylistType.album,
  songIds: [
    "ouL8bTPxxb2CoSm883Oc",
  ],
  authors: const [
    AuthorStub(
      id: "BpitYyswW1bMP4ELmoHi",
      name: "NZCA Lines",
      imageUrl:
          "https://firebasestorage.googleapis.com/v0/b/spotifyui-bfaba.appspot.com/o/images%2Fnzca-lines.jpeg?alt=media&token=4a140f4b-69f1-4e72-8ab9-4c25c3c9e124",
    ),
  ],
  colorHex: 4282485193,
);

Playlist intimateFunk = Playlist(
  id: 'h8HKQtNzedvQREOrq3UF',
  imageUrl:
      'https://firebasestorage.googleapis.com/v0/b/spotifyui-bfaba.appspot.com/o/images%2Fdabeull-intimate.jpg?alt=media&token=420bc609-f47f-43fb-a8da-0c888cda30a1',
  imagePath: '/images/dabeull-intimate.jpg',
  name: 'Intimate Funk',
  releaseYear: 2012,
  playlistType: PlaylistType.album,
  songIds: [
    "KHOAL2QBIEf8sguI16mC",
  ],
  authors: const [
    AuthorStub(
      id: "2TeNnASOnuMVsqMg4u0E",
      name: "Dabeull",
      imageUrl:
          "https://firebasestorage.googleapis.com/v0/b/spotifyui-bfaba.appspot.com/o/images%2Fdabeull.jpeg?alt=media&token=45a1d121-5d77-431b-91ac-d32936db6fe9",
    ),
  ],
  colorHex: 4290130731,
);

List<Playlist> albums = [
  yachtWorld,
  reign,
  pureLuxury,
  theSwap,
  intimateFunk
];
