open Types
type input = DescribeCacheSecurityGroupsMessage.t
type output = CacheSecurityGroupMessage.t
type error = Errors.t
include
  (Aws.Call with type  input :=  input and type  output :=  output and type
     error :=  error)