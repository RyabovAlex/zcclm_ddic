@AbapCatalog.sqlViewName: 'ZCCLM_CM_SYS_KCS'
@AbapCatalog.compiler.CompareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'ZCCLM CM KPI system status for collectors'
define view ZCCLM_CM_CDS_SYS_COLL_STAT_KPI as select from ZCCLM_CM_CDS_SYS_COLL_STAT_RED {
    SystemId,
    max(Status) as Status 
} group by SystemId