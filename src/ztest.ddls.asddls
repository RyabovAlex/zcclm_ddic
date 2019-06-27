@AbapCatalog.sqlViewName: 'Zcdstest12'
@AbapCatalog.compiler.CompareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'qwerty'
define view ztest12 as select from agsccl_object 
                        inner join agsccl_system 
                        on agsccl_object.system_id = agsccl_system.system_id{
    key obj_type,
    key obj_name,
    key agsccl_object.system_id,
    agsccl_system.sys_role_id
}