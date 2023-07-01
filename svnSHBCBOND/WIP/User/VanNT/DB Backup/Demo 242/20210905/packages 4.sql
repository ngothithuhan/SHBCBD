DROP TYPE numbers_t
/

CREATE OR REPLACE 
TYPE numbers_t AS TABLE OF NUMBER
/

DROP TYPE simplestringarraytype
/

CREATE OR REPLACE 
TYPE simplestringarraytype AS TABLE OF VARCHAR2(32767)
/

DROP TYPE ty_arr
/

CREATE OR REPLACE 
TYPE ty_arr AS VARRAY(10) OF VARCHAR2(10)
/

DROP TYPE ty_column_oj
/

CREATE OR REPLACE 
TYPE ty_column_oj is object(
    rid number,
    col_type varchar2(255),
    col_name varchar2(50), 
    col_mas  varchar2(4000), 
    char_value varchar2(4000))
/

DROP TYPE ty_pivot_tb
/

CREATE OR REPLACE 
TYPE ty_pivot_tb is table of ty_column_oj
/

