import 'package:flutter_riverpod/legacy.dart';

/// Selected bottom-navigation tab index.
final selectedTabProvider = StateProvider<int>((ref) => 0);

/// Selected Home filter chip ids (visual only for this phase).
final selectedFiltersProvider = StateProvider<Set<String>>(
  (ref) => {'available'},
);
