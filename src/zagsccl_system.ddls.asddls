@AbapCatalog.sqlViewName: 'ZCCLM_SYSTEM'
@AbapCatalog.compiler.CompareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'ZCCLM View over AGSCCL_SYSTEM'
define view ZAGSCCL_SYSTEM as select from agsccl_system as sys {
    sys.system_id,
    sys.system_role
} where sys.instno = '0000000000'