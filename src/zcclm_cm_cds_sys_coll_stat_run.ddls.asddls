@AbapCatalog.sqlViewName: 'ZCCLM_CM_SYS_CRS'
@AbapCatalog.compiler.CompareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'ZCCLM CM Collectors run for system'
define view ZCCLM_CM_CDS_SYS_COLL_STAT_RUN as select from agsccl_coll_run as run
inner join agsccl_coll_def as def
on def.collector_id = run.collector_id {
    run.collector_id as CollectorId,
    def.name as Name,
    system_id as SystemId,
    time_start as TimeStart,
    time_end as TimeEnd,
    status as Status,
    progress as Progress,
    jobname as JobName    
}