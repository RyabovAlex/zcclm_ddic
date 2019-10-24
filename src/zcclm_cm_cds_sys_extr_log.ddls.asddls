@AbapCatalog.sqlViewName: 'ZCCLM_CM_SYS_CLG'
@AbapCatalog.compiler.CompareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'ZCCLM CM Extractor logs'
define view ZCCLM_CM_CDS_SYS_EXTR_LOG as select from e2e_active_wli as active
inner join e2e_efwk_log as log
    on active.wli_id = log.wli_id {   
    active.wli_id as wliId,
    active.sid as sysId,
    active.active as isActive,
    active.extractor as extractor,
    active.name,
    active.dtrun as delta,
    log.timestamp as time,
    log.phase as phase,
    log.message_type as logStatus,
    log.rc as returnCode,
    log.message as message,
    log.runtime as runtime,
    log.records as records
} where ( active.setup_type = 'CCM' or active.setup_type = 'ICIDB' or ( active.setup_type = 'E2EREP' and active.extractorclass = 'E2E_LUW_SECONDAR_EXTRACTOR_SSR'  ) ) and active.active = 'X'