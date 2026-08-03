enum ListingStatus {
  available,
  reserved,
  sold;

  String get label {
    switch (this) {
      case ListingStatus.available:
        return 'Available';
      case ListingStatus.reserved:
        return 'Reserved';
      case ListingStatus.sold:
        return 'Sold';
    }
  }
}
