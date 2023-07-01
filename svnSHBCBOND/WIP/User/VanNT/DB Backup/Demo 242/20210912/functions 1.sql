DROP FUNCTION account_is_agency
/

CREATE OR REPLACE 
FUNCTION account_is_agency 
(
  P_ACCTNO IN VARCHAR2 
, P_SYMBOL IN VARCHAR2 
) RETURN VARCHAR2 AS 
l_count numeric;
BEGIN
      l_count:=0;
            
            select count(1) into l_count
            from sbsedefacct s
            where p_acctno = s.refafacctno and s.symbol = p_symbol;
            if (l_count = 0) then
        return '0';
      end if;
      return '1';
--          return decode(l_count,0, '0', '1');
END ACCOUNT_IS_AGENCY;
/

DROP FUNCTION buildamtexp
/

CREATE OR REPLACE 
FUNCTION buildamtexp (strAMTEXP IN varchar2,
    strTxnum IN VARCHAR2,
    strtxdate IN VARCHAR2)
  RETURN  varchar2
  IS
  v_strEvaluator varchar2(100);
  v_strElemenent  varchar2(20);
  v_lngIndex number(10,0);
  v_strNodedata varchar2(10);
BEGIN
    v_strEvaluator := '';
    v_lngIndex := 1;
    While v_lngIndex < Length(strAMTEXP) loop
        --Get 02 charatacters in AMTEXP
        v_strElemenent := substr(strAMTEXP, v_lngIndex, 2);
        if v_strElemenent in ( '++', '--', '**', '//', '((', '))') then
                --Operand
                v_strEvaluator := v_strEvaluator || substr(v_strElemenent,1,1);
        else
                --Operator
                select nvalue into v_strNodedata from tllogfld where txnum =strTxnum and txdate =to_date(strtxdate,'DD/MM/YYYY') and fldcd=v_strElemenent;
                v_strEvaluator := v_strEvaluator || v_strNodedata;
        End if;
        v_lngIndex := v_lngIndex + 2;
    end loop;
    RETURN v_strEvaluator;
EXCEPTION
   WHEN OTHERS THEN
    RETURN '0';
END;
/

DROP FUNCTION cal_new_duedate
/

CREATE OR REPLACE 
FUNCTION cal_new_duedate (oldduedate date, p_product varchar2, p_symbol varchar2)
RETURN date
as
    l_termval   number;
    l_date date;
    l_count NUMBER;
BEGIN
    select count(1) into l_count
    from product
    where shortname = p_product and effdate<=oldduedate and oldduedate<=expdate;
    IF (l_count<>0) then
        select termval into l_termval
        from product
        where shortname = p_product AND symbol = p_symbol and effdate<=oldduedate and oldduedate<=expdate;
    ELSE 
        L_TERMVAL := 0;
    END IF;
    return (ADD_MONTHS(nvl(oldduedate, getcurrdate()), l_termval));
end;
/

DROP FUNCTION check_agency
/

CREATE OR REPLACE 
FUNCTION check_agency (p_acctno varchar2)
 RETURN NUMBER
 
as
    l_count number;
BEGIN
    
    l_count:=0;
            
            select count(1) into l_count
            from sbsedefacct s
            where p_acctno = s.refafacctno;
            
            if (l_count=0) then return 0;end if;
            return 1;

end;
/

DROP FUNCTION check_public
/

CREATE OR REPLACE 
FUNCTION check_public (p_custodycd varchar2, p_afacctno varchar2, p_tlid varchar2)
 RETURN NUMBER
 
as
    l_acctno varchar2(50);
    l_count number;
    
-- created by Phong.Do
-- Kiem tra xem tai khoan p_afacctno co duoc public voiw p_custodycd khong!!! 
begin
    l_count:=0;
-- truong hop user la khach hang, nha dau tu
    if (p_tlid='686868') then
        -- neu la chinh no thi ok, cho phep hien thi voi chinh no (return 1)
        select custid into l_acctno from cfmast where custodycd = p_custodycd;
        if (p_afacctno = l_acctno) then return 1; end if;
    else
        -- truong hop user la nhom care by 
        -- neu p_afacctno thuoc vao danh sach quan ly cua thang co tlid = p_tlid thi tra ve 1
        SELECT count(1) INTO l_count
        FROM cfmast c inner join tlgrpusers t on c.careby = t.grpid
        where p_afacctno = c.custid AND t.tlid = p_tlid;
        if (l_count <> 0)
            then
                return 1;
            end if;
        
    end if;
    return 0;
EXCEPTION WHEN OTHERS THEN RETURN -1;
end;
/

DROP FUNCTION conver_number_to_char
/

CREATE OR REPLACE 
FUNCTION conver_number_to_char (value VARCHAR2)
RETURN VARCHAR2

as
            l_return    varchar2(50);
            l_value     varchar2(50);
            i           NUMBER;
            l_count         NUMBER;
begin
            i:= 0 ;
           l_return:= '';
          l_value:='';
          -- select substring(value, l_count -2  , 3 ) into l_return;
            select length(value) into l_count FROM DUAL;
            while (i<l_count ) loop
            if(i+4 > l_count) then
            l_value:= concat ( SUBSTR(value, (l_count -2- i), 3 )  , l_value) ;
            --l_return:= substring(value, l_count -2 -i , 3 );
         else
          l_value:= concat (concat(',', SUBSTR(value, (l_count -2- i), 3 ))  , l_value) ;
         end if;
            i:= i+3;
            end loop;
            RETURN  trim(l_value);
END;
/

DROP FUNCTION convert_dayofweek
/

CREATE OR REPLACE 
FUNCTION convert_dayofweek (p_dayofweek varchar2)
RETURN varchar2
AS
v_result VARCHAR2(100);
v_dayofweek VARCHAR2(100);
BEGIN
    v_dayofweek := UPPER(TRIM(p_dayofweek));
    IF v_dayofweek = 'SUNDAY' THEN
       v_result := '1';
    ELSIF v_dayofweek = 'MONDAY' THEN
       v_result := '2';
    ELSIF v_dayofweek = 'TUESDAY' THEN
       v_result := '3';
    ELSIF v_dayofweek = 'WEDNESDAY' THEN
       v_result := '4';
    ELSIF v_dayofweek = 'THURSDAY' THEN
       v_result := '5';
    ELSIF v_dayofweek = 'FRIDAY' THEN
       v_result := '6';
    ELSIF v_dayofweek = 'SATURDAY' THEN
       v_result := '7';
    END IF;

    RETURN v_result;
EXCEPTION WHEN OTHERS THEN
    RETURN '';
END;
/

DROP FUNCTION convert_to_day
/

CREATE OR REPLACE 
FUNCTION convert_to_day ( p_termcd VARCHAR2 , p_value NUMBER )
 RETURN number

as


 v_result  number;
 l_termval  number;
 l_termcd  varchar2(20);
 l_days     number;
 l_symbol varchar2(200);
 l_weeks    number;
 l_months   number;
 l_count    number ;
    pkgctx plog.log_ctx;
  logrow tlogdebug%rowtype;
BEGIN


    v_result:= 0 ;

    if p_termcd = 'M' then
        v_result:= ADD_MONTHS(getcurrdate(),p_value) - getcurrdate();
    else
         if p_termcd = 'W' then
             v_result:= p_value * 7;

        else
             if p_termcd = 'D' then
                v_result := p_value;
             end if;
        end if;
    end if;
    RETURN nvl(v_result,0);

exception
  when others then
    return 0;-- ban dau return -1, nhung
end;
/

DROP FUNCTION converttvkdau
/

CREATE OR REPLACE 
FUNCTION converttvkdau (p_string VARCHAR2)
RETURN VARCHAR2
AS
BEGIN
RETURN
TRANSLATE( p_string, 'áà?ã?a?????â?????déè???ê?????íì?i?óò?õ?ô?????o?????úù?u?u?????ý????ÁÀ?Ã?A?????Â?????ÐÉÈ???Ê?????ÍÌ?I?ÓÒ?Õ?Ô?????O?????ÚÙ?U?U?????Ý????', 'aaaaaaaaaaaaaaaaadeeeeeeeeeeeiiiiiooooooooooooooooouuuuuuuuuuuyyyyyAAAAAAAAAAAAAAAAADEEEEEEEEEEEIIIIIOOOOOOOOOOOOOOOOOUUUUUUUUUUUYYYYY' );
END;
/

DROP FUNCTION count_limit_product
/

CREATE OR REPLACE 
FUNCTION count_limit_product
  ( p_shortname IN VARCHAR2,
  p_symbol in VARCHAR2,
  p_afacctno in varchar2
  )
  RETURN  NUMBER IS
--
-- To modify this template, edit file FUNC.TXT in TEMPLATE
-- directory of SQL Navigator
--
-- Purpose: Briefly explain the functionality of the function
--
-- MODIFICATION HISTORY
-- Person      Date    Comments
-- ---------   ------  -------------------------------------------
   l_count                 NUMBER;
   -- Declare program variables as shown above
BEGIN
    SELECT COUNT(*) INTO l_count from limits where product = p_shortname and acctno = p_afacctno and symbol = p_symbol;
    RETURN l_count ;
EXCEPTION
   WHEN others THEN
       return -1 ;
END;
/

DROP FUNCTION count_ordered_product
/

CREATE OR REPLACE 
FUNCTION count_ordered_product
  (
  p_productid IN NUMBER
 /* p_shortname IN VARCHAR2,
  p_symbol IN VARCHAR2,
  p_afacctno in VARCHAR2*/
  )
  RETURN  NUMBER IS
  l_shortname varchar2 (100);
  l_symbol varchar2 (100);
  l_afacctno varchar2 (100);
--
-- To modify this template, edit file FUNC.TXT in TEMPLATE
-- directory of SQL Navigator
--
-- Purpose: Briefly explain the functionality of the function
--
-- MODIFICATION HISTORY
-- Person      Date    Comments
-- ---------   ------  -------------------------------------------
   l_count                 NUMBER;
   -- Declare program variables as shown above
BEGIN
    SELECT COUNT(1) INTO l_count from oxmast m where m.productid = p_productid and m.status <> 'R';
    RETURN l_count ;
EXCEPTION
   WHEN others THEN
       return -1 ;
END;
/

DROP FUNCTION count_oxmast_product
/

CREATE OR REPLACE 
FUNCTION count_oxmast_product
  (
  p_productid IN NUMBER
 /* p_shortname IN VARCHAR2,
  p_symbol IN VARCHAR2,
  p_afacctno in VARCHAR2*/
  )
  RETURN  NUMBER IS
  l_shortname varchar2 (100);
  l_symbol varchar2 (100);
  l_afacctno varchar2 (100);
--
-- To modify this template, edit file FUNC.TXT in TEMPLATE
-- directory of SQL Navigator
--
-- Purpose: Briefly explain the functionality of the function
--
-- MODIFICATION HISTORY
-- Person      Date    Comments
-- ---------   ------  -------------------------------------------
   l_count                 NUMBER;
   -- Declare program variables as shown above
BEGIN
    SELECT COUNT(1) INTO l_count from oxmast m where m.productid = p_productid and m.status <> 'R' and m.txdate = getcurrdate();
    RETURN l_count ;
EXCEPTION
   WHEN others THEN
       return -1 ;
END;
/

DROP FUNCTION count_payment_schd_intschd
/

CREATE OR REPLACE 
FUNCTION count_payment_schd_intschd( p_autoid in varchar2)
  RETURN  NUMBER IS
--
-- To modify this template, edit file FUNC.TXT in TEMPLATE
-- directory of SQL Navigator
--
-- Purpose: Briefly explain the functionality of the function
--
-- MODIFICATION HISTORY
-- Person      Date    Comments
-- ---------   ------  -------------------------------------------
   l_count                 NUMBER;
   -- Declare program variables as shown above
BEGIN
    for rec in (select * from intschd where autoid = p_autoid)
        loop
        SELECT COUNT(*) INTO l_count from payment_schd p where p.symbol = rec.symbol and p.paytype = 'INT' and p.castatus <> 'N'
        and p.fromperiod <= rec.periodno and p.toperiod >= rec.periodno
        ;
    end loop;
    RETURN l_count ;
EXCEPTION
   WHEN others THEN
       return -1 ;
END;
/

DROP FUNCTION datediff
/

CREATE OR REPLACE 
FUNCTION datediff (DatePart IN char, FromDate IN Date, ToDate IN Date)
  RETURN number IS

    v_DatePart varchar2(20);
    v_Result number(18,5);
    v_MonthFrom number(18,0);
    v_MonthTo number(18,0);
    v_YearFrom number(18,0);
    v_YearTo number(18,0);

BEGIN
    v_DatePart := trim(lower(DatePart));

    v_MonthFrom := to_number(to_char(FromDate,'MM'));
    v_MonthTo := to_number(to_char(ToDate,'MM'));

    v_YearFrom := to_number(to_char(FromDate,'RRRR'));
    v_YearTo := to_number(to_char(ToDate,'RRRR'));

    if v_DatePart = 'd' or v_DatePart = 'day' then
        v_Result := ToDate - FromDate;
    elsif v_DatePart = 'm' or v_DatePart = 'month' then
        v_Result := 12*(v_YearTo - v_YearFrom) + (v_MonthTo - v_MonthFrom);
    elsif v_DatePart = 'q' or v_DatePart = 'quarter' then
        v_Result := 12*(v_YearTo - v_YearFrom) + (v_MonthTo - v_MonthFrom);
        v_Result := floor(v_Result/3);
    elsif v_DatePart = 'h' or v_DatePart = 'halfyear' then
        v_Result := 12*(v_YearTo - v_YearFrom) + (v_MonthTo - v_MonthFrom);
        v_Result := floor(v_Result/6);
    elsif v_DatePart = 'y' or v_DatePart = 'year' then
        v_Result := v_YearTo - v_YearFrom;
    end if;

    RETURN v_Result;


END;
/

DROP FUNCTION dec2hex
/

CREATE OR REPLACE 
FUNCTION dec2hex (N in number) RETURN varchar2 IS
  hexval varchar2(64);
  N2     number := N;
  digit  number;
  hexdigit  char;
BEGIN
  while ( N2 > 0 ) loop
     digit := mod(N2, 16);
     if digit > 9 then
       hexdigit := chr(ascii('A') + digit - 10);
     else
       hexdigit := to_char(digit);
     end if;
     hexval := hexdigit || hexval;
     N2 := trunc( N2 / 16 );
  end loop;
  return hexval;
END;
/

DROP FUNCTION dtoc
/

CREATE OR REPLACE 
FUNCTION dtoc ( pv_Date IN Date) RETURN  varchar2 IS

-- Purpose: Chuyen bien kieu Date sang bien kieu character
--
-- MODIFICATION HISTORY
-- Person       Date            Comments
-- ---------    ------         -------------------------------------------
-- TUNH         02/05/2008      Created

   v_format  varchar2(10);

BEGIN
    v_format := 'DD/MM/RRRR';
    RETURN to_char(pv_Date,v_format);

EXCEPTION
    WHEN OTHERS THEN
        RETURN NULL;

END;
/

DROP FUNCTION extractstr
/

CREATE OR REPLACE 
FUNCTION extractstr 
  ( STR VARCHAR2,
    DELIMITER CHAR,
    POST INTEGER)
  RETURN  VARCHAR2 IS
  E INTEGER;
  tmp INTEGER;
  tmpSTR VARCHAR2(200);
BEGIN
  E:=INSTR(STR,DELIMITER);
  if E>0 then
    tmp:=1;
    tmpSTR:=STR;
    WHILE tmp<POST LOOP
    tmpSTR:=SUBSTR(tmpSTR,E+1,LENGTH(tmpSTR)-E);
    E:=INSTR(tmpSTR,DELIMITER);
    tmp:=tmp+1;
    END LOOP;
    RETURN SUBSTR(tmpSTR,1,E-1);
  else
    if POST=1 then
      return STR;
    else
      return '';
    end if;
  end if;
EXCEPTION
   WHEN OTHERS THEN
      RETURN '';

END;
/

DROP FUNCTION fn_balance_trade
/

CREATE OR REPLACE 
FUNCTION fn_balance_trade (P_SYMBOL VARCHAR2,PV_CUSTODYCD VARCHAR2,P_DATE DATE)
  return number is
   l_trade  number ;
BEGIN
   l_trade := 0;
 select max(nvl(se.trade, 0)+ nvl(se.secured,0) + nvl(se.netting,0)+nvl(se.sending,0)+nvl(se.blocked,0)  - nvl(tr.trade, 0))
    INTO l_trade
    from semast se,
         (SELECT ACCTNO,
                 SUM(CASE
                          WHEN TXTYPE = 'D' THEN
                           -NAMT
                          ELSE
                           NAMT
                        END)
                       TRADE
            FROM VW_SETRAN_GEN
           WHERE DELTD <> 'Y'
             AND FIELD IN ('TRADE','SECURED','NETTING','SENDING','BLOCKED')
             and busdate > P_DATE
           GROUP BY ACCTNO) tr
   where se.Symbol = P_SYMBOL
     and se.acctno = tr.ACCTNO(+)
     and SE.CUSTODYCD = PV_CUSTODYCD;
  RETURN l_trade;
exception
  when others then
    return 0;
end;
/

DROP FUNCTION fn_bank_bidcode
/

CREATE OR REPLACE 
FUNCTION fn_bank_bidcode (p_acount      varchar2,p_bankcode  varchar2
                                          )
  return string is
  v_fullname varchar2(500);
  v_count    number;

BEGIN
    v_fullname:=p_bankcode;
    SELECT COUNT(*) INTO v_count FROM bank t  where upper(t.bankcode) = upper(p_acount);
   IF v_count>0 THEN
        select max(t.bidcode)
          into v_fullname
          from bank t
         where upper(t.bankcode) = upper(p_acount);
   END IF;
       RETURN v_fullname;
exception
  when others then
    return p_bankcode;
end;
/

DROP FUNCTION fn_bank_citadcode
/

CREATE OR REPLACE 
FUNCTION fn_bank_citadcode (p_acount      varchar2,p_bankcode  varchar2
                                          )
  return string is
  v_fullname varchar2(500);
  v_count    number;

BEGIN
    v_fullname:=p_bankcode;
    SELECT COUNT(*) INTO v_count FROM bank t  where upper(t.bankcode) = upper(p_acount);
   IF v_count>0 THEN
        select max(t.citadcode)
          into v_fullname
          from bank t
         where upper(t.bankcode) = upper(p_acount);
   END IF;
       RETURN v_fullname;
exception
  when others then
    return p_bankcode;
end;
/

DROP FUNCTION fn_cal_cbond_price
/

CREATE OR REPLACE 
FUNCTION fn_cal_cbond_price (v_codeid varchar2, v_yield number)
RETURN number

as
    v_count number;
    v_return number;
    v_rate number;
    v_coupon number;
    v_principal number;
    v_amt number;
    v_tax number;
    v_period number;
    v_parvalue number;
    v_days number;
    v_intbased number;
    v_c1 number;
    v_duedate date;
    v_opndate date;

    CURSOR c1
        IS
        select valuedt - prevdate days, amount, nvl(nvl(f1.feerate, f2.feerate),0) tax
        from
        (select a.valuedt, a.amount, max(nvl(b.valuedt, a.opndate)) prevdate
                from
                (select a.valuedt, a.amount,
                        --nvl(b.intratebaseddt, b.opndate) intratebaseddt
                        b.opndate
                        from payment_hist a, assetdtl b
                        WHERE a.symbol = v_codeid AND a.payment_STATUS='P' and a.paytype = 'INT'
                            and a.symbol = b.symbol and b.status = 'A'
                            and a.valuedt >= getcurrdate()
                 ) a
                 left join (select valuedt
                            from payment_hist
                            WHERE symbol = v_codeid and paytype = 'INT') b
                 on b.valuedt < a.valuedt
                 group by a.valuedt, a.amount) a
                 left join feetype f1
                    on f1.feetype = '010'
                        and f1.symbol = v_codeid
                        and f1.status = 'A'
                        and f1.frdate <= a.valuedt
                        and f1.todate > a.valuedt
                 left join feetype f2
                    on f2.feetype = '010'
                        and f2.symbol = 'ALL'
                        and f2.status = 'A'
                        and f2.frdate <= a.valuedt
                        and f2.todate > a.valuedt
        order by valuedt;
    r_sales c1%ROWTYPE;
begin
    v_return := 0;
    v_days := 0;
    v_c1 := 0;

    SELECT a.intrate, a.parvalue, case when a.intbaseddofy = 'N' then 360 else 365 end intbased,
            a.duedate, a.opndate
        INTO v_coupon, v_parvalue, v_intbased, v_duedate, v_opndate
    FROM assetdtl a
    WHERE symbol=v_codeid;

    v_period := 0;

    OPEN c1;
    LOOP
        FETCH c1 INTO r_sales;
        SELECT r_sales.days, r_sales.amount, r_sales.tax INTO v_days, v_amt, v_tax FROM dual;
        EXIT WHEN c1%NOTFOUND;
        v_period := v_period+1;
        --v_return := v_return + v_amt/POWER((1 + (v_coupon - v_yield)/v_coupon * (v_amt / v_parvalue)),v_period);
        v_return := v_return + (v_amt  - ROUND(v_amt * v_tax / 100 ,0))/power(1+v_yield/100 * v_days / v_intbased,v_period);
        v_c1 := v_days;
    END LOOP;
    CLOSE c1;

    select count(1) into v_count
    from payment_hist
    WHERE symbol = v_codeid AND payment_STATUS='P' and paytype = 'PRI';

    if v_count > 0 then
        if v_period = 0 then
            v_c1 := v_duedate - v_opndate;
            v_period := 1;
        end if;
        select sum(amount) into v_principal
        from payment_hist
        WHERE symbol = v_codeid AND payment_STATUS='P' and paytype = 'PRI';

        v_return := v_return + v_principal/power(1+v_yield/100 * v_c1 / v_intbased,v_period);
    end if;

    return round(v_return,4);
exception
    when others then
        return 0;

END;
/

DROP FUNCTION fn_cal_cbond_price_lump
/

CREATE OR REPLACE 
FUNCTION fn_cal_cbond_price_lump (v_codeid varchar2, v_yield number)
 RETURN number

as
    v_count number;
    v_return number;
    v_rate number;
    v_coupon number;
    v_principal number;
    v_amt number;
    v_period number;
    v_parvalue number;
    v_days number;
    v_intbased number;
    v_c1 number;
    v_duedate date;
    v_opndate date;


begin
    v_return := 0;
    v_days := 0;
    v_c1 := 0;

    select c.amount, a.duedate-1 - nvl(max(b.valuedt), a.opndate) days
            into v_amt, v_days
    from
        (select b.opndate, b.duedate, min(a.valuedt) valuedt
        from payment_hist a, assetdtl b
        WHERE a.symbol = v_codeid AND a.payment_STATUS='P' and a.paytype = 'INT'
            and a.symbol = b.symbol and b.status = 'A'
            and a.valuedt >= getcurrdate()
        group by b.opndate, b.duedate
        ) a
        inner join
            (select sum(amount - round(amount * nvl(nvl(f1.feerate,f2.feerate),0) /100,0))
                    amount
            from payment_hist a
                left join feetype f1
                    on f1.feetype = '010'
                        and f1.symbol = v_codeid
                        and f1.status = 'A'
                        and f1.frdate <= a.valuedt
                        and f1.todate > a.valuedt
                        and a.paytype = 'INT'
                 left join feetype f2
                    on f2.feetype = '010'
                        and f2.symbol = 'ALL'
                        and f2.status = 'A'
                        and f2.frdate <= a.valuedt
                        and f2.todate > a.valuedt
                        and a.paytype = 'INT',
                assetdtl b
            WHERE a.symbol = v_codeid
                AND a.payment_STATUS='P'
                and a.symbol = b.symbol
                and b.status = 'A'
                and a.valuedt >= getcurrdate()) c
            on 1=1
        left join (select valuedt
                    from payment_hist
                    WHERE symbol = v_codeid and paytype = 'INT') b
            on b.valuedt < a.valuedt
    group by a.duedate, a.opndate, c.amount
        ;


    SELECT a.intrate, a.parvalue, case when a.intbaseddofy = 'N' then 360 else 365 end intbased,
            a.duedate, a.opndate
        INTO v_coupon, v_parvalue, v_intbased, v_duedate, v_opndate
    FROM assetdtl a
    WHERE symbol=v_codeid;

    v_return := v_amt/(1+v_yield/100*v_days/v_intbased);

    return round(v_return,0);
exception
    when others then
        return 0;

END;
/

DROP FUNCTION fn_cal_days_by_term
/

CREATE OR REPLACE 
FUNCTION fn_cal_days_by_term (p_termcd varchar2, p_value number)
 RETURN number

as
    l_return number;
BEGIN

    if p_termcd='M' then
    l_return:= p_value * 31;
    end if;
    if p_termcd='W' then
    l_return:= p_value * 7;
    end if;
    if p_termcd='D' then
    l_return:= p_value ;
    end if;
    return l_return;
exception
    when others then
        return -1;
END;
/

DROP FUNCTION fn_cal_limit_buy_remain_prd
/

CREATE OR REPLACE 
FUNCTION fn_cal_limit_buy_remain_prd (p_afacctno varchar2, p_symbol varchar2, p_product varchar2)
RETURN number

as
    l_count number;
    l_limitval number;
    l_limit_total_remain number;
    l_limit_total number;
begin
    l_limit_total:= fn_get_limit_buy_product(p_afacctno, p_symbol, p_product);

    if l_limit_total is not null then

        SELECT
                    GREATEST (l_limit_total - nvl(SUM((nvl(b.QTTY, 0)- nvl(b.RETURN_QTTY , 0) ) * DECODE(fn_get_limit_method_buy_prd(p_afacctno, p_symbol, p_product), 'F', nvl(b.PARVALUE, 0), 'P', nvl(b.PRICE , 0))), 0), 0)
                    INTO l_limit_total_remain
                            FROM
                            boughtdtl b where
                             b.TRNTYPE = 'D'
                            AND b.DELTD = 'N'
                            and b.symbol = p_symbol
                            and b.product = p_product
                            AND b.ACCTNO = p_afacctno;
    else
    l_limit_total_remain:=null;
    end if;

        RETURN l_limit_total_remain;
exception
    when others then
        return -2;

END;
/

DROP FUNCTION fn_cal_limit_buy_remain_symbol
/

CREATE OR REPLACE 
FUNCTION fn_cal_limit_buy_remain_symbol (p_afacctno varchar2, p_symbol varchar2)
RETURN number

as
    l_count number;
    l_limitval number;
    l_limit_total_remain number;
    l_limit_total number;
begin
    l_limit_total:= fn_get_limit_buy_symbol(p_afacctno, p_symbol);

    if l_limit_total is not null then

        SELECT
                    GREATEST (l_limit_total - nvl(SUM((nvl(b.QTTY, 0)- nvl(b.RETURN_QTTY , 0) ) * DECODE(fn_get_limit_method_buy_symbol(p_afacctno, p_symbol), 'F', nvl(b.PARVALUE, 0), 'P', nvl(b.PRICE , 0))), 0), 0)
                    INTO l_limit_total_remain
                            FROM
                            boughtdtl b where
                             b.TRNTYPE = 'D'
                            AND b.DELTD = 'N'
                            and b.symbol = p_symbol
                            AND b.ACCTNO = p_afacctno;
    else
    l_limit_total_remain:=null;
    end if;

        RETURN l_limit_total_remain;
exception
    when others then
        return -2;

END;
/

DROP FUNCTION fn_cal_limit_buy_remain_total
/

CREATE OR REPLACE 
FUNCTION fn_cal_limit_buy_remain_total (p_afacctno varchar2)
RETURN number

as
    l_count number;
    l_limitval number;
    l_limit_total_remain number;
    l_limit_total number;
begin
    l_limit_total:= fn_get_limit_buy_total(p_afacctno);

    if l_limit_total is not null then

        SELECT
                    GREATEST (l_limit_total - nvl(SUM((nvl(b.QTTY, 0)- nvl(b.RETURN_QTTY , 0) ) * DECODE(fn_get_limit_method_buy_total(p_afacctno), 'F', nvl(b.PARVALUE, 0), 'P', nvl(b.PRICE , 0))), 0), 0)
                    INTO l_limit_total_remain
                            FROM
                            boughtdtl b where
                             b.TRNTYPE = 'D'
                            AND b.DELTD = 'N'
                            AND b.ACCTNO = p_afacctno;
    else
    l_limit_total_remain:=null;
    end if;

        RETURN l_limit_total_remain;
exception
    when others then
        return -2;

END;
/

DROP FUNCTION fn_cal_limit_prd_remain_day
/

CREATE OR REPLACE 
FUNCTION fn_cal_limit_prd_remain_day (p_afacctno varchar2, p_symbol varchar2, p_product varchar2)
RETURN number

as
    l_count number;
    l_limitval number;
    l_limit_product_remain number;
    l_limit_total number;
begin
    l_limit_total:= fn_get_limitval_product(p_afacctno, p_symbol, p_product);

    if l_limit_total is not null then

        SELECT
                    GREATEST (l_limit_total - nvl(SUM(o.execqtty ) * DECODE(fn_get_limit_method_prd_day(p_afacctno, p_symbol, p_product), 'F', nvl(a.PARVALUE, 0), 'P', nvl(o.PRICE*(1-o.promotion/100) , 0)), 0), 0)
                    INTO l_limit_product_remain
                             from oxmast o
                            left join assetdtl a on a.symbol= o.symbol
                            left join product p on p.autoid = o.productid
                            where o.txdate = getcurrdate
                            and o.status<>'R'
                            and o.acseller = p_afacctno
                            and o.symbol = p_symbol
                            and p.shortname = p_product
                            ;
    else
    l_limit_product_remain:=null;
    end if;

        RETURN l_limit_product_remain;
exception
    when others then
        return -2;

END;
/

DROP FUNCTION fn_cal_limit_symbol_remain_day
/

CREATE OR REPLACE 
FUNCTION fn_cal_limit_symbol_remain_day (p_afacctno varchar2, p_symbol varchar2)
RETURN number

as
    l_count number;
    l_limitval number;
    l_limit_symbol_remain number;
    l_limit_total number;
begin
    l_limit_total:= fn_get_limitval_symbol(p_afacctno, p_symbol);

    if l_limit_total is not null then

        SELECT
                    GREATEST (l_limit_total - nvl(SUM(o.execqtty ) * DECODE(fn_get_limitmethod_sell_symbol(p_afacctno, p_symbol), 'F', nvl(a.PARVALUE, 0), 'P', nvl(o.PRICE*(1-o.promotion/100) , 0)), 0), 0)
                    INTO l_limit_symbol_remain
                     FROM
                            oxmast o
                            left join assetdtl a on a.symbol= o.symbol
                            where o.txdate = getcurrdate
                            and o.status<>'R'
                            and o.acseller = p_afacctno
                            and o.symbol = p_symbol;

    else
    l_limit_symbol_remain:=null;
    end if;

        RETURN l_limit_symbol_remain;
exception
    when others then
        return -2;

END;
/

DROP FUNCTION fn_calc_limit_total_remain_day
/

CREATE OR REPLACE 
FUNCTION fn_calc_limit_total_remain_day (p_afacctno varchar2)
RETURN number

as
    l_count number;
    l_limitval number;
    l_limit_total_remain number;
    l_limit_total number;
begin
    l_limit_total:= fn_get_limitval_total_day(p_afacctno);

    if l_limit_total is not null then

        SELECT
                    GREATEST (l_limit_total - nvl(SUM(o.execqtty ) * DECODE(fn_get_limit_method_total_day(p_afacctno), 'F', nvl(a.PARVALUE, 0), 'P', nvl(o.PRICE*(1-o.promotion/100) , 0)), 0), 0)
                    INTO l_limit_total_remain
                            FROM oxmast o
                            left join assetdtl a on a.symbol = o.symbol
                            where
                            o.status <>'R'
                            and o.acseller = p_afacctno
                            and o.txdate = getcurrdate
                            ;
    else
    l_limit_total_remain:=null;
    end if;

        RETURN l_limit_total_remain;
exception
    when others then
        return -2;

END;
/

DROP FUNCTION fn_cal_limit_remain_day
/

CREATE OR REPLACE 
FUNCTION fn_cal_limit_remain_day(l_acseller varchar2, l_symbol varchar2, l_product varchar2)
 RETURN NUMBER
 IS
    pkgctx   plog.log_ctx;
    logrow   tlogdebug%ROWTYPE;
    l_count                 NUMBER;
    l_limit_total           NUMBER;
    l_limit_product         NUMBER;
    l_limit_symbol          NUMBER;
    l_limit_total_remain    NUMBER;
    l_limit_symbol_remain   NUMBER;
    l_limit_product_remain  NUMBER;
BEGIN
    plog.setBeginSection(pkgctx, 'fn_calc_limit_sell_remain');

    --      - kiem tra con du han muc ban ra
--      + lay han muc tong tu limits

        l_limit_total:=fn_get_limitval_total_day(l_acseller);
        l_limit_symbol:= fn_get_limitval_symbol_day(l_acseller,l_symbol);
        l_limit_product:= fn_get_limitval_product_day(l_acseller,l_symbol,l_product);
        l_limit_total_remain:= fn_calc_limit_total_remain_day(l_acseller);
        l_limit_symbol_remain:=fn_cal_limit_symbol_remain_day(l_acseller,l_symbol);
        l_limit_product_remain:=fn_cal_limit_prd_remain_day(l_acseller,l_symbol,l_product);
        if l_limit_total is not null or l_limit_symbol is not null or l_limit_product is not null then
        return LEAST(nvl(l_limit_total_remain,9999999999999999999999999),nvl(l_limit_symbol_remain,9999999999999999999999999),nvl(l_limit_product_remain,9999999999999999999999999));
        else return null;
        end if;
        plog.setEndSection(pkgctx, 'fn_calc_limit_sell_remain');
        RETURN null;

Exception
When others then
    return -1;
END
;
/

DROP FUNCTION fn_cal_limitsell_pro_remain
/

CREATE OR REPLACE 
FUNCTION fn_cal_limitsell_pro_remain (p_afacctno varchar2, p_symbol varchar2, p_product varchar2)
RETURN number

as
    l_count number;
    l_limitval number;
    l_limit_product_remain number;
    l_limit_total number;
begin
    l_limit_total:= fn_get_limitval_product(p_afacctno, p_symbol, p_product);

    if l_limit_total is not null then

        SELECT
                    GREATEST (l_limit_total - nvl(SUM((nvl(b.QTTY, 0)- nvl(b.RETURN_QTTY , 0) ) * DECODE(fn_get_limit_method_sell_pro(p_afacctno, p_symbol, p_product), 'F', nvl(b.PARVALUE, 0), 'P', nvl(b.PRICE , 0))), 0), 0)
                    INTO l_limit_product_remain
                            FROM
                            solddtl b where
                             b.TRNTYPE = 'D'
                            AND b.DELTD = 'N'
                            AND b.ACCTNO = p_afacctno
                            and b.symbol= p_symbol
                            and b.product= p_product;
    else
    l_limit_product_remain:=null;
    end if;

        RETURN l_limit_product_remain;
exception
    when others then
        return -2;

END;
/

DROP FUNCTION fn_cal_limitsell_symbol_remain
/

CREATE OR REPLACE 
FUNCTION fn_cal_limitsell_symbol_remain (p_afacctno varchar2, p_symbol varchar2)
RETURN number

as
    l_count number;
    l_limitval number;
    l_limit_symbol_remain number;
    l_limit_total number;
begin
    l_limit_total:= fn_get_limitval_symbol(p_afacctno, p_symbol);

    if l_limit_total is not null then

        SELECT
                    GREATEST (l_limit_total - nvl(SUM((nvl(b.QTTY, 0)- nvl(b.RETURN_QTTY , 0)  ) * DECODE(fn_get_limit_method_symbol_day(p_afacctno, p_symbol), 'F', nvl(b.parvalue, 0), 'P', nvl(b.PRICE , 0))), 0), 0)
                    INTO l_limit_symbol_remain
                           FROM
                            solddtl b where
                             b.TRNTYPE = 'D'
                            AND b.DELTD = 'N'
                            AND b.ACCTNO = p_afacctno
                            and b.symbol= p_symbol;
    else
    l_limit_symbol_remain:=null;
    end if;

        RETURN l_limit_symbol_remain;
exception
    when others then
        return -2;

END;
/

DROP FUNCTION fn_calc_amt
/

CREATE OR REPLACE 
FUNCTION fn_calc_amt (p_date         DATE,
                        p_todate       DATE,
                        p_symbol       VARCHAR2,
                        p_product      VARCHAR2,
                        p_amt          NUMBER,
                        p_custodycd    VARCHAR2)
    RETURN NUMBER
AS

    v_result         NUMBER;

    l_totalamt       NUMBER;

    pkgctx           plog.log_ctx;
    logrow           tlogdebug%ROWTYPE;
BEGIN
    v_result := 0;
    /*l_days := 0;
    l_totalday := 0;
    l_interest := 0;
    l_totalamt := p_amt;*/

    /*SELECT intrate,
           parvalue,
           CASE WHEN intbaseddofy = 'N' THEN 360 ELSE 365 END intbaseddofy,
           duedate
      INTO l_intrate,
           l_parvalue,
           l_intbaseddofy,
           l_duedate
      FROM assetdtl
     WHERE symbol = p_symbol;*/

    /*FOR r
        IN (SELECT *
              FROM payment_hist
             WHERE     symbol = l_symbol
                   AND paytype = 'INT'
                   AND reportdt >= p_date
                   AND valuedt >= p_date)
    LOOP
        l_autoid := r.autoid;
        l_intrate := r.intrate;
        l_rptdate := r.valuedt;


        l_days := r.days;
        l_interest := r.amount;


        SELECT fn_calc_fee (l_rptdate,
                            '001',
                            '',
                            l_symbol,
                            p_custodycd,
                            '',
                            '',
                            l_interest,
                            l_interest)
          INTO l_fee
          FROM DUAL;

        l_totalamt := l_totalamt + l_interest - l_fee;
    END LOOP;

    v_result := l_totalamt;*/

    SELECT SUM(NVL(a.amount, 0)
            - fn_calc_fee (p.valuedt,
                            '001',
                            '',
                            p_symbol,
                            p_custodycd,
                            '',
                            '',
                            a.amount,
                            a.amount))
     INTO l_totalamt
      FROM INTSCHD a
    inner join PAYMENT_SCHD p on a.PERIODNO <= p.TOPERIOD and a.PERIODNO>= p.FROMPERIOD and a.symbol = p.symbol
     WHERE     a.symbol = p_symbol

           and a.reportdt < p_todate
           AND a.reportdt >= p_date
            ;

    v_result := p_amt + nvl(l_totalamt, 0);

    RETURN NVL (v_result, 0);
EXCEPTION
    WHEN OTHERS
    THEN
        RETURN 0;                                  -- ban dau return -1, nhung
END;
/

DROP FUNCTION fn_calc_rate_buy
/

CREATE OR REPLACE 
FUNCTION fn_calc_rate_buy (p_productid    NUMBER,
                                 p_frdate       DATE,
                                 p_autoid       number,
                                 p_orderid        VARCHAR2)
    RETURN NUMBER
AS
    v_result        NUMBER;
    l_termval       NUMBER;
    l_termcd        VARCHAR2 (20);
    l_days          NUMBER;
    l_symbol        VARCHAR2 (200);
    l_weeks         NUMBER;
    l_months        NUMBER;
    l_autoid        NUMBER;
    l_autoidc       NUMBER;
    l_ratepayment   NUMBER;
    l_count         NUMBER;
    l_intrate       NUMBER;
    l_types         VARCHAR2 (20);
    pkgctx          plog.log_ctx;
    logrow          tlogdebug%ROWTYPE;
BEGIN
    v_result := 0;


    l_autoidc:= p_autoid;
    SELECT p.TYPE
      INTO l_types
      FROM productbuydtl p
     WHERE autoid = l_autoidc;

    SELECT symbol
      INTO l_symbol
      FROM product
     WHERE autoid = p_productid;

    IF l_types = 'F'
    THEN
        SELECT p.intrate
          INTO l_intrate
          FROM (SELECT *
                  FROM INTSCHD p
                 WHERE     p.symbol = l_symbol
                     --  AND p.paytype = 'INT'
                       AND p.status = 'A'
                       AND p.reportdt >= p_frdate
                ORDER BY reportdt) p
         WHERE ROWNUM <= 1;

        SELECT l_intrate + p.amplitude - p.feebuy
          INTO v_result
          FROM productbuydtl p
         WHERE autoid = l_autoidc;
    ELSIF l_types = 'V'
    THEN
        SELECT p.rate - p.feebuy
          INTO v_result
          FROM productbuydtl p
         WHERE autoid = l_autoidc;
    ELSE
        SELECT CASE
                   WHEN p_orderid IS NULL OR p_orderid = ''
                   THEN
                       fn_calc_rate_for_sell (p_productid,
                                              p_frdate,
                                              (SELECT duedate
                                                 FROM assetdtl
                                                WHERE symbol = l_symbol))
                   ELSE
                       NVL (intrate, 0)
               END
          INTO l_intrate
          FROM oxmast
         WHERE orderid = p_orderid;

        SELECT l_intrate + p.amplitude - p.feebuy
          INTO v_result
          FROM productbuydtl p
         WHERE autoid = l_autoidc;
    END IF;




    RETURN NVL (v_result, 0);
EXCEPTION
    WHEN OTHERS
    THEN
        RETURN 0;                                  -- ban dau return -1, nhung
END;
/

DROP FUNCTION fn_calc_amt_for_buy
/

CREATE OR REPLACE 
FUNCTION fn_calc_amt_for_buy (p_productid    NUMBER,
                                p_frdate       DATE,
                                p_todate       DATE,
                                p_orderid      VARCHAR2,
                                p_amt          NUMBER,
                                p_cstl         NUMBER)
    RETURN NUMBER
AS
    v_result           NUMBER;
    l_termval          NUMBER;
    l_termcd           VARCHAR2 (20);
    l_days             NUMBER;
    l_symbol           VARCHAR2 (200);
    l_weeks            NUMBER;
    l_months           NUMBER;
    l_autoid           NUMBER;
    l_autoidc          NUMBER;
    l_date1            DATE;
    l_date2            DATE;
    l_ratepayment      NUMBER;
    l_count            NUMBER;
    l_intrate          NUMBER;
    l_calrate_method   VARCHAR2 (20);
    pkgctx             plog.log_ctx;
    logrow             tlogdebug%ROWTYPE;
BEGIN
    v_result := 0;



    SELECT p_todate - p_frdate days,
           (p_todate - p_frdate) / 7 weeks,
           fn_monthdiff (p_frdate, p_todate) months,
           termcd
      INTO l_days,
           l_weeks,
           l_months,
           l_termcd
      FROM product
     WHERE autoid = p_productid;



    SELECT p.autoid, p.calrate_method
      INTO l_autoid, l_calrate_method
      FROM productbuydtl p
     WHERE p.id = p_productid
           AND ( (    p.termcd = 'M'
                  AND p."FROM" <= l_months
                  AND p."TO" > l_months)
                OR (    p.termcd = 'W'
                    AND p."FROM" <= l_weeks
                    AND p."TO" > l_weeks)
                OR (p.termcd = 'D' AND p."FROM" <= l_days AND p."TO" > l_days));



    IF l_calrate_method = 'F' -- neu tinh theo ngay mua dau
    THEN
        SELECT   fn_calc_rate_buy (p_productid,
                                   p_todate,
                                   l_autoid,
                                   p_orderid)
               * p_amt
               * (p_todate - p_frdate)
               / p_cstl
               / 100
               + p_amt
          INTO v_result
          FROM DUAL;
    ELSE -- tinh tu den ky mua dau
        SELECT COUNT (1)
          INTO l_count
          FROM (SELECT *
                  FROM productbuydtl p
                 WHERE     p.id = p_productid
                       AND p.autoid < l_autoid
                       AND p.calrate_method = 'F'
                ORDER BY autoid DESC) p;

        IF l_count > 0 -- lay thang ngay mua dau to nhat
        THEN
            SELECT autoid,
                   CASE
                       WHEN p.termcd = 'M' THEN ADD_MONTHS (p_frdate, p."TO")
                       WHEN p.termcd = 'D' THEN p_frdate + p."TO"
                       ELSE p_frdate + p."TO" * 7
                   END
              INTO l_autoidc, l_date1
              FROM (SELECT *
                      FROM productbuydtl p
                     WHERE     p.id = p_productid
                           AND p.autoid < l_autoid
                           AND p.calrate_method = 'F'
                    ORDER BY autoid DESC) p
             WHERE ROWNUM <= 1;

            SELECT   fn_calc_rate_buy (p_productid,
                                       l_date1,
                                       l_autoidc,
                                       p_orderid)
                   * p_amt
                   * (l_date1 - p_frdate)
                   / p_cstl
                   / 100
              INTO v_result
              FROM DUAL;

            SELECT COUNT (1)
              INTO l_count
              FROM productbuydtl p
             WHERE     p.autoid < l_autoid
                    and p.autoid> l_autoidc
                   AND p.calrate_method = 'C'
                   AND p.id = p_productid;

            IF l_count > 0 --
            THEN
                for vc in (select * from productbuydtl p WHERE     p.autoid < l_autoid  and   p.autoid> l_autoidc    AND p.calrate_method = 'C'   AND p.id = p_productid order by autoid ) loop
                    SELECT autoid,
                           CASE
                               WHEN p.termcd = 'M'
                               THEN
                                   ADD_MONTHS (p_frdate, p."TO")
                               WHEN p.termcd = 'D'
                               THEN
                                   p_frdate + p."TO"
                               ELSE
                                   p_frdate + p."TO" * 7
                           END
                      INTO l_autoidc, l_date2
                      FROM productbuydtl p
                     WHERE p.autoid = vc.autoid ;

                    SELECT   fn_calc_rate_buy (p_productid,
                                               l_date2,
                                               l_autoidc,
                                               p_orderid)
                           * p_amt
                           * (l_date2 - l_date1)
                           / p_cstl
                           / 100
                           + v_result
                      INTO v_result
                      FROM DUAL;
                      l_date1:= l_date2 ;
                  end loop ;
            ELSE
                l_date2 := l_date1;
            END IF;

            SELECT     fn_calc_rate_buy (p_productid,
                                         p_todate,
                                         l_autoid,
                                         p_orderid)
                     * p_amt
                     * (p_todate - l_date2)
                     / p_cstl
                     / 100
                   + v_result
                   + p_amt
              INTO v_result
              FROM DUAL;
        ELSE
            SELECT   fn_calc_rate_buy (p_productid,
                                       p_todate,
                                       l_autoid,
                                       p_orderid)
                   * p_amt
                   * (p_todate - p_frdate)
                   / p_cstl
                   / 100
                   + p_amt
              INTO v_result
              FROM DUAL;
        END IF;
    END IF;


    RETURN NVL (v_result, 0);
EXCEPTION
    WHEN OTHERS
    THEN
        RETURN 0;                                  -- ban dau return -1, nhung
END;
/

DROP FUNCTION fn_calc_amt_for_pl
/

CREATE OR REPLACE 
FUNCTION fn_calc_amt_for_pl (p_date         DATE,
     p_todate       DATE,
     p_symbol       VARCHAR2,
     p_product      VARCHAR2,
     p_amt          NUMBER,
     p_custodycd    VARCHAR2)
    RETURN NUMBER
AS
    l_autoid         NUMBER;
    l_intbaseddofy   NUMBER;
    l_intrate        NUMBER;
    l_parvalue       NUMBER;
    v_result         NUMBER;

    l_totalday       NUMBER;
    l_interest       NUMBER;
    l_totalamt       NUMBER;
    l_fee            NUMBER;
    l_duedate        DATE;

    l_rptdate        DATE;
    l_feebuy         NUMBER;
    l_symbol         VARCHAR2 (200);
    pkgctx           plog.log_ctx;
    logrow           tlogdebug%ROWTYPE;
BEGIN
    l_symbol := p_symbol;
    v_result := 0;

    l_interest := 0;
    l_totalamt := p_amt;

    SELECT CASE WHEN intbaseddofy = 'N' THEN 360 ELSE 365 END intbaseddofy
      INTO l_intbaseddofy
      FROM assetdtl
     WHERE symbol = l_symbol;

    SELECT p.intrate
      INTO l_intrate
      FROM (SELECT *
              FROM INTSCHD p
             WHERE     p.symbol = p_symbol

                   and p.status = 'A'
                   AND p.fromdate <= p_todate
                   AND p.todate >= p_todate 
            ORDER BY reportdt) p
     WHERE ROWNUM <= 1;

    l_interest :=
        ROUND (
            l_intrate * (p_todate - p_date) * p_amt / l_intbaseddofy / 100);
    l_totalamt := l_totalamt + l_interest;

    v_result := l_totalamt;
    RETURN NVL (v_result, 0);
EXCEPTION
    WHEN OTHERS
    THEN
        RETURN 0;                                  -- ban dau return -1, nhung
END;
/

DROP FUNCTION fn_calc_fee
/

CREATE OR REPLACE 
FUNCTION fn_calc_fee (p_txdate       DATE,
                        p_feetype      VARCHAR2,
                        p_exectype     VARCHAR2,
                        p_symbol       VARCHAR2,
                        p_custodycd    VARCHAR2,
                        p_product      VARCHAR2,
                        p_combo        VARCHAR2,
                        p_amt          NUMBER,
                        p_amtp         NUMBER)
    RETURN NUMBER
AS
    v_result         NUMBER;
    v_minresult      NUMBER;

    v_id             NUMBER;
    v_ruletype       VARCHAR (50);
    v_feecalc        VARCHAR2 (10);
    v_feerate        NUMBER;
    v_feeamt         NUMBER;
    v_minamt         NUMBER;
    v_maxamt         NUMBER;
    v_aftype         VARCHAR2 (20);
    v_dealertype     VARCHAR2 (20);
    v_typecustomer   VARCHAR2 (20);
    v_nationality    VARCHAR2 (20);


    pkgctx           plog.log_ctx;
    logrow           tlogdebug%ROWTYPE;
BEGIN
    --Xác d?nh Phân nhóm KH, Lo?i khách hàng, Qu?c t?ch, Phân lo?i NÐT
    IF (p_custodycd IS NOT NULL)
    THEN
        SELECT c.cftype,
               c.custtype,
               c.grinvestor,
               CASE
                   WHEN s.refafacctno IS NOT NULL OR NVL (p_symbol, '') = ''
                   THEN
                       'DEALER'
                   ELSE
                       'CUSTOMER'
               END
          INTO v_aftype,
               v_typecustomer,
               v_nationality,
               v_dealertype
          FROM cfmast c
               LEFT JOIN afmast a
                   ON c.custodycd = a.custodycd
               LEFT JOIN sbsedefacct s
                   ON     a.custid = s.refafacctno
                      AND s.symbol = p_symbol
                      AND s.status = 'A'
         WHERE c.custodycd = p_custodycd;
    ELSE
        v_aftype := NULL;
        v_typecustomer := NULL;
        v_nationality := NULL;
        v_dealertype := NULL;
    END IF;

    /*
        --Tính theo th? t? uu tiên
        v_result := 0;
        select id,ruletype,feecalc,nvl(feerate,0) feerate, nvl(feeamt,0) feeamt, minamt, maxamt
        into v_id,v_ruletype,v_feecalc,v_feerate, v_feeamt, v_minamt, v_maxamt
        from (
        select f.*,
        (case when exectype <> 'NRS' then 1 else 2 end) stt1,--Lo?i giao d?ch
        (case when SBSEDEFACCT <> 'ALL' then 1 else 2 end) stt2,--Mã combo
        (case when symbol <> 'ALL' then 1 else 2 end) stt3,--Mã s?n ph?m
        (case when product <> 'ALL' then 1 else 2 end) stt4,--Mã tài s?n
        (case when aftype <> 'ALL' then 1 else 2 end) stt5,--Phân nhóm KH
        (case when dealertype <> 'ALL' then 1 else 2 end) stt6,--Phân lo?i NÐT
        (case when typecustomer <> 'ALL' then 1 else 2 end) stt7,--Lo?i khách hàng
        (case when nationality <> 'ALL' then 1 else 2 end) stt8--Qu?c t?ch
        from feetype f
        where 1=1
        and feetype = p_feetype
        and p_txdate between frdate and todate - 1
        and (exectype = p_exectype or exectype = 'NRS' or exectype is NULL )
        and (mechanism = p_combo or mechanism = 'ALL' or mechanism is NULL)
        and (product = p_product or product = 'ALL')
        and (symbol = p_symbol or symbol = 'ALL')
        and (aftype = v_aftype or aftype = 'ALL' or aftype is NULL )
        and (dealertype = v_dealertype or dealertype = 'ALL' or dealertype is NULL)
        and (typecustomer = v_typecustomer or typecustomer = 'ALL' or typecustomer is NULL )
        and (nationality = v_nationality or nationality = 'ALL' or nationality is NULL )
        and (status = 'A' OR pstatus LIKE '%A%')
        order by stt1,stt2,stt3,stt4,stt5,stt6,stt7,stt8
        ) WHERE rownum = 1;


    if (v_ruletype = 'F') then

            v_result := round((p_amt*v_feerate)/100,0);
            v_result := least(greatest(v_result, v_minamt), v_maxamt);

    ELSE
        v_result:= 0;
        -- không dùng
        SELECT *
         into v_feerate, v_feeamt
        FROM (
        select nvl(feerate,0) , nvl(feeamt,0)
        from feetier f
        where feeid = v_id
        --and status = 'A'
        and p_amt between framt and toamt -1) z
        WHERE rownum<=1;
        --

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
             v_result := least(greatest(v_result, v_minamt), v_maxamt);

    end if;
    */
    v_result := 0;

      --for vc in (
    SELECT -- id,ruletype,feecalc,nvl(feerate,0) feerate, nvl(feeamt,0) feeamt, minamt, maxamt, calcmethod
           --into v_id,v_ruletype,v_feecalc,v_feerate, v_feeamt, v_minamt, v_maxamt
           prc_calc_fee (
               v_minamt     => f.minamt,
               v_maxamt     => f.maxamt,
               v_ruletype   => f.ruletype,
               v_feerate    => f.feerate,
               v_id         => f.id,
               p_amt        => (CASE
                                    WHEN f.calcmethod = 'V' THEN p_amt
                                    ELSE p_amtp
                                END))
      INTO v_result
      FROM (SELECT f.*,
                   (CASE WHEN sbsedefacct <> 'ALL' THEN 1 ELSE 2 END) stt2, --Mã dai ly
                   (CASE WHEN symbol <> 'ALL' THEN 1 ELSE 2 END) stt3, --Mã s?n ph?m
                   (CASE WHEN product <> 'ALL' THEN 1 ELSE 2 END) stt4, --Mã tài s?n
                   (CASE WHEN aftype <> 'ALL' THEN 1 ELSE 2 END) stt5, --Phân nhóm KH
                   (CASE WHEN dealertype <> 'ALL' THEN 1 ELSE 2 END) stt6, --Phân lo?i NÐT
                   (CASE WHEN typecustomer <> 'ALL' THEN 1 ELSE 2 END) stt7, --Lo?i khách hàng
                   (CASE WHEN nationality <> 'ALL' THEN 1 ELSE 2 END) stt8 --Qu?c t?ch
              FROM feetype f
             WHERE     1 = 1
                   AND feetype = p_feetype
                   AND p_txdate BETWEEN frdate AND todate - 1
                   AND (exectype = p_exectype OR exectype IS NULL)
                   AND (   mechanism = p_combo
                        OR mechanism = 'ALL'
                        OR mechanism IS NULL)
                   AND (product = p_product OR product = 'ALL')
                   AND (symbol = p_symbol OR symbol = 'ALL')
                   AND (aftype = v_aftype OR aftype = 'ALL' OR aftype IS NULL)
                   AND (sbsedefacct =
                            fn_get_acctno_by_custodycd (p_custodycd)
                        OR sbsedefacct = 'ALL')
                   AND (   dealertype = v_dealertype
                        OR dealertype = 'ALL'
                        OR dealertype IS NULL)
                   AND (   typecustomer = v_typecustomer
                        OR typecustomer = 'ALL'
                        OR typecustomer IS NULL)
                   AND (   nationality = v_nationality
                        OR nationality = 'ALL'
                        OR nationality IS NULL)
                   AND (status = 'A' OR pstatus LIKE '%A%')
            ORDER BY stt2,
                     stt3,
                     stt4,
                     stt5,
                     stt6,
                     stt7,
                     stt8) f
     WHERE ROWNUM <= 1 ;

    /*  ) LOOP

      select    prc_calc_fee
                (v_minamt=>vc.minamt,
                 v_maxamt=>vc.maxamt,
                 v_ruletype=>vc.ruletype,
                 v_feerate=>vc.feerate,
                 v_id=>vc.id,
                 p_amt=>(CASE WHEN vc.calcmethod = 'V' THEN p_amt ELSE p_amtp END ) ) into l_result from dual ;
     if v_result = 0 then
           v_result:= l_result ;
       end if;
       v_result:= least(v_result , l_result) ;
   end loop;*/

    RETURN NVL (ROUND (v_result), 0);
EXCEPTION
    WHEN OTHERS
    THEN
        RETURN 0;                                  -- ban dau return -1, nhung
END;
/

DROP FUNCTION fn_calc_amt_for_present
/

CREATE OR REPLACE 
FUNCTION fn_calc_amt_for_present (p_date         DATE,
                                  p_todate       DATE,
                                  p_symbol       VARCHAR2,
                                  p_cstl         NUMBER,
                                  p_amt          NUMBER,
                                  p_rate         NUMBER,
                                  p_custodycd    VARCHAR2)
    RETURN NUMBER
AS
    v_result     NUMBER;
    l_count      NUMBER;
    l_totalamt   NUMBER;

    pkgctx       plog.log_ctx;
    logrow       tlogdebug%ROWTYPE;
BEGIN
    v_result := 0;

    SELECT COUNT (1)
      INTO l_count
      FROM intschd a
     WHERE     a.symbol = p_symbol
           AND a.reportdt < p_todate
           AND a.reportdt >= p_date;

    SELECT SUM (
               CASE
                   WHEN ROWNUM = l_count
                   THEN
                       (  NVL (p.amount, 0)
                        - fn_calc_fee (p.valuedt,
                                       '001',
                                       '',
                                       p_symbol,
                                       p_custodycd,
                                       '',
                                       '',
                                       p.amount,
                                       p.amount)
                        + p_amt)
                       / POWER ( (1 + p_rate * p.days / p_cstl / 100),
                                ROWNUM)
                   ELSE
                       (NVL (p.amount, 0)
                        - fn_calc_fee (p.valuedt,
                                       '001',
                                       '',
                                       p_symbol,
                                       p_custodycd,
                                       '',
                                       '',
                                       p.amount,
                                       p.amount))
                       / POWER ( (1 + p_rate * p.days / p_cstl / 100),
                                ROWNUM)
               END)
      INTO l_totalamt
      FROM (SELECT p.valuedt, a.amount, a.days
              FROM     intschd a
                   INNER JOIN
                       payment_schd p
                   ON     a.periodno <= p.toperiod
                      AND a.periodno >= p.fromperiod
                      AND a.symbol = p.symbol
             WHERE     a.symbol = p_symbol
                   AND a.reportdt < p_todate
                   AND a.reportdt >= p_date
            ORDER BY a.reportdt) p;

    v_result := NVL (l_totalamt, 0);

    RETURN NVL (v_result, 0);
EXCEPTION
    WHEN OTHERS
    THEN
        RETURN 0;                                  -- ban dau return -1, nhung
END;
/

DROP FUNCTION fn_calc_amt_for_sell
/

CREATE OR REPLACE 
FUNCTION fn_calc_amt_for_sell (p_date         DATE,
                                 p_todate       DATE,
                                 p_symbol       VARCHAR2,
                                 p_product      VARCHAR2,
                                 p_amt          NUMBER,
                                 p_custodycd    VARCHAR2)
    RETURN NUMBER
AS
    l_autoid         NUMBER;
    l_intbaseddofy   NUMBER;
    l_intrate        NUMBER;
    l_parvalue       NUMBER;
    v_result         NUMBER;

    l_totalday       NUMBER;
    l_interest       NUMBER;
    l_totalamt       NUMBER;
    l_fee            NUMBER;
    l_duedate        DATE;

    l_rptdate        DATE;
    l_feebuy         NUMBER;
    l_symbol         VARCHAR2 (200);
    pkgctx           plog.log_ctx;
    logrow           tlogdebug%ROWTYPE;
BEGIN
    l_symbol := p_symbol;
    v_result := 0;

    l_interest := 0;
    l_totalamt := p_amt;

    SELECT CASE WHEN intbaseddofy = 'N' THEN 360 ELSE 365 END intbaseddofy
      INTO l_intbaseddofy
      FROM assetdtl
     WHERE symbol = l_symbol;

    SELECT p.intrate
      INTO l_intrate
      FROM (SELECT *
              FROM INTSCHD p
             WHERE     p.symbol = p_symbol

                   and p.status = 'A'
                   AND p.reportdt >= p_todate
            ORDER BY reportdt) p
     WHERE ROWNUM <= 1;

    l_interest :=
        ROUND (
            l_intrate * (p_todate - p_date) * p_amt / l_intbaseddofy / 100);
    l_totalamt := l_totalamt + l_interest;

    v_result := l_totalamt;
    RETURN NVL (v_result, 0);
EXCEPTION
    WHEN OTHERS
    THEN
        RETURN 0;                                  -- ban dau return -1, nhung
END;
/

DROP FUNCTION fn_calc_comboduedate
/

CREATE OR REPLACE 
FUNCTION fn_calc_comboduedate (p_comboid varchar2)
RETURN date
 
as  
    l_return date;
begin   
    select max(a.duedate)
        into l_return 
    from comboproduct c2
        inner join productier p
                on c2.id = p.id         
        inner join assetdtl a
            on p.symbol = a.symbol 
    where c2.id = p_comboid; 

    return l_return;
END;
/

DROP FUNCTION fn_calc_comboterm
/

CREATE OR REPLACE 
FUNCTION fn_calc_comboterm (p_comboid varchar2)
RETURN number
 
as    
    l_return number := 0;
    l_currdate date;
begin   
    l_currdate := getcurrdate();

    select max(case when nvl(b.termval ,0) = 0 then 99999999 else b.termval end)
        into l_return 
    from comboproduct c2
        inner join productier p
                on c2.id = p.id 
        left join product b
                on b.shortname = p.productid 
                    and (b.status = 'A' or b.pstatus like '%A%')
                    and b.effdate <= l_currdate
                    and b.expdate > l_currdate
        where c2.id = p_comboid; 
    
    return l_return;
exception
    when others then
        return -1;
   
END;
/

DROP FUNCTION fn_calc_commission
/

CREATE OR REPLACE 
FUNCTION fn_calc_commission (p_commissionid   VARCHAR2,
                            p_amt       NUMBER,
                            p_txdate       DATE,
                            p_symbol       VARCHAR2,
                            p_product      VARCHAR2,
                            p_sbsedefacct    VARCHAR2,
                            p_cstl OUT   NUMBER)
    RETURN NUMBER
AS
    v_result         NUMBER;
    v_minresult      NUMBER;

    v_id             NUMBER;
    v_ruletype       VARCHAR (50);
    v_feecalc        VARCHAR2 (10);
    v_feerate        NUMBER;
    v_feeamt         NUMBER;
    v_minamt         NUMBER;
    v_maxamt         NUMBER;
    v_aftype         VARCHAR2 (20);
    v_dealertype     VARCHAR2 (20);
    v_typecustomer   VARCHAR2 (20);
    v_nationality    VARCHAR2 (20);


    pkgctx           plog.log_ctx;
    logrow           tlogdebug%ROWTYPE;
BEGIN

        --Tính theo th? t? uu tiên
        v_result := 0;
        select id,
               ruletype,
               ruletype,
               nvl(feerate,0) feerate,
               case
                    when intbaseddofy = 'N' then 360
                    when intbaseddofy = 'A' then 365
                    else 1
                end cstl--, nvl(feeamt,0) feeamt, minamt, maxamt
        into v_id,v_ruletype,v_feecalc,v_feerate, p_cstl--, v_feeamt, v_minamt, v_maxamt
        from (
        select f.*,
        (case when symbol <> 'ALL' then 1 else 2 end) stt1,--Mã s?n ph?m
        (case when product <> 'ALL' then 1 else 2 end) stt2,--Mã tài s?n
        (case when sbsedefacct <> 'ALL' then 1 else 2 end) stt3--Phân lo?i NÐT
        from commission f
        where 1=1
        and id = p_commissionid
        --and p_txdate between frdate and todate - 1
        and (product = p_product or product = 'ALL')
        and (symbol = p_symbol or symbol = 'ALL')
        and (sbsedefacct = p_sbsedefacct or sbsedefacct = 'ALL')
        and (status = 'A' OR pstatus LIKE '%A%')
        order by stt1,stt2,stt3
        ) WHERE rownum = 1;


    if (v_ruletype = 'F') then

            v_result := v_feerate;
            --v_result := least(greatest(v_result, v_minamt), v_maxamt);

    ELSE
        v_result:= 0;
        /*-- không dùng
        SELECT *
         into v_feerate, v_feeamt
        FROM (
        select nvl(feerate,0) , nvl(feeamt,0)
        from feetier f
        where feeid = v_id
        --and status = 'A'
        and p_amt between framt and toamt -1) z
        WHERE rownum<=1;
        --

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
             v_result := least(greatest(v_result, v_minamt), v_maxamt);
*/
    end if;


    RETURN NVL (ROUND (v_result), 0);
EXCEPTION
    WHEN OTHERS
    THEN
        RETURN -1;                                  -- ban dau return -1, nhung
END;
/

DROP FUNCTION fn_calc_current_qtty
/

CREATE OR REPLACE 
FUNCTION fn_calc_current_qtty (
                               p_confirmno    VARCHAR2,
                               p_frdate        DATE
                              )
    RETURN NUMBER
AS
    v_result        NUMBER;
    l_count         NUMBER;

    pkgctx          plog.log_ctx;
    logrow          tlogdebug%ROWTYPE;
BEGIN
    v_result := 0;
        SELECT
            o.EXECQTTY - nvl(ox.qtty , 0) INTO  v_result
        FROM
            oxmast o

            LEFT JOIN
            (SELECT sum(ox.qtty) qtty, ox.ORGCONFIRMNO  FROM OXTRAN ox WHERE ox.BKDATE <= p_frdate  GROUP BY ox.ORGCONFIRMNO ) ox
                ON ox.ORGCONFIRMNO = o.CONFIRMNO
        WHERE o.CONFIRMNO = p_confirmno ;


    RETURN NVL (v_result, 0);
EXCEPTION
    WHEN OTHERS
    THEN
        RETURN 0;                                  -- ban dau return -1, nhung
END;
/

DROP FUNCTION fn_calc_execqtty_by_date
/

CREATE OR REPLACE 
FUNCTION fn_calc_execqtty_by_date (
                               p_custodycd    VARCHAR2,
                               p_symbol       varchar2,
                               p_frdate        DATE
                              )
    RETURN NUMBER
AS
    v_result        NUMBER;
    l_count         NUMBER;
    l_frdate        DATE ;
    pkgctx          plog.log_ctx;
    logrow          tlogdebug%ROWTYPE;
BEGIN
    v_result := 0;
    --l_frdate := to_date(p_frdate , 'dd/mm/yyyy') ;

         select   a.currentamt - nvl(b.amt,0) amt
            INTO  v_result
            from
                (
                select custodycd ,symbol ,
                    --(trade + tradesip + blocked + blockedsip) currentamt
                    trade + blocked currentamt
                from semast
                where custodycd = p_custodycd and symbol = p_symbol
                ) a
            left join
                ( select t.custodycd,t.symbol,sum(amt) amt from
                (select * from
                (select (case when s.trdesc is null then  tl.txdesc else s.trdesc end ) description,
               (case when ap.txtype ='C' then  nvl(s.namt,0)  else 0 end) increase,
                (case when ap.txtype ='D' then  nvl(s.namt,0)  else 0 end) decrease,
                (case when ap.txtype ='C' then   nvl(s.namt,0)  else - nvl(s.namt,0) end) amt,
                se.custodycd,se.symbol,
               s.namt inc, s.txnum,
               --cast(s.txdate as varchar) txdate
               to_char(s.bkdate, 'dd/mm/yyyy' ) txdate
                from setrana s, semast se , apptx ap, tltx tl
                    where s.acctno = se.acctno
                    and s.bkdate  > p_frdate

                    and s.tltxcd <> '4005'
                    and s.tltxcd <> '4006'
                    and se.custodycd = p_custodycd
                    and se.symbol = p_symbol
                    --and ap.field in ('TRADE','TRADESIP')
                    and ap.field in ('TRADE','BLOCKED')
                    and ap.txcd = s.txcd
                    and s.TLTXCD = tl.TLTXCD
                    and s.deltd<>'Y'
                    and ap.apptype = 'SE'

                union all

                select (case when s.trdesc is null then  tl.txdesc else s.trdesc end ) description,
               (case when ap.txtype ='C' then  nvl(s.namt,0)  else 0 end) increase,
                (case when ap.txtype ='D' then  nvl(s.namt,0)  else 0 end) decrease,
                (case when ap.txtype ='C' then   nvl(s.namt,0)  else - nvl(s.namt,0) end) amt,
                se.custodycd,se.symbol,
               s.namt inc, s.txnum,
               --cast(s.txdate as varchar) txdate
               to_char(s.bkdate, 'dd/mm/yyyy' ) txdate
                from setran s, semast se , apptx ap, tltx tl
                    where s.acctno = se.acctno
                    and s.bkdate  > p_frdate

                    and s.tltxcd <> '4005'
                    and s.tltxcd <> '4006'
                    and se.custodycd = p_custodycd
                    and se.symbol = p_symbol
                    --and ap.field in ('TRADE','TRADESIP')
                    and ap.field in ('TRADE','BLOCKED')
                    and ap.txcd = s.txcd
                    and s.tltxcd = tl.tltxcd
                    and s.deltd<>'Y'
                    and ap.apptype = 'SE') x
                order by x.txdate, x.txnum
                ) T group by t.custodycd,t.symbol
             ) b
            on  a.custodycd = b.custodycd and a.symbol = b.symbol

            ;

    RETURN NVL (v_result, 0);
EXCEPTION
    WHEN OTHERS
    THEN
        RETURN -1;                                  -- ban dau return -1, nhung
END;
/

DROP FUNCTION fn_calc_fee_for_pm
/

CREATE OR REPLACE 
FUNCTION fn_calc_fee_for_pm (p_txdate date, p_feetype varchar2, p_exectype varchar2, p_symbol varchar2, p_custodycd varchar2, p_product varchar2, p_combo varchar2, p_amt NUMBER ,p_amtp NUMBER)
 RETURN number

as


 v_result  number;
 v_minresult    number;

 v_id NUMBER;
 v_ruletype varchar(50);
 v_feecalc varchar2(10);
 v_feerate number;
 v_feeamt  number;
 v_minamt  number;
 v_maxamt  number;
 v_aftype varchar2(20);
 v_dealertype varchar2(20);
 v_typecustomer varchar2(20);
 v_nationality varchar2(20);
    l_result number;

    pkgctx plog.log_ctx;
  logrow tlogdebug%rowtype;
BEGIN

    --Xác d?nh Phân nhóm KH, Lo?i khách hàng, Qu?c t?ch, Phân lo?i NÐT
        IF (p_custodycd IS NOT NULL) then
            select c.cftype, c.custtype, c.grinvestor, case when s.refafacctno is not null or nvl(p_symbol, '') = '' then 'DEALER' else 'CUSTOMER' end
            into v_aftype, v_typecustomer, v_nationality, v_dealertype
            from cfmast c left join afmast a on c.custodycd = a.custodycd
                          left join sbsedefacct s on a.custid = s.refafacctno and s.symbol = p_symbol and s.status= 'A'
            where c.custodycd = p_custodycd;
        ELSE
            v_aftype := NULL;
            v_typecustomer := NULL;
            v_nationality := NULL;
            v_dealertype := NULL;
        END IF;

    /*
        --Tính theo th? t? uu tiên
        v_result := 0;
        select id,ruletype,feecalc,nvl(feerate,0) feerate, nvl(feeamt,0) feeamt, minamt, maxamt
        into v_id,v_ruletype,v_feecalc,v_feerate, v_feeamt, v_minamt, v_maxamt
        from (
        select f.*,
        (case when exectype <> 'NRS' then 1 else 2 end) stt1,--Lo?i giao d?ch
        (case when SBSEDEFACCT <> 'ALL' then 1 else 2 end) stt2,--Mã combo
        (case when symbol <> 'ALL' then 1 else 2 end) stt3,--Mã s?n ph?m
        (case when product <> 'ALL' then 1 else 2 end) stt4,--Mã tài s?n
        (case when aftype <> 'ALL' then 1 else 2 end) stt5,--Phân nhóm KH
        (case when dealertype <> 'ALL' then 1 else 2 end) stt6,--Phân lo?i NÐT
        (case when typecustomer <> 'ALL' then 1 else 2 end) stt7,--Lo?i khách hàng
        (case when nationality <> 'ALL' then 1 else 2 end) stt8--Qu?c t?ch
        from feetype f
        where 1=1
        and feetype = p_feetype
        and p_txdate between frdate and todate - 1
        and (exectype = p_exectype or exectype = 'NRS' or exectype is NULL )
        and (mechanism = p_combo or mechanism = 'ALL' or mechanism is NULL)
        and (product = p_product or product = 'ALL')
        and (symbol = p_symbol or symbol = 'ALL')
        and (aftype = v_aftype or aftype = 'ALL' or aftype is NULL )
        and (dealertype = v_dealertype or dealertype = 'ALL' or dealertype is NULL)
        and (typecustomer = v_typecustomer or typecustomer = 'ALL' or typecustomer is NULL )
        and (nationality = v_nationality or nationality = 'ALL' or nationality is NULL )
        and (status = 'A' OR pstatus LIKE '%A%')
        order by stt1,stt2,stt3,stt4,stt5,stt6,stt7,stt8
        ) WHERE rownum = 1;


    if (v_ruletype = 'F') then

            v_result := round((p_amt*v_feerate)/100,0);
            v_result := least(greatest(v_result, v_minamt), v_maxamt);

    ELSE
        v_result:= 0;
        -- không dùng
        SELECT *
         into v_feerate, v_feeamt
        FROM (
        select nvl(feerate,0) , nvl(feeamt,0)
        from feetier f
        where feeid = v_id
        --and status = 'A'
        and p_amt between framt and toamt -1) z
        WHERE rownum<=1;
        --

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
             v_result := least(greatest(v_result, v_minamt), v_maxamt);

    end if;
    */
    v_result:= 0 ;
    for vc in (
        select id,ruletype,feecalc,nvl(feerate,0) feerate, nvl(feeamt,0) feeamt, minamt, maxamt, calcmethod
        --into v_id,v_ruletype,v_feecalc,v_feerate, v_feeamt, v_minamt, v_maxamt
        from (
        select f.*,

        (case when SBSEDEFACCT <> 'ALL' then 1 else 2 end) stt2,--Mã dai ly
        (case when symbol <> 'ALL' then 1 else 2 end) stt3,--Mã s?n ph?m
        (case when product <> 'ALL' then 1 else 2 end) stt4,--Mã tài s?n
        (case when aftype <> 'ALL' then 1 else 2 end) stt5,--Phân nhóm KH
        (case when dealertype <> 'ALL' then 1 else 2 end) stt6,--Phân lo?i NÐT
        (case when typecustomer <> 'ALL' then 1 else 2 end) stt7,--Lo?i khách hàng
        (case when nationality <> 'ALL' then 1 else 2 end) stt8--Qu?c t?ch

        from feetype f
        where 1=1
        and feetype = p_feetype
        and p_txdate between frdate and todate - 1
        and (exectype = p_exectype  or exectype is NULL )
        and (mechanism = p_combo or mechanism = 'ALL' or mechanism is NULL)
        and (product = p_product or product = 'ALL')
        and (symbol = p_symbol or symbol = 'ALL')
        and (aftype = v_aftype or aftype = 'ALL' or aftype is NULL )
        and (dealertype = v_dealertype or dealertype = 'ALL' or dealertype is NULL)
        and (typecustomer = v_typecustomer or typecustomer = 'ALL' or typecustomer is NULL )
        and (nationality = v_nationality or nationality = 'ALL' or nationality is NULL )
        and (status = 'A' OR pstatus LIKE '%A%')
        order by stt2,stt3,stt4,stt5,stt6,stt7,stt8
       ) WHERE rownum = 1

    ) LOOP

      select    PRC_CALC_FEE_FOR_PM
                (v_minamt=>vc.minamt,
                 v_maxamt=>vc.maxamt,
                 v_ruletype=>vc.ruletype,
                 v_feerate=>vc.feerate,
                 v_id=>vc.id,
                 p_amt=>(CASE WHEN vc.calcmethod = 'V' THEN p_amt ELSE p_amtp END ) ) into l_result from dual ;
        if v_result = 0 then
            v_result:= l_result ;
        end if;
        v_result:= least(v_result , l_result) ;
    end loop;

    RETURN nvl(v_result,0);

exception
  when others then
    return 0;-- ban dau return -1, nhung
end;
/

DROP FUNCTION fn_calc_fee_fortype
/

CREATE OR REPLACE 
FUNCTION fn_calc_fee_fortype ( p_date date  ,p_exectype varchar2,  p_symbol varchar2, p_custodycd varchar2, p_product varchar2, p_combo varchar2, p_amt NUMBER ,p_amtp NUMBER)
 RETURN number

as


 v_result  number;
 v_minresult    number;

 v_id NUMBER;
 v_ruletype varchar(50);
 v_feecalc varchar2(10);
 v_feerate number;
 v_feeamt  number;
 v_minamt  number;
 v_maxamt  number;
 v_aftype varchar2(20);
 l_feecalc     NUMBER;
l_fee NUMBER;
    l_result number;

    pkgctx plog.log_ctx;
  logrow tlogdebug%rowtype;
BEGIN
    l_fee:=0 ;
    l_feecalc:= 0 ;
     for vc in (SELECT distinct feetype  FROM FEETYPE  f WHERE EXECTYPE = p_exectype AND (STATUS = 'A' OR PSTATUS LIKE '%A%') and (p_date between frdate and todate - 1))
         loop
            SELECT fn_calc_fee
                (p_txdate=>p_date ,
                 p_feetype=>vc.feetype,
                 p_exectype=>p_exectype,
                 p_symbol=>p_symbol,
                 p_custodycd=>p_custodycd,
                 p_product=>p_product,
                 p_combo=>p_combo,
                 p_amt=>p_amt ,
                 p_amtp=>p_amtp ) into l_feecalc FROM dual ;
                 l_fee  := l_fee + l_feecalc;
         end loop;

    RETURN nvl(round(l_fee),0);

exception
  when others then
    return 0;-- ban dau return -1, nhung
end;
/

DROP FUNCTION fn_calc_feebuy
/

CREATE OR REPLACE 
FUNCTION fn_calc_feebuy (p_productid    NUMBER,
                         p_frdate       DATE,
                         p_todate       DATE,
                         p_amt          NUMBER)
    RETURN NUMBER
AS
    v_result         NUMBER;
    l_termval        NUMBER;
    l_cstl           NUMBER;
    l_termcd         VARCHAR2 (20);
    l_symbol         VARCHAR2 (200);
    l_count          NUMBER;
    l_datereceived   DATE;
    l_feebuyrate     NUMBER;
    l_typefeerate    VARCHAR2 (20);
    pkgctx           plog.log_ctx;
    logrow           tlogdebug%ROWTYPE;
BEGIN
    v_result := 0;

    SELECT termval,
           termcd,
           CASE WHEN intbaseddofy = 'N' THEN 360 ELSE 365 END
      INTO l_termval, l_termcd, l_cstl
      FROM product
     WHERE autoid = p_productid;

    SELECT CASE
               WHEN l_termval = 0 THEN p_todate
               WHEN l_termcd = 'D' THEN p_frdate + l_termval
               WHEN l_termcd = 'W' THEN p_frdate + l_termval * 7
               ELSE ADD_MONTHS (p_frdate, l_termval)
           END
      INTO l_datereceived
      FROM DUAL;

    SELECT CASE
               WHEN l_datereceived <= p_todate
               THEN
                   0
               ELSE
                   fn_calc_rate_for_buy (
                       p_productid,
                       p_frdate,
                       CASE
                           WHEN l_datereceived >= p_todate THEN p_todate
                           ELSE l_datereceived
                       END,
                       'FEE')
           END
      INTO l_feebuyrate
      FROM DUAL;

    SELECT fn_calc_type_feerate_for_buy (p_productid, p_frdate, p_todate)
      INTO l_typefeerate
      FROM DUAL;


    SELECT CASE
               WHEN l_typefeerate = 'N'
               THEN
                   p_amt * l_feebuyrate / 100
               ELSE
                     p_amt
                   * l_feebuyrate
                   * (l_datereceived - p_todate)
                   / l_cstl
                   / 100
           END
      INTO v_result
      FROM DUAL;


    RETURN NVL (v_result, 0);
EXCEPTION
    WHEN OTHERS
    THEN
        RETURN 0;                                  -- ban dau return -1, nhung
END;
/

DROP FUNCTION fn_calc_feebuy_by_date
/

CREATE OR REPLACE 
FUNCTION fn_calc_feebuy_by_date (p_productid    NUMBER,
                         p_frdate       DATE,
                         p_todate       DATE,
                         p_matdate      date , 
                         p_amt          NUMBER)
    RETURN NUMBER
AS
    v_result         NUMBER;
    l_termval        NUMBER;
    l_cstl           NUMBER;
    l_termcd         VARCHAR2 (20);
    l_symbol         VARCHAR2 (200);
    l_count          NUMBER;
    l_datereceived   DATE;
    l_feebuyrate     NUMBER;
    l_typefeerate    VARCHAR2 (20);
    pkgctx           plog.log_ctx;
    logrow           tlogdebug%ROWTYPE;
BEGIN
    v_result := 0;

    SELECT termval,
           termcd,
           CASE WHEN intbaseddofy = 'N' THEN 360 ELSE 365 END
      INTO l_termval, l_termcd, l_cstl
      FROM product
     WHERE autoid = p_productid;

    SELECT CASE
               WHEN l_termval = 0 THEN p_todate
               WHEN l_termcd = 'D' THEN p_frdate + l_termval
               WHEN l_termcd = 'W' THEN p_frdate + l_termval * 7
               ELSE ADD_MONTHS (p_frdate, l_termval)
           END
      INTO l_datereceived
      FROM DUAL;

    SELECT CASE
               WHEN l_datereceived <= p_todate
               THEN
                   0
               ELSE
                   fn_calc_rate_for_buy (
                       p_productid,
                       p_frdate,
                       CASE
                           WHEN l_datereceived >= p_todate THEN p_todate
                           ELSE l_datereceived
                       END,
                       'FEE')
           END
      INTO l_feebuyrate
      FROM DUAL;

    SELECT fn_calc_type_feerate_for_buy (p_productid, p_frdate, p_todate)
      INTO l_typefeerate
      FROM DUAL;


    SELECT CASE
               WHEN l_typefeerate = 'N'
               THEN
                   p_amt * l_feebuyrate / 100
               ELSE
                     p_amt
                   * l_feebuyrate
                   * (p_matdate - p_todate)
                   / l_cstl
                   / 100
           END
      INTO v_result
      FROM DUAL;


    RETURN NVL (v_result, 0);
EXCEPTION
    WHEN OTHERS
    THEN
        RETURN 0;                                  -- ban dau return -1, nhung
END;
/

DROP FUNCTION fn_get_acctno_by_custodycd
/

CREATE OR REPLACE 
FUNCTION fn_get_acctno_by_custodycd (p_custodycd in varchar2) RETURN VARCHAR2 AS
l_acctno    varchar2(50);
l_count     number;
BEGIN
  select count(*) into l_count
            from afmast cf
            where cf.custodycd = p_custodycd;
  if (l_count > 0) then
  select cf.acctno into l_acctno
            from afmast cf
            where cf.custodycd = p_custodycd;
 else l_acctno := null;
 end if;
   RETURN l_acctno;
END FN_GET_ACCTNO_BY_CUSTODYCD;
/

DROP FUNCTION fn_calc_feerate_for_buy
/

CREATE OR REPLACE 
FUNCTION fn_calc_feerate_for_buy (p_txdate date, p_feetype varchar2, p_exectype varchar2, p_symbol varchar2, p_custodycd varchar2,p_custodycdsell varchar2, p_product varchar2, p_combo varchar2 , p_calcmethod varchar2 , p_amt number  )
 RETURN number

as


 v_result  number;
 v_minresult    number;

 v_id NUMBER;
 v_ruletype varchar(50);
 v_feecalc varchar2(10);
 v_feerate number;
 v_feeamt  number;
 v_minamt  number;
 v_maxamt  number;
 v_aftype varchar2(20);
 v_dealertype varchar2(20);
 v_typecustomer varchar2(20);
 v_nationality varchar2(20);
    l_result number;

    pkgctx plog.log_ctx;
  logrow tlogdebug%rowtype;
BEGIN

    --Xác d?nh Phân nhóm KH, Lo?i khách hàng, Qu?c t?ch, Phân lo?i NÐT
        IF (p_custodycd IS NOT NULL) then
            select c.cftype, c.custtype, c.grinvestor, case when s.refafacctno is not null or nvl(p_symbol, '') = '' then 'DEALER' else 'CUSTOMER' end
            into v_aftype, v_typecustomer, v_nationality, v_dealertype
            from cfmast c left join afmast a on c.custodycd = a.custodycd
                          left join sbsedefacct s on a.custid = s.refafacctno and s.symbol = p_symbol and s.status= 'A'
            where c.custodycd = p_custodycd;
        ELSE
            v_aftype := NULL;
            v_typecustomer := NULL;
            v_nationality := NULL;
            v_dealertype := NULL;
        END IF;


    v_result:= 0 ;
    for vc in (
        select id,ruletype,feecalc,nvl(feerate,0) feerate, nvl(feeamt,0) feeamt, minamt, maxamt, calcmethod
        --into v_id,v_ruletype,v_feecalc,v_feerate, v_feeamt, v_minamt, v_maxamt
        from (
        select f.*,

        (case when SBSEDEFACCT <> 'ALL' then 1 else 2 end) stt2,--Mã dai ly
        (case when symbol <> 'ALL' then 1 else 2 end) stt3,--Mã s?n ph?m
        (case when product <> 'ALL' then 1 else 2 end) stt4,--Mã tài s?n
        (case when aftype <> 'ALL' then 1 else 2 end) stt5,--Phân nhóm KH
        (case when dealertype <> 'ALL' then 1 else 2 end) stt6,--Phân lo?i NÐT
        (case when typecustomer <> 'ALL' then 1 else 2 end) stt7,--Lo?i khách hàng
        (case when nationality <> 'ALL' then 1 else 2 end) stt8--Qu?c t?ch

        from feetype f
        where 1=1
        and feetype = p_feetype
        and p_txdate between frdate and todate - 1
        and (exectype = p_exectype  or exectype is NULL )
        and (mechanism = p_combo or mechanism = 'ALL' or mechanism is NULL)
        and (product = p_product or product = 'ALL')
        and (symbol = p_symbol or symbol = 'ALL')
         AND (sbsedefacct = fn_get_acctno_by_custodycd (p_custodycdsell)
                        OR sbsedefacct = 'ALL')
        and (aftype = v_aftype or aftype = 'ALL' or aftype is NULL )
        and (dealertype = v_dealertype or dealertype = 'ALL' or dealertype is NULL)
        and (typecustomer = v_typecustomer or typecustomer = 'ALL' or typecustomer is NULL )
        and (nationality = v_nationality or nationality = 'ALL' or nationality is NULL )
        and CALCMETHOD = 'V'
        and (status = 'A' OR pstatus LIKE '%A%')
        order by stt2,stt3,stt4,stt5,stt6,stt7,stt8
       ) WHERE rownum = 1

    ) LOOP

        if p_CALCMETHOD = 'P' then

            v_result:=vc.feerate ;
        else
            v_feeamt:= p_amt* vc.feerate / 100 ;
            if     v_feeamt >=vc.minamt and v_feeamt <= vc.maxamt then
                v_result:= 0 ;
            elsif  v_feeamt< vc.minamt then
                v_result:= vc.minamt -v_feeamt ;
            else
                v_result :=v_feeamt - vc.maxamt ;
            end if;
        end if;
    end loop;

    RETURN nvl(v_result,0);

exception
  when others then
    return 0;-- ban dau return -1, nhung
end;
/

DROP FUNCTION fn_calc_intacr
/

CREATE OR REPLACE 
FUNCTION fn_calc_intacr (p_date         DATE,
     p_symbol       VARCHAR2)
    RETURN NUMBER
AS

    l_intbaseddofy   NUMBER;
    l_intrate        NUMBER;
    l_parvalue       NUMBER;
    l_fromdate date;

    l_result number;
    pkgctx           plog.log_ctx;
    logrow           tlogdebug%ROWTYPE;
BEGIN


    SELECT CASE WHEN intbaseddofy = 'N' THEN 360 ELSE 365 END intbaseddofy,
            parvalue
      INTO l_intbaseddofy, l_parvalue
      FROM assetdtl
     WHERE symbol = p_symbol;

    SELECT p.intrate, p.fromdate
      INTO l_intrate, l_fromdate
      FROM (SELECT *
              FROM INTSCHD p
             WHERE     p.symbol = p_symbol

                   and p.status = 'A'
                   AND p.fromdate <= p_date
                   AND p.todate >= p_date
            ORDER BY reportdt) p
     WHERE ROWNUM <= 1;

    l_result :=
        ROUND (
            l_intrate * (p_date - l_fromdate) * l_parvalue / l_intbaseddofy / 100);


    RETURN NVL (l_result, 0);
EXCEPTION
    WHEN OTHERS
    THEN
        RETURN 0;                                  -- ban dau return -1, nhung
END;
/

DROP FUNCTION fn_calc_investrate
/

CREATE OR REPLACE 
FUNCTION fn_calc_investrate (p_orgdeal varchar2, p_acctno varchar2, p_orgdate date, p_orgprice number, p_quoteprice number, p_qtty number, p_symbol varchar2, p_category varchar2, p_productid varchar2, p_custodycd varchar2)
 RETURN number
as
    l_return number := 0;
    l_duedate date;
    l_days number;
    l_currdate date;
    l_receivedamt number;
    l_intamt number;
    l_accrbasis number;
    l_parvalue number;
    l_couponamt number;
    l_pricesell number;
    l_orgdate date;
    l_shortname varchar2(100);
    l_taxtransfer number;
    l_feeseller number;
    l_count number;
    l_rate number;
    l_orgprice number;
    l_daysng number;
    l_matdate date;
begin
--  delete from van_test vt ;
--  insert into van_test (autoid, objname , value)
--  values(nextval('seq_van_test'),'calc invest rate', '');
    if p_orgdeal is not null then
    select o.orgdate, o.orgprice,o.matdate  into l_orgdate , l_orgprice, l_matdate from oxmast o where o.orderid= p_orgdeal;
else
    l_orgdate:=getcurrdate();
    l_orgprice:= p_orgprice;
end if;
    select case when a.intbaseddofy = 'A' then 365 else 360 end, a.parvalue
        into l_accrbasis, l_parvalue
    from assetdtl a
    where symbol = p_symbol;

    if l_accrbasis is null then
        l_accrbasis := 365;
    end if;

    l_currdate := getcurrdate();
    if l_matdate is not null then
        l_duedate:= l_matdate;
    else
    -- Tinh thoi gian dau tu
        if p_category = 'C' then
            select max(case when nvl(b.termval ,0) = 0 then a.duedate
                            else ADD_MONTHS(l_orgdate, b.termval)
                        end)
                    into l_duedate
            from comboproduct c2
                inner join productier p
                    on c2.id = p.id
                inner join  assetdtl a
                    on p.symbol = a.symbol
                left join product b
                    on b.shortname = p.productid
                        and (b.status = 'A' or b.pstatus like '%A%')
                        and b.effdate <= l_orgdate
                        and b.expdate > l_orgdate
            where c2.id = p_productid;
        elsif p_category = 'T' then
            select case when nvl(p2.termval ,0) = 0 then a.duedate
                        else
                                        CASE
                                            WHEN p2.termcd = 'M'
                                            THEN
                                                ADD_MONTHS (l_orgdate,
                                                            p2.termval)
                                            WHEN p2.termcd = 'W'
                                            THEN
                                                l_orgdate + p2.termval * 7
                                            ELSE
                                                l_orgdate + p2.termval
                                        END

                    end
                    into l_duedate
            from product p2
                inner join assetdtl a
                    on p2.symbol = a.symbol
            where p2.autoid = p_productid;
        else
            select duedate
                into l_duedate
            from assetdtl a2
            where a2.symbol = p_symbol;
        end if;
    end if;

    l_days := l_duedate - p_orgdate;
    l_daysng:= l_duedate- l_orgdate;
select count(*) into l_count from product where autoid = p_productid;
if l_count > 0 then
    select shortname into l_shortname from product where autoid = p_productid;
else l_shortname:=null;
end if;
    --SELECT fn_calc_price_for_buy(TO_DATE(l_orgdate,'dd/mm/yyyy'),p_orgdeal) into l_pricesell FROM dual;
    if p_productid <>'0' and p_productid is not null then
       SELECT  fn_calc_rate_for_buy (p_productid    ,
                                        l_orgdate,
                                      l_duedate,
                                     p_category ) into l_rate from dual;
        l_receivedamt := round( l_orgprice * (1+ l_rate/100*l_daysng/l_accrbasis),0);
    else
    select fn_calc_amt(
                    P_DATE=>l_orgdate,
                    P_TODATE=>l_duedate,
                    P_SYMBOL=>p_symbol,
                    P_PRODUCT=>p_productid,
                    P_AMT=>l_parvalue,
                    P_CUSTODYCD=>p_custodycd)- l_parvalue into l_couponamt from dual;
    l_receivedamt:= l_parvalue + l_couponamt;
 end if;
    /*select  fn_calc_fee_fortype
                    (p_date => getcurrdate(),
                     p_exectype=> 'CS',
                     p_symbol=>p_symbol,
                     p_custodycd=>p_custodycd,
                     p_product=>'',
                     p_combo=>'',
                     p_amt=>l_pricesell * p_qtty,
                     p_amtp=>l_parvalue* p_qtty ) into l_taxtransfer from dual;
       select fn_calc_fee
                (p_txdate=>getcurrdate(),
                 p_feetype=>'002',
                 p_exectype=>'',
                 p_symbol=>p_symbol,
                 p_custodycd=>p_custodycd,
                 p_product=>l_shortname,
                 p_combo=>'',
                 p_amt=>l_pricesell * p_qtty,
                 p_amtp=>l_parvalue*p_qtty
                 ) into l_feeseller from dual;*/

      /* select      fn_calc_price_for_sell(
            P_PRODUCTID=>p_productid,
            P_FRDATE=>getcurrdate,
            P_SYMBOL=>p_symbol,
            P_CATEGORY=>p_category,
            P_CUSTODYCDSELL => '',
            P_CUSTODYCD=>p_custodycd
            ) into l_pricesell from dual;*/
       /*select fn_calc_amt(
                    P_DATE=>l_orgdate,
                    P_TODATE=>l_duedate,
                    P_SYMBOL=>p_symbol,
                    P_PRODUCT=>p_productid,
                    P_AMT=>l_parvalue,
                    P_CUSTODYCD=>p_custodycd)- l_parvalue into l_couponamt from dual;*/
--  insert into van_test (autoid, objname , value)
--  values(nextval('seq_van_test'),'l_receivedamt', l_receivedamt);

    -- L?i ð?u tý
   --l_receivedamt:= round((l_pricesell * p_qtty + l_couponamt*p_qtty)/p_qtty,0);

     --l_receivedamt:= (l_pricesell*p_qtty- l_feeseller-l_taxtransfer + l_couponamt*p_qtty)/p_qtty;

    l_intamt := l_receivedamt - p_quoteprice;

--  insert into van_test (autoid, objname , value)
--  values(nextval('seq_van_test'),'l_intamt', l_intamt);

    --LS = L?i ð?u tý * CSTL / (S? ngày * S? ti?n ð?u tý)
    l_return := round(l_intamt * l_accrbasis / (l_days * p_quoteprice) * 100,2);


    return round(l_return,2);
exception
    when others then
        return -1;

END;
/

DROP FUNCTION fn_calc_limit_remain
/

CREATE OR REPLACE 
FUNCTION fn_calc_limit_remain (l_acseller varchar2, l_symbol varchar2, l_product varchar2)
 RETURN NUMBER
 IS
    pkgctx   plog.log_ctx;
    logrow   tlogdebug%ROWTYPE;
    l_count                 NUMBER;
    l_limit_total           NUMBER;
    l_limit_product         NUMBER;
    l_limit_symbol          NUMBER;
    l_limit_total_remain    NUMBER;
    l_limit_symbol_remain   NUMBER;
    l_limit_product_remain  NUMBER;
BEGIN
    plog.setBeginSection(pkgctx, 'fn_calc_limit_remain');

    --      - kiem tra con du han muc mua lai
--      + lay han muc tong tu limits

        l_limit_total:=fn_get_limit_buy_total(l_acseller);
        l_limit_symbol:= fn_get_limit_buy_symbol(l_acseller,l_symbol);
        l_limit_product:= fn_get_limit_buy_product(l_acseller,l_symbol,l_product);
        l_limit_total_remain:= fn_cal_limit_buy_remain_total(l_acseller);
        l_limit_symbol_remain:=fn_cal_limit_buy_remain_symbol(l_acseller,l_symbol);
        l_limit_product_remain:=fn_cal_limit_buy_remain_prd(l_acseller,l_symbol,l_product);
        if l_limit_total is not null or l_limit_symbol is not null or l_limit_product is not null then
        return LEAST(nvl(l_limit_total_remain,9999999999999999999999999),nvl(l_limit_symbol_remain,9999999999999999999999999),nvl(l_limit_product_remain,9999999999999999999999999));
        else return null;
        end if;
        plog.setEndSection(pkgctx, 'fn_calc_limit_remain');
        RETURN null;

Exception
When others then
    return -1;
END
;
/

DROP FUNCTION fn_calc_limitsell_total_remain
/

CREATE OR REPLACE 
FUNCTION fn_calc_limitsell_total_remain (p_afacctno varchar2)
RETURN number

as
    l_count number;
    l_limitval number;
    l_limit_total_remain number;
    l_limit_total number;
begin
    l_limit_total:= fn_get_limitval_total(p_afacctno);

    if l_limit_total is not null then

        SELECT
                    GREATEST (l_limit_total - nvl(SUM((nvl(b.QTTY, 0)- nvl(b.RETURN_QTTY , 0) ) * DECODE(fn_get_limit_method_sell_total(p_afacctno), 'F', nvl(b.PARVALUE, 0), 'P', nvl(b.PRICE , 0))), 0), 0)
                    INTO l_limit_total_remain
                            FROM
                            solddtl b where
                             b.TRNTYPE = 'D'
                            AND b.DELTD = 'N'
                            AND b.ACCTNO = p_afacctno;
    else
    l_limit_total_remain:=null;
    end if;

        RETURN l_limit_total_remain;
exception
    when others then
        return -2;

END;
/

DROP FUNCTION fn_calc_limit_sell_remain
/

CREATE OR REPLACE 
FUNCTION fn_calc_limit_sell_remain (l_acseller varchar2, l_symbol varchar2, l_product varchar2)
 RETURN NUMBER
 IS
    pkgctx   plog.log_ctx;
    logrow   tlogdebug%ROWTYPE;
    l_count                 NUMBER;
    l_limit_total           NUMBER;
    l_limit_product         NUMBER;
    l_limit_symbol          NUMBER;
    l_limit_total_remain    NUMBER;
    l_limit_symbol_remain   NUMBER;
    l_limit_product_remain  NUMBER;
BEGIN
    plog.setBeginSection(pkgctx, 'fn_calc_limit_sell_remain');

    --      - kiem tra con du han muc ban ra
--      + lay han muc tong tu limits

        l_limit_total:=fn_get_limitval_total(l_acseller);
        l_limit_symbol:= fn_get_limitval_symbol(l_acseller,l_symbol);
        l_limit_product:= fn_get_limitval_product(l_acseller,l_symbol,l_product);
        l_limit_total_remain:= fn_calc_limitsell_total_remain(l_acseller);
        l_limit_symbol_remain:=fn_cal_limitsell_symbol_remain(l_acseller,l_symbol);
        l_limit_product_remain:=fn_cal_limitsell_pro_remain(l_acseller,l_symbol,l_product);
        if l_limit_total is not null or l_limit_symbol is not null or l_limit_product is not null then
        return LEAST(nvl(l_limit_total_remain,9999999999999999999999999),nvl(l_limit_symbol_remain,9999999999999999999999999),nvl(l_limit_product_remain,9999999999999999999999999));
        else return null;
        end if;
        plog.setEndSection(pkgctx, 'fn_calc_limit_sell_remain');
        RETURN null;

Exception
When others then
    return -1;
END
;
/

DROP FUNCTION fn_calc_presentvalue
/

CREATE OR REPLACE 
FUNCTION fn_calc_presentvalue (v_codeid       VARCHAR2,
                               v_yield        NUMBER,
                               v_taxid        NUMBER,
                               v_duedate      DATE,
                               v_startdate    DATE)
    RETURN NUMBER
AS
    v_count          NUMBER;
    v_return         NUMBER;
    v_rate           NUMBER;
    v_coupon         NUMBER;
    v_principal      NUMBER;
    v_amt            NUMBER;
    v_tax            NUMBER;
    v_period         NUMBER;
    v_parvalue       NUMBER;
    v_days           NUMBER;
    v_intbased       NUMBER;
    v_c1             NUMBER;
    l_duedate        DATE;
    v_opndate        DATE;
    v_taxtype        VARCHAR2 (1);
    v_intrate        NUMBER;
    v_last_intrate   NUMBER := 0;

    CURSOR c1
    IS
        SELECT valuedt
               - (CASE
                      WHEN prevdate < v_startdate THEN v_startdate - 1
                      ELSE prevdate
                  END)
                   days,
               amount,
               intrate,
               CASE
                   WHEN NVL (f1.ruletype, 'F') = 'F'
                   THEN
                       NVL (NVL (f2.feerate, f1.feerate), 0)
                   ELSE
                       NVL (NVL (f2.feeamt, f1.feeamt), 0)
               END
                   tax,
               NVL (f1.ruletype, 'F') taxtype
          FROM (SELECT a.valuedt,
                       a.amount,
                       a.intrate,
                       MAX (NVL (b.valuedt, a.opndate)) prevdate
                  FROM     (SELECT a.valuedt,
                                   a.amount,
                                   --nvl(b.intratebaseddt, b.opndate) intratebaseddt
                                   b.opndate,
                                   a.intrate
                              FROM payment_hist a, assetdtl b
                             WHERE     a.symbol = v_codeid
                                   AND a.payment_status = 'P'
                                   AND a.paytype = 'INT'
                                   AND a.symbol = b.symbol
                                   AND b.status = 'A'
                                   AND a.valuedt >= v_startdate
                                   AND a.valuedt < v_duedate) a
                       LEFT JOIN
                           (SELECT valuedt
                              FROM payment_hist
                             WHERE symbol = v_codeid AND paytype = 'INT') b
                       ON b.valuedt < a.valuedt
                GROUP BY a.valuedt, a.amount, a.intrate) a
               LEFT JOIN feetype f1
                   ON f1.id = v_taxid
               LEFT JOIN (SELECT feeid,
                                 MAX (feeamt) feeamt,
                                 MAX (feerate) feerate
                            FROM feetier
                          GROUP BY feeid) f2
                   ON f1.id = f2.feeid
        ORDER BY valuedt;
BEGIN
    v_return := 0;
    v_days := 0;
    v_c1 := 0;


    SELECT a.intrate,
           a.parvalue,
           CASE WHEN a.intbaseddofy = 'N' THEN 360 ELSE 365 END intbased,
           a.duedate,
           a.opndate
      INTO v_coupon,
           v_parvalue,
           v_intbased,
           l_duedate,
           v_opndate
      FROM assetdtl a
     WHERE symbol = v_codeid;

    v_period := 0;

    OPEN c1;

    LOOP
        FETCH c1
          INTO v_days, v_amt, v_intrate, v_tax, v_taxtype;

        EXIT WHEN c1%NOTFOUND;
        v_period := v_period + 1;
        --v_return := v_return + v_amt/POWER((1 + (v_coupon - v_yield)/v_coupon * (v_amt / v_parvalue)),v_period);
        v_return :=
            v_return
            + (v_amt
               - CASE
                     WHEN v_taxtype = 'F' THEN ROUND (v_amt * v_tax / 100, 0)
                     ELSE v_tax
                 END)
              / POWER (1 + (v_intrate - v_yield) / 100 * v_days / v_intbased,
                       v_period);
        v_c1 := v_days;
        v_last_intrate := v_intrate;
    END LOOP;

    CLOSE c1;


    SELECT COUNT (1)
      INTO v_count
      FROM payment_hist
     WHERE     symbol = v_codeid
           AND payment_status = 'P'
           AND paytype = 'PRI'
           AND valuedt < l_duedate;

    IF v_count > 0
    THEN
        IF v_period = 0
        THEN
            v_c1 := l_duedate - v_startdate + 1;
            v_period := 1;
        END IF;

        SELECT SUM (amount)
          INTO v_principal
          FROM payment_hist
         WHERE symbol = v_codeid AND payment_status = 'P' AND paytype = 'PRI';



        v_return :=
            v_return
            + v_principal
              / POWER (
                    1 + (v_last_intrate - v_yield) / 100 * v_c1 / v_intbased,
                    v_period);
    END IF;

    RETURN ROUND (v_return, 0);
EXCEPTION
    WHEN OTHERS
    THEN
        RETURN 0;
END;
/

DROP FUNCTION fn_calc_price_for_payment
/

CREATE OR REPLACE 
FUNCTION fn_calc_price_for_payment (p_date         DATE,
                                      p_frdate       DATE,
                                      p_symbol       VARCHAR2,
                                      p_qtty         NUMBER,
                                      p_orgprice     NUMBER,
                                      p_productid    NUMBER,
                                      p_custodycd    VARCHAR2)
    RETURN NUMBER
AS
    v_result           NUMBER;
    l_totalamt         NUMBER;
    l_parvalue         NUMBER;
    l_opndate          DATE;
    l_count            NUMBER;
    l_todate           DATE;
    l_startdate        DATE;
    l_calpvmethod      VARCHAR2 (20);
    l_termval          NUMBER;
    l_cstl             NUMBER;
    l_rate             NUMBER;
    l_productid        NUMBER;
    l_orgprice         NUMBER;
    l_symbol           VARCHAR2 (200);
    l_fee              NUMBER;
    l_feediff          NUMBER;
    l_totalfeediff     NUMBER;
    l_feerate          NUMBER;
    l_totalfeerate     NUMBER;
    l_couponreceived   NUMBER;
    l_feebuyrate       NUMBER;
    l_execqtty         NUMBER;
    l_datereceived     DATE;
    l_frdate           DATE;
    l_termcd           VARCHAR2 (200);
    l_custodycdsell    VARCHAR2 (200);
    l_overduerate      number;
    pkgctx             plog.log_ctx;
    logrow             tlogdebug%ROWTYPE;
    l_typefeerate      varchar2(20) ;
BEGIN
    v_result := 0;

    l_typefeerate:= 'N' ;
    l_productid := p_productid;
    l_startdate := p_date;
    l_orgprice := p_orgprice;
    l_symbol := p_symbol;
    l_execqtty := p_qtty;
    l_custodycdsell := p_custodycd;


    SELECT a.duedate, a.opndate
      INTO l_todate, l_opndate
      FROM assetdtl a
     WHERE a.symbol = l_symbol;


    SELECT termval,
           calpvmethod,
           CASE WHEN intbaseddofy = 'N' THEN 360 ELSE 365 END,
           termcd,
           nvl(overduerate ,0)
      INTO l_termval,
           l_calpvmethod,
           l_cstl,
           l_termcd,
           l_overduerate -- lãi quá han
      FROM product
     WHERE autoid = l_productid;



    SELECT a.parvalue
      INTO l_parvalue
      FROM assetdtl a
     WHERE a.symbol = l_symbol;

    SELECT LEAST (p_frdate, l_todate) INTO l_frdate FROM DUAL;

    l_couponreceived := 0;

    -- Tinh rate tu ngay mua -> ngay curr date
    IF l_calpvmethod in  ('L' , 'PR', 'PL', 'PV')
    THEN
        v_result :=p_orgprice ;
          /*  fn_calc_price_for_sell (l_productid,
                                    l_startdate,
                                    l_symbol,
                                    'T',
                                    l_custodycdsell);  -- tong tien thanh toan */

        SELECT CASE  when l_termval = 0 then l_frdate
                   WHEN l_termcd = 'D' THEN l_startdate + l_termval
                   WHEN l_termcd = 'W' THEN l_startdate + l_termval * 7
                   ELSE ADD_MONTHS (l_startdate, l_termval)
               END
          INTO l_datereceived
          FROM DUAL;

         /* SELECT FN_CALC_AMT_FOR_BUY (l_productid, l_startdate, l_frdate, '' , v_result ,l_cstl  )
            INTO  v_result
             FROM DUAL; -- tinh tong tien den luc mua lai



        l_feebuyrate:= 0 ;*/
        SELECT FN_CALC_RATE_FOR_BUY (l_productid, l_startdate, case when l_datereceived >= l_frdate then   l_frdate else l_datereceived end, '')
          INTO l_rate
          FROM DUAL;
         SELECT case when l_datereceived <= l_frdate  then 0 else  FN_CALC_RATE_FOR_BUY (l_productid, l_startdate, case when l_datereceived >= l_frdate then   l_frdate else l_datereceived end, 'FEE') end
          INTO l_feebuyrate
          FROM DUAL;
         select fn_calc_type_feerate_for_buy(l_productid ,l_startdate , l_frdate   ) into  l_typefeerate from dual ;
        if   l_datereceived >= l_frdate then
            v_result :=    v_result*  l_rate * (l_frdate - l_startdate) / 100 / l_cstl    + v_result     ;
        else
            l_datereceived := get_workdate(l_datereceived) ;
            v_result :=  v_result*  l_rate * (l_datereceived - l_startdate) / 100 / l_cstl    + v_result + v_result*  l_overduerate * (l_frdate - l_datereceived) / 100 / l_cstl   ;
        end if;
        SELECT NVL (SUM (NVL (a.amount, 0)
                         - fn_calc_fee (p.valuedt,
                                        '001',
                                        '',
                                        l_symbol,
                                        l_custodycdsell,
                                        '',
                                        '',
                                        a.amount,
                                        a.amount)),
                    0)
          INTO l_couponreceived
          FROM INTSCHD a
         inner join PAYMENT_SCHD p on a.PERIODNO <= p.TOPERIOD and a.PERIODNO>= p.FROMPERIOD and a.symbol = p.symbol
         WHERE     a.symbol = l_symbol

               AND a.reportdt >= l_startdate

               AND a.reportdt <= l_frdate;                     -- coupon da nhan
        v_result:= v_result - l_couponreceived  /*- (case when l_typefeerate = 'N' then  v_result * l_feebuyrate / 100 else   v_result * l_feebuyrate * (  l_frdate - l_startdate )  /l_cstl/100 end   )*/ ;


    ELSIF l_calpvmethod = 'C'
    THEN
        l_rate :=
            fn_calc_rate_for_coupon (l_productid, l_startdate, l_frdate)
            - fn_calc_rate_for_coupon (l_productid, l_startdate, l_todate);
        v_result :=
            fn_calc_amt (l_startdate,
                         l_frdate,
                         l_symbol,
                         '',
                         l_parvalue,

                         l_custodycdsell)
            - l_parvalue;
        v_result := l_rate * v_result/100 + l_parvalue;
        l_feebuyrate:= 0 ;
    ELSE
        v_result :=
            fn_calc_price_for_sell (l_productid,
                                    l_frdate,
                                    l_symbol,
                                    'T',
                                    '',
                                    l_custodycdsell);  -- giá bán t?i ngày

        SELECT   (p.discountrate2 - p.discountrate)
               / (p.lastdate - p.firstdate)
               * (l_frdate - p.firstdate)
               + p.discountrate,
               p.feebuyrate
          INTO l_rate, l_feebuyrate
          FROM product p
         WHERE autoid = l_productid;
    END IF;





    SELECT fn_calc_fee (p_txdate      => l_frdate,
                        p_feetype     => '002',
                        p_exectype    => '',
                        p_symbol      => l_symbol,
                        p_custodycd   => l_custodycdsell,
                        p_product     => l_productid,
                        p_combo       => '',
                        p_amt         => 0,
                        p_amtp        => l_parvalue * l_execqtty)
           + fn_calc_fee_fortype (p_date        => l_frdate,
                                  p_exectype    => 'CS',
                                  p_symbol      => l_symbol,
                                  p_custodycd   => l_custodycdsell,
                                  p_product     => l_productid,
                                  p_combo       => '',
                                  p_amt         => 0,
                                  p_amtp        => l_parvalue * l_execqtty)
      INTO l_fee
      FROM DUAL;

    v_result :=
          v_result
        + l_fee / l_execqtty
        ;
    l_feerate := 0;
    l_totalfeerate := 0;

    -- Tinh tong % phi theo
    FOR vc
        IN (SELECT DISTINCT feetype
              FROM feetype f
             WHERE     exectype = 'CS'
                   AND (status = 'A' OR pstatus LIKE '%A%')
                   AND (l_frdate BETWEEN frdate AND todate - 1))
    LOOP
        SELECT fn_calc_feerate_for_buy (p_txdate          => l_frdate,
                                        p_feetype         => vc.feetype,
                                        p_exectype        => 'CS',
                                        p_symbol          => l_symbol,
                                        p_custodycd       => '',
                                        p_custodycdsell   => l_custodycdsell,
                                        p_product         => l_productid,
                                        p_combo           => '',
                                        p_calcmethod      => 'P',
                                        p_amt             => 0)
          INTO l_feerate
          FROM DUAL;

        l_totalfeerate := l_totalfeerate + l_feerate;
    END LOOP;

    SELECT fn_calc_feerate_for_buy (p_txdate          => l_frdate,
                                    p_feetype         => '002',
                                    p_exectype        => '',
                                    p_symbol          => l_symbol,
                                    p_custodycd       => '',
                                    p_custodycdsell   => l_custodycdsell,
                                    p_product         => l_productid,
                                    p_combo           => '',
                                    p_calcmethod      => 'P',
                                    p_amt             => 0)
      INTO l_feerate
      FROM DUAL;

    l_totalfeerate := l_totalfeerate + l_feerate;
    v_result := v_result / (1 - l_totalfeerate / 100);

    -- Tinh phi chenh lech min max
    l_totalfeediff := 0;

    FOR vc
        IN (SELECT DISTINCT feetype
              FROM feetype f
             WHERE     exectype = 'CS'
                   AND (status = 'A' OR pstatus LIKE '%A%')
                   AND (l_frdate BETWEEN frdate AND todate - 1))
    LOOP
        SELECT fn_calc_feerate_for_buy (
                   p_txdate          => l_frdate,
                   p_feetype         => vc.feetype,
                   p_exectype        => 'CS',
                   p_symbol          => l_symbol,
                   p_custodycd       => '',
                   p_custodycdsell   => l_custodycdsell,
                   p_product         => l_productid,
                   p_combo           => '',
                   p_calcmethod      => 'V',
                   p_amt             => v_result * l_execqtty)
          INTO l_feediff
          FROM DUAL;

        l_totalfeediff := l_totalfeediff + l_feediff;
    END LOOP;

    SELECT fn_calc_feerate_for_buy (
               p_txdate          => l_frdate,
               p_feetype         => '002',
               p_exectype        => '',
               p_symbol          => l_symbol,
               p_custodycd       => '',
               p_custodycdsell   => l_custodycdsell,
               p_product         => l_productid,
               p_combo           => '',
               p_calcmethod      => 'V',
               p_amt             => v_result * l_execqtty)
      INTO l_feediff
      FROM DUAL;

   l_totalfeediff := l_totalfeediff +  l_feediff;

    -- cong phi chenh lech vao gia

    v_result := l_totalfeediff / l_execqtty + v_result;
    RETURN NVL (ROUND (v_result), 1000000);
EXCEPTION
    WHEN OTHERS
    THEN
        RETURN 1000000;                                  -- ban dau return -1, nhung
END;
/

DROP FUNCTION fn_calc_price_by_dt
/

CREATE OR REPLACE 
FUNCTION fn_calc_price_by_dt (p_frdate     DATE,
                            p_orgdate     DATE,
                            p_todate     DATE,
                            p_symbol     VARCHAR2,
                            p_product    VARCHAR2,
                            p_orgprice   NUMBER,
                            p_qtty       NUMBER,
                            p_rate       NUMBER,
                            p_custodycd     VARCHAR2)
    RETURN NUMBER
AS
    l_autoid         NUMBER;
    l_intbaseddofy   NUMBER;
    l_intrate        NUMBER;
    l_parvalue       NUMBER;
    v_result         NUMBER;
    l_days           NUMBER;
    l_totalday       NUMBER;
    l_rate           NUMBER;
    l_totalamt       NUMBER;
    l_fee            NUMBER;
    l_duedate        DATE;
    l_matdate        DATE;
    l_rptdate        DATE;
    l_feebuy         NUMBER;
    l_symbol         VARCHAR2 (200);
    l_pricebuy       NUMBER;
    l_pricesell      NUMBER;
    pkgctx           plog.log_ctx;
    logrow           tlogdebug%ROWTYPE;
BEGIN
    l_symbol := p_symbol;
    v_result := 0;
    l_days := 0;
    l_totalday := 0;
    l_rate := 0;

    SELECT intrate,
           parvalue,
           CASE WHEN intbaseddofy = 'N' THEN 360 ELSE 365 END intbaseddofy,
           duedate
      INTO l_intrate,
           l_parvalue,
           l_intbaseddofy,
           l_duedate
      FROM assetdtl
     WHERE symbol = l_symbol;

    l_matdate := p_todate;


    l_pricebuy:= p_orgprice ;

    SELECT fn_calc_price_for_payment (p_orgdate,
                                      l_matdate,
                                      l_symbol,
                                      p_qtty,
                                      l_pricebuy,
                                      p_product,
                                      p_custodycd)
      INTO l_pricesell
      FROM DUAL;

    IF l_pricesell = 0
    THEN
        l_pricesell := l_parvalue;
    END IF;

    l_totalamt := l_pricesell;

    select fn_calc_feebuy(p_product ,p_orgdate   , l_matdate , l_pricesell * p_qtty) into l_feebuy from dual ;
    SELECT fn_calc_fee_fortype (p_date        => l_matdate,
                                p_exectype    => 'CC',
                                p_symbol      => l_symbol,
                                p_custodycd   => p_custodycd,
                                p_product     => '',
                                p_combo       => '',
                                p_amt         => l_pricesell * p_qtty,
                                p_amtp        => l_pricesell * p_qtty) + l_feebuy
        + fn_calc_fee (l_matdate,
                         '002',
                         '',
                         l_symbol,
                         p_custodycd,
                         '',
                         '',
                         l_pricesell * p_qtty,
                         l_pricesell * p_qtty)
      INTO l_feebuy
      FROM DUAL;


    SELECT fn_calc_amt (p_frdate,
                        l_matdate,
                        l_symbol,
                        '',
                        l_parvalue,
                        p_custodycd) - l_parvalue
      INTO l_totalamt
      FROM DUAL;

    SELECT l_matdate - p_frdate INTO l_totalday FROM DUAL;
  --  v_result := l_feebuy ;
   /* v_result :=
          (l_pricesell *p_qtty +  l_totalamt *  p_qtty  - p_qtty *  p_price   - l_feebuy)
        / (p_price *  p_qtty )
        * l_intbaseddofy
        * 100
        / l_totalday;
    v_result:=( l_pricesell *p_qtty +  l_totalamt *  p_qtty -  p_rate * l_totalday /100 / l_intbaseddofy * (v_result *  p_qtty )   -  l_feebuy ) /  p_qtty  ;

    v_result * p_qtty +  p_rate * l_totalday /100 / l_intbaseddofy * v_result *  p_qtty     := l_pricesell *p_qtty +  l_totalamt *  p_qtty      -l_feebuy   ; */
    v_result := (l_pricesell *p_qtty +  l_totalamt *  p_qtty      -l_feebuy  ) / (p_qtty +  p_rate * l_totalday /100 / l_intbaseddofy  *  p_qtty  ) ;

    RETURN NVL (v_result, 0);
EXCEPTION
    WHEN OTHERS
    THEN
        RETURN 0;                                  -- ban dau return -1, nhung
END;
/

DROP FUNCTION fn_calc_rate_for_sell
/

CREATE OR REPLACE 
FUNCTION fn_calc_rate_for_sell (p_productid    NUMBER,
                                  p_frdate       DATE,
                                  p_todate       DATE)
    RETURN NUMBER
AS
    v_result    NUMBER;
    l_termval   NUMBER;
    l_termcd    VARCHAR2 (20);
    l_days      NUMBER;
    l_symbol    VARCHAR2 (200);
    l_weeks     NUMBER;
    l_months    NUMBER;
    l_autoid    NUMBER;
    l_rate      NUMBER;
    l_count     NUMBER;
    l_types     VARCHAR (20);
    pkgctx      plog.log_ctx;
    logrow      tlogdebug%ROWTYPE;
BEGIN
    v_result := 0;

    SELECT symbol
      INTO l_symbol
      FROM product
     WHERE autoid = p_productid;

    /*
    IF l_termval = 0
    THEN
        SELECT p_todate - p_frdate, fn_monthdiff (p_frdate, p_todate)
          INTO l_days, l_months
          FROM assetdtl a
         WHERE symbol = l_symbol;
    ELSE
        SELECT ADD_MONTHS (p_frdate, l_termval) - p_frdate
          INTO l_days
          FROM DUAL;

        l_months := l_termval;
    END IF;

    SELECT l_days / 7 INTO l_weeks FROM DUAL;*/

    /* SELECT CASE WHEN termval = 0 THEN p_todate
                 WHEN termcd = 'W' THEN p_frdate + 7 * to_number(termval)
                 WHEN termcd = 'D' THEN p_frdate + to_number(termval)
             ELSE ADD_MONTHS (p_frdate, termval) END
            - p_frdate days,
            (CASE WHEN termval = 0 THEN p_todate
                 WHEN termcd = 'W' THEN p_frdate + 7 * to_number(termval)
                 WHEN termcd = 'D' THEN p_frdate + to_number(termval)
             ELSE ADD_MONTHS (p_frdate, termval) END
            - p_frdate) / 7 weeks,
            CASE WHEN termval = 0 THEN fn_monthdiff (p_frdate, p_todate) else termval end months,
            termcd
       INTO l_days,
            l_weeks,
            l_months,
            l_termcd
       FROM product
      WHERE autoid = p_productid; */


    SELECT p_todate - p_frdate days,
           (p_todate - p_frdate) / 7 weeks,
           fn_monthdiff (p_frdate, p_todate) months,
           termcd
      INTO l_days,
           l_weeks,
           l_months,
           l_termcd
      FROM product
     WHERE autoid = p_productid;

    /*SELECT COUNT (1)
      INTO l_count
      FROM productselldtl p
     WHERE p.id = p_productid
           AND ( (    p.termcd = 'M'
                  AND p."FROM" <= l_months
                  AND p."TO" > l_months)
                OR (    p.termcd = 'W'
                    AND p."FROM" <= l_weeks
                    AND p."TO" > l_weeks)
                OR (p.termcd = 'D' AND p."FROM" <= l_days AND p."TO" > l_days));

    IF l_count > 0
    THEN
        SELECT p.rate
          INTO v_result
          FROM (SELECT *
                  FROM productselldtl p
                 WHERE p.id = p_productid
                       AND ( (    p.termcd = 'M'
                              AND p."FROM" <= l_months
                              AND p."TO" > l_months)
                            OR (    p.termcd = 'W'
                                AND p."FROM" <= l_weeks
                                AND p."TO" > l_weeks)
                            OR (    p.termcd = 'D'
                                AND p."FROM" <= l_days
                                AND p."TO" > l_days))
                ORDER BY p.autoid) p
         WHERE ROWNUM <= 1;
    END IF;*/

    SELECT MIN (p.autoid)
      INTO l_autoid
      FROM productselldtl p
     WHERE p.id = p_productid
           AND ( (    p.termcd = 'M'
                  AND p."FROM" <= l_months
                  AND p."TO" > l_months)
                OR (    p.termcd = 'W'
                    AND p."FROM" <= l_weeks
                    AND p."TO" > l_weeks)
                OR (p.termcd = 'D' AND p."FROM" <= l_days AND p."TO" > l_days));

    /*SELECT max(p.rate)
    INTO v_result
    FROM productselldtl p
    where autoid = l_autoid;
    */

    SELECT p.TYPE
      INTO l_types
      FROM productselldtl p
     WHERE autoid = l_autoid;

    IF l_types = 'F'
    THEN
        SELECT p.intrate
          INTO l_rate
          FROM (SELECT *
                  FROM intschd p
                 WHERE p.symbol = l_symbol --  AND p.paytype = 'INT'
                       AND p.status = 'A' AND p.reportdt >= p_frdate
                ORDER BY reportdt) p
         WHERE ROWNUM <= 1;

        SELECT l_rate + MAX (p.amplitude)
          INTO v_result
          FROM productselldtl p
         WHERE autoid = l_autoid;
    ELSIF l_types = 'C'
    THEN
        SELECT p.intrate
          INTO l_rate
          FROM (SELECT *
                  FROM intschd p
                 WHERE p.symbol = l_symbol --  AND p.paytype = 'INT'
                       AND p.status = 'A' AND p.reportdt >= p_frdate
                ORDER BY reportdt) p
         WHERE ROWNUM <= 1;

        SELECT l_rate * MAX (p.amplitude) / 100
          INTO v_result
          FROM productselldtl p
         WHERE autoid = l_autoid;
    ELSE
        SELECT MAX (p.rate)
          INTO v_result
          FROM productselldtl p
         WHERE autoid = l_autoid;
    END IF;

    RETURN NVL (v_result, 0);
EXCEPTION
    WHEN OTHERS
    THEN
        RETURN 0;                                  -- ban dau return -1, nhung
END;
/

DROP FUNCTION fn_calc_price_for_sell
/

CREATE OR REPLACE 
FUNCTION fn_calc_price_for_sell (p_productid        NUMBER,
                                 p_frdate           DATE,
                                 p_symbol           VARCHAR2,
                                 p_category         VARCHAR2,
                                 p_custodycdsell    VARCHAR2,
                                 p_custodycd        VARCHAR2)
    RETURN NUMBER
AS
    v_result        NUMBER;
    l_totalamt      NUMBER;
    l_parvalue      NUMBER;
    l_opndate       DATE;
    l_count         NUMBER;
    l_todate        DATE;
    l_startdate     DATE;
    l_calpvmethod   VARCHAR2 (20);
    l_termval       NUMBER;
    l_cstl          NUMBER;
    l_productid     NUMBER;
    l_autoid        NUMBER;
    l_rate          NUMBER;
    l_percent       NUMBER;
    pkgctx          plog.log_ctx;
    logrow          tlogdebug%ROWTYPE;
BEGIN
    v_result := 0;
    l_totalamt := 0;
    l_percent := 100;

    SELECT a.duedate,
           a.opndate,
           parvalue,
           CASE WHEN intbaseddofy = 'N' THEN 360 ELSE 365 END,
           a.autoid
      INTO l_todate,
           l_opndate,
           l_parvalue,
           l_cstl,
           l_autoid
      FROM assetdtl a
     WHERE a.symbol = p_symbol;


    SELECT NVL (MAX (p.autoid), p_productid)
      INTO l_productid
      FROM product p
     WHERE (p.shortname, p.symbol, p.afacctno, p.termval) IN
               (SELECT shortname,
                       symbol,
                       afacctno,
                       termval
                  FROM product
                 WHERE autoid = p_productid)
           AND p.effdate <= getcurrdate ()
           AND getcurrdate () < p.expdate;



    IF p_category = 'T'
    THEN
        SELECT termval,
               calpvmethod,
               CASE WHEN intbaseddofy = 'N' THEN 360 ELSE 365 END
          INTO l_termval, l_calpvmethod, l_cstl
          FROM product
         WHERE autoid = l_productid;

        SELECT COUNT (1)
          INTO l_count
          FROM buyoption b
         WHERE     b.id = l_autoid
               AND b.fixeddatebuy = 'Y'
               AND b.calldate >= p_frdate;

        IF l_calpvmethod = 'L'
        THEN
            l_rate := fn_calc_rate_for_sell (l_productid, p_frdate, l_todate);

            l_totalamt :=
                fn_calc_amt (p_frdate,
                             l_todate,
                             p_symbol,
                             '',
                             l_parvalue,
                             p_custodycd);


            v_result :=
                  l_cstl
                * l_totalamt
                / (l_cstl + l_rate * (l_todate - p_frdate) / 100);

            IF l_count > 0
            THEN
                l_totalamt := 0;

                FOR vc
                    IN (SELECT *
                          FROM buyoption b
                         WHERE     b.id = l_autoid
                               AND b.fixeddatebuy = 'Y'
                               AND b.calldate >= p_frdate
                        ORDER BY b.calldate)
                LOOP
                    l_totalamt :=
                        l_totalamt
                        + fn_calc_amt (p_frdate,
                                       vc.calldate,
                                       p_symbol,
                                       '',
                                       l_parvalue,
                                       p_custodycd)
                          * l_cstl
                          / (l_cstl + l_rate * (vc.calldate - p_frdate) / 100)
                          * l_percent
                          * TO_NUMBER (vc.buyall)
                          / 100
                          / 100;

                    l_percent :=
                        l_percent - TO_NUMBER (vc.buyall) * l_percent / 100;
                END LOOP;

                v_result := l_totalamt + v_result * l_percent / 100;
            END IF;
        ELSIF l_calpvmethod = 'PL'
        THEN
            SELECT p.fromdate
              INTO l_startdate
              FROM (SELECT *
                      FROM intschd p
                     WHERE     p.symbol = p_symbol    -- AND p.paytype = 'INT'
                           AND p.status = 'A'
                           AND p.fromdate <= p_frdate
                           AND p.todate >= p_frdate
                    ORDER BY p.reportdt) p
             WHERE ROWNUM <= 1;

            v_result :=
                fn_calc_amt_for_pl (l_startdate,
                                    p_frdate,
                                    p_symbol,
                                    '',
                                    l_parvalue,
                                    p_custodycd);
        /*  IF l_count > 0
          THEN
              SELECT SUM (b.percent)
                INTO l_count
                FROM buyoption b
               WHERE b.id = l_autoid AND b.fixeddatebuy = 'Y';

              SELECT SUM (
                         fn_calc_amt (p_frdate,
                                      b.calldate,
                                      p_symbol,
                                      '',
                                      l_parvalue,
                                      p_custodycd)

                         * b.percent
                         / 100)
                     + v_result * (1 - l_count / 100)
                INTO v_result
                FROM buyoption b
               WHERE b.id = l_autoid AND b.fixeddatebuy = 'Y';
          END IF;*/
        ELSIF l_calpvmethod = 'PV'
        THEN
            v_result := l_parvalue;
        ELSIF l_calpvmethod = 'PR'
        THEN
            l_rate := fn_calc_rate_for_sell (l_productid, p_frdate, l_todate);
            v_result :=
                fn_calc_amt_for_present (p_frdate,
                                         l_todate,
                                         p_symbol,
                                         l_cstl,
                                         l_parvalue,
                                         l_rate,
                                         p_custodycd);

            IF l_count > 0
            THEN
                FOR vc
                    IN (SELECT *
                          FROM buyoption b
                         WHERE     b.id = l_autoid
                               AND b.fixeddatebuy = 'Y'
                               AND b.calldate >= p_frdate
                        ORDER BY b.calldate)
                LOOP
                    l_totalamt :=
                        l_totalamt
                        +   fn_calc_amt_for_present (p_frdate,
                                                     vc.calldate,
                                                     p_symbol,
                                                     l_cstl,
                                                     l_parvalue,
                                                     l_rate,
                                                     p_custodycd)
                          * l_percent
                          * TO_NUMBER (vc.buyall)
                          / 100
                          / 100;
                    l_percent :=
                        l_percent - TO_NUMBER (vc.buyall) * l_percent / 100;
                END LOOP;

                v_result := l_totalamt + v_result * l_percent / 100;
            END IF;
        ELSIF l_calpvmethod = 'C'
        THEN
            l_rate :=
                fn_calc_rate_for_coupon (l_productid, p_frdate, l_todate);
            l_totalamt :=
                fn_calc_amt (p_frdate,
                             l_todate,
                             p_symbol,
                             '',
                             l_parvalue,
                             p_custodycd)
                - l_parvalue;
            v_result := l_parvalue + l_totalamt * l_rate / 100;
        ELSE
            SELECT   (p.discountrate2 - p.discountrate)
                   / (p.lastdate - p.firstdate)
                   * (p_frdate - p.firstdate)
                   + p.discountrate
              INTO l_rate
              FROM product p
             WHERE autoid = l_productid;

            SELECT NVL (MAX (reportdt), l_opndate) intdate
              INTO l_startdate
              FROM intschd p
             WHERE     p.symbol = p_symbol
                   AND p.status = 'A'                --  AND p.paytype = 'INT'
                   AND p.reportdt < p_frdate;

            l_totalamt :=
                fn_calc_amt_for_sell (l_startdate,
                                      p_frdate,
                                      p_symbol,
                                      '',
                                      l_parvalue,
                                      p_custodycd);

            v_result :=
                l_totalamt
                + l_parvalue * l_rate / l_cstl * (l_todate - p_frdate) / 100;

            IF l_count > 0
            THEN
                l_totalamt := 0;

                FOR vc
                    IN (SELECT *
                          FROM buyoption b
                         WHERE     b.id = l_autoid
                               AND b.fixeddatebuy = 'Y'
                               AND b.calldate >= p_frdate
                        ORDER BY b.calldate)
                LOOP
                    l_totalamt :=
                        l_totalamt
                        +   l_parvalue
                          * l_rate
                          / l_cstl
                          * (vc.calldate - p_frdate)
                          / 100
                          * l_percent
                          * TO_NUMBER (vc.buyall)
                          / 100
                          / 100;
                    l_percent :=
                        l_percent - TO_NUMBER (vc.buyall) * l_percent / 100;
                END LOOP;

                v_result := l_totalamt + v_result * l_percent / 100;
            END IF;
        END IF;
    ELSIF p_category = 'I'
    THEN
        v_result := l_parvalue;
    ELSE
        /* v_result := 0;

         -- tinh rate trong payment_hist
         SELECT p.intrate
           INTO l_rate
           FROM (SELECT *
                   FROM intschd p
                  WHERE p.symbol = p_symbol -- AND p.paytype = 'INT'
                        AND p.status = 'A' AND p.reportdt >= p_frdate
                 ORDER BY reportdt) p
          WHERE ROWNUM <= 1;


         -- lay dong da tinh lai
         SELECT NVL (MAX (reportdt), l_opndate) intdate
           INTO l_startdate
           FROM intschd p
          WHERE p.symbol = p_symbol --  AND p.paytype = 'INT'
                AND p.status = 'A' AND p.reportdt < p_frdate;

         v_result :=
             l_parvalue
             +   l_parvalue
               * l_rate
               / l_cstl
               * (getcurrdate () - l_startdate)
               / 100;*/

        SELECT CASE
                   WHEN p.calpv_method = 'PR'
                   THEN
                         (p.discountratelast - p.discountratefirst)
                       / (p.lastdate - p.firtdate)
                       * (p_frdate - p.firtdate)
                       + p.discountratefirst
                   ELSE
                       p.ipodiscrate
               END,
               p.calpv_method
          INTO l_rate, l_calpvmethod
          FROM sbsedefacct p
         WHERE p.symbol = p_symbol
               AND p_custodycdsell =
                       fn_get_custodycd_by_acctno (p.refafacctno);

        SELECT COUNT (1)
          INTO l_count
          FROM buyoption b
         WHERE     b.id = l_autoid
               AND b.fixeddatebuy = 'Y'
               AND b.calldate >= p_frdate;

        IF l_calpvmethod = 'L'
        THEN
            l_totalamt :=
                fn_calc_amt (p_frdate,
                             l_todate,
                             p_symbol,
                             '',
                             l_parvalue,
                             p_custodycd);


            v_result :=
                  l_cstl
                * l_totalamt
                / (l_cstl + l_rate * (l_todate - p_frdate) / 100);

            IF l_count > 0
            THEN
                l_totalamt := 0;

                FOR vc
                    IN (SELECT *
                          FROM buyoption b
                         WHERE     b.id = l_autoid
                               AND b.fixeddatebuy = 'Y'
                               AND b.calldate >= p_frdate
                        ORDER BY b.calldate)
                LOOP
                    l_totalamt :=
                        l_totalamt
                        + fn_calc_amt (p_frdate,
                                       vc.calldate,
                                       p_symbol,
                                       '',
                                       l_parvalue,
                                       p_custodycd)
                          * l_cstl
                          / (l_cstl + l_rate * (vc.calldate - p_frdate) / 100)
                          * l_percent
                          * TO_NUMBER (vc.buyall)
                          / 100
                          / 100;

                    l_percent :=
                        l_percent - TO_NUMBER (vc.buyall) * l_percent / 100;
                END LOOP;

                v_result := l_totalamt + v_result * l_percent / 100;
            END IF;
        ELSIF l_calpvmethod = 'PL'
        THEN
            SELECT p.fromdate
              INTO l_startdate
              FROM (SELECT *
                      FROM intschd p
                     WHERE     p.symbol = p_symbol    -- AND p.paytype = 'INT'
                           AND p.status = 'A'
                           AND p.fromdate <= p_frdate
                           AND p.todate >= p_frdate
                    ORDER BY p.reportdt) p
             WHERE ROWNUM <= 1;

            v_result :=
                fn_calc_amt_for_pl (l_startdate,
                                    p_frdate,
                                    p_symbol,
                                    '',
                                    l_parvalue,
                                    p_custodycd);
        /*   IF l_count > 0
           THEN
               SELECT SUM (b.percent)
                 INTO l_count
                 FROM buyoption b
                WHERE b.id = l_autoid AND b.fixeddatebuy = 'Y';

               SELECT SUM (
                          fn_calc_amt (p_frdate,
                                       b.calldate,
                                       p_symbol,
                                       '',
                                       l_parvalue,
                                       p_custodycd)

                          * b.percent
                          / 100)
                      + v_result * (1 - l_count / 100)
                 INTO v_result
                 FROM buyoption b
                WHERE b.id = l_autoid AND b.fixeddatebuy = 'Y';
           END IF;*/
        ELSIF l_calpvmethod = 'PV'
        THEN
            v_result := l_parvalue;
        ELSIF l_calpvmethod = 'PR'
        THEN
            -- l_rate := fn_calc_rate_for_sell (l_productid, p_frdate, l_todate);
            v_result :=
                fn_calc_amt_for_present (p_frdate,
                                         l_todate,
                                         p_symbol,
                                         l_cstl,
                                         l_parvalue,
                                         l_rate,
                                         p_custodycd);

            IF l_count > 0
            THEN
                FOR vc
                    IN (SELECT *
                          FROM buyoption b
                         WHERE     b.id = l_autoid
                               AND b.fixeddatebuy = 'Y'
                               AND b.calldate >= p_frdate
                        ORDER BY b.calldate)
                LOOP
                    l_totalamt :=
                        l_totalamt
                        +   fn_calc_amt_for_present (p_frdate,
                                                     vc.calldate,
                                                     p_symbol,
                                                     l_cstl,
                                                     l_parvalue,
                                                     l_rate,
                                                     p_custodycd)
                          * l_percent
                          * TO_NUMBER (vc.buyall)
                          / 100
                          / 100;
                    l_percent :=
                        l_percent - TO_NUMBER (vc.buyall) * l_percent / 100;
                END LOOP;

                v_result := l_totalamt + v_result * l_percent / 100;
            END IF;
        ELSIF l_calpvmethod = 'C'
        THEN
            l_totalamt :=
                fn_calc_amt (p_frdate,
                             l_todate,
                             p_symbol,
                             '',
                             l_parvalue,
                             p_custodycd)
                - l_parvalue;
            v_result := l_parvalue + l_totalamt * l_rate / 100;
        ELSE
            SELECT   (p.discountrate2 - p.discountrate)
                   / (p.lastdate - p.firstdate)
                   * (p_frdate - p.firstdate)
                   + p.discountrate
              INTO l_rate
              FROM product p
             WHERE autoid = l_productid;

            SELECT NVL (MAX (reportdt), l_opndate) intdate
              INTO l_startdate
              FROM intschd p
             WHERE     p.symbol = p_symbol
                   AND p.status = 'A'                --  AND p.paytype = 'INT'
                   AND p.reportdt < p_frdate;

            l_totalamt :=
                fn_calc_amt_for_sell (l_startdate,
                                      p_frdate,
                                      p_symbol,
                                      '',
                                      l_parvalue,
                                      p_custodycd);

            v_result :=
                l_totalamt
                + l_parvalue * l_rate / l_cstl * (l_todate - p_frdate) / 100;

            IF l_count > 0
            THEN
                SELECT SUM (b.percent)
                  INTO l_count
                  FROM buyoption b
                 WHERE     b.id = l_autoid
                       AND b.fixeddatebuy = 'Y'
                       AND b.calldate >= p_frdate;

                SELECT SUM (
                           (l_totalamt
                            +   l_parvalue
                              * l_rate
                              / l_cstl
                              * (b.calldate - p_frdate)
                              / 100)
                           * b.percent
                           / 100)
                       + v_result * (1 - l_count / 100)
                  INTO v_result
                  FROM buyoption b
                 WHERE     b.id = l_autoid
                       AND b.fixeddatebuy = 'Y'
                       AND b.calldate >= p_frdate;
            END IF;
        END IF;
    END IF;

    RETURN NVL (ROUND (v_result), 0);
EXCEPTION
    WHEN OTHERS
    THEN
        RETURN 0;                                  -- ban dau return -1, nhung
END;
/

DROP FUNCTION fn_calc_rate_for_coupon
/

CREATE OR REPLACE 
FUNCTION fn_calc_rate_for_coupon (p_productid    NUMBER,
                                  p_frdate       DATE,
                                  p_todate       DATE)
    RETURN NUMBER
AS
    v_result    NUMBER;
    l_termval   NUMBER;
    l_termcd    VARCHAR2 (20);
    l_days      NUMBER;
    l_symbol    VARCHAR2 (200);
    l_weeks     NUMBER;
    l_months    NUMBER;
    l_autoid    NUMBER;
    l_rate      NUMBER;
    l_count     NUMBER;
    l_types     VARCHAR (20);
    pkgctx      plog.log_ctx;
    logrow      tlogdebug%ROWTYPE;
BEGIN
    v_result := 0;

    SELECT symbol
      INTO l_symbol
      FROM product
     WHERE autoid = p_productid;



    SELECT p_todate - p_frdate days,
           (p_todate - p_frdate) / 7 weeks,
           fn_monthdiff (p_frdate, p_todate) months,
           termcd
      INTO l_days,
           l_weeks,
           l_months,
           l_termcd
      FROM product
     WHERE autoid = p_productid;



    SELECT MIN (p.autoid)
      INTO l_autoid
      FROM PRODUCTCOUPONDTL p
     WHERE p.id = p_productid
           AND ( (    p.termcd = 'M'
                  AND p."FROM" <= l_months
                  AND p."TO" > l_months)
                OR (    p.termcd = 'W'
                    AND p."FROM" <= l_weeks
                    AND p."TO" > l_weeks)
                OR (p.termcd = 'D' AND p."FROM" <= l_days AND p."TO" > l_days));


    SELECT
        RATIO
    INTO
        v_result
    FROM
        PRODUCTCOUPONDTL
    WHERE
        AUTOID = l_autoid ;


    RETURN NVL (v_result, 0);
EXCEPTION
    WHEN OTHERS
    THEN
        RETURN 0;                                  -- ban dau return -1, nhung
END;
/

DROP FUNCTION fn_calc_type_feerate_for_buy
/

CREATE OR REPLACE 
FUNCTION fn_calc_type_feerate_for_buy (p_productid    NUMBER,
                                       p_frdate       DATE,
                                       p_todate       DATE)
    RETURN VARCHAR2
AS
    v_result        VARCHAR2 (20);
    l_termval       NUMBER;
    l_termcd        VARCHAR2 (20);
    l_days          NUMBER;
    l_symbol        VARCHAR2 (200);
    l_weeks         NUMBER;
    l_months        NUMBER;
    l_autoid        NUMBER;
    l_autoidc       NUMBER;
    l_ratepayment   NUMBER;
    l_count         NUMBER;
    l_intrate       NUMBER;
    l_types         VARCHAR2 (20);
    pkgctx          plog.log_ctx;
    logrow          tlogdebug%ROWTYPE;
BEGIN
    v_result := 'N';



    SELECT p_todate - p_frdate days,
           (p_todate - p_frdate) / 7 weeks,
           fn_monthdiff (p_frdate, p_todate) months,
           termcd
      INTO l_days,
           l_weeks,
           l_months,
           l_termcd
      FROM product
     WHERE autoid = p_productid;



    SELECT MIN (p.autoid)
      INTO l_autoid
      FROM productbuydtl p
     WHERE p.id = p_productid
           AND ( (    p.termcd = 'M'
                  AND p."FROM" <= l_months
                  AND p."TO" > l_months)
                OR (    p.termcd = 'W'
                    AND p."FROM" <= l_weeks
                    AND p."TO" > l_weeks)
                OR (p.termcd = 'D' AND p."FROM" <= l_days AND p."TO" > l_days));


    l_autoidc := l_autoid;


    SELECT p.TYPE
      INTO l_types
      FROM productbuydtl p
     WHERE autoid = l_autoidc;

    SELECT symbol
      INTO l_symbol
      FROM product
     WHERE autoid = p_productid;



    SELECT                                                      -- max(p.rate)
          NVL (p.isdaytypefee, 'N')
      INTO v_result
      FROM productbuydtl p
     WHERE autoid = l_autoidc;

    RETURN NVL (v_result, 'N');
EXCEPTION
    WHEN OTHERS
    THEN
        RETURN '';                                 -- ban dau return -1, nhung
END;
/

DROP FUNCTION fn_get_custodycd_by_acctno
/

CREATE OR REPLACE 
FUNCTION fn_get_custodycd_by_acctno (p_acctno in varchar2) RETURN VARCHAR2 AS
l_custodycd varchar2(50);
BEGIN
  select af.custodycd into l_custodycd
            from afmast af
            where af.acctno = p_acctno;
              
            RETURN l_custodycd;
END FN_GET_CUSTODYCD_BY_ACCTNO;
/

DROP FUNCTION fn_calc_price_for_buy
/

CREATE OR REPLACE 
FUNCTION fn_calc_price_for_buy (p_frdate DATE, p_orderid VARCHAR2)
    RETURN NUMBER
AS
    v_result           NUMBER;
    l_totalamt         NUMBER;
    l_parvalue         NUMBER;
    l_opndate          DATE;
    l_count            NUMBER;
    l_todate           DATE;
    l_startdate        DATE;
    l_calpvmethod      VARCHAR2 (20);
    l_termval          NUMBER;
    l_cstl             NUMBER;
    l_rate             NUMBER;
    l_productid        NUMBER;
    l_orgprice         NUMBER;
    l_symbol           VARCHAR2 (200);
    l_termcd           VARCHAR2 (200);
    l_feebuyrate       NUMBER;
    l_fee              NUMBER;
    l_feediff          NUMBER;
    l_totalfeediff     NUMBER;
    l_feerate          NUMBER;
    l_totalfeerate     NUMBER;
    l_execqtty         NUMBER;
    l_couponreceived   NUMBER;
    l_datereceived     DATE;
    l_frdate           DATE;
    l_custodycdsell    VARCHAR2 (200);
    l_custodycdbuy     VARCHAR2 (200);
    l_overduerate      number;
    l_typefeerate      varchar2(20) ;
    pkgctx             plog.log_ctx;
    logrow             tlogdebug%ROWTYPE;
BEGIN
    v_result := 0;
    l_typefeerate:= 'N' ;

    SELECT o.productid,
           o.orgdate,
           o.orgprice,
           o.symbol,
          o.execqtty ,
           fn_get_custodycd_by_acctno (o.acbuyer),
           fn_get_custodycd_by_acctno (o.acseller)

      INTO l_productid,
           l_startdate,
           l_orgprice,
           l_symbol,
           l_execqtty,
           l_custodycdbuy,
           l_custodycdsell

      FROM oxmast o
     WHERE o.orderid = p_orderid;

    SELECT a.duedate, a.opndate
      INTO l_todate, l_opndate
      FROM assetdtl a
     WHERE a.symbol = l_symbol;

    SELECT LEAST (p_frdate, l_todate) INTO l_frdate FROM DUAL;

    SELECT termval,
           calpvmethod,
           CASE WHEN intbaseddofy = 'N' THEN 360 ELSE 365 END,
           termcd,
           nvl(overduerate ,0)
      INTO l_termval,
           l_calpvmethod,
           l_cstl,
           l_termcd,
           l_overduerate -- lãi quá han
      FROM product
     WHERE autoid = l_productid;



    SELECT a.parvalue
      INTO l_parvalue
      FROM assetdtl a
     WHERE a.symbol = l_symbol;

    -- Tinh rate tu ngay mua -> ngay curr date
    l_feebuyrate := 0;
    l_couponreceived := 0;

    IF l_calpvmethod in  ('L' , 'PR', 'PL', 'PV')
    THEN
        SELECT CASE when l_termval = 0 then l_frdate
                   WHEN l_termcd = 'D' THEN l_startdate + l_termval
                   WHEN l_termcd = 'W' THEN l_startdate + l_termval * 7
                   ELSE ADD_MONTHS (l_startdate, l_termval)
               END
          INTO l_datereceived
          FROM DUAL;

        -- if l_datereceived > l_frdate then

          SELECT   FN_CALC_RATE_FOR_BUY (l_productid, l_startdate,case when l_datereceived >= l_frdate then   l_frdate else l_datereceived end , p_orderid)
          INTO l_rate
          FROM DUAL;
         SELECT case when l_datereceived <= l_frdate  then 0 else  FN_CALC_RATE_FOR_BUY (l_productid, l_startdate, case when l_datereceived >= l_frdate then   l_frdate else l_datereceived end, 'FEE') end
          INTO l_feebuyrate
          FROM DUAL;
         select fn_calc_type_feerate_for_buy(l_productid ,l_startdate , l_frdate   ) into  l_typefeerate from dual ;
        if   l_datereceived >= l_frdate then
            v_result :=    l_orgprice*  l_rate * (l_frdate - l_startdate) / 100 / l_cstl    + l_orgprice     ;
        else
            l_datereceived := get_workdate(l_datereceived) ;
            v_result :=  l_orgprice*  l_rate * (l_datereceived - l_startdate) / 100 / l_cstl    + l_orgprice + l_orgprice*  l_overduerate * (l_frdate - l_datereceived) / 100 / l_cstl   ;
        end if;

        SELECT NVL (SUM (NVL (a.amount, 0)
                         - fn_calc_fee (p.valuedt,
                                        '001',
                                        '',
                                        l_symbol,
                                        l_custodycdbuy,
                                        '',
                                        '',
                                        a.amount,
                                        a.amount)),
                    0)
          INTO l_couponreceived
          FROM     intschd a
               INNER JOIN
                   payment_schd p
               ON     a.periodno <= p.toperiod
                  AND a.periodno >= p.fromperiod
                  AND a.symbol = p.symbol
         WHERE a.symbol = l_symbol --   AND paytype = 'INT'
               AND a.reportdt >= l_startdate AND a.reportdt <= l_frdate;
    v_result:= v_result - l_couponreceived /* - (case when l_typefeerate = 'N' then  v_result * l_feebuyrate/100 else   v_result * l_feebuyrate * (  l_frdate  - l_startdate)  /l_cstl/100 end   ) */;
    ELSIF l_calpvmethod = 'C'
    THEN
        l_rate :=
            fn_calc_rate_for_coupon (l_productid, l_startdate, l_frdate)
            - fn_calc_rate_for_coupon (l_productid, l_startdate, l_todate);
        v_result :=
            fn_calc_amt (l_startdate,
                         l_frdate,
                         l_symbol,
                         '',
                         l_parvalue,
                         l_custodycdbuy)
            - l_parvalue;
        v_result := l_rate * v_result/100 + l_parvalue;
    ELSE
        SELECT   (p.discountrate2 - p.discountrate)
               / (p.lastdate - p.firstdate)
               * (LEAST (l_frdate, p.lastdate) - p.firstdate)
               + p.discountrate,
               p.feebuyrate
          INTO l_rate, l_feebuyrate
          FROM product p
         WHERE autoid = l_productid;

        SELECT fn_calc_price_for_sell (l_productid,
                                       getcurrdate (),
                                       l_symbol,
                                       'T',
                                       l_custodycdsell,
                                       l_custodycdbuy)
          INTO l_orgprice
          FROM DUAL;



        v_result := l_orgprice;
    END IF;

    -- tong tien thanh toan


    SELECT fn_calc_fee (p_txdate      => l_frdate,
                        p_feetype     => '002',
                        p_exectype    => '',
                        p_symbol      => l_symbol,
                        p_custodycd   => l_custodycdbuy,
                        p_product     => l_productid,
                        p_combo       => '',
                        p_amt         => 0,
                        p_amtp        => l_parvalue * l_execqtty)
           + fn_calc_fee_fortype (p_date        => l_frdate,
                                  p_exectype    => 'CS',
                                  p_symbol      => l_symbol,
                                  p_custodycd   => l_custodycdbuy,
                                  p_product     => l_productid,
                                  p_combo       => '',
                                  p_amt         => 0,
                                  p_amtp        => l_parvalue * l_execqtty)
      INTO l_fee
      FROM DUAL;

    v_result :=
          v_result
        + l_fee / l_execqtty
      ;
    l_feerate := 0;
    l_totalfeerate := 0;

    -- Tinh tong % phi theo
    FOR vc
        IN (SELECT DISTINCT feetype
              FROM feetype f
             WHERE     exectype = 'CS'
                   AND (status = 'A' OR pstatus LIKE '%A%')
                   AND (p_frdate BETWEEN frdate AND todate - 1))
    LOOP
        SELECT fn_calc_feerate_for_buy (p_txdate          => l_frdate,
                                        p_feetype         => vc.feetype,
                                        p_exectype        => 'CS',
                                        p_symbol          => l_symbol,
                                        p_custodycd       => l_custodycdbuy,
                                        p_custodycdsell   => l_custodycdsell,
                                        p_product         => l_productid,
                                        p_combo           => '',
                                        p_calcmethod      => 'P',
                                        p_amt             => 0)
          INTO l_feerate
          FROM DUAL;

        l_totalfeerate := l_totalfeerate + l_feerate;
    END LOOP;

    SELECT fn_calc_feerate_for_buy (p_txdate          => l_frdate,
                                    p_feetype         => '002',
                                    p_exectype        => '',
                                    p_symbol          => l_symbol,
                                    p_custodycd       => l_custodycdbuy,
                                    p_custodycdsell   => l_custodycdsell,
                                    p_product         => l_productid,
                                    p_combo           => '',
                                    p_calcmethod      => 'P',
                                    p_amt             => 0)
      INTO l_feerate
      FROM DUAL;

    l_totalfeerate := l_totalfeerate + l_feerate;
    v_result := v_result / (1 - l_totalfeerate / 100);

    -- Tinh phi chenh lech min max
    l_totalfeediff := 0;

    FOR vc
        IN (SELECT DISTINCT feetype
              FROM feetype f
             WHERE     exectype = 'CS'
                   AND (status = 'A' OR pstatus LIKE '%A%')
                   AND (p_frdate BETWEEN frdate AND todate - 1))
    LOOP
        SELECT fn_calc_feerate_for_buy (
                   p_txdate          => l_frdate,
                   p_feetype         => vc.feetype,
                   p_exectype        => 'CS',
                   p_symbol          => l_symbol,
                   p_custodycd       => l_custodycdbuy,
                   p_custodycdsell   => l_custodycdsell,
                   p_product         => l_productid,
                   p_combo           => '',
                   p_calcmethod      => 'V',
                   p_amt             => v_result * l_execqtty)
          INTO l_feediff
          FROM DUAL;

        l_totalfeediff := l_totalfeediff + l_feediff;
    END LOOP;

    SELECT fn_calc_feerate_for_buy (
               p_txdate          => l_frdate,
               p_feetype         => '002',
               p_exectype        => '',
               p_symbol          => l_symbol,
               p_custodycd       => l_custodycdbuy,
               p_custodycdsell   => l_custodycdsell,
               p_product         => l_productid,
               p_combo           => '',
               p_calcmethod      => 'V',
               p_amt             => v_result * l_execqtty)
      INTO l_feediff
      FROM DUAL;

    l_totalfeediff := l_totalfeediff + l_feediff;

    -- cong phi chenh lech vao gia

    v_result := l_totalfeediff / l_execqtty + v_result;
    RETURN NVL (ROUND (v_result), -1);
EXCEPTION
    WHEN OTHERS
    THEN
        RETURN 1;                                  -- ban dau return -1, nhung
END;
/

DROP FUNCTION fn_calc_rate_for_buy
/

CREATE OR REPLACE 
FUNCTION fn_calc_rate_for_buy (p_productid    NUMBER,
                                 p_frdate       DATE,
                                 p_todate       DATE,
                                 p_types        VARCHAR2)
    RETURN NUMBER
AS
    v_result        NUMBER;
    l_termval       NUMBER;
    l_termcd        VARCHAR2 (20);
    l_days          NUMBER;
    l_symbol        VARCHAR2 (200);
    l_weeks         NUMBER;
    l_months        NUMBER;
    l_autoid        NUMBER;
    l_autoidc       NUMBER;
    l_ratepayment   NUMBER;
    l_count         NUMBER;
    l_intrate       NUMBER;
    l_types         VARCHAR2 (20);
    pkgctx          plog.log_ctx;
    logrow          tlogdebug%ROWTYPE;
BEGIN
    v_result := 0;



    SELECT p_todate - p_frdate days,
           (p_todate - p_frdate) / 7 weeks,
           fn_monthdiff (p_frdate, p_todate) months,
           termcd
      INTO l_days,
           l_weeks,
           l_months,
           l_termcd
      FROM product
     WHERE autoid = p_productid;



    SELECT MIN (p.autoid)
      INTO l_autoid
      FROM productbuydtl p
     WHERE p.id = p_productid
           AND ( (    p.termcd = 'M'
                  AND p."FROM" <= l_months
                  AND p."TO" > l_months)
                OR (    p.termcd = 'W'
                    AND p."FROM" <= l_weeks
                    AND p."TO" > l_weeks)
                OR (p.termcd = 'D' AND p."FROM" <= l_days AND p."TO" > l_days));


    l_autoidc := l_autoid;


    SELECT p.TYPE
      INTO l_types
      FROM productbuydtl p
     WHERE autoid = l_autoidc;

    SELECT symbol
      INTO l_symbol
      FROM product
     WHERE autoid = p_productid;

    IF l_types = 'F'
    THEN
        SELECT p.intrate
          INTO l_intrate
          FROM (SELECT *
                  FROM intschd p
                 WHERE     p.symbol = l_symbol
                       AND p.status = 'A'
                       AND p.reportdt >= p_frdate
                ORDER BY reportdt) p
         WHERE ROWNUM <= 1;

        SELECT CASE
                   WHEN p.calfee_method = 'F'
                   THEN
                       l_intrate + nvl(p.amplitude, 0 ) - p.feebuy
                   ELSE
                       l_intrate + nvl(p.amplitude, 0 )
               END
          INTO v_result
          FROM productbuydtl p
         WHERE autoid = l_autoidc;
    ELSIF l_types = 'V'
    THEN
        SELECT CASE
                   WHEN p.calfee_method = 'F' THEN p.rate - p.feebuy
                   ELSE p.rate
               END
          INTO v_result
          FROM productbuydtl p
         WHERE autoid = l_autoidc;
    ELSIF l_types = 'B'
    THEN
        SELECT p.intrate
          INTO l_intrate
          FROM (SELECT *
                  FROM intschd p
                 WHERE     p.symbol = l_symbol
                       AND p.status = 'A'
                       AND p.todate >= p_todate
                ORDER BY reportdt) p
         WHERE ROWNUM <= 1;

        SELECT CASE
                   WHEN p.calfee_method = 'F'
                   THEN
                       l_intrate + nvl(p.amplitude, 0 ) - p.feebuy
                   ELSE
                       l_intrate + nvl(p.amplitude, 0 )
               END
          INTO v_result
          FROM productbuydtl p
         WHERE autoid = l_autoidc;
    ELSIF l_types = 'R'
    THEN
        SELECT p.intrate
          INTO l_intrate
          FROM (SELECT *
                  FROM intschd p
                 WHERE     p.symbol = l_symbol
                       AND p.status = 'A'
                       AND p.todate >= p_todate
                ORDER BY reportdt) p
         WHERE ROWNUM <= 1;

        SELECT CASE
                   WHEN p.calfee_method = 'F'
                   THEN
                       l_intrate * nvl(p.amplitude, 0 ) / 100 - p.feebuy
                   ELSE
                       l_intrate * nvl(p.amplitude, 0 ) / 100
               END
          INTO v_result
          FROM productbuydtl p
         WHERE autoid = l_autoidc;
    ELSE
        SELECT p.intrate
          INTO l_intrate
          FROM (SELECT *
                  FROM intschd p
                 WHERE     p.symbol = l_symbol
                       AND p.status = 'A'
                       AND p.reportdt >= p_frdate
                ORDER BY reportdt) p
         WHERE ROWNUM <= 1;

        SELECT CASE
                   WHEN p.calfee_method = 'F'
                   THEN
                       l_intrate * nvl(p.amplitude, 0 ) / 100 - p.feebuy
                   ELSE
                       l_intrate * nvl(p.amplitude, 0 ) / 100
               END
          INTO v_result
          FROM productbuydtl p
         WHERE autoid = l_autoidc;
    /*ELSE
        SELECT CASE
                   WHEN p_types IS NULL OR p_types = ''
                   THEN
                       fn_calc_rate_for_sell (p_productid,
                                              p_frdate,
                                              (SELECT duedate
                                                 FROM assetdtl
                                                WHERE symbol = l_symbol))
                   ELSE
                       NVL (intrate, 0)
               END
          INTO l_intrate
          FROM oxmast
         WHERE orderid = p_types;

        SELECT l_intrate + p.amplitude
          INTO v_result
          FROM productbuydtl p
         WHERE autoid = l_autoidc;*/
    END IF;



    SELECT                                                      -- max(p.rate)
          CASE
               WHEN p_types = 'FEE' AND p.calfee_method = 'C' THEN p.feebuy
               WHEN p_types = 'FEE' AND p.calfee_method = 'F' THEN 0
               ELSE v_result
           END
      INTO v_result
      FROM productbuydtl p
     WHERE autoid = l_autoidc;

    RETURN NVL (v_result, 0);
EXCEPTION
    WHEN OTHERS
    THEN
        RETURN 0;                                  -- ban dau return -1, nhung
END;
/

DROP FUNCTION fn_calc_price_for_customer
/

CREATE OR REPLACE 
FUNCTION fn_calc_price_for_customer (
                                      p_productid    NUMBER,
                                      p_frdate       DATE,
                                      p_orgdate      DATE ,
                                      p_matdate      DATE,
                                      p_orgprice     NUMBER,
                                      p_symbol       VARCHAR2,
                                      p_custodycd    VARCHAR2)
 RETURN NUMBER
AS
    v_result        NUMBER;
    l_parvalue      NUMBER ;
    l_startdate      DATE ;
    l_counponreceived  NUMBER;
    l_rate           NUMBER ;
    l_cstl          NUMBER;
    pkgctx          plog.log_ctx;
    logrow          tlogdebug%ROWTYPE;
BEGIN
    SELECT parvalue INTO l_parvalue  FROM assetdtl WHERE symbol = p_symbol ;
    SELECT fn_calc_amt(
                p_orgdate ,
                p_frdate ,
                p_symbol ,
                '',
                l_parvalue ,
                p_custodycd
            ) - l_parvalue  INTO l_counponreceived FROM dual ;


    SELECT fn_calc_rate_for_buy(p_productid ,p_orgdate ,p_matdate , ''   ) INTO l_rate  FROM dual ;
    SELECT CASE WHEN INTBASEDDOFY = 'A' THEN 365 ELSE 360 END  INTO l_cstl FROM product WHERE autoid = p_productid ;
    v_result:= p_orgprice * (1 + l_rate /l_cstl * (p_frdate - p_orgdate  )  / 100 ) - l_counponreceived ;

    RETURN NVL (ROUND (v_result), 0);
EXCEPTION
    WHEN OTHERS
    THEN
        RETURN 0;                                  -- ban dau return -1, nhung
END;
/

DROP FUNCTION fn_calc_price_for_request
/

CREATE OR REPLACE 
FUNCTION fn_calc_price_for_request (p_productid    NUMBER,
                                      p_frdate       DATE,
                                      p_symbol       VARCHAR2,
                                      p_category     VARCHAR2,
                                      p_custodycd    VARCHAR2,
                                      p_fee          NUMBER,
                                      p_rate         NUMBER,
                                      p_margin       NUMBER)
    RETURN NUMBER
AS
    v_result        NUMBER;
    l_totalamt      NUMBER;
    l_parvalue      NUMBER;
    l_opndate       DATE;
    l_count         NUMBER;
    l_todate        DATE;
    l_startdate     DATE;
    l_calpvmethod   VARCHAR2 (20);
    l_termval       NUMBER;
    l_cstl          NUMBER;
    l_productid     NUMBER;
    l_autoid        NUMBER;
    l_rate          NUMBER;
    l_percent       number;
    pkgctx          plog.log_ctx;
    logrow          tlogdebug%ROWTYPE;
BEGIN
    v_result := 0;
    l_percent:= 100 ;
    SELECT a.duedate,
           a.opndate,
           parvalue,
           CASE WHEN intbaseddofy = 'N' THEN 360 ELSE 365 END,
           a.autoid
      INTO l_todate,
           l_opndate,
           l_parvalue,
           l_cstl,
           l_autoid
      FROM assetdtl a
     WHERE a.symbol = p_symbol;


    SELECT NVL (MAX (p.autoid), p_productid)
      INTO l_productid
      FROM product p
     WHERE (p.shortname, p.symbol, p.afacctno, p.termval) IN
               (SELECT shortname,
                       symbol,
                       afacctno,
                       termval
                  FROM product
                 WHERE autoid = p_productid)
           AND p.effdate <= getcurrdate ()
           AND getcurrdate () < p.expdate;

    SELECT termval,
           calpvmethod,
           CASE WHEN intbaseddofy = 'N' THEN 360 ELSE 365 END
      INTO l_termval, l_calpvmethod, l_cstl
      FROM product
     WHERE autoid = l_productid;

    SELECT COUNT (1)
      INTO l_count
      FROM buyoption b
     WHERE b.id = l_autoid AND b.fixeddatebuy = 'Y' and b.calldate >= p_frdate;

    IF p_category = 'L'
    THEN
        l_rate := p_rate;

        l_totalamt :=
            fn_calc_amt (p_frdate,
                         l_todate,
                         p_symbol,
                         '',
                         l_parvalue,
                         p_custodycd);


        v_result :=
              l_cstl
            * l_totalamt
            / (l_cstl + l_rate * (l_todate - p_frdate) / 100);

        IF l_count > 0
        THEN
            l_totalamt := 0;

            FOR vc
                IN (SELECT *
                      FROM buyoption b
                     WHERE     b.id = l_autoid
                           AND b.fixeddatebuy = 'Y'
                           AND b.calldate >= p_frdate
                    ORDER BY b.calldate)
            LOOP
                l_totalamt :=
                    l_totalamt
                    + fn_calc_amt (p_frdate,
                                   vc.calldate,
                                   p_symbol,
                                   '',
                                   l_parvalue,
                                   p_custodycd)
                      * l_cstl
                      / (l_cstl + l_rate * (vc.calldate - p_frdate) / 100)
                      * l_percent
                      * TO_NUMBER (vc.buyall)
                      / 100
                      / 100;

                l_percent :=
                    l_percent - TO_NUMBER (vc.buyall) * l_percent / 100;
            END LOOP;

            v_result := l_totalamt + v_result * l_percent / 100;
        END IF;
    ELSIF p_category = 'C'
    THEN
        l_rate := p_rate;
        l_totalamt :=
            fn_calc_amt (p_frdate,
                         l_todate,
                         p_symbol,
                         '',
                         l_parvalue,
                         p_custodycd)
            - l_parvalue;
        v_result := l_totalamt * p_rate / 100 + l_parvalue;
    ELSIF l_calpvmethod = 'PL'
    THEN
        l_rate := p_rate;
        SELECT p.fromdate
          INTO l_startdate
          FROM (SELECT *
                  FROM intschd p
                 WHERE     p.symbol = p_symbol    -- AND p.paytype = 'INT'
                       AND p.status = 'A'
                       AND p.fromdate <= p_frdate
                       AND p.todate >= p_frdate
                ORDER BY p.reportdt) p
         WHERE ROWNUM <= 1;
         v_result := l_parvalue + l_parvalue * (p_frdate - l_startdate ) * l_rate /l_cstl /100 ;
    ELSIF l_calpvmethod = 'PV'
    THEN
        v_result := l_parvalue;
    ELSIF l_calpvmethod = 'PR'
    THEN
        l_rate :=  p_rate;
        v_result :=
            fn_calc_amt_for_present (p_frdate,
                                     l_todate,
                                     p_symbol,
                                     l_cstl,
                                     l_parvalue,
                                     l_rate,
                                     p_custodycd);

        IF l_count > 0
        THEN
            l_totalamt:= 0 ;
            FOR vc
                IN (SELECT *
                      FROM buyoption b
                     WHERE     b.id = l_autoid
                           AND b.fixeddatebuy = 'Y'
                           AND b.calldate >= p_frdate
                    ORDER BY b.calldate)
            LOOP
                l_totalamt :=
                    l_totalamt
                    +   fn_calc_amt_for_present (p_frdate,
                                                 vc.calldate,
                                                 p_symbol,
                                                 l_cstl,
                                                 l_parvalue,
                                                 l_rate,
                                                 p_custodycd)
                      * l_percent
                      * TO_NUMBER (vc.buyall)
                      / 100
                      / 100;
                l_percent :=
                    l_percent - TO_NUMBER (vc.buyall) * l_percent / 100;
            END LOOP;

            v_result := l_totalamt + v_result * l_percent / 100;
        END IF;
    ELSE
        /*  SELECT   (p.discountrate2 - p.discountrate)
                 / (p.lastdate - p.firstdate)
                 * (p_frdate - p.firstdate)
                 + p.discountrate
            INTO l_rate
            FROM product p
           WHERE autoid = l_productid;*/
        l_rate := p_margin;

        SELECT NVL (MAX (reportdt), l_opndate) intdate
          INTO l_startdate
          FROM intschd p
         WHERE p.symbol = p_symbol AND p.status = 'A' --  AND p.paytype = 'INT'
               AND p.reportdt < p_frdate;

        l_totalamt :=
            fn_calc_amt_for_sell (l_startdate,
                                  p_frdate,
                                  p_symbol,
                                  '',
                                  l_parvalue,
                                  p_custodycd);

        v_result :=
            l_totalamt
            + l_parvalue * l_rate / l_cstl * (l_todate - p_frdate) / 100;

        IF l_count > 0
        THEN
            l_totalamt := 0;

            FOR vc
                IN (SELECT *
                      FROM buyoption b
                     WHERE     b.id = l_autoid
                           AND b.fixeddatebuy = 'Y'
                           AND b.calldate >= p_frdate
                    ORDER BY b.calldate)
            LOOP
                l_totalamt :=
                    l_totalamt
                    +   l_parvalue
                      * l_rate
                      / l_cstl
                      * (vc.calldate - p_frdate)
                      / 100
                      * l_percent
                      * TO_NUMBER (vc.buyall)
                      / 100
                      / 100;
                l_percent :=
                    l_percent - TO_NUMBER (vc.buyall) * l_percent / 100;
            END LOOP;

            v_result := l_totalamt + v_result * l_percent / 100;
        END IF;
    END IF;


    RETURN NVL (ROUND (v_result), 0);
EXCEPTION
    WHEN OTHERS
    THEN
        RETURN 0;                                  -- ban dau return -1, nhung
END;
/

DROP FUNCTION fn_calc_price_for_suggest
/

CREATE OR REPLACE 
FUNCTION fn_calc_price_for_suggest (
                                      p_productid    NUMBER,
                                      p_frdate       DATE,
                                      p_orgprice     NUMBER,
                                      p_symbol       VARCHAR2,
                                      p_custodycd    VARCHAR2)
 RETURN NUMBER
AS
    v_result        NUMBER;
    l_parvalue      NUMBER ;
   l_startdate      DATE ;
    pkgctx          plog.log_ctx;
    logrow          tlogdebug%ROWTYPE;
BEGIN
    SELECT p.fromdate
      INTO l_startdate
      FROM (SELECT *
              FROM intschd p
             WHERE     p.symbol = p_symbol    -- AND p.paytype = 'INT'
                   AND p.status = 'A'
                   AND p.fromdate <= p_frdate
                   AND p.todate >= p_frdate
            ORDER BY p.reportdt) p
     WHERE ROWNUM <= 1;
    SELECT parvalue INTO l_parvalue  FROM assetdtl WHERE symbol = p_symbol ;
    v_result :=
        fn_calc_amt_for_pl (l_startdate,
                            p_frdate,
                            p_symbol,
                            '',
                            l_parvalue,
                            p_custodycd);
     IF p_productid = 0 THEN
        v_result := v_result   ;
     ELSE
        v_result := v_result + p_orgprice - l_parvalue ;
     END IF;

    RETURN NVL (ROUND (v_result), 0);
EXCEPTION
    WHEN OTHERS
    THEN
        RETURN 0;                                  -- ban dau return -1, nhung
END;
/

DROP FUNCTION fn_calc_rate
/

CREATE OR REPLACE 
FUNCTION fn_calc_rate (p_date date,   p_symbol varchar2,  p_product varchar2, p_amt NUMBER  )
 RETURN number

AS
l_autoid  number;
l_intbaseddofy number;
l_intrate number;
l_parvalue  number;
 v_result  number;
 l_days     NUMBER ;
 l_totalday NUMBER;
 l_rate    NUMBER;
l_totalrate NUMBER;
l_fee      NUMBER;
l_duedate  DATE;
l_matdate DATE;
l_rptdate DATE;
l_feebuy  number ;
l_symbol   varchar2(200);
    pkgctx plog.log_ctx;
  logrow tlogdebug%rowtype;
BEGIN
    l_symbol:= p_symbol ;
    v_result:= 0 ;
    l_days:= 0 ;
   l_totalday:= 0 ;
   l_rate:= 0 ;
  l_totalrate:= p_amt;
  SELECT intrate,
                   parvalue,
                   CASE WHEN intbaseddofy = 'N' THEN 360 ELSE 365 END
                       intbaseddofy,

                   duedate
              INTO l_intrate,
                   l_parvalue,
                   l_intbaseddofy,

                   l_duedate
              FROM assetdtl
             WHERE symbol = l_symbol;

    l_matdate:=  l_duedate;

 select fn_calc_fee_fortype
                    (
                    p_date => getcurrdate() ,
                    p_exectype=> 'CB',
                     p_symbol=>l_symbol,
                     p_custodycd=>'',
                     p_product=>'',
                     p_combo=>'',
                     p_amt=>p_amt,
                     p_amtp=>p_amt) into l_feebuy from dual ;
 SELECT p_amt
    -
    fn_calc_fee_fortype
                    (p_date => l_matdate,
                     p_exectype=> 'CS',
                     p_symbol=>l_symbol,
                     p_custodycd=>'',
                     p_product=>'',
                     p_combo=>'',
                     p_amt=>p_amt,
                     p_amtp=>p_amt)
     -
                    fn_calc_fee (
                   l_matdate,
                   '002',
                   '',
                   l_symbol,
                   '',
                   '',
                   '',
                    p_amt,
                    p_amt) into l_totalrate from dual ;

    FOR r
        IN (SELECT *
              FROM INTSCHD
             WHERE     symbol = l_symbol
                  -- AND paytype = 'INT'              --and status = 'P'
                   AND reportdt >= p_date
                   AND reportdt <
                           NVL (l_matdate,
                                TO_DATE ('31/12/2099', 'DD/MM/YYYY')))
      LOOP
        l_autoid := r.autoid;
        l_intrate := r.intrate;
         l_rptdate := r.reportdt;

         SELECT reportdt - prevdate days
          INTO l_days
          FROM (SELECT a.reportdt,
                       a.amount,
                       MAX (NVL (b.reportdt, a.reportdt))
                           prevdate
                  FROM     (SELECT a.reportdt,
                                   a.amount,
                                   b.opndate - 1 orgvaluedt
                              FROM INTSCHD a, assetdtl b
                             WHERE     a.symbol = l_symbol
                                   --AND a.STATUS='P'

                                   AND a.symbol = b.symbol
                                   AND b.symbol = l_symbol
                                   AND a.autoid = l_autoid) a
                       LEFT JOIN
                           (SELECT reportdt
                              FROM INTSCHD
                             WHERE symbol = l_symbol
                                  ) b
                       ON b.reportdt < a.reportdt
                GROUP BY a.reportdt, a.amount) a;
     -- l_totalday := l_days + l_totalday ;
      l_rate    := round(l_intrate * l_days* p_amt /l_intbaseddofy/100)  ;
      SELECT    fn_calc_fee (
                   l_rptdate,
                   '001',
                   '',
                   l_symbol,
                   '',
                   '',
                   '',
                   l_rate,
                   l_rate ) INTO l_fee FROM dual ;
      l_totalrate:= l_totalrate + l_rate - l_fee;
    --  l_totalrate :=  l_rate    + l_totalrate  -  l_fee  ;
      END LOOP;
  select l_matdate  -  p_date  into l_totalday from dual ;
     v_result:=( l_totalrate - p_amt )  / (p_amt + l_feebuy)* l_intbaseddofy * 100 /l_totalday   ;
    RETURN nvl(v_result,0);

exception
  when others then
    return 0;-- ban dau return -1, nhung
end;
/

DROP FUNCTION fn_calc_rate_buydtl
/

CREATE OR REPLACE 
FUNCTION fn_calc_rate_buydtl (p_productid    NUMBER,
                                 p_frdate       DATE,
                                 p_todate       DATE,
                                 p_types        VARCHAR2)
    RETURN NUMBER
AS
    v_result        NUMBER;
    l_termval       NUMBER;
    l_termcd        VARCHAR2 (20);
    l_days          NUMBER;
    l_symbol        VARCHAR2 (200);
    l_weeks         NUMBER;
    l_months        NUMBER;
    l_autoid        NUMBER;
    l_autoidc       NUMBER;
    l_ratepayment   NUMBER;
    l_count         NUMBER;
    l_intrate       NUMBER;
    l_types         VARCHAR2 (20);
    l_calpvmethod varchar2(10);
    pkgctx          plog.log_ctx;
    logrow          tlogdebug%ROWTYPE;
BEGIN
    v_result := 0;


select calpvmethod into l_calpvmethod from product where autoid = p_productid;
SELECT p_todate - p_frdate days,
           (p_todate - p_frdate) / 7 weeks,
           fn_monthdiff (p_frdate, p_todate) months,
           termcd
      INTO l_days,
           l_weeks,
           l_months,
           l_termcd
      FROM product
     WHERE autoid = p_productid;

 IF l_calpvmethod in( 'L','PR','PV','PL') then
    SELECT MIN (p.autoid)
      INTO l_autoid
      FROM productbuydtl p
     WHERE p.id = p_productid
           AND ( (    p.termcd = 'M'
                  AND p."FROM" <= l_months
                  AND p."TO" > =l_months)
                OR (    p.termcd = 'W'
                    AND p."FROM" <= l_weeks
                    AND p."TO" >= l_weeks)
                OR (p.termcd = 'D' AND p."FROM" <= l_days AND p."TO" >= l_days));

   /* SELECT COUNT (1)
      INTO l_count
      FROM productbuydtl p
     WHERE     p.id = p_productid
           AND p.autoid >= l_autoid
           AND p.calrate_method = 'C';

    IF l_count > 0
    THEN
        SELECT autoid
          INTO l_autoidc
          FROM (SELECT *
                  FROM productbuydtl p
                 WHERE     p.id = p_productid
                       AND p.autoid >= l_autoid
                       AND p.calrate_method = 'C'
                ORDER BY autoid ) p
         WHERE ROWNUM <= 1;
    ELSE
        l_autoidc := l_autoid;
    END IF;*/

    SELECT p.TYPE
      INTO l_types
      FROM productbuydtl p
     WHERE autoid = l_autoid;

    SELECT symbol
      INTO l_symbol
      FROM product
     WHERE autoid = p_productid;


        SELECT p.intrate
          INTO l_intrate
          FROM (SELECT *
                  FROM INTSCHD p
                 WHERE     p.symbol = l_symbol

                       AND p.status = 'A'
                       AND p.reportdt >= p_frdate
                ORDER BY reportdt) p
         WHERE ROWNUM <= 1;
    IF l_types = 'F'
     THEN
        SELECT nvl(l_intrate,0) + p.amplitude
          INTO v_result
          FROM productbuydtl p
         WHERE autoid = l_autoid;
    ELSIF l_types = 'V'
        THEN
            SELECT p.rate
              INTO v_result
              FROM productbuydtl p
             WHERE autoid = l_autoid;
      ELSIF l_types = 'C'
        THEN
            SELECT nvl(l_intrate,1) * p.amplitude/100
              INTO v_result
              FROM productbuydtl p
             WHERE autoid = l_autoid;
     ELSIF l_types = 'R'
        THEN
            SELECT nvl(l_intrate,1) * p.amplitude/100
              INTO v_result
              FROM productbuydtl p
             WHERE autoid = l_autoid;
    ELSE

        SELECT nvl(l_intrate,0) + p.amplitude
          INTO v_result
          FROM productbuydtl p
         WHERE autoid = l_autoid;
        /*SELECT CASE
                   WHEN p_types IS NULL OR p_types = ''
                   THEN
                       fn_calc_rate_for_sell (p_productid,
                                              p_frdate,
                                              (SELECT duedate
                                                 FROM assetdtl
                                                WHERE symbol = l_symbol))
                   ELSE
                       NVL (intrate, 0)
               END
          INTO l_intrate
          FROM oxmast
         WHERE orderid = p_types;

        SELECT l_intrate + p.amplitude
          INTO v_result
          FROM productbuydtl p
         WHERE autoid = l_autoidc;*/
    END IF;



    /* SELECT                                                      -- max(p.rate)
           CASE
                WHEN p_types = 'FEE' THEN p.feebuy
                WHEN p."TYPE" = 'FIX' THEN p.rate
                ELSE p.amplitude
            END
       INTO v_result
       FROM productbuydtl p
      WHERE autoid = l_autoidc;
 */
 end if;
 if l_calpvmethod='C' then
   SELECT MIN (p.autoid)
      INTO l_autoid
      FROM productcoupondtl p
     WHERE p.id = p_productid
           AND ( (    p.termcd = 'M'
                  AND p."FROM" <= l_months
                  AND p."TO" > =l_months)
                OR (    p.termcd = 'W'
                    AND p."FROM" <= l_weeks
                    AND p."TO" >= l_weeks)
                OR (p.termcd = 'D' AND p."FROM" <= l_days AND p."TO" >= l_days));

  select p.ratio into v_result from productcoupondtl p where p.autoid= l_autoid;
 end if;
    RETURN NVL (v_result, 0);
EXCEPTION
    WHEN OTHERS
    THEN
        RETURN 0;                                  -- ban dau return -1, nhung
END;
/

DROP FUNCTION fn_calc_rate_by_date
/

CREATE OR REPLACE 
FUNCTION fn_calc_rate_by_date (p_frdate     DATE,
                            p_todate     DATE,
                            p_symbol     VARCHAR2,
                            p_product    VARCHAR2,
                            p_orgprice   NUMBER,
                            p_qtty       NUMBER,
                            p_custodycd     VARCHAR2)
    RETURN NUMBER
AS
    l_autoid         NUMBER;
    l_intbaseddofy   NUMBER;
    l_intrate        NUMBER;
    l_parvalue       NUMBER;
    v_result         NUMBER;
    l_days           NUMBER;
    l_totalday       NUMBER;
    l_rate           NUMBER;
    l_totalamt       NUMBER;
    l_fee            NUMBER;
    l_duedate        DATE;
    l_matdate        DATE;
    l_rptdate        DATE;
    l_feebuy         NUMBER;
    l_symbol         VARCHAR2 (200);
    l_pricebuy       NUMBER;
    l_pricesell      NUMBER;
    pkgctx           plog.log_ctx;
    logrow           tlogdebug%ROWTYPE;
BEGIN
    l_symbol := p_symbol;
    v_result := 0;
    l_days := 0;
    l_totalday := 0;
    l_rate := 0;

    SELECT intrate,
           parvalue,
           CASE WHEN intbaseddofy = 'N' THEN 360 ELSE 365 END intbaseddofy,
           duedate
      INTO l_intrate,
           l_parvalue,
           l_intbaseddofy,
           l_duedate
      FROM assetdtl
     WHERE symbol = l_symbol;

    l_matdate := p_todate;


    l_pricebuy:= p_orgprice ;

    SELECT fn_calc_price_for_payment (p_frdate,
                                      l_matdate,
                                      l_symbol,
                                      p_qtty,
                                      l_pricebuy,
                                      p_product,
                                      p_custodycd)
      INTO l_pricesell
      FROM DUAL;

    IF l_pricesell = 0
    THEN
        l_pricesell := l_parvalue;
    END IF;

    l_totalamt := l_pricesell;

    select fn_calc_feebuy(p_product ,p_frdate   , l_matdate , l_pricesell * p_qtty) into l_feebuy from dual ;
    SELECT fn_calc_fee_fortype (p_date        => l_matdate,
                                p_exectype    => 'CC',
                                p_symbol      => l_symbol,
                                p_custodycd   => p_custodycd,
                                p_product     => '',
                                p_combo       => '',
                                p_amt         => l_pricesell * p_qtty,
                                p_amtp        => l_pricesell * p_qtty) + l_feebuy
        + fn_calc_fee (l_matdate,
                         '002',
                         '',
                         l_symbol,
                         p_custodycd,
                         '',
                         '',
                         l_pricesell * p_qtty,
                         l_pricesell * p_qtty)
      INTO l_feebuy
      FROM DUAL;


    SELECT fn_calc_amt (p_frdate,
                        l_matdate,
                        l_symbol,
                        '',
                        l_parvalue,
                        p_custodycd) - l_parvalue
      INTO l_totalamt
      FROM DUAL;

    SELECT l_matdate - p_frdate INTO l_totalday FROM DUAL;
  --  v_result := l_feebuy ;
    v_result :=
          (l_pricesell *p_qtty +  l_totalamt *  p_qtty  - p_qtty *  p_orgprice   - l_feebuy)
        / (l_pricebuy *  p_qtty )
        * l_intbaseddofy
        * 100
        / l_totalday;
    RETURN NVL (v_result, 0);
EXCEPTION
    WHEN OTHERS
    THEN
        RETURN 0;                                  -- ban dau return -1, nhung
END;
/

DROP FUNCTION fn_calc_rate_by_dt
/

CREATE OR REPLACE 
FUNCTION fn_calc_rate_by_dt (p_frdate     DATE,
                            p_orgdate     DATE,
                            p_todate     DATE,
                            p_symbol     VARCHAR2,
                            p_product    VARCHAR2,
                            p_orgprice   NUMBER,
                            p_qtty       NUMBER,
                            p_price       NUMBER,
                            p_custodycd     VARCHAR2)
    RETURN NUMBER
AS
    l_autoid         NUMBER;
    l_intbaseddofy   NUMBER;
    l_intrate        NUMBER;
    l_parvalue       NUMBER;
    v_result         NUMBER;
    l_days           NUMBER;
    l_totalday       NUMBER;
    l_rate           NUMBER;
    l_totalamt       NUMBER;
    l_fee            NUMBER;
    l_duedate        DATE;
    l_matdate        DATE;
    l_rptdate        DATE;
    l_feebuy         NUMBER;
    l_symbol         VARCHAR2 (200);
    l_pricebuy       NUMBER;
    l_pricesell      NUMBER;
    pkgctx           plog.log_ctx;
    logrow           tlogdebug%ROWTYPE;
BEGIN
    l_symbol := p_symbol;
    v_result := 0;
    l_days := 0;
    l_totalday := 0;
    l_rate := 0;

    SELECT intrate,
           parvalue,
           CASE WHEN intbaseddofy = 'N' THEN 360 ELSE 365 END intbaseddofy,
           duedate
      INTO l_intrate,
           l_parvalue,
           l_intbaseddofy,
           l_duedate
      FROM assetdtl
     WHERE symbol = l_symbol;

    l_matdate := p_todate;


    l_pricebuy:= p_orgprice ;

    SELECT fn_calc_price_for_payment (p_orgdate,
                                      l_matdate,
                                      l_symbol,
                                      p_qtty,
                                      l_pricebuy,
                                      p_product,
                                      p_custodycd)
      INTO l_pricesell
      FROM DUAL;

    IF l_pricesell = 0
    THEN
        l_pricesell := l_parvalue;
    END IF;

    l_totalamt := l_pricesell;

    select fn_calc_feebuy(p_product ,p_orgdate   , l_matdate , l_pricesell * p_qtty) into l_feebuy from dual ;
    SELECT fn_calc_fee_fortype (p_date        => l_matdate,
                                p_exectype    => 'CC',
                                p_symbol      => l_symbol,
                                p_custodycd   => p_custodycd,
                                p_product     => '',
                                p_combo       => '',
                                p_amt         => l_pricesell * p_qtty,
                                p_amtp        => l_pricesell * p_qtty) + l_feebuy
        + fn_calc_fee (l_matdate,
                         '002',
                         '',
                         l_symbol,
                         p_custodycd,
                         '',
                         '',
                         l_pricesell * p_qtty,
                         l_pricesell * p_qtty)
      INTO l_feebuy
      FROM DUAL;


    SELECT fn_calc_amt (p_frdate,
                        l_matdate,
                        l_symbol,
                        '',
                        l_parvalue,
                        p_custodycd) - l_parvalue
      INTO l_totalamt
      FROM DUAL;

    SELECT l_matdate - p_frdate INTO l_totalday FROM DUAL;
  --  v_result := l_feebuy ;
    v_result :=
          (l_pricesell *p_qtty +  l_totalamt *  p_qtty  - p_qtty *  p_price   - l_feebuy)
        / (p_price *  p_qtty )
        * l_intbaseddofy
        * 100
        / l_totalday;
    RETURN NVL (v_result, 0);
EXCEPTION
    WHEN OTHERS
    THEN
        RETURN 0;                                  -- ban dau return -1, nhung
END;
/

DROP FUNCTION fn_calc_rate_in
/

CREATE OR REPLACE 
FUNCTION fn_calc_rate_in (p_frdate     DATE,
                            p_todate     DATE,
                            p_symbol     VARCHAR2,
                            p_product    VARCHAR2,
                            p_amt        NUMBER,
                            p_qtty       NUMBER,
                            p_custodycd     VARCHAR2)
    RETURN NUMBER
AS
    l_autoid         NUMBER;
    l_intbaseddofy   NUMBER;
    l_intrate        NUMBER;
    l_parvalue       NUMBER;
    v_result         NUMBER;
    l_days           NUMBER;
    l_totalday       NUMBER;
    l_rate           NUMBER;
    l_totalamt       NUMBER;
    l_fee            NUMBER;
    l_duedate        DATE;
    l_matdate        DATE;
    l_rptdate        DATE;
    l_feebuy         NUMBER;
    l_symbol         VARCHAR2 (200);
    l_pricebuy       NUMBER;
    l_pricesell      NUMBER;
    pkgctx           plog.log_ctx;
    logrow           tlogdebug%ROWTYPE;
BEGIN
    l_symbol := p_symbol;
    v_result := 0;
    l_days := 0;
    l_totalday := 0;
    l_rate := 0;

    SELECT intrate,
           parvalue,
           CASE WHEN intbaseddofy = 'N' THEN 360 ELSE 365 END intbaseddofy,
           duedate
      INTO l_intrate,
           l_parvalue,
           l_intbaseddofy,
           l_duedate
      FROM assetdtl
     WHERE symbol = l_symbol;

    l_matdate := get_nextday_work (p_todate, 0);


    SELECT fn_calc_price_for_sell (
               p_product,
               getcurrdate (),
               l_symbol,
               (CASE
                    WHEN p_product IS NOT NULL AND p_product <> 0 THEN 'T'
                    ELSE 'I'
                END),
                '',
               p_custodycd)
      INTO l_pricebuy
      FROM DUAL;

    SELECT fn_calc_price_for_payment (getcurrdate (),
                                      l_matdate,
                                      l_symbol,
                                      p_qtty,
                                      l_pricebuy,
                                      p_product,
                                      '')
      INTO l_pricesell
      FROM DUAL;

    IF l_pricesell = 0
    THEN
        l_pricesell := l_parvalue;
    END IF;

    l_totalamt := l_pricesell;

    SELECT fn_calc_fee_fortype (p_date        => getcurrdate (),
                                p_exectype    => 'CB',
                                p_symbol      => l_symbol,
                                p_custodycd   => '',
                                p_product     => '',
                                p_combo       => '',
                                p_amt         => l_pricebuy,
                                p_amtp        => l_parvalue)
      INTO l_feebuy
      FROM DUAL;

    /* FOR r
         IN (SELECT *
               FROM payment_hist
              WHERE     symbol = l_symbol
                    AND paytype = 'INT'                      --and status = 'P'
                    AND valuedt >= p_frdate
                    AND reportdt >= p_frdate
                    AND valuedt <=
                            NVL (l_matdate,
                                 TO_DATE ('31/12/2099', 'DD/MM/YYYY')))
     LOOP
         l_autoid := r.autoid;
         l_intrate := r.intrate;
         l_rptdate := r.valuedt;

         SELECT valuedt - prevdate days
           INTO l_days
           FROM (SELECT a.valuedt,
                        a.amount,
                        MAX (NVL (b.valuedt, a.orgvaluedt)) prevdate
                   FROM     (SELECT a.valuedt,
                                    a.amount,
                                    b.opndate - 1 orgvaluedt
                               FROM payment_hist a, assetdtl b
                              WHERE     a.symbol = l_symbol
                                    --AND a.STATUS='P'
                                    AND a.paytype = 'INT'
                                    AND a.symbol = b.symbol
                                    AND b.symbol = l_symbol
                                    AND a.autoid = l_autoid) a
                        LEFT JOIN
                            (SELECT valuedt
                               FROM payment_hist
                              WHERE symbol = l_symbol AND paytype = 'INT') b
                        ON b.valuedt < a.valuedt
                 GROUP BY a.valuedt, a.amount) a;

         -- l_totalday := l_days + l_totalday ;
         l_rate :=
             ROUND (l_intrate * l_days * l_parvalue / l_intbaseddofy / 100);

         SELECT fn_calc_fee (l_rptdate,
                             '001',
                             '',
                             l_symbol,
                             '',
                             '',
                             '',
                             l_rate,
                             l_rate)
           INTO l_fee
           FROM DUAL;

         l_totalamt := l_totalamt + l_rate - l_fee;
     --  l_totalamt :=  l_rate    + l_totalamt  -  l_fee  ;
     END LOOP; */
    SELECT fn_calc_amt (p_frdate,
                        l_matdate,
                        l_symbol,
                        '',
                        l_pricebuy,
                        p_custodycd)
      INTO l_totalamt
      FROM DUAL;

    SELECT l_matdate - p_frdate INTO l_totalday FROM DUAL;

    v_result :=
          (l_totalamt - l_pricebuy - l_feebuy)
        / (l_pricebuy + l_feebuy)
        * l_intbaseddofy
        * 100
        / l_totalday;
    RETURN NVL (v_result, 0);
EXCEPTION
    WHEN OTHERS
    THEN
        RETURN 0;                                  -- ban dau return -1, nhung
END;
/

DROP FUNCTION fn_calc_received_coupon_frdate
/

CREATE OR REPLACE 
FUNCTION fn_calc_received_coupon_frdate (p_symbol varchar2, p_orgdate date, p_date date)
 RETURN number
 
as  
    l_return number := 0;
    l_frdate date;
    l_todate date;
    
begin
    
    
    select min(valuedt) into l_frdate
    from payment_hist ph 
    where valuedt >= p_orgdate
        and symbol = p_symbol
        and paytype = 'INT';
    
    select max(valuedt) into l_todate
    from payment_hist ph 
    where valuedt < p_date
        and symbol = p_symbol
        and paytype = 'INT';
    
    if l_frdate > l_todate or l_todate is null then
        l_return := 0;
    else
        select sum(amount) into l_return
        from payment_hist ph 
        where symbol = p_symbol
        and paytype = 'INT'
        and valuedt >= l_frdate
        and valuedt <= l_todate;
    
    end if;
    
    return round(l_return,0);
exception
    when others then
        return 0;
   
END;
/

DROP FUNCTION fn_calc_remain_cbond_qtty
/

CREATE OR REPLACE 
FUNCTION fn_calc_remain_cbond_qtty (p_confirmno varchar2)
RETURN number

as
    l_count number;
    l_sumqtty number;
    l_sumexecqtty number;
    v_result number;
    l_txdatetime varchar2(100);
    l_orgconfirmno varchar2(100);
    l_execqtty number;
begin
        select count(*) into l_count from sereqclose s
        left join oxmast o on o.confirmno = s.orgconfirmno
        where s.confirmno = p_confirmno;
        if l_count >0 then
            select to_char(s.txdate,'yyyy-mm-dd')||nvl(s.txtime,'00:00:00'),s.orgconfirmno, o.execqtty into l_txdatetime, l_orgconfirmno, l_execqtty from sereqclose s
            left join oxmast o on o.confirmno = s.orgconfirmno
            where s.confirmno = p_confirmno;
        end if;

        select count(*) into l_count from sereqclose s where s.status <>'R' and  TO_DATE(to_char(s.txdate,'yyyy-mm-dd')||nvl(s.txtime,'00:00:00'),'yyyy-mm-dd hh24:mi:ss') < TO_DATE(l_txdatetime,'yyyy-mm-dd hh24:mi:ss') and orgconfirmno = l_orgconfirmno ;
        if l_count > 0 then
            select sum(quantity) into l_sumqtty from sereqclose s where s.status <>'R' and  TO_DATE(to_char(s.txdate,'yyyy-mm-dd')||nvl(s.txtime,'00:00:00'),'yyyy-mm-dd hh24:mi:ss') < TO_DATE(l_txdatetime,'yyyy-mm-dd hh24:mi:ss') and orgconfirmno = l_orgconfirmno group by s.orgconfirmno;
         end if;

        select count(*) into l_count
             from oxmast o
                  where o.status <>'R'
                  and o.buyconfirmno = l_orgconfirmno
                  and  TO_DATE(to_char(o.txdate,'yyyy-mm-dd')||nvl(o.txtime,'00:00:00'),'yyyy-mm-dd hh24:mi:ss') < TO_DATE(l_txdatetime,'yyyy-mm-dd hh24:mi:ss')
                 ;
          if l_count >0 then
               select sum(o.execqtty) into l_sumexecqtty
                  from oxmast o
                  where o.status <>'R'
                  and o.buyconfirmno = l_orgconfirmno
                  and  TO_DATE(to_char(o.txdate,'yyyy-mm-dd')||nvl(o.txtime,'00:00:00'),'yyyy-mm-dd hh24:mi:ss') < TO_DATE(l_txdatetime,'yyyy-mm-dd hh24:mi:ss')
                  group by o.buyconfirmno;
          end if;
        v_result:= nvl(l_execqtty,0)-nvl(l_sumqtty,0)-nvl(l_sumexecqtty,0);
        RETURN nvl(v_result,0);
exception
    when others then
        return -2;

END;
/

DROP FUNCTION fn_calc_sellprice
/

CREATE OR REPLACE 
FUNCTION fn_calc_sellprice(p_orgdeal in varchar2, p_acctno in varchar2, p_orgdate date, p_orgprice in number, p_sellrate  in number, p_qtty in number, p_symbol in varchar2, p_category in varchar2, p_productid in varchar2, p_custodycd in varchar2)
 RETURN number

AS

    l_return  number := 0;
    l_duedate date;
    l_days number;
    l_currdate date;

    l_receivedamt number;
    l_intamtnumber number;
    l_accrbasis  number;
    l_parvalue number;
    l_pricesell number;
    l_couponamt number;
    l_orgdate date;
    l_shortname varchar2(100);
    l_taxtransfer number;
    l_feeseller number;
    l_count number;
     l_rate number;
    l_orgprice number;
    l_daysng number;
begin
--  delete from van_test vt ;
--  insert into van_test (autoid, objname , value)
--  values(nextval('seq_van_test'),'calc invest rate', '');
if p_orgdeal is not null then
    select o.txdate, o.price  into l_orgdate , l_orgprice from oxmast o where o.orderid= p_orgdeal;
else
    l_orgdate:=getcurrdate();
    l_orgprice:= p_orgprice;
end if;
    select case when a.intbaseddofy = 'A' then 365 else 360 end, a.parvalue
        into l_accrbasis, l_parvalue
    from assetdtl a
    where symbol = p_symbol;

    if l_accrbasis is null then
        l_accrbasis := 365;
    end if;

    l_currdate := getcurrdate();
    -- Tinh thoi gian dau tu
    if p_category = 'C' then
        select max(case when nvl(b.termval ,0) = 0 then a.duedate
                        else ADD_MONTHS(p_orgdate, b.termval)
                    end)
                into l_duedate
        from comboproduct c2
            inner join productier p
                on c2.id = p.id
            inner join  assetdtl a
                on p.symbol = a.symbol
            left join product b
                on b.shortname = p.productid
                    and (b.status = 'A' or b.pstatus like '%A%')
                    and b.effdate <= p_orgdate
                    and b.expdate > p_orgdate
        where c2.id = p_productid;
    elsif p_category = 'T' then
        select case when nvl(p2.termval ,0) = 0 then a.duedate
                    else
                                    CASE
                                        WHEN p2.termcd = 'M'
                                        THEN
                                            ADD_MONTHS (p_orgdate,
                                                        p2.termval)
                                        WHEN p2.termcd = 'W'
                                        THEN
                                            p_orgdate + p2.termval * 7
                                        ELSE
                                            p_orgdate + p2.termval
                                    END

                end
                into l_duedate
        from product p2
            inner join assetdtl a
                on p2.symbol = a.symbol
        where p2.autoid = p_productid;
    else
        select duedate
            into l_duedate
        from assetdtl a2
        where a2.symbol = p_symbol;
    end if;

    l_days := l_duedate - l_currdate;
 l_daysng:= l_duedate- l_orgdate;
select count(*) into l_count from product where autoid = p_productid;
if l_count > 0 then
    select shortname into l_shortname from product where autoid = p_productid;
else l_shortname:=null;
end if;
    --SELECT fn_calc_price_for_buy(TO_DATE(l_orgdate,'dd/mm/yyyy'),p_orgdeal) into l_pricesell FROM dual;
   if p_productid <>'0' and p_productid is not null then
   SELECT  fn_calc_rate_for_buy (p_productid    ,
                                    l_orgdate,
                                  l_duedate,
                                 p_category ) into l_rate from dual;
    l_receivedamt := round( l_orgprice * (1+ l_rate/100*l_daysng/l_accrbasis),0);
      l_return := round(l_receivedamt  / (1+  (p_sellrate/100/l_accrbasis) * l_days),2);
 else
    select fn_calc_amt(
                    P_DATE=>l_orgdate,
                    P_TODATE=>l_duedate,
                    P_SYMBOL=>p_symbol,
                    P_PRODUCT=>p_productid,
                    P_AMT=>l_parvalue,
                    P_CUSTODYCD=>p_custodycd)- l_parvalue into l_couponamt from dual;
     l_receivedamt := l_parvalue + l_couponamt;
      l_return := round(l_receivedamt  / (1+  (p_sellrate/100/l_accrbasis) * l_days),2);
 end if;
   /* select  fn_calc_fee_fortype
                    (p_date => getcurrdate(),
                     p_exectype=> 'CS',
                     p_symbol=>p_symbol,
                     p_custodycd=>p_custodycd,
                     p_product=>'',
                     p_combo=>'',
                     p_amt=>l_pricesell * p_qtty,
                     p_amtp=>l_parvalue* p_qtty ) into l_taxtransfer from dual;
       select fn_calc_fee
                (p_txdate=>getcurrdate(),
                 p_feetype=>'002',
                 p_exectype=>'',
                 p_symbol=>p_symbol,
                 p_custodycd=>p_custodycd,
                 p_product=>l_shortname,
                 p_combo=>'',
                 p_amt=>l_pricesell * p_qtty,
                 p_amtp=>l_parvalue*p_qtty
                 ) into l_feeseller from dual;
      /* select      fn_calc_price_for_sell(
            P_PRODUCTID=>p_productid,
            P_FRDATE=>getcurrdate,
            P_SYMBOL=>p_symbol,
            P_CATEGORY=>p_category,
            P_CUSTODYCDSELL => '',
            P_CUSTODYCD=>p_custodycd
            ) into l_pricesell from dual;*/
     /*  select fn_calc_amt(
                    P_DATE=>l_orgdate,
                    P_TODATE=>l_duedate,
                    P_SYMBOL=>p_symbol,
                    P_PRODUCT=>p_productid,
                    P_AMT=>l_parvalue,
                    P_CUSTODYCD=>p_custodycd)- l_parvalue into l_couponamt from dual;*/
--  insert into van_test (autoid, objname , value)
--  values(nextval('seq_van_test'),'l_receivedamt', l_receivedamt);

    -- L?i ð?u tý
   --l_receivedamt:= round((l_pricesell * p_qtty + l_couponamt*p_qtty)/p_qtty,0);

     --l_receivedamt:= (l_pricesell*p_qtty- l_feeseller-l_taxtransfer + l_couponamt*p_qtty)/p_qtty;


--  insert into van_test (autoid, objname , value)
--  values(nextval('seq_van_test'),'l_receivedamt', l_receivedamt);



    --Giá ð?u tý = ti?n nh?n * CSTL / (CSTL + L?i su?t * S? ngày) / Kh?i lý?ng ð?u tý



    return round(l_return,0);
exception
    when others then
        return -1;

END FN_CALC_SELLPRICE;
/

DROP FUNCTION fn_calc_sum_payment
/

CREATE OR REPLACE 
FUNCTION fn_calc_sum_payment(p_symbol in varchar2, p_productid in varchar2, p_orgdate in varchar2, p_orgprice in varchar2, p_duedate in varchar2, p_custodycd in varchar2, p_qtty in varchar2, p_sbdefacctno in varchar2)
 RETURN number

AS
/**----------------------------------------------------------------------------------------------------
 ** FUNCTION: PRC_GET_payment_detail_hist
 ** and is copyrighted by FSS.
 **
 **    All rights reserved.  No part of this work may be reproduced, stored in a retrieval system,
 **    adopted or transmitted in any form or by any means, electronic, mechanical, photographic,
 **    graphic, optic recording or otherwise, translated in any language or computer language,
 **    without the prior written permission of Financial Software Solutions. JSC.
 **
 **  MODIFICATION HISTORY
 **  Person      Date           Comments
 **  SYSTEM      19/12/2019     Created
 **
 ** (c) 2019 by Financial Software Solutions. JSC.
 ** ----------------------------------------------------------------------------------------------------*/



 l_language      varchar2(20);
    l_err_code      number;
    v_logsctx       varchar2(4000);
    v_logsbody     varchar2(4000);
    v_exception    varchar2(4000);

    l_intpaidfrq    varchar(10);
    l_periods       number;
    l_intdate       date;
    l_intratebaseddt date;
    l_autoid        number;
    l_duedate       date;
    l_intrate       number;
    l_symbol        varchar(100);
    l_parvalue number;
    l_days     number;
    l_intbaseddofy  number;
    l_intpaidday    number;
    l_intcalmethod  varchar(10);
    l_count         number;
    l_product       number;
    l_rate          number;
    l_prate         number;
    l_pdate         date;
    l_orgvaluedt    date;
    l_rptdate       date;
    l_prevdate      date;
    l_reinvest_rate number;
    l_matdate       date;
    l_reinvestdays  number;

    l_productcode   varchar(50);
    l_combocode     varchar(50);
    l_qtty          number;
    l_orgprice      number;

  /*  r               record;
    combo           record;*/
    l_return number;
begin
    --delete from van_test vt ;
--  insert into van_test(autoid, objname , value )
--  values(nextval('seq_van_test'),'cal sum payment','');

    l_return := 0;


    --l_qtty := p_qtty;
    --combo sp
    if p_symbol = '' and nvl(p_productid, '') <> '' then

        for combo in (select c.id comboid, c.symbol, nvl(p.autoid, 0) productid, cb.productid combocode, p.shortname productcode, c.discount,
                            case when nvl(p.termval,0) = 0 then a2.duedate
                                else least(a2.duedate , ADD_MONTHS(to_date(p_orgdate,'dd/mm/yyyy') , p.termval))
                            end duedate
                    from comboproduct cb
                         inner join productier c on cb.id = c.id
                         left join product p on c.productid = p.shortname and p.symbol = c.symbol
                         inner join assetdtl a2 on c.symbol = a2.symbol
                    where c.id = p_productid)
        loop
            l_productcode := combo.productcode;
            l_combocode := combo.combocode;
            l_orgvaluedt := to_date(p_orgdate, 'DD/MM/YYYY');
            l_qtty := p_qtty * combo.discount;


            l_symbol := combo.symbol;

            l_product := combo.productid;

            l_orgprice := fn_calc_dealer_price(p_sbdefacctno,case when l_product = 0 then 'O' else 'T' end,l_symbol,l_product,'',p_custodycd,getcurrdate());


            select to_date(p_duedate, 'DD/MM/YYYY')
            into l_matdate from dual;


            l_matdate := least(l_matdate, combo.duedate);

            select intrate, parvalue, case when intbaseddofy = 'N' then 360 else 365 end intbaseddofy, intcalmethod
            into l_intrate, l_parvalue, l_intbaseddofy, l_intcalmethod
            from assetdtl
            where symbol = l_symbol;

            for r in (
                        select *
                        from payment_hist
                        where symbol = l_symbol
                        and paytype = 'INT'
                        --and status = 'P'
                        and valuedt >= getcurrdate()
                        and valuedt < nvl(l_matdate, to_date('31/12/2099', 'DD/MM/YYYY'))
                      )
            loop
                    l_intrate := r.intrate;
                    l_rptdate := r.valuedt;
                    l_autoid := r.autoid;

--                  l_reinvestdays := l_matdate - l_rptdate;
--
--                  select rr.rate into l_reinvest_rate
--                  from vw_reinvest_rate rr
--                  where rr.effdate <= l_rptdate
--                  and rr.expdate > l_rptdate
--                  and l_rptdate + interval '1 month' * rr.min_month <= l_matdate
--                  and l_rptdate + interval '1 month' * rr.max_month > l_matdate;


                    if l_intcalmethod in ('D', 'R') then
                        --if l_product = 0 then
                            select valuedt - prevdate days
                            into l_days
                            from
                            (select a.valuedt, a.amount, max(nvl(b.valuedt, a.orgvaluedt)) prevdate
                                    from
                                    (select a.valuedt, a.amount,
                                            b.opndate - 1 orgvaluedt
                                            from payment_hist a, assetdtl b
                                            WHERE a.symbol = l_symbol
                                                --AND a.STATUS='P'
                                                and a.paytype = 'INT'
                                                and a.symbol = b.symbol and b.symbol = l_symbol
                                                and a.autoid = l_autoid
                                                ) a
                                     left join (select valuedt
                                                from payment_hist
                                                WHERE symbol = l_symbol and paytype = 'INT') b
                                     on b.valuedt < a.valuedt
                                     group by a.valuedt, a.amount) a;

--                          insert into van_test(autoid, objname , value )
--                          values(nextval('seq_van_test'),'int amount',l_qtty * round(l_intrate * l_parvalue/100*l_days/l_intbaseddofy, 0));
--
--                          insert into van_test(autoid, objname , value )
--                          values(nextval('seq_van_test'),'int tax',fn_calc_fee(l_rptdate,'010','NS',l_symbol,p_custodycd,l_productcode,l_combocode,l_qtty * round(l_intrate * l_parvalue/100*l_days/l_intbaseddofy, 0)));

                            l_return := l_return + l_qtty * round(l_intrate * l_parvalue/100*l_days/l_intbaseddofy, 0)
                                        - fn_calc_fee(l_rptdate,'010','NS',l_symbol,p_custodycd,l_productcode,l_combocode,l_qtty * round(l_intrate * l_parvalue/100*l_days/l_intbaseddofy, 0));


                    end if;

              end loop;

--          insert into van_test(autoid, objname , value )
--                          values(nextval('seq_van_test'),'pri amount',l_qtty * fn_calc_closeprice('', l_symbol, l_product,p_custodycd, l_orgprice, l_orgvaluedt, l_matdate));
--
--
--          insert into van_test(autoid, objname , value )
--                          values(nextval('seq_van_test'),'pri tax',fn_calc_fee(l_matdate,'007','NR',l_symbol,p_custodycd,l_productcode,l_combocode,l_qtty * fn_calc_closeprice('', l_symbol, l_product,p_custodycd, l_orgprice, l_orgvaluedt, l_matdate)));
--
--          insert into van_test(autoid, objname , value )
--                          values(nextval('seq_van_test'),'pri amount',fn_calc_fee(l_matdate,'011','NR',l_symbol,p_custodycd,l_productcode,l_combocode,l_qtty * fn_calc_closeprice('', l_symbol, l_product,p_custodycd, l_orgprice, l_orgvaluedt, l_matdate)));

            l_return := l_return + l_qtty * fn_calc_closeprice('', l_symbol, l_product,p_custodycd, l_orgprice, l_orgvaluedt, l_matdate)
                        - case when l_product = 0 then 0
                                else fn_calc_fee(l_matdate,'007','NR',l_symbol,p_custodycd,l_productcode,l_combocode,l_qtty * fn_calc_closeprice('', l_symbol, l_product,p_custodycd, l_orgprice, l_orgvaluedt, l_matdate))
                            end
                        - case when l_product = 0 then 0
                                else fn_calc_fee(l_matdate,'011','NR',l_symbol,p_custodycd,l_productcode,l_combocode,l_qtty * fn_calc_closeprice('', l_symbol, l_product,p_custodycd, l_orgprice, l_orgvaluedt, l_matdate))
                            end;

        end loop;

    else
        l_orgvaluedt := to_date(p_orgdate, 'DD/MM/YYYY');

        l_symbol := p_symbol;

        l_product := p_productid;

        l_qtty := p_qtty;

        select shortname
        into l_productcode
        from product
        where autoid = l_product;


        select to_date(p_duedate, 'DD/MM/YYYY')
        into l_matdate from dual;


        select intrate, parvalue, case when intbaseddofy = 'N' then 360 else 365 end intbaseddofy, intcalmethod, duedate
        into l_intrate, l_parvalue, l_intbaseddofy, l_intcalmethod, l_duedate
        from assetdtl
        where symbol = l_symbol;

        if p_productid <> '0' then
            select case when p.termval = 0 then a.duedate
                        else least(a.duedate, ADD_MONTHS(to_date(p_orgdate,'dd/mm/yyyy') , p.termval ))
                    end into l_duedate
            from product p,
                assetdtl a
            where p.symbol = a.symbol
                and p.autoid = l_product;
        end if;

        l_matdate := least(l_matdate,l_duedate);

        for r in (
                    select *
                    from payment_hist
                    where symbol = l_symbol
                    and paytype = 'INT'
                    --and status = 'P'
                    and valuedt >= getcurrdate()
                    and valuedt < nvl(l_matdate, to_date('31/12/2099', 'DD/MM/YYYY'))
                  )
        loop

            l_intrate := r.intrate;
            l_rptdate := r.valuedt;
            l_autoid := r.autoid;

--          l_reinvestdays := l_matdate - l_rptdate;
--
--          select rr.rate into l_reinvest_rate
--          from vw_reinvest_rate rr
--          where rr.effdate <= l_rptdate
--          and rr.expdate > l_rptdate
--          and l_rptdate + interval '1 month' * rr.min_month <= l_matdate
--          and l_rptdate + interval '1 month' * rr.max_month > l_matdate;


            if l_intcalmethod in ('D', 'R') then
                    select valuedt - prevdate days
                    into l_days
                    from
                    (select a.valuedt, a.amount, max(nvl(b.valuedt, a.orgvaluedt)) prevdate
                            from
                            (select a.valuedt, a.amount,
                                    b.opndate - 1 orgvaluedt
                                    from payment_hist a, assetdtl b
                                    WHERE a.symbol = l_symbol
                                        --AND a.STATUS='P'
                                        and a.paytype = 'INT'
                                        and a.symbol = b.symbol and b.symbol = l_symbol
                                        and a.autoid = l_autoid
                                        ) a
                             left join (select valuedt
                                        from payment_hist
                                        WHERE symbol = l_symbol and paytype = 'INT') b
                             on b.valuedt < a.valuedt
                             group by a.valuedt, a.amount) a;


                l_return := l_return + l_qtty * round(l_intrate * l_parvalue/100*l_days/l_intbaseddofy, 0)
                            - fn_calc_fee(l_rptdate,'010','NS',l_symbol,p_custodycd,l_productcode,l_combocode,l_qtty * round(l_intrate * l_parvalue/100*l_days/l_intbaseddofy, 0));


            end if;

        end loop;



        l_return := l_return + l_qtty * fn_calc_closeprice('', l_symbol, l_product,p_custodycd, p_orgprice, l_orgvaluedt, l_matdate)
                    - case when l_product = 0 then 0
                            else fn_calc_fee(l_matdate,'007','NR',l_symbol,p_custodycd,l_productcode,l_combocode,l_qtty * fn_calc_closeprice('', l_symbol, l_product,p_custodycd, p_orgprice, l_orgvaluedt, l_matdate))
                        end
                    - case when l_product = 0 then 0
                            else fn_calc_fee(l_matdate,'011','NR',l_symbol,p_custodycd,l_productcode,l_combocode,l_qtty * fn_calc_closeprice('', l_symbol, l_product,p_custodycd, p_orgprice, l_orgvaluedt, l_matdate))
                        end;


    end if;



    RETURN l_return;

Exception
    when others then

        RETURN -1;
End fn_calc_sum_payment
;
/

DROP FUNCTION fn_calc_trade_semast
/

CREATE OR REPLACE 
FUNCTION fn_calc_trade_semast (p_acctno in varchar2, p_symbol in varchar2) RETURN number AS
l_result number;
l_count number;
BEGIN
select count(*) into l_count  from semast se
            where se.afacctno = p_acctno
            and se.symbol = p_symbol;
            if l_count > 0 then
                  select se.trade - se.secured into l_result from semast se
                            where se.afacctno = p_acctno
                            and se.symbol = p_symbol;
                            RETURN l_result;
            else return null;
            end if;
END FN_CALC_TRADE_SEMAST;
/

DROP FUNCTION fn_check_datetime
/

CREATE OR REPLACE 
FUNCTION fn_check_datetime (pv_fromtime IN VARCHAR2, pv_totime IN varchar2)
  RETURN VARCHAR2 IS
  v_Result number(10,4);
  v_fromhour VARCHAR2(2);
  v_tohour VARCHAR2(2);
  v_frommin VARCHAR2(2);
  v_tomin VARCHAR2(2);
  v_fromtime VARCHAR2(4);
  v_totime VARCHAR2(4);
BEGIN
    v_Result := 0;
    v_fromtime := rpad(replace(pv_fromtime,' ','0'),4,'0');
    v_fromhour := substr(v_fromtime,0,2);
    v_frommin := substr(v_fromtime,3,2);
    v_totime := rpad(replace(pv_totime,' ','0'),4,'0');
    v_tohour := substr(v_totime,0,2);
    v_tomin := substr(v_totime,3,2);
    
    begin
       IF  v_fromhour > v_tohour OR v_fromhour > 24 OR v_fromhour < 0 
         OR v_tohour > 24 OR v_tohour< 0
         OR v_frommin >60 OR v_frommin<0 
         OR v_tomin > 60 OR v_frommin < 0 THEN
            v_result := 0;
        ELSE 
          v_result := 1;
        END IF;
    EXCEPTION when OTHERS THEN
        v_Result := 0;
    end;
    RETURN v_Result;
EXCEPTION
   WHEN OTHERS THEN
    RETURN 0;
END;
/

DROP FUNCTION fn_check_isprofession
/

CREATE OR REPLACE 
FUNCTION fn_check_isprofession (p_custodycd in varchar2) RETURN VARCHAR2 AS
l_isprofession    varchar2(50);
l_count     number;
BEGIN
  select count(*) into l_count
            from cfmast cf
            where cf.custodycd = p_custodycd;
  if (l_count > 0) then
 SELECT
        case when cf.isprofession ='Y' and (cf.isexists ='Y' or (cf.isexists ='N' and cs.cfurlfile is not null)) then 'Y' else 'N' end into l_isprofession
        FROM cfmast cf
        left join cfsign cs on cf.custodycd = cs.custodycd and cs.status = 'A' and cs."TYPE"= 'DCT'
         where  cf.custodycd = p_custodycd;
 else l_isprofession := 'N';
 end if;
   RETURN l_isprofession;
END FN_CHECK_ISPROFESSION;
/

DROP FUNCTION fn_check_otp
/

CREATE OR REPLACE 
FUNCTION fn_check_otp (p_otpkey VARCHAR2, p_otp VARCHAR2)
    RETURN NUMBER
AS
    l_count      NUMBER;
    l_otplimit   NUMBER;

    l_return     NUMBER;
BEGIN
    -- Kiem tra OTP
    SELECT TO_NUMBER (varvalue)
      INTO l_otplimit
      FROM sysvar
     WHERE varname = 'OTPLIMIT';

    SELECT COUNT (1)
      INTO l_count
      FROM otp_logs a
     WHERE a.code in ('OPENCF','EDITCF')
            AND a.refid = p_otpkey AND status = 'N';

    IF l_count = 0
    THEN
        l_return := errnums_trans.C_SY_VERIFIED_OTP;
        RETURN l_return;
    END IF;

    SELECT COUNT (1)
      INTO l_count
      FROM otp_logs a
     WHERE    a.code in ('OPENCF','EDITCF')
           AND a.refid = p_otpkey
           AND status = 'N'
           AND a.retry_count >= l_otplimit;

    IF l_count > 0
    THEN
        l_return := errnums_trans.C_SY_OVERLIMIT_OTP;
        RETURN l_return;
    END IF;

    SELECT COUNT (1)
      INTO l_count
      FROM otp_logs a
     WHERE    a.code in ('OPENCF','EDITCF')
            AND a.refid = p_otpkey
           AND status = 'N'
           AND a.exprieddt < SYSDATE;

    IF l_count > 0
    THEN
        l_return := errnums_trans.C_SY_EXPIRED_OTP;
        RETURN l_return;
    END IF;

    SELECT COUNT (1)
      INTO l_count
      FROM otp_logs a
     WHERE     a.code in ('OPENCF','EDITCF')
            AND a.refid = p_otpkey
           AND status = 'N'
           AND a.secret = genencryptpassword (p_otp);

    IF l_count = 0
    THEN
        l_return := errnums_trans.C_SY_INVALID_OTP;

        UPDATE otp_logs
           SET retry_count = NVL (retry_count, 0) + 1
         WHERE code in ('OPENCF','EDITCF')
            AND refid = p_otpkey AND status = 'N';

        COMMIT;

        RETURN l_return;
    END IF;

    update otp_logs
    set status = 'A'
    WHERE code in ('OPENCF','EDITCF')
            AND refid = p_otpkey AND status = 'N';


    RETURN systemnums.c_success;
END;
/

DROP FUNCTION fn_check_remain_qtty
/

CREATE OR REPLACE 
FUNCTION fn_check_remain_qtty (p_acctno      VARCHAR2,
                              p_issueid     VARCHAR2,
                              p_category    VARCHAR2,
                              p_symbol      VARCHAR2,
                              p_productid     VARCHAR2,
                              p_quoteval    NUMBER)
    RETURN NUMBER
AS
    l_remainqtty number;
    l_return number;
BEGIN
    -- Chao ban lan dau => Phai con du so luong cua dot phat hanh = KL ghi so PH - KL dang chao ban LD - KL da ban lan dau - KL da dau tu so cap - KL da hoan tra
    if p_category = 'I' then


        select d.qtty - nvl(d.deliqtty,0) - nvl(d.sellquoteqtty,0) - nvl(d.investedamt,0) - nvl(d.returnamt,0)
            into l_remainqtty
        from deposit d
        where d.acctno = p_acctno
            and d.symbol = p_symbol
            and d.autoid = to_number(p_issueid);

        if l_remainqtty < p_quoteval then
            l_return := errnums_trans.C_NEGT_NOT_ENOUGH_ISSUEQTTY;
            RETURN l_return;
        end if;

    end if;

    --Chao ban tron/HDKH => Phai du so luong con lai: semast.trade - semast.secured
    if p_category in ('T','O') then
        select s.trade - nvl(s.secured,0) into l_remainqtty
        from semast s
        where s.afacctno = p_acctno
            and s.symbol = p_symbol;

        if l_remainqtty < p_quoteval then
            l_return := errnums_trans.C_NEGT_NOT_ENOUGH_QTTY;
            RETURN l_return;
        end if;

    end if;

    -- Chao ban combo san pham => Phai du so luong con lai cua tung trai phieu trong combo
    if p_category = 'C' then
        for r in (select p.symbol, sum(p.discount) qtty
                from comboproduct c, productier p
                where c.id = to_number(nvl(p_productid,'0'))
                    and c.id = p.id
                group by p.symbol)
        loop
            select s.trade - nvl(s.secured,0) into l_remainqtty
            from semast s
            where s.afacctno = p_acctno
                and s.symbol = r.symbol;

            if l_remainqtty < r.qtty * p_quoteval then
                l_return := errnums_trans.C_NEGT_NOT_ENOUGH_QTTY;
                RETURN l_return;
            end if;
        end loop;
    end if;

    RETURN systemnums.C_SUCCESS;
END;
/

DROP FUNCTION fn_check_roles
/

CREATE OR REPLACE 
FUNCTION fn_check_roles 
(
 pv_tltx  IN VARCHAR2,
 pv_menutype IN VARCHAR2 DEFAULT 'TA',
 pv_modcode  IN VARCHAR2,
 pv_key IN VARCHAR2,
 pv_table varchar2
)
RETURN NUMBER
/*
Check quyen hien thi giao dich
*/
IS
  v_curdate DATE;
  l_count NUMBER;
  v_roles VARCHAR2(100);
BEGIN
    IF pv_menutype = 'ALL' THEN
        RETURN 1;
    END IF;

    IF pv_tltx IN ('2014') THEN
        RETURN 1;
    END IF;

    --check rieng cho cac gd dung chung cho ca TA và PA
    IF pv_tltx IN ('2010','2011','2012','2004','2002','CFMAST') THEN
        IF SUBSTR(pv_key,4,1) = 'H' THEN
            IF pv_menutype = 'PA' THEN
                RETURN 1;
            ELSE
                RETURN 0;
            END IF;
        ELSE
            IF pv_menutype = 'TA' THEN
                RETURN 1;
            ELSE
                RETURN 0;
            END IF;
        END IF;
    END IF;

    --check gd maintain
    IF pv_tltx IN ('9997','9998','9999') THEN
        IF pv_menutype = 'FA' THEN
            RETURN 1;
        END IF;

        IF pv_table = 'MEMBERS' THEN
            RETURN 1;
        ELSE
            SELECT COUNT(*) INTO l_count FROM FUND F WHERE F.CODEID = pv_key AND F.ftype = 'P' ;
        END IF;

        IF pv_modcode = 'PA' OR l_count > 0 THEN
            IF pv_menutype = 'PA' THEN
                RETURN 1;
            ELSE
                RETURN 0;
            END IF;
        ELSE  ---IF pv_modcode <> 'PA'
            IF pv_menutype = 'TA' THEN
                RETURN 1;
            ELSE
                RETURN 0;
            END IF;
        END IF;
    END IF;

    --check cac gd con lai. gd PA dau 91%  con lai la TA
    IF pv_tltx like ('91%') OR pv_tltx like ('93%') THEN
        IF pv_menutype = 'PA' THEN
            RETURN 1;
        ELSE
            RETURN 0;
        END IF;
    ELSIF pv_tltx like ('92%') THEN
        IF pv_menutype = 'FA' THEN
            RETURN 1;
        ELSE
            RETURN 0;
        END IF;
    ELSE
        IF pv_menutype = 'TA' THEN
            RETURN 1;
        ELSE
            RETURN 0;
        END IF;
    END IF;

    RETURN 1;
EXCEPTION
  WHEN OTHERS THEN
    RETURN 0;
END;
/

DROP FUNCTION fn_checkallowgetdata
/

CREATE OR REPLACE 
FUNCTION fn_checkallowgetdata (pv_tlid varchar2, pv_cmdfuncname varchar2, pv_cmdobjname varchar2, pv_action varchar2)
RETURN varchar2 
IS
    v_logsctx       varchar2(500);
    v_logsbody      varchar2(500);
    text_var1       varchar2(500);
    l_count         INTEGER;
    p_err_code      varchar2(30);
BEGIN
    

     select count(*) into l_count 
     from focmdcode 
     where upper(objname) = upper(trim(pv_cmdobjname)) 
            and upper(cmdcode) = upper(trim(pv_cmdfuncname));
    
    if nvl(l_count,0) = 0 then
        p_err_code := fn_systemnums('errnums.E_TRANS_NOT_ALLOW');
       
        RETURN p_err_code;
    end if;
        
    
    RETURN p_err_code;
EXCEPTION WHEN OTHERS THEN
   
        p_err_code  := fn_systemnums('errnums.C_SYSTEM_ERROR');
    RETURN p_err_code;
END 

;
/

DROP FUNCTION fn_checkfunctionallow
/

CREATE OR REPLACE 
FUNCTION fn_checkfunctionallow (pv_tlid varchar2, pv_cmdtype varchar2, pv_cmdobjname varchar2, pv_action varchar2)
RETURN varchar2
is
    v_logsctx       varchar2(500);
    v_logsbody      varchar2(500);
    text_var1       varchar2(500);
    l_count         INTEGER;
--    rec             RECORD;
    pkgctx      varchar2(30);
    p_err_param      varchar2(3000);
    p_err_code      varchar2(3000);
    l_isINQUIRY     varchar2(2);
    l_isADD         varchar2(2);
    l_isEDIT        varchar2(2);
    l_isDELETE      varchar2(2);
    l_isAPPROVE     varchar2(2);
    l_cmdid         varchar2(20);
    l_is4customer   varchar2(2);
    l_tltxcd_list   varchar2(1000);
    l_action        varchar2(100);

BEGIN
    p_err_code  := systemnums.C_SUCCESS;
    p_err_param := 'SUCCESS';


    if pv_tlid in (fn_systemnums('systemnums.C_ADMIN_ID') , fn_systemnums('systemnums.C_SYSTEM_USERID'))
            or pv_cmdobjname = fn_systemnums('systemnums.C_SYSTEM_AUTH') then
        p_err_code := fn_systemnums('systemnums.C_SUCCESS');
        RETURN p_err_code;
    else

        -- 08/09/2018 TruongLD Add, dói v?i tru?ng h?p view --> user ph?i có quy?n truy c?p m?t ch?c nang nào dó c?a h? th?ng.
        if upper(pv_action) = 'VIEW' then
            select COUNT(*) into l_count
            from cmdauth ath, tlgrpusers tl
            where ath.authid = tl.grpid and tl.active = 'Y' and (tl.tlid = pv_tlid or pv_tlid = fn_systemnums('systemnums.C_ONLINE_USERID'));
            if l_count = 0 then
                p_err_code := fn_systemnums('errnums.E_TRANS_NOT_ALLOW');
                RETURN p_err_code;
            else
                RETURN p_err_code;
            end if;
        end if;
        --End TruongLD

        --Check xem chuc nang co trong he thong khong
        select count(*) into l_count from focmdmenu where objname = pv_cmdobjname;
        if l_count = 0 then
            p_err_code := fn_systemnums('errnums.E_TRANS_NOT_ALLOW');
            RETURN p_err_code;
        end if;

        --select cmdid, is4customer, tltxcd into l_cmdid, l_is4customer, l_tltxcd_list from focmdmenu where objname = pv_cmdobjname;
        --Neu la User Online thi co quyen thuc hien cac chuc nang tren online
        if  pv_tlid = fn_systemnums('systemnums.C_ONLINE_USERID') then
            select count(*) into l_count from focmdmenu
            where objname = pv_cmdobjname and is4customer = 'Y';

            if l_count > 0 then
                p_err_code := fn_systemnums('systemnums.C_SUCCESS');
                RETURN p_err_code;
            end if;

        end if;

        if upper(pv_action) = 'C' and pv_cmdtype = 'T' then
            l_action    := 'ADD';
        elsif upper(pv_action) = 'A' and pv_cmdtype = 'T' then
            l_action    := 'APPROVE';
        elsif upper(pv_action) in ('D','Z') and pv_cmdtype = 'T' then
            l_action    := 'DELETE';
        elsif upper(pv_action) = 'R' and pv_cmdtype = 'T' then
            l_action    := 'REJECT';
        else
            l_action   := pv_action;
        end if;

        l_count := 0;
        for rec in (
                    select ath.* from cmdauth ath, tlgrpusers tl
                    where ath.authid = tl.grpid and tl.active = 'Y' and tl.tlid = pv_tlid
                        and ath.cmdobjname = pv_cmdobjname
                   ) loop


            l_isINQUIRY :=  nvl(rec.isINQUIRY,'N');
            l_isADD     :=  nvl(rec.isADD,'N');
            l_isEDIT    :=  nvl(rec.isEDIT,'N');
            l_isDELETE  :=  nvl(rec.isDELETE,'N');
            l_isAPPROVE :=  nvl(rec.isAPPROVE,'N');
            l_action    := upper(l_action);
            if l_action = 'ADD' and l_isADD = 'Y' then
                l_count := l_count + 1;
            elsif l_action = 'EDIT' and l_isEDIT = 'Y' then
                l_count := l_count + 1;
            elsif l_action = 'DELETE' and l_isDELETE = 'Y' then
                l_count := l_count + 1;
            elsif l_action in ('APPROVE','REJECT','APPROVE_OBJLOG','REJECT_OBJLOG') and l_isAPPROVE = 'Y' then
                l_count := l_count + 1;
            end if;

        end loop;

        if nvl(l_count,0) = 0 then
            p_err_code := fn_systemnums('errnums.E_TRANS_NOT_ALLOW');
            RETURN p_err_code;
        end if;

    end if;



    RETURN p_err_code;
EXCEPTION WHEN OTHERS THEN
--        GET STACKED DIAGNOSTICS text_var1 := PG_EXCEPTION_CONTEXT;
        p_err_code := errnums.C_SYSTEM_ERROR;
        p_err_param := 'SYSTEM_ERROR';
                RETURN p_err_code;
END


;
/

DROP FUNCTION fn_common_getdateofnextwrkday
/

CREATE OR REPLACE 
FUNCTION fn_common_getdateofnextwrkday (p_busdate IN DATE, p_wrkdays IN NUMBER)
  RETURN VARCHAR2
IS
    v_return DATE;
BEGIN
    SELECT SBDATE INTO v_return
        FROM (SELECT ROWNUM DAYCNT, SBDATE
        FROM (SELECT * FROM SBCLDR WHERE CLDRTYPE='000' AND SBDATE>p_busdate AND HOLIDAY='N' ORDER BY SBDATE) CLDR) RL
        WHERE DAYCNT=p_wrkdays;
    RETURN v_return;
END;
/

DROP FUNCTION fn_common_parseacctno
/

CREATE OR REPLACE 
FUNCTION fn_common_parseacctno (p_txdesc IN VARCHAR2)
   RETURN VARCHAR2
IS
    v_count INTEGER;
    v_tmp INTEGER;
    v_tmpstr VARCHAR2(300);
    v_intchar INTEGER;
    v_position INTEGER;
    v_acctlength INTEGER;
    v_delimiter VARCHAR2(1);
    v_word VARCHAR2(300);
    v_return VARCHAR2(30);
    v_pcflag VARCHAR2(30);
    v_listprefix VARCHAR2(500);
BEGIN
    v_return := '';
    v_word := '';
    v_pcflag :='PCFAB';
    v_word := UPPER(p_txdesc);

    SELECT LISTAGG(dbcode, '/') WITHIN GROUP (ORDER BY dbcode) INTO v_listprefix
    FROM
    (select distinct dbcode from roles WHERE rolecode='DXX' OR rolecode='EXX' or rolecode='PAX');
    --remove multiple blank
    v_tmpstr := UPPER(REPLACE(TRIM(p_txdesc), '  ', '' ));
    --remove soecial underscore
    v_tmpstr := UPPER(REPLACE(TRIM(v_tmpstr), '_', '' ));
    v_tmpstr := UPPER(REPLACE(TRIM(v_tmpstr), '.', '' ));
    v_tmpstr := UPPER(REPLACE(TRIM(v_tmpstr), '-', '' ));

    v_delimiter := ' ';
    v_position := 1;
    v_acctlength := 10;
    v_position := INSTR(v_tmpstr, v_delimiter);
    --Find the word which has 10 charaters and match with prefix
    IF v_position>0 THEN
        --Many words, find the first word is account number
        v_tmp := 0;
        WHILE v_tmp < v_position LOOP
            v_word := SUBSTR(v_tmpstr, v_tmp, v_position-v_tmp);

            --Get account number
            v_return := FN_COMMON_PARSEACCTNO_SUB(v_word, v_listprefix, v_pcflag);
            IF NOT v_return IS NULL  THEN
                select count(*) into v_count from cfmast where custodycd=v_return;
                IF v_count>0 THEN
                    RETURN v_return;
                ELSE
                    v_return :='';
                END IF;
            END IF;
            --Move to next word
            v_tmp := v_position + 1;
            v_position := INSTR(v_tmpstr, v_delimiter, v_tmp);
        END LOOP;
    ELSE
        --Only has once word
        v_word := v_tmpstr;
        v_return := FN_COMMON_PARSEACCTNO_SUB(v_word, v_listprefix, v_pcflag);
        IF NOT v_return IS NULL  THEN
            select count(*) into v_count from cfmast where custodycd=v_return;
            IF v_count>0 THEN
                RETURN v_return;
            ELSE
                v_return :='';
            END IF;
        END IF;
    END IF;

    RETURN v_return;
END;
/

DROP FUNCTION fn_common_parseacctno_sub
/

CREATE OR REPLACE 
FUNCTION fn_common_parseacctno_sub (p_word IN VARCHAR2, p_prefix IN VARCHAR2, p_pcflag IN VARCHAR2)
  RETURN VARCHAR2
IS
  v_intchar INTEGER;
  v_acctlength INTEGER;
  v_acctno VARCHAR2(30);
  v_word VARCHAR2(30);
BEGIN
    v_acctlength := 10;
    v_acctno := '';
    v_word := UPPER(p_word);
    IF LENGTH(v_word) >= v_acctlength THEN
        IF INSTR(p_prefix, SUBSTR(v_word, 1, 3)) > 0 THEN
            v_intchar := INSTR(p_pcflag, SUBSTR(v_word, 4, 1));
            IF v_intchar>0 THEN
                v_acctno := SUBSTR(v_word, 1, v_acctlength);
            END IF;
        END IF;
    END IF;
    RETURN v_acctno;
END;
/

DROP FUNCTION fn_common_parseacctno_4pa
/

CREATE OR REPLACE 
FUNCTION fn_common_parseacctno_4pa (p_txdesc IN VARCHAR2)
   RETURN VARCHAR2
IS
    v_count INTEGER;
    v_tmp INTEGER;
    v_tmpstr VARCHAR2(300);
    v_intchar INTEGER;
    v_position INTEGER;
    v_acctlength INTEGER;
    v_delimiter VARCHAR2(1);
    v_word VARCHAR2(300);
    v_return VARCHAR2(30);
    v_pcflag VARCHAR2(30);
    v_listprefix VARCHAR2(500);
BEGIN
    v_return := '';
    v_word := '';
    v_pcflag :='PCFABH';
    v_word := UPPER(p_txdesc);

    SELECT LISTAGG(dbcode, '/') WITHIN GROUP (ORDER BY dbcode) INTO v_listprefix
    FROM
    (select distinct dbcode from roles WHERE rolecode='DXX' OR rolecode='EXX' or rolecode='PAX');
    --remove multiple blank
    v_tmpstr := UPPER(REPLACE(TRIM(p_txdesc), '  ', '' ));
    --remove soecial underscore
    v_tmpstr := UPPER(REPLACE(TRIM(v_tmpstr), '_', '' ));
    v_tmpstr := UPPER(REPLACE(TRIM(v_tmpstr), '.', '' ));
    v_tmpstr := UPPER(REPLACE(TRIM(v_tmpstr), '-', '' ));

    v_delimiter := ' ';
    v_position := 1;
    v_acctlength := 10;
    v_position := INSTR(v_tmpstr, v_delimiter);
    --Find the word which has 10 charaters and match with prefix
    IF v_position>0 THEN
        --Many words, find the first word is account number
        v_tmp := 0;
        WHILE v_tmp < v_position LOOP
            v_word := SUBSTR(v_tmpstr, v_tmp, v_position-v_tmp);

            --Get account number
            v_return := FN_COMMON_PARSEACCTNO_SUB(v_word, v_listprefix, v_pcflag);
            IF NOT v_return IS NULL  THEN
                select count(*) into v_count from cfmast where custodycd=v_return;
                IF v_count>0 THEN
                    RETURN v_return;
                ELSE
                    v_return :='';
                END IF;
            END IF;
            --Move to next word
            v_tmp := v_position + 1;
            v_position := INSTR(v_tmpstr, v_delimiter, v_tmp);
        END LOOP;
    ELSE
        --Only has once word
        v_word := v_tmpstr;
        v_return := FN_COMMON_PARSEACCTNO_SUB(v_word, v_listprefix, v_pcflag);
        IF NOT v_return IS NULL  THEN
            select count(*) into v_count from cfmast where custodycd=v_return;
            IF v_count>0 THEN
                RETURN v_return;
            ELSE
                v_return :='';
            END IF;
        END IF;
    END IF;

    RETURN v_return;
END;
/

DROP FUNCTION fn_convert_string_to_array
/

CREATE OR REPLACE 
FUNCTION fn_convert_string_to_array (p_str varchar2)
 RETURN dbms_utility.lname_array 
 IS

    l_input varchar2(4000) := p_str ;
    l_count binary_integer;
    l_array dbms_utility.lname_array;
    str varchar(500);
    len NUMBER;

BEGIN
--  str := regexp_replace(l_input,'(^|~\$~)',',x');
--  len := length(str);
--  str := left_(str, len-2);
--  len := length(str);
--  str := right_(str, len-1);
--  dbms_output.put_line(str);
    str := regexp_replace(l_input,'(^|#)','\1x,');
--  str := 'key_paF1key_childGG111key_child11key_paF1key_childTrái phi?u tronkey_child444key_pa';
--  str := ',xF1key_childGG111key_child11,xF1key_childTrái phi?u tronkey_child444,x';
--  len := length(str);
--  str := left_(str, len-2);
--  len := length(str);
--  str := right_(str, len-1);
--  str := 'xF1key_childGG111key_child11,xF1key_childTráikey_child444';
    dbms_output.put_line(str);
    dbms_utility.comma_to_table
     ( list   => str
      , tablen => l_count
      , tab    => l_array
    );
     dbms_output.put_line('CEEEEE'); 
     for i in 1 .. l_count
     loop
       dbms_output.put_line
       ( 'Element ' || to_char(i) ||
         ' of array contains: ' ||
         substr(l_array(i),2)
       );
    end loop;
    RETURN l_array; 

Exception
When others then
    return l_array;
END

;
/

DROP FUNCTION fn_convert_to_sms_text
/

CREATE OR REPLACE 
FUNCTION fn_convert_to_sms_text (strinput  varchar2)
 RETURN varchar2 
 IS


    strconvert    varchar2(2000);

BEGIN
    strconvert := translate(strinput,
                            'áà?ã?â?????a?????déè???ê?????íì?i?óò?õ?ô?????o?????úù?u?u?????ý????ÁÀ?Ã?Â?????A?????ÐÉÈ???Ê?????ÍÌ?I?ÓÒ?Õ?Ô?????O?????ÚÙ?U?U?????Ý????',
                            'aaaaaaaaaaaaaaaaadeeeeeeeeeeeiiiiiooooooooooooooooouuuuuuuuuuuyyyyyAAAAAAAAAAAAAAAAADEEEEEEEEEEEIIIIIOOOOOOOOOOOOOOOOOUUUUUUUUUUUYYYYY');
    return strconvert;

Exception
When others then
    return '-1';
END

;
/

DROP FUNCTION fn_crb_buildamtexp
/

CREATE OR REPLACE 
FUNCTION fn_crb_buildamtexp (strAMTEXP IN varchar2,
    strTxnum IN VARCHAR2,
    strtxdate IN VARCHAR2)
  RETURN  varchar2
  IS
  v_strEvaluator varchar2(100);
  v_strElemenent  varchar2(20);
  v_lngIndex number(10,0);
  v_strNodedata varchar2(10);
  v_CURRDATE varchar2(10);
BEGIN
  SELECT VARVALUE INTO v_CURRDATE FROM SYSVAR WHERE VARNAME='CURRDATE';
    v_strEvaluator := '';
    v_lngIndex := 1;
    While v_lngIndex < Length(strAMTEXP) loop
        --Get 02 charatacters in AMTEXP
        v_strElemenent := substr(strAMTEXP, v_lngIndex, 2);
        if v_strElemenent in ( '++', '--', '**', '//', '((', '))') then
                --Operand
                v_strEvaluator := v_strEvaluator || substr(v_strElemenent,1,1);
        else
                --Operator
                IF v_CURRDATE=strtxdate THEN
                  select nvalue into v_strNodedata from tllogfld where txnum =strTxnum and txdate =to_date(strtxdate,'DD/MM/YYYY') and fldcd=v_strElemenent;
                ELSE
                  select nvalue into v_strNodedata from tllogfldall where txnum =strTxnum and txdate =to_date(strtxdate,'DD/MM/YYYY') and fldcd=v_strElemenent;
                END IF;
                v_strEvaluator := v_strEvaluator || v_strNodedata;
        End if;
        v_lngIndex := v_lngIndex + 2;
    end loop;
    RETURN v_strEvaluator;
EXCEPTION
   WHEN OTHERS THEN
    RETURN '0';
END;
/

DROP FUNCTION fn_demo
/

CREATE OR REPLACE 
FUNCTION fn_demo (datainput varchar2, p_language varchar2)
 RETURN varchar2
 IS
BEGIN
    FOR i IN 1..5
    LOOP
        INSERT INTO AHIHI VALUES ('2'); 
    END LOOP;
    commit;
   RETURN 'OK';
Exception
When others then
    return 'Err: ' || sqlerrm || ' Trace: ' || dbms_utility.format_error_backtrace;
END
;
/

DROP FUNCTION fn_eval_amtexp
/

CREATE OR REPLACE 
FUNCTION fn_eval_amtexp (p_txnum IN VARCHAR2, p_txdate IN VARCHAR2, p_REFVAL IN VARCHAR2)
  RETURN  varchar2
  IS
  TYPE v_CurTyp  IS REF CURSOR;
  c1        v_CurTyp;
  v_RETURN   varchar2(500);
  v_EXPRESSION varchar2(250);
  v_CURRDATE varchar2(10);
BEGIN
  v_RETURN:='0';
  IF NOT p_REFVAL IS NULL THEN
    BEGIN
      IF SUBSTR(p_REFVAL,1,1)='@' THEN
        --LAY TRUC TIEP GIA TRI
        v_RETURN := SUBSTR(p_REFVAL,2);
      ELSIF SUBSTR(p_REFVAL,1,1) IN ('$', '#') THEN
        BEGIN
          --LAY THEO MOT TRUONG TREEN MAN HINH
          v_EXPRESSION := SUBSTR(p_REFVAL,2, 2);  --LAY MA TRUONG DU LIEU
          SELECT VARVALUE INTO v_CURRDATE FROM SYSVAR WHERE VARNAME='CURRDATE';
          IF v_CURRDATE=p_txdate THEN
            SELECT (CASE WHEN CVALUE IS NULL THEN TO_CHAR(NVALUE) ELSE CVALUE END) INTO v_RETURN
            FROM TLLOGFLD WHERE TXNUM=p_txnum AND TXDATE=TO_DATE(p_txdate,'DD/MM/YYYY') AND FLDCD=v_EXPRESSION;
          ELSE
            SELECT (CASE WHEN CVALUE IS NULL THEN TO_CHAR(NVALUE) ELSE CVALUE END) INTO v_RETURN
            FROM TLLOGFLDALL WHERE TXNUM=p_txnum AND TXDATE=TO_DATE(p_txdate,'DD/MM/YYYY') AND FLDCD=v_EXPRESSION;
          END IF;
        END;
      ELSIF p_REFVAL = '<$BUSDATE>' THEN
        --BIEN HE THONG
        SELECT VARVALUE INTO v_RETURN FROM SYSVAR WHERE GRNAME='SYSTEM' AND VARNAME='CURRDATE';
      ELSIF p_REFVAL = '<$COMPANYNAME>' THEN
        --BIEN HE THONG
        SELECT VARVALUE INTO v_RETURN FROM SYSVAR WHERE GRNAME='SYSTEM' AND VARNAME='COMPANYNAME';
      ELSE
        BEGIN
          --BIEU THUC TINH TOAN SO HOC
          v_EXPRESSION := FN_CRB_BUILDAMTEXP(p_REFVAL, p_txnum, p_txdate);
          OPEN c1 FOR 'SELECT TO_CHAR(' || v_EXPRESSION || ') AS RETVAL FROM DUAL';
          FETCH c1 INTO v_RETURN;
          CLOSE c1;
        END;
      END IF;
    END;
  END IF;
  RETURN v_RETURN;
EXCEPTION
   WHEN OTHERS THEN
    RETURN '0';
END;
/

DROP FUNCTION fn_fa_getbondcoupon
/

CREATE OR REPLACE 
FUNCTION fn_fa_getbondcoupon (p_fundcodeid in VARCHAR2, p_symbol    IN VARCHAR2,
                                                p_busdate   IN DATE)
   RETURN NUMBER
IS
   v_count        NUMBER;
   v_parvalue     NUMBER;
   v_intlastdt    DATE;
   v_intrate      NUMBER;
   v_numofdays    NUMBER;
   v_daysofyear   NUMBER;
   v_intyearcd    VARCHAR2 (3);
   v_return       NUMBER;
BEGIN
   v_return := 0;

   SELECT COUNT (*)
     INTO v_count
     FROM INSTRLIST
    WHERE SYMBOL = p_symbol AND fundcodeid = p_fundcodeid;

   IF v_count >= 1
   THEN
      SELECT NVL (INTLASTDT, SYSDATE),
             INTRATE,
             INTYEARCD,
             PARVALUE
        INTO v_intlastdt,
             v_intrate,
             v_intyearcd,
             v_parvalue
        FROM INSTRLIST
       WHERE SYMBOL = p_symbol AND fundcodeid = p_fundcodeid;

      SELECT p_busdate - v_intlastdt INTO v_numofdays FROM DUAL;

      IF v_numofdays > 0
      THEN
         IF v_intyearcd = 'S'
         THEN
            v_daysofyear := 360;
         ELSE
            SELECT   ADD_MONTHS (TRUNC (p_busdate, 'RRRR'), 12)
                   - TRUNC (p_busdate, 'RRRR')
              INTO v_daysofyear
              FROM DUAL;
         END IF;

         v_return :=
            v_parvalue * (v_intrate / 100) * v_numofdays / v_daysofyear;
      END IF;
   END IF;

   RETURN v_return;
END;
/

DROP FUNCTION fn_feetype_check_duplicate
/

CREATE OR REPLACE 
FUNCTION fn_feetype_check_duplicate (pv_feeid varchar2, p_feetype varchar2, p_frdate date, p_todate date, p_exectype varchar2, p_srtype varchar2, p_symbol varchar2)
return varchar2
 
AS
-- Hàm check duplicate feetype

    
    p_err_code varchar2(100);
    v_logsctx     varchar2(500);
    v_exception   varchar2(500);
    v_logsbody    varchar2(500);
  
    v_count integer;
BEGIN
    
    p_err_code  := fn_systemnums('systemnums.C_SUCCESS');
    v_count := 0;    
    select Count(1) into v_count
    from feetype f
        where feetype = p_feetype
        and feetype <> '003'
        and nvl(exectype,'') = nvl(p_exectype,'')
        and nvl(srtype,'') = nvl(p_srtype,'')
        and nvl(symbol,'') = nvl(p_symbol,'')
        and id <> pv_FEEID
        and ((p_frdate >= frdate and p_frdate < todate)
            or (p_todate > frdate and p_todate <= todate)
            or (frdate >= p_frdate and frdate < p_todate)
            or (todate > p_frdate and todate <= p_todate)
            );
        
    if (v_count =0) then 
        with t1 as (select record_value,column_name,to_value,mod_num
        from maintain_log ml 
        where table_name = 'FEETYPE' 
        and action_flag = 'EDIT'
        and approve_dt is null
        ), t2 as (
        select record_value,column_name,to_value,mod_num
        from t1 a
        where mod_num = (select Max(mod_num) from t1 b where  a.record_value = b.record_value
            )
        ), t as (
        select id,
        nvl((select to_value from t2 where column_name = 'FEETYPE' and record_value = f.id),feetype) feetype,
        nvl((select to_value from t2 where column_name = 'EXECTYPE' and record_value = f.id),exectype) exectype,
        nvl((select to_value from t2 where column_name = 'SRTYPE' and record_value = f.id),srtype) srtype,
        nvl((select to_value from t2 where column_name = 'SYMBOL' and record_value = f.id),symbol) symbol,
        nvl((select to_date(to_value,'dd/MM/yyyy') from t2 where column_name = 'FRDATE' and record_value = f.id),frdate) frdate,
        nvl((select to_date(to_value,'dd/MM/yyyy') from t2 where column_name = 'TODATE' and record_value = f.id),todate) todate
        from feetype f
        )
        select Count(1) into v_count
        from t
        where feetype = p_feetype
        and feetype <> '003'
        and nvl(exectype,'') = nvl(p_exectype,'')
        and nvl(srtype,'') = nvl(p_srtype,'')
        and nvl(symbol,'') = nvl(p_symbol,'')
        and id <> pv_FEEID
        and ((p_frdate >= frdate and p_frdate < todate)
            or (p_todate > frdate and p_todate <= todate)
            or (frdate >= p_frdate and frdate < p_todate)
            or (todate > p_frdate and todate <= p_todate)
            )
        ;
    end if;
    /*if v_count > 0 then
         p_err_code := '-511186';
         --log output
         v_logsbody     := '{"p_err_code":"' || p_err_code || '"}';
         v_logsctx  := plog.setendsection(v_logsctx, v_logsbody);
    RETURN p_err_code;
    end if;*/
                   
    
    RETURN p_err_code;
Exception
    when others then
    
        p_err_code  := fn_systemnums('errnums.C_SYSTEM_ERROR');
        
    RETURN p_err_code;
END;
/

DROP FUNCTION fn_fldval_maintainlog
/

CREATE OR REPLACE 
FUNCTION fn_fldval_maintainlog 
(p_fldname   in   VARCHAR2,
 p_objname IN VARCHAR2,
 p_fldval IN VARCHAR2)
return string 
IS 
  l_refcursor pkg_report.ref_cursor;
  l_return varchar2(1000);
  l_count    number;
  l_llist  varchar2(1000);
  l_strSQL varchar2(1000);
BEGIN
    SELECT count(llist) , max(llist) INTO l_count,l_llist FROM fldmaster 
    WHERE objname = p_objname AND DEFNAME = p_fldname AND llist IS NOT NULL; 
    IF l_count = 1 THEN 
        BEGIN
            l_return :=p_fldval;
            l_strSQL :='select DISPLAY from (' || l_llist ||') where VALUE ='''|| p_fldval || '''';
            OPEN  l_refcursor FOR l_strSQL;
            LOOP
                FETCH l_refcursor INTO l_return;
                EXIT WHEN l_refcursor%NOTFOUND;
            END LOOP;
            CLOSE l_refcursor;
        EXCEPTION WHEN OTHERS THEN
            l_return :=p_fldval;   
        END;    
    ELSE 
        l_return :=p_fldval;
    END IF;
    RETURN l_return;
exception
  when others then
    return  p_fldval;
end;
/

DROP FUNCTION fn_formatnumber
/

CREATE OR REPLACE 
FUNCTION fn_formatnumber (p_value number)
 RETURN varchar2
 IS
    v_logsctx       varchar2(500);
    v_logsbody      varchar2(500);
    v_exception     varchar2(500);
    v_value         number;
    v_txtReturn     varchar2(500);
BEGIN
    v_value := nvl(p_value,0);
    if mod(v_value,1) > 0 then
        v_txtReturn := trim(to_char(v_value, fn_systemnums('systemnums.c_number_format2')));
    else
        v_txtReturn := trim(to_char( v_value, fn_systemnums('systemnums.c_number_format')));
    end if;

    return v_txtReturn;

Exception
When others then
    return '-1';
END

;
/

DROP FUNCTION fn_gen_camastid
/

CREATE OR REPLACE 
FUNCTION fn_gen_camastid (pv_date In VARCHAR2, pv_codeid IN VARCHAR2,pv_id VARCHAR2)
    RETURN VARCHAR2 IS
    pkgctx   plog.log_ctx;
   logrow   tlogdebug%ROWTYPE;
  l_refcursor pkg_report.ref_cursor;

    v_Result  VARCHAR2(250);
    v_autoid VARCHAR2(250);
    v_date  date;
    v_symbol VARCHAR2(100);
    l_strSQL varchar2(1000);
    l_count    number;
      l_fldname varchar2(500);
      p_tablename VARCHAR2(500);
      L_SYMBOL VARCHAR2(100);
BEGIN
    --Lay ma quy:
    SELECT symbol INTO v_symbol FROM FUND WHERE codeid  = pv_codeid;
    v_date := to_date(pv_date,'dd/MM/rrrr');
    v_autoid:=LPAD(SUBSTR(pv_id,-2),2,0);

    l_fldname := 'substr( CAMASTID,-2' || ')';
    p_tablename := 'CAMAST';
    L_SYMBOL := v_symbol||to_char(v_date,'ddmmrrrr');
    l_strSQL :='SELECT NVL(MAX(ODR)+1,1) AUTOINV FROM
                        (SELECT ROWNUM ODR, INVACCT
                        FROM (SELECT ' || l_fldname || ' INVACCT FROM '|| p_tablename ||
                        ' WHERE 0=0 AND SUBSTR(CAMASTID,1, length(CAMASTID)-2) = '|| '''' || L_SYMBOL || '''' ||' ORDER BY '
                        || l_fldname ||') DAT WHERE TO_NUMBER(INVACCT)=ROWNUM ) INVTAB';

    plog.error (pkgctx, 'l_strSQL: '||l_strSQL);

    OPEN l_refcursor FOR l_strSQL;
    LOOP
            FETCH l_refcursor INTO l_count;
            EXIT WHEN l_refcursor%NOTFOUND;
        END LOOP;
    CLOSE l_refcursor;

    v_result:=v_symbol||to_char(v_date,'ddmmrrrr')||LPAD(l_count,2,0);
    RETURN v_Result;

EXCEPTION
   WHEN OTHERS THEN
    RETURN 0;
END;
/

DROP FUNCTION fn_gen_strdt4005
/

CREATE OR REPLACE 
FUNCTION fn_gen_strdt4005 (pv_strdt In VARCHAR2,pv_id number)
    RETURN VARCHAR2 IS
 v_Result varchar2(1000)  ;
BEGIN

IF pv_id =0 THEN

SELECT symbol INTO v_Result  FROM fund WHERE codeid IN
(SELECT SUBSTR( pv_strdt,0,INSTR (pv_strdt,'|') -1 )
FROM dual) ;

ELSIF pv_id =1THEN

SELECT feename INTO v_Result  FROM feetype WHERE id IN
(SELECT  SUBSTR( pv_strdt,INSTR (pv_strdt,'|') +1 ,INSTR (pv_strdt,'|',1,2) -INSTR (pv_strdt,'|',1,1)-1  )
FROM dual) ;


ELSIF pv_id =2 THEN

v_Result:=   SUBSTR( pv_strdt,INSTR (pv_strdt,'|',1,2) +1,INSTR (pv_strdt,'|',1,3) -INSTR (pv_strdt,'|',1,2)-1  );

ELSE
v_Result:=  SUBSTR( pv_strdt,INSTR (pv_strdt,'|',1,3) +1  );

END IF;

RETURN v_Result;


EXCEPTION
   WHEN OTHERS THEN
    RETURN '';
END;
/

DROP FUNCTION fn_gen_strdt4014
/

CREATE OR REPLACE 
FUNCTION fn_gen_strdt4014 (pv_strdt In VARCHAR2,pv_id number)
    RETURN VARCHAR2 IS
 v_Result varchar2(1000)  ;
BEGIN

IF pv_id =0 THEN

SELECT symbol INTO v_Result  FROM fund WHERE codeid IN
(SELECT SUBSTR( pv_strdt,0,INSTR (pv_strdt,'|') -1 )
FROM dual) ;

ELSIF pv_id =1THEN

SELECT feename INTO v_Result  FROM feetype WHERE id IN
(SELECT  SUBSTR( pv_strdt,INSTR (pv_strdt,'|') +1 ,INSTR (pv_strdt,'|',1,2) -INSTR (pv_strdt,'|',1,1)-1  )
FROM dual) ;


ELSIF pv_id =2 THEN

v_Result:=   SUBSTR( pv_strdt,INSTR (pv_strdt,'|',1,2) +1,INSTR (pv_strdt,'|',1,3) -INSTR (pv_strdt,'|',1,2)-1  );

ELSE
v_Result:=  SUBSTR( pv_strdt,INSTR (pv_strdt,'|',1,3) +1  );

END IF;

RETURN v_Result;


EXCEPTION
   WHEN OTHERS THEN
    RETURN '';
END;
/

DROP FUNCTION fn_get_acctno
/

CREATE OR REPLACE 
FUNCTION fn_get_acctno 
(
 pv_custodycd  IN VARCHAR2
)
RETURN VARCHAR2
IS
  l_acctno VARCHAR2(100);
BEGIN
  select af.acctno into l_acctno from cfmast cf, afmast af
  where cf.custid = af.custid
  and cf.custodycd = pv_custodycd;
  return l_acctno;
EXCEPTION
  WHEN OTHERS THEN
    RETURN null;
END;
/

DROP FUNCTION fn_get_address_2006
/

CREATE OR REPLACE 
FUNCTION fn_get_address_2006 (p_SID varchar2)
  return string is
  v_address varchar2(500);
BEGIN

  SELECT CF.ADDRESS INTO v_address FROM CFMASTER CF WHERE SID = p_SID;
  RETURN v_address;
exception
  when others then
    return ' ';
end;
/

DROP FUNCTION fn_get_autoid_asset
/

CREATE OR REPLACE 
FUNCTION fn_get_autoid_asset (p_symbol VARCHAR2)
    RETURN INTEGER
AS
    l_autoid   INTEGER;
BEGIN
    SELECT autoid
      INTO l_autoid
      FROM assetdtl
     WHERE symbol = p_symbol;

    RETURN l_autoid;
END;
/

DROP FUNCTION fn_get_autoid_assetdtl
/

CREATE OR REPLACE 
FUNCTION fn_get_autoid_assetdtl (p_symbol varchar2)
 RETURN integer
 
AS
            l_autoid    integer;
        BEGIN
            select autoid
            into l_autoid
            from assetdtl
            where symbol = p_symbol;
            RETURN l_autoid;
        END;
/

DROP FUNCTION fn_get_avlqtty
/

CREATE OR REPLACE 
FUNCTION fn_get_avlqtty (p_acount      varchar2,p_codeid varchar2
                                          )
  return varchar2 is
 v_dc  varchar2(200)   ;

BEGIN
    v_dc := '0';
    select se.trade into v_dc from semast se 
    where se.custodycd = p_acount
    and  se.codeid = p_codeid;
    RETURN v_dc;
exception
  when others then
    return '0';
end;
/

DROP FUNCTION fn_get_balqttybyfeetype
/

CREATE OR REPLACE 
FUNCTION fn_get_balqttybyfeetype (p_afacctno VARCHAR2,p_codeid VARCHAR2,p_feetype  VARCHAR2)
return varchar2 is
 v_dc  varchar2(200)   ;
BEGIN
    v_dc := '0';
    IF p_feetype IS NOT NULL  THEN

    select sum(se.trade)  into v_dc from sedtl se
    where se.afacctno =p_afacctno AND se.codeid =p_codeid AND se.feeid = p_feetype ;

    ELSE
    select se.trade into v_dc from semast se
    where se.afacctno =p_afacctno AND se.codeid =p_codeid ;
    END if ;
    RETURN v_dc;
exception
  when others then
    return '0';
end;
/

DROP FUNCTION fn_get_brid
/

CREATE OR REPLACE 
FUNCTION fn_get_brid (p_tlid varchar2)


return varchar2

is
    l_brid varchar2(10);
 Begin
    l_brid:='999999';
    select brid into l_brid from tlprofiles where tlid=p_tlid;
    return nvl(l_brid,'999999');
exception
  when others then
    return '999999';
End


;
/

DROP FUNCTION fn_get_cbondprice
/

CREATE OR REPLACE 
FUNCTION fn_get_cbondprice (p_symbol varchar2, p_dealer varchar2)
 RETURN number
 
as
    l_facevalue number;
    l_pvcal_method varchar2(1);
    l_discount_rate number;
    l_coupon_rate number;
    l_count number;
    l_return number;
begin
    
    select count(1) into l_count
    from sbsedefacct s, assetdtl a
    where s.symbol = p_symbol and s.refafacctno = p_dealer and s.status = 'A'
        and s.symbol = a.symbol and a.status = 'A';

    if l_count = 0 then
        return 0;
    end if;

    select a.parvalue, s.calpv_method, s.ipodiscrate, a.intrate 
        into l_facevalue, l_pvcal_method, l_discount_rate, l_coupon_rate
    from sbsedefacct s, assetdtl a
    where s.symbol = p_symbol and s.refafacctno = p_dealer and s.status = 'A'
        and s.symbol = a.symbol and a.status = 'A';
    
    if l_pvcal_method is null or l_pvcal_method = 'B' then -- Ban theo menh gia
        l_return := l_facevalue;
    else
        if l_pvcal_method = 'P' then -- Ban theo Present value          
            l_return := fn_cal_cbond_price(p_symbol, l_coupon_rate - l_discount_rate);
            --l_return := fn_ox_oxcbond_price(p_symbol, l_coupon_rate - l_discount_rate);
            
            
        else -- Gia dinh nhan het cuoi ky
            l_return := fn_cal_cbond_price_lump(p_symbol, l_coupon_rate - l_discount_rate);
        end if;
    end if;

    return round(l_return,0);
exception
    when others then
        return 0;
END;
/

DROP FUNCTION fn_get_cftype_by_custodycd
/

CREATE OR REPLACE 
FUNCTION fn_get_cftype_by_custodycd (p_custodycd in varchar2) RETURN VARCHAR2 AS
l_cftype varchar2(50);
BEGIN
  select cf.cftype into l_cftype
            from cfmast cf
            where cf.custodycd = p_custodycd;

            RETURN l_cftype;
END FN_GET_CFTYPE_BY_CUSTODYCD;
/

DROP FUNCTION fn_get_changtype
/

CREATE OR REPLACE 
FUNCTION fn_get_changtype (P_value VARCHAR2,P_type VARCHAR2)
return VARCHAR2
is
    V_STRTLNAME   VARCHAR2(2000);
BEGIN
    -- HAM THUC HIEN LAY CHUOI TEN VALUE
    -- DUNG CHO BAO CAO SA0007
    IF P_type IN ('M','G') THEN
          SELECT CMD1||CMD2||CMD3||CMD4||CMD5||CMD6||CMD7 INTO V_STRTLNAME
          FROM(
          SELECT (CASE WHEN SUBSTR(P_value,1,1)='Y' THEN 'Truy c?p, ' ELSE '' END) CMD1,
                 (CASE WHEN SUBSTR(P_value,2,1)='Y' THEN 'Tim ki?m, ' ELSE '' END) CMD2,
                 (CASE WHEN SUBSTR(P_value,3,1)='Y' THEN 'Them m?i, ' ELSE '' END) CMD3,
                 (CASE WHEN SUBSTR(P_value,4,1)='Y' THEN 'S?a, ' ELSE '' END) CMD4,
                 (CASE WHEN SUBSTR(P_value,5,1)='Y' THEN 'Xoa, ' ELSE '' END) CMD5,
                 (CASE WHEN SUBSTR(P_value,6,1)='Y' THEN 'Duy?t, ' ELSE '' END) CMD6,
                 (CASE WHEN SUBSTR(P_value,7,1)='A' THEN 'Toan b?, '
                       WHEN SUBSTR(P_value,7,1)='B' THEN 'Chi nhanh, '
                       WHEN SUBSTR(P_value,7,1)='C' THEN 'Nhom Q.ly KH, '
                       WHEN SUBSTR(P_value,7,1)='S' THEN 'Phong GD, '
                       WHEN SUBSTR(P_value,7,1)='R' THEN 'Khu v?c, ' ELSE '' END) CMD7
          FROM DUAL
           );
    ELSIF P_type ='R' THEN

          SELECT CMD1||CMD2||CMD3||CMD4 INTO V_STRTLNAME
          FROM(
          SELECT (CASE WHEN SUBSTR(P_value,1,1)='Y' THEN 'Xem, ' ELSE '' END) CMD1,
                 (CASE WHEN SUBSTR(P_value,2,1)='Y' THEN 'In, ' ELSE '' END) CMD2,
                 (CASE WHEN SUBSTR(P_value,3,1)='Y' THEN 'T?o bao cao, ' ELSE '' END) CMD3,
                  (CASE WHEN SUBSTR(P_value,7,1)='A' THEN 'Toan b?, '
                       WHEN SUBSTR(P_value,7,1)='B' THEN 'Chi nhanh, '
                       WHEN SUBSTR(P_value,7,1)='C' THEN 'Nhom Q.ly KH, '
                       WHEN SUBSTR(P_value,7,1)='S' THEN 'Phong GD, '
                       WHEN SUBSTR(P_value,7,1)='R' THEN 'Khu v?c, ' ELSE '' END) CMD4

          FROM DUAL
          );
    ELSIF P_type ='T' THEN
          SELECT CMD1||CMD2||CMD3||CMD4||CMD5||CMD6||CMD7||CMD8 INTO V_STRTLNAME
          FROM(
          SELECT (CASE WHEN SUBSTR(P_value,2,1)='Y' THEN 'DLPP t?o, ' else '' end) CMD1,
                 (CASE WHEN SUBSTR(P_value,3,1)='Y' THEN 'DLPP duy?t, ' else '' end) CMD2,
                 (CASE WHEN SUBSTR(P_value,4,1)='Y' THEN 'NHGS t?o, ' else '' end) CMD3,
                 (CASE WHEN SUBSTR(P_value,5,1)='Y' THEN 'NHGS duy?t, ' else '' end) CMD4,
                 (CASE WHEN SUBSTR(P_value,6,1)='Y' THEN 'CTQLQ t?o, ' else '' end) CMD5,
                 (CASE WHEN SUBSTR(P_value,7,1)='Y' THEN 'CTQLQ duy?t, ' else '' end) CMD6,
                 (CASE WHEN SUBSTR(P_value,8,1)='Y' THEN 'VSD duy?t 1, ' else '' end) CMD7,
                 (CASE WHEN SUBSTR(P_value,9,1)='Y' THEN 'VSD duy?t 2, ' else '' end) CMD8
          FROM DUAL
          );
    ELSE  --P_type ='T' THEN


          SELECT CMD1||CMD2||CMD3 INTO V_STRTLNAME
          FROM(
          SELECT (CASE WHEN SUBSTR(P_value,1,1)='Y' THEN 'Backdate, '
                       WHEN SUBSTR(P_value,1,1)='N' THEN ''
                       WHEN SUBSTR(P_value,1,1)='A' THEN 'Toan b?, '
                       WHEN SUBSTR(P_value,1,1)='B' THEN 'Chi nhanh, '
                       WHEN SUBSTR(P_value,1,1)='C' THEN 'Nhom Q.ly KH, '
                       WHEN SUBSTR(P_value,1,1)='S' THEN 'Phong GD, '
                       WHEN SUBSTR(P_value,1,1)='R' THEN 'Khu v?c, '   ELSE P_value END) CMD1,
                 (CASE WHEN SUBSTR(P_value,2,1) in ('Y','N') THEN ''
                       WHEN SUBSTR(P_value,2,1)='A' THEN 'Toan b?, '
                       WHEN SUBSTR(P_value,2,1)='B' THEN 'Chi nhanh, '
                       WHEN SUBSTR(P_value,2,1)='C' THEN 'Nhom Q.ly KH, '
                       WHEN SUBSTR(P_value,2,1)='S' THEN 'Phong GD, '
                       WHEN SUBSTR(P_value,2,1)='R' THEN 'Khu v?c, '  ELSE '' END) CMD2,
                  (CASE WHEN SUBSTR(P_value,3,1)='A' THEN 'Toan b?, '
                       WHEN SUBSTR(P_value,3,1)='B' THEN 'Chi nhanh, '
                       WHEN SUBSTR(P_value,3,1)='C' THEN 'Nhom Q.ly KH, '
                       WHEN SUBSTR(P_value,3,1)='S' THEN 'Phong GD, '
                       WHEN SUBSTR(P_value,3,1)='R' THEN 'Khu v?c, ' ELSE '' END) CMD3

          FROM DUAL
          );

 --   ELSE V_STRTLNAME:=TO_CHAR(P_value);

    END IF;
    return V_STRTLNAME;

exception when others then
return '';
end;
/

DROP FUNCTION fn_get_codeid_symbol
/

CREATE OR REPLACE 
FUNCTION fn_get_codeid_symbol (p_symbol in varchar2) RETURN VARCHAR2 AS
l_codeid    varchar(255);
BEGIN
   select autoid into l_codeid
            from assetdtl a
            where a.symbol= p_symbol;

            RETURN l_codeid;
END FN_GET_CODEID_SYMBOL;
/

DROP FUNCTION fn_get_content_by_imgtype
/

CREATE OR REPLACE 
FUNCTION fn_get_content_by_imgtype (p_type varchar2, p_language varchar2 DEFAULT 'vie')
 RETURN varchar2
 IS


    l_desc   varchar2(2000);

BEGIN

    if p_type is null then
        return 'Loai giay to chua duoc dinh nghia';
    else
       select (case when p_language ='vie' then a.cdcontent else a.en_cdcontent end) imgtype into l_desc
       from allcode a where a.cdtype='CF' and a.cdname='IMGTYPE' and a.cdval= p_type;
        RETURN l_desc;
    end if;

Exception
When others then
    return 'Loai giay to chua duoc dinh nghia';
END

;
/

DROP FUNCTION fn_get_country_2006
/

CREATE OR REPLACE 
FUNCTION fn_get_country_2006 (p_SID varchar2)
  return string is
  v_country varchar2(500);
BEGIN

  SELECT A.CDCONTENT
    into v_country
    FROM CFMASTER CF, ALLCODE A
   WHERE CF.COUNTRY = A.CDVAL
     AND A.CDNAME = 'COUNTRY'
     and a.cdtype = 'CF'
     AND SID = p_SID;
  RETURN v_country;
exception
  when others then
    return ' ';
end;
/

DROP FUNCTION fn_get_couponamt
/

CREATE OR REPLACE 
FUNCTION fn_get_couponamt (p_symbol varchar2, p_date date)
 RETURN number
 
as
    l_return number;
begin
    select /*c.amount +*/ round(c.intrate * ass.parvalue/100*(p_date - nvl(b.valuedt, ass.opndate - 1) - 1)/case when ass.intbaseddofy = 'N' then 360 else 365 end, 0) 
    into l_return
    from --payment_hist a
    --inner join 
    assetdtl ass --on a.symbol = ass.symbol
    left join
    (select b.symbol, max(b.valuedt) valuedt from payment_hist b where b.valuedt < p_date and paytype = 'INT' group by b.symbol) b
    on ass.symbol = b.symbol --and a.valuedt = b.valuedt
    inner join
    (   
        select a.symbol, a.intrate
        from payment_hist a, 
             (select b.symbol, min(b.valuedt) valuedt from payment_hist b where b.valuedt >= p_date and paytype = 'INT' group by b.symbol) b
        where a.symbol = b.symbol and a.valuedt = b.valuedt and paytype = 'INT'
    ) c
    on ass.symbol = c.symbol
    where /*a.paytype = 'INT' and*/ ass.symbol = p_symbol;

    return round(l_return,0);
exception
    when others then
        return -1;
END;
/

DROP FUNCTION fn_get_couponamt_received
/

CREATE OR REPLACE 
FUNCTION fn_get_couponamt_received (p_symbol varchar2, p_date date)
 RETURN number
as
    l_return number;
    l_cnt number;
begin

    select count(1) into l_cnt
    from payment_hist b
    where b.valuedt <= p_date
        and paytype = 'INT'
        and b.symbol = p_symbol;

    if l_cnt > 0 then
        select sum(b.amount) into l_return
        from payment_hist b
        where b.valuedt <= p_date
            and paytype = 'INT'
            and b.symbol = p_symbol;
    else
        l_return := 0;
    end if;

    return round(nvl(l_return, 0),0);
exception
    when others then
        return 0;
END;
/

DROP FUNCTION fn_get_custid_by_custodycd
/

CREATE OR REPLACE 
FUNCTION fn_get_custid_by_custodycd (p_custodycd in varchar2) RETURN VARCHAR2 AS 
l_custid    varchar(255);
BEGIN
   select custid into l_custid
            from cfmast cf
            where cf.custodycd = p_custodycd;
            
            RETURN l_custid;
END FN_GET_CUSTID_BY_CUSTODYCD;
/

DROP FUNCTION fn_get_custtype_2006
/

CREATE OR REPLACE 
FUNCTION fn_get_custtype_2006 (p_SID varchar2)
  return string is
  v_custtype varchar2(500);
BEGIN

  SELECT A.CDCONTENT
    into v_custtype
    FROM CFMASTER CF, ALLCODE A
   WHERE CF.CUSTTYPE = A.CDVAL
     AND A.CDNAME = 'CUSTTYPE'
     and a.cdtype = 'CF'
     AND CF.SID = p_SID;
  RETURN v_custtype;
exception
  when others then
    return ' ';
end;
/

DROP FUNCTION fn_get_date_by_termcd
/

CREATE OR REPLACE 
FUNCTION fn_get_date_by_termcd (p_termcd varchar2, p_value number)
 RETURN date

as
    l_return date;
BEGIN

    if p_termcd='M' then
    l_return:= ADD_MONTHS(getcurrdate,p_value);
    end if;
    if p_termcd='W' then
    l_return:= getcurrdate + p_value * 7 ;
    end if;
    if p_termcd='D' then
    l_return:= getcurrdate + p_value ;
    end if;
    return l_return;
exception
    when others then
        return to_date('01/01/2999','dd/mm/yyyy');
END;
/

DROP FUNCTION fn_get_date_payment
/

CREATE OR REPLACE 
FUNCTION fn_get_date_payment (p_date varchar2, p_count number )
 RETURN date
 IS


    l_date_return   date;

BEGIN

    IF p_count > 0 then
         SELECT SBDATE  into l_date_return FROM (
             select  ROWNUM stt,a.sbdate
                    from (
                    SELECT sbdate FROM sbcldr
                    where sbdate > to_date(p_date,'dd/mm/yyyy')
                    and holiday = 'N'
                    ORDER BY SBDATE 
                    ) a)
            WHERE  stt = p_count; 

    ELSIF p_count = 0 then
        l_date_return :=  to_date(p_date,'dd/mm/yyyy');

    ELSE
    SELECT SBDATE  into l_date_return
    FROM (
         select  ROWNUM stt,a.sbdate
                from (
                SELECT sbdate FROM sbcldr
                where sbdate < to_date(p_date,'dd/mm/yyyy')
                and holiday = 'N'
                ORDER BY SBDATE desc
                ) a)
        WHERE  stt = ABS(p_count);


    END IF;
    RETURN l_date_return;

Exception
When others then
    return '-1';
END

;
/

DROP FUNCTION fn_get_dlpp
/

CREATE OR REPLACE 
FUNCTION fn_get_dlpp (p_acount      varchar2
                                          )
  return string is
  v_fullname varchar2(500);
  v_count    number;

BEGIN

    Select DISTINCT(d.cdcontent) into v_fullname  from cfmast cf,roles r,allcode d   where cf.dbcode = r.dbcode and cf.custodycd = p_acount
    and d.cdname = 'ROLECODE' and d.cdval = r.rolecode;
    RETURN v_fullname;
exception
  when others then
    return ' ';
end;
/

DROP FUNCTION fn_get_dstatus_by_lev
/

CREATE OR REPLACE 
FUNCTION fn_get_dstatus_by_lev 
    (
     pv_tltxcd IN VARCHAR2,
     pv_numLev IN NUMBER)
   RETURN VARCHAR2
IS
    l_return VARCHAR2(100);
    l_count NUMBER;
    l_dstatus VARCHAR2(10);
BEGIN
    l_dstatus :='';
    IF INSTR('9999/9998/9997',pv_tltxcd)>0 THEN
            RETURN 'D1D2S1S2C1C2V1V2';
    END IF;

    BEGIN
        SELECT DSTATUS INTO l_dstatus FROM tltxwf WHERE tltxcd = pv_tltxcd AND lvel = pv_numLev;
    EXCEPTION WHEN OTHERS THEN
        l_dstatus :='';
    END;
    RETURN l_dstatus;
EXCEPTION WHEN OTHERS THEN
    RETURN '';
END;
/

DROP FUNCTION fn_get_duedate_of_deal
/

CREATE OR REPLACE 
FUNCTION fn_get_duedate_of_deal (p_autoid number)
 RETURN date
 
as
            l_duedate   date;
            l_product_id    number;
            l_orgdate       date;
            l_termval       number;
            l_temp_date     date;
        BEGIN
            -- layra id cua product 
            select o.productid, o.orgdate, a.duedate into l_product_id, l_orgdate, l_duedate
            from oxmast o inner join  assetdtl a on o.symbol = a.symbol
            where o.autoid = p_autoid;
           -- lay ra termval
            select p.termval into l_termval
            from product p
            where p.autoid = l_product_id; 
           --tinh ra ngay dao han
            if (l_product_id=0) then
                return l_duedate;
            else
            -- voi nhung th productid = 0 thi termval = null nen phai them lenh nay
                if (l_termval is null) then l_termval:= 0; end if;
--              l_termval:=concat(l_termval, ' month');
                l_temp_date:= ADD_MONTHS(l_orgdate, l_termval);
                return least(l_temp_date, l_duedate);-- lay ra ngay dao han thuc
--              if (getcurrdate()<=l_temp_date) then
--                  return l_temp_date;
--              else
--                  return l_duedate;
--              end if;
            end if;
--           return 1;
        END;
/

