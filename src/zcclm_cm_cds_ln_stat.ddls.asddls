@AbapCatalog.sqlViewName: 'ZCCLM_CM_LN_LST'
@AbapCatalog.compiler.CompareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'ZCCLM CM Aggregated landscape statuses'
define view ZCCLM_CM_CDS_LN_STAT as select from ZCCLM_CM_CDS_SYS_STAT as sysstat
inner join zagsccl_ltos as ltos
    on sysstat.SystemId = ltos.sys_id  {
   ltos.lnscp_id as LandscapeId,
   max(sysstat.CollectorStatus) as CollectorStatus,
   max(sysstat.ExtractorStatus) as ExtractorStatus  
} group by ltos.lnscp_id