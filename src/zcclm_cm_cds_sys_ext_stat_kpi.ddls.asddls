@AbapCatalog.sqlViewName: 'ZCCLM_CM_SYS_KES'
@AbapCatalog.compiler.CompareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'ZCCLM CM KPI system status for extractors'
define view ZCCLM_CM_CDS_SYS_EXT_STAT_KPI as select from ZCCLM_CM_CDS_SYS_EXT_STAT_RED {
    SystemId,
    max(Status) as Status 
} group by SystemId