with final as (

SELECT

    CreditPolicy.value:_min_income::NUMBER as min_income,

    CreditPolicy.value:_max_pti::NUMBER as max_pti,

    CreditPolicy.value:_max_dti::NUMBER as max_dti,

    CreditPolicy.value:_max_af::NUMBER as max_af,

    CreditPolicy.value:_max_term::NUMBER as max_term,

    CreditPolicy.value:_min_payment::NUMBER as min_payment,

    CreditPolicy.value:_max_vehicle_age::NUMBER as max_vehicle_age,

    CreditPolicy.value:_max_miles::NUMBER as max_miles,

    CreditPolicy.value:_max_line3_percent::NUMBER as max_line3_percent,

    CreditPolicy.value:_max_line5_percent::NUMBER as max_line5_percent,
    
    CreditPolicy.value:_create_date::TIMESTAMP_TZ as create_date,

    CreditPolicy.value:_update_date::TIMESTAMP_TZ as update_date,
    
    CreditPolicy.value:_updated_by::VARCHAR as updated_by,

    CreditPolicy.value:_deal_detail_id::VARCHAR as deal_detail_id,

    CreditPolicy.value:_bundle_id::NUMBER as bundle_id

    

    from {{ source('src', 'APP_1_JSON') }},

    LATERAL FLATTEN(INPUT => LOAN_APPLICATIONS:LoanApplication)  LoanApplication_flattened,

    LATERAL FLATTEN(INPUT => LoanApplication_flattened.value:LoanApplicationStates.LoanApplicationState.CreditPolicy) CreditPolicy

  )

select * from final