@AbapCatalog.sqlViewName: 'zcclm_cm_obj_kpi'
@AbapCatalog.compiler.CompareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'AGSCCL_OBJECT KPIs'
define view ZCCLM_CM_KPIS as 

select from agsccl_system 
    left outer join ZCCLM_AGSCCL_OBJECT 
    on agsccl_system.system_id = ZCCLM_AGSCCL_OBJECT.SystemId 
                  and Severity = '5' 
                  and LifecycleStatus <> '99'  {
    agsccl_system.system_id as SystemId,
    cast( 'Custom Objects' as  abap.char(60) ) as Name,
    sum(zcount) as Value    
} group by agsccl_system.system_id 
  
union

select from agsccl_system 
    left outer join ZCCLM_AGSCCL_OBJECT 
    on agsccl_system.system_id = ZCCLM_AGSCCL_OBJECT.SystemId 
                  and Severity = '3' 
                  and LifecycleStatus <> '99' {
    agsccl_system.system_id as SystemId,
    cast( 'Modifications' as  abap.char(60) ) as Name,
    sum(zcount) as Value   
} group by agsccl_system.system_id
  
union

select from agsccl_system 
    left outer join ZCCLM_AGSCCL_OBJECT 
    on agsccl_system.system_id = ZCCLM_AGSCCL_OBJECT.SystemId 
                  and Severity = '1' 
                  and LifecycleStatus <> '99' {
    agsccl_system.system_id as SystemId,
    cast( 'Enhancements' as  abap.char(60) ) as Name,
    sum(zcount) as Value   
} group by agsccl_system.system_id 
  
union

select from agsccl_system 
    left outer join ZCCLM_AGSCCL_OBJECT 
    on agsccl_system.system_id = ZCCLM_AGSCCL_OBJECT.SystemId 
                 and UsageFlag = 'X' 
                 and LastUsed  <> '00000000' 
                 and LifecycleStatus <> '99' {
    agsccl_system.system_id as SystemId,
    cast( 'Used executables' as  abap.char(60) ) as Name,
    sum(zcount) as Value   
} group by agsccl_system.system_id
  
union

select from agsccl_system 
    left outer join ZCCLM_AGSCCL_OBJECT 
    on agsccl_system.system_id = ZCCLM_AGSCCL_OBJECT.SystemId
                 and UsageFlag = 'X' 
                 and LastUsed  = '00000000' 
                 and LifecycleStatus <> '99' {
    agsccl_system.system_id as SystemId,
    cast( 'Not Used executables' as  abap.char(60) ) as Name,
    sum(zcount) as Value   
} group by agsccl_system.system_id 
  
union

select from agsccl_system
    left outer join zcclm_proj_c
    on agsccl_system.system_id = zcclm_proj_c.SystemId {
    agsccl_system.system_id as SystemId,
    cast( zcclm_proj_c.Name as  abap.char(60) ) as Name,
    zcclm_proj_c.Value as Value   
}
