open Types
type input = PutScalingPolicyType.t
type output = PolicyARNType.t
type error = Errors.t
include
  (Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error)