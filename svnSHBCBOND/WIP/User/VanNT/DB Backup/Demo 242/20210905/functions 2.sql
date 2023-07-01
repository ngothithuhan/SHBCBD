DROP FUNCTION fnc_chuyen_font
/

CREATE OR REPLACE 
FUNCTION fnc_chuyen_font (v_IN IN Varchar2) Return Varchar2 is

   Cursor c_Font(v_prtype varchar2) is
   Select PRNAME from font_param where prtype=v_prtype;
   v_FontTV varchar2(1000);
   v_FontTA varchar2(1000);
   v_FontTV2 varchar2(1000);
   v_FontTA2 varchar2(1000);
   i number;
   j number;
   v_Kq1 varchar2(1000);
   v_Kq2 varchar2(1000);
   v_result varchar2(1000);

   BEGIN
    Open c_Font('SMSFONTTV1');
    Fetch c_Font into v_FontTV;
    Close c_Font;

    Open c_Font('SMSFONTTA1');
    Fetch c_Font into v_FontTA;
    Close c_Font;
    v_Kq1:=v_In;
    For i in 1..length(v_In)
    Loop
       For j in 1..Length(v_FontTV)
       Loop
         If substr(V_IN,i,1)=substr(v_FontTV,j,1) Then
          v_Kq1:=Replace(v_Kq1,substr(v_FontTV,j,1),substr(v_FontTA,j,1));
         End if;
       End Loop;
      -- v_result :=v_Kq;
    End loop;

    dbms_output.put_line('v_Kq1'||v_Kq1);
    Open c_Font('SMSFONTTV2');
    Fetch c_Font into v_FontTV2;
    Close c_Font;

    Open c_Font('SMSFONTTA2');
    Fetch c_Font into v_FontTA2;
    Close c_Font;
    v_Kq2:=v_Kq1;
    For i in 1..length(v_Kq1)
    Loop
       For j in 1..Length(v_FontTV2)
       Loop
         If substr(v_Kq1,i,2)=substr(v_FontTV2,j,2) Then
         dbms_output.put_line('So sanh '||substr(v_Kq1,i,2)||' Thay the '||substr(v_FontTA2,j,2));
          v_Kq2:=Replace(v_Kq2,substr(v_FontTV2,j,2),Trim(substr(v_FontTA2,j,2)));
         End if;
       End Loop;
      --v_result :=v_Kq2;
    End loop;
    v_result :=v_Kq2;
    Return v_result;

    Exception when others then
    v_Kq2:=Null;

    Return v_Kq2;

    END;
/

DROP FUNCTION fnc_duedate_termcd
/

CREATE OR REPLACE 
FUNCTION fnc_duedate_termcd (p_date DATE, p_termcd VARCHAR2) RETURN DATE
IS
v_return DATE;
v_last VARCHAR2(10);
v_first VARCHAR2(10);
v_twofirst VARCHAR2(20);
v_monthofquarter VARCHAR2(20);
v_termcd VARCHAR2(10);
v_pos NUMBER;
v_year NUMBER;
v_month NUMBER;
v_day NUMBER;
BEGIN
    v_termcd := upper(p_termcd);
    --Ngay va thang hi?n t?i
    SELECT EXTRACT(year FROM p_date) into v_year from dual;
    SELECT EXTRACT(month FROM p_date) into v_month from dual;
    SELECT EXTRACT(day FROM p_date) into v_day from dual;
    
    v_first := substr(v_termcd,1,1);
    v_twofirst := substr(v_termcd,1, 2);
    IF v_first='D' THEN
        v_last := substr(v_termcd,2);
        v_return := TO_DATE(v_last || '/' || to_char(v_month) || '/' || to_char(v_year),'DD/MM/YYYY');
    ELSIF v_twofirst='MD' THEN
        v_last := substr(v_termcd,3);
        v_return := TO_DATE(v_last || '/' || to_char(v_month) || '/' || to_char(v_year),'DD/MM/YYYY');
    ELSIF v_twofirst='QM' THEN
        --Thang nao trong quy
        v_pos := instr(v_termcd, 'D');
        v_monthofquarter := substr(v_termcd,v_pos-1,1); --Thang th? m?y
        v_last := substr(v_termcd,v_pos+1); --Ngay nao trong thang
        --Ch? x? ly cho thang ??u quy
        IF v_month=1 or v_month=4 or v_month=7 or v_month=10 THEN
            v_month := v_month-1 + to_number(v_monthofquarter);
            v_return := TO_DATE(v_last || '/' || to_char(v_month) || '/' || to_char(v_year),'DD/MM/YYYY');
        else
            v_return := p_date;
        end if;    
    ELSE
        v_return := p_date;
    END IF;
    RETURN v_return;
END;
/

DROP FUNCTION fnc_font
/

CREATE OR REPLACE 
FUNCTION fnc_font (v_IN IN Varchar2) Return Varchar2 is

   v_FontTV varchar2(500):='aa???a?????a?????ee???e?????ii??ioo???o?????o?????uu??uu??????y???dAA???A?????A?????EE???E?????II??IOO???O?????O?????UU??UU??????Y????';
   v_FontTA varchar2(500):='aaaaaaaaaaaaaaaaaeeeeeeeeeeeiiiiiooooooooooooooooouuuuuuuuuuuyyyyydAAAAAAAAAAAAAAAAAEEEEEEEEEEEIIIIIOOOOOOOOOOOOOOOOOUUUUUUUUUUUYYYYYD';
   i number;
   j number;
   v_Kq varchar2(500);
   v_result varchar2(500);
   
   BEGIN
    v_Kq:=v_In;
    For i in 1..length(v_In)
    Loop
       For j in 1..Length(v_FontTV)
       Loop
         If substr(V_IN,i,1)=substr(v_FontTV,j,1) Then
          v_Kq:=Replace(v_Kq,substr(v_FontTV,j,1),substr(v_FontTA,j,1));
         End if;
       End Loop;
       v_result :=v_Kq;
    End loop;
    Return v_result;

    Exception when others then
    v_Kq:=Null;
    return null;

    END;
/

DROP FUNCTION fnc_geterrmsg
/

CREATE OR REPLACE 
FUNCTION fnc_geterrmsg (p_ErrCode VARCHAR2)   RETURN VARCHAR2
    AS
    --Ham lay noi dung loi.
    v_Result varchar2(1000);
    BEGIN


      FOR i IN (SELECT errdesc FROM deferror WHERE errnum = p_ErrCode)
      LOOP
        v_Result:= i.errdesc;
      END LOOP;

      RETURN v_Result;


 EXCEPTION WHEN OTHERS THEN

      RETURN NULL;

 END;
/

DROP FUNCTION fnc_getsysstatus
/

CREATE OR REPLACE 
FUNCTION fnc_getsysstatus 
  RETURN varchar2 IS
   v_status VARCHAR2(10);
BEGIN


SELECT varvalue  INTO v_status
FROM SYSVAR
WHERE GRNAME = 'SYSTEM' AND VARNAME ='HOSTATUS';

RETURN v_status;
EXCEPTION
   WHEN OTHERS THEN
    RETURN '0';
END;
/

DROP FUNCTION fnc_hienthisodu
/

CREATE OR REPLACE 
FUNCTION fnc_hienthisodu (P_ACCTNO VARCHAR2,SO_DUGLMAST NUMBER)
RETURN varchar2
as
V_RESULT VARCHAR2(1);
BEGIN
  V_RESULT := 'C';
  IF substr(P_ACCTNO,0,1) in ('1','2','6','8')  THEN 
    V_RESULT := 'D';
    if P_ACCTNO = '131' and SO_DUGLMAST >0 then V_RESULT := 'C' ;
    end if;
  end if;   
   -- hien thi ben no
  
RETURN V_RESULT;
EXCEPTION WHEN OTHERS THEN
    V_RESULT := '';

END;
/

DROP FUNCTION fnc_is_number
/

CREATE OR REPLACE 
FUNCTION fnc_is_number (p_string IN VARCHAR2)
   RETURN INT
IS
   v_new_num NUMBER;
BEGIN
   v_new_num := TO_NUMBER(p_string);
   RETURN 1;
EXCEPTION
WHEN VALUE_ERROR THEN
   RETURN 0;
END fnc_is_number;

--Xac ??nh duedate
/

DROP FUNCTION fnc_map_account
/

CREATE OR REPLACE 
FUNCTION fnc_map_account (p_codeid VARCHAR2, p_subcd VARCHAR2 , p_refcd VARCHAR2, p_alias varchar2) RETURN VARCHAR
IS
BEGIN
RETURN p_codeid || '.' || p_subcd || '.' || p_refcd || '.' || p_alias;
END;
/

DROP FUNCTION fnc_map_contributeschd
/

CREATE OR REPLACE 
FUNCTION fnc_map_contributeschd (p_termcd VARCHAR2, p_subtermcd VARCHAR2, p_day VARCHAR2) RETURN VARCHAR2
IS
BEGIN
    IF UPPER(p_termcd)='Q' THEN
        RETURN lower(p_termcd || p_subtermcd || 'd' || p_day);
    ELSE
        RETURN lower(p_termcd || 'd' || p_day);
    END IF;
END;
/

DROP FUNCTION fnc_map_termcd
/

CREATE OR REPLACE 
FUNCTION fnc_map_termcd (p_termcd VARCHAR2, p_subcd VARCHAR2, p_day VARCHAR2) RETURN VARCHAR
IS
v_return VARCHAR2(100);
BEGIN
    v_return := '';
    IF p_termcd='M' THEN
        v_return := 'md' || p_day;
    ELSIF p_termcd='Q' THEN
        v_return := p_termcd || p_subcd || 'd' || p_day;
    END IF;
    RETURN LOWER(v_return);
END;

--Ki?m tra tr??ng s?
/

DROP FUNCTION fnc_sid_getchkdigit
/

CREATE OR REPLACE 
FUNCTION fnc_sid_getchkdigit 
 RETURN varchar2
 IS


    v_Result varchar(50);

BEGIN
      v_Result:= Trunc(dbms_random.value(10,99));
      --SELECT floor(dbms_random.value*(99-10+1))+10 str INTO v_Result FROM dual;

      RETURN v_Result;

Exception
When others then
    return '-1';
END

;
/

DROP FUNCTION fnc_sid_getsid
/

CREATE OR REPLACE 
FUNCTION fnc_sid_getsid (p_custid varchar2)
 RETURN varchar2
 IS


    v_Result varchar(50);

BEGIN
    FOR i IN (SELECT custid, custodycd, custtype, grinvestor, TradingDate, iddate FROM cfmast WHERE custid  = p_CustID union all SELECT custid, custodycd, custtype, grinvestor, TradingDate, iddate FROM cfmast_temp WHERE custid  = p_CustID)
      LOOP
        --1. 2 ky tu dau
        IF i.custtype ='CN' THEN
            v_Result:='ID';
        ELSE
            v_Result:='CP';
        END IF;
        --2. 1 ky tu tiep theo: 3
        IF i.grinvestor  ='TN' THEN
            v_Result:=v_Result||'D';
        ELSE
           v_Result:=v_Result||'F';
        END IF;
        --3. Ky tu 4->7
        IF i.grinvestor  ='NN' THEN
            --3.1 Neu nuoc ngoai la TradingDate.
            v_Result:=v_Result||coalesce(to_char(i.TradingDate,'DDMM'),'xxxx');
        ELSE
            --3.2 Neu trong nuoc la IDDATE.
            v_Result:=v_Result||coalesce(to_char(i.iddate,'DDMM'),'xxxx');
        END IF;
        --4.Ky tu 8-13
           v_Result:=v_Result||LPAD(seq_cfmaster.nextval,6,'0');

      END LOOP;
        --5.Check Digit 14-->15:
        v_Result:=v_Result|| fnc_sid_getCHKDIGIT();
      RETURN v_Result;

Exception
When others then
    return '-1';
END

;
/

DROP FUNCTION genencryptpassword
/

CREATE OR REPLACE 
FUNCTION genencryptpassword (input_string varchar2)
 RETURN varchar2
    is
    hash_value varchar2(100);
    hash_value_str varchar2(100);

BEGIN
    if input_string is null then
        return input_string;
    end if;

    hash_value_str := rawtohex(
    DBMS_CRYPTO.Hash (
        UTL_I18N.STRING_TO_RAW (input_string, 'AL32UTF8'),
        2)
    );
    hash_value := lower(hash_value_str);

    return hash_value;
EXCEPTION
    WHEN others THEN -- caution handles all exceptions
        --PERFORM plog.error('genencryptpassword: Error:=' || SQLERRM||SQLSTATE);
        return input_string;
END genencryptpassword;
/

DROP FUNCTION generate_series
/

CREATE OR REPLACE 
FUNCTION generate_series(minnumber INTEGER, maxnumber INTEGER)
   RETURN numbers_t
   PIPELINED
   DETERMINISTIC
IS
BEGIN
   FOR i IN minnumber .. maxnumber LOOP
      PIPE ROW (i);
   END LOOP;
   RETURN;
END;
/

DROP FUNCTION get_nextday_work
/

CREATE OR REPLACE 
FUNCTION get_nextday_work(p_frdate date, p_days number)
 RETURN date

AS

   l_date  date;
BEGIN

    select sbdate into l_date
    from (
    select sbdate, row_number() over (order by sbdate) as seqnum
    from sbcldr where holiday = 'N'
    and sbdate >= p_frdate
    ) a
    where  seqnum =  p_days;

    RETURN l_date;

exception
  when others then
    return null;-- ban dau return -1, nhung
end;
/

DROP FUNCTION get_preday_work
/

CREATE OR REPLACE 
FUNCTION get_preday_work(p_frdate date, p_days number)
 RETURN date

AS

   l_date  date;
BEGIN
    select sbdate into l_date
    from (
    select rownum stt, sbdate
    from (
    select sbdate
    from sbcldr where holiday = 'N'
    and sbdate < p_frdate
    ORDER BY sbdate desc
    ) a)
    where  p_days = stt;

    RETURN l_date;

exception
  when others then
    return null;-- ban dau return -1, nhung
end;
/

DROP FUNCTION getcurrdate
/

CREATE OR REPLACE 
FUNCTION getcurrdate 
  RETURN DATE IS
   getdate  DATE;
BEGIN
    
SELECT TO_DATE(VARVALUE,'DD/MM/YYYY') CURRDATE INTO getdate 
FROM SYSVAR 
WHERE GRNAME = 'SYSTEM' AND VARNAME ='CURRDATE';

RETURN getdate;
EXCEPTION
   WHEN OTHERS THEN
    RETURN SYSDATE;
END;
/

DROP FUNCTION json_create_value_node
/

CREATE OR REPLACE 
FUNCTION json_create_value_node (
    field IN varchar2,
    value IN varchar2,
    isString IN integer default 1
    )
RETURN varchar2 IS
  pOut varchar2(30000) := '';
  pIsString boolean;
BEGIN
  pIsString := sys.diutil.int_to_bool(isstring);
    pOut := pOut || '"' || field || '":';
    IF pIsString THEN
        pOut := pOut || '"' || value || '"';
    ELSE
        pOut := pOut || value;
    END IF;
    pOut := pOut || '';
   RETURN pOut;
END;
/

DROP FUNCTION get_report_parameters
/

CREATE OR REPLACE 
FUNCTION get_report_parameters (
  p_rptid IN varchar2,
  p_rptparam IN VARCHAR2,
  p_tlid IN VARCHAR2,
  returnValueAsObject IN integer DEFAULT 0
  )
RETURN varchar2 IS
  isReturnValueAsObject boolean := sys.diutil.int_to_bool(returnValueAsObject);
  l_rptparam varchar2(1000);
  i NUMBER;
  v_count    NUMBER;
  params txpks_notify.str_array;

  pOut varchar2(30000) := '{';
  NODE_HEADOFFICE varchar2(200);
  v_HEADOFFICE varchar2(200);
  NODE_HEADOFFICE_ADDRESS VARCHAR2(500);
  v_HEADOFFICE_ADDRESS VARCHAR2(500);
  NODE_HEADOFFICE_CONTACT VARCHAR2(500);
  v_HEADOFFICE_CONTACT VARCHAR2(500);
  NODE_FROM_DATE varchar2(200);
  v_FROM_DATE varchar2(200);
  NODE_TO_DATE varchar2(200);
  v_TO_DATE varchar2(200);
  NODE_REPORT_TTILE varchar2(200);
  v_REPORT_TTILE varchar2(200);
  NODE_REPORT_CRITERIAS_TXT varchar2(1000);
  v_REPORT_CRITERIAS_TXT varchar2(1000);
  NODE_CREATED_DATE varchar2(200);
  v_CREATED_DATE varchar2(200);
  NODE_CREATED_BY varchar2(200);
  v_CREATED_BY varchar2(200);

BEGIN
  SELECT varvalue INTO v_HEADOFFICE FROM SYSVAR WHERE VARNAME = 'HEADOFFICE';
  SELECT varvalue INTO v_HEADOFFICE_ADDRESS FROM SYSVAR WHERE VARNAME = 'BRADDRESS';
  SELECT varvalue INTO v_HEADOFFICE_CONTACT FROM SYSVAR WHERE VARNAME = 'BRPHONEFAX';
  SELECT to_char(getcurrdate,'dd/mm/rrrr') INTO v_CREATED_DATE FROM dual;

  SELECT COUNT(*) INTO v_count FROM rptmaster WHERE rptid = p_rptid;
  BEGIN
    IF v_count > 0 THEN
       SELECT description INTO v_REPORT_TTILE FROM rptmaster WHERE rptid = p_rptid;
    ELSE
       SELECT note INTO v_REPORT_TTILE FROM rptlog_map WHERE objname = p_rptid;
    END IF;
  EXCEPTION WHEN OTHERS THEN
    v_REPORT_TTILE := '';
  END;

  BEGIN
    SELECT fullname INTO v_CREATED_BY FROM
    (SELECT fullname FROM cfmast WHERE custid = p_tlid
    UNION ALL
    SELECT tlname fullname FROM tlprofiles WHERE tlid = p_tlid);
  EXCEPTION WHEN OTHERS THEN
    v_CREATED_BY := '';
  END;

  l_rptparam := replace(p_rptparam,'''','');
  params := txpks_notify.split(l_rptparam, ',');

  --HEAD OFFICE
  NODE_HEADOFFICE := JSON_CREATE_VALUE_NODE('HEADOFFICE',v_HEADOFFICE);
  pOut := pOut || NODE_HEADOFFICE || ',';
  --HEADOFFICE_ADDRESS
  NODE_HEADOFFICE_ADDRESS := JSON_CREATE_VALUE_NODE('HEADOFFICE_ADDRESS',v_HEADOFFICE_ADDRESS);
  pOut := pOut || NODE_HEADOFFICE_ADDRESS || ',';
  --HEADOFFICE_CONTACT
  NODE_HEADOFFICE_CONTACT := JSON_CREATE_VALUE_NODE('HEADOFFICE_CONTACT',v_HEADOFFICE_CONTACT);
  pOut := pOut || NODE_HEADOFFICE_CONTACT || ',';
  --REPORT_TTILE
  NODE_REPORT_TTILE := JSON_CREATE_VALUE_NODE('REPORT_TITLE',v_REPORT_TTILE);
  pOut := pOut || NODE_REPORT_TTILE || ',';
  --CREATED_DATE
  NODE_CREATED_DATE := JSON_CREATE_VALUE_NODE('CREATED_DATE',v_CREATED_DATE);
  pOut := pOut || NODE_CREATED_DATE || ',';
  --CREATED_BY
  NODE_CREATED_BY := JSON_CREATE_VALUE_NODE('CREATED_BY',v_CREATED_BY);
  pOut := pOut || NODE_CREATED_BY || ',';

  IF upper(p_rptid) = 'OD0019' THEN
    --FROM DATE, TO DATE
    v_from_date := params(1);
    v_to_date := params(2);
    --REPORT_CRITERIAS_TXT
    FOR rec IN (SELECT * FROM rptfields r WHERE objname = 'OD0019' AND r.visible = 'Y'
      AND r.fldname NOT IN ('F_DATE','T_DATE') ORDER BY r.odrnum)
    LOOP
      i := 3;
      v_REPORT_CRITERIAS_TXT := v_REPORT_CRITERIAS_TXT||rec.caption||': '||params(i)||'\r\n';
      i := i+1;
    END LOOP;
    node_from_date := JSON_CREATE_VALUE_NODE('FROM_DATE', v_from_date);
    node_to_date := JSON_CREATE_VALUE_NODE('TO_DATE', v_to_date);
    NODE_REPORT_CRITERIAS_TXT := JSON_CREATE_VALUE_NODE('REPORT_CRITERIAS_TXT', v_REPORT_CRITERIAS_TXT);
    pOut := pOut || node_from_date || ',';
    pOut := pOut || node_to_date || ',';
    pOut := pOut || NODE_REPORT_CRITERIAS_TXT || ',';
  END IF;

  IF upper(p_rptid) = 'OD0040' THEN
    --FROM DATE, TO DATE
    v_from_date := params(1);
    v_to_date := params(2);
    node_from_date := JSON_CREATE_VALUE_NODE('FROM_DATE', v_from_date);
    node_to_date := JSON_CREATE_VALUE_NODE('TO_DATE', v_to_date);
    pOut := pOut || node_from_date || ',';
    pOut := pOut || node_to_date || ',';
  END IF;

  IF upper(p_rptid) = 'OD0080' THEN
    --FROM DATE, TO DATE
    v_from_date := params(2);
    v_to_date := params(3);
    node_from_date := JSON_CREATE_VALUE_NODE('FROM_DATE', v_from_date);
    node_to_date := JSON_CREATE_VALUE_NODE('TO_DATE', v_to_date);
    pOut := pOut || node_from_date || ',';
    pOut := pOut || node_to_date || ',';
  END IF;

  pOut := SUBSTR(pOut,1, LENGTH(pOut) - 1) || '}';
  IF NOT isReturnValueAsObject THEN
    pOut := REPLACE(pOut, '"', '\"');
    pOut := '"' || pOut || '"';
  END IF;
   RETURN pOut;
END;
/

DROP FUNCTION get_workdate
/

CREATE OR REPLACE 
FUNCTION get_workdate(p_frdate date)
 RETURN date

AS

   l_date  date;
   l_count number;
BEGIN
    select count(1) into l_count
    from sbcldr
    where sbdate = p_frdate
        and holiday = 'N';
        
    if l_count > 0 then
        return p_frdate;
    else
        select min(sbdate) into l_date
        from sbcldr 
        where holiday = 'N'
        and sbdate >= p_frdate;
    end if;

    RETURN l_date;

exception
  when others then
    return null;-- ban dau return -1, nhung
end;
/

DROP FUNCTION getavlsewithdraw
/

CREATE OR REPLACE 
FUNCTION getavlsewithdraw (p_acctno varchar2)
 RETURN number
 
as
    
        l_result number;
    BEGIN
        select nvl(greatest(trade,0) - greatest(secured,0), 0)
        into l_result
        from semast
        where acctno = p_acctno;
    
        return l_result;
        END;
/

DROP FUNCTION getdayofmonth
/

CREATE OR REPLACE 
FUNCTION getdayofmonth 
  ( busdate IN DATE,
    P_CODEID IN CHAR,
    P_DAY IN VARCHAR2,
    P_RULE IN VARCHAR2
  )
  RETURN  DATE IS
   l_day VARCHAR2(100);
   duedate  DATE;
   v_err varchar2(200);
  pkgctx   plog.log_ctx:= plog.init ('fn',
                 plevel => 30,
                 plogtable => true,
                 palert => false,
                 ptrace => false);
   logrow   tlogdebug%ROWTYPE;
BEGIN
 
  IF P_RULE = 'N' THEN
    
       SELECT MIN(SBDATE)
        INTO duedate
        FROM SBCLDR SB
        WHERE 
         SB.SBDATE >= TO_DATE((P_DAY||'/'||TO_CHAR(to_date(busdate,'DD/MM/RRRR'),'MM/RRRR')),'DD/MM/RRRR')
        AND SB.CLDRTYPE = P_CODEID
        AND SB.HOLIDAY = 'N';
        --plog.error(pkgctx,'P_DAY: '||P_DAY || 'busdate: ' ||busdate || 'P_CODEID: '||P_CODEID);
        --plog.error(pkgctx,'duedate: '||duedate);
          
   ELSE
        SELECT MAX(SBDATE)
        INTO duedate
        FROM SBCLDR SB
        WHERE SB.SBDATE > busdate
        --AND TO_CHAR(busdate,'DD') < TO_CHAR(SB.SBDATE,'DD')
        AND TO_CHAR(SB.SBDATE,'DD') <= TO_DATE((P_DAY||'/'||TO_CHAR(to_date(busdate,'DD/MM/RRRR'),'MM/RRRR')),'DD/MM/RRRR')
        AND SB.CLDRTYPE = P_CODEID
        AND SB.HOLIDAY = 'N';
   END IF;

  RETURN duedate ;

EXCEPTION when others then
   v_err:=substr(sqlerrm,1,199);
       RETURN '01-JAN-2000';
END;
/

DROP FUNCTION getdayofweek
/

CREATE OR REPLACE 
FUNCTION getdayofweek 
  ( busdate IN DATE,
    CODEID IN CHAR,
    NEXTDAY IN NUMBER
  )
  RETURN  DATE IS
   l_day VARCHAR2(100);
   duedate  DATE;
   v_err varchar2(200);

BEGIN

  -- Ham lay ra ngay theo theo th?
  IF NEXTDAY = 2 THEN
    l_day := 'MONDAY';
  ELSIF NEXTDAY = 3 THEN
    l_day := 'TUESDAY';
  ELSIF NEXTDAY = 4 THEN
    l_day := 'WEDNESDAY';
  ELSIF NEXTDAY = 5 THEN
    l_day := 'THURSDAY';
  ELSIF NEXTDAY = 6 THEN
    l_day := 'FRIDAY';
  ELSIF NEXTDAY = 7 THEN
    l_day := 'SATURDAY';
  ELSIF NEXTDAY = 8 THEN
    l_day := 'SUNDAY';
  END IF;

    SELECT MIN(SBDATE) INTO DUEDATE FROM SBCLDR SB
   WHERE SB.SBDATE > TO_DATE(busdate,'DD/MM/RRRR')
   AND TRIM(TO_CHAR(SB.SBDATE,'DAY')) = l_day
   AND sb.cldrtype = CODEID;
   
    RETURN duedate ;

EXCEPTION when others then
   v_err:=substr(sqlerrm,1,199);
       RETURN '01-JAN-2000';
END;
/

DROP FUNCTION getduedate
/

CREATE OR REPLACE 
FUNCTION getduedate (busdate IN DATE,
    clearcd IN VARCHAR2,
    tradeplace IN CHAR,
    clearday IN NUMBER,
    tradingtype IN VARCHAR2)
  RETURN  DATE IS

   duedate  DATE;
   v_err varchar2(200);

BEGIN

if tradingtype = 'SIP' THEN
    IF clearday=0 THEN
        duedate:=busdate;
    Elsif clearday < 0 THEN
        --SELECT MAX(SB.SBDATE) INTO duedate FROM sbcldr sb WHERE sb.cldrtype = tradeplace AND sb.sbdate <= TO_DATE(busdate - 1,'DD/MM/RRRR')  AND sb.Sip = 'Y';
            SELECT SBDATE INTO duedate
                FROM (SELECT ROWNUM DAY, SBDATE
                FROM (SELECT * FROM SBCLDR WHERE CLDRTYPE=tradeplace/*'000'*/ AND SBDATE < busdate AND SIP='Y' ORDER BY SBDATE DESC) CLDR) RL
                WHERE DAY=-clearday;                    
    ELSE
        IF  clearcd='B' THEN
            SELECT SBDATE INTO duedate
                FROM (SELECT ROWNUM DAY, SBDATE
                FROM (SELECT * FROM SBCLDR WHERE CLDRTYPE=tradeplace/*'000'*/ AND SBDATE>busdate AND SIP='Y' ORDER BY SBDATE) CLDR) RL
                WHERE DAY=clearday;
        ELSE
            SELECT SBDATE INTO duedate
                FROM (SELECT ROWNUM DAY, SBDATE
                FROM (SELECT * FROM SBCLDR WHERE CLDRTYPE=tradeplace/*'000'*/ AND SBDATE>busdate ORDER BY SBDATE) CLDR) RL
                WHERE DAY=clearday;
        END IF;
    END IF;
ELSE
    IF clearday=0 THEN
        duedate:=busdate;
    Elsif clearday < 0 THEN
        --SELECT MAX(SB.SBDATE) INTO duedate FROM sbcldr sb WHERE sb.cldrtype = tradeplace AND sb.sbdate <= TO_DATE(busdate - 1,'DD/MM/RRRR')  AND sb.holiday = 'N';
        SELECT SBDATE INTO duedate
                FROM (SELECT ROWNUM DAY, SBDATE
                FROM (SELECT * FROM SBCLDR WHERE CLDRTYPE=tradeplace/*'000'*/ AND SBDATE < busdate AND HOLIDAY='N' ORDER BY SBDATE DESC) CLDR) RL
                WHERE DAY=-clearday;                    
    ELSE
        IF  clearcd='B' THEN
            SELECT SBDATE INTO duedate
                FROM (SELECT ROWNUM DAY, SBDATE
                FROM (SELECT * FROM SBCLDR WHERE CLDRTYPE=tradeplace/*'000'*/ AND SBDATE>busdate AND HOLIDAY='N' ORDER BY SBDATE) CLDR) RL
                WHERE DAY=clearday;
        ELSE
            SELECT SBDATE INTO duedate
                FROM (SELECT ROWNUM DAY, SBDATE
                FROM (SELECT * FROM SBCLDR WHERE CLDRTYPE=tradeplace/*'000'*/ AND SBDATE>busdate ORDER BY SBDATE) CLDR) RL
                WHERE DAY=clearday;
        END IF;
    END IF;
END IF;

    RETURN duedate ;
/*
If busdate ='26-JUN-2009' then
    RETURN '01-JUL-2009';
Else
    RETURN '02-JUL-2009';
END if;
*/
EXCEPTION when others then
   v_err:=substr(sqlerrm,1,199);
       RETURN '01-JAN-2000';
END;
/

DROP FUNCTION getnextdate
/

CREATE OR REPLACE 
FUNCTION getnextdate (f_indate varchar2)
return varchar2
-------------------------------------------------
-----Lay ngay lam viec tiep theo-----------------
-------------------------------------------------
is
    v_nextwrkdate varchar2(10);
begin
    select to_char(min(sbdate),'DD/MM/RRRR') into v_nextwrkdate from sbcldr where sbdate>to_date(f_indate,'DD/MM/RRRR') and holiday='N' and cldrtype='000';
    return v_nextwrkdate;
exception
when others then
return f_indate;
end;
/

DROP FUNCTION getprevdate
/

CREATE OR REPLACE 
FUNCTION getprevdate (p_date date, p_prevnum number)
return date
is
l_prevdate date;
begin
    /*select min(sbdate)
        into l_prevdate
    from (
             select sb.sbdate from sbcldr sb
             where sb.cldrtype = '000' and sb.holiday = 'N' and sb.sbdate <= p_date
             order by sb.sbdate desc)
     where rownum <= p_prevnum;
     return l_prevdate;*/
     -- SUA THEO CACH CUA GIANHVG -- 12-MAR-2012
     select sbdate into l_prevdate from sbcurrdate where numday=(
        select numday from sbcurrdate
        where sbdate= p_date and sbtype='B'
        ) - p_prevnum + 1
    and sbtype='B';
    return l_prevdate;
exception when others then
return p_date;
end;
/

DROP FUNCTION getyesno
/

CREATE OR REPLACE 
FUNCTION getyesno 
  ( val IN varchar2,
    lang IN varchar2)
  RETURN  varchar2 IS
--
-- To modify this template, edit file FUNC.TXT in TEMPLATE
-- directory of SQL Navigator
--
-- Purpose: Briefly explain the functionality of the function
--
-- MODIFICATION HISTORY
-- Person      Date    Comments
-- ---------   ------  -------------------------------------------

   -- Declare program variables as shown above
BEGIN
    if (val = 'Y') then
        if (lang = 'en') then return 'Yes'; end if;
        if (lang = 'vi') then return 'Có'; end if;
    end if;
    if (val = 'N') then
        if (lang = 'en') then return 'No'; end if;
        if (lang = 'vi') then return 'Không'; end if;
    end if;
    return val;
EXCEPTION
   WHEN others THEN
       return val ;
END;
/

DROP FUNCTION is_number
/

CREATE OR REPLACE 
FUNCTION is_number (str in varchar2) return varchar2 IS
dummy number;
begin
dummy := TO_NUMBER(str);
IF (DUMMY  IS null) THEN
    RETURN ('FALSE');
END IF;
return ('TRUE');
Exception WHEN OTHERS then
return ('FALSE');
end;
/

DROP FUNCTION left_
/

CREATE OR REPLACE 
FUNCTION left_ (str varchar2, num number)
 RETURN varchar2
 
AS
        
begin
    RETURN SUBSTR(str, 1, num);
end;
/

DROP FUNCTION is_string_in_careby
/

CREATE OR REPLACE 
FUNCTION is_string_in_careby (str varchar2, p_tlid varchar2)
 RETURN number
as      tem varchar2(50);
        rs number;
        ss varchar2(50);
-- created by Phong.Do
-- Kiem tra xem 1 tai khoan 
begin
    rs:=0;
    ss:=str;
    IF (p_tlid = fn_systemnums('systemnums.C_ADMIN_ID')) THEN
        RETURN 1;
    END IF;
    while (length(ss)<>0) loop
        tem:=left_(ss, 10);
        ss:=substr(ss,12, length(str));
        select CASE WHEN (tem in (select c.custodycd 
                        from cfmast c 
                            inner join tlgrpusers t 
                            on c.careby = t.grpid 
                        where t.tlid= (case when p_tlid = 'ALL' or p_tlid = fn_systemnums('systemnums.C_ADMIN_ID') then t.tlid else p_tlid end)
                        )
                ) THEN 1 ELSE 0 end into rs FROM dual;
        if rs=1 then return rs; end if;
    end loop;
    return rs;
end;
/

DROP FUNCTION isdate
/

CREATE OR REPLACE 
FUNCTION isdate (p_str IN VARCHAR2)
  RETURN  VARCHAR2 IS
-- ThangNV: Function to check a field is date or not
-- 30/09/2013
-- Cap nhat lai 24/10/2013: Chuyen lai dinh dang 'DD/MM/RRRR'
-- ---------   ------  -------------------------------------------
  p_date DATE;
BEGIN
    p_date := to_date(p_str,'DD/MM/RRRR') ;
    RETURN 'Y' ;
EXCEPTION
   WHEN others THEN
    RETURN 'N' ;
END isdate;
/

DROP FUNCTION isnumber
/

CREATE OR REPLACE 
FUNCTION isnumber (p_str IN varchar2)
  RETURN  VARCHAR2 IS
-- ThangNV: Function to check a field is number or not
-- 30/09/2013
-- ---------   ------  -------------------------------------------
    p_num NUMBER;
BEGIN
    p_num := to_number(p_str);
    RETURN 'Y' ;
EXCEPTION
   WHEN others THEN
    RETURN 'N';
END isnumber;
/

DROP FUNCTION load_tradingcycle
/

CREATE OR REPLACE 
FUNCTION load_tradingcycle 
  ( TRADINGCYCLE IN VARCHAR2,
    CYCLETYPE IN VARCHAR2,
    MONTHTYPE IN VARCHAR2
  )
RETURN  VARCHAR2 IS
  l_result VARCHAR2(500);
  l_count NUMBER;
  l_header VARCHAR2(500);
  n VARCHAR2(10);
  l_footer VARCHAR2(500);
  c VARCHAR2(10);
  l_str1 VARCHAR2(500);
  l_str2 VARCHAR2(500);
  l_str3 VARCHAR2(500);
  l_str4 VARCHAR2(500);
  pkgctx   plog.log_ctx;
  logrow   tlogdebug%ROWTYPE;
BEGIN
  l_result := '';
  l_header := '';
  l_footer := '';
-- HANG NGAY
  IF CYCLETYPE = 'D' THEN
    l_result := 'Hàng ngày';
  END IF;


--HANG TUAN

  IF CYCLETYPE = 'W' THEN
   l_count := 3;
   l_footer := ' hàng tu?n';
   LOOP
     n := SUBSTR(TRADINGCYCLE,l_count,1);
      --plog.error(pkgctx, 'l_header' || l_header);
     IF n IS NOT NULL THEN
       IF l_header IS NOT NULL  THEN
         l_header := l_header || ',' || 'th? ' || n;
       ELSE
         l_header := 'Th? ' || n;
       END IF;
     END IF;
     l_count := l_count + 3;
     EXIT WHEN n IS NULL OR n = '';
   END LOOP;
   l_result := l_header || l_footer;
  END IF;

-- HANG THANG - THEO NGAY

  IF cyCLETYPE = 'M' AND MONTHTYPE = 'D' THEN
    IF TRADINGCYCLE = 'MD' THEN
      l_result := 'T?t c? các ngày trong tháng';
    ELSE
      l_count := 3;
      l_footer := ' hàng tháng';
       LOOP
         n := SUBSTR(TRADINGCYCLE,l_count,2);
         IF n < 10 THEN
            n := REPLACE(n,'0','');
         END IF;
          --plog.error(pkgctx, 'l_header' || l_header);
         IF n IS NOT NULL THEN
           IF l_header IS NOT NULL  THEN
             l_header := l_header || ',' || 'ngày ' || n;
           ELSE
             l_header := 'Ngày ' || n;
           END IF;
         END IF;
         l_count := l_count + 4;
         EXIT WHEN n IS NULL OR n = '';
       END LOOP;
       l_result := l_header || l_footer;
     END IF;
  END IF;

-- HANG THANG - THEO THU
    IF cyCLETYPE = 'M' AND MONTHTYPE = 'T' THEN
      l_count :=3;
      l_str2 := TRADINGCYCLE;--'MW1D2D3MW2D3D4'
      LOOP
          l_str1 :=  pck_cldr.fn_get_fist_tradingcycle(l_str2,'M');
           l_count := 5 ;
           l_header := '';
           LOOP
             n := SUBSTR(l_str1,l_count,1);
             IF n IS NOT NULL THEN
               IF l_header IS NOT NULL or l_header <> '' THEN
                 l_header := l_header || ',' || 'th? ' || n;
               ELSE
                 l_header := 'Th? ' || n;
               END IF;
             END IF;
             l_count := l_count + 2;
            -- plog.error(pkgctx, 'l_header: ' || l_header);
           EXIT WHEN n IS NULL;
           END LOOP;
           plog.error(pkgctx, 'l_header: ' || l_header);
           l_footer := ' tu?n th? ' || SUBSTR(l_str1,3,1) || ' hàng tháng';
           l_result := l_result || l_header || l_footer;
           l_str2 := substr(l_str2,length(l_str1)+1);
      EXIT WHEN l_str2 IS NULL or l_str2 = '';
      END LOOP;
    end if;

-- NEU LA TRUOC HOAC SAU NGAY BNHIEU CUA THANG
    IF CYCLETYPE = 'M' AND (MONTHTYPE = 'N' OR MONTHTYPE = 'P') THEN
      IF MONTHTYPE = 'N' THEN
        l_result := 'Sau ngày ' || TRIM(SUBSTR(TRADINGCYCLE,3,2)) || ' hàng tháng';
      ELSE
        l_result := 'Tru?c ngày ' || TRIM(SUBSTR(TRADINGCYCLE,3,2)) || ' hàng tháng';
      END IF;
    END IF;

--Truoc hoac sau ngay bao nhieu cua thang thu may cua quy --QM1D10QM2D10
    IF CYCLETYPE = 'Q' AND (MONTHTYPE = 'N' OR MONTHTYPE = 'P') THEN
      l_str2 := TRADINGCYCLE;
      LOOP
         l_str1 :=  pck_cldr.fn_get_fist_tradingcycle(l_str2,'Q');
         IF MONTHTYPE = 'N' THEN
           if l_header IS NULL then
              l_header := 'Sau ngày ' || TRIM(SUBSTR(l_str1,5,2)) || ' tháng th? ' || TRIM(SUBSTR(l_str1,3,1));
           else
              l_header := l_header || ',' || 'tháng th? ' || TRIM(SUBSTR(l_str1,3,1));
           end if;
         else
           if l_header IS NULL then
              l_header := 'Tru?c ngày ' || TRIM(SUBSTR(l_str1,5,2)) || ' tháng th? ' || TRIM(SUBSTR(l_str1,3,1));
           else
              l_header := l_header || ',' || 'tháng th? ' || TRIM(SUBSTR(l_str1,3,1));
           end if;
         END IF;
         l_str2 := substr(l_str2,length(l_str1)+1);
      EXIT WHEN l_str2 IS NULL or l_str2 = '';
      END LOOP;
      l_result := l_header || ' hàng quý';
    END IF;

-- HANG QUY - THEO NGAY --'QM1D02D03QM2D03D04'
    IF CYCLETYPE = 'Q' AND MONTHTYPE = 'D' THEN
        l_str2 := TRADINGCYCLE;
       LOOP
           l_str1 :=  pck_cldr.fn_get_fist_tradingcycle(l_str2,'Q');
           l_count := 5 ;
           l_header := '';
         IF LENGTH(l_str1) = 4 THEN
           l_result := l_result || ' T?t c? các ngày tháng th? '|| SUBSTR(l_str1,3,1)|| ' hàng quý';
           l_str2 := substr(l_str2,length(l_str1)+1);
         ELSE
           LOOP
             n := SUBSTR(l_str1,l_count,2);
             IF n IS NOT NULL THEN
               IF l_header IS NOT NULL  THEN
                 l_header := l_header || ',' || 'ngày ' || n;
               ELSE
                 l_header := 'Ngày ' || n;
               END IF;
             END IF;
             l_count := l_count + 3;
            EXIT WHEN n IS NULL;
            END LOOP;
            l_footer := ' tháng th? '|| SUBSTR(l_str1,3,1) ||' hàng quý';
            l_result := l_result || ' ' || l_header || l_footer;
            l_str2 := substr(l_str2,length(l_str1)+1);
         END IF;
       EXIT WHEN l_str2 IS NULL;
       END LOOP;

    END IF;

-- HANG QUY - THEO THU --QM1W1D2D3QM2W1D2D3
    IF cyCLETYPE = 'Q' AND MONTHTYPE = 'T' THEN
       l_str2 := TRADINGCYCLE;
       LOOP
           l_str1 :=  pck_cldr.fn_get_fist_tradingcycle(l_str2,'Q');
           l_count := 7 ;
           l_header:= '';
           LOOP
             n := SUBSTR(l_str1,l_count,1);
             IF n IS NOT NULL THEN
               IF l_header IS NOT NULL  THEN
                 l_header := l_header || ',' || 'th? ' || n;
               ELSE
                 l_header := 'Th? ' || n;
               END IF;
             END IF;
             l_count := l_count + 2;
           EXIT WHEN n IS NULL;
           END LOOP;
           l_footer := ' tu?n th? '|| SUBSTR(l_str1,5,1) || ' tháng th? '|| SUBSTR(l_str1,3,1) ||' hàng quý';
           l_result := l_result || ' ' || l_header || l_footer;
           l_str2 := substr(l_str2,length(l_str1)+1);
       EXIT WHEN l_str2 IS NULL;
       END LOOP;
    END IF;

RETURN l_result;

EXCEPTION when others then
   --v_err:=substr(sqlerrm,1,199);
       RETURN 'ERROR';
END;
/

DROP FUNCTION log_info
/

CREATE OR REPLACE 
FUNCTION log_info (l_name in varchar, l_info in varchar2)
return varchar2
is
begin
    return '[' || l_name ||':' || l_info || ']';
exception when others then
    return '';
end;
/

DROP FUNCTION md5raw
/

CREATE OR REPLACE 
FUNCTION md5raw (text in varchar2)
return varchar2 is
hash_value varchar2(20);
begin
   hash_value := dbms_obfuscation_toolkit.md5 (input_string => text);
   return hash_value;
end;
/

DROP FUNCTION pr_system_genotp
/

CREATE OR REPLACE 
FUNCTION pr_system_genotp (prefid varchar2, potptype varchar2, potplen integer, potpintval integer)
RETURN varchar2
IS
    pkgctx plog.log_ctx;
    logrow tlogdebug%rowtype;
    v_logsctx   varchar2(500);
    v_logsbody  varchar2(500);
    v_dtformat  varchar2(500);
    v_secret        varchar2(500);
    v_otpval        varchar2(500);
    v_issueddt  timestamp;
    v_expireddt timestamp;
    l_time      number;
    l_retry_count   number;
    l_count         number;
BEGIN
    plog.setBeginSection(pkgctx, 'pr_system_genotp');
    --Initiate log pcontext

    --log input
    v_logsbody := '{"refid":"' || nvl(prefid ,'') || '", "otptype":"' || nvl(potptype ,'') ||  '}';

    --Execution
    v_issueddt := localtimestamp;
    select to_number(varvalue) into l_time from sysvar where varname = 'OTPTIME_MT';
    v_expireddt := localtimestamp + l_time/1440;
    v_dtformat := 'MM-DD-YYYY HH24:MI:SS';
    v_secret := fn_passwordgenerator();
    plog.debug(pkgctx,'pr_system_genotp.v_secret: '||v_secret);
    v_otpval := genencryptpassword(v_secret);
    select count(*) into l_count from  (
        select max(retry_count) from otp_logs where code=potptype and refid=nvl(prefid ,'') and status in ('N','R')
    );
    if l_count > 0 then
        select max(retry_count) into l_retry_count from otp_logs where code=potptype and refid=nvl(prefid ,'') and status in ('N','R');
--        update otp_logs set status ='E' where code=potptype and refid=nvl(prefid ,'') and status in ('N','R');
        return '-2';
    else
        l_retry_count := null;
    end if;
--    l_retry_count := nvl(l_retry_count,0)+1;
    /*insert into otp_logs (code, refid, secret, otpintval, otplen, issueddt, exprieddt, retry_count)
    values (potptype, nvl(prefid ,''), v_otpval, potpintval, potplen, v_issueddt, v_expireddt, l_retry_count);*/
    plog.setEndSection(pkgctx, 'pr_system_genotp');
    return v_secret;

    EXCEPTION
        WHEN  OTHERS THEN
            RETURN '-1';
END;
/

DROP FUNCTION pr_system_genotp1
/

CREATE OR REPLACE 
FUNCTION pr_system_genotp1 (prefid varchar2, p_varvalue varchar2, potptype varchar2, potplen integer, potpintval integer)
 RETURN varchar2
 IS


    v_dtformat  varchar2(500);
    v_secret        varchar2(500);
    v_otpval        varchar2(500);
    v_issueddt  timestamp;
    v_expireddt timestamp;
    l_retry_count   number;
    l_count         number;

BEGIN
     v_issueddt := current_timestamp;
    select current_timestamp + (1/1440*varvalue) INTO v_expireddt from sysvar where varname = p_varvalue;

    v_dtformat := 'MM-DD-YYYY HH24:MI:SS';
    v_secret := fn_passwordgenerator();
    v_otpval := genencryptpassword(v_secret);
    select count(*) into l_count from  otp_logs where code=potptype and refid=nvl(prefid ,'') and status in ('N','R');
    if l_count > 0 then
          select max(retry_count) into l_retry_count from otp_logs where code=potptype and refid=nvl(prefid ,'') and status in ('N','R');
    else
       l_retry_count := null;
    end if;


    update otp_logs set status ='E' where code=potptype and refid=nvl(prefid ,'') and status in ('N','R');
    l_retry_count := nvl(l_retry_count,0)+1;
    insert into otp_logs (code, refid, secret, otpintval, otplen, issueddt, exprieddt, retry_count)
    values (potptype, nvl(prefid ,''), v_otpval, potpintval, potplen, v_issueddt, v_expireddt, l_retry_count);
    return v_secret;

Exception
When others then
    return '-1';
END

;
/

DROP FUNCTION prc_calc_fee
/

CREATE OR REPLACE 
FUNCTION prc_calc_fee (v_minamt NUMBER ,v_maxamt NUMBER ,v_ruletype varchar2 ,v_feerate NUMBER ,v_id NUMBER ,p_amt  NUMBER )
 RETURN number

as


 v_result  number;
 l_feecalc  varchar2(20);
 l_feeamt    number ;
BEGIN

    --Xác d?nh Phân nhóm KH, Lo?i khách hàng, Qu?c t?ch, Phân lo?i NÐT

    select feecalc , nvl(feeamt , 0) into  l_feecalc, l_feeamt  from feetype where id = v_id ;
    if l_feecalc = 'F' then
        if (v_ruletype = 'F') then
            v_result:=  l_feeamt  ;
        else
            v_result:= 0;


            for vc in (
                select nvl(feerate,0) feerate, nvl(feeamt,0) feeamt, framt ,toamt
            from feetier f
            where feeid = v_id
            --and status = 'A'
            and ((p_amt between framt and toamt -1) or p_amt >  framt)
            ) loop
               v_result := v_result +  vc.feerate   ;
            end loop;

                v_result := v_result ;
        end if;

    else
        if (v_ruletype = 'F') then

                v_result := (p_amt*v_feerate)/100;
                v_result := least(greatest(v_result, v_minamt), v_maxamt);

        ELSE
            v_result:= 0;


            for vc in (
                select nvl(feerate,0) feerate, nvl(feeamt,0) feeamt, framt ,toamt
            from feetier f
            where feeid = v_id
            --and status = 'A'
            and ((p_amt between framt and toamt -1) or p_amt >  framt)
            ) loop
               v_result := v_result +  (least(vc.toamt -1,p_amt  ) - vc.framt  ) * vc.feerate /100 ;
            end loop;

                v_result := v_result ;
                 v_result := least(greatest(v_result, v_minamt), v_maxamt);

        end if;
    end if;
    if p_amt = 0 then
        v_result:= 0 ;
    end if;
    RETURN nvl(v_result,0);

exception
  when others then
    return 0;-- ban dau return -1, nhung
end;
/

DROP FUNCTION prc_calc_fee_for_pm
/

CREATE OR REPLACE 
FUNCTION prc_calc_fee_for_pm (v_minamt NUMBER ,v_maxamt NUMBER ,v_ruletype varchar2 ,v_feerate NUMBER ,v_id NUMBER ,p_amt  NUMBER )
 RETURN number

as


 v_result  number;
 l_feecalc  varchar2(20);
 l_feeamt    number ;
BEGIN

    --Xác d?nh Phân nhóm KH, Lo?i khách hàng, Qu?c t?ch, Phân lo?i NÐT


    select feecalc , nvl(feeamt , 0) into  l_feecalc, l_feeamt  from feetype where id = v_id ;
    if l_feecalc = 'F' then
        if (v_ruletype = 'F') then
            v_result:=    l_feeamt  ;
        ELSE
            v_result:= 0;


            for vc in (
                select nvl(feerate,0) feerate, nvl(feeamt,0) feeamt, framt ,toamt
            from feetier f
            where feeid = v_id
            --and status = 'A'
            and ((p_amt between framt and toamt -1) or p_amt >  framt)
            ) loop
               v_result := v_result +   vc.feerate  ;
            end loop;

                v_result := round(v_result,0);
                -- v_result := least(greatest(v_result, v_minamt), v_maxamt);

        end if;
    else
        if (v_ruletype = 'F') then

                v_result := round((p_amt*v_feerate)/100,0);
              --  v_result := least(greatest(v_result, v_minamt), v_maxamt);

        ELSE
            v_result:= 0;


            for vc in (
                select nvl(feerate,0) feerate, nvl(feeamt,0) feeamt, framt ,toamt
            from feetier f
            where feeid = v_id
            --and status = 'A'
            and ((p_amt between framt and toamt -1) or p_amt >  framt)
            ) loop
               v_result := v_result +  (least(vc.toamt -1,p_amt  ) - vc.framt  ) * vc.feerate /100 ;
            end loop;

                v_result := round(v_result,0);
                -- v_result := least(greatest(v_result, v_minamt), v_maxamt);

        end if;
    end if;
    RETURN nvl(v_result,0);

exception
  when others then
    return 0;-- ban dau return -1, nhung
end;
/

DROP FUNCTION prc_create_payment_hist
/

CREATE OR REPLACE 
FUNCTION prc_create_payment_hist (p_autoid varchar2)
 RETURN varchar2

as

    v_logsctx       varchar2(500);
    v_logsbody      varchar2(500);

    l_intpaidfrq    varchar2(10);
    l_periods       integer;
    l_intdate       date;
    l_intratebaseddt date;
    l_autoid        number;
    l_duedate       date;
    l_intrate       number;
    l_symbol        varchar2(100);
    l_parvalue number;
    l_days     number;
    l_intbaseddofy  number;
    l_intpaidday    number;
    l_intdate_tmp   date;
    l_opndate   date;
begin


    select autoid, symbol, intpaidfrq, intratebaseddt, duedate - 1, intrate, parvalue, opndate,
           case when intbaseddofy = 'N' then 360 else 365 end intbaseddofy, to_number(nvl(case when intpaidday = '' then '31' else intpaidday end, '31'), '99')
        into l_autoid, l_symbol, l_intpaidfrq, l_intratebaseddt, l_duedate, l_intrate, l_parvalue, l_opndate,
             l_intbaseddofy, l_intpaidday
    from assetdtl
    where autoid = p_autoid;

   delete from payment_hist where symbol = l_symbol;

  if      l_intpaidfrq is not null then
   select case when l_intpaidfrq = 'Y' then 1
               when l_intpaidfrq = 'H' then 2
               when l_intpaidfrq = 'Q' then 4
               when  l_intpaidfrq = 'M' then 12
              else 0 end into l_periods from dual ;
end if;
    if l_periods = 0 /*and l_intrate <> 0*/ then
        INSERT INTO payment_hist (autoid, refid, symbol, amount, ratio, valuedt, payment_status, paytype, parvalue, intrate, days, intbaseddofy)
        VALUES (seq_payment_hist.nextval, 0, l_symbol, ROUND(l_intrate * l_parvalue/100*(l_duedate - l_opndate)/l_intbaseddofy, 0), 0, l_duedate, 'P', 'INT', l_parvalue, l_intrate, (l_duedate - l_opndate), l_intbaseddofy);
    end if;


    if l_periods > 0 /*and l_intrate <> 0*/ then
        --l_intdate := least(l_intratebaseddt + interval '1 month' * (12/l_periods), l_duedate);
        select max(a.sbdate)
        into l_intdate
        from sbcldr a
        where a.sbdate >= l_intratebaseddt
        and to_number(to_char(a.sbdate, 'dd'), '99') <= l_intpaidday
        and to_number(to_char(a.sbdate, 'yyyymm'), '999999') = to_number(to_char(add_months(l_intratebaseddt , (12/l_periods) * case when to_number(to_char(l_intratebaseddt, 'dd'), '99') > l_intpaidday then 2 else 1 end), 'yyyymm'), '999999')
        --and to_number(to_char(a.sbdate, 'yyyymm'), '999999') >= to_number(to_char(l_intratebaseddt + interval '1 month' * (12/l_periods), 'yyyymm'), '999999')
        --and to_number(to_char(a.sbdate, 'yyyymm'), '999999') < to_number(to_char(l_intratebaseddt + interval '1 month' * (12/l_periods) * 2, 'yyyymm'), '999999')
        and cldrtype = '000'
        --and mod(to_number(to_char(a.sbdate, 'mm'), '99'), (12/l_periods)) = 0
        ;

        l_intdate_tmp := l_intdate;

        select min(a.sbdate)
        into l_intdate
        from sbcldr a
        where a.sbdate >= l_intdate_tmp
        and cldrtype = '000' and holiday = 'N';

        l_intdate := least(l_intdate, l_duedate);

        l_autoid := seq_payment_hist.nextval;
        INSERT INTO payment_hist (autoid, refid, symbol, amount, ratio, valuedt, payment_status, paytype, parvalue, intrate, days, intbaseddofy)
        VALUES (l_autoid, 0, l_symbol, ROUND(l_intrate * l_parvalue/100*(l_intratebaseddt - l_opndate + 1)/l_intbaseddofy, 0), 0, l_intratebaseddt, 'P', 'INT', l_parvalue, l_intrate, (l_intratebaseddt - l_opndate), l_intbaseddofy);


        while l_intdate <= l_duedate
        loop
            l_autoid := seq_payment_hist.nextval;
            INSERT INTO payment_hist (autoid, refid, symbol, amount, ratio, valuedt, payment_status, paytype, parvalue, intrate, days, intbaseddofy)
            VALUES (l_autoid, 0, l_symbol, null, 0, l_intdate, 'P', 'INT', l_parvalue, l_intrate, null, l_intbaseddofy);

            --lay ngay
            select valuedt - prevdate days
            into l_days
            from
            (select a.valuedt, a.amount, max(nvl(b.valuedt, a.intratebaseddt)) prevdate
                    from
                    (select a.valuedt, a.amount,
                            nvl(b.intratebaseddt, b.opndate) - 1 intratebaseddt
                            from payment_hist a, assetdtl b
                            WHERE a.symbol = l_symbol AND a.payment_STATUS='P' and a.paytype = 'INT'
                                and a.symbol = b.symbol and b.autoid = p_autoid
                                and a.autoid = l_autoid) a
                     left join (select valuedt
                                from payment_hist
                                WHERE symbol = l_symbol and paytype = 'INT') b
                     on b.valuedt < a.valuedt
                     group by a.valuedt, a.amount) a;


            update payment_hist
            set amount = ROUND(l_intrate * l_parvalue/100*l_days/l_intbaseddofy, 0), days = l_days
            where autoid = l_autoid;

            if l_intdate_tmp >= l_duedate then
                exit;
            end if;

            --l_intdate := l_intdate + interval '1 month' * (12/l_periods);
            select max(a.sbdate)
            into l_intdate_tmp
            from sbcldr a
            where a.sbdate >= l_intdate_tmp
            and to_number(to_char(a.sbdate, 'dd'), '99') <= l_intpaidday
            and to_number(to_char(a.sbdate, 'yyyymm'), '999999') = to_number(to_char(add_months(l_intdate_tmp , (12/l_periods)), 'yyyymm'), '999999')
            and cldrtype = '000';

            select min(a.sbdate)
            into l_intdate
            from sbcldr a
            where a.sbdate >= l_intdate_tmp
            and cldrtype = '000' and holiday = 'N';

            l_intdate := least(l_intdate, l_duedate);

        end loop;



    end if;


    l_autoid := seq_payment_hist.nextval;


    INSERT INTO payment_hist (autoid, refid, symbol, amount, ratio, valuedt, payment_status, paytype, parvalue, intrate, days, intbaseddofy)
    VALUES (l_autoid, 0, l_symbol, l_parvalue, 0, l_duedate, 'P', 'PRI', l_parvalue, l_intrate, 0, l_intbaseddofy);

    return '1';


End
;
/

DROP FUNCTION prc_get_vsdfeeid
/

CREATE OR REPLACE 
FUNCTION prc_get_vsdfeeid (p_codeid varchar2, p_custodycd varchar2, p_srtype varchar2)
 RETURN varchar2
 IS


    v_exception     varchar2(500);
    v_vsdfeeid    varchar2(2000);

BEGIN
    SELECT max(case when p_srtype = 'SP' then tad.vsdspcodesip else tad.vsdspcode end) "vsdfeeid" into v_vsdfeeid
            FROM   tasipdef tad
            WHERE  tad.codeid like p_codeid;
    RETURN v_vsdfeeid;

Exception
When others then
    return '-1';
END;
/

DROP FUNCTION prc_update_payment_hist
/

CREATE OR REPLACE 
FUNCTION prc_update_payment_hist (p_updatedt date)
 RETURN varchar2

as

    l_intrate       number;
    l_newintrate    number;

    l_startdate     date;
    l_startdate_tmp date;


begin



    for rec in (select ad.symbol, n.n,add_months(ad.opndate,ad.intratefltfrq * n.n  ) nextrepricing from assetdtl ad
                inner join natural_numbers n
                on 1=1
                where ad.status = 'A'
                and ad.intratefltcd = 'Y'
                and add_months(ad.opndate,ad.intratefltfrq * n.n  ) = p_updatedt)
    loop
        select a.rate
        into l_newintrate
        from vw_ratehistory a
        where a.effdate <= rec.nextrepricing and a.expdate > rec.nextrepricing and symbol = rec.symbol;

        select distinct intrate into l_intrate
        from payment_hist ph
        where ph.symbol = rec.symbol and ph.paytype = 'INT';

        select max(valuedt+1)
        into l_startdate_tmp
        from payment_hist
        where valuedt <= rec.nextrepricing and paytype = 'INT' and symbol = rec.symbol;

        select min(case when l_startdate_tmp = rec.nextrepricing then b.valuedt else a.valuedt end)
        into l_startdate
        from (select paytype, symbol, min(valuedt) valuedt
                        from payment_hist
                        where valuedt >= rec.nextrepricing and paytype = 'INT' group by symbol, paytype) b
             left join payment_hist a on a.symbol = b.symbol and a.valuedt > b.valuedt
        where b.symbol = rec.symbol and b.paytype = 'INT';

        if l_newintrate <> l_intrate then
            update payment_hist
            set amount = ROUND(l_newintrate * parvalue/100*days/intbaseddofy, 0), intrate = l_newintrate
            where symbol = rec.symbol and paytype = 'INT' and valuedt >= l_startdate;
        end if;
    end loop;


    return '0';

Exception
When others then
    return '-1';
End
;
/

DROP FUNCTION readbilionnumber
/

CREATE OR REPLACE 
FUNCTION readbilionnumber 
(
  VALUE IN VARCHAR2 
) RETURN VARCHAR2 AS 
BEGIN
  RETURN 'M?t';
END READBILIONNUMBER;
/

DROP FUNCTION right_
/

CREATE OR REPLACE 
FUNCTION right_ (str varchar2, num number)
 RETURN varchar2
 
AS
        leng NUMBER;
BEGIN
    leng := length(str);
    RETURN SUBSTR(str, LENG - num + 1, num);
end;
/

