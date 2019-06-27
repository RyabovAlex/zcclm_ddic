@AbapCatalog.sqlViewName: 'ZCCLM_CM_SYS_CSR'
@AbapCatalog.compiler.CompareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'ZCCLM CM Aggregated system status for collectors'
define view ZCCLM_CM_CDS_SYS_COLL_STAT_RED as select from ZCCLM_CM_CDS_SYS_COLL_STATUS {
    SystemId,
    case when BestPractice = 0  then CollectorStatus
         when BestPractice = 1  then 0
         else BestPractice 
    end as Status
}