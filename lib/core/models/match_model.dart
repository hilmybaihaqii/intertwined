// match_model.dart
class MatchUser {
  final String name;
  final String imageUrl;
  final String lastMessage;
  final String time;

  MatchUser({
    required this.name,
    required this.imageUrl,
    required this.lastMessage,
    required this.time,
  });
}

// Data Dummy 2 Orang
List<MatchUser> dummyMatches = [
  MatchUser(
    name: "Alya Putri",
    imageUrl: "https://i.pravatar.cc/150?img=5", // Placeholder image
    lastMessage: "Halo, salam kenal ya! 👋",
    time: "10:30",
  ),
  MatchUser(
    name: "Rizky Ramadhan",
    imageUrl: "https://i.pravatar.cc/150?img=11", // Placeholder image
    lastMessage: "Boleh minta IG nya?",
    time: "09:15",
  ),
];