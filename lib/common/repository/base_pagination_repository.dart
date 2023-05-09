import '../model/cursor_pagination_model.dart';
import '../model/pagination_params.dart';

abstract class IBasePaginationRepository<T> {
  Future<CursorPagination<T>> pagenate({
    PaginationParams? paginationParams = const PaginationParams(),
  });
}
