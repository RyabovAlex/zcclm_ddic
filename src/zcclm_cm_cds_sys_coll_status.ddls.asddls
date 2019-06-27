@AbapCatalog.sqlViewName: 'ZCCLM_CM_SYS_CST'
@AbapCatalog.compiler.CompareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'ZCCLM CM System status for collectors'
define view ZCCLM_CM_CDS_SYS_COLL_STATUS as select from ZAGSCCL_SYSTEM as sys
inner join zagsccl_srtc as srtc
    on srtc.system_role = sys.system_role
inner join agsccl_coll_stat as stat
    on stat.collector_id = srtc.collector_id and sys.system_id = stat.system_id
inner join agsccl_coll_def as def
    on def.collector_id = stat.collector_id 
inner join agsccl_coll_sys as coll_sys
    on coll_sys.collector_id = stat.collector_id and sys.system_id = coll_sys.system_id    
 {
    sys.system_id as SystemId,
    sys.system_role as SystemRole,
    stat.collector_id as CollectorId,
    def.name as CollectorName,
    case when stat.status = 'F' then 0
         when stat.status = 'A' then 2
         else 1
    end as CollectorStatus,
    stat.rc as ReturnCode,
    stat.progress as CollectorProgress,
    stat.time_start as TimeStart,
    stat.time_end as TimeEnd,
    //cast(stat.message as abap.char( 255 ) ) as CollectorLog,
    0 as BestPractice  
} where coll_sys.active = 'X'

union 

select from ZAGSCCL_SYSTEM as sys
inner join zagsccl_srtc as srtc
    on srtc.system_role = sys.system_role
inner join agsccl_coll_def as def
    on def.collector_id = srtc.collector_id
left outer join agsccl_coll_sys as coll_sys
    on coll_sys.collector_id = srtc.collector_id and coll_sys.system_id = sys.system_id
 {
    sys.system_id as SystemId,
    sys.system_role as SystemRole,
    srtc.collector_id as CollectorId,
    def.name as CollectorName,
    2 as CollectorStatus,
    '00' as ReturnCode,
    0 as CollectorProgress,
    000000000000000 as TimeStart,
    000000000000000 as TimeEnd,
    //cast(stat.message as abap.char( 255 ) ) as CollectorLog,
    2 as BestPractice  
} where coll_sys.active <> 'X'

union 

select from ZAGSCCL_SYSTEM as sys
inner join agsccl_coll_stat as stat
    on sys.system_id = stat.system_id
inner join agsccl_coll_def as def
    on def.collector_id = stat.collector_id
inner join agsccl_coll_sys as coll_sys
    on coll_sys.collector_id = stat.collector_id  and sys.system_id = coll_sys.system_id
left outer join zagsccl_srtc as srtc
    on stat.collector_id = srtc.collector_id and srtc.system_role = sys.system_role
 {
    sys.system_id as SystemId,
    sys.system_role as SystemRole,
    stat.collector_id as CollectorId,
    def.name as CollectorName,
        case when stat.status = 'F' then 0
         when stat.status = 'A' then 2
         else 1
    end as CollectorStatus,
    stat.rc as ReturnCode,
    stat.progress as CollectorProgress,
    stat.time_start as TimeStart,
    stat.time_end as TimeEnd,
    //cast(stat.message as abap.char( 255 ) ) as CollectorLog,
    1 as BestPractice  
} where srtc.collector_id is null and coll_sys.active = 'X'