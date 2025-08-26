DROP TABLE IF EXISTS coverage_data CASCADE;
DROP TABLE IF EXISTS downstream_analysis CASCADE;
DROP TABLE IF EXISTS execution_coverage CASCADE;
DROP TABLE IF EXISTS test_executions CASCADE;
DROP TABLE IF EXISTS kafka_catalog CASCADE;
DROP TABLE IF EXISTS api_catalog CASCADE;
DROP TABLE IF EXISTS service_info CASCADE;

CREATE TABLE api_catalog (
                                    api_id varchar NOT NULL,
                                    app_id varchar NOT NULL,
                                    method_type varchar NOT NULL,
                                    method_endpoint varchar NOT NULL,
                                    is_eligible bool NOT NULL,
                                    last_refreshed timestamp NOT NULL,
                                    CONSTRAINT api_catalog_pkey PRIMARY KEY (api_id)
);
CREATE TABLE coverage_data (
                                      execution_id uuid NOT NULL,
                                      coverage_percentage float8 NOT NULL,
                                      CONSTRAINT coverage_data_pkey PRIMARY KEY (execution_id)
);
CREATE TABLE downstream_analysis (
                                            downstream_id uuid NOT NULL,
                                            execution_id uuid NULL,
                                            correlation_id varchar NULL,
                                            downstream_api varchar NOT NULL,
                                            CONSTRAINT downstream_analysis_pkey PRIMARY KEY (downstream_id)
);
CREATE TABLE execution_coverage (
                                           coverage_id uuid NOT NULL,
                                           execution_id uuid NULL,
                                           api_id varchar NOT NULL,
                                           correlation_id varchar NOT NULL,
                                           response_status_code int4 NOT NULL,
                                           CONSTRAINT execution_coverage_pkey PRIMARY KEY (coverage_id)
);
CREATE TABLE kafka_catalog (
                                      kafka_id varchar NOT NULL,
                                      app_id varchar NOT NULL,
                                      topic_name varchar NOT NULL,
                                      CONSTRAINT kafka_catalog_pkey PRIMARY KEY (kafka_id)
);
CREATE TABLE service_info (
                                     app_id varchar NOT NULL,
                                     service_name varchar NOT NULL,
                                     service_url varchar NOT NULL,
                                     tenant_name varchar NOT NULL,
                                     service_owner varchar NOT NULL,
                                     updated_at timestamp NOT NULL,
                                     CONSTRAINT service_info_pkey PRIMARY KEY (app_id)
);
CREATE TABLE test_executions (
                                        execution_id uuid NOT NULL,
                                        app_id varchar NOT NULL,
                                        test_type varchar NOT NULL,
                                        triggered_at timestamp NOT NULL,
                                        CONSTRAINT test_executions_pkey PRIMARY KEY (execution_id)
);

-- Sample Data Inserts

INSERT INTO api_catalog (api_id,app_id,method_type,method_endpoint,is_eligible,last_refreshed) VALUES
                                                                                                          ('API-312','BA-3259','POST','/customers/{id}/refresh',true,'2025-08-15 11:23:00'),
                                                                                                          ('API-313','BA-3259','GET','/customers/{id}/status',false,'2025-08-15 11:23:00'),
                                                                                                          ('API-X44','BA-3259','PATCH','/customers/{id}/update-status',true,'2025-08-15 11:23:00'),
                                                                                                          ('API-912','APP-8234','DELETE','/v2/customer/{id}/address',true,'2025-08-02 10:32:00'),
                                                                                                          ('API-463','APP-9735','POST','/v1/addresses',false,'2025-08-13 11:23:00'),
                                                                                                          ('API-7769','CO-2590','GET','/v2/{id}/credit-info',true,'2024-12-15 21:15:00'),
                                                                                                          ('API-314','BA-3257','POST','v2/customers/{id}/refresh',true,'2025-08-15 11:23:00'),
                                                                                                          ('API-315','BA-3257','GET','v2/customers/{id}/status',false,'2025-08-15 11:23:00'),
                                                                                                          ('API-X45','BA-3257','PATCH','v2/customers/{id}/update-status',true,'2025-08-15 11:23:00'),
                                                                                                          ('API-913','APP-8236','DELETE','/v3/customer/{id}/address',true,'2025-08-02 10:32:00');
INSERT INTO api_catalog (api_id,app_id,method_type,method_endpoint,is_eligible,last_refreshed) VALUES
                                                                                                          ('API-464','APP-9739','POST','/v3/addresses',false,'2025-08-13 11:23:00'),
                                                                                                          ('API-7760','CO-2592','GET','/v3/{id}/credit-info',true,'2024-12-15 21:15:00'),
                                                                                                          ('API-316','BA-3258','POST','v2/customers/{id}/refresh',true,'2025-08-15 11:23:00'),
                                                                                                          ('API-317','BA-3258','GET','v2/customers/{id}/status',false,'2025-08-15 11:23:00'),
                                                                                                          ('API-X47','BA-3258','PATCH','v2/customers/{id}/update-status',true,'2025-08-15 11:23:00'),
                                                                                                          ('API-914','APP-8237','DELETE','/v3/customer/{id}/address',true,'2025-08-02 10:32:00'),
                                                                                                          ('API-465','APP-9740','POST','/v3/addresses',false,'2025-08-13 11:23:00'),
                                                                                                          ('API-7762','CO-2593','GET','/v3/{id}/credit-info',true,'2024-12-15 21:15:00');


INSERT INTO coverage_data (execution_id,coverage_percentage) VALUES
                                                                        ('550e8400-e29b-41d4-a716-446655440001'::uuid,32.0),
                                                                        ('550e8400-e29b-41d4-a716-446655440002'::uuid,15.5),
                                                                        ('550e8400-e29b-41d4-a716-446655440003'::uuid,64.9),
                                                                        ('550e8400-e29b-41d4-a716-446655440004'::uuid,42.0),
                                                                        ('550e8400-e29b-41d4-a716-446655440005'::uuid,55.5),
                                                                        ('550e8400-e29b-41d4-a716-446655440006'::uuid,84.9),
                                                                        ('550e8400-e29b-41d4-a716-446655440007'::uuid,32.0),
                                                                        ('550e8400-e29b-41d4-a716-446655440008'::uuid,45.5),
                                                                        ('550e8400-e29b-41d4-a716-446655440010'::uuid,42.0),
                                                                        ('550e8400-e29b-41d4-a716-446655440011'::uuid,55.5);
INSERT INTO coverage_data (execution_id,coverage_percentage) VALUES
                                                                        ('550e8400-e29b-41d4-a716-446655440013'::uuid,48.0),
                                                                        ('550e8400-e29b-41d4-a716-446655440014'::uuid,61.5),
                                                                        ('550e8400-e29b-41d4-a716-446655440016'::uuid,51.0),
                                                                        ('550e8400-e29b-41d4-a716-446655440019'::uuid,51.0),
                                                                        ('550e8400-e29b-41d4-a716-446655440022'::uuid,71.0),
                                                                        ('550e8400-e29b-41d4-a716-446655440023'::uuid,86.5),
                                                                        ('550e8400-e29b-41d4-a716-446655440012'::uuid,36.9),
                                                                        ('550e8400-e29b-41d4-a716-446655440015'::uuid,59.9),
                                                                        ('550e8400-e29b-41d4-a716-446655440021'::uuid,72.0),
                                                                        ('550e8400-e29b-41d4-a716-446655440018'::uuid,64.9);
INSERT INTO coverage_data (execution_id,coverage_percentage) VALUES
                                                                        ('550e8400-e29b-41d4-a716-446655440017'::uuid,56.5),
                                                                        ('550e8400-e29b-41d4-a716-446655440020'::uuid,56.5),
                                                                        ('550e8400-e29b-41d4-a716-446655440009'::uuid,44.9),
                                                                        ('550e8400-e29b-41d4-a716-446655440024'::uuid,59.0),
                                                                        ('550e8400-e29b-41d4-a716-446655440025'::uuid,72.5);


INSERT INTO downstream_analysis (downstream_id,execution_id,correlation_id,downstream_api) VALUES
                                                                                                      ('750e8400-e29b-41d4-a716-446655440312'::uuid,'550e8400-e29b-41d4-a716-446655440001'::uuid,'corr-001','/v2/external/user-validation'),
                                                                                                      ('750e8400-e29b-41d4-a716-446655440313'::uuid,'550e8400-e29b-41d4-a716-446655440001'::uuid,'corr-001','/v2/external/user-info'),
                                                                                                      ('750e8400-e29b-41d4-a716-446655440314'::uuid,'550e8400-e29b-41d4-a716-446655440001'::uuid,'corr-001','/v2/external/refresh-status'),
                                                                                                      ('750e8400-e29b-41d4-a716-446655440315'::uuid,'550e8400-e29b-41d4-a716-446655440002'::uuid,'corr-002','/v1/3559/address-info'),
                                                                                                      ('750e8400-e29b-41d4-a716-446655440316'::uuid,'550e8400-e29b-41d4-a716-446655440002'::uuid,'corr-003','/v1/2209/credit-service'),
                                                                                                      ('750e8400-e29b-41d4-a716-446655440317'::uuid,'550e8400-e29b-41d4-a716-446655440004'::uuid,'corr-004','/v3/external/user-validation'),
                                                                                                      ('750e8400-e29b-41d4-a716-446655440318'::uuid,'550e8400-e29b-41d4-a716-446655440004'::uuid,'corr-004','/v3/external/user-info'),
                                                                                                      ('750e8400-e29b-41d4-a716-446655440319'::uuid,'550e8400-e29b-41d4-a716-446655440004'::uuid,'corr-004','/v3/external/refresh-status'),
                                                                                                      ('750e8400-e29b-41d4-a716-446655440320'::uuid,'550e8400-e29b-41d4-a716-446655440005'::uuid,'corr-005','/v2/3559/address-info'),
                                                                                                      ('750e8400-e29b-41d4-a716-446655440321'::uuid,'550e8400-e29b-41d4-a716-446655440005'::uuid,'corr-006','/v3/2209/credit-service');
INSERT INTO downstream_analysis (downstream_id,execution_id,correlation_id,downstream_api) VALUES
                                                                                                      ('750e8400-e29b-41d4-a716-446655440322'::uuid,'550e8400-e29b-41d4-a716-446655440007'::uuid,'corr-008','/v3/external/user-validation'),
                                                                                                      ('750e8400-e29b-41d4-a716-446655440323'::uuid,'550e8400-e29b-41d4-a716-446655440007'::uuid,'corr-008','/v3/external/user-info'),
                                                                                                      ('750e8400-e29b-41d4-a716-446655440324'::uuid,'550e8400-e29b-41d4-a716-446655440007'::uuid,'corr-010','/v3/external/refresh-status'),
                                                                                                      ('750e8400-e29b-41d4-a716-446655440325'::uuid,'550e8400-e29b-41d4-a716-446655440008'::uuid,'corr-036','/v2/3559/address-info'),
                                                                                                      ('750e8400-e29b-41d4-a716-446655440326'::uuid,'550e8400-e29b-41d4-a716-446655440009'::uuid,'corr-011','/v3/2209/credit-service');


INSERT INTO execution_coverage (coverage_id,execution_id,api_id,correlation_id,response_status_code) VALUES
                                                                                                                ('650e8400-e29b-41d4-a716-446655440001'::uuid,'550e8400-e29b-41d4-a716-446655440001'::uuid,'API-X44','corr-001',201),
                                                                                                                ('650e8400-e29b-41d4-a716-446655440003'::uuid,'550e8400-e29b-41d4-a716-446655440001'::uuid,'API-312','corr-002',500),
                                                                                                                ('650e8400-e29b-41d4-a716-446655440004'::uuid,'550e8400-e29b-41d4-a716-446655440001'::uuid,'API-312','corr-003',200),
                                                                                                                ('650e8400-e29b-41d4-a716-446655440005'::uuid,'550e8400-e29b-41d4-a716-446655440002'::uuid,'API-7769','corr-034',404),
                                                                                                                ('650e8400-e29b-41d4-a716-446655440006'::uuid,'550e8400-e29b-41d4-a716-446655440003'::uuid,'API-912','corr-004',200),
                                                                                                                ('650e8400-e29b-41d4-a716-446655440007'::uuid,'550e8400-e29b-41d4-a716-446655440004'::uuid,'API-X46','corr-004',201),
                                                                                                                ('650e8400-e29b-41d4-a716-446655440008'::uuid,'550e8400-e29b-41d4-a716-446655440004'::uuid,'API-315','corr-005',500),
                                                                                                                ('650e8400-e29b-41d4-a716-446655440009'::uuid,'550e8400-e29b-41d4-a716-446655440004'::uuid,'API-315','corr-006',200),
                                                                                                                ('650e8400-e29b-41d4-a716-446655440010'::uuid,'550e8400-e29b-41d4-a716-446655440005'::uuid,'API-7761','corr-035',404),
                                                                                                                ('650e8400-e29b-41d4-a716-446655440011'::uuid,'550e8400-e29b-41d4-a716-446655440006'::uuid,'API-912','corr-007',200);
INSERT INTO execution_coverage (coverage_id,execution_id,api_id,correlation_id,response_status_code) VALUES
                                                                                                                ('650e8400-e29b-41d4-a716-446655440012'::uuid,'550e8400-e29b-41d4-a716-446655440007'::uuid,'API-X47','corr-008',201),
                                                                                                                ('650e8400-e29b-41d4-a716-446655440013'::uuid,'550e8400-e29b-41d4-a716-446655440007'::uuid,'API-316','corr-009',500),
                                                                                                                ('650e8400-e29b-41d4-a716-446655440014'::uuid,'550e8400-e29b-41d4-a716-446655440007'::uuid,'API-316','corr-010',200),
                                                                                                                ('650e8400-e29b-41d4-a716-446655440015'::uuid,'550e8400-e29b-41d4-a716-446655440008'::uuid,'API-7762','corr-036',404),
                                                                                                                ('650e8400-e29b-41d4-a716-446655440016'::uuid,'550e8400-e29b-41d4-a716-446655440009'::uuid,'API-914','corr-011',200);


INSERT INTO kafka_catalog (kafka_id,app_id,topic_name) VALUES
                                                                  ('kafka-X01','BA-3259','fraud-data-event-v1.dev'),
                                                                  ('kafka-X39','BA-3259','otp-refresh-event-v2.test'),
                                                                  ('kafka-u20','APP-9735','event-expiry-event-v1.sit'),
                                                                  ('kafka-u30','CO-2590','cibil-refresh-test');


INSERT INTO service_info (app_id,service_name,service_url,tenant_name,service_owner,updated_at) VALUES
                                                                                                           ('APP-8234','Address Service','https://github.aus.thenational.com/address-service','customer-info-tenant','hellocustomer@nab.com.au','2025-08-02 10:32:00'),
                                                                                                           ('BA-3259','Fraud Service','https://github.aus.thenational.com/fraud-service','fraud-tenant','hellofraud@nab.com.au','2025-08-15 11:23:00'),
                                                                                                           ('CO-2590','Credit Service','https://github.aus.thenational.com/credit-service','mobile-tenant','hellomobile@nab.com.au','2024-12-15 21:15:00'),
                                                                                                           ('APP-9735','Mobile Service','https://github.aus.thenational.com/mobile-service','credit-tenant','hellocredit@nab.com.au','2025-08-13 11:23:00'),
                                                                                                           ('APP-8236','Location Service','https://github.aus.thenational.com/address-service','customer-info-tenant','hellocustomer@nab.com.au','2025-08-02 10:32:00'),
                                                                                                           ('BA-3257','NonFraud Service','https://github.aus.thenational.com/fraud-service','fraud-tenant','hellofraud@nab.com.au','2025-08-15 11:23:00'),
                                                                                                           ('CO-2592','Debit Service','https://github.aus.thenational.com/credit-service','mobile-tenant','hellomobile@nab.com.au','2024-12-15 21:15:00'),
                                                                                                           ('APP-9739','Phone Service','https://github.aus.thenational.com/mobile-service','credit-tenant','hellocredit@nab.com.au','2025-08-13 11:23:00'),
                                                                                                           ('APP-8237','State Service','https://github.aus.thenational.com/address-service','customer-info-tenant','hellocustomer@nab.com.au','2025-08-02 10:32:00'),
                                                                                                           ('BA-3258','Reconcil Service','https://github.aus.thenational.com/fraud-service','fraud-tenant','hellofraud@nab.com.au','2025-08-15 11:23:00');
INSERT INTO service_info (app_id,service_name,service_url,tenant_name,service_owner,updated_at) VALUES
                                                                                                           ('CO-2593','Savings Service','https://github.aus.thenational.com/credit-service','mobile-tenant','hellomobile@nab.com.au','2024-12-15 21:15:00'),
                                                                                                           ('APP-9740','Contact Service','https://github.aus.thenational.com/mobile-service','credit-tenant','hellocredit@nab.com.au','2025-08-13 11:23:00');


INSERT INTO test_executions (execution_id,app_id,test_type,triggered_at) VALUES
                                                                                    ('550e8400-e29b-41d4-a716-446655440001'::uuid,'BA-3259','system-test','2025-08-21 14:09:00'),
                                                                                    ('550e8400-e29b-41d4-a716-446655440002'::uuid,'CO-2590','system-test','2025-08-21 21:45:00'),
                                                                                    ('550e8400-e29b-41d4-a716-446655440004'::uuid,'BA-3257','system-test','2025-08-21 14:09:00'),
                                                                                    ('550e8400-e29b-41d4-a716-446655440005'::uuid,'CO-2592','system-test','2025-08-21 21:45:00'),
                                                                                    ('550e8400-e29b-41d4-a716-446655440007'::uuid,'BA-3258','system-test','2025-08-21 14:09:00'),
                                                                                    ('550e8400-e29b-41d4-a716-446655440008'::uuid,'CO-2593','system-test','2025-08-21 21:45:00'),
                                                                                    ('550e8400-e29b-41d4-a716-446655440010'::uuid,'BA-3258','blackbox-test','2025-08-21 14:09:00'),
                                                                                    ('550e8400-e29b-41d4-a716-446655440011'::uuid,'CO-2593','blackbox-test','2025-08-21 21:45:00'),
                                                                                    ('550e8400-e29b-41d4-a716-446655440013'::uuid,'BA-3258','blackbox-test','2025-08-24 14:09:00'),
                                                                                    ('550e8400-e29b-41d4-a716-446655440014'::uuid,'CO-2593','blackbox-test','2025-08-24 21:45:00');
INSERT INTO test_executions (execution_id,app_id,test_type,triggered_at) VALUES
                                                                                    ('550e8400-e29b-41d4-a716-446655440015'::uuid,'APP-8237','system-test','2025-08-24 21:45:00'),
                                                                                    ('550e8400-e29b-41d4-a716-446655440016'::uuid,'BA-3258','blackbox-test','2025-08-26 14:09:00'),
                                                                                    ('550e8400-e29b-41d4-a716-446655440017'::uuid,'CO-2593','blackbox-test','2025-08-26 21:45:00'),
                                                                                    ('550e8400-e29b-41d4-a716-446655440018'::uuid,'APP-8237','system-test','2025-08-26 21:45:00'),
                                                                                    ('550e8400-e29b-41d4-a716-446655440019'::uuid,'CO-2590','blackbox-test','2025-08-24 14:09:00'),
                                                                                    ('550e8400-e29b-41d4-a716-446655440020'::uuid,'APP-8237','system-test','2025-08-24 21:45:00'),
                                                                                    ('550e8400-e29b-41d4-a716-446655440021'::uuid,'APP-8234','system-test','2025-08-24 21:45:00'),
                                                                                    ('550e8400-e29b-41d4-a716-446655440022'::uuid,'BA-3259','blackbox-test','2025-08-24 14:09:00'),
                                                                                    ('550e8400-e29b-41d4-a716-446655440023'::uuid,'APP-8236','system-test','2025-08-24 21:45:00'),
                                                                                    ('550e8400-e29b-41d4-a716-446655440003'::uuid,'APP-8234','blackbox-test','2025-08-19 21:45:00');
INSERT INTO test_executions (execution_id,app_id,test_type,triggered_at) VALUES
                                                                                    ('550e8400-e29b-41d4-a716-446655440006'::uuid,'APP-8236','blackbox-test','2025-08-19 21:45:00'),
                                                                                    ('550e8400-e29b-41d4-a716-446655440009'::uuid,'APP-8237','blackbox-test','2025-08-19 21:45:00'),
                                                                                    ('550e8400-e29b-41d4-a716-446655440012'::uuid,'APP-8237','system-test','2025-08-19 21:45:00'),
                                                                                    ('550e8400-e29b-41d4-a716-446655440024'::uuid,'APP-8237','blackbox-test','2025-08-24 14:09:00'),
                                                                                    ('550e8400-e29b-41d4-a716-446655440025'::uuid,'APP-8237','blackbox-test','2025-08-26 21:45:00');

