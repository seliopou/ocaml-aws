open Types
type input = CreateVolumeRequest.t
type output = Volume.t
type error = Errors.t
include
  (Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error)