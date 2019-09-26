@AbapCatalog.sqlViewName: 'ZCCLM_CM_SYS_ESR'
@AbapCatalog.compiler.CompareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'ZCCLM CM Reduced system status for extractors'
define view ZCCLM_CM_CDS_SYS_EXT_STAT_RED as select from ZCCLM_CM_CDS_SYS_EXT_STATUS {
    SystemId,
    case when BestPractice = 0  then ExtractorStatus
         when BestPractice = 1  then 1
         else BestPractice 
    end as Status
}