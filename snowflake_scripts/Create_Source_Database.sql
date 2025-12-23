 
-- CREATE THE RAW TABLES

-- create agent table
CREATE OR REPLACE TABLE agent (
    agent_id          VARCHAR,
    agent_name        VARCHAR,
    phone             VARCHAR,
    email             VARCHAR,
    office_city       VARCHAR,
    office_name       VARCHAR,
    annual_salary     NUMBER(18,2),
    commission_rate   NUMBER(6,3),
    hire_date         DATE,
    experience_years  NUMBER(5,2),
    city_code VARCHAR 
);

-- create lead table
CREATE OR REPLACE TABLE lead (
    lead_id             VARCHAR,
    lead_name           VARCHAR,
    phone               VARCHAR,
    mail                VARCHAR,
    contact_date        DATE,
    last_contact_date   DATE,
    conversion_date     DATE,
    num_calls           NUMBER,
    lead_status         VARCHAR,
    lead_source         VARCHAR,
    purchased           BOOLEAN,
    agent_id            VARCHAR,
    campaign_id         VARCHAR,
    min_budget          NUMBER(18,2),
    max_budget          NUMBER(18,2)
);

-- create marketing_campaign table
CREATE OR REPLACE TABLE marketing_campaign (
    campaign_id        VARCHAR,
    campaign_name      VARCHAR,
    campaign_type      VARCHAR,
    start_date         DATE,
    end_date           DATE,
    target_leads_nums  NUMBER,
    actual_leads       NUMBER,
    budget             NUMBER(18,2),
    clicks             NUMBER,
    impressions        NUMBER,
    marketing_channel  VARCHAR,
    governorate_name   VARCHAR,
    campaign_status    VARCHAR  
);

-- create properties table
CREATE OR REPLACE TABLE properties (
    property_id         VARCHAR,
    governorate         VARCHAR,
    governorate_lat     FLOAT,
    governorate_lon     FLOAT,
    city                VARCHAR,
    compound            VARCHAR,
    compound_lat        FLOAT,
    compound_lon        FLOAT,
    property_type       VARCHAR,
    property_status     VARCHAR,
    bedrooms            NUMBER,
    area                NUMBER(18,2),
    property_price      NUMBER(18,2),
    selling_price       NUMBER(18,2),
    renovation_cost     NUMBER(18,2),
    agent_id            VARCHAR,
    availability_status VARCHAR
);

-- create transactiion table
CREATE OR REPLACE TABLE transactions (
    transaction_id            VARCHAR,
    property_id               VARCHAR,
    lead_id                   VARCHAR,
    agent_id                  VARCHAR,
    sale_date                 DATE,
    sale_price                NUMBER(18,2),
    payment_method            VARCHAR,
    commission_amount         NUMBER(18,2),
    commission_rate           NUMBER(6,3),
    original_property_price   NUMBER(18,2),
    governorate_code          VARCHAR
);
