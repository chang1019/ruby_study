USE ruby_sample_db;
SET SESSION FOREIGN_KEY_CHECKS=0;

TRUNCATE employees;
TRUNCATE companies;

INSERT INTO
       companies (id, name)
VALUES
	(1, 'A-Company'),
	(2, 'B-Production'),
	(3, 'C-cInsurance')
;

INSERT INTO
       employees (company_id, name)
VALUES
	(1, 'yamada'),
	(1, 'yoshida'),
	(2, 'suzuki'),
	(2, 'fujita'),
	(3, 'takahashi')
;


