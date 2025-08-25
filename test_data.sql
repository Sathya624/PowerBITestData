DROP TABLE IF EXISTS coverage_data CASCADE;
DROP TABLE IF EXISTS downstream_analysis CASCADE;
DROP TABLE IF EXISTS execution_coverage CASCADE;
DROP TABLE IF EXISTS test_executions CASCADE;
DROP TABLE IF EXISTS kafka_catalog CASCADE;
DROP TABLE IF EXISTS api_catalog CASCADE;
DROP TABLE IF EXISTS service_info CASCADE;

CREATE TABLE service_info (
app_id VARCHAR PRIMARY KEY,
service_name VARCHAR NOT NULL,
service_url VARCHAR NOT NULL,
updated_at TIMESTAMP NOT NULL
);

CREATE TABLE api_catalog (
api_id VARCHAR PRIMARY KEY,
app_id VARCHAR NOT NULL REFERENCES service_info(app_id),
method_type VARCHAR NOT NULL,
method_endpoint VARCHAR NOT NULL,
is_eligible BOOLEAN NOT NULL,
last_refreshed TIMESTAMP NOT NULL
);

CREATE TABLE kafka_catalog (
kafka_id VARCHAR PRIMARY KEY,
app_id VARCHAR NOT NULL REFERENCES service_info(app_id),
topic_name VARCHAR NOT NULL
);

CREATE TABLE test_executions (
execution_id UUID PRIMARY KEY,
test_type VARCHAR NOT NULL,
triggered_at TIMESTAMP NOT NULL
);

CREATE TABLE execution_coverage (
coverage_id UUID PRIMARY KEY,
execution_id UUID REFERENCES test_executions(execution_id),
api_id VARCHAR NOT NULL,
correlation_id VARCHAR NOT NULL,
response_status_code INT NOT NULL
);

CREATE TABLE downstream_analysis (
downstream_id UUID PRIMARY KEY,
execution_id UUID REFERENCES test_executions(execution_id),
correlation_id VARCHAR ,
downstream_api VARCHAR NOT NULL
);

CREATE TABLE coverage_data (
execution_id UUID PRIMARY KEY REFERENCES test_executions(execution_id),
coverage_percentage FLOAT NOT NULL
);

-- Sample Data Inserts
INSERT INTO service_info (app_id, service_name, service_url, updated_at) VALUES
('APP-8234', 'Address Service', 'https://github.aus.thenational.com/address-service', '2025-08-02 10:32:00'),
('BA-3259', 'Fraud Service', 'https://github.aus.thenational.com/fraud-service', '2025-08-15 11:23:00'),
('CO-2590', 'Credit Service', 'https://github.aus.thenational.com/credit-service', '2024-12-15 21:15:00'),
('APP-9735', 'Mobile Service', 'https://github.aus.thenational.com/mobile-service', '2025-08-13 11:23:00');

INSERT INTO api_catalog (api_id, app_id, method_type, method_endpoint, is_eligible, last_refreshed) VALUES
('API-312', 'BA-3259', 'POST', '/customers/{id}/refresh', true, '2025-08-15 11:23:00'),
('API-313', 'BA-3259', 'GET', '/customers/{id}/status', false, '2025-08-15 11:23:00'),
('API-X44', 'BA-3259', 'PATCH', '/customers/{id}/update-status', true, '2025-08-15 11:23:00'),
('API-912', 'APP-8234', 'DELETE', '/v2/customer/{id}/address', true, '2025-08-02 10:32:00'),
('API-463', 'APP-9735', 'POST', '/v1/addresses', false, '2025-08-13 11:23:00'),
('API-7769', 'CO-2590', 'GET', '/v2/{id}/credit-info', true, '2024-12-15 21:15:00');

INSERT INTO kafka_catalog (kafka_id, app_id, topic_name) VALUES
('kafka-X01', 'BA-3259', 'fraud-data-event-v1.dev'),
('kafka-X39', 'BA-3259', 'otp-refresh-event-v2.test'),
('kafka-u20', 'APP-9735', 'event-expiry-event-v1.sit'),
('kafka-u30', 'CO-2590', 'cibil-refresh-test');

INSERT INTO test_executions (execution_id, test_type, triggered_at) VALUES
('550e8400-e29b-41d4-a716-446655440001', 'system-test', '2025-08-21 14:09:00'),
('550e8400-e29b-41d4-a716-446655440002', 'system-test', '2025-08-21 21:45:00'),
('550e8400-e29b-41d4-a716-446655440003', 'blackbox-test', '2025-08-09 21:45:00');

INSERT INTO execution_coverage (coverage_id, execution_id, api_id, correlation_id, response_status_code) VALUES
('650e8400-e29b-41d4-a716-446655440001', '550e8400-e29b-41d4-a716-446655440001', 'API-X44', 'corr-001', 201),
('650e8400-e29b-41d4-a716-446655440003', '550e8400-e29b-41d4-a716-446655440001', 'API-312', 'corr-002', 500),
('650e8400-e29b-41d4-a716-446655440004', '550e8400-e29b-41d4-a716-446655440001', 'API-312', 'corr-003', 200),
('650e8400-e29b-41d4-a716-446655440005', '550e8400-e29b-41d4-a716-446655440002', 'API-7769', 'corr-034', 404),
('650e8400-e29b-41d4-a716-446655440006', '550e8400-e29b-41d4-a716-446655440002', 'API-912', 'corr-004', 200);

INSERT INTO downstream_analysis (downstream_id, execution_id, correlation_id, downstream_api) VALUES
('750e8400-e29b-41d4-a716-446655440312', '550e8400-e29b-41d4-a716-446655440001', 'corr-001', '/v2/external/user-validation'),
('750e8400-e29b-41d4-a716-446655440313', '550e8400-e29b-41d4-a716-446655440001', 'corr-001', '/v2/external/user-info'),
('750e8400-e29b-41d4-a716-446655440314', '550e8400-e29b-41d4-a716-446655440001', 'corr-001', '/v2/external/refresh-status'),
('750e8400-e29b-41d4-a716-446655440315', '550e8400-e29b-41d4-a716-446655440002', 'corr-002', '/v1/3559/address-info'),
('750e8400-e29b-41d4-a716-446655440316', '550e8400-e29b-41d4-a716-446655440002', 'corr-003', '/v1/2209/credit-service');

INSERT INTO coverage_data (execution_id, coverage_percentage) VALUES
('550e8400-e29b-41d4-a716-446655440001', 32.0),
('550e8400-e29b-41d4-a716-446655440002', 15.5),
('550e8400-e29b-41d4-a716-446655440003', 64.9);