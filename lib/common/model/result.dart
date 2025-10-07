import 'package:pei_yee_session/common/model/error_entity.dart';

class Result<T> {
  final T? data;
  final ErrorEntity? error;

  const Result({this.data, this.error});

  @override
  String toString() {
    return "Result<$T>{ data: $data, error: $error }";
  }

  bool get isSuccess {
    if (error != null || data == null) return false;

    if (data is bool) {
      return data as bool; // Return the bool value directly
    }

    if (data is List) {
      return (data as List).isNotEmpty;
    }

    if (data is String) {
      return (data as String).isNotEmpty;
    }

    if (data is Map) {
      return (data as Map<String, dynamic>).values.every((value) {
        if (value == null) return false;
        if (value is List || value is String || value is Map) {
          return value.isNotEmpty;
        }
        return true; // For non-container values like int, bool, etc.
      });
    }

    return true; // For non-container types that are not null
  }
}

class PaginationResult<T> extends Result<T> {
  final int maxData;
  final int loadedData;
  final int? pageSize;

  const PaginationResult({
    required this.maxData,
    required this.loadedData,
    this.pageSize,
    super.data,
    super.error,
  });

  /// Checks if more data can be loaded
  bool get hasMoreData => loadedData < maxData;

  bool get isMax => !hasMoreData;

  /// Calculates the total number of pages
  int get totalPages => pageSize != null ? (maxData / pageSize!).ceil() : 1;

  /// Calculates the current page index (1-based)
  int get currentPage => pageSize != null ? (loadedData / pageSize!).ceil() : 1;

  /// Determines the number of remaining items to load
  int get remainingData => maxData - loadedData;

  @override
  String toString() {
    return "PaginationResult<$T>{ data: $data, maxData: $maxData, loadedData: $loadedData, error: $error }";
  }
}
