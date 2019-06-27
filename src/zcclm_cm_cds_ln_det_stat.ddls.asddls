@AbapCatalog.sqlViewName: 'ZCCLM_CM_LN_LSD'
@AbapCatalog.compiler.CompareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'ZCCLM CM Detailed landscape statuses'
define view ZCCLM_CM_CDS_LN_DET_STAT as select from ZCCLM_CM_CDS_SYS_STAT as sysstat
inner join zagsccl_ltos as ltos
    on sysstat.SystemId = ltos.sys_id {
    ltos.lnscp_id as LandscapeId,
    ltos.sys_id as SystemId,
    sysstat.ExtractorStatus as ExtractorStatus,
    sysstat.CollectorStatus as CollectorStatus
}