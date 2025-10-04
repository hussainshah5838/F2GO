class FavouriteModel {
  final String image;
  final String title;
  final String location;
  final String dateTime;
  final String status;
  final List<String> avatars;

  FavouriteModel({
    required this.image,
    required this.title,
    required this.location,
    required this.dateTime,
    required this.status,
    required this.avatars,
  });
}
