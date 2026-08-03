class AppUser {
  const AppUser({
    required this.id,
    required this.name,
    required this.pickupArea,
    this.avatarUrl,
    this.rating = 4.8,
  });

  final String id;
  final String name;
  final String pickupArea;
  final String? avatarUrl;
  final double rating;
}
