@AbapCatalog.sqlViewName: 'ZCCLM_VL_LTOS'
@AbapCatalog.compiler.CompareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'ZCCLM VL Landscapes to System Relationship'
define view ZCCLM_VL_CDS_LTOS as select from zagsccl_ltos as ltos
    association[1] to agsccl_system as system on ltos.sys_id = system.system_id
    association[1] to zagsccl_lnscp as landscape on ltos.lnscp_id = landscape.id {
    key lnscp_id as LandscapeID,
    landscape.descr as LandscapeDescription,
    key sys_id as SystemID,
    system.system_role as SystemRole,
    ltos.sys_clnt as SystemClient
}