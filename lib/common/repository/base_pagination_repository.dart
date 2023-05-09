import 'package:codfac/common/model/model_with_id.dart';

import '../model/cursor_pagination_model.dart';
import '../model/pagination_params.dart';

abstract class IBasePaginationRepository<T extends IModelWithId> {
  Future<CursorPagination<T>> pagenate({
    PaginationParams? paginationParams = const PaginationParams(),
  });
}
