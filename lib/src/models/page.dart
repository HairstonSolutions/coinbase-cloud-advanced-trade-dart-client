/// A generic model representing a single page of paginated results.
class Page<T> {
  /// The list of items on the current page.
  final List<T> items;

  /// The cursor to the next page of results, if any.
  final String? nextCursor;

  /// Whether there are more pages of results.
  final bool hasNext;

  /// Page constructor
  Page({
    required this.items,
    this.nextCursor,
    this.hasNext = false,
  });

  @override
  String toString() {
    return 'Page{items=$items, nextCursor=$nextCursor, hasNext=$hasNext}';
  }
}
