DROP FUNCTION fn_get_voucher
/

CREATE OR REPLACE 
FUNCTION fn_get_voucher (p_custodycd varchar2, p_comboid varchar2)
RETURN number
 
as
    l_return number;
  	l_1 number;
  	l_2 number;
    l_count number;
begin
	select nvl(max(case when g.discount is not null then g.discount else gg.discount end) , 0)
	into l_1
	from cfmast c 
			left join gwfvip g
			on g.custodycd  = p_custodycd and g.status ='A'
			left join gwfvip gg
			on c.cftype = gg.aftype and gg.status ='A'
			where c.custodycd = p_custodycd
		
			--and	g.frdate > getcurrdate()
			;
  select count(1) into l_count from comboproduct c where id  = case when p_comboid is null then '0' else p_comboid end ;
  if (l_count <> 0) then
    select discount into l_2 from comboproduct c where id  = case when p_comboid is null then '0' else p_comboid end ;
  else
    l_2 := 0;
  end if;

	if p_comboid is null
	then 
		return l_1;
	else 
	
--	if l_1 > l_2
--	then 
--		return l_1;
--	else
--		return l_2;
--	end if;
		return greatest(l_1, l_2);
		
	end if;
  return 0;
exception
	when others then
		return -1;
END;
/

DROP FUNCTION fn_getbuyamt
/

CREATE OR REPLACE 
FUNCTION fn_getbuyamt (P_TRADINGID VARCHAR2)
  return number is
   l_amt  number ;
BEGIN
   l_amt := 0;
  SELECT TS.Buyamt into l_amt
  FROM TRADINGSESSION TS
  WHERE TS.TRADINGID = P_TRADINGID;
  RETURN l_amt;
exception
  when others then
    return 0;
end;
/

DROP FUNCTION fn_getclsorddate
/

CREATE OR REPLACE 
FUNCTION fn_getclsorddate (P_TRADINGID VARCHAR2)
  return varchar2 is
   l_CLSORDDATE  VARCHAR2(20) ;
BEGIN
   l_CLSORDDATE := ' ';
  SELECT to_char(TS.CLSORDDATE,'dd/MM/rrrr') into l_CLSORDDATE
  FROM (SELECT * FROM TRADINGSESSION UNION ALL SELECT * FROM TRADINGSESSIONHIST) TS
  WHERE TS.TRADINGID = P_TRADINGID;
  RETURN l_CLSORDDATE;
exception
  when others then
    return l_CLSORDDATE;
end;
/

DROP FUNCTION fn_getcurrdate
/

CREATE OR REPLACE 
FUNCTION fn_getcurrdate 
 RETURN varchar2
 is
   l_currdate  varchar2(20);
BEGIN

    SELECT VARVALUE CURRDATE INTO l_currdate
    FROM SYSVAR
    WHERE GRNAME = 'SYSTEM' AND VARNAME ='CURRDATE';
    RETURN l_currdate;

EXCEPTION
   WHEN OTHERS THEN
    RETURN l_currdate ;
End
;
/

DROP FUNCTION fn_getexecdatecash
/

CREATE OR REPLACE 
FUNCTION fn_getexecdatecash (P_TRADINGID VARCHAR2)
  return varchar2 is
   l_EXECDATECASH  VARCHAR2(20) ;
BEGIN
   l_EXECDATECASH := ' ';
  SELECT to_char(TS.EXECDATECASH,'dd/MM/rrrr') into l_EXECDATECASH
  FROM (SELECT * FROM TRADINGSESSION UNION ALL SELECT * FROM TRADINGSESSIONHIST) TS
  WHERE TS.TRADINGID = P_TRADINGID;
  RETURN l_EXECDATECASH;
exception
  when others then
    return l_EXECDATECASH;
end;
/

DROP FUNCTION fn_getexecdateccq
/

CREATE OR REPLACE 
FUNCTION fn_getexecdateccq (P_TRADINGID VARCHAR2)
  return varchar2 is
   l_EXECDATECCQ  VARCHAR2(20) ;
BEGIN
   l_EXECDATECCQ := ' ';
  SELECT to_char(TS.EXECDATECCQ,'dd/MM/rrrr') into l_EXECDATECCQ
  FROM (SELECT * FROM TRADINGSESSION UNION ALL SELECT * FROM TRADINGSESSIONHIST) TS
  WHERE TS.TRADINGID = P_TRADINGID;
  RETURN l_EXECDATECCQ;
exception
  when others then
    return l_EXECDATECCQ;
end;
/

DROP FUNCTION fn_gethodingtime
/

CREATE OR REPLACE 
FUNCTION fn_gethodingtime (p_holdtime varchar2,p_holdtype  varchar2  ,p_sedtlid varchar2 , p_execdateccq date )
  return NUMBER  is
  v_hodingtime_day NUMBER ;
  v_sipid       VARCHAR2(200) ;
BEGIN
IF p_holdtype ='002' THEN


    IF p_holdtime ='D' THEN
    SELECT  p_execdateccq - txdate  INTO v_hodingtime_day FROM sedtl  WHERE id =p_sedtlid;
      RETURN v_hodingtime_day;
    ELSIF p_holdtime ='M' THEN
    SELECT MONTHS_BETWEEN( p_execdateccq , txdate)  INTO v_hodingtime_day FROM sedtl  WHERE id =p_sedtlid;
      RETURN v_hodingtime_day ;



    ELSIF p_holdtime ='Y' THEN
      RETURN v_hodingtime_day/360;
    END IF;

END IF;


IF p_holdtype ='001' THEN
SELECT  sipid INTO v_sipid FROM sedtl  WHERE id =p_sedtlid;



    IF p_holdtime ='D' THEN
     SELECT p_execdateccq -  MIN(txdate) INTO v_hodingtime_day   FROM sedtl WHERE sipid =v_sipid;
      RETURN v_hodingtime_day;
    ELSIF p_holdtime ='M' THEN
    SELECT MONTHS_BETWEEN( p_execdateccq, ( SELECT MIN(txdate)   FROM sedtl WHERE sipid =v_sipid ) ) v_hodingtime_day INTO v_hodingtime_day FROM dual ;
        RETURN v_hodingtime_day ;
    ELSIF p_holdtime ='Y' THEN
      RETURN v_hodingtime_day/360;
    END IF;

END IF;



exception
  when others then
    return 0;
end;
/

DROP FUNCTION fn_getholiday
/

CREATE OR REPLACE 
FUNCTION fn_getholiday ( pv_TXDATE IN VARCHAR2,pv_cldtype IN VARCHAR2)
    RETURN VARCHAR2 IS
    v_Result  VARCHAR2(10);

BEGIN

    BEGIN
        SELECT max(holiday)  INTO v_Result FROM sbcldr WHERE trim(CLDRTYPE) = pv_cldtype AND SBDATE = TO_DATE(pv_TXDATE,'DD/MM/RRRR');
    --SELECT 1  INTO v_Result FROM dual;
    EXCEPTION WHEN OTHERS THEN
        v_Result := 'Y';
    END;
    v_Result := NVL(v_Result,'Y');
    RETURN v_Result;
EXCEPTION
   WHEN OTHERS THEN
    RETURN 'Y';
END;
/

DROP FUNCTION fn_getinventory
/

CREATE OR REPLACE 
FUNCTION fn_getinventory (clause varchar2, brid varchar2, ssysvar varchar2, reflength number, reference varchar2)
 RETURN varchar2
 IS


          V_CLAUSE          varchar2(100);
          V_BRID            varchar2(100);
          V_SSYSVAR         varchar2(100);
          V_iRefLength      integer;
          V_REFERENCE       varchar2(100);
          v_startnumtemp    varchar2(500);
          v_endnumtemp      varchar2(500);

          v_prefix          varchar2(6);
          v_AUTOINV         varchar2(6);
          v_AUTOINVTEMP     varchar2(6);
          v_startnum        integer;
          v_endnum          integer;
          v_AutoNum         integer;
          l_count           integer;

BEGIN
          V_CLAUSE          := UPPER(CLAUSE);
          V_BRID            := UPPER(BRID);
          V_SSYSVAR         := SSYSVAR;
          V_iRefLength      := RefLength;
          V_REFERENCE       := REFERENCE;

          IF (V_CLAUSE = 'CUSTID') THEN

            SELECT COUNT(*)  INTO l_count FROM (


                SELECT SUBSTR(INVACCT,1,6), MAX(ODR)+1 AUTOINV
                  FROM (SELECT DAT.ODR_CUSTID ODR, INVACCT
                        FROM (
                                SELECT row_number() over ( ORDER BY cf.CUSTID) as ODR_CUSTID, CUSTID INVACCT
                                FROM (select CUSTID from CFMAST union select CUSTID from CFMAST_temp) cf
                                WHERE SUBSTR(cf.CUSTID,1,6)= V_BRID
                                ORDER BY cf.CUSTID
                            ) DAT
                        WHERE (SUBSTR(INVACCT,7,6)) = DAT.ODR_CUSTID
                       ) INVTAB
                  GROUP BY SUBSTR(INVACCT,1,6)


            );
          if(l_count > 0) THEN

              SELECT SUBSTR(INVACCT,1,6), MAX(ODR)+1 AUTOINV
                into  v_prefix, v_AutoNum
              FROM (SELECT DAT.ODR_CUSTID ODR, INVACCT
                    FROM (
                            SELECT row_number() over ( ORDER BY cf.CUSTID) as ODR_CUSTID, CUSTID INVACCT
                            FROM (select CUSTID from CFMAST union select CUSTID from CFMAST_temp) cf
                            WHERE SUBSTR(cf.CUSTID,1,6)= V_BRID
                            ORDER BY cf.CUSTID
                        ) DAT
                    WHERE (SUBSTR(INVACCT,7,6)) = DAT.ODR_CUSTID
                   ) INVTAB
              GROUP BY SUBSTR(INVACCT,1,6);
              RETURN nvl(v_prefix,V_BRID)||lpad(nvl(v_AutoNum,1),6,'0');
           ELSE
                v_prefix := NULL;
                v_AutoNum := NULL;
                RETURN nvl(v_prefix,V_BRID)||lpad(nvl(v_AutoNum,1),6,'0');

           END if ;


          ELSIF (V_CLAUSE = 'CUSTODYCD') THEN

            BEGIN
               /* SELECT count(*) INTO l_count FROM (
                    SELECT CUSTODYCDFROM,CUSTODYCDTO
                          FROM BRGRP br WHERE br.BRID = V_BRID
                    );

                IF l_count > 0
                THEN
                    SELECT CUSTODYCDFROM,CUSTODYCDTO
                       INTO v_startnumtemp,v_endnumtemp
                      FROM BRGRP br WHERE br.BRID = V_BRID;
                ELSE
                    v_startnumtemp := NULL;
                    v_endnumtemp := NULL;
                END IF;*/
               
               v_startnumtemp := NULL;
               v_endnumtemp := NULL;


                v_startnum:= v_startnumtemp;
                v_endnum:= v_endnumtemp;
            exception when others then
                v_startnum:= 0;
                v_endnum:= 999999;
            end;

            v_startnum  := nvl(v_startnum,0);
            v_endnum    := nvl(v_endnum,999999);

            BEGIN

                SELECT COUNT(*)  INTO l_count FROM (
                    SELECT SUBSTR(INVACCT,1,4), (v_startnum)  + MAX(ODR)+1 AUTOINV
                FROM (
                        SELECT DAT.ODR_CUSTODYCD as ODR, INVACCT
                        FROM (
                                SELECT row_number() over ( ORDER BY CUSTODYCD) as ODR_CUSTODYCD, CUSTODYCD INVACCT
                                FROM ( select  cf.custodycd FROM (select CUSTODYCD from CFMAST
                                                                    union select CUSTODYCD from CFMAST_temp
                                                                    union select CUSTODYCD from cfmastvip
                                                                 ) cf
                                        WHERE SUBSTR(cf.CUSTODYCD,1,4)= V_SSYSVAR || V_REFERENCE AND trim(TRANSLATE(SUBSTR(cf.CUSTODYCD,5,6),'0123456789',' ')) IS null
                                        )CFMAST
                                WHERE (SUBSTR(trim(CUSTODYCD),5,6))  >= (v_startnum)  and (SUBSTR(trim(CUSTODYCD),5,6)) <= (v_endnum)
                                ORDER BY CUSTODYCD
                         ) DAT
                        WHERE (SUBSTR(INVACCT,5,6)) = DAT.ODR_CUSTODYCD +(v_startnum)
                ) INVTAB
                GROUP BY SUBSTR(INVACCT,1,4)

                );

               IF l_count > 0 THEN
                SELECT SUBSTR(INVACCT,1,4), (v_startnum)  + MAX(ODR)+1 AUTOINV
                into  v_prefix, v_AutoNum
                FROM (
                        SELECT DAT.ODR_CUSTODYCD as ODR, INVACCT
                        FROM (
                                SELECT row_number() over ( ORDER BY CUSTODYCD) as ODR_CUSTODYCD, CUSTODYCD INVACCT
                                FROM ( select  cf.custodycd FROM (select CUSTODYCD from CFMAST
                                                                    union select CUSTODYCD from CFMAST_temp
                                                                    union select CUSTODYCD from cfmastvip
                                                                 ) cf
                                        WHERE SUBSTR(cf.CUSTODYCD,1,4)= V_SSYSVAR || V_REFERENCE AND trim(TRANSLATE(SUBSTR(cf.CUSTODYCD,5,6),'0123456789',' ')) IS null
                                        )CFMAST
                                WHERE (SUBSTR(trim(CUSTODYCD),5,6))  >= (v_startnum)  and (SUBSTR(trim(CUSTODYCD),5,6)) <= (v_endnum)
                                ORDER BY CUSTODYCD
                         ) DAT
                        WHERE (SUBSTR(INVACCT,5,6)) = DAT.ODR_CUSTODYCD +(v_startnum)
                ) INVTAB
                GROUP BY SUBSTR(INVACCT,1,4);
               ELSE
                    v_prefix := NULL;
                    v_AutoNum := NULL;
               END IF;


            exception when others then
              v_prefix:=V_SSYSVAR || V_REFERENCE;
              v_AutoNum:=v_startnum + 1;
              RAISE;
            end;
                RETURN nvl(v_prefix,V_SSYSVAR||V_REFERENCE)||lpad(nvl(v_AutoNum,1),6,'0');



        END IF;

Exception
When OTHERS THEN

      return '-1';
END

;
/

DROP FUNCTION fn_getmbcode
/

CREATE OR REPLACE 
FUNCTION fn_getmbcode (P_MBCODE VARCHAR2)
  return VARCHAR2 is
L_MBCODE VARCHAR2(20);
BEGIN
  SELECT SUBSTR('000000',1,6 - LENGTH(NMBCODE))||NMBCODE MBCODE INTO L_MBCODE FROM (SELECT (NVL(TO_NUMBER(MAX(FD.MBCODE)),0) +1) NMBCODE FROM MEMBERS FD) A;
  RETURN L_MBCODE;
exception
  when others then
    return L_MBCODE;
end;
/

DROP FUNCTION fn_getmrktprice
/

CREATE OR REPLACE 
FUNCTION fn_getmrktprice (P_SYMBOL  VARCHAR2,P_FUNDCODEID varchar2)
  return number is
   l_amt  number ;
   l_symbol VARCHAR2(100);
BEGIN
   l_amt := 0;
   l_symbol:= REPLACE( P_SYMBOL,'_WFTS','');
   l_symbol:= REPLACE( l_symbol,'_WFTR','');
   BEGIN
   SELECT  MAX(T.MRKTPRICE) INTO l_amt
   FROM INSTRLIST T WHERE T.SYMBOL = l_symbol AND T.FUNDCODEID = P_FUNDCODEID;
   exception
   when others then
     l_amt := 0 ;
   end ;
   if l_amt = 0 then
   BEGIN
   SELECT  MAX(T.MRKTPRICE) INTO l_amt
   FROM INSTRLIST T WHERE T.SYMBOL = l_symbol ;
   exception
   when others then
     l_amt := 0 ;
   end ;
   end if;
  RETURN l_amt;
exception
  when others then
    return 0;
end;
/

DROP FUNCTION fn_getnav
/

CREATE OR REPLACE 
FUNCTION fn_getnav (P_TRADINGID VARCHAR2)
  return number is
   l_nav  number ;
BEGIN
   l_nav := 0;
  SELECT TS.NAV into l_nav
  FROM TRADINGSESSION TS
  WHERE TS.TRADINGID = P_TRADINGID;
  RETURN l_nav;
exception
  when others then
    return 0;
end;
/

DROP FUNCTION fn_getnavbycodeid
/

CREATE OR REPLACE 
FUNCTION fn_getnavbycodeid (P_CODEID VARCHAR2)
  return number is
   l_nav  number ;
   l_tradingdate date ;
BEGIN
   l_nav := 0;

   select  max(tradingdate) into l_tradingdate  FROM (SELECT * FROM   TRADINGSESSION UNION ALL SELECT * FROM   tradingsessionhist  ) where  tradingdate<= getcurrdate and nav >0 and codeid =P_CODEID;

  /*for rec in (SELECT TS.NAV
  FROM TRADINGSESSION TS
  WHERE TS.codeid = P_CODEID and ts.tradingstatus in ('A','B') ) loop
  l_nav := rec.nav;
  end loop;*/

 select  nav into l_nav  from  (SELECT * FROM   TRADINGSESSION UNION ALL SELECT * FROM   tradingsessionhist  )
  where tradingdate=  l_tradingdate and codeid =P_CODEID;
  RETURN l_nav;
exception
  when others then
    return 0;
end;
/

DROP FUNCTION fn_getnextautoidfromtable
/

CREATE OR REPLACE 
FUNCTION fn_getnextautoidfromtable 
(p_fldname   in   VARCHAR2,
 p_tablename IN VARCHAR2,
 p_fldlenght IN NUMBER DEFAULT 0,
 p_codeid IN VARCHAR2 DEFAULT '000000',
 p_type IN VARCHAR2 DEFAULT 'N')
return string
IS

  l_refcursor pkg_report.ref_cursor;
  l_return varchar2(100);
  l_count    number;
  l_strSQL varchar2(1000);
  L_SYMBOL VARCHAR(100);
  l_fldname varchar2(500);
BEGIN
    l_count :=1;
    l_fldname := p_fldname;
    IF UPPER(p_tablename) ='FEETYPE' THEN


       select F.SYMBOL INTO L_SYMBOL from FUND F where codeid = p_codeid;
          l_fldname := 'substr(' || l_fldname || ',' || 'length(' || l_fldname || ')' || ' - ' || p_fldlenght || ' + 1' || ')';

          l_strSQL :='SELECT NVL(MAX(ODR)+1,1) AUTOINV FROM
                        (SELECT ROWNUM ODR, INVACCT
                        FROM (SELECT ' || l_fldname || ' INVACCT FROM '|| p_tablename ||
                        ' WHERE 0=0 AND SUBSTR(ID,1, length(id)-4) = '|| '''' || L_SYMBOL || '''' ||' ORDER BY '
                        || l_fldname ||') DAT WHERE TO_NUMBER(INVACCT)=ROWNUM ) INVTAB';
    ELSIF  UPPER(p_tablename) ='FAOBJECT' THEN
         l_fldname := 'substr(' || l_fldname || ',' || 'length(' || l_fldname || ')' || ' - ' || p_fldlenght || ' + 1' || ')';

         l_strSQL :='SELECT NVL(MAX(ODR)+1,1) AUTOINV FROM
                        (SELECT ROWNUM ODR, INVACCT
                        FROM (SELECT ' || l_fldname || ' INVACCT FROM '|| p_tablename ||
                        ' WHERE 0=0 AND SUBSTR(ID,1, length(id)-6) = '|| '''' || p_codeid || '''' ||' ORDER BY '
                        || l_fldname ||') DAT WHERE TO_NUMBER(INVACCT)=ROWNUM ) INVTAB';



    else
      IF p_fldlenght > 0 THEN
          l_strSQL :='SELECT NVL(MAX(ODR)+1,1) AUTOINV FROM
                        (SELECT ROWNUM ODR, INVACCT
                        FROM (SELECT ' || l_fldname || ' INVACCT FROM '|| p_tablename ||' WHERE 0=0 ORDER BY '|| l_fldname ||') DAT WHERE TO_NUMBER(INVACCT)=ROWNUM ) INVTAB';
      ELSIF p_fldlenght = 0 THEN
          l_strSQL :='SELECT SEQ_' || p_tablename ||'.NEXTVAL  AUTOINV FROM DUAL';
      END IF;

    end if;

    OPEN l_refcursor FOR l_strSQL;
    LOOP
        FETCH l_refcursor INTO l_count;
        EXIT WHEN l_refcursor%NOTFOUND;
    END LOOP;
    CLOSE l_refcursor;

    IF p_fldlenght>0 THEN
        l_return :='0000000000000000'||to_char(l_count);
        l_return := substr(l_return,LENGTH(l_return) - p_fldlenght +1);
    ELSIF p_fldlenght = 0 THEN
        l_return :=to_char(l_count);
    END IF;

   IF UPPER(p_tablename) IN ('FEETYPE') THEN
      select F.SYMBOL INTO L_SYMBOL from FUND F where codeid = p_codeid;
      l_return := L_SYMBOL || p_type ||l_return;
   END IF;
   IF UPPER(p_tablename) IN ('FAOBJECT') THEN
      l_return := p_codeid||l_return;
   END IF;
   RETURN l_return;
exception
  when others then
    return '0';
end;
/

DROP FUNCTION fn_getnextbusinessdate
/

CREATE OR REPLACE 
FUNCTION fn_getnextbusinessdate (p_frdate date, p_numday number)
    RETURN DATE
AS
    l_return date;
BEGIN
    SELECT SBDATE
        INTO l_return
    FROM (SELECT row_number() over ( ORDER BY SBDATE )  "DAY", SBDATE
    FROM (SELECT * FROM SBCLDR WHERE CLDRTYPE='000'
            AND SBDATE>p_frdate AND HOLIDAY='N' ORDER BY SBDATE) CLDR) RL
    WHERE "DAY" = p_numday;

    RETURN l_return;
END;
/

DROP FUNCTION fn_getsecured_5004
/

CREATE OR REPLACE 
FUNCTION fn_getsecured_5004 (P_ORDERQTTY VARCHAR2, P_QTTY VARCHAR2)
  return number is
   l_qtty  number ;
BEGIN

  if to_number(P_ORDERQTTY) - to_number(P_QTTY) < 0 then
     l_qtty := to_number(P_QTTY) - to_number(P_ORDERQTTY)  ;
  else
      l_qtty:= 0;
  end if;
  RETURN l_qtty;
exception
  when others then
    return 0;
end;
/

DROP FUNCTION fn_getsessionno
/

CREATE OR REPLACE 
FUNCTION fn_getsessionno (P_codeid VARCHAR2)
  return string is
  l_sessionno VARCHAR2(50);
  l_tradingcycle varchar2(20);
  l_tradingdate date;
  l_tradingid varchar(20);
  v_count number;
  l_codeid varchar2(20);
BEGIN
  --select F.CODEID INTO l_codeid from FUND F WHERE F.CODEID = P_codeid;
  l_codeid := P_codeid;
  select count(*) into v_count from tradingsession where codeid = l_codeid;

 /* if v_count > 1 then*/
    --longbb
    --rao tam cho gen phien tiep theo de test
    /*l_tradingdate := getduedate(getcurrdate,'B',p_codeid,1,'NOMAL');
    SELECT TS.TRADINGID into l_sessionno
    FROM TRADINGSESSION TS
    WHERE TS.TRADINGDATE = TO_DATE(l_tradingdate,'DD/MM/RRRR')
    AND TS.CODEID = P_CODEID
    AND TS.TRADINGSTATUS = 'A';*/
    SELECT TS.TRADINGID into l_sessionno
    FROM TRADINGSESSION TS
    WHERE  TS.CODEID = l_codeid
    AND TS.TRADINGSTATUS = 'A';
 /* else
    select TS.TRADINGDATE INTO l_tradingdate from tradingsession ts where ts.tradingtype = 'IPO' AND TS.CODEID = l_codeid;
    SELECT TS.TRADINGID into l_sessionno
    FROM TRADINGSESSION TS
    WHERE TS.TRADINGDATE = TO_DATE(l_tradingdate,'DD/MM/RRRR')
    AND TS.CODEID = l_codeid
    AND TS.TRADINGSTATUS = 'A';
  end if;*/
  RETURN l_sessionno;
exception
  when others then
    return '';
end;
/

DROP FUNCTION fn_getsip_by_codeid
/

CREATE OR REPLACE 
FUNCTION fn_getsip_by_codeid ( pv_TXDATE IN VARCHAR2,pv_cldtype IN VARCHAR2)
    RETURN VARCHAR2
IS
    v_Result  VARCHAR2(10);

BEGIN

    BEGIN
        SELECT max(SIP)  INTO v_Result FROM sbcldr WHERE trim(CLDRTYPE) = pv_cldtype AND SBDATE = TO_DATE(pv_TXDATE,'DD/MM/RRRR');
    --SELECT 1  INTO v_Result FROM dual;
    EXCEPTION WHEN OTHERS THEN
        v_Result := 'N';
    END;
    v_Result := NVL(v_Result,'N');
    RETURN v_Result;
EXCEPTION
   WHEN OTHERS THEN
    RETURN 'N';
END;
/

DROP FUNCTION fn_gettime
/

CREATE OR REPLACE 
FUNCTION fn_gettime (p_p1      varchar2,p_fromdate varchar2,p_todate varchar2,p_p2 varchar2
                                          )
  return string is
  v_so varchar2(5);

BEGIN
    if p_p1 = '2' THEN
      if abs(to_date(p_fromdate,'dd/MM/rrrr') - to_date(p_todate,'dd/MM/rrrr')) <=90
        then v_so := '1';
      end if;
      if abs(to_date(p_fromdate,'dd/MM/rrrr') - to_date(p_todate,'dd/MM/rrrr')) >90 and abs(to_date(p_fromdate,'dd/MM/rrrr') - to_date(p_todate,'dd/MM/rrrr')) <=180
        then v_so := '2';
      end if;
      if abs(to_date(p_fromdate,'dd/MM/rrrr') - to_date(p_todate,'dd/MM/rrrr')) >180 and  abs(to_date(p_fromdate,'dd/MM/rrrr') - to_date(p_todate,'dd/MM/rrrr')) <= 270
        then v_so := '3';
      end if;
      if abs(to_date(p_fromdate,'dd/MM/rrrr') - to_date(p_todate,'dd/MM/rrrr')) >270
        then v_so := '4';
      end if;
    else RETURN p_p2;
    end if;

    RETURN v_so;
exception
  when others then
    return p_p2;
end;
/

DROP FUNCTION fn_gettltxdstatus
/

CREATE OR REPLACE 
FUNCTION fn_gettltxdstatus 
(
    pv_TLAUTH IN VARCHAR2,
    pv_dstatus IN VARCHAR2)
    return VARCHAR2 
IS 
   l_count    number;
   l_return varchar2(20);
BEGIN
   IF pv_dstatus ='D1' THEN
        l_return := substr(pv_TLAUTH,1,1);
   ELSIF  pv_dstatus ='D2' THEN
        l_return := substr(pv_TLAUTH,2,1);
   ELSIF  pv_dstatus ='S1' THEN        
        l_return := substr(pv_TLAUTH,3,1);
   ELSIF  pv_dstatus ='S2' THEN  
        l_return := substr(pv_TLAUTH,4,1);
   ELSIF  pv_dstatus ='C1' THEN  
        l_return := substr(pv_TLAUTH,5,1);
   ELSIF  pv_dstatus ='C2' THEN  
        l_return := substr(pv_TLAUTH,6,1);
   ELSIF  pv_dstatus ='V1' THEN  
        l_return := substr(pv_TLAUTH,7,1);
   ELSIF  pv_dstatus ='V2' THEN  
        l_return := substr(pv_TLAUTH,8,1);
   ELSE 
        l_return:='N';
   END IF;
   
   RETURN l_return;
exception
  when others then
    return 'N';
end;
/

DROP FUNCTION fn_gettltxworkfollow
/

CREATE OR REPLACE 
FUNCTION fn_gettltxworkfollow 
(p_tltx IN VARCHAR2)
return VARCHAR2
IS
   l_count    number;
   l_return varchar2(20);
   l_D1 varchar2(1);
   l_D2 varchar2(1);
   l_S1 varchar2(1);
   l_S2 varchar2(1);
   l_C1 varchar2(1);
   l_C2 varchar2(1);
   l_V1 varchar2(1);
   l_V2 varchar2(1);

BEGIN
   l_D1:='N';
   l_D2:='N';
   l_S1:='N';
   l_S2:='N';
   l_C1:='N';
   l_C2:='N';
   l_V1:='N';
   l_V2:='N';
   FOR rec IN (SELECT *  FROM tltxwf WHERE tltxcd = p_tltx)
   LOOP
        IF rec.dstatus ='D1' THEN
            l_D1 :='Y';
        ELSIF rec.dstatus ='D2' THEN
            l_D2 :='Y';
        ELSIF rec.dstatus ='S1' THEN
            l_S1 :='Y';
        ELSIF rec.dstatus ='S2' THEN
            l_S2 :='Y';
        ELSIF rec.dstatus ='C1' THEN
            l_C1 :='Y';
        ELSIF rec.dstatus ='C2' THEN
            l_C2 :='Y';
        ELSIF rec.dstatus ='V1' THEN
            l_V1 :='Y';
        ELSIF rec.dstatus ='V2' THEN
            l_V2 :='Y';
        END IF;
   END LOOP;
   l_return :=l_D1||l_D2||l_S1||l_S2||l_C1||l_C2||l_V1||l_V2;
   RETURN l_return;
exception
  when others then
    return 'NNNNNNNN';
end;
/

DROP FUNCTION fn_gettotalnav
/

CREATE OR REPLACE 
FUNCTION fn_gettotalnav (P_TRADINGID VARCHAR2)
  return number is
   l_nav  number ;
BEGIN
   l_nav := 0;
  SELECT TS.TOTALNAV into l_nav
  FROM TRADINGSESSION TS
  WHERE TS.TRADINGID = P_TRADINGID;
  RETURN l_nav;
exception
  when others then
    return 0;
end;
/

DROP FUNCTION fn_gettotaltrade
/

CREATE OR REPLACE 
FUNCTION fn_gettotaltrade (P_SYMBOL VARCHAR2,P_DATE date)
  return number is
   l_TOTALTRADE  number ;
BEGIN
  l_TOTALTRADE := 0;
  select sum(nvl(se.trade, 0) + nvl(se.secured, 0) +
                     nvl(se.netting, 0) + nvl(se.BLOCKED, 0) +nvl(se.sending,0)
                     - nvl(tr.trade, 0) - nvl(tr.secured, 0)  - nvl(tr.netting, 0)  - nvl(tr.BLOCKED, 0)- nvl(tr.sending,0))
                      into l_TOTALTRADE from   semast se,
                      (select ACCTNO,
                             SUM(CASE
                                   WHEN FIELD = 'TRADE' THEN
                                    (CASE
                                      WHEN TXTYPE = 'D' THEN
                                       -NAMT
                                      ELSE
                                       NAMT
                                    END)
                                   ELSE
                                    0
                                 END) TRADE,
                             SUM(CASE
                                   WHEN FIELD = 'SECURED' THEN
                                    (CASE
                                      WHEN TXTYPE = 'D' THEN
                                       -NAMT
                                      ELSE
                                       NAMT
                                    END)
                                   ELSE
                                    0
                                 END) SECURED,
                             SUM(CASE
                                   WHEN FIELD = 'NETTING' THEN
                                    (CASE
                                      WHEN TXTYPE = 'D' THEN
                                       -NAMT
                                      ELSE
                                       NAMT
                                    END)
                                   ELSE
                                    0
                                 END) NETTING,
                           SUM(CASE
                                   WHEN FIELD = 'BLOCKED' THEN
                                    (CASE
                                      WHEN TXTYPE = 'D' THEN
                                       -NAMT
                                      ELSE
                                       NAMT
                                    END)
                                   ELSE
                                    0
                                 END) BLOCKED,
                                 SUM(CASE
                                   WHEN FIELD = 'SENDING' THEN
                                    (CASE
                                      WHEN TXTYPE = 'D' THEN
                                       -NAMT
                                      ELSE
                                       NAMT
                                    END)
                                   ELSE
                                    0
                                 END) SENDING
                        FROM VW_SETRAN_GEN
                       WHERE DELTD <> 'Y'
                         AND FIELD IN ('TRADE', 'SECURED', 'NETTING','BLOCKED','SENDING')
                         and busdate > P_DATE
                         and symbol = p_symbol
                        group by ACCTNO) tr
    where 
       se.symbol = p_symbol
       and se.acctno = tr.ACCTNO(+);
        
  RETURN l_TOTALTRADE;
exception
  when others then
    return 0;
end;
/

DROP FUNCTION fn_getunsecured_5004
/

CREATE OR REPLACE 
FUNCTION fn_getunsecured_5004 (P_ORDERQTTY VARCHAR2, P_QTTY VARCHAR2)
  return number is
   l_qtty  number ;
BEGIN

  if to_number(P_ORDERQTTY) - to_number(P_QTTY) > 0 then
     l_qtty := to_number(P_ORDERQTTY) - to_number(P_QTTY) ;
  else
      l_qtty:= 0;
  end if;
  RETURN l_qtty;
exception
  when others then
    return 0;
end;
/

DROP FUNCTION fn_getvalfromsql
/

CREATE OR REPLACE 
FUNCTION fn_getvalfromsql (p_strsql varchar2, p_fldname varchar2, p_srchkey varchar2, p_srchval varchar2)
 RETURN varchar2
is
    v_logsbody  varchar2(500);
    v_logsctx   varchar2(500);
    v_exception varchar2(500);
    l_return    varchar2(500);
    l_strSQL    varchar2(500);
BEGIN
--    v_logsctx := plog.init('fn_getvalFromSQL', 30, false, false, false);
    --log input
--  v_logsbody := '{"p_strSQL":"' || p_strSQL || '", "p_fldname":"' || p_fldname || '", "p_srchkey":"' || p_srchkey || '", "p_srchval":"' || p_srchval || '"}';
--  v_logsctx := plog.setbeginsection(v_logsctx, v_logsbody);

    l_strSQL    := 'select mst.'||p_fldname||'  from ( '||chr(10)
                || p_strsql || chr(10)
                || ') mst where mst.' || p_srchkey || ' like ''' || p_srchval || '''';
    execute immediate l_strSQL into l_return;

    return nvl(l_return,'');
--  v_logsctx := plog.setendsection(v_logsctx, 'end fn_getvalFromSQL');

Exception
When others then
    return null;
END
;
/

DROP FUNCTION fn_getvermatching
/

CREATE OR REPLACE 
FUNCTION fn_getvermatching (P_TRADINGID VARCHAR2)
  return number is
   l_VERMATCHING  VARCHAR2(20) ;
BEGIN
   l_VERMATCHING := ' ';
  SELECT TS.VERMATCHING  into l_VERMATCHING
  FROM TRADINGSESSION TS
  WHERE TS.TRADINGID = P_TRADINGID;
  RETURN l_VERMATCHING;
exception
  when others then
    return 0;
end;
/

DROP FUNCTION fn_monthdiff
/

CREATE OR REPLACE 
FUNCTION fn_monthdiff (startdate date, enddate date)
 RETURN integer
 
as

			yy	integer;
			mm  integer;
        BEGIN
            SELECT extract(YEAR from enddate) - extract(YEAR from startdate) INTO yy FROM dual;
           	SELECT extract(month from enddate) - extract(month from startdate) INTO mm FROM dual;
           	return yy*12+mm;
        END;
/

DROP FUNCTION fn_parse_amtexp_val
/

CREATE OR REPLACE 
FUNCTION fn_parse_amtexp_val (l_txmsg in tx.msg_rectype,l_amtexp varchar2,p_rnd varchar2)
       RETURN VARCHAR2
   IS
    pkgctx plog.log_ctx;
    logrow tlogdebug%rowtype;
    l_exp   VARCHAR2 (1000);
    l_count   number;
    l_dai VARCHAR2 (1000);
    v_field  VARCHAR2 (1000);
    v_str_result  VARCHAR2 (1000);
    v_operator VARCHAR2 (1000);
    v_result number;
    i NUMBER ;
    v_temp_field  VARCHAR2 (1000);
    BEGIN

    IF INSTR (l_amtexp, '@') > 0
    THEN
        l_exp   := SUBSTR (l_amtexp, 2);
        RETURN l_exp;
    ELSIF substr(l_amtexp,1,1) = '$' or substr(l_amtexp,1,1) = '#'
    THEN
        l_exp   := SUBSTR (l_amtexp, 2);
        l_exp   := L_txmsg.txfields('''|| l_exp ||''').value;
        RETURN l_exp;
    ELSIF l_amtexp = '<$BUSDATE>'    THEN

        RETURN 'TO_DATE(L_txmsg.txdate, systemnums.C_DATE_FORMAT)';
    ELSE
        l_dai:=LENGTH(l_amtexp);
        v_operator:='+';
        i:=1;
        v_field:='';
        v_str_result:='';
        v_result:=0;
        WHILE i< l_dai LOOP
            v_field:=SUBSTR(l_amtexp,i,2);
            IF INSTR ('++,--,**,//,((,))',v_field)=0 THEN
                v_temp_field:=l_txmsg.txfields(v_field).VALUE;
                v_str_result:=v_str_result||v_temp_field;
            ELSE -- la operator
                v_operator:=SUBSTR(v_field,1,1);
                v_str_result:=v_str_result||v_operator;
            END IF;

        i:=i+2;
        END LOOP;

    EXECUTE IMMEDIATE ' select '|| v_str_result ||'  from dual  ' INTO   v_result;
    RETURN v_result;
    END IF ;

    END fn_parse_amtexp_val;
/

DROP FUNCTION fn_parse_cursor_xml
/

CREATE OR REPLACE 
FUNCTION fn_parse_cursor_xml 
(
 pv_refcursor   IN  pkg_report.ref_cursor
 ) RETURN xmldom.domdocument
IS
    v_cursor_number NUMBER;
    v_columns NUMBER;
    v_desc_tab dbms_sql.desc_tab;
    V_SQLERRM VARCHAR2(200);
    v_refcursor pkg_report.ref_cursor;
    v_number_value NUMBER;
    v_varchar_value VARCHAR(200);
    v_date_value DATE;
    l_str_val VARCHAR2(1000);
    v_strXmltemp varchar2(32000);
     -- xmlparser
    l_parser              xmlparser.parser;
    -- Document
    l_doc            xmldom.domdocument;
    -- Elements
    l_element             xmldom.domelement;
    -- Nodes
    headernode      xmldom.domnode;
    docnode        xmldom.domnode;
    entrynode   xmldom.domnode;
    childnode   xmldom.domnode;
    textnode xmldom.DOMText;
    temp1          VARCHAR2 (32000);
    l_clob_xml CLOB;
    l_fldname varchar2(100);
    l_fldval varchar2(1000);
    l_fldtype varchar2(100);
    pkgctx   plog.log_ctx;
BEGIN
    plog.setbeginsection(pkgctx, 'fn_parse_cursor_xml');
    --1. Add header msg
    l_parser              := xmlparser.newparser;
    xmlparser.parsebuffer (l_parser, '<ReportMessage/>');
    l_doc            := xmlparser.getdocument (l_parser);
    docnode        := xmldom.makenode (l_doc);
    l_element := xmldom.getdocumentelement(l_doc);
    xmldom.setattribute (l_element, 'TXDATE', TO_CHAR (getcurrdate,'dd/mm/rrrr'));
    headernode   := xmldom.appendchild (docnode, xmldom.makenode (l_element));

   /* l_element    := xmldom.createelement (l_doc, 'NewDataSet');
    childnode    := xmldom.appendchild (headernode, xmldom.makenode (l_element));*/

    --2. Add RptData from cursor
    v_refcursor := pv_refcursor;
    v_cursor_number := dbms_sql.to_cursor_number(v_refcursor);
    dbms_sql.describe_columns(v_cursor_number, v_columns, v_desc_tab);
    --define colums
    FOR i IN 1 .. v_desc_tab.COUNT LOOP
            IF v_desc_tab(i).col_type = dbms_types.typecode_number THEN
            --Number
                dbms_sql.define_column(v_cursor_number, i, v_number_value);
            ELSIF v_desc_tab(i).col_type = dbms_types.typecode_varchar
                OR  v_desc_tab(i).col_type = dbms_types.typecode_char THEN
            --Varchar, char
                dbms_sql.define_column(v_cursor_number, i, v_varchar_value,200);
            ELSIF v_desc_tab(i).col_type = dbms_types.typecode_date THEN
            --Date,
               dbms_sql.define_column(v_cursor_number, i, v_date_value);
            END IF;
    END LOOP;

    WHILE dbms_sql.fetch_rows(v_cursor_number) > 0 LOOP
        l_element             := xmldom.createelement (l_doc, 'RptData');
        childnode    := xmldom.appendchild (headernode, xmldom.makenode (l_element));
        FOR i IN 1 .. v_desc_tab.COUNT LOOP
              l_fldname :=  v_desc_tab(i).col_name;
              IF v_desc_tab(i).col_type = dbms_types.typecode_number THEN
              --Number
                    dbms_sql.column_value(v_cursor_number, i, v_number_value);
                    --plog.error (pkgctx, 'v_number_value:'||i ||':' ||v_number_value);
                    l_fldval :=to_char(v_number_value);
                    l_fldtype :='System.Decimal';
              END IF;
              IF v_desc_tab(i).col_type = dbms_types.typecode_varchar
                OR  v_desc_tab(i).col_type = dbms_types.typecode_char
                THEN
              --Varchar, char
                    dbms_sql.column_value(v_cursor_number, i, v_varchar_value);
                    --plog.error (pkgctx, 'v_varchar_value:'||i ||':' ||v_varchar_value);
                    l_fldval := v_varchar_value;
                    l_fldtype :='System.String';
              END IF;
              IF v_desc_tab(i).col_type = dbms_types.typecode_date
                THEN
              --Date
                    dbms_sql.column_value(v_cursor_number, i, v_date_value);
                    --plog.error (pkgctx, 'v_date_value:'||i ||':' ||to_char(v_date_value,'DD/MM/RRRR'));
                    l_fldval := to_char(v_date_value,'dd/mm/rrrr');
                    l_fldtype :='System.DateTime';
              END IF;
              l_element := xmldom.createelement (l_doc, l_fldname);
              --plog.error (pkgctx, 'l_fldname:'||i||l_fldname );
              entrynode   := xmldom.appendchild (childnode, xmldom.makenode(l_element));
              textnode := xmldom.createTextNode(l_doc, l_fldval);
              --plog.error (pkgctx, 'l_fldval:'||i||l_fldval );
              entrynode := xmldom.appendChild(entrynode, xmldom.makeNode(textnode));

        END LOOP;
    END LOOP;
    dbms_sql.close_cursor(v_cursor_number);
    --xmldom.writetobuffer (l_doc,temp1 );
    --plog.error (pkgctx, 'temp1:'||temp1);
    --xmldom.writetoclob(l_doc,l_clob_xml);

    plog.setendsection(pkgctx, 'fn_parse_cursor_xml');
    return l_doc;
EXCEPTION WHEN OTHERS THEN
    plog.error (pkgctx, 'fn_parse_cursor_xml: ' || dbms_utility.format_error_backtrace);
    plog.setendsection(pkgctx, 'fn_parse_cursor_xml');
    RETURN NULL;
END;
/

DROP FUNCTION fn_passwordgenerator
/

CREATE OR REPLACE 
FUNCTION fn_passwordgenerator 
 RETURN varchar2
IS
    l_password varchar2(6);
BEGIN
    select dbms_random.string('a',6)
        INTO l_Password
    from dual;
    RETURN l_Password;
END fn_passwordgenerator;
/

DROP FUNCTION fn_split_varchar
/

CREATE OR REPLACE 
FUNCTION fn_split_varchar (
    v_instring     VARCHAR2,
    v_index        NUMBER DEFAULT 1,
    v_splitchar    VARCHAR2 DEFAULT '|')
    RETURN VARCHAR2
AS
    v_strtoprocess   VARCHAR2 (5000);
    v_return         VARCHAR2 (5000);
    v_offset         INTEGER;
    v_startpos       INTEGER;
    v_endpos         INTEGER;
BEGIN
    v_strtoprocess := v_instring || v_splitchar;

    IF v_index = 1
    THEN
        v_offset := 0;
    ELSE
        v_offset :=
            INSTR (v_strtoprocess,
                   v_splitchar,
                   1,
                   v_index - 1);
    END IF;

    v_startpos := v_offset + 1;
    v_endpos :=
          INSTR (v_strtoprocess,
                 v_splitchar,
                 1,
                 v_index)
        - 1
        - v_offset;
    v_return := SUBSTR (v_strtoprocess, v_startpos, v_endpos);
    RETURN TRIM (v_return);
EXCEPTION
    WHEN OTHERS
    THEN
        RETURN '';
END fn_split_varchar;
/

DROP FUNCTION fn_pivot_string
/

CREATE OR REPLACE 
FUNCTION fn_pivot_string (
    p_listclob      CLOB,
    p_lstcolname    VARCHAR2 DEFAULT NULL,
    p_lstcoltype    VARCHAR2 DEFAULT NULL,
    p_lstcolmas     CLOB DEFAULT NULL,
    p_dilimiter     VARCHAR2 DEFAULT '^#')
    RETURN ty_pivot_tb
IS
    TYPE type_tbl_clob IS TABLE OF CLOB
                              INDEX BY BINARY_INTEGER;

    vt_clob       type_tbl_clob;
    vt_tab        ty_pivot_tb;
    v_pos         NUMBER;
    v_idx         NUMBER := 0;
    v_clob        CLOB;
    v_sub_idx     NUMBER := 0;
    v_cl          VARCHAR2 (255);
    v_cn          VARCHAR2 (255);

    v_sub_idx_2   NUMBER := 0;
    v_ma          CLOB;
    v_pos_2       VARCHAR2 (255);
    vt_ma         CLOB;

    FUNCTION get_clob_tab (p_listclob CLOB)
        RETURN type_tbl_clob
    IS
        vt_tab   type_tbl_clob;
        v_pos    NUMBER;
        v_idx    NUMBER := 0;
        v_clob   CLOB;
        v_len    NUMBER := LENGTH (p_dilimiter);
    BEGIN
        v_clob := p_listclob || p_dilimiter;

        WHILE v_clob <> EMPTY_CLOB ()
        LOOP
            v_idx := v_idx + 1;
            v_pos := DBMS_LOB.INSTR (v_clob, p_dilimiter);
            vt_tab (v_idx) := SUBSTR (v_clob, 0, v_pos - 1);
            v_clob := SUBSTR (v_clob, v_pos + v_len);
        END LOOP;

        RETURN vt_tab;
    END;
BEGIN
    vt_clob := get_clob_tab (p_listclob);
    vt_tab := ty_pivot_tb ();
    vt_ma := p_lstcolmas || '|';

    FOR i IN 1 .. vt_clob.LAST
    LOOP
        v_clob := vt_clob (i) || '|';
        v_cl := NULL;
        v_cn := 'UD' || i;
        v_ma := vt_ma;

        IF p_lstcoltype IS NOT NULL
        THEN
            v_cl := fn_split_varchar (p_lstcoltype, i);
        END IF;

        IF p_lstcolname IS NOT NULL
        THEN
            v_cn := fn_split_varchar (p_lstcolname, i);
        END IF;

        IF vt_ma IS NULL
        THEN
            WHILE v_clob <> EMPTY_CLOB ()
            LOOP
                v_sub_idx := v_sub_idx + 1;
                v_pos := DBMS_LOB.INSTR (v_clob, '|');
                vt_tab.EXTEND ();
                v_idx := vt_tab.COUNT;
                vt_tab (v_idx) :=
                    ty_column_oj (v_sub_idx,
                                 v_cl,
                                 v_cn,
                                 NULL,
                                 SUBSTR (v_clob, 0, v_pos - 1));
                v_clob := SUBSTR (v_clob, v_pos + 1);
            END LOOP;

            v_sub_idx := 0;
        ELSE
            WHILE v_clob <> EMPTY_CLOB ()
            LOOP
                v_pos_2 := DBMS_LOB.INSTR (v_ma, '|'); /* Minh them vao */

                v_sub_idx := v_sub_idx + 1;
                v_pos := DBMS_LOB.INSTR (v_clob, '|');
                vt_tab.EXTEND ();
                v_idx := vt_tab.COUNT;
                vt_tab (v_idx) :=
                    ty_column_oj (v_sub_idx,
                                 v_cl,
                                 v_cn,
                                 SUBSTR (v_ma, 0, v_pos_2 - 1),
                                 SUBSTR (v_clob, 0, v_pos - 1));
                v_clob := SUBSTR (v_clob, v_pos + 1);
                v_ma := SUBSTR (v_ma, v_pos_2 + 1); /* Minh them vao */
            END LOOP;

            v_sub_idx := 0;
        END IF;
    END LOOP;

    RETURN vt_tab;
END fn_pivot_string;
/

DROP FUNCTION fn_push_notify_bus
/

CREATE OR REPLACE 
FUNCTION fn_push_notify_bus (pv_type in varchar2)
return TIMESTAMP
is
 pv_ref pkg_report.ref_cursor;
 enq_msgid RAW(16);
 l_content VARCHAR2(4000);
begin
  IF pv_type = 'PUSHQUEUE' THEN
     OPEN pv_ref for
     SELECT 'C' MSGTYPE, 'HB' EVENTTYPE, TO_CHAR(SYSTIMESTAMP, 'RRRR-MM-DD HH24:MI:SS.FF') TIME
     FROM dual;

     txpks_NOTIFY.PR_FLEX2FO_ENQUEUE(PV_REFCURSOR=>pv_ref, ENQ_MSGID=>enq_msgid, queue_name=>'PUSH2FO');
  ELSE
     l_content := '{"msgtype":"C", ' || '"datatype":"HB", ' || '"time":"'||SYSTIMESTAMP||'"}';

     txpks_NOTIFY.sp_set_message_queue(f_content=>l_content,f_queue=>'TXAQS_RPTFLEX2FO',autocommit=>'N');
  END IF;
  return SYSTIMESTAMP;
EXCEPTION WHEN
  OTHERS THEN
  return '-1';
end FN_Push_Notify_BUS;
/

DROP FUNCTION fn_qtty_9109
/

CREATE OR REPLACE 
FUNCTION fn_qtty_9109 (P_STRDATA VARCHAR2,p_fundcodeid varchar2)
  return number is
   l_qtty  number ;
BEGIN
  l_qtty := 0;
   select  trim(substr(strdata,8,30)) into l_qtty
                  from
                    (select regexp_substr(P_STRDATA,'[^#]+', 1, level) strdata from dual
                    connect by regexp_substr(P_STRDATA, '[^#]+', 1, level) is not NULL)
   where substr(strdata,0,6) = p_fundcodeid;
   return l_qtty;
  EXCEPTION
  WHEN OTHERS THEN
    return  0;

end;
/

DROP FUNCTION fn_replace_strdata
/

CREATE OR REPLACE 
FUNCTION fn_replace_strdata (P_STRDATA VARCHAR2)
RETURN VARCHAR2
AS
pkgctx   plog.log_ctx;
   logrow   tlogdebug%ROWTYPE;
l_STRDT VARCHAR2(500);
l_codeid VARCHAR2(20);
l_qtty  NUMBER;
l_symbol VARCHAR2(500);
l_return VARCHAR2(4000);
BEGIN
l_STRDT := P_STRDATA;
plog.error (pkgctx, 'l_STRDT: '||l_STRDT);
l_return := '';
    FOR REC0 IN (
        SELECT REGEXP_SUBSTR(l_STRDT, '[^#,]+', 1, LEVEL) tmp
        FROM dual CONNECT BY REGEXP_SUBSTR(l_STRDT, '[^#,]+', 1, LEVEL) is NOT NULL
                )
    LOOP
    plog.error (pkgctx, 'REC0'||rec0.tmp);
    SELECT SUBSTR( rec0.tmp,0,INSTR (rec0.tmp,'|') -1 ) ,
          SUBSTR( rec0.tmp,INSTR (rec0.tmp,'|',1,1) +1  )
        INTO l_codeid, l_qtty
    FROM dual ;

    SELECT f.symbol INTO l_symbol FROM fund f WHERE f.codeid = l_codeid;
    l_return := l_return || '|' || 'Qu? ' || l_symbol || ':' || l_qtty;
    END LOOP;

    RETURN l_return;
EXCEPTION WHEN OTHERS THEN
    RETURN '';
END;
/

DROP FUNCTION fn_reportcheck
/

CREATE OR REPLACE 
FUNCTION fn_reportcheck (pv_objname varchar2, pv_param varchar2) return varchar2
is
    v_strValue1 varchar2(200);
    v_strValue2 varchar2(200);
    v_strValue3 varchar2(200);
    v_strValue4 varchar2(200);

begin
    /*----GianhVG add Sample code--------------------------------------------------------------------------------
    ----Kiem tra bao cao CF1007. Chan khong duoc in qua 1000 ngay------------------------------------------------
    if pv_objname='CF1007' then
        --pv_param=F_DATE!01/09/2014#T_DATE!23/09/2014#pv_CUSTODYCD!002C103019#PV_AFACCTNO!0001103019#TLID!0001
        select
           REGEXP_SUBSTR(s, '[^#]+', 1, 1) F_DATE,
           REGEXP_SUBSTR(s, '[^#]+', 1, 2) T_DATE
           into v_strValue1, v_strValue2
        from (select pv_param s from dual);
        dbms_output.put_line('v_strValue1:' || v_strValue1);
        dbms_output.put_line('v_strValue2:' || v_strValue2);
        select
           REGEXP_SUBSTR(s, '[^!]+', 1, 2) F_DATE
           into v_strValue1
        from (select v_strValue1 s from dual);
        select
           REGEXP_SUBSTR(s, '[^!]+', 1, 2) F_DATE
           into v_strValue2
        from (select v_strValue2 s from dual);

        dbms_output.put_line('v_strValue1:' || v_strValue1);
        dbms_output.put_line('v_strValue2:' || v_strValue2);

        if to_date(v_strValue2,'DD/MM/RRRR')-to_date(v_strValue1,'DD/MM/RRRR') >1000 then
            Return 'Vuot qua khoang thoi gian lay bao cao cho phep cua he thong';
        end if;
    end if;
    -------------End GianhVG add Sample code---------------------------------------------------------------------*/
    return 'OK';
EXCEPTION
   WHEN OTHERS THEN
    RETURN 'OK';
end;
/

DROP FUNCTION fn_sereg_getafacctno
/

CREATE OR REPLACE 
FUNCTION fn_sereg_getafacctno (P_CODEID    VARCHAR2,
                                                 P_CUSTID    VARCHAR2)
   RETURN VARCHAR2
IS
   l_afacctno   VARCHAR2 (500);
BEGIN
   SELECT ser.acctno
     INTO l_afacctno
     FROM sereg ser
    WHERE ser.codeid = P_CODEID AND ser.custid = P_CUSTID;

   RETURN l_afacctno;
EXCEPTION
   WHEN OTHERS
   THEN
      RETURN l_afacctno;
END;
/

DROP FUNCTION fn_seri
/

CREATE OR REPLACE 
FUNCTION fn_seri (value VARCHAR2,value2 varchar2)
RETURN VARCHAR2

as
            l_value     varchar2(5000);
            l_value1    varchar2(5000);
begin
          For record IN (
        SELECT REGEXP_REPLACE(TRIM (fil.char_value), '\(|\)', '') fil_cond
        FROM (
        SELECT fn_pivot_string (
        REGEXP_REPLACE (value,
        '~\#~', '|'))
        filter_row
        FROM DUAL
        ),
        table (filter_row) fil
        )
        LOOP
              SELECT
             b.framt,b.toamt into l_value,l_value1
            FROM
              (WITH tmp AS (
              SELECT
                REGEXP_REPLACE (TRIM (fil.char_value), '\(|\)', '') VALUE, fil.rid
              FROM
                  (SELECT
                  fn_pivot_string ( REGEXP_REPLACE (record.FIL_COND, '~\$~', '|')) filter_row
                FROM
                  DUAL), TABLE (filter_row) fil)
              SELECT
                framt.VALUE framt , toamt.VALUE toamt
              FROM
                (
                SELECT
                  VALUE
                FROM
                  tmp
                WHERE
                  rid = 1) framt
                  INNER JOIN (
                SELECT
                  VALUE
                FROM
                  tmp
                WHERE
                  rid = 2) toamt ON
                1 = 1
              )b;

      END LOOP;
      return l_value||'~'||l_value1;
END;
/

DROP FUNCTION fn_systemnums
/

CREATE OR REPLACE 
FUNCTION fn_systemnums (p_emnumname IN VARCHAR2)
RETURN VARCHAR2
IS
    l_returnvalue VARCHAR2(1000);
BEGIN
    l_returnvalue :='';
    CASE upper(p_emnumname)
        -- systemnums NUM ----
        when upper('systemnums.colchar') then l_returnvalue := '~#~';
        when upper('systemnums.rowchar') then l_returnvalue := '~$~';
        when upper('systemnums.vn_lang') then l_returnvalue := 'vie';
        when upper('systemnums.en_lang') then l_returnvalue := 'en';
        when upper('systemnums.C_SUCCESS') then l_returnvalue := '0';
        when upper('systemnums.C_DATE_FORMAT') then l_returnvalue := 'DD/MM/YYYY';
        when upper('systemnums.C_TIME_FORMAT') then l_returnvalue := 'HH24:MI:SS';
        when upper('systemnums.C_ADMIN_ID') then l_returnvalue := '000001';
        when upper('systemnums.C_SYSTEM_USERID') then l_returnvalue := '999999';
        when upper('systemnums.C_ONLINE_USERID') then l_returnvalue := '686868';
        when upper('systemnums.C_ONLINE_CUSTOMER') then l_returnvalue := '008868';
        when upper('systemnums.C_HO_BRID') then l_returnvalue := '000000';
        when upper('systemnums.C_HO_MBID') then l_returnvalue := '000001';
        when upper('systemnums.C_HO_HOID') then l_returnvalue := '000001';
        when upper('systemnums.C_BATCH_BRID') then l_returnvalue := '000001';
        when upper('systemnums.C_OL_BRID') then l_returnvalue := '000068';
        when upper('systemnums.C_VND_CCYCD') then l_returnvalue := '00';
        when upper('systemnums.C_OPERATION_ACTIVE') then l_returnvalue := '1';
        when upper('systemnums.C_OPERATION_INACTIVE') then l_returnvalue := '0';
        when upper('systemnums.C_BRGRP_ACTIVE') then l_returnvalue := 'A';
        when upper('systemnums.C_BRGRP_CLOSED') then l_returnvalue := 'C';
        when upper('systemnums.C_FO_PREFIXED') then l_returnvalue := '80';
        when upper('systemnums.C_OL_PREFIXED') then l_returnvalue := '68';
        when upper('systemnums.C_BATCH_PREFIXED') then l_returnvalue := '99';
        when upper('systemnums.C_FORMAT_BATCHTXNUM') then l_returnvalue := '0000000000';
        when upper('systemnums.C_SYSTEM_AUTH') then l_returnvalue := 'SYSTEMAUTH';
        when upper('systemnums.C_SYSTEM_CAREBY') then l_returnvalue := '9999';
        when upper('systemnums.c_number_format') then l_returnvalue := '999,999,999,999,999,999';
        when upper('systemnums.c_number_format2') then l_returnvalue := '999,999,999,999,999,990.99';
        -- txnums NUM ----
        when upper('txnums.C_DELTD_TXDELETED') then l_returnvalue := 'Y';
        when upper('txnums.C_DELTD_TXNORMAL') then l_returnvalue := 'N';
        when upper('txnums.C_TXTYPE_WITDRAWAL') then l_returnvalue := 'W';  -- Required Cash management, update host data before approve
        when upper('txnums.C_TXTYPE_REMITTANCE') then l_returnvalue := 'R';  -- Required Cash management, update host data before approve
        when upper('txnums.C_TXTYPE_DEPOSIT') then l_returnvalue := 'D';
        when upper('txnums.C_TXTYPE_TRANSACTION') then l_returnvalue := 'T';
        when upper('txnums.C_TXTYPE_ORDER') then l_returnvalue := 'O';  -- -- update host data before approve
        when upper('txnums.C_TXTYPE_MAINTENANCE') then l_returnvalue := 'M';

        when upper('txnums.C_TXACTION_DELETE') then l_returnvalue := 'DEL';
        when upper('txnums.C_TXACTION_APPROVE') then l_returnvalue := 'APR';
        when upper('txnums.C_TXACTION_REVERSE') then l_returnvalue := 'RVL';
        when upper('txnums.C_TXACTION_TRANSACT') then l_returnvalue := 'TXN';
        --- ..
        -- txstatusnums NUM ----
        when upper('txstatusnums.c_txlogged') then l_returnvalue := '0';
        when upper('txstatusnums.c_txcompleted') then l_returnvalue := '1';
        when upper('txstatusnums.c_txerroroccured') then l_returnvalue := '2';
        when upper('txstatusnums.c_txcashier') then l_returnvalue := '3';
        when upper('txstatusnums.c_txpending') then l_returnvalue := '4';
        when upper('txstatusnums.c_txrejected') then l_returnvalue := '5';
        when upper('txstatusnums.c_txmsgrequired') then l_returnvalue := '6';
        when upper('txstatusnums.c_txdeleting') then l_returnvalue := '7';  --Pending to delete
        when upper('txstatusnums.c_txrefuse') then l_returnvalue := '8';
        when upper('txstatusnums.c_txdeleted') then l_returnvalue := '9';
        when upper('txstatusnums.c_txremittance') then l_returnvalue := '10';
        -- ...
        -- utf8nums NUM ----
        when upper('utf8nums.C_CONST_DATE_VI') then l_returnvalue := 'ngày';
        when upper('utf8nums.C_CONST_MONTH_VI') then l_returnvalue := 'tháng';
        when upper('utf8nums.C_CONST_YEAR_VI') then l_returnvalue := 'nam';
        when upper('utf8nums.c_const_str_common') then l_returnvalue := 'Thông tin chung';
        when upper('utf8nums.c_const_custodycd_type_c') then l_returnvalue := 'Trong nu?c';
        when upper('utf8nums.c_const_custodycd_type_f') then l_returnvalue := 'Nu?c ngoài';
        when upper('utf8nums.c_const_custodycd_type_p') then l_returnvalue := 'T? doanh';
        when upper('utf8nums.c_const_custtype_custodycd_ic') then l_returnvalue := 'Cá nhân trong nu?c';
        when upper('utf8nums.c_const_custtype_custodycd_bc') then l_returnvalue := 'T? ch?c trong nu?c';
        when upper('utf8nums.c_const_custtype_custodycd_if') then l_returnvalue := 'Cá nhân nu?c ngoài';
        when upper('utf8nums.c_const_custtype_custodycd_bf') then l_returnvalue := 'T? ch?c nu?c ngoài';

        ---errnums-------
        when upper('errnums.C_HOST_VOUCHER_NOT_FOUND') then l_returnvalue := '-100100';
        when upper('errnums.C_SYSTEM_ERROR') then l_returnvalue := '-1';
        when upper('errnums.C_BIZ_RULE_INVALID') then l_returnvalue := '-110010';
        when upper('errnums.E_TRANS_NOT_ALLOW') then l_returnvalue := '-100';
        when upper('errnums.C_CHECKER1_REQUIRED') then l_returnvalue := '-100010';
        when upper('errnums.C_CHECKER2_REQUIRED') then l_returnvalue := '-100011';
        when upper('errnums.C_INVALID_SESSION') then l_returnvalue := '-500006';
        when upper('errnums.C_SA_CALENDAR_MISSING') then l_returnvalue := '-100030';
        when upper('errnums.C_CHECKER_CONTROL') then l_returnvalue := '@00';
        when upper('errnums.C_OFFID_REQUIRED') then l_returnvalue := '@00';
        when upper('errnums.OVRRQS_CHECKER_CONTROL') then l_returnvalue := '@00';
        when upper('errnums.C_HOST_OPERATION_STILL_ACTIVE') then l_returnvalue := '-100022';
        when upper('errnums.C_HOST_OPERATION_ISINACTIVE') then l_returnvalue := '-100023';
        ------CF
        --S?a import TK
        --when upper('CF.CFMAST_FIELDS') then l_returnvalue := 'CUSTID~#~CUSTODYCD~#~FULLNAME~#~ACCTYPE~#~CUSTTYPE~#~GRINVESTOR~#~SEX~#~BIRTHDATE~#~IDTYPE~#~IDCODE~#~IDDATE~#~IDPLACE~#~TAXNO~#~REGADDRESS~#~ADDRESS~#~COUNTRY~#~OTHERCOUNTRY~#~PHONE~#~MOBILE~#~EMAIL~#~BANKACC~#~BANKCODE~#~CITYBANK~#~BANKACNAME~#~FAX~#~INCOMEYEAR~#~ISAUTH~#~TRADINGCODE~#~PASSPORT~#~PASSPORTDATE~#~PASSPORTPLACE~#~TAXPLACE~#~CAREBY~#~INVESTTYPE~#~IDEXPDATED~#~ISONLINE~#~ISCONTACT~#~SALEID~#~ISFATCA~#~ISPEP~#~FAMILYNAME1~#~NAME1~#~FAMILYNAME2~#~NAME2~#~ISREPRESENTATIVE~#~LRNAME~#~LRSEX~#~LRDOB~#~LRCOUNTRY~#~LRPOSITION~#~LRDECISIONNO~#~LRID~#~LRIDDATE~#~LRIDPLACE~#~LRADDRESS~#~LRCONTACT~#~LRPRIPHONE~#~LRALTPHONE~#~LRFAX~#~LREMAIL';
        when upper('CF.CFMAST_FIELDS') then l_returnvalue := 'CUSTID~#~CUSTODYCD~#~FULLNAME~#~ACCTYPE~#~CUSTTYPE~#~GRINVESTOR~#~SEX~#~BIRTHDATE~#~IDTYPE~#~IDCODE~#~IDDATE~#~IDPLACE~#~TAXNO~#~REGADDRESS~#~ADDRESS~#~COUNTRY~#~OTHERCOUNTRY~#~PHONE~#~MOBILE~#~EMAIL~#~BANKACC~#~BANKCODE~#~CITYBANK~#~BANKACNAME~#~FAX~#~INCOMEYEAR~#~ISAUTH~#~TRADINGCODE~#~PASSPORT~#~PASSPORTDATE~#~PASSPORTPLACE~#~TAXPLACE~#~CAREBY~#~INVESTTYPE~#~IDEXPDATED~#~ISONLINE~#~ISCONTACT~#~SALEID~#~ISFATCA~#~ISPEP~#~FAMILYNAME1~#~NAME1~#~FAMILYNAME2~#~NAME2~#~ISREPRESENTATIVE~#~LRNAME~#~LRSEX~#~LRDOB~#~LRCOUNTRY~#~LRPOSITION~#~LRDECISIONNO~#~LRID~#~LRIDDATE~#~LRIDPLACE~#~LRADDRESS~#~LRCONTACT~#~LRPRIPHONE~#~LRALTPHONE~#~LRFAX~#~LREMAIL~#~JOB~#~WORKUNIT~#~CFTYPE~#~ISPROFESSION~#~FULLNAMEACCENTED~#~ISEXISTS~#~PROFESSIONFRDATE~#~PROFESSIONTODATE~#~SEACCOUNT~#~CIACCOUNT~#~SECIF~#~LRIDTYPER~#~IDTYPECK~#~IDCODECK~#~IDDATECK~#~IDEXPDATEDCK~#~IDPLACECK~#~MOBILEGT~#~TLIDGT';
        when upper('CF.CFMAST_FIELDS_ALT') then l_returnvalue := 'CUSTID~#~CUSTODYCD~#~FULLNAME~#~ACCTYPE~#~CUSTTYPE~#~GRINVESTOR~#~SEX~#~BIRTHDATE~#~IDTYPE~#~IDCODE~#~IDDATE~#~IDPLACE~#~TAXNO~#~REGADDRESS~#~ADDRESS~#~COUNTRY~#~OTHERCOUNTRY~#~PHONE~#~MOBILE~#~EMAIL~#~BANKACC~#~BANKCODE~#~CITYBANK~#~BANKACNAME~#~FAX~#~INCOMEYEAR~#~ISAUTH~#~TRADINGCODE~#~PASSPORT~#~PASSPORTDATE~#~PASSPORTPLACE~#~TAXPLACE~#~CAREBY~#~INVESTTYPE~#~IDEXPDATED~#~ISONLINE~#~ISCONTACT~#~SALEID~#~ISFATCA~#~ISPEP~#~FAMILYNAME1~#~NAME1~#~FAMILYNAME2~#~NAME2~#~LRCOUNTRY~#~LRPOSITION~#~LRDECISIONNO~#~LRID~#~LRIDDATE~#~LRIDPLACE~#~LRADDRESS~#~LRCONTACT~#~LRPRIPHONE~#~LRALTPHONE~#~LRFAX~#~LREMAIL~#~ISREPRESENTATIVE~#~LRNAME~#~LRSEX~#~LRDOB~#~JOB~#~WORKUNIT~#~CFTYPE~#~ISPROFESSION~#~FULLNAMEACCENTED~#~ISEXISTS~#~PROFESSIONFRDATE~#~PROFESSIONTODATE~#~SEACCOUNT~#~CIACCOUNT~#~SECIF~#~LRIDTYPER~#~IDTYPECK~#~IDCODECK~#~IDDATECK~#~IDEXPDATEDCK~#~IDPLACECK~#~MOBILEGT~#~TLIDGT';
        when upper('CF.CFAUTH_FIELDS') then l_returnvalue := 'AUTOID~#~CUSTID~#~CUSTNAME~#~IDCODE~#~IDDATE~#~IDPLACE~#~EFDATE~#~EXDATE~#~ADDRESS~#~POSITION~#~SEX~#~BIRTHDATE~#~RELATIONSHIP~#~REGADDRESS~#~COUNTRY~#~EMAIL~#~MOBILE~#~AUTH_ALL~#~AUTH_ORDER~#~AUTH_CASH~#~AUTH_INFOR~#~FAX~#~OTHERCOUNTRY~#~AUTHCERT~#~ALTPHONE~#~IDTYPE';
        when upper('CF.CFCONTACT_FIELDS') then l_returnvalue := 'AUTOID~#~CUSTID~#~FULLNAME~#~IDCODE~#~IDDATE~#~IDPLACE~#~ADDRESS~#~POSITION~#~SEX~#~BIRTHDATE~#~RELATIONSHIP~#~REGADDRESS~#~COUNTRY~#~EMAIL~#~MOBILE';
        when upper('CF.FATCA_FIELDS') then l_returnvalue := 'CUSTID~#~ISUSCITIZEN~#~ISUSPLACEOFBIRTH~#~ISUSMAIL~#~ISUSPHONE~#~ISUSTRANFER~#~ISAUTHRIGH~#~ISSOLEADDRESS~#~OPNDATE~#~ISDISAGREE~#~ISOPPOSITION~#~ISUSSIGN~#~REOPNDATE~#~W9ORW8BEN~#~FULLNAME~#~ROOMNUMBER~#~CITY~#~STATE~#~NATIONAL~#~ZIPCODE~#~ISSSN~#~ISIRS~#~OTHER~#~W8MAILROOMNUMBER~#~W8MAILCITY~#~W8MAILSTATE~#~W8MAILNATIONAL~#~W8MAILZIPCODE~#~IDENUMTAX~#~FOREIGNTAX~#~REF~#~FIRSTCALL~#~FIRSTNOTE~#~SECONDCALL~#~SECONDNOTE~#~THIRTHCALL~#~THIRTHNOTE~#~ISUS~#~SIGNDATE~#~NOTE';
        when upper('prefix_report') then l_returnvalue := '$#Reports\';
        --h?ng s? thông tin công ty
        when upper('sysvar.brname') then l_returnvalue := 'EVEREST';
        when upper('sysvar.brname_fullname') then l_returnvalue := 'CÔNG TY C? PH?N EVEREST';
        when upper('sysvar.website') then l_returnvalue := 'https://www.eves.com.vn/';
        when upper('sysvar.info_email') then l_returnvalue := 'info@evs.vn';
        when upper('sysvar.address') then l_returnvalue := 'T?ng 2 - Tòa nhà VNT Tower, S? 19 Nguy?n Trãi, Thanh Xuân, Hà N?i';
        when upper('sysvar.phone_fax') then l_returnvalue := 'Ði?n tho?i: +84 46 2539861 Fax: (+84)-24-39364542';
        when upper('sysvar.brname_fullname_sms') then l_returnvalue := 'Cong ty co phan chung khoan EVEREST';

        Else l_returnvalue := '-1';
    END CASE;

    return l_returnvalue;
END FN_SYSTEMNUMS;
/

DROP FUNCTION fn_to_date
/

CREATE OR REPLACE 
FUNCTION fn_to_date (p_date VARCHAR2, p_format VARCHAR2,p_default DATE DEFAULT null  )
                                          
  return DATE  is
 

BEGIN
    RETURN  to_date (p_date,p_format  );

    
exception
  when others then
    return p_default;
end;
/

DROP FUNCTION fn_totalqtty
/

CREATE OR REPLACE 
FUNCTION fn_totalqtty (P_EERQTTY VARCHAR2,P_eeYQTTY VARCHAR2)
  return number is
   l_TOTAL  number ;
BEGIN
  RETURN P_EERQTTY+P_eeYQTTY;
exception
  when others then
    return 0;
end;
/

DROP FUNCTION fn_xml2obj4field
/

CREATE OR REPLACE 
FUNCTION fn_xml2obj4field (p_xmlmsg    VARCHAR2, P_FIELD VARCHAR2) RETURN varchar IS
    l_parser   xmlparser.parser;
    l_doc      xmldom.domdocument;
    l_nodeList xmldom.domnodelist;
    l_node     xmldom.domnode;

    l_fldname fldmaster.fldname%TYPE;
    l_txmsg   tx.msg_rectype;
      pkgctx plog.log_ctx;
  BEGIN
    plog.setbeginsection (pkgctx, 'fn_xml2obj4field');

    plog.debug(pkgctx,'msg length: ' || length(p_xmlmsg));
    l_parser := xmlparser.newparser();
    plog.debug(pkgctx,'1');
    xmlparser.parseclob(l_parser, p_xmlmsg);
    plog.debug(pkgctx,'2');
    l_doc := xmlparser.getdocument(l_parser);
    plog.debug(pkgctx,'3');
    xmlparser.freeparser(l_parser);

    plog.debug(pkgctx,'Prepare to parse Message Header');
    l_nodeList := xslprocessor.selectnodes(xmldom.makenode(l_doc),
                                           '/TransactMessage');


    --<<Begin of fields transformation>>
    plog.debug(pkgctx,'Prepare to parse Message Fields');
    l_nodeList := xslprocessor.selectnodes(xmldom.makenode(l_doc),
                                           '/TransactMessage/fields/entry');

    FOR i IN 0 .. xmldom.getlength(l_nodeList) - 1 LOOP
      plog.debug(pkgctx,'parse fields: ' || i);
      l_node := xmldom.item(l_nodeList, i);
      l_fldname := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                           'fldname'));

     IF l_fldname = P_FIELD THEN

    /* plog.ERROR(pkgctx,' l_fldname99: '||l_fldname);
     plog.ERROR(pkgctx,' l_fldname100: '|| xmldom.getnodevalue(xmldom.getfirstchild(l_node)));*/

     RETURN  xmldom.getnodevalue(xmldom.getfirstchild(l_node));

     END  IF;



    END LOOP;

RETURN NULL;
  EXCEPTION
    WHEN OTHERS THEN
      --dbms_lob.freetemporary(p_xmlmsg);

      plog.error(pkgctx, SQLERRM);
      plog.error (pkgctx, 'Loi tai dong: ' || dbms_utility.format_error_backtrace);
      plog.setendsection(pkgctx, 'fn_xml2obj4field');
      RETURN NULL;

  END fn_xml2obj4field;
/

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

    /*hash_value_str := rawtohex(
    DBMS_CRYPTO.Hash (
        UTL_I18N.STRING_TO_RAW (input_string, 'AL32UTF8'),
        2)
    );*/
    select STANDARD_HASH(input_string,'SHA256') into hash_value_str from dual;

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
    select rownum stt, sbdate
    from (
    select sbdate
    from sbcldr where holiday = 'N'
    and sbdate >= p_frdate
    ORDER BY sbdate
    ) a)
    where  p_days + 1 = stt;

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
    and sbdate <= p_frdate
    ORDER BY sbdate desc
    ) a)
    where  p_days + 1 = stt;

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
as 		tem varchar2(50);
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

DROP FUNCTION transfer_seri
/

CREATE OR REPLACE 
FUNCTION transfer_seri (value VARCHAR2,value2 varchar2)
RETURN VARCHAR2

as
            l_value     varchar2(5000);
begin
          l_value := replace(value,value2||'~');
            RETURN  trim(l_value);
END;
/

