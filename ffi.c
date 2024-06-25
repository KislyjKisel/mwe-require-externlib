#include <lean/lean.h>

extern lean_external_class* b_class;

LEAN_EXPORT lean_obj_res make_b_object(lean_obj_arg io_) {
  return lean_io_result_mk_ok(lean_alloc_external(b_class, NULL));
}
