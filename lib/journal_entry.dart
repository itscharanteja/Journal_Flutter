class JournalEntry {
  final String title;
  final List<String> imagePaths;
  final String content;
  final double? latitude;
  final double? longitude;
  final String? locationName;

  JournalEntry({
    required this.title,
    required this.imagePaths,
    required this.content,
    this.latitude,
    this.longitude,
    this.locationName,
  });

  Map<String, dynamic> toJson() => {
    'title': title,
    'content': content,
    'imagePaths': imagePaths,
    'latitude': latitude,
    'longitude': longitude,
    'locationName': locationName,
  };

  factory JournalEntry.fromJson(Map<String, dynamic> json) => JournalEntry(
    title: json['title'],
    content: json['content'],
    imagePaths: List<String>.from(json['imagePaths']),
    latitude: json['latitude'],
    longitude: json['longitude'],
    locationName: json['locationName'],
  );
}