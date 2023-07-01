begin
for r in (select table_name 
        from user_tables
        where table_name in ('ALLCODE','APPRVRQD','APPTX', 'AREAS', 'BANK',
            'BRGRP','CSTB_RPT_TERM_DEFN','DEFERROR','FILEMAP','FILEMASTER','FLDMASTER','FOCMDCODE','FOCMDMENU',
            'GRMASTER','MEMBERS','OBJMASTER','RPTFIELDS','RPTMASTER','RPTSUBS','SBBATCHCTL','SBCLDR','TLOGLEVEL',
            'SYSVAR','TBLBACKUP','TEMPLATES','TLGROUPS','TLGRPUSERS','TLOGDEBUG','TLPROFILES','TLTX','TLTXWF',
            'APIAUTHDEF','APIDEF', 'CMDAUTH'
            /*,
            'ISSUERS', 'BUYOPTION', 'SELLOPTION', 'INTSCHD', 'PAYMENT_SCHD',
            'ASSETDTL', 'SBSEDEFACCT', 'PRODUCT', 'PRODUCTBUYDTL', 'PRODUCTSELLDTL',
            'SALE_GROUPS','COMMISSION','SALE_RETYPE','FEEAPPLY','SALE_ROLES', 'CFMAST',
            'USERLOGIN','AFMAST','SALE_MANAGERS','AGENCY','SALE_CUSTOMERS',
            'CFAUTH','CFCONTACT','CFMASTER','CFMASTINVEST','CFSIGN',
            'FEETYPE','FEEVAR','FUND','REINVEST_RATE', 'LIMITS','REINVEST_RATE_DTL'*/
            )
        order by table_name)
loop
    dbms_output.put_line('create table '||r.table_name||'_39bk_20210912 as select * from '||r.table_name||'@shb39;');
    --dbms_output.put_line('delete from '||r.table_name||';');
end loop;
end;


begin
for r in (select table_name 
        from user_tables
        where table_name like 'FOCMDMENU_BK%'
        order by table_name)
loop
    dbms_output.put_line('create table '||r.table_name||'_39bk as select * from '||r.table_name||'@shb39;');
    --dbms_output.put_line('delete from '||r.table_name||';');
end loop;
end;