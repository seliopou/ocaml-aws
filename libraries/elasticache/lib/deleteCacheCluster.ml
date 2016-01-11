open Types
open Aws
type input = DeleteCacheClusterMessage.t
type output = DeleteCacheClusterResult.t
type error = Errors.t
let service = "elasticache"
let to_http req =
  let uri =
    Uri.add_query_params (Uri.of_string "https://elasticache.amazonaws.com")
      (List.append
         [("Version", ["2015-02-02"]); ("Action", ["DeleteCacheCluster"])]
         (Util.drop_empty
            (Uri.query_of_encoded
               (Query.render (DeleteCacheClusterMessage.to_query req))))) in
  (`POST, uri, [])
let of_http body =
  try
    let xml = Ezxmlm.from_string body in
    let resp =
      Util.option_bind (Xml.member "DeleteCacheClusterResponse" (snd xml))
        (Xml.member "DeleteCacheClusterResult") in
    try
      Util.or_error (Util.option_bind resp DeleteCacheClusterResult.parse)
        (let open Error in
           BadResponse
             {
               body;
               message =
                 "Could not find well formed DeleteCacheClusterResult."
             })
    with
    | Xml.RequiredFieldMissing msg ->
        let open Error in
          `Error
            (BadResponse
               {
                 body;
                 message =
                   ("Error parsing DeleteCacheClusterResult - missing field in body or children: "
                      ^ msg)
               })
  with
  | Failure msg ->
      `Error
        (let open Error in
           BadResponse { body; message = ("Error parsing xml: " ^ msg) })
let parse_error code err =
  let errors =
    [Errors.InvalidParameterCombination;
    Errors.InvalidParameterValue;
    Errors.SnapshotQuotaExceededFault;
    Errors.SnapshotFeatureNotSupportedFault;
    Errors.SnapshotAlreadyExistsFault;
    Errors.InvalidCacheClusterState;
    Errors.CacheClusterNotFound] @ Errors.common in
  match Errors.of_string err with
  | Some var ->
      if
        (List.mem var errors) &&
          ((match Errors.to_http_code var with
            | Some var -> var = code
            | None  -> true))
      then Some var
      else None
  | None  -> None