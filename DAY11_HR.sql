-- HR ���� Ȱ��ȭ
ALTER SESSION
  SET "_ORACLE_SCRIPT"=true
  ;
@C:\app\Administrator\product\18.0.0\dbhomeXE\demo\schema\human_resources\hr_main

-- 1�� �Է� : HR
-- 2�� �Է� : HR
-- 3�� �Է� : HR
-- 4�� �Է� : $ORACLE_HOME/demo/cchema/log/
-- 1 ~ 4 �Է� �� HR ���� ���̺� ������.

-- HR�� �۾�
-- SELECT �� ~ JOIN, SUB-QUERY����
-- ���ϸ� : day11_HR�̸�.sql �ۼ� �� �̸��Ϸ� ����!

-- 1. SELECT��
----- (1) EMPLOYEES ���̺��� FIRST_NAME�� ��ȸ
SELECT first_name
  FROM employees
;

----- (2) JOBS ���̺��� JOB_ID�� JOB_TITLE�� ��ȸ
SELECT job_id
      , job_title
  FROM jobs
;
----- (3) REGIONS ���̺��� REGION_NAME�� ��ȸ�Ͻÿ�
SELECT region_name
  FROM regions
;

-- 2. DISTINCT��
----- (1) EMPLOYEES ���̺��� JOB_ID�� �ߺ����� ��ȸ�Ͻÿ�
SELECT DISTINCT job_id
  FROM employees
;

----- (2) DEPARTMENTS ���̺��� LOCATION ID �� �ߺ����� ��ȸ�Ͻÿ�
SELECT DISTINCT location_id
  FROM departments
;

----- (3) CONTRIES ���̺��� REGION_ID�� �ߺ� ���� ��ȸ�Ͻÿ�
SELECT DISTINCT region_id
  FROM countries
;

-- 3. ORDER BY ��
----- (1) EMPLOYEES ���̺��� FIRST_NAME ������ �������� ���� �Ͻÿ�
SELECT employee_id
      , first_name
      , last_name
  FROM employees
 ORDER BY first_name
;
----- (2) COUNTRIES ���̺��� REGION_ID ������ ���� ���� �����Ͻÿ�.
SELECT country_id
      , country_name
      , region_id
  FROM COUNTRIES
 ORDER BY region_id DESC
;
----- (3) COUNTRIES ���̺��� COUNTRY_NAME ������ ���� ���� ���� �� 
--        REGION_ID ������ ���� ���� �����Ͻÿ�.
SELECT country_id
      , country_name
      , region_id
  FROM COUNTRIES
 ORDER BY country_name
         , region_id DESC
;

-- 4. ALIAS(��Ī)
----- (1) EMPLOYEES ���̺��� ���̵�(employee_id), ��(first_name), 
--        �̸�(last_name)�� �Ի� �⵵(hire_date)�� ��ȸ�Ͻÿ�
SELECT employee_id "���̵�"
      , first_name  "��"
      , last_name   "�̸�"
      , hire_date   "�Ի� �⵵"
  FROM employees
;

----- (2) DEPARTMENTS ���̺��� �μ� ���̵�(department_id), �μ� �̸�(department_name)
--        , �Ŵ��� ���̵�(manager_id), ��ġ ���̵�(lacation_id)�� ��ȸ�Ͻÿ�
SELECT department_id   "�μ� ���̵�"
      , department_name "�μ� �̸�"
      , manager_id      "�Ŵ��� ���̵�"
      , location_id     "��ġ ���̵�"
  FROM departments
;
----- (3) REGIONS ���̺��� ���� ���̵�(region_id), ���� �̸�(region_name)
SELECT region_id   "���� ���̵�"
      , region_name "���� �̸�"
  FROM regions
;

-- 5. WHERE ��
----- (1) EMPLOYEES ���̺��� job_id�� ST_MAN �� ����� first_name�� last_name �� ��ȸ�Ͻÿ�
SELECT first_name
      , last_name
      , job_id
  FROM employees
 WHERE job_id = 'ST_MAN'
;

----- (2) JOBS ���̺��� min_salary�� 4000�� ����� job_title�� ��ȸ�Ͻÿ�
SELECT j.job_title
      , j.min_salary
  FROM jobs j
 WHERE j.min_salary = 4000
;

----- (3) JOBS ���̺��� job_title �� Accountant�� ����� job_id �� ��ȸ�Ͻÿ�
SELECT j.job_id
      ,j.job_title
  FROM jobs j
 WHERE j.job_title = 'Accountant'
;

-- 6. ������
----- 1) ��� ������ : (), *, / , +, - ������ �켱����
----- (1) employees ���̺��� �������� employee_id, first_name, salary, salary��
--        commission_pct�� ���� ���� ���Ͻÿ�
SELECT e.employee_id "���� id"
      , e.first_name  "��"
      , e.salary      "�޿�"
      , e.salary + e.commission_pct "�޿�+����" 
  FROM employees e
 ORDER BY "�޿�+����"
;

----- (2) employees ���̺��� �������� employee_id, first_name, salary, ������ ���Ͻÿ�
SELECT e.employee_id "���� id"
      , e.first_name  "��"
      , e.salary      "�޿�"
      , e.salary * 12 "����"
  FROM employees e
;

----- (3) employees ���̺��� �������� employee_id, first_name, salary, ����� 20�� �� 
--        job_id�� AD_VP�� �������� ����� ������ �޿��� ���Ͻÿ�
SELECT e.employee_id "���� id"
      , e.job_id
      , e.first_name  "��"
      , e.salary      "�޿�"
      , e.salary - 30 "����� ���� �޿�"
  FROM employees e
 WHERE e.job_id = 'AD_VP'
;

----- 2) �� ������ : =, <>, !=, <, >, <=, >=
----- (1) employees ���̺��� ������ 9000 �̻��� ������ employee_id, first_name, last_name, salary ��ȸ
SELECT e.employee_id
      , e.first_name
      , e.last_name
      , e.salary
  FROM employees e
 WHERE e.salary > 9000
 ORDER BY e.salary
;

----- (2) employees ���̺��� ������ 9000 �� �ƴ� ������ employee_id, first_name, last_name, salary ��ȸ
SELECT e.employee_id
      , e.first_name
      , e.last_name
      , e.salary
  FROM employees e
 WHERE e.salary != 9000
 ORDER BY e.salary
;

----- (3) employees ���̺��� ������ 12000 �� ���ų� ���� ������ employee_id, first_name, last_name, salary ��ȸ
SELECT e.employee_id
      , e.first_name
      , e.last_name
      , e.salary
  FROM employees e
 WHERE e.salary <= 12000
;

----- 3) �� ������ : NOT, AND, OR
----- (1) employees ���̺��� �μ� ��ȣ�� 50���� �ƴ� ������ 
--        employee_id, first_name, last_name, department_id�� ��ȸ�Ͻÿ�
SELECT e.employee_id
      , e.first_name
      , e.last_name
      , e.department_id
  FROM employees e
 WHERE NOT e.department_id = 50
 ORDER BY e.department_id
;

----- (2) employees ���̺��� �μ� ��ȣ�� 50���̰� manager_id�� 100�� �����
--        employee_id, first_name, last_name, department_id, manager_id�� ��ȸ�Ͻÿ�
SELECT e.employee_id
      , e.first_name
      , e.last_name
      , e.department_id
      , e.manager_id
  FROM employees e
 WHERE e.department_id = 50
   AND e.manager_id = 100
;

----- (3) employees ���̺��� �μ� ��ȣ�� 50���̰ų� manager_id�� 103�� �����
--        employee_id, first_name, last_name, department_id, manager_id�� ��ȸ�Ͻÿ�
SELECT e.employee_id
      , e.first_name
      , e.last_name
      , e.department_id
      , e.manager_id
  FROM employees e
 WHERE e.department_id = 50
    OR e.manager_id = 103
;

----- 4) SQL ������ : IN, BETWEEN, IS NULL, IS NOT NULL, LIKE, EXIST
----- (1) employees ���̺��� �޿��� 9000~19000 ������ ������ 
--        employee_id, first_name, last_name, salary�� ��ȸ�Ͻÿ�
SELECT e.employee_id
      , e.first_name
      , e.last_name
      , e.salary
  FROM employees e
 WHERE e.salary BETWEEN 9000 AND 19000
 ORDER BY e.salary
;

----- (2) employees ���̺��� ������ null�� �ƴ� ������ 
--        employee_id, first_name, last_name, salary, commition_pct�� ��ȸ�Ͻÿ�
SELECT e.employee_id
      , e.first_name
      , e.last_name
      , e.salary
      , e.commission_pct
  FROM employees e
 WHERE e.commission_pct IS NOT NULL
 ORDER BY e.commission_pct
;

----- (3) employees ���̺��� ������ first_name �� 'A'�� �����ϴ� ������ 
--        employee_id, first_name, last_name, salary�� ��ȸ�Ͻÿ�
SELECT e.employee_id
      , e.first_name
      , e.last_name
      , e.salary
  FROM employees e
 WHERE e.first_name LIKE 'A%'
 ORDER BY e.employee_id
;

----- 5) ���� ������ : ||
----- (1) employees ���̺��� ��ü �����͸� ������� employee_id �� ���޿��� ������ �����
--        ex)'Steven'�� ���޿��� $24000 �Դϴ�. �� �ǵ��� ��ȸ�Ͻÿ�

SELECT e.employee_id "���� ID"
      , e.first_name || '�� ���޿��� $'
                     || e.salary
                     || '�Դϴ�.' "���޿�"
  FROM employees e
;
----- (2) JOB_HISTORY ���̺��� JOB_ID�� ���� �����Ͽ��� ���� ���������� ���Ͽ�
--        ex) 'IT_PROG�� 01/01/13�� �����Ͽ����� 06/07/24�� ���� �����Դϴ�.'�� ���·� ��ȸ �Ͻÿ�.
SELECT j.job_id || '�� '
                || j.start_date
                || '�� �����Ͽ����� '
                || j.end_date
                || '�� ���� �����Դϴ�.' "job ����"
  FROM job_history j
;
----- (3) LOCATIONS ���̺��� �������(CITY)�� ��� ��ġ��(STREET_ADDRESS) ��ġ�Ͽ� �ִ���
--        ex) 'Roma�� 1297 Via Cola di Rie�� ��ġ�Ͽ����ϴ�'���·� ��ȸ�Ͻÿ�.
SELECT l.city || '�� '
              || l.street_address
              || '�� ��ġ�Ͽ����ϴ�.' "��ġ"
  FROM locations l
;
----- 6) ���� ������ : UNION ALL, UNION, INTERSECT, MINUS
----- (1) �� ���� SELECT ���� �����Ű�� LOCATION_ID�� �ߺ��� �����Ͽ� DEPARTMENTS ���̺��� ��ȸ�Ͻÿ�.
SELECT d.department_id
      , d.department_name
      , d.location_id
      , d.manager_id
  FROM departments d UNION ALL
SELECT d.department_id
      , d.department_name
      , d.location_id
      , d.manager_id
  FROM departments d
 WHERE d.location_id = 1700
;
----- (2) �� ���� SELECT ���� �����Ű�� LOCATION_ID�� �ߺ��� ���� �� �� DEPARTMENTS ���̺��� ��ȸ�Ͻÿ�.
SELECT d.department_id
      , d.department_name
      , d.location_id
      , d.manager_id
  FROM departments d UNION
SELECT d.department_id
      , d.department_name
      , d.location_id
      , d.manager_id
  FROM departments d
 WHERE d.location_id = 1700
;

----- (3) DEPARTMENTS ���̺��� �� ���� SELECT ���� �����Ű�� LOCATION_ID�� �ߺ� ������ ��ȸ�Ͻÿ�.
SELECT d.department_id
      , d.department_name
      , d.location_id
      , d.manager_id
  FROM departments d INTERSECT
SELECT d.department_id
      , d.department_name
      , d.location_id
      , d.manager_id
  FROM departments d
 WHERE d.location_id = 1700
;

