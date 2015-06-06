USE ruby_sample_db;
SET SESSION FOREIGN_KEY_CHECKS=0;

DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS companies;

CREATE TABLE companies
(
	id int NOT NULL AUTO_INCREMENT,
	name text NOT NULL,
	PRIMARY KEY (id)
);

CREATE TABLE employees
(
	id int NOT NULL AUTO_INCREMENT,
	company_id int NOT NULL,
	name text NOT NULL,
	PRIMARY KEY (id)
);

ALTER TABLE employees
	ADD FOREIGN KEY (company_id)
	REFERENCES companies (id)
	ON UPDATE RESTRICT
	ON DELETE RESTRICT
;
