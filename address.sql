with final as (


SELECT

Address.value:_bundle_id::NUMBER as bundle_id,

    Address.value:_create_date::TIMESTAMP_TZ as create_date,

    Address.value:_update_date::TIMESTAMP_TZ as update_date,

    Address.value:_updated_by::VARCHAR(80) as updated_by,

    Address.value:_address_id::NUMBER as address_id,

    Address.value:_city::VARCHAR(80) as city,

    Address.value:_state_code_id::VARCHAR(30) as state_code_id,

    Address.value:_country_code::VARCHAR(30) as country_code,

    Address.value:_postal_code::NUMBER as postal_code,

    Address.value:_item_code::VARCHAR(50) as item_code,

    Address.value:_street_type::VARCHAR(50) as street_type,

    Address.value:_street_type_description::VARCHAR(80) as street_type_description,

    Address.value:_years_at_address::NUMBER as years_at_address,

    Address.value:_months_at_address::NUMBER as months_at_address,

    Address.value:_mortgage_rent::DECIMAL(30,2) as mortgage_rent,

    Address.value:_address_type::VARCHAR(50) as address_type,

    Address.value:_street_number::VARCHAR(50) as street_number,

    Address.value:_street::VARCHAR(50) as street,

    Address.value:_house_type::VARCHAR(50) as house_type,

    Address.value:_deal_detail_id::NUMBER as deal_detail_id,

    from {{ source('src', 'APP_1_JSON') }},

     LATERAL FLATTEN(INPUT => LOAN_APPLICATIONS:LoanApplication) LoanApplication_flattened,

    LATERAL FLATTEN(INPUT => LoanApplication_flattened.value:LoanApplicationStates.LoanApplicationState.Customers.Customer.Addresses.Address) Address
)

select * from final