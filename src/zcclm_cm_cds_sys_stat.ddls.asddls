@AbapCatalog.sqlViewName: 'ZCCLM_CM_SYS_SST'
@AbapCatalog.compiler.CompareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'ZCCLM CM Aggregated system statuses'
define view ZCCLM_CM_CDS_SYS_STAT as select from agsccl_system as sys
inner join ZCCLM_CM_CDS_SYS_COLL_STAT_KPI as coll
    on coll.SystemId = sys.system_id
inner join ZCCLM_CM_CDS_SYS_EXT_STAT_KPI as ext
    on ext.SystemId = coll.SystemId
//inner join notes status

//inner join bw status
{
  coll.SystemId as SystemId,
  sys.system_role,
  coll.Status as CollectorStatus,
  ext.Status as ExtractorStatus
} 