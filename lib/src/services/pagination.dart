import 'package:coinbase_cloud_advanced_trade_client/src/models/page.dart';

/// Resolves the cursor an exhaustive list helper should request next, or null
/// when the helper should stop paginating.
///
/// The Coinbase Advanced Trade API documents `has_next` as the end-of-results
/// signal; the cursor is documented only as the value responses follow, with
/// no guarantee that it is empty on the final page. Deciding on the cursor
/// alone therefore risks an unbounded request loop, so this helper stops when:
///
/// * [requireHasNext] is true and the page's `has_next` is false,
/// * the next cursor is null or empty, or
/// * the next cursor repeats [currentCursor], which would replay the exact
///   request that produced [page].
///
/// [requireHasNext] should be false for endpoints that do not return
/// `has_next` - List Fills does not document it, and [Page.hasNext] defaults
/// to false there.
String? nextPageCursor<T>(
  Page<T> page,
  String? currentCursor, {
  bool requireHasNext = true,
}) {
  if (requireHasNext && !page.hasNext) {
    return null;
  }

  String? nextCursor = page.nextCursor;
  if (nextCursor == null || nextCursor.isEmpty) {
    return null;
  }
  if (nextCursor == currentCursor) {
    return null;
  }

  return nextCursor;
}
