import Lake
open Lake DSL

require b from git "../b"

package «a» where

lean_lib «A» where

@[default_target]
lean_exe «a» where
  root := `Main

target ffi.o pkg : FilePath := do
  let oFile := pkg.buildDir / "c" / "ffi.o"
  let srcJob <- inputFile <| pkg.dir / "ffi.c"
  let weakArgs := #["-I", (<- getLeanIncludeDir).toString]
  buildO oFile srcJob weakArgs #["-fPIC"] "cc" getLeanTrace

extern_lib libleanffia pkg := do
  let ffiO <- ffi.o.fetch
  let name := nameToStaticLib "leanffia"
  buildStaticLib (pkg.nativeLibDir / name) #[ffiO]
