open Types
type input = TerminateInstancesRequest.t
type output = TerminateInstancesResult.t
type error = Errors.t
include
  (Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error)