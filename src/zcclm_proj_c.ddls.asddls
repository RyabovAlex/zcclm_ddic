@AbapCatalog.sqlViewName: 'zcclm_cm_proj'
@AbapCatalog.compiler.CompareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'qwerty'
define view zcclm_proj_c as select from agsccl_system 
    left outer join ags_cc_dc_pr_sys 
    on agsccl_system.system_id = ags_cc_dc_pr_sys.system_id {
    agsccl_system.system_id as SystemId,
    'DC projects as development system' as Name,
     count( distinct ags_cc_dc_pr_sys.system_id ) as Value   
} group by agsccl_system.system_id

union

select from agsccl_system 
    left outer join ags_cc_dc_pr_sys 
    on agsccl_system.system_id = ags_cc_dc_pr_sys.system_id and type = 'U' {
    agsccl_system.system_id as SystemId,
    'DC projects as statistics system' as Name,
     count( distinct ags_cc_dc_pr_sys.system_id ) as Value   
} group by agsccl_system.system_id

union 

select from agsccl_system 
    left outer join ags_ccq_select 
    on agsccl_system.system_id = ags_ccq_select.sys_id and ags_ccq_select.sys_id <> 'ALL' {
    agsccl_system.system_id as SystemId,
    'QC projects as ATC system' as Name,
     count ( distinct ags_ccq_select.sys_id ) as Value   
} group by agsccl_system.system_id
 
union 

select from agsccl_system 
    left outer join ags_ccq_select 
    on agsccl_system.system_id = ags_ccq_select.low and attrib_id = 'PARA_ATC_STAT' {
    agsccl_system.system_id as SystemId,
    'QC projects as statistics system' as Name,
     count( distinct ags_ccq_select.low ) as Value   
} group by agsccl_system.system_id