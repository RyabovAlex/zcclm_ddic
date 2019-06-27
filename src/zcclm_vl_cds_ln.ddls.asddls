@AbapCatalog.sqlViewName: 'ZCCLM_VL_LN'
@AbapCatalog.compiler.CompareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'ZCCLM VL Landscapes'
define view ZCCLM_VL_CDS_LN as select from zagsccl_lnscp as ln
    association to zagsccl_ltos as ltos on ln.id = ltos.lnscp_id  {
    key ln.id as ID,
    ln.descr as Description,
    ltos as SystemData
}