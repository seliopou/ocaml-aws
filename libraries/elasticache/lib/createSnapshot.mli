open Types
type input = CreateSnapshotMessage.t
type output = CreateSnapshotResult.t
type error = Errors.t
include
  (Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error)