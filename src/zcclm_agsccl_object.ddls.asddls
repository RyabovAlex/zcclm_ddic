@AbapCatalog.sqlViewName: 'ZCCLM_CM_OBJ'
@AbapCatalog.compiler.CompareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'ZCCLM CM Obj table'
define view ZCCLM_AGSCCL_OBJECT as select from agsccl_object {
    system_id as SystemId,
    obj_type as ObjType,
    obj_name as ObjName,
    severity as Severity,
    saplifecyclestatus as LifecycleStatus,
    usageflag as UsageFlag,
    last_used as LastUsed,
    devclass as DevClass,    
    cast( 1 as abap.int4 ) as zcount
}