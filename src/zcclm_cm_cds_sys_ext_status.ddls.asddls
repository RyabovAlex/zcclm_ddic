@AbapCatalog.sqlViewName: 'ZCCLM_CM_SES'
@AbapCatalog.compiler.CompareFilter: true
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'ZCCLM CM System status for extractors'
define view ZCCLM_CM_CDS_SYS_EXT_STATUS as select from ZAGSCCL_SYSTEM as sys
inner join zagsccl_srte as srte
    on srte.system_role = sys.system_role
inner join e2e_efwk_status as e2e
    on e2e.extractor = srte.extractor_name and e2e.sid = sys.system_id 
inner join e2e_active_wli as awli
    on e2e.wli_id = awli.wli_id {
    key sys.system_id as SystemId,
    sys.system_role as SystemRole,
    key awli.name as ExtractorName,
    e2e.wli_id as ExtractorId,
    case when e2e.rc = 0 and e2e.t_start_last = e2e.t_start_last_suc then 0
         else 2
    end
    as ExtractorStatus,
    e2e.rc as ReturnCode,
    e2e.timestart as LastStart,
    e2e.timestop as LastStop,
    e2e.lastruntime as LastRuntime,
    e2e.lastrecords as LastRecordsNumber,
    e2e.t_start_last_suc as LastSucStart,
    e2e.t_stop_last_suc as LastSucStop,
    0 as BestPractice
} where awli.active = 'X' and 
    (awli.setup_type = 'CCM' or 
        ( awli.setup_type = 'E2EREP' and 
            awli.extractorclass = 'E2E_LUW_ECL_0CCMSATPH'  ) )

union

select from ZAGSCCL_SYSTEM as sys
inner join zagsccl_srte as srte
    on srte.system_role = sys.system_role
/*inner join e2e_active_wli as awli
    on srte.extractor_name = awli.extractor*/
left outer join e2e_efwk_status as e2e
    on e2e.extractor = srte.extractor_name and sys.system_id = e2e.sid
 {
    key sys.system_id as SystemId,
    sys.system_role as SystemRole,
    srte.extractor_name as ExtractorName,
    e2e.wli_id as ExtractorId,
    case when e2e.rc = 0 and e2e.t_start_last = e2e.t_start_last_suc then 0
         else 2
    end
    as ExtractorStatus,
    e2e.rc as ReturnCode,
    e2e.t_start_last as LastStart,
    e2e.t_stop_last as LastStop,
    e2e.lastruntime as LastRuntime,
    e2e.lastrecords as LastRecordsNumber,
    e2e.t_start_last_suc as LastSucStart,
    e2e.t_stop_last_suc as LastSucStop,
    2 as BestPractice
} where e2e.extractor is null and srte.extractor_name is not null /*and 
     (awli.setup_type = 'CCM' or 
     ( awli.setup_type = 'E2EREP' and 
            awli.extractorclass = 'E2E_LUW_ECL_0CCMSATPH'  ) )
*/

union

select from ZAGSCCL_SYSTEM as sys
inner join e2e_efwk_status as e2e
    on sys.system_id = e2e.sid
inner join e2e_active_wli as awli
    on e2e.wli_id = awli.wli_id
left outer join zagsccl_srte as srte
    on e2e.extractor = srte.extractor_name and srte.system_role = sys.system_role 
 {
    key sys.system_id as SystemId,
    sys.system_role as SystemRole,
    awli.name as ExtractorName,
    e2e.wli_id as ExtractorId,
    case when e2e.rc = 0 and e2e.t_start_last = e2e.t_start_last_suc then 0
         else 2
    end
    as ExtractorStatus,
    e2e.rc as ReturnCode,
    e2e.t_start_last as LastStart,
    e2e.t_stop_last as LastStop,
    e2e.lastruntime as LastRuntime,
    e2e.lastrecords as LastRecordsNumber,
    e2e.t_start_last_suc as LastSucStart,
    e2e.t_stop_last_suc as LastSucStop,
    1 as BestPractice
} where srte.extractor_name is null and awli.active = 'X' and 
    (awli.setup_type = 'CCM' )