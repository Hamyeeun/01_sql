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

-- 7) ������ �Լ� 
----- 1. ���� �Լ� : MOD(), ROUND(), TRUNC(), CEIL(), FLOOR(), WIDTH_BUCKET()
----- (1) 10�� 3���� ���� �������� 1ȸ�� ����Ͻÿ�
SELECT mod(10,3)
  FROM dual
;

----- (2) employees ���̺��� ��� �������� �� �޿��� 0.35% �� �߰� �������� �� �� 
--        �Ҽ��� ��°�ڸ����� �ݿø��Ͽ� ��ȸ�Ͻÿ�.
-- �� �� first_name�� ���� �޿�, �߰� ����, ���� �޿��� �߰� ���� ���� ���� �� �޿��� ��ȸ�Ͻÿ�
SELECT e.first_name                        "��"
      , e.salary                           "���� �޿�"
      , round(e.salary*0.35, 1)            "�߰� ����"
      , e.salary + round(e.salary*0.35, 1) "�� �޿�"
  FROM employees e
;

----- (3) employees ���̺��� ��� �������� �� �޿��� 0.35% �� �߰� �������� �� �� 
--        �Ҽ��� ù° �ڸ������� ����� �����Ͽ� ��ȸ�Ͻÿ�.
-- �� �� first_name�� ���� �޿�, �߰� ����, ���� �޿��� �߰� ���� ���� ���� �� �޿��� ��ȸ�Ͻÿ�
SELECT e.first_name                       "��"
      , e.salary                          "���� �޿�"
      , trunc(e.salary*0.35,1)            "�߰� ����"
      , e.salary + trunc(e.salary*0.35,1) "�� �޿�"
  FROM employees e
;

----- 2. ���� �Լ� : INITCAP(), LOWER(), UPPER(), LENGTH(), LENGTHB(), CONCAT(), SUBSTR(), INSTR(),
--                   LAPD(), RPAD(), LTRIM(), RTRIM(), TRIM(), NVL(), NVL2(), NULLIF()

----- (1) CONCAT(str1,str2)�� �̿��Ͽ� '�������б�','�ȳ��ϼ���'�� ����Ͻÿ�
SELECT concat('�������б� ','�ȳ��ϼ���') "�λ�"
  FROM dual
;
----- (2) '�������б��� �����Ѱ��� ȯ���մϴ�'��� �������� ȯ���մϴٸ� ����Ͻÿ�
SELECT SUBSTR('�������б��� �����Ѱ��� ȯ���մϴ�',14,18) "ȯ���մϴ�"
  FROM dual
;
----- (3) employees ���̺��� commission_pct�� null�̸� null ��� 0�� ��µǵ��� ��ȸ�Ͻÿ�.
--        ��(first_name), �̸�(last_name), �޿�(salary), ����(commission_pct) ��ȸ
SELECT e.first_name                "��"
      , e.last_name                "�̸�"
      , e.salary                   "�޿�"
      , NVL(e.commission_pct, 0) "����"
  FROM employees e
;


----- 3. ��¥ �Լ� : YYYY, YY, MM, MONTH(Month), MON(Mon), DD, D, DAY, DY, FM
--                   sysdate, MONTHS_BETWEEN(), ADD_MONTH(), NEXT_DAY(), LAST_DAY(), ROUNT(), TRUNC()
----- 4. ������ Ÿ�� ��ȯ �Լ� : TO_CHAR(), TO_NUMBER(), TO_DATE()

----- (1) ������ ��¥�� '2019-00-00  0���� �Դϴ�'���·� ��ȸ�Ͻÿ�
SELECT to_char(sysdate, 'YYYY-MM-DD DAY') ||' �Դϴ�' "������ ��¥"
  FROM dual
;

----- (2) employees ���̺��� �������� �Ի����� '0000-00-00 0���� �Ի��߽��ϴ�.'���·� ��ȸ�Ͻÿ�
--        ��(first_name), �̸�(last_name), �Ի���(hire_date)
SELECT e.first_name                                                "��"   
      , e.last_name                                                "�̸�"
      , to_char(e.hire_date, 'YYYY-MM-DD DAY') || ' �Ի��߽��ϴ�.' "�Ի���"
  FROM employees e
 ORDER BY e.hire_date
;

----- (3) �� ������ ����� �Ի��ߴ��� first_name �� '0���� �Ի��߽��ϴ�'���·� ��ȸ�Ͻÿ�.
--        1 ~ 12�� ���� ���ʷ� ��ȸ�Ұ�.
SELECT e.first_name                                          "��"
      ,to_char(e.hire_date,' FMMM') || '���� �Ի��߽��ϴ�.' "�Ի� ��"
  FROM employees e
 ORDER BY to_number(to_char(e.hire_date,' FMMM')) 
;



----- 5. DECODE
----- (1) employees ���̺��� ����id(job_id)�� ���� ���ʽ��� �شٰ� �� �� ����id(job_id)�� ���ʽ� �� ��ȸ�Ͻÿ�
/*
AC_ACCOUNT : 0.02
AC_MGR     : 0.02
AD_ASST    : 0.021
AD_PRES    : 0.021
AD_VP      : 0.021
FI_ACCOUNT : 0.022
FI_MGR     : 0.022
HR_REP     : 0.023
IT_PROG    : 0.024
MK_MAN     : 0.025
MK_REP     : 0.025
PR_REP     : 0.026
PU_CLERK   : 0.027
PU_MAN     : 0.027
SA_MAN     : 0.028
SA_REP     : 0.028
SH_CLERK   : 0.029
ST_CLERK   : 0.03
ST_MAN     : 0.03
*/        
SELECT DISTINCT e.job_id
      , DECODE(e.job_id , 'AC_ACCOUNT', e.salary * 0.02
                        , 'AC_MGR'    , e.salary * 0.02
                        , 'AD_ASST'   , e.salary * 0.021
                        , 'AD_PRES'   , e.salary * 0.021
                        , 'AD_VP'     , e.salary * 0.021
                        , 'FI_ACCOUNT', e.salary * 0.022
                        , 'FI_MGR'    , e.salary * 0.022
                        , 'HR_REP'    , e.salary * 0.023
                        , 'IT_PROG'   , e.salary * 0.024
                        , 'MK_MAN'    , e.salary * 0.025
                        , 'MK_REP'    , e.salary * 0.025
                        , 'PR_REP'    , e.salary * 0.026
                        , 'PU_CLERK'  , e.salary * 0.027
                        , 'PU_MAN'    , e.salary * 0.027
                        , 'SA_MAN'    , e.salary * 0.028
                        , 'SA_REP'    , e.salary * 0.028
                        , 'SH_CLERK'  , e.salary * 0.029
                        , 'ST_CLERK'  , e.salary * 0.030
                        , 'ST_MAN'    , e.salary * 0.030) "���ʽ�"
  FROM employees e
 ORDER BY e.job_id
;

----- (2) employees ���̺��� �μ���ȣ�� ��ȸ�ϰ� ���� �μ����� ��ȸ�Ͻÿ�
--        first_name, deptment_id, �μ���
--        ���� �μ�id�� null ���̸� '-'�� ��ȸ�ǰ� �Ͻÿ�
SELECT e.first_name     "��"
      , e.department_id "�μ� id"
      ,DECODE(e.department_id, 10, 'Administration'
                             , 20, 'Marketing'
                             , 30, 'Purchasing'
                             , 40, 'Human Resources'
                             , 50, 'Shipping'
                             , 60, 'IT'
                             , 70, 'Public Relations'
                             , 80, 'Sales'
                             , 90, 'Executive'
                             , 100, 'Finance'
                             , 110, 'Accounting', '-') "�μ���"
  FROM employees e
 ORDER BY e.department_id
;

----- (3) locations ���̺� ���� city�� city�� �ʼ��� ��ȸ�Ͻÿ�
--        ex) ���ø�     �ʼ�
-------------------------------------------------------------
--            Beijing    �ʼ��� B�� �����ϴ� �����Դϴ�.

SELECT l.city  "���ø�"
      , DECODE(l.city, 'Beijing', '�ʼ��� B�� �����ϴ� �����Դϴ�.'
                     , 'Bern', '�ʼ��� B�� �����ϴ� �����Դϴ�.'
                     , 'Bombay', '�ʼ��� B�� �����ϴ� �����Դϴ�.'
                     , 'Geneva', '�ʼ��� G�� �����ϴ� �����Դϴ�.'
                     , 'Hiroshima', '�ʼ��� H�� �����ϴ� �����Դϴ�.'
                     , 'London', '�ʼ��� L�� �����ϴ� �����Դϴ�.'
                     , 'Mexico City', '�ʼ��� M�� �����ϴ� �����Դϴ�.'
                     , 'Munich', '�ʼ��� M�� �����ϴ� �����Դϴ�.'
                     , 'Oxford', '�ʼ��� O�� �����ϴ� �����Դϴ�.'
                     , 'Roma', '�ʼ��� R�� �����ϴ� �����Դϴ�.'
                     , 'Sao Paulo', '�ʼ��� S�� �����ϴ� �����Դϴ�.'
                     , 'Seattle', '�ʼ��� S�� �����ϴ� �����Դϴ�.'
                     , 'Singapore', '�ʼ��� S�� �����ϴ� �����Դϴ�.'
                     , 'South Brunswick', '�ʼ��� S�� �����ϴ� �����Դϴ�.'
                     , 'South San Francisco', '�ʼ��� S�� �����ϴ� �����Դϴ�.'
                     , 'Southlake', '�ʼ��� S�� �����ϴ� �����Դϴ�.'
                     , 'Stretford', '�ʼ��� S�� �����ϴ� �����Դϴ�.'
                     , 'Sydney', '�ʼ��� S�� �����ϴ� �����Դϴ�.'
                     , 'Tokyo', '�ʼ��� T�� �����ϴ� �����Դϴ�.'
                     , 'Toronto', '�ʼ��� T�� �����ϴ� �����Դϴ�.'
                     , 'Utrecht', '�ʼ��� U�� �����ϴ� �����Դϴ�.'
                     , 'Venice', '�ʼ��� V�� �����ϴ� �����Դϴ�.'
                     , 'Whitehorse', '�ʼ��� W�� �����ϴ� �����Դϴ�.') "�ʼ�"
  FROM locations l
;

----- 6. CASE

----- (1) employees ���̺��� ����id(job_id)�� ���� ���ʽ��� �شٰ� �� �� ����id(job_id)�� ���ʽ� �� ��ȸ�Ͻÿ�
/*
AC_ACCOUNT : 0.02
AC_MGR     : 0.02
AD_ASST    : 0.021
AD_PRES    : 0.021
AD_VP      : 0.021
FI_ACCOUNT : 0.022
FI_MGR     : 0.022
HR_REP     : 0.023
IT_PROG    : 0.024
MK_MAN     : 0.025
MK_REP     : 0.025
PR_REP     : 0.026
PU_CLERK   : 0.027
PU_MAN     : 0.027
SA_MAN     : 0.028
SA_REP     : 0.028
SH_CLERK   : 0.029
ST_CLERK   : 0.03
ST_MAN     : 0.03
*/        
SELECT DISTINCT e.job_id
      , CASE e.job_id WHEN 'AC_ACCOUNT' THEN e.salary * 0.02
                      WHEN 'AC_MGR'     THEN e.salary * 0.02
                      WHEN 'AD_ASST'    THEN e.salary * 0.021
                      WHEN 'AD_PRES'    THEN e.salary * 0.021
                      WHEN 'AD_VP'      THEN e.salary * 0.021
                      WHEN 'FI_ACCOUNT' THEN e.salary * 0.022
                      WHEN 'FI_MGR'     THEN e.salary * 0.022
                      WHEN 'HR_REP'     THEN e.salary * 0.023
                      WHEN 'IT_PROG'    THEN e.salary * 0.024
                      WHEN 'MK_MAN'     THEN e.salary * 0.025
                      WHEN 'MK_REP'     THEN e.salary * 0.025
                      WHEN 'PR_REP'     THEN e.salary * 0.026
                      WHEN 'PU_CLERK'   THEN e.salary * 0.027
                      WHEN 'PU_MAN'     THEN e.salary * 0.027
                      WHEN 'SA_MAN'     THEN e.salary * 0.028
                      WHEN 'SA_REP'     THEN e.salary * 0.028
                      WHEN 'SH_CLERK'   THEN e.salary * 0.029
                      WHEN 'ST_CLERK'   THEN e.salary * 0.030
                      WHEN 'ST_MAN'     THEN e.salary * 0.030
                      END AS "���ʽ�"
  FROM employees e
 ORDER BY e.job_id
;

----- (2) cuntries ���̺��� ���� �̸�(country_name)�� ���� ��� ������� ��ȸ�Ͻÿ�
--        ex)  �����̸�    ���
--            argentina   Americas
SELECT c.country_name  "�����̸�"
     , CASE c.region_id WHEN 1 THEN 'Europe'
                        WHEN 2 THEN 'Americas'
                        WHEN 3 THEN 'Asia'
                        WHEN 4 THEN 'Middle East and Africa'
     END "���"
  FROM countries c
 ORDER BY "�����̸�"
;

----- (3) employees ���̺��� �޿� ����� ��ȸ�Ͻÿ�
--        first_name, salary, �޿� ���
SELECT e.first_name "��"
      , e.salary    "�޿�"
      , CASE WHEN e.salary BETWEEN 2000  AND 4000  THEN 1
             WHEN e.salary BETWEEN 4000  AND 6000  THEN 2
             WHEN e.salary BETWEEN 6000  AND 8000  THEN 3
             WHEN e.salary BETWEEN 8000  AND 10000 THEN 4
             WHEN e.salary BETWEEN 10000 AND 20000 THEN 5
             WHEN e.salary BETWEEN 20000 AND 30000 THEN 6
             END "�޿� ���"
  FROM employees e
 ORDER BY e.salary
;

-- 8) ������ �Լ�(�׷��Լ�)
------ 1. GROUP BY
------ 2. HAVING

----- (1) employees ���̺��� ���� id�� ������ ��ȸ�Ͻÿ�
SELECT e.job_id
  FROM employees e
 GROUP BY e.job_id
;

----- (2) employees ���̺��� IT_PROG�� ���� id�� ��ȸ�Ͻÿ�
SELECT e.job_id
  FROM employees e
 GROUP BY e.job_id
HAVING e.job_id = 'IT_PROG'
;
----- (3) employees ���̺��� �Ŵ����� ���� ������ ����� ��ȸ�Ͻÿ�.(NULL�� ����)
SELECT e.manager_id
  FROM employees e
 GROUP BY e.manager_id
HAVING e.manager_id IS NOT NULL
;

------ 3. COUNT(), SUM(), AVG(), MAX(), MIN(), STDDEV(), VARIANCE()

----- (1) employees ���̺��� ���� ���� ��ȸ�Ͽ���
SELECT count(*)
  FROM employees e
;

----- (2) employees ���̺��� ����ID�� PU_CLERK�� ������� ��� �޿��� ��ȸ�Ͻÿ�
--        ����ID(job_id), ��ձ޿� ��ȸ
SELECT e.job_id       "����ID"
      , AVG(e.salary) "��� �޿�"
  FROM employees e
 WHERE e.job_id = 'PU_CLERK'
 GROUP BY e.job_id
;

----- (3) employees ���̺��� �Ŵ����� ���� ������ ����� ����� ������ �þҴ��� ��ȸ�Ͻÿ�.(NULL�� ����)
SELECT e.manager_id "�Ŵ��� ���"
      , COUNT(*) "�Ʒ� ����"
  FROM employees e
 GROUP BY e.manager_id
HAVING e.manager_id IS NOT NULL
;


-- 9) ���� : CARTITION JOIN, EQUI JOIN, NON-EQUI JOIN, OUTER JOIN, SELF JOIN

----- (1) � ������ ����μ����� ���ϴ��� ��ȸ�Ͽ���
--        first_name, department_id, department_name
SELECT e.first_name      "��"
      , e.department_id  "�μ�ID"
      , d.department_name"�μ���"
  FROM employees e, departments d
 WHERE e.department_id = d.department_id
ORDER BY e.department_id
;

----- (2) �� job_id�� �����ϰ� ������, job_title�� �����޿��� ��ȸ�Ͽ���
--        job_id, job_title, start_date, end_date, min_salary ��ȸ.
SELECT j1.job_id      "�۾�ID"
      , j1.job_title  "�۾� ��"
      , j2.start_date "�۾� ������"
      , j2.end_date   "�۾� ������"
      , j1.min_salary "�����޿�"
  FROM jobs j1, job_history j2
 WHERE j1.job_id = j2.job_id
 ORDER BY j2.start_date
;

----- (3) �� ����� ��ġ�� ������ �� ������ ��ȸ�Ͻÿ�.
SELECT r.region_name "���"
      , COUNT(*)     "��ġ�� ����(��)"
  FROM regions r, countries c
 WHERE c.region_id = r.region_id
 GROUP BY r.region_name
;

----- (4) employees ���̺��� �Ŵ����� �ð� �ִ� ������ first_name�� ����� �ð� �ִ��� ��ȸ�Ͽ���
SELECT e1.first_name  "�Ŵ��� �̸�"
      , e2.manager_id "�Ŵ��� ���"
      , COUNT(*)      "�����ϴ� ���(��)"
  FROM employees e1, employees e2
 WHERE e1.employee_id = e2.manager_id
 GROUP BY e2.manager_id, e1.first_name
 ORDER BY COUNT(*) DESC
;

-- 10) ��������

----- (1) �� �������� �ִ� �޿��� �޴� ������ �����Ͻÿ�
SELECT e.employee_id  "����ID"
     , e.first_name   "��"
     , e.job_id       "����ID"
     , e.salary       "�޿�"
  FROM employees e
 WHERE (e.job_id, e.salary) IN (SELECT e.job_id
                                      , MAX(e.salary) max_sal
                                  FROM employees e
                                 GROUP BY  e.job_id)
 ORDER BY e.job_id
;

----- (2) �� �������� �Ի縦 ������ ������ �����Ͻÿ�
SELECT e.job_id       "����ID"
     , e.first_name   "��"
     , e.employee_id  "����ID"
     , e.hire_date    "�Ի���"
  FROM employees e
 WHERE (e.job_id, e.hire_date) IN (SELECT e.job_id
                                        , MIN(e.hire_date)
                                  FROM employees e
                                 GROUP BY  e.job_id)
 ORDER BY e.job_id
;
----- (3) Southlake�� ���� ���� �ִ� ���õ��� ��ȸ�Ͽ���.
--        ���� �̸�, �����̸�, ��ġ�� �Ÿ� ��ȸ
SELECT l.city           "����"
      , l.country_id    "��ġ�� ����"
      , l.street_address"�ּ�"
  FROM locations l
 WHERE l.country_id = (SELECT l.country_id
                         FROM locations l
                        WHERE l.city = 'Southlake')
;
