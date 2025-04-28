import Lake
open Lake DSL

require b from git "https://github.com/KislyjKisel/mwe-require-externlib2" @ "6e098b4"

package «a» where

lean_lib «A» where

@[default_target]
lean_exe «a» where
  root := `Main

input_file ffi_static.c where
  path := "ffi.c"
  text := true

target ffi.o pkg : System.FilePath := do
  let srcJob ← ffi_static.c.fetch
  let oFile := pkg.buildDir / "c" / "ffi_static.o"
  let weakArgs := #["-I", (<- getLeanIncludeDir).toString]
  buildO oFile srcJob weakArgs #["-fPIC"] "cc"

extern_lib libleanffia pkg := do
  let ffiO <- ffi.o.fetch
  let name := nameToStaticLib "leanffia"
  buildStaticLib (pkg.staticLibDir / name) #[ffiO]
