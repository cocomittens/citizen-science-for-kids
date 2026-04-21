CREATE TABLE teachers (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  email VARCHAR UNIQUE NOT NULL,
  password_hash VARCHAR NOT NULL
);

CREATE TABLE projects (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  teacher_id UUID REFERENCES teachers(id),
  title VARCHAR NOT NULL,
  description VARCHAR,
  class_code VARCHAR UNIQUE NOT NULL
);

CREATE TABLE fields (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  project_id UUID REFERENCES projects(id),
  label VARCHAR NOT NULL,
  field_type VARCHAR NOT NULL,
  options VARCHAR
);

CREATE TABLE observations (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  project_id UUID REFERENCES projects(id),
  student_name VARCHAR,
  latitude FLOAT,
  longitude FLOAT,
  observed_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE observation_values (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  observation_id UUID REFERENCES observations(id),
  field_id UUID REFERENCES fields(id),
  value VARCHAR
);