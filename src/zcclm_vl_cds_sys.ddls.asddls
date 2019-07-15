@AbapCatalog.sqlViewName: 'ZCCLM_VL_SYS'
@AbapCatalog.compiler.CompareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'ZCCLM VL Systems'

define view ZCCLM_VL_CDS_SYS as select from agsccl_system as sys
    left outer join zagsccl_ltos as ltos on sys.system_id = ltos.sys_id {
    key sys.system_id as ID,
    sys.system_role as Role,
    ltos.lnscp_id as LandscapeId
}