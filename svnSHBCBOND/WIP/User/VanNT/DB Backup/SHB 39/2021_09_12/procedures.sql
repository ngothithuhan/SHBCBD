DROP PROCEDURE add_year_4fund
/

CREATE OR REPLACE 
PROCEDURE add_year_4fund 
   ( pv_strNewYear IN VARCHAR2, pv_strHoliday IN VARCHAR2,pv_strfund in VARCHAR2)
IS
-- Purpose: Add a new year
-- MODIFICATION HISTORY
-- Person      Date        Comments
-- NAMNT      01/01/2018
-- ---------   ------  -------------------------------------------
   FIRST_DAY_MONTH CONSTANT VARCHAR2(11) := '01/01/';
   MONTH_COUNT CONSTANT INT := 12;
   v_dCurDate Date;
   v_dCurMonth Int;
   v_strSBBUSDAY VARCHAR2(1);
   v_strSBEOW VARCHAR2(1);
   v_strSBEOM VARCHAR2(1);
   v_strSBEOQ VARCHAR2(1);
   v_strSBEOY VARCHAR2(1);
   v_strSBBOW VARCHAR2(1);
   v_strSBBOM VARCHAR2(1);
   v_strSBBOQ VARCHAR2(1);
   v_strSBBOY VARCHAR2(1);
   v_strHOLIDAY VARCHAR2(1);
   v_strFirstDayOfWeek VARCHAR2(1);
   v_strLastDayOfWeek VARCHAR2(1);
   v_iTmp Int;
   v_bCheck Boolean;
   v_bTmp Boolean;
   v_bCheckFirstDayOfWeek Boolean;
   v_strYearHoliday  VARCHAR2(100);
   v_strCLDRTYPE VARCHAR2(20);
   pkgctx   plog.log_ctx;
   l_Log_Info varchar2 (2000);
   l_err_code varchar2(100);
BEGIN
    --Init session
    plog.setbeginsection (pkgctx, 'add_year_4fund');
    plog.info(pkgctx, l_Log_Info);
    v_strCLDRTYPE := pv_strfund;
    -- Xac dinh ngay dau tuan
    v_iTmp := 1;
    v_bCheck := false;
    WHILE v_bCheck = false
    LOOP
        IF INSTR(pv_strHoliday, to_char(v_iTmp)) > 0 THEN
            v_iTmp := v_iTmp + 1;
        ELSE
            v_bCheck := true;
            v_strFirstDayOfWeek := to_char(v_iTmp);
        END IF;
    END LOOP;
    -- Xac dinh ngay cuoi tuan
    v_iTmp := 7;
    v_bCheck := false;
    WHILE v_bCheck = false
    LOOP
        IF INSTR(pv_strHoliday, to_char(v_iTmp)) > 0 THEN
            v_iTmp := v_iTmp - 1;
        ELSE
            v_bCheck := true;
            v_strLastDayOfWeek := to_char(v_iTmp);
        END IF;
    END LOOP;

        -- Khoi tao ngay dau cua nam 01/01
        v_dCurDate := to_date(concat(FIRST_DAY_MONTH,pv_strNewYear),'dd/mm/rrrr');

        SELECT COUNT(*) INTO v_iTmp FROM SBCLDR
        WHERE to_number(Convert_dayofweek(to_char(SBDATE,'day'))) < to_number(Convert_dayofweek(to_char(v_dCurDate,'day')))
        AND SBDATE < v_dCurDate
        AND v_dCurDate - SBDATE <= 6 AND HOLIDAY = 'N' AND CLDRTYPE = v_strCLDRTYPE;

        IF v_iTmp > 0 THEN
            v_bCheckFirstDayOfWeek := true;
        ELSE
            v_bCheckFirstDayOfWeek := false;
        END IF;

        FOR v_dCurMonth IN 1..MONTH_COUNT
        LOOP
            -- Da xac dinh duoc ngay dau thang
            v_bCheck := false;
            WHILE to_char(v_dCurDate, 'mm') = replace(to_char(v_dCurMonth,'09'),' ','')
            LOOP
                SELECT COUNT(*) INTO v_iTmp FROM SBCLDR
                WHERE CLDRTYPE = v_strCLDRTYPE
                AND SBDATE = v_dCurDate;
                IF v_iTmp <= 0 THEN
                    v_strSBBUSDAY := 'N';
                    v_strSBBOW := 'N';
                    v_strSBBOM := 'N';
                    v_strSBBOQ := 'N';
                    v_strSBBOY := 'N';
                    v_strSBEOW := 'N';
                    v_strSBEOM := 'N';
                    v_strSBEOQ := 'N';
                    v_strSBEOY := 'N';
                    v_strHOLIDAY := 'N';

                    -- Co phai ngay nghi khong
                    IF INSTR(v_strYearHoliday, CONCAT(CONCAT('#',to_char(v_dCurDate, 'dd/mm')),'#')) > 0 THEN
                        v_strHOLIDAY := 'Y';
                    END IF;
                    -- Co phai la ngay dau tuan hay cuoi tuan khong
                    IF Convert_dayofweek(to_char(v_dCurDate,'day')) = v_strFirstDayOfWeek THEN
                        IF v_strHOLIDAY = 'N' THEN
                            v_strSBBOW := 'Y';
                            v_bCheckFirstDayOfWeek := true;
                        END IF;
                    ELSIF Convert_dayofweek(to_char(v_dCurDate,'day')) = v_strLastDayOfWeek THEN
                        v_bCheckFirstDayOfWeek := false;
                        IF v_strHOLIDAY = 'N' THEN
                            v_strSBEOW := 'Y';
                        ELSE
                            UPDATE SBCLDR SET SBEOW = 'Y'
                            WHERE HOLIDAY = 'N'
                            AND (v_dCurDate - SBDATE) = (SELECT min(v_dCurDate - SBDATE) FROM SBCLDR
                                                        WHERE to_number(Convert_dayofweek(to_char(SBDATE,'day'))) < to_number(v_strLastDayOfWeek))
                            AND CLDRTYPE = v_strCLDRTYPE;
                        END IF;
                    -- Neu khong thi co phai ngay nghi khong
                    ELSIF INSTR(pv_strHoliday, Convert_dayofweek(to_char(v_dCurDate,'day'))) > 0 THEN
                        v_strHOLIDAY := 'Y';
                    ELSIF v_bCheckFirstDayOfWeek = false THEN
                        v_strSBBOW := 'Y';
                    END IF;
                    -- Ngay dau thang
                    IF v_bCheck = false THEN
                        IF v_strHOLIDAY = 'N' THEN
                            v_strSBBOM := 'Y';
                            v_bCheck := true;
                        END IF;
                    END IF;
                    -- Ngay cuoi thang
                    IF v_strHOLIDAY = 'N' THEN
                        IF v_dCurDate = LAST_DAY(v_dCurDate) THEN
                            v_strSBEOM := 'Y';
                        ELSE
                            --IF to_char(v_dCurDate + 1, 'dd') = '1' THEN
                            IF v_dCurDate + 1 = LAST_DAY(v_dCurDate) + 1 THEN
                                v_strSBEOM := 'Y';
                            ELSE
                                v_bTmp := false;
                                v_iTmp := 1;
                                WHILE v_bTmp = false
                                LOOP
                                    IF INSTR(pv_strHoliday, Convert_dayofweek(to_char(v_dCurDate + v_iTmp, 'day'))) > 0 THEN
                                        v_iTmp := v_iTmp + 1;
                                    ELSIF to_number(to_char(v_dCurDate + v_iTmp,'dd')) < to_number(to_char(v_dCurDate,'dd')) THEN
                                        v_bTmp := true;
                                        v_strSBEOM := 'Y';
                                    ELSIF INSTR(v_strYearHoliday, to_char(v_dCurDate + v_iTmp,'dd/mm')) > 0 THEN
                                        v_iTmp := v_iTmp + 1;
                                    ELSE
                                        v_bTmp := true;
                                    END IF;
                                END LOOP;
                            END IF;
                        END IF;
                    END IF;
                    -- Ngay dau quy, dau nam
                    IF v_strSBBOM = 'Y' THEN
                        IF v_dCurMonth = 4 or v_dCurMonth = 7 or v_dCurMonth = 10 THEN
                            v_strSBBOQ := 'Y';
                        ELSIF v_dCurMonth = 1 THEN
                            v_strSBBOQ := 'Y';
                            v_strSBBOY := 'Y';
                        END IF;
                    END IF;

                    IF v_strSBEOM = 'Y' THEN
                        IF v_dCurMonth = 3 or v_dCurMonth = 6 or v_dCurMonth = 9 THEN
                            v_strSBEOQ := 'Y';
                        ELSIF v_dCurMonth = 12 THEN
                            v_strSBEOQ := 'Y';
                            v_strSBEOY := 'Y';
                        END IF;
                    END IF;
                    INSERT INTO SBCLDR (Autoid,SBDATE,SBBUSDAY,SBBOW,SBBOM,SBBOQ,SBBOY,SBEOW,SBEOM,SBEOQ,SBEOY,HOLIDAY,CLDRTYPE)
                    VALUES (seq_SBCLDR.NEXTVAL,v_dCurDate,v_strSBBUSDAY,v_strSBBOW,v_strSBBOM,v_strSBBOQ,v_strSBBOY,v_strSBEOW,v_strSBEOM,v_strSBEOQ,v_strSBEOY,v_strHOLIDAY,v_strCLDRTYPE);

                END IF;
                v_dCurDate := v_dCurDate + 1;

            END LOOP;
        END LOOP;

        update sbcldr
        set holiday = 'Y'
        where extract(year FROM SBDATE) = pv_strNewYear
        and to_char(SBDATE, 'Dy') = 'Sun';

   plog.setendsection (pkgctx, 'ADD_YEAR_4FUND');
EXCEPTION
   WHEN OTHERS THEN
        BEGIN
            rollback;
            raise;
            dbms_output.put_line('Error... ');
            l_err_code := errnums.C_SYSTEM_ERROR;
            --Log when error
            --log trace if exception, log error code if handle
            plog.error (pkgctx, '[SQLERRM] ' || SQLERRM); --Log trace exception
            plog.error (pkgctx, '[p_err_code]=' || l_err_code); --Log error code why handle
            plog.error (pkgctx, '[Format_error_backtrace] ' || dbms_utility.format_error_backtrace); --Log trace
            plog.error (pkgctx, l_Log_Info);  --Log infor for bugging
            plog.setendsection (pkgctx, 'ADD_YEAR_4FUND');
            return;
        END;
END;
/

DROP PROCEDURE add_year
/

CREATE OR REPLACE 
PROCEDURE add_year
   ( pv_strNewYear IN VARCHAR2, pv_strHoliday IN VARCHAR2,pv_strfund in VARCHAR2)
IS
-- Purpose: Add a new year
-- MODIFICATION HISTORY
-- Person      Date        Comments
-- NAMNT      01/01/2018
-- ---------   ------  -------------------------------------------
   v_strCLDRTYPE VARCHAR2(20);
   --Lay danh sach ma quy cho truong hop type = ALL
   CURSOR curCLDRTYPEFUND IS SELECT '000' codeid FROM dual /* UNION ALL SELECT codeid from fund WHERE status ='A'*/;
   pkgctx   plog.log_ctx;
BEGIN
    --Init session
    plog.setbeginsection (pkgctx, 'ADD_YEAR');
    --TYPE = ALL
    IF pv_strfund =  '000' THEN
        OPEN curCLDRTYPEFUND;
        LOOP
            FETCH curCLDRTYPEFUND INTO v_strCLDRTYPE;
            EXIT WHEN curCLDRTYPEFUND%NOTFOUND;
            --Sinh lich he thong 000
            add_year_4fund(pv_strNewYear,pv_strHoliday,v_strCLDRTYPE);
        END LOOP;
    /*ELSE
        --Sinh lich cho ma quy
        add_year_4fund(pv_strNewYear,pv_strHoliday,pv_strfund); */
    END IF;
     --gen lich cho quy
     /*FOR REC IN (SELECT codeid from fund WHERE status ='A')
       LOOP
         BEGIN
            update_year_4sip(pv_strNewYear, '', REC.CODEID, 'NOMARL');
            update_year_4sip(pv_strNewYear, '', REC.CODEID, 'SIP');
         EXCEPTION WHEN OTHERS THEN
            plog.error (pkgctx, 'loi gen lich cho quy: ' || REC.CODEID); --Log trace exception
            plog.error (pkgctx, '[Format_error_backtrace] ' || dbms_utility.format_error_backtrace); --Log trace
         END;
     END LOOP;*/
    plog.setendsection (pkgctx, 'ADD_YEAR');
EXCEPTION
   WHEN OTHERS THEN
        BEGIN
            rollback;
            --Log when error
            --log trace if exception, log error code if handle
            plog.error (pkgctx, '[SQLERRM] ' || SQLERRM); --Log trace exception
            plog.error (pkgctx, '[Format_error_backtrace] ' || dbms_utility.format_error_backtrace); --Log trace
            plog.setendsection (pkgctx, 'ADD_YEAR');
            return;
        END;
END;
/

DROP PROCEDURE create_report
/

CREATE OR REPLACE 
PROCEDURE create_report 
   (
   pv_rptid IN VARCHAR2,
   pv_rptparams IN VARCHAR2,
   p_err_code IN OUT VARCHAR2
   )
IS
--Tao bao cao xml, in queue
--pv_rptparams : (:l_refcursor,tlid=>'0001',brid=>'000001',pv_tradingid=>'ALL')
    l_count NUMBER;
    pkgctx   plog.log_ctx;
    l_sql VARCHAR2(4000);
    l_refcursor pkg_report.ref_cursor;
    l_cursor_number NUMBER;
    l_xml_data xmldom.domdocument;
    tmp_text_message   SYS.AQ$_JMS_TEXT_MESSAGE;
    eopt               DBMS_AQ.enqueue_options_t;
    mprop              DBMS_AQ.message_properties_t;
    tmp_encode_text    VARCHAR2 (32767);
    ownerschema VARCHAR2(100);
    enq_msgid  RAW(16);
    l_msg_clob CLOB;
BEGIN
    plog.setbeginsection (pkgctx, 'CREATE_REPORT');
    p_err_code :=systemnums.C_SUCCESS;
    --goi thu tuc lay du lieu bao cao
    l_sql :='BEGIN ' || pv_rptid || pv_rptparams || '; END;';
    plog.error (pkgctx, 'l_sql:'||l_sql);
    EXECUTE IMMEDIATE l_sql USING IN OUT l_refcursor;

    --parse refcursor ra xml
    l_xml_data := fn_parse_cursor_xml(l_refcursor);
    --in queue
    select sys_context('USERENV', 'CURRENT_SCHEMA') INTO ownerschema from dual;

    --queue
    IF NOT DBMS_XMLDOM.ISNULL(l_xml_data) THEN
        tmp_text_message := SYS.AQ$_JMS_TEXT_MESSAGE.construct;
        xmldom.writetobuffer(l_xml_data,tmp_encode_text);
        --xmldom.writetobuffer(l_xml_data,l_msg_clob);
        -- plog.error (pkgctx, 'tmp_encode_text:'||tmp_encode_text);
        tmp_text_message.set_text(tmp_encode_text);
        DBMS_AQ.ENQUEUE(queue_name         => ownerschema ||
                                              '.REPORT_QUEUE',
                        enqueue_options    => eopt,
                        message_properties => mprop,
                        payload            => tmp_text_message,
                        msgid              => enq_msgid);
        --xml
        /*DBMS_AQ.ENQUEUE(queue_name         => ownerschema ||
                                              '.REPORT_QUEUE_XML',
                        enqueue_options    => eopt,
                        message_properties => mprop,
                        payload            => TO_CHAR(l_msg_clob),
                        msgid              => enq_msgid);*/
    ELSE
        p_err_code :='-100078';
    END IF;

    --ghi ra file
    --DBMS_XMLDOM.WRITETOFILE(l_xml_data, 'REPORT_DATA/sr0002.xml');


    plog.setendsection (pkgctx, 'CREATE_REPORT');
EXCEPTION
   WHEN OTHERS THEN
   p_err_code := errnums.C_SYSTEM_ERROR;
   plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
   plog.setendsection (pkgctx, 'CREATE_REPORT');
END;
/

DROP PROCEDURE create_report_req
/

CREATE OR REPLACE 
PROCEDURE create_report_req 
   (
        PV_REFCURSOR IN OUT PKG_REPORT.REF_CURSOR,
        pv_rptid IN VARCHAR2,
        pv_rptparams IN VARCHAR2
   )
IS
    --pv_rptparams : (:l_refcursor,tlid=>'0001',brid=>'000001',pv_tradingid=>'ALL')
    l_sql VARCHAR2(4000);
    l_cursor_number NUMBER;
    pkgctx   plog.log_ctx;
BEGIN
    plog.setbeginsection (pkgctx, 'CREATE_REPORT_REQ');
    --goi thu tuc lay du lieu bao cao
    l_sql :='BEGIN ' || pv_rptid || pv_rptparams || '; END;';
    EXECUTE IMMEDIATE l_sql USING IN OUT PV_REFCURSOR;
    plog.setendsection (pkgctx, 'CREATE_REPORT_REQ');
EXCEPTION
   WHEN OTHERS THEN
   plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
   plog.setendsection (pkgctx, 'CREATE_REPORT_REQ');
END;
/

DROP PROCEDURE fab06qm_11
/

CREATE OR REPLACE 
PROCEDURE fab06qm_11 (
   PV_REFCURSOR    IN OUT PKG_REPORT.REF_CURSOR,
   PV_TLID         IN     VARCHAR2,
   PV_BRID         IN     VARCHAR2,
   PV_ROLECODE     IN     VARCHAR2,
   V_SIDChiNhanh   IN     VARCHAR2,
   PV_YEAR         IN     VARCHAR2)
IS
   p_CCQID         VARCHAR2 (10);
   p_SIDChiNhanh   VARCHAR2 (20);
   V_NAME          VARCHAR2 (300);
   V_MBNAME        VARCHAR2 (500);
   v_ntodate       DATE;
   v_n_1todate     DATE;
   v_n_1fromdate   DATE;
   v_minnavccq     NUMBER (20, 2);
   v_maxnavccq     NUMBER (20, 2);
BEGIN
   v_ntodate := TO_DATE ('31/12/' || PV_YEAR, 'DD/mm/RRRR');
   v_n_1todate :=
      TO_DATE ('31/12/' || TO_CHAR (TO_NUMBER (PV_YEAR) - 1), 'DD/mm/RRRR');

   SELECT d.name, m.mbname
     INTO V_NAME, V_MBNAME
     FROM fund d, MEMBERS m
    WHERE m.mbcode = d.fmcode AND d.symbol = V_SIDChiNhanh;

   SELECT codeid
     INTO p_SIDChiNhanh
     FROM fund d
    WHERE d.symbol = V_SIDChiNhanh;

   SELECT D.FMCODE
     INTO p_CCQID
     FROM FUND D
    WHERE D.CODEID = p_SIDChiNhanh;

   --
   OPEN PV_REFCURSOR FOR
      SELECT 'A1' TYPE,
             'B1' fullname,
             0 nts,
             0 nts1
        FROM DUAL
      UNION ALL
      SELECT 'A2' TYPE,
             'B2' fullname,
             0 nts,
             0 nts1
        FROM DUAL
      UNION ALL
      SELECT 'A3' TYPE,
             'B3' fullname,
             0 nts,
             0 nts1
        FROM DUAL
      UNION ALL
      SELECT 'A4' TYPE,
             'B4' fullname,
             0 nts,
             0 nts1
        FROM DUAL
      UNION ALL
      SELECT 'A4' TYPE,
             'B5' fullname,
             0 nts,
             0 nts1
        FROM DUAL;
END;
/

DROP PROCEDURE fab06qm_12
/

CREATE OR REPLACE 
PROCEDURE fab06qm_12 (
   PV_REFCURSOR    IN OUT PKG_REPORT.REF_CURSOR,
   PV_TLID         IN     VARCHAR2,
   PV_BRID         IN     VARCHAR2,
   PV_ROLECODE     IN     VARCHAR2,
   V_SIDChiNhanh   IN     VARCHAR2,
   PV_YEAR         IN     VARCHAR2)
IS
   p_CCQID         VARCHAR2 (10);
   p_SIDChiNhanh   VARCHAR2 (20);
   V_NAME          VARCHAR2 (300);
   V_MBNAME        VARCHAR2 (500);
   v_ntodate       DATE;
   v_n_1todate     DATE;
   v_n_1fromdate   DATE;
   v_minnavccq     NUMBER (20, 2);
   v_maxnavccq     NUMBER (20, 2);
BEGIN
   v_ntodate := TO_DATE ('31/12/' || PV_YEAR, 'DD/mm/RRRR');
   v_n_1todate :=
      TO_DATE ('31/12/' || TO_CHAR (TO_NUMBER (PV_YEAR) - 1), 'DD/mm/RRRR');

   SELECT d.name, m.mbname
     INTO V_NAME, V_MBNAME
     FROM fund d, MEMBERS m
    WHERE m.mbcode = d.fmcode AND d.symbol = V_SIDChiNhanh;

   SELECT codeid
     INTO p_SIDChiNhanh
     FROM fund d
    WHERE d.symbol = V_SIDChiNhanh;

   SELECT D.FMCODE
     INTO p_CCQID
     FROM FUND D
    WHERE D.CODEID = p_SIDChiNhanh;

   --
   OPEN PV_REFCURSOR FOR SELECT '' blq, '' mqh FROM DUAL;
END;
/

DROP PROCEDURE fab06qm_13
/

CREATE OR REPLACE 
PROCEDURE fab06qm_13 (
   PV_REFCURSOR    IN OUT PKG_REPORT.REF_CURSOR,
   PV_TLID         IN     VARCHAR2,
   PV_BRID         IN     VARCHAR2,
   PV_ROLECODE     IN     VARCHAR2,
   V_SIDChiNhanh   IN     VARCHAR2,
   PV_YEAR         IN     VARCHAR2)
IS
   p_CCQID         VARCHAR2 (10);
   p_SIDChiNhanh   VARCHAR2 (20);
   V_NAME          VARCHAR2 (300);
   V_MBNAME        VARCHAR2 (500);
   v_ntodate       DATE;
   v_n_1todate     DATE;
   v_n_1fromdate   DATE;
   v_minnavccq     NUMBER (20, 2);
   v_maxnavccq     NUMBER (20, 2);
BEGIN
   v_ntodate := TO_DATE ('31/12/' || PV_YEAR, 'DD/mm/RRRR');
   v_n_1todate :=
      TO_DATE ('31/12/' || TO_CHAR (TO_NUMBER (PV_YEAR) - 1), 'DD/mm/RRRR');

   SELECT d.name, m.mbname
     INTO V_NAME, V_MBNAME
     FROM fund d, MEMBERS m
    WHERE m.mbcode = d.fmcode AND d.symbol = V_SIDChiNhanh;

   SELECT codeid
     INTO p_SIDChiNhanh
     FROM fund d
    WHERE d.symbol = V_SIDChiNhanh;

   SELECT D.FMCODE
     INTO p_CCQID
     FROM FUND D
    WHERE D.CODEID = p_SIDChiNhanh;

   --
   OPEN PV_REFCURSOR FOR SELECT '' ndgd, 0 amt, 0 amt1 FROM DUAL;
END;
/

DROP PROCEDURE fas03qm
/

CREATE OR REPLACE 
PROCEDURE fas03qm (
   PV_REFCURSOR    IN OUT PKG_REPORT.REF_CURSOR,
   PV_TLID         IN     VARCHAR2,
   PV_BRID         IN     VARCHAR2,
   PV_ROLECODE     IN     VARCHAR2,
   V_SIDChiNhanh   IN     VARCHAR2,
   p_TuNgay        IN     VARCHAR2,
   p_DenNgay       IN     VARCHAR2)
IS
   l_fromDate      DATE := TO_DATE (p_TuNgay, 'dd/MM/rrrr');
   l_toDate        DATE := TO_DATE (p_DenNgay, 'dd/MM/rrrr');
   p_CCQID         VARCHAR2 (10);
   p_SIDChiNhanh   VARCHAR2 (20);
   V_NAME          VARCHAR2 (300);
   V_MBNAME        VARCHAR2 (500);
BEGIN
   SELECT d.name, m.mbname
     INTO V_NAME, V_MBNAME
     FROM fund d, MEMBERS m
    WHERE m.mbcode = d.fmcode AND d.symbol = V_SIDChiNhanh;

   SELECT codeid
     INTO p_SIDChiNhanh
     FROM fund d
    WHERE d.symbol = V_SIDChiNhanh;

   SELECT D.FMCODE
     INTO p_CCQID
     FROM FUND D
    WHERE D.CODEID = p_SIDChiNhanh;

   OPEN PV_REFCURSOR FOR
      SELECT TO_CHAR (t.txdate, 'dd/MM/rrrr') txdate,
             t.txnum,
             t.txdesc,
             t.refsymbol,
             d.fullname_vn,
             t.txqtty,
             t.txamt,
             CASE
                WHEN t.txqtty <> 0 THEN ROUND (t.txamt / t.txqtty, 2)
                ELSE 0
             END
                price,
             V_NAME V_NAME,
             V_MBNAME V_MBNAME,
             p_TuNgay p_TuNgay,
             p_DenNgay p_DenNgay
        FROM FASFNOTICETX t,(SELECT SYMBOL,fullname_vn FROM  instrlist where 1=1 group by SYMBOL,fullname_vn) d
       WHERE     
             d.symbol = t.refsymbol
             AND t.txbors = 'B'                                         -- MUA
             AND t.fundcodeid = p_SIDChiNhanh
             AND t.txdate >= l_fromDate
             AND t.txdate <= l_toDate;
END;
/

DROP PROCEDURE fas04qm
/

CREATE OR REPLACE 
PROCEDURE fas04qm (
   PV_REFCURSOR    IN OUT PKG_REPORT.REF_CURSOR,
   PV_TLID         IN     VARCHAR2,
   PV_BRID         IN     VARCHAR2,
   PV_ROLECODE     IN     VARCHAR2,
   V_SIDChiNhanh   IN     VARCHAR2,
   p_TuNgay        IN     VARCHAR2,
   p_DenNgay       IN     VARCHAR2)
IS
   l_fromDate      DATE := TO_DATE (p_TuNgay, 'dd/MM/rrrr');
   l_toDate        DATE := TO_DATE (p_DenNgay, 'dd/MM/rrrr');
   p_CCQID         VARCHAR2 (10);
   p_SIDChiNhanh   VARCHAR2 (20);
   V_NAME          VARCHAR2 (300);
   V_MBNAME        VARCHAR2 (500);
BEGIN
   SELECT d.name, m.mbname
     INTO V_NAME, V_MBNAME
     FROM fund d, MEMBERS m
    WHERE m.mbcode = d.fmcode AND d.symbol = V_SIDChiNhanh;

   SELECT codeid
     INTO p_SIDChiNhanh
     FROM fund d
    WHERE d.symbol = V_SIDChiNhanh;

   SELECT D.FMCODE
     INTO p_CCQID
     FROM FUND D
    WHERE D.CODEID = p_SIDChiNhanh;

   OPEN PV_REFCURSOR FOR
      SELECT TO_CHAR (t.txdate, 'dd/MM/rrrr') txdate,
             t.txnum,
             t.txdesc,
             t.refsymbol,
             d.fullname_vn,
             t.txqtty,
             t.txamt,
             CASE
                WHEN t.txqtty <> 0 THEN ROUND (t.txamt / t.txqtty, 2)
                ELSE 0
             END
                price,
             V_NAME V_NAME,
             V_MBNAME V_MBNAME,
             p_TuNgay p_TuNgay,
             p_DenNgay p_DenNgay
        FROM FASFNOTICETX t,(select symbol,fullname_vn from  instrlist where 1=1 group by symbol,fullname_vn) d
       WHERE     
             d.symbol = t.refsymbol
             AND t.txbors = 'S'                                         -- ban
             AND t.fundcodeid = p_SIDChiNhanh
             AND t.txdate >= l_fromDate
             AND t.txdate <= l_toDate;
END;
/

DROP PROCEDURE gagag
/

CREATE OR REPLACE 
PROCEDURE gagag 
(
  PARAM1 IN VARCHAR2 
, PARAM2 OUT VARCHAR2 
) AS 
BEGIN
  insert into draff_phong values(param1);
END GAGAG;
/

DROP PROCEDURE getbalance
/

CREATE OR REPLACE 
PROCEDURE getbalance 
   ( PV_REFCURSOR IN OUT VARCHAR2,
        pv_afacctno IN VARCHAR2)
   IS
--
-- To modify this template, edit file PROC.TXT in TEMPLATE
-- directory of SQL Navigator
--
-- Purpose: Briefly explain the functionality of the procedure
--
-- MODIFICATION HISTORY
-- Person      Date    Comments
-- ---------   ------  -------------------------------------------
   variable_name        NUMBER;
   -- Declare program variables as shown above
BEGIN
    PV_REFCURSOR:=pv_afacctno;
  EXCEPTION
        WHEN OTHERS THEN PV_REFCURSOR := 'error' ;
END; -- Procedure
/

DROP PROCEDURE insert_cfsign
/

CREATE OR REPLACE 
PROCEDURE insert_cfsign (
V_CUSTID varchar2, 
V_SIGNATURE CLOB, 
V_VALDATE varchar2, 
V_TYPE varchar2,
V_AUTOID NUMBER,
V_DESC varchar2) IS
v_custtype varchar2(1);
    BEGIN
        INSERT INTO CFSIGN (AUTOID, CUSTID, SIGNATURE, VALDATE, EXPDATE, DESCRIPTION,TYPE) VALUES
            (V_AUTOID, V_CUSTID, V_SIGNATURE, GETCURRDATE, GETCURRDATE, V_DESC, V_TYPE);

    END ;
/

DROP PROCEDURE insert_productbuydtl
/

CREATE OR REPLACE 
PROCEDURE insert_productbuydtl (p_buydtl varchar2,
                            p_autoid number,
                            p_err_code in out varchar2)
is

    pkgctx   plog.log_ctx;
    logrow   tlogdebug%ROWTYPE;
begin
    plog.setBeginSection(pkgctx, 'prc_sysprocess');

  FOR record
                IN (SELECT REGEXP_REPLACE (TRIM (fil.char_value),
                                           '\(|\)',
                                           '')
                               fil_cond
                      FROM (SELECT fn_pivot_string (
                                       REGEXP_REPLACE (p_buydtl, '~\$~', '|'))
                                       filter_row
                              FROM DUAL),
                           TABLE (filter_row) fil)
            LOOP
                INSERT INTO productbuydtl (autoid,
                                                    id,
                                                    termcd,
                                                    "FROM",
                                                    "TO",
                                                    "TYPE",
                                                    rate,
                                                    FEEBUY,
                                                    AMPLITUDE,
                                                    CALRATE_METHOD,
                                                    CALFEE_METHOD
                                                   )
                    SELECT SEQ_BUYDTL.NEXTVAL,
                           p_autoid,
                           b.TERMCD,
                           b."FROM",
                           B."TO",
                           b."TYPE",
                           to_number(B.RATE),
                            to_number( b.FEEBUY),
                           to_number(B.AMPLITUDE),
                           'F',
                            b.CALFEE_METHOD

                      FROM (SELECT *
                              FROM (WITH tmp
                                             AS (SELECT REGEXP_REPLACE (
                                                            TRIM (
                                                                fil.char_value),
                                                            '\(|\)',
                                                            '')
                                                            VALUE,
                                                        fil.rid
                                                   FROM (SELECT fn_pivot_string (
                                                                    REGEXP_REPLACE (
                                                                        record.fil_cond,
                                                                        '~\#~',
                                                                        '|'))
                                                                    filter_row
                                                           FROM DUAL),
                                                        TABLE (filter_row) fil)


                                    select *
                                        from (select * from
                                            (select value TERMCD from tmp t where t.rid = 1) t1,
                                            (select value "TYPE" from tmp t where t.rid = 2) t2,
                                            (select value "FROM" from tmp t where t.rid = 3) t3,
                                            (select value "TO" from tmp t where t.rid = 4) t4,
                                            (select value RATE from tmp t where t.rid = 5) t5,
                                            (select value AMPLITUDE from tmp t where t.rid = 6) t6,
                                            (select value CALFEE_METHOD from tmp t where t.rid = 7) t7,
                                            (select value FEEBUY from tmp t where t.rid = 8) t8
                                        )  ) ) b;
            END LOOP;


    p_err_code := '';
    plog.setEndSection(pkgctx, 'prc_sysprocess');
exception when others then
    p_err_code := errnums.C_SYSTEM_ERROR;
    RAISE;

end;
/

DROP PROCEDURE insert_productbuydtlmemo
/

CREATE OR REPLACE 
PROCEDURE insert_productbuydtlmemo (p_buydtl varchar2,
                            p_autoid number,
                            p_action varchar2,
                            p_err_code in out varchar2)
is

    pkgctx   plog.log_ctx;
    logrow   tlogdebug%ROWTYPE;
begin
    plog.setBeginSection(pkgctx, 'prc_sysprocess');

  FOR record
                    IN (SELECT REGEXP_REPLACE (TRIM (fil.char_value),
                                               '\(|\)',
                                               '')
                                   fil_cond
                          FROM (SELECT fn_pivot_string (
                                           REGEXP_REPLACE (p_buydtl, '~\$~', '|'))
                                           filter_row
                                  FROM DUAL),
                               TABLE (filter_row) fil)
                LOOP
                    INSERT INTO productbuydtlmemo (autoid,
                                                        id,
                                                        termcd,
                                                        "FROM",
                                                        "TO",
                                                        "TYPE",
                                                        rate,
                                                        feebuy,
                                                        AMPLITUDE,
                                                        CALRATE_METHOD,
                                                        CALFEE_METHOD,
                                                        ACTION,
                                                        STATUS)
                        SELECT SEQ_BUYDTL.NEXTVAL,
                               p_autoid,
                               b.TERMCD,
                               b."FROM",
                               B."TO",
                               b."TYPE",
                               to_number(B.RATE),
                               to_number(B.FEEBUY),
                               to_number(B.AMPLITUDE),
                               'F',
                               b.CALFEE_METHOD,
                               p_action,
                               'P'
                          FROM (SELECT *
                                  FROM (WITH tmp
                                                 AS (SELECT REGEXP_REPLACE (
                                                                TRIM (
                                                                    fil.char_value),
                                                                '\(|\)',
                                                                '')
                                                                VALUE,
                                                            fil.rid
                                                       FROM (SELECT fn_pivot_string (
                                                                        REGEXP_REPLACE (
                                                                            record.fil_cond,
                                                                            '~\#~',
                                                                            '|'))
                                                                        filter_row
                                                               FROM DUAL),
                                                            TABLE (filter_row) fil)


                                        select *
                                            from (select * from
                                                (select value TERMCD from tmp t where t.rid = 1) t1,
                                                (select value "TYPE" from tmp t where t.rid = 2) t2,
                                                (select value "FROM" from tmp t where t.rid = 3) t3,
                                                (select value "TO" from tmp t where t.rid = 4) t4,
                                                (select value RATE from tmp t where t.rid = 5) t5,
                                                (select value AMPLITUDE from tmp t where t.rid = 6) t6,
                                                (select value CALFEE_METHOD from tmp t where t.rid = 7) t7,
                                                (select value FEEBUY from tmp t where t.rid = 8) t8
                                            )  ) ) b;
                END LOOP;


    p_err_code := '';
    plog.setEndSection(pkgctx, 'prc_sysprocess');
exception when others then
    p_err_code := errnums.C_SYSTEM_ERROR;
    RAISE;

end;
/

DROP PROCEDURE insert_productcoupondtl
/

CREATE OR REPLACE 
PROCEDURE insert_productcoupondtl (p_coupondtl varchar2,
                            p_autoid number,
                            p_err_code in out varchar2)
is

    pkgctx   plog.log_ctx;
    logrow   tlogdebug%ROWTYPE;
begin
    plog.setBeginSection(pkgctx, 'prc_sysprocess');

 FOR record
                IN (SELECT REGEXP_REPLACE (TRIM (fil.char_value),
                                           '\(|\)',
                                           '')
                               fil_cond
                      FROM (SELECT fn_pivot_string (
                                       REGEXP_REPLACE (p_coupondtl, '~\$~', '|'))
                                       filter_row
                              FROM DUAL),
                           TABLE (filter_row) fil)
            LOOP
                INSERT INTO productcoupondtl (autoid,
                                                    id,
                                                    termcd,
                                                    "FROM",
                                                    "TO",
                                                    ratio
                                                    )
                    SELECT SEQ_SELLDTL.NEXTVAL,
                           p_autoid,
                           b.TERMCD,
                           b."FROM",
                           B."TO",
                           to_number(B.RATIO)
                      FROM (SELECT *
                              FROM (WITH tmp
                                             AS (SELECT REGEXP_REPLACE (
                                                            TRIM (
                                                                fil.char_value),
                                                            '\(|\)',
                                                            '')
                                                            VALUE,
                                                        fil.rid
                                                   FROM (SELECT fn_pivot_string (
                                                                    REGEXP_REPLACE (
                                                                        record.fil_cond,
                                                                        '~\#~',
                                                                        '|'))
                                                                    filter_row
                                                           FROM DUAL),
                                                        TABLE (filter_row) fil)


                                    select *
                                        from (select * from
                                            (select value TERMCD from tmp t where t.rid = 1) t1,

                                            (select value "FROM" from tmp t where t.rid =2) t2,
                                            (select value "TO" from tmp t where t.rid = 3) t3,
                                            (select value RATIO from tmp t where t.rid = 4) t4

                                        )  ) ) b;
            END LOOP;


    p_err_code := '';
    plog.setEndSection(pkgctx, 'prc_sysprocess');
exception when others then
    p_err_code := errnums.C_SYSTEM_ERROR;
    RAISE;

end;
/

DROP PROCEDURE insert_productcoupondtlmemo
/

CREATE OR REPLACE 
PROCEDURE insert_productcoupondtlmemo (p_coupondtl varchar2,
                            p_autoid number,
                            p_action varchar2,
                            p_err_code in out varchar2)
is

    pkgctx   plog.log_ctx;
    logrow   tlogdebug%ROWTYPE;
begin
    plog.setBeginSection(pkgctx, 'prc_sysprocess');

  FOR record
                    IN (SELECT REGEXP_REPLACE (TRIM (fil.char_value),
                                               '\(|\)',
                                               '')
                                   fil_cond
                          FROM (SELECT fn_pivot_string (
                                           REGEXP_REPLACE (p_coupondtl, '~\$~', '|'))
                                           filter_row
                                  FROM DUAL),
                               TABLE (filter_row) fil)
                LOOP
                    INSERT INTO productcoupondtlmemo (autoid,
                                                        id,
                                                        termcd,
                                                        "FROM",
                                                        "TO",
                                                        RATIO,
                                                        ACTION,
                                                        STATUS)
                        SELECT SEQ_BUYDTL.NEXTVAL,
                               p_autoid,
                               b.TERMCD,
                               b."FROM",
                               B."TO",
                               to_number(B.RATIO),
                               p_action,
                               'P'
                          FROM (SELECT *
                                  FROM (WITH tmp
                                                 AS (SELECT REGEXP_REPLACE (
                                                                TRIM (
                                                                    fil.char_value),
                                                                '\(|\)',
                                                                '')
                                                                VALUE,
                                                            fil.rid
                                                       FROM (SELECT fn_pivot_string (
                                                                        REGEXP_REPLACE (
                                                                            record.fil_cond,
                                                                            '~\#~',
                                                                            '|'))
                                                                        filter_row
                                                               FROM DUAL),
                                                            TABLE (filter_row) fil)


                                        select *
                                            from (select * from
                                                (select value TERMCD from tmp t where t.rid = 1) t1,
                                                (select value "FROM" from tmp t where t.rid = 2) t2,
                                                (select value "TO" from tmp t where t.rid = 3) t3,
                                                (select value RATIO from tmp t where t.rid = 4) t4

                                            )  ) ) b;
                END LOOP;


    p_err_code := '';
    plog.setEndSection(pkgctx, 'prc_sysprocess');
exception when others then
    p_err_code := errnums.C_SYSTEM_ERROR;
    RAISE;

end;
/

DROP PROCEDURE insert_productselldtl
/

CREATE OR REPLACE 
PROCEDURE insert_productselldtl (p_selldtl varchar2,
                            p_autoid number,
                            p_err_code in out varchar2)
is

    pkgctx   plog.log_ctx;
    logrow   tlogdebug%ROWTYPE;
begin
    plog.setBeginSection(pkgctx, 'prc_sysprocess');

 FOR record
                IN (SELECT REGEXP_REPLACE (TRIM (fil.char_value),
                                           '\(|\)',
                                           '')
                               fil_cond
                      FROM (SELECT fn_pivot_string (
                                       REGEXP_REPLACE (p_selldtl, '~\$~', '|'))
                                       filter_row
                              FROM DUAL),
                           TABLE (filter_row) fil)
            LOOP
                INSERT INTO productselldtl (autoid,
                                                    id,
                                                    termcd,
                                                    "FROM",
                                                    "TO",
                                                    "TYPE",
                                                    AMPLITUDE,
                                                    rate
                                                    )
                    SELECT SEQ_SELLDTL.NEXTVAL,
                           p_autoid,
                           b.TERMCD,
                           b."FROM",
                           B."TO",
                           b."TYPE",
                            to_number(b.AMPLITUDE),
                           to_number(B.RATE)
                      FROM (SELECT *
                              FROM (WITH tmp
                                             AS (SELECT REGEXP_REPLACE (
                                                            TRIM (
                                                                fil.char_value),
                                                            '\(|\)',
                                                            '')
                                                            VALUE,
                                                        fil.rid
                                                   FROM (SELECT fn_pivot_string (
                                                                    REGEXP_REPLACE (
                                                                        record.fil_cond,
                                                                        '~\#~',
                                                                        '|'))
                                                                    filter_row
                                                           FROM DUAL),
                                                        TABLE (filter_row) fil)


                                    select *
                                        from (select * from
                                            (select value TERMCD from tmp t where t.rid = 1) t1,

                                            (select value "FROM" from tmp t where t.rid =2) t2,
                                            (select value "TO" from tmp t where t.rid = 3) t3,
                                            (select value "TYPE" from tmp t where t.rid = 4) t4,
                                            (select value AMPLITUDE from tmp t where t.rid = 5) t5,
                                            (select value RATE from tmp t where t.rid = 6) t6

                                        )  ) ) b;
            END LOOP;


    p_err_code := '';
    plog.setEndSection(pkgctx, 'prc_sysprocess');
exception when others then
    p_err_code := errnums.C_SYSTEM_ERROR;
    RAISE;

end;
/

DROP PROCEDURE insert_productselldtlmemo
/

CREATE OR REPLACE 
PROCEDURE insert_productselldtlmemo (p_selldtl varchar2,
                            p_autoid number,
                            p_action varchar2,
                            p_err_code in out varchar2)
is

    pkgctx   plog.log_ctx;
    logrow   tlogdebug%ROWTYPE;
begin
    plog.setBeginSection(pkgctx, 'prc_sysprocess');

 FOR record
                    IN (SELECT REGEXP_REPLACE (TRIM (fil.char_value),
                                               '\(|\)',
                                               '')
                                   fil_cond
                          FROM (SELECT fn_pivot_string (
                                           REGEXP_REPLACE (p_selldtl, '~\$~', '|'))
                                           filter_row
                                  FROM DUAL),
                               TABLE (filter_row) fil)
                LOOP
                    INSERT INTO productselldtlmemo (autoid,
                                                        id,
                                                        termcd,
                                                        "FROM",
                                                        "TO",
                                                          "TYPE",
                                                       AMPLITUDE,
                                                        rate,

                                                        ACTION,
                                                        STATUS)
                        SELECT SEQ_SELLDTL.NEXTVAL,
                               p_autoid,
                               b.TERMCD,
                               b."FROM",
                               B."TO",
                             b."TYPE",
                             to_number(B.AMPLITUDE),
                               to_number(B.RATE),

                               p_action,
                               'P'
                          FROM (SELECT *
                                  FROM (WITH tmp
                                                 AS (SELECT REGEXP_REPLACE (
                                                                TRIM (
                                                                    fil.char_value),
                                                                '\(|\)',
                                                                '')
                                                                VALUE,
                                                            fil.rid
                                                       FROM (SELECT fn_pivot_string (
                                                                        REGEXP_REPLACE (
                                                                            record.fil_cond,
                                                                            '~\#~',
                                                                            '|'))
                                                                        filter_row
                                                               FROM DUAL),
                                                            TABLE (filter_row) fil)


                                        select *
                                            from (select * from
                                                (select value TERMCD from tmp t where t.rid = 1) t1,

                                                (select value "FROM" from tmp t where t.rid = 2) t2,
                                                (select value "TO" from tmp t where t.rid = 3) t3,
                                                (select value "TYPE" from tmp t where t.rid = 4) t4,
                                            (select value AMPLITUDE from tmp t where t.rid = 5) t5,
                                            (select value RATE from tmp t where t.rid = 6) t6

                                            )  ) ) b;
                END LOOP;



    p_err_code := '';
    plog.setEndSection(pkgctx, 'prc_sysprocess');
exception when others then
    p_err_code := errnums.C_SYSTEM_ERROR;
    RAISE;

end;
/

DROP PROCEDURE insert_reinvest_rate_dtl
/

CREATE OR REPLACE 
PROCEDURE insert_reinvest_rate_dtl (p_reinvest_rate_dtl varchar2,
                            p_autoid number,
                            p_err_code in out varchar2)
is

    pkgctx   plog.log_ctx;
    logrow   tlogdebug%ROWTYPE;
begin
    plog.setBeginSection(pkgctx, 'prc_sysprocess');

FOR record
                IN (SELECT REGEXP_REPLACE (TRIM (fil.char_value),
                                           '\(|\)',
                                           '')
                               fil_cond
                      FROM (SELECT fn_pivot_string (
                                       REGEXP_REPLACE (p_reinvest_rate_dtl, '~\$~', '|'))
                                       filter_row
                              FROM DUAL),
                           TABLE (filter_row) fil)
            LOOP
                INSERT INTO reinvest_rate_dtl (autoid,
                                                    id,
                                                    termcd,
                                                    "FROM",
                                                    "TO",
                                                    rate
                                                 )
                    SELECT SEQ_REINVEST_RATE_DTL.NEXTVAL,
                           p_autoid,
                           b.TERMCD,
                           b."FROM",
                           B."TO",
                           to_number(B.RATE)
                      FROM (SELECT *
                              FROM (WITH tmp
                                             AS (SELECT REGEXP_REPLACE (
                                                            TRIM (
                                                                fil.char_value),
                                                            '\(|\)',
                                                            '')
                                                            VALUE,
                                                        fil.rid
                                                   FROM (SELECT fn_pivot_string (
                                                                    REGEXP_REPLACE (
                                                                        record.fil_cond,
                                                                        '~\#~',
                                                                        '|'))
                                                                    filter_row
                                                           FROM DUAL),
                                                        TABLE (filter_row) fil)


                                    select *
                                        from (select * from
                                            (select value TERMCD from tmp t where t.rid = 1) t1,
                                            (select value "FROM" from tmp t where t.rid =2) t2,
                                            (select value "TO" from tmp t where t.rid = 3) t3,
                                            (select value RATE from tmp t where t.rid = 4) t4

                                        )  ) ) b;
            END LOOP;



    p_err_code := '';
    plog.setEndSection(pkgctx, 'prc_sysprocess');
exception when others then
    p_err_code := errnums.C_SYSTEM_ERROR;
    RAISE;

end;
/

DROP PROCEDURE insert_reinvest_rate_dtlmemo
/

CREATE OR REPLACE 
PROCEDURE insert_reinvest_rate_dtlmemo (p_reinvest_rate_dtl varchar2,
                            p_autoid number,
                            p_action varchar2,
                            p_err_code in out varchar2)
is

    pkgctx   plog.log_ctx;
    logrow   tlogdebug%ROWTYPE;
begin
    plog.setBeginSection(pkgctx, 'prc_sysprocess');

FOR record
                IN (SELECT REGEXP_REPLACE (TRIM (fil.char_value),
                                           '\(|\)',
                                           '')
                               fil_cond
                      FROM (SELECT fn_pivot_string (
                                       REGEXP_REPLACE (p_reinvest_rate_dtl, '~\$~', '|'))
                                       filter_row
                              FROM DUAL),
                           TABLE (filter_row) fil)
            LOOP
                INSERT INTO reinvest_rate_dtlmemo (autoid,
                                                    id,
                                                    termcd,
                                                    "FROM",
                                                    "TO",
                                                    rate,
                                                    "ACTION"
                                                 )
                    SELECT SEQ_REINVEST_RATE_DTL.NEXTVAL,
                           p_autoid,
                           b.TERMCD,
                           b."FROM",
                           B."TO",
                           to_number(B.RATE),
                           p_action
                      FROM (SELECT *
                              FROM (WITH tmp
                                             AS (SELECT REGEXP_REPLACE (
                                                            TRIM (
                                                                fil.char_value),
                                                            '\(|\)',
                                                            '')
                                                            VALUE,
                                                        fil.rid
                                                   FROM (SELECT fn_pivot_string (
                                                                    REGEXP_REPLACE (
                                                                        record.fil_cond,
                                                                        '~\#~',
                                                                        '|'))
                                                                    filter_row
                                                           FROM DUAL),
                                                        TABLE (filter_row) fil)


                                    select *
                                        from (select * from
                                            (select value TERMCD from tmp t where t.rid = 1) t1,
                                            (select value "FROM" from tmp t where t.rid =2) t2,
                                            (select value "TO" from tmp t where t.rid = 3) t3,
                                            (select value RATE from tmp t where t.rid = 4) t4

                                        )  ) ) b;
            END LOOP;



    p_err_code := '';
    plog.setEndSection(pkgctx, 'prc_sysprocess');
exception when others then
    p_err_code := errnums.C_SYSTEM_ERROR;
    RAISE;

end;
/

DROP PROCEDURE iv0055
/

CREATE OR REPLACE 
PROCEDURE iv0055 (PV_REFCURSOR IN OUT PKG_REPORT.REF_CURSOR,
                                   PV_TLID      IN VARCHAR2,
                                   PV_BRID      IN VARCHAR2,
                                   PV_ROLECODE  IN VARCHAR2,
                                   PV_MONTH    IN VARCHAR2,
                                   T_DATE       IN VARCHAR2,
                                   PV_POST       IN VARCHAR2,
                                   PV_SIGNPERSON       IN VARCHAR2) IS

BEGIN
   OPEN PV_REFCURSOR FOR
      SELECT F.NAME,f.symbol, m.mbname, PV_MONTH MMYYYY, T_DATE TODATE,
      TO_CHAR(TO_DATE(TRUNC(SYSDATE),'DD/MM/YYYY'),'DD') C_DAY,
      TO_CHAR(TO_DATE(TRUNC(SYSDATE),'DD/MM/YYYY'),'MM') C_MONTH,
      TO_CHAR(TO_DATE(TRUNC(SYSDATE),'DD/MM/RRRR'),'RRRR') C_YYYY,
      PV_POST POSITION, INITCAP(LOWER(PV_SIGNPERSON)) SIGNPERSON FROM FUND f, members m WHERE f.fmcode = m.mbcode AND f.status  ='A';

EXCEPTION
  WHEN OTHERS THEN
    RETURN;
END;
/

DROP PROCEDURE pr_action_log
/

CREATE OR REPLACE 
PROCEDURE pr_action_log (p_userid IN varchar2,
                            p_ip IN varchar2,
                            p_headers IN varchar2,
                            p_cmdobjname IN varchar2,
                            p_action IN varchar2,
                            p_func_key IN varchar2,
                            p_key_value IN varchar2,
                            p_param_value IN varchar2,
                            p_err_code IN varchar2,
                            p_err_param IN varchar2) as
  pkgctx plog.log_ctx;
  logrow tlogdebug%rowtype;
  begin

    plog.setBeginSection(pkgctx, 'pr_action_log');


    insert into action_log
        (
           autoid,
           userid,
           ip,
           headers,
           cmdobjname,
           action,
           action_time,
           func_key,
           key_value,
           param_value,
           err_code,
           err_param
        )
     values
         (
            seq_action_log.NEXTVAL,
            p_userid,
            p_ip,
            p_headers,
            p_cmdobjname,
            NVL(p_action, 'GET'),
            CURRENT_TIMESTAMP,
            p_func_key,
            p_key_value,
            p_param_value,
            p_err_code,
            p_err_param
         );
     COMMIT;

    plog.setEndSection(pkgctx, 'pr_action_log');
  exception
    when others then
      plog.error(pkgctx,'Err: ' || sqlerrm || ' Trace: ' || dbms_utility.format_error_backtrace );
      plog.setEndSection(pkgctx, 'pr_action_log');
  end pr_action_log;
/

DROP PROCEDURE pr_api_log
/

CREATE OR REPLACE 
PROCEDURE pr_api_log (p_apicode IN varchar2,
                            p_reqbody IN varchar2,
                            p_query IN varchar2,
                            p_resbody IN clob,
                            p_err_code IN OUT varchar2,
                            p_err_param IN OUT varchar2) as
  pkgctx plog.log_ctx;
  logrow tlogdebug%rowtype;
  begin

    plog.setBeginSection(pkgctx, 'pr_api_log');
    p_err_code  := systemnums.C_SUCCESS;
    p_err_param := 'SUCCESS';

    insert into api_log
        (
           autoid, apicode, reqbody, query, resbody, calltime
        )
     values
         (
            seq_api_log.NEXTVAL,
            p_apicode, p_reqbody, p_query, p_resbody, CURRENT_TIMESTAMP
         );
     COMMIT;

    plog.setEndSection(pkgctx, 'pr_api_log');
  exception
    when others then
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error(pkgctx,'Err: ' || sqlerrm || ' Trace: ' || dbms_utility.format_error_backtrace );
      plog.setEndSection(pkgctx, 'pr_api_log');
  end pr_api_log;
/

DROP PROCEDURE pr_demo
/

CREATE OR REPLACE 
PROCEDURE pr_demo (datainput varchar2, p_language varchar2, p_err_code IN OUT  varchar2)
 IS
 
    l_array dbms_utility.lname_array;
   
-- 	type namesarray IS VARRAY(5) OF VARCHAR2(10); 
-- 	names namesarray;
-- 	
-- 	total integer;
-- 	l_input varchar2(4000) := '1,2,3';
--  	l_count binary_integer;
--  	l_array dbms_utility.lname_array;
 
BEGIN
	
	
--	l_array := fn_convert_string_to_array('CA#NGHIA#QUAN');

--	dbms_utility.comma_to_table
--     ( list   => regexp_replace(l_input,'(^|,)','\1x')
--      , tablen => l_count
--      , tab    => l_array
--    );
--	dbms_output.put_line('C'||l_array.count);
--     for i in 1 .. l_array.count 
--     loop
--       dbms_output.put_line
--       ( 'Element ' || to_char(i) ||
--         ' of array contains: ' ||
--         substr(l_array(i),2)
--       );
--    end loop;
--	names := namesarray('Kavita', 'Pritam', 'Ayan', 'Rishav', 'Aziz');
--	total := names.count; 
	p_err_code := '0';
-- 	FOR i in 1 .. total LOOP 
--      dbms_output.put_line('Student: ' || names(i) );
--   	END LOOP; 
--    FOR i IN 1..5
--    LOOP
--        INSERT INTO AHIHI VALUES ('2' || i);
--    END LOOP;
--    commit;
    
Exception
When others THEN
	p_err_code := '-1';
    dbms_output.put_line('Err: ' || sqlerrm || ' Trace: ' || dbms_utility.format_error_backtrace);
END
;
/

DROP PROCEDURE pr_exec_user
/

CREATE OR REPLACE 
PROCEDURE pr_exec_user (p_userid IN varchar2,
                            p_username IN varchar2,
                            p_fullname IN varchar2,
                            p_pos IN varchar2,
                            p_position IN varchar2,
                            p_workunit IN varchar2,
                            p_role IN varchar2,
                            p_status IN varchar2,
                            pv_action IN varchar2,
                            p_err_code IN OUT varchar2,
                            p_err_param IN OUT varchar2) as
  pkgctx plog.log_ctx;
  logrow tlogdebug%rowtype;
  l_count NUMBER ;
  l_data_source   varchar2(500);
  l_Email         varchar2(300);
  l_Mobile        varchar2(30);
  l_orgpasswrd    varchar2(60);
  l_password      varchar2(5000);
  l_salt          varchar2(50);
  begin
    for i in (select * from tlogdebug)
      loop
        logrow.loglevel  := i.loglevel;
        logrow.log4table := i.log4table;
        logrow.log4alert := i.log4alert;
        logrow.log4trace := i.log4trace;
      end loop;

      pkgctx := plog.init('pr_exec_user',
                          plevel            => nvl(logrow.loglevel, 30),
                          plogtable         => (nvl(logrow.log4table, 'N') = 'Y'),
                          palert            => (nvl(logrow.log4alert, 'N') = 'Y'),
                          ptrace            => (nvl(logrow.log4trace, 'N') = 'Y'));

    plog.setBeginSection(pkgctx, 'pr_exec_user');
    p_err_code  := systemnums.C_SUCCESS;
    p_err_param := 'SUCCESS';

    plog.debug(pkgctx, 'p_userid = ' || p_userid);
    plog.debug(pkgctx, 'p_username = ' || p_username);

   	IF pv_action = 'ADD' THEN

	    select count(*) into l_count from TLPROFILES where LOWER(tlname)  = LOWER(p_username) AND tlid = p_userid ;
	    IF l_count = 0 THEN
	    	p_err_code := '-112224';
	        p_err_param := fn_get_errmsg(p_err_code,'vie');
	        return;
	    ELSE

	    	select fn_passwordgenerator(), fn_passwordgenerator() into l_orgpasswrd, l_salt from dual;
	    	l_password := genencryptpassword('123456'||l_salt);
			INSERT
				INTO
				TLPROFILES (
				TLID,
				TLNAME,
				TLFULLNAME,
				MBID,
				BRID,
				PASSWORD,
				ACTIVE,
				TLTYPE,
				DEPARTMENT,
				TLTITLE,
				IDCODE,
				MOBILE,
				EMAIL,
				DESCRIPTION,
				STATUS,
				PSTATUS,
				TLREFID,
				VSDSALEID,
				ISMANAGER,
				RETRY_COUNT,
				SALT)
			VALUES(
			p_userid,
			p_username,
			p_fullname, --TLFULLNAME
			(SELECT mbid FROM BRGRP WHERE brid = p_pos), --MBID
			p_pos, --BRID
			l_password,
			p_status,--active
			NULL,-- tltype
			p_workunit, --department
			p_position, -- tltitle
			NULL,--idcode
			NULL, -- mobile
			NULL, -- email
			NULL, -- des
			'A', --status
			'A',  -- pstatus
			NULL,
			NULL,
			'Y', -- ismanager
			NULL,
			l_salt);


	    END IF;
        FOPKS_SYSTEM.prc_mt_tlgrpusers(
                p_role,
                '',
                p_userid,
                'Y',
                '000001',
                '',
                'ADD',
                'vie',
                'USER',
                p_err_code,
                p_err_param
        );
    ELSif pv_action = 'EDIT' then
    	select count(*) into l_count from TLPROFILES where LOWER(tlname )= LOWER(p_username) and tlid <> p_userid;
        if l_count > 0 then
            p_err_code := '-112224';
            p_err_param := fn_get_errmsg(p_err_code,'vie');
            return;
        end if;
       SELECT count(1) INTO l_count from TLPROFILES where LOWER(tlname )= LOWER(p_username) and tlid = p_userid;
       if l_count = 0 then
            p_err_code := '-200093';
            p_err_param := fn_get_errmsg(p_err_code,'vie');
            return;
        end if;
       UPDATE TLPROFILES SET TLFULLNAME = p_fullname ,MBID = (SELECT mbid FROM BRGRP WHERE brid = p_pos) , BRID = p_pos   WHERE  LOWER(tlname )= LOWER(p_username)  ;
       select count(1) into l_count from tlgrpusers where tlid = p_userid and grpid = p_role ;
       if l_count = 0 then
           FOPKS_SYSTEM.prc_mt_tlgrpusers(
                    p_role,
                    '',
                    p_userid,
                    'Y',
                    '000001',
                    '',
                    'ADD',
                    'vie',
                    'USER',
                    p_err_code,
                    p_err_param
            );
        end if;
    else

        for vc in (select * from tlgrpusers where tlid = p_userid ) loop
            FOPKS_SYSTEM.prc_mt_tlgrpusers(
                  vc.grpid,
                  vc.id,
                  vc.tlid,
                  '',
                  '000001',
                  '',
                  'DELETE',
                  'vie',
                  'USER',
                  p_err_code,
                  p_err_param
          );

        end loop;

        delete from tlprofiles where tlid = p_userid ;
        delete from tlprofilesmemo where tlid = p_userid ;
    END IF;

    COMMIT;

    plog.setEndSection(pkgctx, 'pr_exec_user');
  exception
    when others then
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error(pkgctx,'Err: ' || sqlerrm || ' Trace: ' || dbms_utility.format_error_backtrace );
      plog.setEndSection(pkgctx, 'pr_exec_user');
  end pr_exec_user;
/

DROP PROCEDURE pr_gather_all_table
/

CREATE OR REPLACE 
PROCEDURE pr_gather_all_table 
IS
--
-- To modify this template, edit file PROC.TXT in TEMPLATE
-- directory of SQL Navigator
--
-- Purpose: Briefly explain the functionality of the procedure
--
-- MODIFICATION HISTORY
-- Person      Date         Comments
-- ThaiTQ      2019/08/08   Create

BEGIN
    FOR i
        IN (SELECT    'begin DBMS_STATS.GATHER_TABLE_STATS (ownname => '''
                   || a.owner
                   || ''' , tabname => '''
                   || a.table_name
                   || ''',cascade => true, estimate_percent => 10,method_opt=>''for all indexed columns size 1'', granularity => ''ALL'', degree => 16); end;' sql_exec
              FROM all_tables a
             WHERE a.owner IN ('CBOND_SHB') AND a.table_name not like '%$%' AND a.table_name not like '%BK%' 
                   and a.table_name not like '%HIST%'
                   and a.table_name not like '%_OLD%'
                   ---
                   and a.table_name not like '%_TEMP%'
                   and a.table_name not like '%_TMP%'
                   and a.table_name not like '%_LOG%'
                   and a.table_name not like '%_20%'
             ORDER BY a.table_name)
    LOOP
        execute immediate i.sql_exec;
    END LOOP;
END;                                                              -- Procedure
/

DROP PROCEDURE pr_gen_sbcurrdate
/

CREATE OR REPLACE 
PROCEDURE pr_gen_sbcurrdate 
as
v_currdate date;
v_count number;

begin
    select to_date(varvalue,'DD/MM/RRRR') into v_currdate from sysvar where varname ='CURRDATE' and grname ='SYSTEM';
    --Gen lich business
    delete from sbcurrdate;

    v_count:=0;
    for rec in (select * from sbcldr where sbdate >=v_currdate and cldrtype ='000' and holiday ='N' order by sbdate)
    loop
        insert into sbcurrdate (currdate,sbdate,numday,sbtype)
        values (v_currdate,rec.sbdate,v_count,'B' );
        v_count:=v_count+1;
    end loop;
    v_count:=0;
    for rec in (select * from sbcldr where sbdate <v_currdate and cldrtype ='000'  and holiday ='N'  order by sbdate desc)
    loop

        v_count:=v_count-1;
        insert into sbcurrdate (currdate,sbdate,numday,sbtype)
        values (v_currdate,rec.sbdate,v_count,'B' );
    end loop;

    --Gen lich normal
    v_count:=0;
    for rec in (select * from sbcldr where sbdate >=v_currdate and cldrtype ='000' order by sbdate)
    loop
        insert into sbcurrdate (currdate,sbdate,numday,sbtype)
        values (v_currdate,rec.sbdate,v_count,'N' );
        v_count:=v_count+1;
    end loop;
    v_count:=0;
    for rec in (select * from sbcldr where sbdate <v_currdate and cldrtype ='000'  order by sbdate desc)
    loop

        v_count:=v_count-1;
        insert into sbcurrdate (currdate,sbdate,numday,sbtype)
        values (v_currdate,rec.sbdate,v_count,'N' );
    end loop;
end;
/

DROP PROCEDURE pr_getussearch_front
/

CREATE OR REPLACE 
PROCEDURE pr_getussearch_front (PV_REFCURSOR IN OUT PKG_REPORT.REF_CURSOR,
TellerId varchar2, BranchId varchar2, SearchFilter varchar2)
is
v_sql clob;
v_tablelog varchar2(20);
v_Searchlft varchar2(4000);
v_mbcode varchar2(20);
begin

    if instr(SearchFilter,'TLLOG.TXDATE') <> 0 then
        v_tablelog:= 'vw_objlog_all';
    else
        v_tablelog:= 'vw_objlog_all';
    end if;
    v_mbcode:=fopks_sa.fn_get_mbcode(TellerId);
    if TellerId='0001' THEN --Admin he thong
        v_sql:='SELECT distinct *
        FROM ( SELECT * FROM (
        SELECT lg0.CFFULLNAME CFFULLNAME,lg0.CFCUSTODYCD IDAFACCTNO,NVL(SB.SYMBOL,''---'') CODEID, tltx.en_txdesc NAMENV,
          lg0.CAREBYGRP,lg0.AUTOID,A1.CDCONTENT DELTD,lg0.TXNUM,lg0.TXDATE,
          lg0.BUSDATE,lg0.BRID,lg0.TLTXCD||''-''||(CASE WHEN tltx.tltxcd LIKE ''50%''
                                                                  THEN lg0.TXDESC ELSE tltx.txdesc
                                                                  END) TLTXCD,A0.CDCONTENT TXSTATUS,
          ((CASE WHEN lg0.TXSTATUS=''7'' THEN ''4''  ELSE  lg0.TXSTATUS END)  ) TXSTATUSCD,
          lg0.TXDESC,lg0.MSGACCT ACCTNO, lg0.MSGAMT AMT, lg0.TLID,lg0.CHID,lg0.CHKID,lg0.OFFID,
          TLMAKER.TLNAME TLNAME, TLCASHIER.TLNAME CHNAME,lg0.createdt,
          TLCHECKER.TLNAME CHKNAME, TLOFFICER.TLNAME OFFNAME, NVL(lg0.TXTIME,lg0.OFFTIME) TXTIME, lg0.OFFTIME, lg0.lvel, A2.CDCONTENT DSTATUS,PARENTTABLE,PARENTVALUE,PARENTKEY,CHILTABLE,CHILDVALUE,CHILDKEY,MODULCODE
        FROM (select * from ' || v_tablelog || ' where batchname = ''DAY''  ) lg0, ALLCODE A0, ALLCODE A1,ALLCODE A2,tltx,FUND SB,
        (select * from (SELECT DISTINCT TL.TLID, TL.TLNAME FROM tlprofiles TL union select ''____'' TLID, ''____'' TLNAME from dual)) TLMAKER,
        (select * from (SELECT DISTINCT TL.TLID, TL.TLNAME FROM tlprofiles TL union select ''____'' TLID, ''____'' TLNAME from dual)) TLCASHIER,
        (select * from (SELECT DISTINCT TL.TLID, TL.TLNAME FROM tlprofiles TL union select ''____'' TLID, ''____'' TLNAME from dual)) TLOFFICER,
        (select * from (SELECT DISTINCT TL.TLID, TL.TLNAME FROM tlprofiles TL union select ''____'' TLID, ''____'' TLNAME from dual)) TLCHECKER
        WHERE A0.CDTYPE=''SY'' AND A0.CDNAME = ''TXSTATUS''
          AND A0.CDVAL= ( CASE WHEN DELTD=''Y'' THEN ''9'' WHEN (lg0.TXSTATUS=''4'' AND (lg0.OVRRQS <> ''0'' AND lg0.OVRRQS <> ''@00'') AND lg0.CHKID IS NOT NULL  AND lg0.OFFID IS NULL) THEN ''10'' ELSE  lg0.TXSTATUS END)
          AND A1.CDTYPE=''SY'' AND A1.CDNAME = ''YESNO'' AND A1.CDVAL=DELTD
          AND A2.CDTYPE=''SY'' AND A2.CDNAME = ''DSTATUS'' and A2.cdval = lg0.dstatus
          AND lg0.ccyusage= SB.CODEID(+)
          AND (CASE WHEN lg0.TLID IS NULL THEN ''____'' ELSE lg0.TLID END)=TLMAKER.TLID
          AND (CASE WHEN lg0.CHID IS NULL THEN ''____'' ELSE lg0.CHID END)=TLCASHIER.TLID
          AND (CASE WHEN lg0.CHKID IS NULL THEN ''____'' ELSE lg0.CHKID END)=TLCHECKER.TLID
          AND (CASE WHEN lg0.OFFID IS NULL THEN ''____'' ELSE lg0.OFFID END)=TLOFFICER.TLID and tltx.tltxcd=lg0.tltxcd
        ) TLLOG WHERE 0=0  )TLLOG WHERE 0=0 ';
    else --User thong thuong
        v_sql:='
        with
        grpuser as
        (
        select grpid from tlgrpusers where tlid = '''||TellerId||'''
        )
        SELECT distinct * FROM (SELECT * FROM (SELECT lg0.CFFULLNAME CFFULLNAME, lg0.CFCUSTODYCD IDAFACCTNO,NVL(SB.SYMBOL,''---'') CODEID,
            tltx.en_txdesc NAMENV,lg0.CAREBYGRP,lg0.AUTOID,A1.CDCONTENT DELTD,lg0.TXNUM,
            lg0.TXDATE,lg0.BUSDATE,lg0.BRID,lg0.TLTXCD||''-''||(CASE WHEN tltx.tltxcd LIKE ''50%''
                                                                  THEN lg0.TXDESC ELSE tltx.txdesc
                                                                  END) TLTXCD,A0.CDCONTENT TXSTATUS,
             ((CASE WHEN lg0.TXSTATUS=''7'' THEN ''4'' ELSE  lg0.TXSTATUS END)  ) TXSTATUSCD,
            lg0.TXDESC,lg0.MSGACCT ACCTNO, lg0.MSGAMT AMT, lg0.TLID,lg0.CHID,lg0.CHKID,lg0.OFFID,
            TLMAKER.TLNAME TLNAME, TLCASHIER.TLNAME CHNAME, TLCHECKER.TLNAME CHKNAME,lg0.createdt,
            TLOFFICER.TLNAME OFFNAME, NVL(lg0.TXTIME,lg0.OFFTIME) TXTIME, lg0.OFFTIME,lg0.lvel, A2.CDCONTENT DSTATUS,PARENTTABLE,PARENTVALUE,PARENTKEY,CHILTABLE,CHILDVALUE,CHILDKEY,MODULCODE
            FROM (select TL.* from ' || v_tablelog || ' tl, CFMAST CF where (batchname = ''DAY'') AND TL.cfcustodycd = CF.custodycd(+)  ) lg0, ALLCODE A0, ALLCODE A1, ALLCODE A2,tltx,
            (SELECT GRPID FROM TLGRPUSERS WHERE TLID=''' || TellerId || ''' UNION ALL select ''XXXX'' GRPID from dual) TLCAREBY,
            (select * from (SELECT DISTINCT TL.TLID, TL.TLNAME FROM tlprofiles TL union select ''____'' TLID, ''____'' TLNAME from dual)) TLMAKER,
            (select * from (SELECT DISTINCT TL.TLID, TL.TLNAME FROM tlprofiles TL union select ''____'' TLID, ''____'' TLNAME from dual)) TLCASHIER,
            (select * from (SELECT DISTINCT TL.TLID, TL.TLNAME FROM tlprofiles TL union select ''____'' TLID, ''____'' TLNAME from dual)) TLOFFICER,
            (select * from (SELECT DISTINCT TL.TLID, TL.TLNAME FROM tlprofiles TL union select ''____'' TLID, ''____'' TLNAME from dual)) TLCHECKER,
            FUND SB
            WHERE A0.CDTYPE=''SY'' AND A0.CDNAME = ''TXSTATUS'' AND A0.CDVAL=( CASE WHEN DELTD=''Y'' THEN ''9'' WHEN (lg0.TXSTATUS=''4'' AND (lg0.OVRRQS <> ''0'' AND lg0.OVRRQS <> ''@00'') AND lg0.CHKID IS NOT NULL  AND lg0.OFFID IS NULL) THEN ''10'' ELSE  lg0.TXSTATUS END)
            AND A1.CDTYPE=''SY'' AND A1.CDNAME = ''YESNO'' AND A1.CDVAL=DELTD
            AND A2.CDTYPE=''SY'' AND A2.CDNAME = ''DSTATUS'' and A2.cdval = lg0.dstatus
            AND lg0.ccyusage= SB.CODEID(+)
            AND (CASE WHEN lg0.TLID IS NULL THEN ''____'' ELSE lg0.TLID END)=TLMAKER.TLID
            AND (CASE WHEN lg0.CHID IS NULL THEN ''____'' ELSE lg0.CHID END)=TLCASHIER.TLID
            AND (CASE WHEN lg0.CHKID IS NULL THEN ''____'' ELSE lg0.CHKID END)=TLCHECKER.TLID
            AND (CASE WHEN lg0.OFFID IS NULL THEN ''____'' ELSE lg0.OFFID END)=TLOFFICER.TLID and tltx.tltxcd=lg0.tltxcd
            AND (lg0.TLID= ''' || TellerId || '''
            OR (lg0.TLTXCD IN ( SELECT CMDCODE TLTXCD FROM CMDAUTH WHERE CMDTYPE=''T'' and AUTHID= ''' || TellerId || ''' AND AUTHTYPE=''U''
             UNION ALL select CMDCODE tltxcd from CMDAUTH t, tlgrpusers g where t.authid = g.grpid and g.tlid = ''' || TellerId || ''' and t.authtype = ''G'' and t.cmdtype = ''T'' ))
            OR (lg0.parenttable IN (SELECT m.objname FROM CMDAUTH  A,CMDMENU M WHERE a.CMDTYPE <> ''T'' and m.cmdid = a.cmdcode
            AND a.AUTHID= ''' || TellerId || ''' AND a.AUTHTYPE=''U'' and   INSTR(a.strauth,''Y'') >0 and m.objname is not null
            UNION ALL
            SELECT m.objname FROM CMDAUTH  A,CMDMENU M,TLGRPUSERS G WHERE a.CMDTYPE <> ''T'' and m.cmdid = a.cmdcode
            AND a.AUTHID = G.GRPID AND a.AUTHTYPE=''G'' and  INSTR(a.strauth,''Y'') >0 and m.objname is not null
            AND G.TLID = ''' || TellerId || '''))
            ))TLLOG WHERE 0=0 )TLLOG WHERE 0=0 ';
    end if;
    --dbms_output.put_line('v_sql:' || v_sql);
    v_Searchlft:=SearchFilter;
    v_Searchlft:=v_Searchlft|| ' order by decode(TXSTATUSCD,''4'',''-1'',TXSTATUSCD),createdt desc';
    IF length(SearchFilter)>0 then
        v_sql := v_sql || ' AND ' || v_Searchlft;
    ELSE
          v_sql := v_sql || ' ' || v_Searchlft;
    end if;
    plog.error('sql: ' || v_sql);
    open PV_REFCURSOR for v_sql;
EXCEPTION
  WHEN others THEN -- caution handles all exceptions
   plog.error('ERROR: ' || SQLERRM || dbms_utility.format_error_backtrace);
   plog.error('v_sql = ' || v_sql);
end;
/

DROP PROCEDURE pr_lockaccount
/

CREATE OR REPLACE 
PROCEDURE pr_lockaccount (p_txmsg in tx.msg_rectype, p_err_code in out varchar2)
is

    l_listacctno varchar2 (1000);
begin
    l_listacctno:='|';
    IF p_txmsg.tltxcd ='5024' THEN
         insert into TBL_ACCTNO_UPDATING (acctno,updatetype,createdate)
                values (p_txmsg.txfields('15').value, 'IP', SYSTIMESTAMP);
         p_err_code:=0;
    ELSIF p_txmsg.tltxcd ='5002' OR p_txmsg.tltxcd ='5004' OR p_txmsg.tltxcd ='5006'
         OR p_txmsg.tltxcd ='5008' OR p_txmsg.tltxcd ='5010' OR p_txmsg.tltxcd ='4002' THEN
        --06	5002	SEACCTNO lam giam ccq
         insert into TBL_ACCTNO_UPDATING (acctno,updatetype,createdate)
                values (p_txmsg.txfields('06').value, 'OD', SYSTIMESTAMP);
         p_err_code:=0;
    ELSE
        for rec in (
            select  distinct map.acfld, map.apptype
            from appmap map, apptx tx, tltx
            where map.apptxcd= tx.txcd and map.apptype = tx.apptype
            and fldtype ='N' and  map.tltxcd =p_txmsg.tltxcd
            and map.tltxcd = tltx.tltxcd and nvl(chksingle,'N') ='Y'

        )
        loop

            if instr(l_listacctno,'|' || p_txmsg.txfields(rec.acfld).value || rec.apptype || '|') =0 then

             insert into TBL_ACCTNO_UPDATING (acctno,updatetype,createdate)
                values (p_txmsg.txfields(rec.acfld).value, rec.apptype, SYSTIMESTAMP);
            end if;
            l_listacctno:= l_listacctno  ||  p_txmsg.txfields(rec.acfld).value || rec.apptype || '|';
            p_err_code:=0;
        end loop;
    END IF;

exception when others then
    p_err_code:='-100201';

end;
/

DROP PROCEDURE pr_sync_data_api
/

CREATE OR REPLACE 
PROCEDURE pr_sync_data_api (p_apicode IN varchar2,
                            p_resbody IN clob,
                            p_err_code IN OUT varchar2,
                            p_err_param IN OUT varchar2) as
  pkgctx plog.log_ctx;
  logrow tlogdebug%rowtype;
  begin
    for i in (select * from tlogdebug)
      loop
        logrow.loglevel  := i.loglevel;
        logrow.log4table := i.log4table;
        logrow.log4alert := i.log4alert;
        logrow.log4trace := i.log4trace;
      end loop;

      pkgctx := plog.init('pr_sync_data_api',
                          plevel            => nvl(logrow.loglevel, 30),
                          plogtable         => (nvl(logrow.log4table, 'N') = 'Y'),
                          palert            => (nvl(logrow.log4alert, 'N') = 'Y'),
                          ptrace            => (nvl(logrow.log4trace, 'N') = 'Y'));

    plog.setBeginSection(pkgctx, 'pr_sync_data_api');
    p_err_code  := systemnums.C_SUCCESS;
    p_err_param := 'SUCCESS';

    plog.debug(pkgctx, 'p_apicode = ' || p_apicode);
    plog.debug(pkgctx, 'p_resbody = ' || p_resbody);

    --X? lý theo t?ng apicode
    IF p_apicode = 'APIREQSECOPENACCT' then
        --if p_resbody = 0 then
           insert into draff_phong(ten) values (p_apicode||SYSDATE);

           /*fopks_customer.prc_mt_call_coreshs
                (p_custodycd=>p_CUSTODYCD,
                 p_tltxcd=>'2023',
                 p_txnum=>l_txnum,
                 p_txdate=>to_char(l_txdate, 'DD/MM/YYYY'),
                 pv_tlid=>pv_tlid,
                 pv_role=>'AMC',
                 pv_action=>pv_action,
                 pv_language=>pv_language,
                 p_err_code=>p_err_code,
                 p_err_param=>p_err_param);*/
        --end if;
        COMMIT;
    END IF;

    COMMIT;

    plog.setEndSection(pkgctx, 'pr_sync_data_api');
  exception
    when others then
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error(pkgctx,'Err: ' || sqlerrm || ' Trace: ' || dbms_utility.format_error_backtrace );
      plog.setEndSection(pkgctx, 'pr_sync_data_api');
  end pr_sync_data_api;
/

DROP PROCEDURE pr_unlockaccount
/

CREATE OR REPLACE 
PROCEDURE pr_unlockaccount (p_txmsg in tx.msg_rectype)
is

begin
    IF p_txmsg.tltxcd ='5024' THEN
        delete from TBL_ACCTNO_UPDATING where acctno= p_txmsg.txfields('15').value and updatetype = 'IP';
    ELSIF p_txmsg.tltxcd ='5002' OR p_txmsg.tltxcd ='5004' OR p_txmsg.tltxcd ='5006'
         OR p_txmsg.tltxcd ='5008' OR p_txmsg.tltxcd ='5010' OR p_txmsg.tltxcd ='4002' THEN
        --06	5002	SEACCTNO
        delete from TBL_ACCTNO_UPDATING where acctno= p_txmsg.txfields('06').value and updatetype = 'OD';
    ELSE
        for rec in (
                select  distinct map.acfld, map.apptype
                from appmap map, apptx tx
                where map.apptxcd= tx.txcd and map.apptype = tx.apptype
                and fldtype ='N' and  tltxcd =p_txmsg.tltxcd
                    )
        loop
            delete from TBL_ACCTNO_UPDATING where acctno= p_txmsg.txfields(rec.acfld).value and updatetype = rec.apptype;
        end loop;
    END IF;
exception when others then
    null;
end;
/

DROP PROCEDURE prc_8725
/

CREATE OR REPLACE 
PROCEDURE prc_8725
   ( param1 IN datatype DEFAULT default_value,
     param2 IN OUT datatype)
   IS
--
-- To modify this template, edit file PROC.TXT in TEMPLATE
-- directory of SQL Navigator
--
-- Purpose: Briefly explain the functionality of the procedure
--
-- MODIFICATION HISTORY
-- Person      Date    Comments
-- ---------   ------  -------------------------------------------
   variable_name                 datatype;
   -- Declare program variables as shown above
BEGIN
    statements;
EXCEPTION
    WHEN exception_name THEN
        statements ;
END; -- Procedure
/

DROP PROCEDURE prc_add_oxpost
/

CREATE OR REPLACE 
PROCEDURE prc_add_oxpost (p_txnum varchar2,
                            p_txdate date,
                            p_busdate date,
                            p_txtime varchar2,
                            p_tltxcd varchar2,
                            p_txdesc varchar2,
                            p_tlid varchar2,
                            p_offid varchar2,
                            p_account varchar2,
                            p_publicacct varchar2,
                            p_coacctno varchar2,
                            p_category varchar2,
                            p_symbol varchar2,
                            p_effdate date,
                            p_expdate date,
                            p_quoteval number,
                            p_publicval number,
                            p_quoteprice number,
                            p_productid varchar2,
                            p_refissuid varchar2,
                            p_quoterate number,
                            p_coabr varchar2,
                            p_maxqtty number,
                            p_buyconfirmno varchar2,
                            p_sellopt varchar2,
                            p_cftype varchar2,--
                            p_cfonline varchar2,--
                            p_maxqttypercus number,--
                            p_err_code in out varchar2)
is
    l_currdate date;
    l_orderid varchar2(500);
    l_codeid varchar2(4000);

    l_reflegid number;
    l_orgconfirmno varchar2(100);
    l_orgdate date;
    l_orgprice number;
    l_dealeracct varchar2(100);
    pkgctx   plog.log_ctx;
    logrow   tlogdebug%ROWTYPE;
begin
    plog.setBeginSection(pkgctx, 'prc_sysprocess');
    l_currdate := getcurrdate();

    l_orderid := to_char(p_txdate,'YYYYMMDD')||p_txnum;

    if p_category <> 'C' then
        select to_char(a.autoid) into l_codeid
        from assetdtl a
        where a.symbol = p_symbol;
    end if;

    if trim(p_buyconfirmno) is not null then
        select nvl(orgconfirmno,confirmno), nvl(orgdate,txdate), nvl(orgprice, price), o.sbdefacctno
            into l_orgconfirmno, l_orgdate, l_orgprice, l_dealeracct
        from oxmast o
        where confirmno = p_buyconfirmno;

        select autoid into l_reflegid
        from oxmastleg
        where confirmno = p_buyconfirmno
            and legcd = 'B';
    end if;

    -- Insert oxpost
    INSERT INTO oxpost (autoid,
                        orderid,
                        txdate,
                        txtime,
                        traderid,
                        checkerid,
                        afacctno,
                        publicacct,
                        coacctno,
                        category,
                        side,
                        codeid,
                        symbol,
                        effdate,
                        expdate,
                        quoteval,
                        publicval,
                        availval,
                        quoteprice,
                        subsqtty,
                        subsamt,
                        firmqtty,
                        firmamt,
                        settqtty,
                        settamt,
                        cancelqtty,
                        status,
                        lastchange,
                        productid,
                        refissuid,
                        reflegid,
                        txnum,
                        dealeraccount,
                        orgconfirmno,
                        refadid,
                        orgdate,
                        buyconfirmno,
                        quoterate,
                        orgprice,
                        comboid,
                        sellopt,
                        coabr,
                        maxqtty,
                        cftype ,--
                        cfonline, --
                        maxqttypercus--
                        )
    VALUES (
               seq_oxpost.NEXTVAL, --autoid
               l_orderid, --orderid
               p_txdate, --txdate
               NVL (
                   p_txtime,
                   TO_CHAR (SYSDATE, fn_systemnums ('systemnums.c_time_format'))), --txtime
               p_tlid, --traderid
               p_offid, --chkid
               p_account, --afacctno
               p_publicacct, --publicacct
               upper(p_coacctno), --coacctno
               --p_category, --category
               'T',--category
               'S', --side
               l_codeid, --codeid
               p_symbol, --symbol
               p_effdate, --effdate
               p_expdate, --expdate
               p_quoteval, --quoteval
               p_publicval, --publicval
               0, --availval
               p_quoteprice, --quoteprice
               0, --subqtty
               0, --subamt
               0, --firmqtty
               0, --firmamt
               0, --settqtty
               0, --settamt
               0, --cancelqtty
               'A', --status
               SYSDATE, --lastchange
               --DECODE (p_category, 'C', NULL, 'T', p_productid, '0')
               p_productid, --productid
               0, --refissuid
               --p_refissuid, --refissuid
               nvl(l_reflegid,0), --reflegid
               p_txnum, --txnum
               nvl(l_dealeracct,p_account), --dealeraccount
               l_orgconfirmno, --orgconfirmno
               NULL, --refadid
               l_orgdate, --orgdate
               p_buyconfirmno, --buyconfirmno
               p_quoterate, --quoterate
               l_orgprice, --orgprice
               DECODE (p_category, 'C', p_productid, NULL), --comboid
               p_sellopt,
               p_coabr,
               p_maxqtty,
               p_cftype ,--
               p_cfonline, --
               p_maxqttypercus --
               ); --sellopt
               plog.debug(pkgctx, 'phong phanh');


    p_err_code := '';
    plog.setEndSection(pkgctx, 'prc_sysprocess');
exception when others then
    p_err_code := errnums.C_SYSTEM_ERROR;
    RAISE;

end;
/

DROP PROCEDURE prc_add_oxquote
/

CREATE OR REPLACE 
PROCEDURE prc_add_oxquote (p_txnum varchar2,
                            p_txdate date,
                            p_busdate date,
                            p_txtime varchar2,
                            p_tltxcd varchar2,
                            p_txdesc varchar2,
                            p_tlid varchar2,
                            p_offid varchar2,
                            p_account varchar2,
                            p_autoid_oxpost number,
                            p_quoteprice number,
                            p_quoterate number,
                            p_quoteqtty number,
                            p_err_code in out varchar2)
is
    l_currdate date;
    l_refpostid varchar2(100);
    l_quoteid varchar2(100);
    l_ioiacctno varchar2(100);
    l_codeid number;
    l_symbol varchar2(200);
    l_category varchar2(10);

    l_day number;


begin
    l_currdate := getcurrdate();

    select to_number(varvalue)
       into l_day
    from sysvar
    where varname = 'PAYMENT_C';

    select o.orderid, o.afacctno, o.symbol, o.category
        into l_refpostid, l_ioiacctno, l_symbol, l_category
    from oxpost o
    where o.autoid = p_autoid_oxpost;

    l_quoteid := to_char(p_txdate,'YYYYMMDD')||p_txnum;

    select autoid into l_codeid
    from assetdtl
    where symbol = l_symbol;

    -- Insert oxquote
    insert into oxquote(autoid,
                       refpostid,
                       quoteid,
                       txdate,
                       txtime,
                       traderid,
                       checkerid,
                       afacctno,
                       ioiacctno,
                       codeid,
                       symbol,
                       category,
                       side,
                       qtty,
                       amt,
                       expdate,
                       deltd,
                       status,
                       quoterate)
    values(seq_oxquote.nextval, --autoid,
           l_refpostid,--            refpostid,
           l_quoteid,--            quoteid,
           p_txdate,--            txdate,
           NVL (
               p_txtime,
               TO_CHAR (SYSDATE, fn_systemnums ('systemnums.c_time_format'))),--            txtime,
           p_tlid,--            traderid,
           p_offid,--            checkerid,
           p_account,--            afacctno,
           l_ioiacctno,--            ioiacctno,
           to_char(l_codeid),--            codeid,
           l_symbol,--            symbol,
           l_category,--            category,
           'B',--            side,
           p_quoteqtty,--            qtty,
           p_quoteprice,--            amt,
           fn_getnextbusinessdate(l_currdate, l_day),--            expdate,
           'N',--            deltd,
           'N',--            status,
           p_quoterate--            quoterate
           );

    update assetdtl
    set mrkprice = p_quoteprice
    where symbol = l_symbol;

    p_err_code := '';
exception when others then
    p_err_code := errnums.C_SYSTEM_ERROR;
    RAISE;

end;
/

DROP PROCEDURE prc_cancel_contract
/

CREATE OR REPLACE 
PROCEDURE prc_cancel_contract (
                p_confirmno varchar2,
                p_txdate date,
                p_txtime varchar2,
                p_txnum varchar2,
                p_tltxcd varchar2,
                p_desc varchar2,
                p_err_code in out varchar2)
is
l_orderid varchar2(100);
l_category varchar2(10);
l_execqtty number;
l_acbuyer varchar2(100);
l_acseller varchar2(100);
l_execamt number;
l_feebuyer number;
l_feeseller number;
l_taxseller number;
l_confirmno varchar2(100);
l_custodycdbuyer varchar2(100);
l_custodycdseller varchar2(100);
l_desc varchar2(1000);
l_parvalue number;
l_count number;


    pkgctx   plog.log_ctx;
    logrow   tlogdebug%ROWTYPE;
begin
    plog.setBeginSection(pkgctx, 'prc_cancel_contract');
 select o.confirmno, o.category, o.execqtty, o.feebuyer, o.feeseller, o.taxseller, o.execamt, o.acbuyer, o.acseller
        into l_confirmno,l_category,l_execqtty,l_feebuyer,l_feeseller,l_taxseller,l_execamt,l_acbuyer,l_acseller
        from oxmast o
        where o.confirmno = p_confirmno;
         l_custodycdbuyer:=fn_get_custodycd_by_acctno(l_acbuyer);
         l_custodycdseller:=fn_get_custodycd_by_acctno(l_acseller);


        for rec in (select * from oxmast o  where o.confirmno = p_confirmno)
          loop
               update oxmast o set o.status ='R' where o.orderid=rec.orderid;

                 l_desc:= p_desc;
                 -- giam secured nguoi bán
                   update semast s set
                        s.secured = s.secured- rec.execqtty
                        where s.afacctno = rec.acseller and s.symbol = rec.symbol;
                   -- insert setran giam secured ngu?i bán
                   INSERT INTO SETRAN
                    (TXNUM, TXDATE, ACCTNO, TXCD, NAMT, CAMT, "REF", DELTD, AUTOID, ACCTREF, TLTXCD, BKDATE, TRDESC, LVEL, VERMATCHING, SESSIONNO, NAV, FEEAMT, TAXAMT)
                    VALUES(p_txnum, p_txdate,rec.acseller||LPAD(fn_get_codeid_symbol(rec.symbol),6,'0'), '0005', rec.execqtty, NULL, '1', 'N', seq_setran.NEXTVAL, NULL, p_tltxcd, p_txdate, l_desc, 2, NULL, NULL, 0, 0, 0);


                if rec.status in ('A') then
                     -- update fee_dtl
                     update fee_dtl set deltd='Y' where orderid= rec.orderid and types='S';
                     -- giam firmqtty, firmamt lenh chao
                     update oxpost o set
                        o.firmqtty = o.firmqtty - rec.execqtty,
                        o.firmamt = o.firmamt - (rec.execamt)
                        where o.orderid = rec.refpostid;
                      -- giam semast.receiving nguoi mua
                     update semast s set
                        s.receiving = s.receiving- rec.execqtty
                        where s.afacctno = rec.acbuyer and s.symbol = rec.symbol;
                        -- insert setran giam receiving nguoi mua
                       INSERT INTO SETRAN
                        (TXNUM, TXDATE, ACCTNO, TXCD, NAMT, CAMT, "REF", DELTD, AUTOID, ACCTREF, TLTXCD, BKDATE, TRDESC, LVEL, VERMATCHING, SESSIONNO, NAV, FEEAMT, TAXAMT)
                        VALUES(p_txnum, p_txdate,rec.acbuyer||LPAD(fn_get_codeid_symbol(rec.symbol),6,'0'), '0007', rec.execqtty, NULL, '1', 'N', seq_setran.NEXTVAL, NULL, p_tltxcd, p_txdate, l_desc, 2, NULL, NULL, 0, 0, 0);
                        -- giam ivmast.netting nguoi mua
                        update ivmast i set
                            i.netting = i.netting - (rec.execamt + rec.feebuyer)
                            where i.afacctno = rec.acbuyer and i.symbol = rec.symbol;
                         -- insert ivtran giam netting nguoi mua
                        INSERT INTO ivtran
                          (txnum, txdate, acctno,codeid,symbol, txcd, namt, camt, ref,srtype, deltd, autoid, acctref, tltxcd, bkdate, trdesc, lvel)
                          VALUES(p_txnum, p_txdate,l_custodycdbuyer,fn_get_codeid_symbol(rec.symbol),rec.symbol, '0013', rec.execamt, NULL, '1','NN', 'N', seq_ivtran.NEXTVAL, '', p_tltxcd,
                          p_txdate,'' || l_desc || '', 2);
                          if rec.feebuyer <> 0 then
                               INSERT INTO ivtran
                              (txnum, txdate, acctno,codeid,symbol, txcd, namt, camt, ref,srtype, deltd, autoid, acctref, tltxcd, bkdate, trdesc, lvel)
                              VALUES(p_txnum, p_txdate, l_custodycdbuyer,fn_get_codeid_symbol(rec.symbol),rec.symbol, '0013', rec.feebuyer, NULL, '1','NN', 'N', seq_ivtran.NEXTVAL, '', p_tltxcd,
                              p_txdate,'' || l_desc || '', 2);
                        end if;
                      -- giam ivmast receiving nguoi ban

                      update ivmast i set
                            i.receiving = i.receiving - (rec.execamt - rec.feeseller - rec.taxseller)
                            where i.afacctno = rec.acseller and i.symbol = rec.symbol;
                        -- insert ivtran giam receiving nguoi ban
                        INSERT INTO ivtran
                          (txnum, txdate, acctno,codeid,symbol, txcd, namt, camt, ref,srtype, deltd, autoid, acctref, tltxcd, bkdate, trdesc, lvel)
                          VALUES(p_txnum, p_txdate, l_custodycdseller,fn_get_codeid_symbol(rec.symbol),rec.symbol, '0015', rec.execamt, NULL, '1','NN', 'N', seq_ivtran.NEXTVAL, '', p_tltxcd,
                          p_txdate,'' || l_desc || '', 2);

                      if (rec.feeseller <> 0 ) then
                           INSERT INTO ivtran
                          (txnum, txdate, acctno,codeid,symbol, txcd, namt, camt, ref,srtype, deltd, autoid, acctref, tltxcd, bkdate, trdesc, lvel)
                          VALUES(p_txnum, p_txdate, l_custodycdseller,fn_get_codeid_symbol(rec.symbol),rec.symbol, '0016', rec.feeseller, NULL, '1','NN', 'N', seq_ivtran.NEXTVAL, '', p_tltxcd,
                          p_txdate,'' || l_desc || '', 2);

                      end if;
                      if(rec.taxseller <> 0) then

                       INSERT INTO ivtran
                      (txnum, txdate, acctno,codeid,symbol, txcd, namt, camt, ref,srtype, deltd, autoid, acctref, tltxcd, bkdate, trdesc, lvel)
                      VALUES(p_txnum, p_txdate, l_custodycdseller,fn_get_codeid_symbol(rec.symbol),rec.symbol, '0016', rec.taxseller, NULL, '1','NN', 'N', seq_ivtran.NEXTVAL, '', p_tltxcd,
                      p_txdate,'' || l_desc || '', 2);
                      end if;

                        -- Hoàn han muc mua, ban'

                        prc_return_limit_sell_ref(rec.confirmno,p_err_code);
             end if;

            end loop;



    p_err_code := '';
    plog.setEndSection(pkgctx, 'prc_cancel_contract');
exception when others then
    p_err_code := errnums.C_SYSTEM_ERROR;
    RAISE;

end;
/

DROP PROCEDURE prc_cancel_oxquote
/

CREATE OR REPLACE 
PROCEDURE prc_cancel_oxquote (p_autoid number,
                            p_err_code in out varchar2)
is



begin
    update oxquote
    set status = 'R'
    where autoid = p_autoid;

    p_err_code := '';
exception when others then
    p_err_code := errnums.C_SYSTEM_ERROR;
    RAISE;

end;
/

DROP PROCEDURE prc_cancel_oxpost
/

CREATE OR REPLACE 
PROCEDURE prc_cancel_oxpost (txnum varchar2,
                            txdate date,
                            busdate date,
                            tltxcd varchar2,
                            txdesc varchar2,
                            p_autoid number,
                            p_err_code in out varchar2)
is
    l_acctno varchar2(4000);
    l_category varchar2(10);
    l_comboid number;
    l_symbol varchar2(200);
    l_availqtty number;
    l_issueid number;
    l_refpostid varchar2(100);
begin
    select o.afacctno, o.category, o.symbol, o.comboid, o.availval, o.refissuid, o.orderid
        into l_acctno, l_category, l_symbol, l_comboid, l_availqtty, l_issueid, l_refpostid
    from oxpost o
    where o.autoid = p_autoid;

    update oxpost
    set cancelqtty = l_availqtty,
        availval = 0,
        status = 'C'
    where autoid = p_autoid;

    -- Huy cac lenh dang thuong luong cho lenh chao
    for r in (select autoid
             from oxquote
             where refpostid = l_refpostid
                and status = 'N')
    loop
        prc_cancel_oxquote(r.autoid, p_err_code);

        if p_err_code <> '' then
            return;
        end if;
    end loop;



    -- Chao ban lan dau
    if l_category = 'I' then
        update deposit
        set sellquoteqtty = nvl(sellquoteqtty,0) - l_availqtty
        where autoid = l_issueid;
    else
    -- Chao ban trai phieu tron/HD ky han/Combo
        for r in (select l_symbol symbol, a.autoid codeid, 1 qtty
                 from assetdtl a
                 where a.symbol = l_symbol
                    and l_category in ('T','O')
                 union all
                select p.symbol, a.autoid codeid, sum(p.discount) qtty
                from comboproduct c, productier p, assetdtl a
                where c.id = l_comboid
                    and c.id = p.id
                    and a.symbol = p.symbol
                    and l_category = 'C'
                group by p.symbol, a.autoid)
        loop


            update semast
            set secured = secured - l_availqtty * r.qtty,
                lastchange = sysdate
            where afacctno = l_acctno and symbol = r.symbol;

            INSERT INTO setran(txnum,
                               txdate,
                               acctno,
                               txcd,
                               namt,
                               camt,
                               REF,
                               deltd,
                               autoid,
                               acctref,
                               tltxcd,
                               bkdate,
                               trdesc,
                               lvel,
                               vermatching,
                               sessionno,
                               nav,
                               feeamt,
                               taxamt)
            VALUES(txnum, --txnum
                    txdate, --txdate
                    l_acctno||lpad(r.codeid,6,'0'), --acctno
                    '0005', --txcd
                    l_availqtty * r.qtty, --namt
                    null, --camt
                    '1', --ref
                    'N', --deltd
                    seq_setran.NEXTVAL, --autoid
                    null, --acctref
                    tltxcd, --tltxcd
                    busdate, --bkdate
                    txdesc, --trdesc
                    2,--lvel,
                    null,--vermatching
                    null, --sessionno
                    0,--nav
                    0,--feeamt
                    0);--taxamt
        end loop;
    end if;

    p_err_code := '';
exception when others then
    p_err_code := errnums.C_SYSTEM_ERROR;
    RAISE;

end;
/

DROP PROCEDURE prc_create_schd
/

CREATE OR REPLACE 
PROCEDURE prc_create_schd (v_PrcName VARCHAR2,v_PrcStoreName VARCHAR2 )
AS

--Tao mot scheduler chay thu tuc v_PrcName, sau do Scheduler tu dong drop.
  v_count number(10);
    pkgctx     plog.log_ctx;
BEGIN
/*  SELECT count(*) INTO v_count FROM user_scheduler_jobs WHERE UPPER(JOB_NAME) =UPPER('SCHD_'||v_PrcName);


   plog.error(pkgctx, 'So tien trinh dang ton tai:'|| v_count);
  IF v_count =1 THEN

   DBMS_SCHEDULER.DROP_JOB(
   job_name           =>  'SCHD_'||v_PrcName);
   COMMIT;
  END IF;*/
  DBMS_SCHEDULER.CREATE_JOB (
 --dbms_job.submit(
   job_name           =>  v_PrcName,
   job_type           =>  'PLSQL_BLOCK',
   job_action         =>  'BEGIN '||v_PrcStoreName||'; END;',
   start_date         =>   systimestamp,
   --repeat_interval    =>  'freq=secondly; interval=5;',
   auto_drop          =>   TRUE,
   enabled             =>  TRUE,
   comments           => v_PrcName);
   COMMIT;
   EXCEPTION
    WHEN OTHERS THEN

      plog.error(pkgctx, sqlerrm || dbms_utility.format_error_backtrace);
      plog.setendsection(pkgctx, 'pr_genIPOSession');

END;
/

DROP PROCEDURE prc_focmdcode
/

CREATE OR REPLACE 
PROCEDURE prc_focmdcode (p_REFCURSOR IN OUT PKG_REPORT.REF_CURSOR,
                     p_err_code      in out varchar2,
                     p_err_param     in out varchar2) as
  pkgctx plog.log_ctx;
  logrow tlogdebug%rowtype;
  begin

    plog.setBeginSection(pkgctx, 'PRC_FOCMDCODE');


    p_err_code  := systemnums.C_SUCCESS;
    p_err_param := 'SUCCESS';

    Open p_refcursor for
        SELECT A.CMDCODE, A.CMDTEXT, A.CMDUSE, A.CMDTYPE, A.CMDDESC
        FROM FOCMDCODE A
        WHERE A.CMDUSE='Y';

    plog.setEndSection(pkgctx, 'PRC_FOCMDCODE');
  exception
    when others then
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error(pkgctx,'Err: ' || sqlerrm || ' Trace: ' || dbms_utility.format_error_backtrace );
      plog.setEndSection(pkgctx, 'PRC_FOCMDCODE');
  end PRC_FOCMDCODE;
/

DROP PROCEDURE prc_get_chart
/

CREATE OR REPLACE 
procedure prc_get_chart(p_REFCURSOR IN OUT PKG_REPORT.REF_CURSOR,
p_productid varchar2 ,
p_symbol varchar2,
p_custodycd varchar2,
 p_tlid varchar2,
 p_role varchar2,
 p_language varchar2,
 pv_objname varchar2,
 p_err_code in out varchar2,
 p_err_param in out varchar2)
AS
    l_err_code      integer;
    v_logsctx       varchar2(500);
    v_logsbody      varchar2(500);
    v_exception     varchar2(500);
    l_language      varchar2(20);
    l_sbsedefacct varchar2(100);
begin

    plog.setBeginSection(pkgctx, 'prc_get_chart');
    --plog.error(pkgctx, 'prc_get_chart');

    p_err_code  := systemnums.C_SUCCESS;
    p_err_param := 'SUCCESS';

   l_language := nvl(p_language, fn_systemnums('systemnums.vn_lang'));
	create temp table IF NOT exists temp_rate (
			months numberic,
			rate NUMERIC,
			symbol varchar2(200),
			productid varchar2(100),
			productname varchar2(100)
		);
	truncate  temp_rate;
for rec in 1..36 loop
		 insert
			into
			temp_rate (months,
			rate ,
			symbol ,
			productid ,
			productname)
		values (
		select
			rec months,
			fn_calc_rate_in(getcurrdate(),ADD_MONTHS(getcurrdate(),rec),p_symbol,p_productid,'1000000','1','SHBC000019') rate,
			p_symbol symbol,
			p_productid productid,
			fn_get_shortname_by_productid(p_productid) productname)
			
			
	
			

	end loop;
    OPEN p_refcursor for
  SELECT * FROM tmp_rate ORDER BY months ASC;

 plog.setEndSection(pkgctx, 'prc_get_chart');
  exception
    when others then
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error(pkgctx,'Err: ' || sqlerrm || ' Trace: ' || dbms_utility.format_error_backtrace );
      plog.setEndSection(pkgctx, 'prc_get_chart');
  end prc_get_chart;
 ---------------------------------------------------------------------------------------------------------
/

DROP PROCEDURE prc_insertemaillog
/

CREATE OR REPLACE 
PROCEDURE prc_insertemaillog (p_email IN VARCHAR2,
                                   p_templateID IN VARCHAR2,
                                   p_datasource IN VARCHAR2,
                                   p_custodycd IN VARCHAR2,
                                   p_txdate IN DATE,
                                   p_otp IN VARCHAR2 default null)
is
    l_seq_emaillog number;
begin

    l_seq_emaillog := seq_emaillog.NEXTVAL;
    insert into emaillog(autoid, email, templateid, datasource, status, createtime, custodycd,typesms, txdate, otp)
    values (l_seq_emaillog, p_email, p_templateID, p_datasource, 'A', sysdate, p_custodycd,'', p_txdate, p_otp);
    txpks_notify.prc_system_jsonnotify(l_seq_emaillog);

exception when others then
    RAISE;

end;
/

DROP PROCEDURE prc_return_limit_buy_ref
/

CREATE OR REPLACE 
PROCEDURE prc_return_limit_buy_ref (p_confirmno varchar2,p_err_code in out varchar2)
is
    l_methodLimitSellTotal VARCHAR2(10);
    l_methodLimitSellSymbol VARCHAR2(10);
    l_methodLimitSellProduct VARCHAR2(10);
    l_price_by_total number;
    l_price_by_symbol number;
    l_price_by_product number;

    pkgctx   plog.log_ctx;
    logrow   tlogdebug%ROWTYPE;
begin
    plog.setBeginSection(pkgctx, 'prc_return_limit_sell_ref');

 for rec in
    (select s.dealeracctno,s.symbol,s.confirmno, s.orgconfirmno,o.productid
     from sereqclose s
     left join oxmast o
     on o.confirmno = s.orgconfirmno
     where s.confirmno = p_confirmno)
 loop
            --  huy ghi nh?n h?n m?c mua l?i
            update boughtdtl set deltd ='Y' where confirmno = rec.confirmno and trntype='D' and deltd ='N';
            update boughtdtl set deltd ='Y' where return_confirmno = rec.confirmno and trntype='C' and deltd ='N';
            l_methodLimitSellTotal:= fn_get_limit_method_sell_total(rec.dealeracctno);
            l_methodLimitSellSymbol:= fn_get_limitmethod_sell_symbol(rec.dealeracctno,rec.symbol);
            l_methodLimitSellProduct:= fn_get_limit_method_sell_pro(rec.dealeracctno,rec.symbol,fn_get_shortname_by_productid(rec.productid));
            -- huy hoan han muc ban ra
           for rec2 in
            (select * from solddtl where  confirmno = rec.confirmno and trntype='C' and deltd ='N')
            LOOP
                if l_methodLimitSellTotal is not null then
                    select DECODE(l_methodLimitSellTotal,'F',rec2.parvalue,'P',rec2.price) into l_price_by_total from dual;
                end if;
                if l_methodLimitSellSymbol is not null then
                    select DECODE(l_methodLimitSellSymbol,'F',rec2.parvalue,'P',rec2.price) into l_price_by_symbol from dual;
                end if;
                if l_methodLimitSellProduct is not null then
                  select DECODE(l_methodLimitSellProduct,'F',rec2.parvalue,'P',rec2.price) into l_price_by_product from dual;
                end if;

                 update solddtl  set return_qtty = return_qtty - rec2.qtty ,
                                   return_limit =    return_limit - nvl(l_price_by_total*rec2.qtty,0),
                                   return_limit_ass = return_limit_ass - nvl(l_price_by_symbol*rec2.qtty,0),
                                   return_limit_prd = return_limit_prd - nvl(l_price_by_product*rec2.qtty,0)
                                 where confirmno = rec2.return_confirmno;
                 END LOOP;
              update solddtl  set deltd ='Y' where confirmno = rec.confirmno and  trntype='C' and deltd ='N';
             --end if;
         end loop;





    p_err_code := '';
    plog.setEndSection(pkgctx, 'prc_return_limit_sell_ref');
exception when others then
    p_err_code := errnums.C_SYSTEM_ERROR;
    RAISE;

end;
/

DROP PROCEDURE prc_process_8302
/

CREATE OR REPLACE 
PROCEDURE prc_process_8302
                            (
                            p_txnum varchar2,
                            p_txdate date,
                            p_busdate date,
                            p_txtime varchar2,
                            p_tltxcd varchar2,
                            p_txdesc varchar2,
                            p_tlid varchar2,
                            p_offid varchar2,
                            p_confirmno  varchar2,
                            p_txnumref  varchar2,
                            p_mode  varchar2,
                            p_reason varchar2,
                            p_err_code in out varchar2
                            )
   IS
    l_confirmno varchar2(100);
    l_mode varchar2(10);
    l_txnum varchar2(100);
    l_ttkd_profile_stat varchar2(50);
    l_bks_profile_stat varchar2(50);
    l_appr_stat varchar2(50);
    l_oxtype varchar2(50);
    l_reason varchar2(500);
    l_pstatus varchar2(50);
    l_status varchar2(50);
    l_TTKD_APPROVE_BUY varchar2(10);
    l_BKS_APPROVE_BUY varchar2(10);
    l_desc varchar2(500);
    l_symbol varchar2(100);
    l_acbuyer varchar2(100);
    l_acseller varchar2(100);
    l_feecn number;
    l_agency_name varchar2(100);
    l_agency_email varchar2(100);
    l_data_source varchar2(4000);
    l_qtty number;
    l_contractno varchar2(500);
    l_autoid varchar2(100);
    l_orderid varchar2(100);
    l_count number;
    l_status_sereqclose varchar2(10);
   pkgctx   plog.log_ctx;
    logrow   tlogdebug%ROWTYPE;
--
-- To modify this template, edit file PROC.TXT in TEMPLATE
-- directory of SQL Navigator
--
-- Purpose: Briefly explain the functionality of the procedure
--
-- MODIFICATION HISTORY
-- Person      Date    Comments
-- ---------   ------  -------------------------------------------

   -- Declare program variables as shown above
BEGIN
    l_confirmno:=p_confirmno;
    l_mode:=p_mode;
    l_txnum:=p_txnumref;
    l_reason:=p_reason;
    select status into l_status_sereqclose from sereqclose where confirmno =l_confirmno;
    select s.varvalue into l_TTKD_APPROVE_BUY from sysvar s where s.varname='TTKD_APPROVE_BUY';
    select s.varvalue into l_BKS_APPROVE_BUY from sysvar s where s.varname='BKS_APPROVE_BUY';
--    select oxtype, status, pstatus into l_oxtype, l_status,l_pstatus from profilemanager where confirmno=l_confirmno and txnum = l_txnum;
    if l_mode ='C' then
        update profilemanager p
        set p.status ='C',
        p.offid = p_tlid,
        p.pstatus = p.status
        where p.confirmno =l_confirmno and p.txnum = l_txnum;
        update sereqclose set status = 'C' where confirmno = l_confirmno and status ='A';
        update sereqclose set last_update_prof_dt = getcurrdate() where confirmno = l_confirmno;
        select ttkd_profile_stat , appr_stat, bks_profile_stat ,acctno, symbol, dealeracctno, quantity, contract_no
        into l_ttkd_profile_stat, l_appr_stat, l_bks_profile_stat ,l_acbuyer,l_symbol,l_acseller, l_qtty, l_contractno
        from sereqclose where confirmno=l_confirmno;
        -- khong can BKS, TTKD duyet
        if l_ttkd_profile_stat ='U' then
            if l_TTKD_APPROVE_BUY ='N' and l_BKS_APPROVE_BUY ='N' then
               update sereqclose s
               set s.ttkd_profile_stat = 'C' , s.ttkd_reason='',
                    s.bks_profile_stat = 'C' , s.bks_reason='',
                    s.status = 'F'
                 where s.confirmno = l_confirmno;
            end if;

            -- Can TTKD  duyet
            if l_TTKD_APPROVE_BUY ='Y'  then
                  update sereqclose s set s.ttkd_profile_stat = 'A'
                 where s.confirmno = l_confirmno ;

            end if;

            -- khong can TTKD, can BKS
            if l_TTKD_APPROVE_BUY ='N' and l_BKS_APPROVE_BUY ='Y' then
             update sereqclose s set s.ttkd_profile_stat = 'C', s.ttkd_reason='', s.bks_profile_stat = 'A'
                 where s.confirmno = l_confirmno ;
            end if;

        elsif l_ttkd_profile_stat ='C' and l_bks_profile_stat ='U' then
        -- khong can bks phe duyet
            if  l_BKS_APPROVE_BUY ='N' then
               update sereqclose s set s.bks_profile_stat = 'C' , s.bks_reason=''
                 where s.confirmno = l_confirmno;


            end if;

            -- Can BKS  duyet
            if l_BKS_APPROVE_BUY ='Y'  then

                  update sereqclose s set s.bks_profile_stat = 'A'
                 where s.confirmno = l_confirmno ;

            end if;


        end if;


    end if;


    if l_mode ='R' then
        if l_status_sereqclose ='A' then
            update profilemanager p
            set p.status ='R',
            p.note = l_reason
            /*p.pstatus = l_status*/
            where p.confirmno =l_confirmno and p.txnum = l_txnum and p.status='P';
            /*FOR rec in (select * from profilemanager   where confirmno = l_confirmno and status = 'D' and oxtype = 'B')
            LOOP

                     update profilemanager set status = rec.pstatus, pstatus = '' where confirmno = l_confirmno and status = 'D' and oxtype = rec.oxtype and autoid = rec.autoid;

            END LOOP;*/

        -- xu ly huy HD mua lai
                for rec3 in (select * from sereqclose s where  s.confirmno=l_confirmno )
                    loop

                        -- cap nhat status =R
                            update sereqclose s set s.status = 'R' where s.confirmno= rec3.confirmno;
                            -- giam oxmast.pending_clsqtty
                            update oxmast o set
                                o.pending_clsqtty=o.pending_clsqtty - rec3.quantity
                                    where o.confirmno=rec3.orgconfirmno
                                    --and o.orderid = l_orderid
                                    ;

                            -- giam semast.secured KH 0005
                            update semast s set
                                s.secured = s.secured- rec3.quantity
                                where s.afacctno = rec3.acctno and s.symbol = rec3.symbol;
                                l_desc:= 'Huy yeu cau tat toan  '||to_char(rec3.confirmno)||' ' ;
                           INSERT INTO SETRAN
                            (TXNUM, TXDATE, ACCTNO, TXCD, NAMT, CAMT, "REF", DELTD, AUTOID, ACCTREF, TLTXCD, BKDATE, TRDESC, LVEL, VERMATCHING, SESSIONNO, NAV, FEEAMT, TAXAMT)
                            VALUES(p_txnum, p_txdate,rec3.acctno||LPAD(fn_get_codeid_symbol(rec3.symbol),6,'0'), '0005', rec3.quantity, NULL, '1', 'N', seq_setran.NEXTVAL, NULL, p_tltxcd, p_txdate, l_desc, 2, NULL, NULL, 0, 0, 0);
                            --


                            -- giam semast.receiving dai ly 0007
                            update semast s set
                                --s.receiving = s.receiving- (rec3.quantity* rec3.price)
                                s.receiving = s.receiving- rec3.quantity
                                where s.afacctno = rec3.dealeracctno and s.symbol = rec3.symbol;
                                l_desc:= 'Huy yeu cau tat toan  ' ||to_char(rec3.confirmno)||' ' ;
                           INSERT INTO SETRAN
                            (TXNUM, TXDATE, ACCTNO, TXCD, NAMT, CAMT, "REF", DELTD, AUTOID, ACCTREF, TLTXCD, BKDATE, TRDESC, LVEL, VERMATCHING, SESSIONNO, NAV, FEEAMT, TAXAMT)
                            VALUES(p_txnum, p_txdate,rec3.dealeracctno||LPAD(fn_get_codeid_symbol(rec3.symbol),6,'0'), '0007', rec3.quantity, NULL, '1', 'N', seq_setran.NEXTVAL, NULL, p_tltxcd, p_txdate, l_desc, 2, NULL, NULL, 0, 0, 0);

                            --giam ivmast.netting DL 0013
                            update ivmast i set
                                 i.netting = i.netting - (rec3.quantity* rec3.price)
                                where i.afacctno = rec3.dealeracctno and i.symbol = rec3.symbol;
                                l_desc:= 'Huy yeu cau tat toan  '||to_char(rec3.confirmno)||' ' ;
                            INSERT INTO ivtran
                              (txnum, txdate, acctno,codeid,symbol, txcd, namt, camt, ref,srtype, deltd, autoid, acctref, tltxcd, bkdate, trdesc, lvel)
                              VALUES(p_txnum, p_txdate, fn_get_custodycd_by_acctno(rec3.dealeracctno),fn_get_codeid_symbol(rec3.symbol),rec3.symbol, '0013', rec3.quantity*rec3.price, NULL, '1','NN', 'N', seq_ivtran.NEXTVAL, '', p_tltxcd,
                              p_txdate,'' || l_desc || '', 2);
                         -- giam ivmast.receiving khach hang 0015 0016
                            update ivmast i set
                                i.receiving = i.receiving - (rec3.quantity* rec3.price - rec3.taxamt - rec3.feeamt-rec3.feesettamt)
                                where i.afacctno = rec3.acctno and i.symbol = rec3.symbol;

                            l_desc:= 'Huy yeu cau tat toan  ' ||to_char(rec3.confirmno)||' ' ;
                            INSERT INTO ivtran
                              (txnum, txdate, acctno,codeid,symbol, txcd, namt, camt, ref,srtype, deltd, autoid, acctref, tltxcd, bkdate, trdesc, lvel)
                              VALUES(p_txnum, p_txdate, fn_get_custodycd_by_acctno(rec3.acctno),fn_get_codeid_symbol(rec3.symbol),rec3.symbol, '0015', rec3.quantity * rec3.price, NULL, '1','NN', 'N', seq_ivtran.NEXTVAL, '', p_tltxcd,
                              p_txdate,'' || l_desc || '', 2);

                            if(rec3.feeamt <> 0) then
                                l_desc:= 'Huy yeu cau tat toan  '||to_char(rec3.confirmno)||' ' ;
                                INSERT INTO ivtran
                                (txnum, txdate, acctno,codeid,symbol, txcd, namt, camt, ref,srtype, deltd, autoid, acctref, tltxcd, bkdate, trdesc, lvel)
                                VALUES(p_txnum, p_txdate, fn_get_custodycd_by_acctno(rec3.acctno),fn_get_codeid_symbol(rec3.symbol),rec3.symbol, '0016', rec3.feeamt, NULL, '1','NN', 'N', seq_ivtran.NEXTVAL, '', p_tltxcd,
                                p_txdate,'' || l_desc || '', 2);
                            end if;

                            if(rec3.taxamt <> 0) then
                                l_desc:= 'Huy yeu cau tat toan  '||to_char(rec3.confirmno)||' ' ;
                                INSERT INTO ivtran
                                (txnum, txdate, acctno,codeid,symbol, txcd, namt, camt, ref,srtype, deltd, autoid, acctref, tltxcd, bkdate, trdesc, lvel)
                                VALUES(p_txnum, p_txdate, fn_get_custodycd_by_acctno(rec3.acctno),fn_get_codeid_symbol(rec3.symbol),rec3.symbol, '0016', rec3.taxamt, NULL, '1','NN', 'N', seq_ivtran.NEXTVAL, '', p_tltxcd,
                                p_txdate,'' || l_desc || '', 2);
                            end if;

                          /*  if(rec3.feesettamt <> 0) then
                                l_desc:= 'Huy yeu cau tat toan  '||to_char(rec3.confirmno)||' ' ;
                                INSERT INTO ivtran
                                (txnum, txdate, acctno,codeid,symbol, txcd, namt, camt, ref,srtype, deltd, autoid, acctref, tltxcd, bkdate, trdesc, lvel)
                                VALUES(p_txnum, p_txdate, fn_get_custodycd_by_acctno(rec3.acctno),fn_get_codeid_symbol(rec3.symbol),rec3.symbol, '0016', rec3.feesettamt, NULL, '1','NN', 'N', seq_ivtran.NEXTVAL, '', p_tltxcd,
                                p_txdate,'' || l_desc || '', 2);
                            end if;*/
                            -- update fee_dtl
                         update fee_dtl set deltd ='Y' where orderid = rec3.confirmno and types='B';
                        -- Han sua han muc ngay 16/6/2021
                        -- h?y hoan han muc ban ra , mua l?i cua sereqclose
                         prc_return_limit_buy_ref(rec3.confirmno,p_err_code);
                            /*IF p_err_code IS NOT NULL THEN
                                RETURN p_err_code;
                            END IF;*/

                     -- END

                            select o.orderid into l_orderid from oxmast o where o.confirmno= rec3.orgconfirmno;
                           txpks_notify.prc_system_logevent('8302', 'OXMASTS',  'ALL'|| '~#~' ||'ALL'|| '~#~' ||l_orderid, 'R','INSERT/UPDATE OXMAST');

                    end loop;
              end if;

            if l_status_sereqclose ='S' then
                update profilemanager p
                set p.status ='R',
                p.note = l_reason
                where p.confirmno =l_confirmno and p.txnum = l_txnum and p.status ='P';
                FOR rec in (select * from profilemanager   where confirmno = l_confirmno and status = 'D' and oxtype = 'B')
                LOOP

                    update profilemanager set status = rec.pstatus, pstatus = '' where confirmno = l_confirmno and status = 'D' and oxtype = rec.oxtype and autoid = rec.autoid;

               END LOOP;
            end if;
        end if;
     select s.autoid into l_autoid from sereqclose s where s.confirmno = p_confirmno;
     txpks_notify.prc_system_logevent('8302', 'SEREQCLOSE',  'ALL'|| '~#~' ||'ALL'|| '~#~' ||l_autoid, 'R','INSERT/UPDATE SEREQCLOSE');

    p_err_code := '';
    plog.setEndSection(pkgctx, 'prc_sysprocess');
exception when others then
    p_err_code := errnums.C_SYSTEM_ERROR;
    RAISE;

end;
/

DROP PROCEDURE prc_process_0404
/

CREATE OR REPLACE 
PROCEDURE prc_process_0404 (p_txnum varchar2,
                            p_txdate date,
                            p_busdate date,
                            p_txtime varchar2,
                            p_tltxcd varchar2,
                            p_txdesc varchar2,
                            p_tlid varchar2,
                            p_offid varchar2,
                            p_orderid varchar2,
                            p_pricesellback number,
                            p_quantity number,
                            p_fee number,
                            p_tax number,
                            p_total number,
                            p_rate number,
                            p_moneytransder varchar2,
                            p_inadvance varchar2,
                            p_err_code in out varchar2)
is
    l_count                 NUMBER;
    l_currdate              DATE;
    l_acseller              varchar2(1000);
    l_acbuyer               varchar2(1000);
    l_symbol                varchar2(1000);
    l_execamt               NUMBER;
    l_autoid_symbol         NUMBER;
    l_confirmno             varchar2(1000);
    l_contract_no           varchar2(1000);
    l_autoid_sold           NUMBER;
    l_price_sold            NUMBER;
    l_parvalue_sold         NUMBER;
    l_parvalue              NUMBER;
    l_return_limit          NUMBER;
    l_before_limit          NUMBER;
    l_limit_total           NUMBER;
    l_limit_symbol          NUMBER;
    l_remain_limit          NUMBER;
    l_confirmno_sold        varchar2(1000);
    l_seq                   varchar2(1000);
    l_FEEBUYER              NUMBER;
    l_TAXBUYER              NUMBER;
    l_product_name varchar2(100);
    l_method_total varchar2(10);
    l_method_symbol VARCHAR2(10);
    l_method_product varchar2(10);
    l_limit_product number;
    l_limit_total_remain number ;
    l_limit_symbol_remain number ;
    l_limit_product_remain number;
    l_return_limit_total number;
    l_return_limit_symbol number;
    l_return_limit_product number;
    l_method varchar2(10);
    l_limit_buy_total_remain number;
    l_limit_buy_symbol_remain number;
    l_limit_buy_product_remain number;
    l_limit_method_buy_total varchar2(10);
    l_limit_method_buy_symbol varchar2(10);
    l_limit_method_buy_product varchar2(10);
    l_price_by_total number;
    l_price_by_symbol number;
    l_price_by_product number;
    l_price_buy_after_fee number;
    l_couponrate number;
    l_islisted varchar2(10);
    l_feesettamt number;
    l_txdate date;
    l_productid varchar2(100);
    l_status varchar2(10);
    pkgctx   plog.log_ctx;
    logrow   tlogdebug%ROWTYPE;
begin
    plog.setBeginSection(pkgctx, 'prc_sysprocess');
    plog.debug(pkgctx,'LOG.0404.BEGIN');
    l_currdate := getcurrdate();
    l_return_limit := 0;
    l_seq := lpad(to_char(seq_sereqclose.nextval),9,'0');

    SELECT o.ACSELLER,o.ACBUYER,o.SYMBOL,o.EXECAMT,o.CONFIRMNO ,o.FEEBUYER,o.TAXBUYER, p.shortname, o.islisted,o.productid,o.txdate
    INTO l_acseller,l_acbuyer,l_symbol,l_execamt,l_confirmno,l_FEEBUYER,l_TAXBUYER, l_product_name, l_islisted,l_productid,l_txdate
    FROM OXMAST o
    left join product p on p.autoid = o.productid
    WHERE o.ORDERID = p_orderid;

    SELECT a.AUTOID INTO l_autoid_symbol  FROM ASSETDTL a WHERE a.SYMBOL = l_symbol;

    SELECT o.BRID ||'.'||o.SALE_MANAGER_ID||'.'||o.idbuyer||'.'||l_seq||'.'||CASE WHEN o.CATEGORY ='T' THEN p.SHORTNAME ELSE o.SYMBOL END ||'/HÐTP-M-'||o.CONFIRMNO ||'/SHB'
        INTO l_contract_no
        FROM OXMAST o
        LEFT JOIN PRODUCT p
            ON o.PRODUCTID = p.AUTOID
        WHERE o.ORDERID = p_orderid;

   l_feesettamt:= round(fn_calc_feebuy(P_PRODUCTID=>l_productid, P_FRDATE=>l_txdate, P_TODATE=>getcurrdate, P_AMT=>p_pricesellback*p_quantity),0);
   if p_tlid ='686868' then
        l_status:='C';
   else
        l_status :='A' ;
   end if;
    -- insert sereqclose
    INSERT INTO SEREQCLOSE (AUTOID ,ACCTNO ,DEALERACCTNO ,SYMBOL ,QUANTITY ,PRICE ,
                STATUS ,TXDATE ,"REF" ,TXTIME ,ORGCONFIRMNO ,
                TAXAMT ,FEEAMT ,TLID ,OFFID ,CONFIRMNO ,CONTRACT_NO ,TTKD_PROFILE_STAT ,BKS_PROFILE_STAT ,APPR_STAT ,SETT_STAT ,TRANSFER_STAT ,
                ACCOUNTING_STAT ,ISTRANSFER, INTRATE,ISLISTED,ISPUSHED,MONEYTRANSFER, INADVANCE
    )
    VALUES(seq_SEREQCLOSE.nextval,l_acbuyer,l_acseller,l_symbol,p_quantity,p_pricesellback,
            l_status,p_txdate,p_txnum,p_txtime,l_confirmno,
            p_tax,p_fee,p_tlid,p_offid,l_seq,l_contract_no,'N','N','N','N','N','N',
            'N', fn_get_intrate_symbol(l_symbol, getcurrdate()),l_islisted,'N',p_moneytransder,p_inadvance);

        -- update oxmast
        UPDATE OXMAST SET PENDING_CLSQTTY  = PENDING_CLSQTTY + p_quantity WHERE ORDERID = p_orderid;
        -- Tang semast.secured khách hàng
        UPDATE SEMAST SET SECURED = SECURED + p_quantity WHERE afacctno = l_acbuyer and symbol = l_symbol;
        -- insert setran
        INSERT INTO SETRAN
        (TXNUM, TXDATE, ACCTNO, TXCD, NAMT, CAMT, "REF", DELTD, AUTOID, ACCTREF, TLTXCD, BKDATE, TRDESC, LVEL, VERMATCHING, SESSIONNO, NAV, FEEAMT, TAXAMT)
        VALUES(p_txnum,  p_txdate,l_acbuyer ||lpad(l_autoid_symbol,6,0) , '0006', p_quantity, NULL, '1', 'N', seq_setran.nextval, NULL, '0404', p_busdate,
        'Yeu cau tat toan HD ' ||l_contract_no,
         2, NULL, NULL, 0, 0, 0);

        -- tang semast.receiving d?i lý
        UPDATE SEMAST SET RECEIVING = RECEIVING  + p_quantity  WHERE AFACCTNO = l_acseller AND SYMBOL = l_symbol;
        INSERT INTO SETRAN
        (TXNUM, TXDATE, ACCTNO, TXCD, NAMT, CAMT, "REF", DELTD, AUTOID, ACCTREF, TLTXCD, BKDATE, TRDESC, LVEL, VERMATCHING, SESSIONNO, NAV, FEEAMT, TAXAMT)
        VALUES(p_txnum,  p_txdate,l_acseller ||lpad(l_autoid_symbol,6,0) , '0008', p_quantity, NULL, '1', 'N', seq_setran.nextval, NULL, '0404', p_busdate,
        'Yeu cau tat toan HD '||l_contract_no, 2, NULL, NULL, 0, 0, 0);

        -- Tang ivmast.netting d?i lý
        UPDATE IVMAST  SET NETTING = NETTING + (p_quantity * p_pricesellback) WHERE  afacctno = l_acseller AND SYMBOL = l_symbol;
        -- insert ivtran
        INSERT INTO IVTRAN
        (AUTOID, TXNUM, TXDATE, TLTXCD, BKDATE, TRDESC, ACCTNO, CODEID, SYMBOL, SRTYPE, TXCD, NAMT, CAMT, "REF", DELTD, ACCTREF, LVEL)
        VALUES(seq_IVTRAN.nextval, p_txnum, p_txdate, p_tltxcd,p_busdate,
        'Tien can thanh toan KH cho yeu cau tat toan HD ' || l_contract_no, fn_get_custodycd_by_acctno(l_acseller), l_autoid_symbol,
        l_symbol, 'NN', '0012', p_quantity * p_pricesellback, NULL, '1', 'N', NULL, 2);

        -- tang ivmast.receiving khách hàng
        UPDATE IVMAST  SET RECEIVING = RECEIVING + nvl(p_total,0) WHERE AFACCTNO = l_acbuyer AND SYMBOL = l_symbol;
        -- Tang execamt
        INSERT INTO IVTRAN
        (AUTOID, TXNUM, TXDATE, TLTXCD, BKDATE, TRDESC, ACCTNO, CODEID, SYMBOL, SRTYPE, TXCD, NAMT, CAMT, "REF", DELTD, ACCTREF, LVEL)
        VALUES(seq_IVTRAN.nextval, p_txnum, p_txdate, p_tltxcd,p_busdate,
        'Tien tat toan HD ' || l_contract_no, fn_get_custodycd_by_acctno(l_acbuyer), l_autoid_symbol,
        l_symbol, 'NN', '0016',p_quantity * p_pricesellback , NULL, '1', 'N', NULL, 2);

        IF p_fee <> 0 THEN
            INSERT INTO IVTRAN
            (AUTOID, TXNUM, TXDATE, TLTXCD, BKDATE, TRDESC, ACCTNO, CODEID, SYMBOL, SRTYPE, TXCD, NAMT, CAMT, "REF", DELTD, ACCTREF, LVEL)
            VALUES(seq_IVTRAN.nextval, p_txnum, p_txdate, p_tltxcd,p_busdate,
            'Phi ban HD ' ||l_contract_no,
            fn_get_custodycd_by_acctno(l_acbuyer), l_autoid_symbol,
            l_symbol, 'NN', '0015', p_fee, NULL, '1', 'N', NULL, 2);
        END IF;

        -- Tang taxseller
        IF p_tax <> 0 THEN
            INSERT INTO IVTRAN
            (AUTOID, TXNUM, TXDATE, TLTXCD, BKDATE, TRDESC, ACCTNO, CODEID, SYMBOL, SRTYPE, TXCD, NAMT, CAMT, "REF", DELTD, ACCTREF, LVEL)
            VALUES(seq_IVTRAN.nextval, p_txnum, p_txdate, p_tltxcd,p_busdate,
            'Thue ban HD ' || l_contract_no,
            fn_get_custodycd_by_acctno(l_acbuyer), l_autoid_symbol,
            l_symbol, 'NN', '0015', p_tax, NULL, '1', 'N', NULL, 2);
        END IF;


    SELECT PARVALUE INTO l_parvalue FROM ASSETDTL a WHERE SYMBOL = l_symbol;

    -- ghi nh?n h?n m?c mua l?i, hoàn h?n m?c bán ra
    for rec in (SELECT *  FROM SOLDDTL s WHERE TRNTYPE ='D' AND CONFIRMNO = l_confirmno AND (QTTY - RETURN_QTTY > 0 ))
    loop

        l_limit_total_remain := fn_calc_limitsell_total_remain(l_acseller);
        l_limit_symbol_remain := fn_cal_limitsell_symbol_remain(l_acseller, l_symbol);
        l_limit_product_remain:= fn_cal_limitsell_pro_remain(l_acseller,l_symbol,l_product_name);
        l_limit_total:= fn_get_limitval_total(l_acseller);
        l_limit_symbol:=fn_get_limitval_symbol(l_acseller,l_symbol);
        l_limit_product:= fn_get_limitval_product(l_acseller,l_symbol,l_product_name);

        SELECT AUTOID,PRICE,CONFIRMNO,PARVALUE INTO l_autoid_sold,l_price_sold,l_confirmno_sold,l_parvalue_sold  FROM SOLDDTL s WHERE TRNTYPE ='D' AND CONFIRMNO = l_confirmno AND (QTTY - RETURN_QTTY > 0 );
        -- update solddtl
        UPDATE SOLDDTL SET RETURN_QTTY = RETURN_QTTY + p_quantity WHERE TRNTYPE ='D' AND CONFIRMNO = l_confirmno  ;
        l_method_total:= fn_get_limit_method_sell_total(l_acseller);
        l_method_symbol:= fn_get_limitmethod_sell_symbol(l_acseller,l_symbol);
        l_method_product:=fn_get_limit_method_sell_pro(l_acseller,l_symbol,l_product_name);
         if l_method_total is not null then
            SELECT
                decode(l_method_total, 'F', rec.parvalue, 'P', rec.price) * p_quantity INTO l_return_limit_total
            FROM DUAL;
             UPDATE SOLDDTL SET RETURN_LIMIT = RETURN_LIMIT +  l_return_limit_total WHERE TRNTYPE ='D' AND CONFIRMNO = l_confirmno  ;
         end if;
         if l_method_symbol is not null then
            SELECT
                decode(l_method_symbol, 'F', rec.parvalue, 'P', rec.price) * p_quantity INTO l_return_limit_symbol
            FROM DUAL;
             UPDATE SOLDDTL SET RETURN_LIMIT_ASS = RETURN_LIMIT_ASS +  l_return_limit_symbol WHERE TRNTYPE ='D' AND CONFIRMNO = l_confirmno  ;
         end if;
         if l_method_product is not null then
            SELECT
                decode(l_method_product, 'F', rec.parvalue, 'P', rec.price) * p_quantity INTO l_return_limit_product
            FROM DUAL;
             UPDATE SOLDDTL SET RETURN_LIMIT_PRD = RETURN_LIMIT_PRD +  l_return_limit_product WHERE TRNTYPE ='D' AND CONFIRMNO = l_confirmno  ;
         end if;
    --END IF;

        --plog.debug(pkgctx,'LOG.0404.l_remain_limit : '||l_remain_limit);
        INSERT INTO SOLDDTL(AUTOID ,ACCTNO ,SYMBOL ,TLTXCD ,PRICE ,PARVALUE ,QTTY ,CONFIRMNO ,TRNTYPE ,RETURN_QTTY ,RETURN_CONFIRMNO ,TRNDATE,
        BEFORE_LIMIT,REMAIN_LIMIT ,RETURN_LIMIT,
        BEFORE_LIMIT_ASS,REMAIN_LIMIT_ASS ,RETURN_LIMIT_ASS,
        BEFORE_LIMIT_PRD,REMAIN_LIMIT_PRD ,RETURN_LIMIT_PRD,
        DELTD, product
        )
        VALUES (seq_SOLDDTL.nextval,l_acseller,l_symbol,p_tltxcd,l_price_sold,l_parvalue,p_quantity,l_seq,
        'C',0,l_confirmno_sold,LOCALTIMESTAMP,
        nvl(l_limit_total_remain,''),
        nvl(LEAST(l_limit_total,  l_limit_total_remain + l_return_limit_total),''),
        0,
         nvl(l_limit_symbol_remain,''),
        nvl(LEAST(l_limit_symbol,  l_limit_symbol_remain + l_return_limit_symbol),''),
        0,
         nvl(l_limit_product_remain,''),
        nvl(LEAST(l_limit_product,  l_limit_product_remain + l_return_limit_product),''),
        0,
        'N',
        l_product_name);

 end loop;



    --insert Boughtdtl

    l_limit_buy_total_remain := fn_cal_limit_buy_remain_total(l_acseller);
    l_limit_buy_symbol_remain := fn_cal_limit_buy_remain_symbol(l_acseller, l_symbol);
    l_limit_buy_product_remain:= fn_cal_limit_buy_remain_prd(l_acseller,l_symbol,l_product_name);
    l_limit_method_buy_total:= fn_get_limit_method_buy_total(l_acseller);
    l_limit_method_buy_symbol:=fn_get_limit_method_buy_symbol(l_acseller,l_symbol);
    l_limit_method_buy_product:= fn_get_limit_method_buy_prd(l_acseller,l_symbol,l_product_name);
    l_price_buy_after_fee:= round(p_total/p_quantity,0);

    if l_limit_method_buy_total is not null then
        SELECT
                decode(l_limit_method_buy_total, 'F', l_parvalue, 'P', l_price_buy_after_fee) INTO l_price_by_total from dual;
    end if;
     if l_limit_method_buy_symbol is not null then
        SELECT
                decode(l_limit_method_buy_symbol, 'F', l_parvalue, 'P', l_price_buy_after_fee) INTO l_price_by_symbol from dual;
    end if;
     if l_limit_method_buy_product is not null then
        SELECT
                decode(l_limit_method_buy_product, 'F', l_parvalue, 'P', l_price_buy_after_fee) INTO l_price_by_product from dual;
    end if;



    INSERT INTO BOUGHTDTL(AUTOID ,ACCTNO ,SYMBOL ,TLTXCD ,PRICE ,PARVALUE ,QTTY ,CONFIRMNO ,TRNTYPE ,RETURN_QTTY ,TRNDATE,
    BEFORE_LIMIT ,REMAIN_LIMIT ,RETURN_LIMIT,
    BEFORE_LIMIT_ASS ,REMAIN_LIMIT_ASS ,RETURN_LIMIT_ASS,
    BEFORE_LIMIT_PRD ,REMAIN_LIMIT_PRD ,RETURN_LIMIT_PRD,
    DELTD,
    PRODUCT
    )
    values(seq_BOUGHTDTL.nextval,l_acseller,l_symbol,p_tltxcd,
    l_price_buy_after_fee -- gia mua lai sau thue phi
    ,l_parvalue,p_quantity,l_seq,
    'D',0,LOCALTIMESTAMP,
    l_limit_buy_total_remain,
    l_limit_buy_total_remain - p_quantity* l_price_by_total,
    0,
    nvl(l_limit_buy_symbol_remain,''),
    nvl(l_limit_buy_symbol_remain - p_quantity* l_price_by_symbol,''),
    0,
    nvl(l_limit_buy_product_remain,''),
    nvl(l_limit_buy_product_remain - p_quantity* l_price_by_product,''),
    0,
    'N',
    l_product_name
    );

    if p_fee > 0 then
        INSERT INTO FEE_DTL
            (AUTOID, ORDERID, ACBUYER, FEE, FEETYPE,ACSELLER ,TYPES,deltd,feeid)
            VALUES(seq_fee_dtl.nextval, l_seq, '', p_fee, '003',  l_acbuyer , 'B','N','');
    end if;

    if p_tax > 0 then
        INSERT INTO FEE_DTL
            (AUTOID, ORDERID, ACBUYER, FEE, FEETYPE,ACSELLER ,TYPES,deltd,feeid)
            VALUES(seq_fee_dtl.nextval, l_seq, '', p_tax, '002',  l_acbuyer , 'B','N','');
    end if;


    -- khach hang tat toan
    if p_tlid ='686868' then
        prc_process_8302(P_TXNUM=>p_txnum,
        P_TXDATE=>p_txdate,
        P_BUSDATE=>p_busdate,
        P_TXTIME=>p_txtime,
        P_TLTXCD=>p_tltxcd,
        P_TXDESC=>p_txdesc,
        P_TLID=>p_tlid,
        P_OFFID=>p_offid,
        P_CONFIRMNO=>l_seq,
        P_TXNUMREF=>'',
        P_MODE=>'C',
        P_REASON=>'',
        P_ERR_CODE=>p_err_code);
    end if;

    p_err_code := '';
    plog.setEndSection(pkgctx, 'prc_sysprocess');
exception when others then
    p_err_code := errnums.C_SYSTEM_ERROR;
    plog.debug(pkgctx,'LOG.0404.ERRR');
    RAISE;

end;
/

DROP PROCEDURE prc_return_limit_sell_ref
/

CREATE OR REPLACE 
PROCEDURE prc_return_limit_sell_ref (p_confirmno varchar2,p_err_code in out varchar2)
is
    l_methodLimitBuyTotal VARCHAR2(10);
    l_methodLimitBuySymbol VARCHAR2(10);
    l_methodLimitBuyProduct VARCHAR2(10);
    l_price_by_total number;
    l_price_by_symbol number;
    l_price_by_product number;

    pkgctx   plog.log_ctx;
    logrow   tlogdebug%ROWTYPE;
begin
    plog.setBeginSection(pkgctx, 'prc_return_limit_sell_ref');

 for rec in (select * from oxmast o  where o.confirmno = p_confirmno)
 loop
                update solddtl set deltd ='Y' where confirmno = rec.confirmno and trntype='D' and deltd ='N';
                update solddtl set deltd ='Y' where return_confirmno = rec.confirmno and trntype='C' and deltd ='N';
                 l_methodLimitBuyTotal:= fn_get_limit_method_buy_total(rec.acseller);
                 l_methodLimitBuySymbol:= fn_get_limit_method_buy_symbol(rec.acseller,rec.symbol);
                 l_methodLimitBuyProduct:= fn_get_limit_method_buy_prd(rec.acseller,rec.symbol,fn_get_shortname_by_productid(rec.productid));



                -- hoan han muc mua lai
           for rec2 in
            (select * from boughtdtl where  confirmno = rec.confirmno and trntype='C' and deltd ='N')
            LOOP
                if l_methodLimitBuyTotal is not null then
                    select DECODE(l_methodLimitBuyTotal,'F',rec2.parvalue,'P',rec2.price) into l_price_by_total from dual;
                end if;
                if l_methodLimitBuySymbol is not null then
                    select DECODE(l_methodLimitBuySymbol,'F',rec2.parvalue,'P',rec2.price) into l_price_by_symbol from dual;
                end if;
                if l_methodLimitBuyProduct is not null then
                  select DECODE(l_methodLimitBuyProduct,'F',rec2.parvalue,'P',rec2.price) into l_price_by_product from dual;
                end if;

                 update boughtdtl  set return_qtty = return_qtty - rec2.qtty ,
                                   return_limit =    return_limit - nvl(l_price_by_total*rec2.qtty,0),
                                   return_limit_ass = return_limit_ass - nvl(l_price_by_symbol*rec2.qtty,0),
                                   return_limit_prd = return_limit_prd - nvl(l_price_by_product*rec2.qtty,0)
                                 where confirmno = rec2.return_confirmno;
                 END LOOP;
              update boughtdtl  set deltd ='Y' where confirmno = rec.confirmno and  trntype='C' and deltd ='N';
             --end if;
         end loop;





    p_err_code := '';
    plog.setEndSection(pkgctx, 'prc_return_limit_sell_ref');
exception when others then
    p_err_code := errnums.C_SYSTEM_ERROR;
    RAISE;

end;
/

DROP PROCEDURE prc_reject_contract
/

CREATE OR REPLACE 
PROCEDURE prc_reject_contract (
                p_confirmno varchar2,
                p_txdate date,
                p_txtime varchar2,
                p_txnum varchar2,
                p_tltxcd varchar2,
                p_desc varchar2,
                p_err_code in out varchar2)
is
l_orderid varchar2(100);
l_category varchar2(10);
l_execqtty number;
l_acbuyer varchar2(100);
l_acseller varchar2(100);
l_execamt number;
l_feebuyer number;
l_feeseller number;
l_taxseller number;
l_confirmno varchar2(100);
l_custodycdbuyer varchar2(100);
l_custodycdseller varchar2(100);
l_desc varchar2(1000);
l_parvalue number;
l_count number;


    pkgctx   plog.log_ctx;
    logrow   tlogdebug%ROWTYPE;
begin
    plog.setBeginSection(pkgctx, 'prc_reject_contract');
 select o.confirmno, o.category, o.execqtty, o.feebuyer, o.feeseller, o.taxseller, o.execamt, o.acbuyer, o.acseller
        into l_confirmno,l_category,l_execqtty,l_feebuyer,l_feeseller,l_taxseller,l_execamt,l_acbuyer,l_acseller
        from oxmast o
        where o.confirmno = p_confirmno;
         l_custodycdbuyer:=fn_get_custodycd_by_acctno(l_acbuyer);
         l_custodycdseller:=fn_get_custodycd_by_acctno(l_acseller);


        for rec in (select * from oxmast o  where o.confirmno = p_confirmno)
          loop
               update oxmast o set o.status ='R' where o.orderid=rec.orderid;

                 l_desc:= p_desc;
                 -- giam secured nguoi bán
                  /* update semast s set
                        s.secured = s.secured- rec.execqtty
                        where s.afacctno = rec.acseller and s.symbol = rec.symbol;*/
                   -- insert setran giam secured ngu?i bán
                   /*INSERT INTO SETRAN
                    (TXNUM, TXDATE, ACCTNO, TXCD, NAMT, CAMT, "REF", DELTD, AUTOID, ACCTREF, TLTXCD, BKDATE, TRDESC, LVEL, VERMATCHING, SESSIONNO, NAV, FEEAMT, TAXAMT)
                    VALUES(p_txnum, p_txdate,rec.acseller||LPAD(fn_get_codeid_symbol(rec.symbol),6,'0'), '0005', rec.execqtty, NULL, '1', 'N', seq_setran.NEXTVAL, NULL, p_tltxcd, p_txdate, l_desc, 2, NULL, NULL, 0, 0, 0);
*/

                --if rec.status in ('A','C') then
                     -- update fee_dtl
                     update fee_dtl set deltd='Y' where orderid= rec.orderid and types='S';
                     -- giam firmqtty, firmamt lenh chao
                     update oxpost o set
                        o.firmqtty = o.firmqtty - rec.execqtty,
                        o.firmamt = o.firmamt - (rec.execamt)
                        where o.orderid = rec.refpostid;
                      -- giam semast.receiving nguoi mua
                     update semast s set
                        s.receiving = s.receiving- rec.execqtty
                        where s.afacctno = rec.acbuyer and s.symbol = rec.symbol;
                        -- insert setran giam receiving nguoi mua
                       INSERT INTO SETRAN
                        (TXNUM, TXDATE, ACCTNO, TXCD, NAMT, CAMT, "REF", DELTD, AUTOID, ACCTREF, TLTXCD, BKDATE, TRDESC, LVEL, VERMATCHING, SESSIONNO, NAV, FEEAMT, TAXAMT)
                        VALUES(p_txnum, p_txdate,rec.acbuyer||LPAD(fn_get_codeid_symbol(rec.symbol),6,'0'), '0007', rec.execqtty, NULL, '1', 'N', seq_setran.NEXTVAL, NULL, p_tltxcd, p_txdate, l_desc, 2, NULL, NULL, 0, 0, 0);
                        -- giam ivmast.netting nguoi mua
                        update ivmast i set
                            i.netting = i.netting - (rec.execamt + rec.feebuyer)
                            where i.afacctno = rec.acbuyer and i.symbol = rec.symbol;
                         -- insert ivtran giam netting nguoi mua
                        INSERT INTO ivtran
                          (txnum, txdate, acctno,codeid,symbol, txcd, namt, camt, ref,srtype, deltd, autoid, acctref, tltxcd, bkdate, trdesc, lvel)
                          VALUES(p_txnum, p_txdate,l_custodycdbuyer,fn_get_codeid_symbol(rec.symbol),rec.symbol, '0013', rec.execamt, NULL, '1','NN', 'N', seq_ivtran.NEXTVAL, '', p_tltxcd,
                          p_txdate,'' || l_desc || '', 2);
                          if rec.feebuyer <> 0 then
                               INSERT INTO ivtran
                              (txnum, txdate, acctno,codeid,symbol, txcd, namt, camt, ref,srtype, deltd, autoid, acctref, tltxcd, bkdate, trdesc, lvel)
                              VALUES(p_txnum, p_txdate, l_custodycdbuyer,fn_get_codeid_symbol(rec.symbol),rec.symbol, '0013', rec.feebuyer, NULL, '1','NN', 'N', seq_ivtran.NEXTVAL, '', p_tltxcd,
                              p_txdate,'' || l_desc || '', 2);
                        end if;
                      -- giam ivmast receiving nguoi ban

                      update ivmast i set
                            i.receiving = i.receiving - (rec.execamt - rec.feeseller - rec.taxseller)
                            where i.afacctno = rec.acseller and i.symbol = rec.symbol;
                        -- insert ivtran giam receiving nguoi ban
                        INSERT INTO ivtran
                          (txnum, txdate, acctno,codeid,symbol, txcd, namt, camt, ref,srtype, deltd, autoid, acctref, tltxcd, bkdate, trdesc, lvel)
                          VALUES(p_txnum, p_txdate, l_custodycdseller,fn_get_codeid_symbol(rec.symbol),rec.symbol, '0015', rec.execamt, NULL, '1','NN', 'N', seq_ivtran.NEXTVAL, '', p_tltxcd,
                          p_txdate,'' || l_desc || '', 2);

                      if (rec.feeseller <> 0 ) then
                           INSERT INTO ivtran
                          (txnum, txdate, acctno,codeid,symbol, txcd, namt, camt, ref,srtype, deltd, autoid, acctref, tltxcd, bkdate, trdesc, lvel)
                          VALUES(p_txnum, p_txdate, l_custodycdseller,fn_get_codeid_symbol(rec.symbol),rec.symbol, '0016', rec.feeseller, NULL, '1','NN', 'N', seq_ivtran.NEXTVAL, '', p_tltxcd,
                          p_txdate,'' || l_desc || '', 2);

                      end if;
                      if(rec.taxseller <> 0) then

                       INSERT INTO ivtran
                      (txnum, txdate, acctno,codeid,symbol, txcd, namt, camt, ref,srtype, deltd, autoid, acctref, tltxcd, bkdate, trdesc, lvel)
                      VALUES(p_txnum, p_txdate, l_custodycdseller,fn_get_codeid_symbol(rec.symbol),rec.symbol, '0016', rec.taxseller, NULL, '1','NN', 'N', seq_ivtran.NEXTVAL, '', p_tltxcd,
                      p_txdate,'' || l_desc || '', 2);
                      end if;

                        -- Hoàn han muc mua, ban'

                        prc_return_limit_sell_ref(rec.confirmno,p_err_code);
             --end if;

            end loop;



    p_err_code := '';
    plog.setEndSection(pkgctx, 'prc_reject_contract');
exception when others then
    p_err_code := errnums.C_SYSTEM_ERROR;
    RAISE;

end;
/

DROP PROCEDURE prc_process_8102
/

CREATE OR REPLACE 
PROCEDURE prc_process_8102
                            (
                            p_txnum varchar2,
                            p_txdate date,
                            p_busdate date,
                            p_txtime varchar2,
                            p_tltxcd varchar2,
                            p_txdesc varchar2,
                            p_tlid varchar2,
                            p_offid varchar2,
                            p_confirmno  varchar2,
                            p_txnumref  varchar2,
                            p_mode  varchar2,
                            p_reason varchar2,
                            p_err_code in out varchar2
                            )
   IS
    l_confirmno varchar2(100);
    l_mode varchar2(10);
    l_txnum varchar2(100);
    l_ttkd_profile_stat varchar2(50);
    l_appr_stat varchar2(50);
    l_oxtype varchar2(50);
    l_reason varchar2(500);
    l_pstatus varchar2(50);
    l_status varchar2(50);
    l_ttkd_approve_sell varchar2(10);
    l_bks_approve_sell varchar2(10);
    l_bks_profile_stat varchar2(10);
    l_accounting_stat varchar2(10);
    l_transfer_start varchar2(10);
    l_sett_stat varchar2(10);
    l_contract_no varchar2(500);
    l_desc varchar2(100);
    l_custodycd varchar2(100);

    l_islisted varchar2(10);
    l_otprefid varchar2(100);
    l_otpval varchar2(6);
    l_secret varchar2(4000);
    l_otptime number;
    l_fullname varchar2(4000);
    l_mobile varchar2(100);
    l_email varchar2(200);
    l_data_source varchar2(4000);
    l_count number;
    l_orderid varchar2(100);
    l_symbol varchar2(200);
    p_refid varchar2(200);
    l_execqtty varchar2(100);
    l_execamt varchar2(100);
    l_contractno varchar2(1000);
    l_acbuyer varchar2(100);
    l_acseller varchar2(100);
    l_feebuyer number;
    l_feeseller number;
    l_taxseller number;
    l_buyconfirmno varchar(100);
    l_codeid varchar2(100);
    l_feecn number;
    l_qtty number;
    l_agency_name varchar2(500);
    l_agency_email varchar2(100);
   pkgctx   plog.log_ctx;
    logrow   tlogdebug%ROWTYPE;
--
-- To modify this template, edit file PROC.TXT in TEMPLATE
-- directory of SQL Navigator
--
-- Purpose: Briefly explain the functionality of the procedure
--
-- MODIFICATION HISTORY
-- Person      Date    Comments
-- ---------   ------  -------------------------------------------

   -- Declare program variables as shown above
BEGIN
    l_confirmno:=p_confirmno;
    l_mode:=p_mode;
    l_txnum:=p_txnumref;
    l_reason:=p_reason;
    select s.varvalue into l_ttkd_approve_sell from sysvar s where s.varname ='TTKD_APPROVE_SELL';
     select s.varvalue into l_bks_approve_sell from sysvar s where s.varname ='BKS_APPROVE_SELL';
   -- select oxtype, status, pstatus into l_oxtype, l_status,l_pstatus from profilemanager where confirmno=l_confirmno and txnum = l_txnum;
    if l_mode ='C' then
        update profilemanager p
            set p.status ='C',
            p.offid = p_tlid
            where p.confirmno =l_confirmno and p.txnum = l_txnum;
         update oxmast o set o.status = 'C' where o.confirmno = l_confirmno;

        -- xu ly ivmast
      select o.execqtty, o.acbuyer, o.acseller, o.symbol, o.contract_no, o.execamt, o.feebuyer, o.feeseller, o.taxseller, o.buyconfirmno,o.orderid
        into l_qtty, l_acbuyer, l_acseller, l_symbol , l_contract_no, l_execamt, l_feebuyer, l_feeseller, l_taxseller, l_buyconfirmno,l_orderid
        from oxmast o where o.confirmno  = l_confirmno;


         l_desc:= 'X/n thanh toan HD ban TP '|| l_contract_no;
         l_codeid:=fn_get_codeid_symbol(l_symbol);
         -- giam ivmast.netting ngu?i mua
        update ivmast
        set netting = nvl(netting,0) - (l_execamt + l_feebuyer)
        where afacctno = l_acbuyer
            and symbol = l_symbol;

        -- inserr ivtran gi?m netting ngu?i mua
        INSERT INTO ivtran (txnum,
                            txdate,
                            acctno,
                            codeid,
                            symbol,
                            txcd,
                            namt,
                            camt,
                            REF,
                            srtype,
                            deltd,
                            autoid,
                            acctref,
                            tltxcd,
                            bkdate,
                            trdesc)
        VALUES (p_txnum,
                p_txdate,
                fn_get_custodycd_by_acctno(l_acbuyer),
                l_codeid,
                l_symbol,
                '0013',
                l_execamt,
                NULL,
                '1',
                'NN',
                'N',
                seq_ivtran.NEXTVAL,
                '',
                p_tltxcd,
                p_txdate,
                '' || l_desc || '');


        IF l_feebuyer <> 0 THEN

            INSERT INTO ivtran (txnum,
                                txdate,
                                acctno,
                                codeid,
                                symbol,
                                txcd,
                                namt,
                                camt,
                                REF,
                                srtype,
                                deltd,
                                autoid,
                                acctref,
                                tltxcd,
                                bkdate,
                                trdesc)
            VALUES (p_txnum,
                p_txdate,
                fn_get_custodycd_by_acctno(l_acbuyer),
                l_codeid,
                l_symbol,
                '0013',
                l_feebuyer,
                NULL,
                '1',
                'NN',
                'N',
                seq_ivtran.NEXTVAL,
                '',
                p_tltxcd,
                p_txdate,
                '' || l_desc || '');

        END IF;
    -- giam ivmast receiving nguoi ban

        UPDATE ivmast
           SET receiving = receiving - (l_execamt - l_feeseller - l_taxseller)
         WHERE afacctno = l_acseller AND symbol = l_symbol;
    -- insert ivtran giam receiving ngu?i bán
        INSERT INTO ivtran (txnum,
                            txdate,
                            acctno,
                            codeid,
                            symbol,
                            txcd,
                            namt,
                            camt,
                            REF,
                            srtype,
                            deltd,
                            autoid,
                            acctref,
                            tltxcd,
                            bkdate,
                            trdesc)
        VALUES (p_txnum,
                p_txdate,
                fn_get_custodycd_by_acctno(l_acseller),
                l_codeid,
                l_symbol,
                '0015',
                l_execamt,
                NULL,
                '1',
                'NN',
                'N',
                seq_ivtran.NEXTVAL,
                '',
                p_tltxcd,
                p_txdate,
                '' || l_desc || '');

       IF (l_feeseller <> 0 ) THEN

            INSERT INTO ivtran (txnum,
                                txdate,
                                acctno,
                                codeid,
                                symbol,
                                txcd,
                                namt,
                                camt,
                                REF,
                                srtype,
                                deltd,
                                autoid,
                                acctref,
                                tltxcd,
                                bkdate,
                                trdesc)
            VALUES (p_txnum,
                p_txdate,
                fn_get_custodycd_by_acctno(l_acseller),
                l_codeid,
                l_symbol,
                '0016',
                l_feeseller,
                NULL,
                '1',
                'NN',
                'N',
                seq_ivtran.NEXTVAL,
                '',
                p_tltxcd,
                p_txdate,
                '' || l_desc || '');

       END IF;
       IF(l_taxseller <> 0) THEN

            INSERT INTO ivtran (txnum,
                                txdate,
                                acctno,
                                codeid,
                                symbol,
                                txcd,
                                namt,
                                camt,
                                REF,
                                srtype,
                                deltd,
                                autoid,
                                acctref,
                                tltxcd,
                                bkdate,
                                trdesc)
            VALUES (p_txnum,
                p_txdate,
                fn_get_custodycd_by_acctno(l_acseller),
                l_codeid,
                l_symbol,
                '0016',
                l_taxseller,
                NULL,
                '1',
                'NN',
                'N',
                seq_ivtran.NEXTVAL,
                '',
                p_tltxcd,
                p_txdate,
                '' || l_desc || '');

      END IF;



    end if;

    if l_mode ='R' then

     update profilemanager p
            set p.status ='R',
            p.note = l_reason,
            p.pstatus = p.status
            where p.confirmno =l_confirmno and p.txnum = l_txnum;
            FOR rec in (select * from profilemanager   where confirmno = l_confirmno and status = 'D' and oxtype = 'S')
            LOOP

                     update profilemanager set status = rec.pstatus, pstatus = '' where confirmno = l_confirmno and status = 'D' and oxtype = 'S' and autoid = rec.autoid;

         END LOOP;
              update profilemanager set offid = p_tlid  where confirmno =l_confirmno;
        -- huy HD
        select o.confirmno , o.contract_no into l_confirmno , l_contract_no from oxmast o where o.confirmno = l_confirmno;
        l_desc:='Tu choi HD '||l_contract_no;
                prc_reject_contract(P_CONFIRMNO=>l_confirmno,
                            P_TXDATE=>p_txdate,
                            P_TXTIME=>p_txtime,
                            P_TXNUM=>p_txnum,
                            P_TLTXCD=>p_tltxcd,
                            P_DESC=>l_desc,
                            P_ERR_CODE=>p_err_code);
         /*IF p_err_code IS NOT NULL THEN
            RETURN p_err_code;
         END IF;*/
            -- dong bo oxpost
            for rec in (select * from oxpost where orderid in (select o.refpostid from oxmast o where o.confirmno = l_confirmno))
                loop
                    txpks_notify.prc_system_logevent('8102', 'OXPOSTS',  'ALL'|| '~#~' ||'ALL'|| '~#~' ||rec.orderid, 'R','INSERT/UPDATE OXPOST');
                end loop;
    end if;
    for rec in (select * from oxmast where confirmno = p_confirmno)
     loop
        txpks_notify.prc_system_logevent('8102', 'OXMASTS',  'ALL'|| '~#~' ||'ALL'|| '~#~' ||rec.orderid, 'R','INSERT/UPDATE OXMAST');
    end loop;

                  /*  insert into alertcontent(autoid,
                               shortcontent,
                               maincontent,
                               createtime,
                               alerttype,
                               status,
                               pstatus,
                               lastchange,
                               senddate,
                               maker,
                               reader,
                               maincontent_en,
                               shortcontent_en
                               )
                    select seq_alertcontent.NEXTVAL,
                           a.msg_shortcontent shortcontent,
                          replace(replace(replace(a.msg_maincontent,'[p_buyer]',fn_get_custodycd_by_acctno(l_acbuyer)),'[p_confirmno]',l_confirmno),'[p_totalamount]',l_execamt + l_feebuyer)
                                maincontent,
                           SYSTIMESTAMP createtime,
                           'A' alerttype,
                           'A' status,
                           null pstatus,
                           SYSTIMESTAMP lastchange,
                           CURRENT_DATE senddate,
                           '',
                           '',
                          (replace(replace(replace(a.msg_maincontent_en,'[p_buyer]',fn_get_custodycd_by_acctno(l_acbuyer)),'[p_confirmno]',l_confirmno),'[p_totalamount]',l_execamt + l_feebuyer))
                                maincontent_en,
                           a.msg_shortcontent_en shortcontent_en
                   from alerttemp a
                   where msg_type = 'A002';*/
    p_err_code := '';
    plog.setEndSection(pkgctx, 'prc_sysprocess');
exception when others then
    p_err_code := errnums.C_SYSTEM_ERROR;
    RAISE;

end;
/

DROP PROCEDURE prc_process_8725
/

CREATE OR REPLACE 
PROCEDURE prc_process_8725(
                            p_txnum varchar2,
                            p_txdate date,
                            p_busdate date,
                            p_txtime varchar2,
                            p_tltxcd varchar2,
                            p_txdesc varchar2,
                            p_tlid varchar2,
                            p_offid varchar2,
                            p_reforderid varchar2,
                            p_acbuyer varchar2,
                            p_productid varchar2,
                            p_price number,
                            p_qtty number,
                            p_acseller varchar2,
                            p_idbuyer varchar2,
                            p_managerid varchar2,
                            p_pos varchar2,
                            p_coid varchar2,
                            p_issueowner varchar2,
                            p_intadj varchar2,
                            p_comprogram varchar2,
                            p_moneytransfer varchar2,
                            p_isrmsales varchar2,
                            p_rateadjurl varchar2,
                            p_err_code in out varchar2)
   IS
--
-- To modify this template, edit file PROC.TXT in TEMPLATE
-- directory of SQL Navigator
--
-- Purpose: Briefly explain the functionality of the procedure
--
-- MODIFICATION HISTORY
-- Person      Date    Comments
-- ---------   ------  -------------------------------------------
l_islisted varchar2(10);
l_spotmodeid varchar2(10);
l_count varchar(100);
l_afacctno varchar(100);
l_symbol varchar(100);
l_autoid varchar(100);
l_category varchar(100);
l_dealeraccount varchar(100);
l_refissuid varchar(100);
l_reforderid2 varchar2(100);
l_currdate varchar(100);
l_txdesc varchar(5000);
l_codeid varchar(100);
l_acctno varchar(500);
l_acctnobuyer varchar(500);
l_status varchar(50);
l_feebuyer number;
l_feeseller number;
l_taxseller number;
l_settmode varchar (100);
l_acoxcash varchar(100);
l_acoxbank varchar(100);
l_acoxcitybank varchar(100);
l_orgconfirmno varchar(100);
l_buyconfirmno varchar(100);
l_confirmno varchar(100);
l_contractno varchar(500);
l_orgprice varchar(100);
l_ccpafacctno varchar(500);
l_coid varchar(100);
l_brid varchar(100);
l_shortname varchar(100);
l_orderid varchar(500);
l_bankacct varchar (100);
l_bankacc varchar(100);
l_bankcd varchar(100);
l_bankcode varchar(100);
l_citybank varchar(100);
l_citybank2 varchar (100);
l_orgdate varchar(100);
l_parvalue number;
p_qttybuy number;
l_limitTotal number;
l_limitAsset number;
l_limitTotalRemain number;
l_limitAssetRemain number;
l_sumTotal number;
l_sumAsset number;
l_priceSell number;
l_priceSell2 number;
l_priceSell3 number;
l_methodLimitTotal varchar2(5);
l_methodLimitAsset varchar2(5);
l_isgioihanndt varchar(5);
l_before_limit number;
l_remain_limit number;
l_return_limit number;
l_isprofessor varchar2(10);
l_intrate number;
l_limitProduct number;
l_limitProductRemain number;
l_methodLimitProduct varchar2(5);
l_sumProduct number;
l_methodLimitBuyTotal VARCHAR2(10);
l_methodLimitBuyAsset VARCHAR2(10);
l_methodLimitBuyProduct VARCHAR2(10);
l_price_by_total number;
l_price_by_symbol number;
l_price_by_product number;
l_limitBuyTotalRemain number;
l_limitBuySymbolRemain number;
l_limitBuyProductRemain number;
l_cifacbuyer varchar2(100);
l_cifacseller varchar2(100);
l_price number;
l_idbuyer varchar2(100);
l_managerid varchar2(100);
l_issueowner varchar2(10);
l_intadj varchar2(10);
l_moneytransfer varchar2(10);
l_comprogram varchar2(10);
l_tradeid varchar2(100);
l_txdate date;
l_txtime varchar2(100);
l_payment_rule varchar2(10);
l_crbankacct varchar2(100);
l_bankcdsb varchar2(100);
l_bankcodeaf varchar2(100);
l_citybanksb varchar2(100);
l_citybankaf varchar2(100);
l_sellercash varchar2(100);
l_sellerbank varchar2(100);
l_sellercitybank varchar2(100);
l_bankaccaf varchar2(100);
l_matdate date;
l_buyercash varchar2(100);
l_buyerbank varchar2(100);
l_buyercitybank varchar2(100);
    pkgctx   plog.log_ctx;
    logrow   tlogdebug%ROWTYPE;
   -- Declare program variables as shown above
BEGIN
     plog.setBeginSection(pkgctx, 'prc_sysprocess');
    plog.debug(pkgctx,'LOG.8725.BEGIN');
    l_cifacbuyer:= fn_get_custodycd_by_acctno(p_acbuyer);
    l_cifacseller:= fn_get_custodycd_by_acctno(p_acseller);

    select o.status , o.afacctno, o.symbol, o.category , o.dealeraccount, o.refissuid , o.buyconfirmno , o.orgconfirmno,case when o.afacctno = o.dealeraccount then getcurrdate() else o.orgdate end ,
         o.orgprice ,s.payment_rule,s.crbankacct,s.bankcd, s.citybank, a.parvalue, case when o.buyconfirmno is not null then ox.matdate else fn_get_matdate_product(p_productid,o.symbol)end
    into l_status, l_afacctno, l_symbol, l_category, l_dealeraccount, l_refissuid, l_buyconfirmno,
        l_orgconfirmno,l_orgdate,l_orgprice ,l_payment_rule, l_crbankacct,l_bankcdsb,l_citybanksb,l_parvalue,l_matdate
    from oxpost o
    left join oxmast ox on ox.confirmno= o.buyconfirmno
    left join assetdtl a on a.symbol = o.symbol
    left join sbsedefacct s on o.dealeraccount = s.refafacctno and o.symbol =s.symbol
    where o.orderid = p_reforderid;

    select a.autoid, a.settmode, a.ccpafacctno, a.bankacct,a.bankcd,a.citybank
            into l_codeid, l_settmode, l_ccpafacctno, l_bankacct,l_bankcd,l_citybank
            from assetdtl a
            where a.symbol = l_symbol;

    select c.bankacc, c.bankcode, c.citybank into l_bankacc, l_bankcodeaf , l_citybankaf from cfmast c where c.custid = l_afacctno;
    --Acoxcash
    if l_dealeraccount = l_afacctno then
        if l_payment_rule ='I' then
            if l_settmode ='T' then
                l_acoxcash:=l_bankacct;
            else
                l_acoxcash:= l_crbankacct;
            end if;
        end if;
         if l_payment_rule ='D' then
            l_acoxcash:= l_crbankacct;
        end if;
    else
        if l_settmode ='T' then
            l_acoxcash:= l_bankacct;
        else
        l_acoxcash := l_bankacc;
        end if;
    end if;
    --acoxbank
    if l_dealeraccount = l_afacctno then
        if l_payment_rule ='I' then
            if l_settmode ='T' then
                l_acoxbank:=l_bankcd;
            else
                l_acoxbank:= l_bankcdsb;
            end if;
        end if;
         if l_payment_rule ='D' then
            l_acoxbank:= l_bankcdsb;
        end if;
    else
        if l_settmode ='T' then
            l_acoxbank:=l_bankcd;
        else
       l_acoxbank:=l_bankcodeaf;
        end if;
    end if;
--acoxcitybank
    if l_dealeraccount = l_afacctno then
        if l_payment_rule ='I' then
            if l_settmode ='T' then
                l_acoxcitybank:=l_citybank;
            else
                l_acoxcitybank:=l_citybanksb;
            end if;
        end if;
         if l_payment_rule ='D' then
            l_acoxcitybank:=l_citybanksb;
        end if;
    else
        if l_settmode ='T' then
            l_acoxcitybank:=l_citybank;
        else
        l_acoxcitybank:=l_citybankaf;
        end if;
    end if;
-- sellercash
  if l_dealeraccount = l_afacctno then
        if l_payment_rule ='I' and l_settmode ='T' then

                l_sellercash:=l_crbankacct;
        else
            l_sellercash:='';
        end if;
    else
        if l_settmode ='T' then
             l_sellercash:=l_bankacc;
        else
         l_sellercash:='';
        end if;
    end if;
    --sellerbank
   if l_dealeraccount = l_afacctno then
        if l_payment_rule ='I' and l_settmode ='T' then

                l_sellerbank:=l_bankcdsb;
        else
             l_sellerbank:='';
        end if;
    else
        if l_settmode ='T' then
             l_sellerbank:=l_bankcodeaf;
        else
         l_sellerbank:='';
        end if;
    end if;
    --sellercitybank
  if l_dealeraccount = l_afacctno then
        if l_payment_rule ='I' and l_settmode ='T' then

                l_sellercitybank:=l_citybanksb;
        else
             l_sellercitybank:='';
        end if;
    else
        if l_settmode ='T' then
             l_sellercitybank:=l_citybankaf;
        else
         l_sellercitybank:='';
        end if;
    end if;

    select c.bankacc, c.bankcode, c.citybank into l_buyercash, l_buyerbank, l_buyercitybank from cfmast c where c.custid = p_acbuyer;
    --status
    if p_tlid='686868' then
        l_status:='C';
    else
        if p_intadj ='Y' then l_status:= 'P' ; else l_status :='A'; end if;
    end if;
    select count(*) into l_count from product where autoid = p_productid;
    if l_count <>0 then
         select shortname into l_shortname from product where autoid=p_productid;
     else l_shortname:='';
    end if;

    l_feebuyer:=  fn_calc_fee_fortype
                    (
                     p_date => getcurrdate(),
                     p_exectype=> 'CC',
                     p_symbol=>l_symbol,
                     p_custodycd=>l_cifacseller,
                     p_product=>l_shortname,
                     p_combo=>'',
                     p_amt=>p_price * p_qtty,
                     p_amtp=>l_parvalue*p_qtty);
     l_feeseller:= fn_calc_fee_fortype
                    (p_date => getcurrdate(),
                     p_exectype=> 'DS',
                     p_symbol=>l_symbol,
                     p_custodycd=>l_cifacseller,
                     p_product=>l_shortname,
                     p_combo=>'',
                     p_amt=>p_price * p_qtty,
                     p_amtp=>l_parvalue* p_qtty) ;
     l_taxseller:= fn_calc_fee
                (p_txdate=>getcurrdate(),
                 p_feetype=>'002',
                 p_exectype=>'',
                 p_symbol=>l_symbol,
                 p_custodycd=>l_cifacseller,
                 p_product=>l_shortname,
                 p_combo=>'',
                 p_amt=>p_price * p_qtty,
                 p_amtp=>l_parvalue * p_qtty
                 ) ;

    if l_afacctno = l_dealeraccount then
        l_ccpafacctno:= '';
    else
        l_ccpafacctno:= l_ccpafacctno;
    end if;
     l_acctno := p_acseller||lpad(l_codeid,6,'0');
     l_acctnobuyer := p_acbuyer||lpad(l_codeid,6,'0');
     l_intrate:=fn_get_intrate_symbol(l_symbol,getcurrdate);



        -- insert oxmast
         l_orderid :=lpad(to_char(seq_confirmno.nextval),9,'0');
         l_confirmno:=l_orderid||'01';



        if l_category='T' then
            l_contractno:=p_pos||'.'||p_managerid||'.'||p_idbuyer||'.'||l_confirmno||'.'||l_shortname||'/HDTP-B/SHB';
        else --if l_category in ('O','I')
            l_contractno:=p_pos||'.'||p_managerid||'.'||p_idbuyer||'.'||l_confirmno||'.'||l_symbol||'/HDTP-B/SHB';
        end if;

       select a.spotmode into l_spotmodeid from assetdtl a where a.symbol= l_symbol;
       if l_spotmodeid = 'A' then
        l_islisted:='Y';
       else
       l_islisted :='N';
       end if;
        l_autoid:=seq_oxmast.NEXTVAL;
        insert into oxmast (
                autoid,
                orderid,
                confirmno,
                txdate,
                txtime,
                traderid,
                checkerid,
                actype,
                productid,
                symbol,
                execqtty,
                execamt,
                settamt,
                refpostid,
                category,
                acbuyer,
                acseller,
                acoxcash,
                acoxbank,
                acoxcitybank,
                sellercash,
                sellerbank,
                sellercitybank,
                status,
                feebuyer,
                feeseller,
                taxbuyer,
                taxseller,
                idbuyer,
                price,
                orgdate,
                orgconfirmno,
                sbdefacctno,
                buyconfirmno,
                orgprice,
                ccpafacctno,
                promotion,
                renew,
                contract_no,
                ttkd_profile_stat,
                bks_profile_stat,
                appr_stat,
                sett_stat,
                transfer_stat,
                accounting_stat,
                sale_manager_id,
                idcode_collab,
                collab_id,
                brid,
                matdate,
                pending_clsqtty,
                clsqtty,
                soldqtty,
                isprofessor,
                REFISSUID,
                intrate,
                islisted,
                ispushed,
                moneytransfer,
                issueowner,
                intadj,
                comprogram,
                isrmsales,
                buyercash,
                buyerbank,
                buyercitybank,
                beforeadjprice,
                isissued,
                rateadjurl
                )
            values
                (
                 l_autoid,--autoid
                 l_orderid,--orderid
                 l_confirmno,--confirmno
                 p_txdate,--txdate
                 nvl(p_txtime,to_char(sysdate,'HH24:MI:SS')),--txtime
                 p_tlid,--tlid
                 p_offid,--offid
                 '0000',--actype
                 p_productid, --productid
                 l_symbol,--symbol
                 p_qtty,--qtty
                 p_qtty * p_price, --execamt
                 0,--settamt
                 p_reforderid,--refpostid
                 l_category,--category
                 p_acbuyer,--acbuyer
                 p_acseller,--acseller
                 l_acoxcash,--acoxcash
                 l_acoxbank,--acoxbank
                 l_acoxcitybank,--acoxcitybank
                 l_sellercash,--sellercash
                 l_sellerbank,--sellerbank
                 l_sellercitybank,--sellercitybank
                 l_status,--status
                 l_feebuyer,--feebuyer
                 l_feeseller,--feeseller
                 0,--taxbuyer
                 l_taxseller,--taxseller
                 p_idbuyer,--idbuyer
                 p_price,--price
                 l_orgdate,-- ngay mua lan dau
                 nvl(l_orgconfirmno,l_confirmno),--orgconfirmno
                 l_dealeraccount,--sbsedefacct
                 l_buyconfirmno,--buyconfirmno
                 nvl(l_orgprice,p_price), --orgprice
                 l_ccpafacctno,--ccpafacctno
                 0,
                 'N',
                 l_contractno,--contractno
                 'N',
                 'N',
                 'N',
                 'N',
                 'N',
                 'N',
                 p_managerid,
                 fn_get_idcode_by_coid(p_coid),--idcode_collabe
                  p_coid,--collab_id
                  p_pos,--brid
                  l_matdate,
                  0,--pending_clsqtty
                  0,--clsqtty
                  0,--soldqtty
                  fn_get_isprofession(fn_get_custodycd_by_acctno(p_acbuyer)),--isprofessor
                  l_refissuid,--refissuid
                  l_intrate,--intrate
                  l_islisted,--islisted
                  'N',--ispushed
                  p_moneytransfer,--moneytransfer
                  p_issueowner,--issueowner
                  p_intadj,--intadj
                  fn_get_id_by_procode(p_comprogram),--comprogram
                  p_isrmsales, --isrmsales
                  l_buyercash ,-- buyercash
                  l_buyerbank,-- buyerbank
                  l_buyercitybank, -- buyercitybank
                  '',-- beforeadjprice
                  'N', --isissued
                  p_rateadjurl-- rateadjurl
                );


            -- INSERT OXMASTLEG cho chan sell
          /*  if l_buyconfirmno is not null then
                select oxmast.autoid into l_reforderid2 from oxpost left join oxmast on oxmast.confirmno = oxpost.buyconfirmno where oxpost.orderid = p_reforderid;
            end if;
            insert into oxmastleg
            (
                autoid,
                orgorderid,
                reforderid,
                symbol,
                legcd,
                orgacctno,
                afacctno,
                coacctno,
                optioncd,
                orgqtty,
                exerqtty,
                confirmno
                )
            values
                (
                seq_oxmastleg.NEXTVAL,
                l_autoid,
                nvl(l_reforderid2,l_autoid),
                l_symbol,
                'S',
                l_afacctno,
                l_afacctno,
                p_acbuyer,
                'N',
                p_qtty,
                0,
                l_confirmno
                );*/
             -- INSERT OXMASTLEG cho chan buy
            /*if l_buyconfirmno is not null then
                select oxmast.autoid into l_reforderid2 from oxpost left join oxmast on oxmast.confirmno = oxpost.buyconfirmno where oxpost.orderid = l_reforderid;
            end if;*/
            /*insert into oxmastleg
                (
                autoid,
                orgorderid,
                reforderid,
                symbol,
                legcd,
                orgacctno,
                afacctno,
                coacctno,
                optioncd,
                orgqtty,
                exerqtty,
                confirmno
                )
            values
                (
                seq_oxmastleg.NEXTVAL,
                l_autoid,
                nvl(l_reforderid2,l_autoid),
                l_symbol,
                'B',
                l_afacctno,
                p_acbuyer,
                l_afacctno,
                'N',
                p_qtty,
                0,
                l_confirmno
                );*/
        -- xu ly tang semast.secured nguoi ban
         update semast se set se.secured = nvl(se.secured,0)+ p_qtty where se.afacctno = p_acseller and se.symbol=l_symbol;
         l_txdesc:= 'Ban '||p_qtty||' '||l_symbol||'" - HÐ:'||l_contractno;
         -- insert setran tang secured nguoi ban
          INSERT INTO setran
          (txnum, txdate, acctno, txcd, namt, camt, ref, deltd, autoid, acctref, tltxcd, bkdate, trdesc, lvel, vermatching, sessionno, nav, feeamt, taxamt)
          VALUES
          (p_txnum, p_txdate, l_acctno, '0006', p_qtty, NULL, '1', 'N', seq_setran.NEXTVAL, '', p_tltxcd,getcurrdate(),'' || l_txdesc || '', 2, NULL, NULL, 0, 0, 0);


            -- Khong DCLS
        if p_intadj='N' then

          -- Tang oxpost.firmqtty, oxpost.firmamt
            update oxpost o set  o.firmqtty = o.firmqtty + p_qtty,
                         o.firmamt = o.firmamt + p_qtty * p_price
                         where o.orderid = p_reforderid;
           --insert fee_dtl
            if(l_feebuyer <> 0) then
                for vc in (SELECT distinct feetype, id  FROM FEETYPE  f WHERE EXECTYPE = 'CC' AND (STATUS = 'A' OR PSTATUS LIKE '%A%') and (getcurrdate() between frdate and todate - 1))
                loop



                     INSERT INTO FEE_DTL
                    (AUTOID, ORDERID, ACBUYER, FEE, FEETYPE,ACSELLER ,TYPES,deltd, feeid)
                    VALUES(
                        seq_fee_dtl.nextval,
                        l_orderid,
                        p_acbuyer,
                        fn_calc_fee
                        (p_txdate=>getcurrdate(),
                                    p_feetype=>vc.feetype,
                                    p_exectype=>'CC',
                                    p_symbol=>l_symbol,
                                    p_custodycd=>fn_get_custodycd_by_acctno(p_acseller),
                                    p_product=>(select case when p_productid = 0 then '' else  ( select  shortname from product where autoid  = p_productid) end from dual ),
                                    p_combo=>'',
                                    p_amt=>p_price* p_qtty,
                                    p_amtp=> p_qtty *l_parvalue  ),
                        vc.feetype,
                         '' ,
                         'S',
                         'N',
                         vc.id);

                end loop;
            end if;
            if(l_feeseller <> 0) then

                for vc in (SELECT distinct feetype , id FROM FEETYPE  f WHERE EXECTYPE = 'DS' AND (STATUS = 'A' OR PSTATUS LIKE '%A%') and (getcurrdate() between frdate and todate - 1))
                loop



                     INSERT INTO FEE_DTL
                    (AUTOID, ORDERID, ACBUYER, FEE, FEETYPE,ACSELLER , TYPES,deltd, feeid)
                        VALUES(
                        seq_fee_dtl.nextval,
                        l_orderid,
                        '',
                        fn_calc_fee
                        (p_txdate=>getcurrdate(),
                                    p_feetype=>vc.feetype,
                                    p_exectype=>'DS',
                                    p_symbol=>l_symbol,
                                    p_custodycd=>fn_get_custodycd_by_acctno(p_acseller),
                                    p_product=>(select case when p_productid = 0 then '' else  ( select  shortname from product where autoid  = p_productid) end from dual ),
                                    p_combo=>'',
                                    p_amt=>p_price * p_qtty,
                                    p_amtp=> p_qtty *l_parvalue ),
                        vc.feetype,
                         p_acseller,
                         'S',
                         'N',
                         vc.id);

                end loop;
            end if;
           /* if(l_taxseller <> 0) then
                 INSERT INTO FEE_DTL
                (AUTOID, ORDERID, ACBUYER, FEE, FEETYPE,ACSELLER ,TYPES,deltd, feeid)
                VALUES(seq_fee_dtl.nextval, l_orderid, '', l_taxseller, '002',  p_acseller , 'S','N','');
            end if;*/
            delete from FEE_DTL where orderid = l_orderid and fee = 0 ;


          -- tang semast.receiving nguoi mua
          select count(*) into l_count  from semast se  where se.afacctno = p_acbuyer and se.symbol = l_symbol;
          if l_count = 0 then
              INSERT INTO semast
                      (acctno, afacctno, custodycd,codeid, symbol, trade, tradeepr, tradeepe, careceiving, costprice, receiving, blocked, netting, status, pl, lastchange, sending, secured, tradesip, sendingsip, blockedsip, isallowodsip)
                      VALUES(l_acctnobuyer, p_acbuyer, l_cifacbuyer, l_codeid, l_symbol, 0, 0, 0, 0, 0, 0, 0, 0, 'A', 0, null, 0, 0, 0, 0, 0, 'Y');
          end if;
           update semast se set se.receiving = nvl(se.receiving,0)+p_qtty where se.afacctno = p_acbuyer and se.symbol=l_symbol;
             l_txdesc:= 'Mua '||p_qtty||' '||l_symbol||'" - HÐ:'||l_contractno;

         --insert SETRAN tang reciving nguoi mua
           INSERT INTO setran
          (txnum, txdate, acctno, txcd, namt, camt, ref, deltd, autoid, acctref, tltxcd, bkdate, trdesc, lvel, vermatching, sessionno, nav, feeamt, taxamt)
           VALUES(p_txnum, p_txdate, l_acctnobuyer, '0008', p_qtty, NULL, '1', 'N', seq_setran.NEXTVAL, '', p_tltxcd,getcurrdate(),'' || l_txdesc || '', 2, NULL, NULL, 0, 0, 0);

             select count(1) into l_count
             from ivmast
             where afacctno = p_acbuyer
                  and symbol = l_symbol;
              if l_count = 0 then
                  INSERT INTO ivmast
                  (acctno, afacctno, custid, custodycd, codeid, symbol, srtype, balance, receiving, careceiving, netting, blocked, status)
                  VALUES(l_acctnobuyer, p_acbuyer, p_acbuyer, l_cifacbuyer, l_codeid, l_symbol, 'NN', 0, 0, 0, 0, 0, 'A');
              end if;
             -- tang ivmast.netting ngu?i mua
              update ivmast i set i.netting = i.netting+ (p_price * p_qtty + l_feebuyer)
              where i.afacctno = p_acbuyer and i.symbol=l_symbol;
            -- inset ivtran tang netting nguoi mua
             l_txdesc:= 'Tien mua '||p_qtty||' '||l_symbol||'" - HÐ:'||l_contractno;
            INSERT INTO ivtran
            (txnum, txdate, acctno,codeid,symbol, txcd, namt, camt, ref,srtype, deltd, autoid, acctref, tltxcd, bkdate, trdesc, lvel)
            VALUES(p_txnum, p_txdate, l_cifacbuyer,l_codeid,l_symbol, '0012', p_price * p_qtty, NULL, '1','NN', 'N', seq_ivtran.NEXTVAL, '', p_tltxcd,getcurrdate,'' || l_txdesc || '', 2);
            --insert ivtran phi mua
            if l_feebuyer <>0 then
                l_txdesc:= 'Phi mua '||p_qtty||' '||l_symbol||'" - HÐ:'||l_contractno;
                INSERT INTO ivtran
                  (txnum, txdate, acctno,codeid,symbol, txcd, namt, camt, ref,srtype, deltd, autoid, acctref, tltxcd, bkdate, trdesc, lvel)
                  VALUES(p_txnum, p_txdate , l_cifacbuyer,l_codeid,l_symbol, '0012', l_feebuyer, NULL, '1','NN', 'N', seq_ivtran.NEXTVAL, '', p_tltxcd,
                 getcurrdate(),'' || l_txdesc || '', 2);
            end if;
            -- tang ivmast.receiving ngu?i bán
            select count(1) into l_count
              from ivmast
              where afacctno = p_acseller
                  and symbol = l_symbol;

              if l_count = 0 then
                  INSERT INTO ivmast
                  (acctno, afacctno, custid, custodycd, codeid, symbol, srtype, balance, receiving, careceiving, netting, blocked, status)
                  VALUES(l_acctno, p_acseller, p_acseller, l_cifacseller, l_codeid, l_symbol, 'NN', 0, 0, 0, 0, 0, 'A');

              end if;

              update ivmast i set i.receiving = i.receiving+ (p_price * p_qtty -l_feeseller - l_taxseller)
              where i.afacctno = p_acseller and i.symbol=l_symbol;
             -- insert ivtran ngu?i bán
                l_txdesc:= 'Tien ban '||p_qtty||' '||l_symbol||'" - HÐ:'||l_contractno;
            INSERT INTO ivtran
              (txnum, txdate, acctno,codeid,symbol, txcd, namt, camt, ref,srtype, deltd, autoid, acctref, tltxcd, bkdate, trdesc, lvel)
              VALUES(p_txnum, p_txdate, l_cifacseller,l_codeid,l_symbol, '0016', p_price * p_qtty, NULL, '1','NN', 'N', seq_ivtran.NEXTVAL, '', p_tltxcd,
              getcurrdate,'' || l_txdesc || '', 2);
              if l_feeseller <>0 then
                l_txdesc:= 'Phi ban '||p_qtty||' '||l_symbol||'" - HÐ:'||l_contractno;
                INSERT INTO ivtran
                  (txnum, txdate, acctno,codeid,symbol, txcd, namt, camt, ref,srtype, deltd, autoid, acctref, tltxcd, bkdate, trdesc, lvel)
                  VALUES(p_txnum, p_txdate , l_cifacseller,l_codeid,l_symbol, '0015', l_feeseller, NULL, '1','NN', 'N', seq_ivtran.NEXTVAL, '', p_tltxcd,
                 getcurrdate(),'' || l_txdesc || '', 2);
             end if;
            if l_taxseller <>0 then
               l_txdesc:= 'Thue ban '||p_qtty||' '||l_symbol||'" - HÐ:'||l_contractno;
                INSERT INTO ivtran
                  (txnum, txdate, acctno,codeid,symbol, txcd, namt, camt, ref,srtype, deltd, autoid, acctref, tltxcd, bkdate, trdesc, lvel)
                  VALUES(p_txnum, p_txdate, l_cifacseller,l_codeid,l_symbol, '0015', l_taxseller, NULL, '1','NN', 'N', seq_ivtran.NEXTVAL, '', p_tltxcd,
                  getcurrdate,'' || l_txdesc || '', 2);
            end if;


            -- ghi nh?n h?n m?c bán và hoàn h?n m?c mua l?i cho d?i lý
            if l_afacctno = l_dealeraccount then
                  l_limitTotalRemain:= fn_calc_limitsell_total_remain(l_afacctno);
                  l_limitAssetRemain:=fn_cal_limitsell_symbol_remain(l_afacctno,l_symbol);
                  l_limitProductRemain:= fn_cal_limitsell_pro_remain(l_afacctno,l_symbol,l_shortname);

                  l_methodLimitTotal:= fn_get_limit_method_sell_total(l_afacctno);
                  l_methodLimitAsset:= fn_get_limitmethod_sell_symbol(l_afacctno,l_symbol);
                  l_methodLimitProduct:= fn_get_limit_method_sell_pro(l_afacctno,l_symbol,l_shortname);

                  if l_methodLimitTotal is not null then
                    select DECODE(l_methodLimitTotal,'F',l_parvalue,'P',p_price) into l_priceSell from dual;
                  end if;
                  if l_methodLimitAsset is not null then
                    select DECODE(l_methodLimitAsset,'F',l_parvalue,'P',p_price) into l_priceSell2 from dual;
                  end if;
                  if l_methodLimitProduct is not null then
                    select DECODE(l_methodLimitProduct,'F',l_parvalue,'P',p_price) into l_priceSell3 from dual;
                  end if;


            -- insert solddtl
                     INSERT INTO SOLDDTL
                        (AUTOID,
                        ACCTNO,
                        SYMBOL,
                        TLTXCD,
                        PRICE,
                        PARVALUE,
                        QTTY,
                        CONFIRMNO,
                        TRNTYPE,
                        RETURN_QTTY,
                        TRNDATE,
                        BEFORE_LIMIT,
                        REMAIN_LIMIT,
                        RETURN_LIMIT,
                        BEFORE_LIMIT_ASS,
                        REMAIN_LIMIT_ASS,
                        RETURN_LIMIT_ASS,
                        BEFORE_LIMIT_PRD,
                        REMAIN_LIMIT_PRD,
                        RETURN_LIMIT_PRD,
                        DELTD,
                        product)
                    VALUES(
                        seq_solddtl.NEXTVAL ,--autoid
                        l_afacctno,--afacctno
                        l_symbol,--symbol
                        '8725',--tltxcd
                        p_price,--price
                        l_parvalue,--parvalue
                        p_qtty,--qtty
                        l_confirmno,--confirmno
                        'D',--trntype
                        0,--return_qtty
                        sysdate,--trndate
                        NVL(l_limitTotalRemain,''),--before_limit
                        nvl(l_limitTotalRemain- p_qtty*l_priceSell,''),--remain_limit
                        0,--return_limit
                        NVL(l_limitAssetRemain,''),--BEFORE_LIMIT_ASS
                        nvl(l_limitAssetRemain- p_qtty*l_priceSell2,''),--REMAIN_LIMIT_ASS
                        0,--RETURN_LIMIT_ASS
                        NVL(l_limitProductRemain,''),--BEFORE_LIMIT_PRD
                        nvl(l_limitProductRemain- p_qtty*l_priceSell3,''),--REMAIN_LIMIT_PRD
                        0,--RETURN_LIMIT_PRD
                        'N',--deltd
                         l_shortname);--product

            -- hoan han muc mua lai
                  l_limitTotal:= fn_get_limit_buy_total(l_afacctno);
                  l_limitAsset:= fn_get_limit_buy_symbol(l_afacctno,l_symbol);
                  l_limitProduct:= fn_get_limit_buy_product(l_afacctno,l_symbol,l_shortname);
                  l_limitBuyTotalRemain:= fn_cal_limit_buy_remain_total(l_afacctno);
                  l_limitBuySymbolRemain:=fn_cal_limit_buy_remain_symbol(l_afacctno,l_symbol);
                  l_limitBuyProductRemain:= fn_cal_limit_buy_remain_prd(l_afacctno,l_symbol,l_shortname);

                  l_methodLimitBuyTotal:= fn_get_limit_method_buy_total(l_afacctno);
                  l_methodLimitBuyAsset:= fn_get_limit_method_buy_symbol(l_afacctno,l_symbol);
                  l_methodLimitBuyProduct:= fn_get_limit_method_buy_prd(l_afacctno,l_symbol,l_shortname);


            p_qttybuy:=p_qtty;
            for rec in
            (select * from boughtdtl where trntype= 'D' and (qtty - return_qtty)>0 and acctno= l_afacctno and symbol = l_symbol order by autoid asc)
            LOOP
                if l_methodLimitBuyTotal is not null then
                    select DECODE(l_methodLimitBuyTotal,'F',rec.parvalue,'P',rec.price) into l_price_by_total from dual;
                end if;
                if l_methodLimitBuyAsset is not null then
                    select DECODE(l_methodLimitBuyAsset,'F',rec.parvalue,'P',rec.price) into l_price_by_symbol from dual;
                end if;
                if l_methodLimitBuyProduct is not null then
                  select DECODE(l_methodLimitBuyProduct,'F',rec.parvalue,'P',rec.price) into l_price_by_product from dual;
                end if;

            if p_qttybuy < (rec.qtty - rec.return_qtty) then

                update boughtdtl  set return_qtty = return_qtty +  p_qttybuy ,
                                   return_limit = return_limit + nvl(l_price_by_total*p_qttybuy,0),
                                   return_limit_ass = return_limit_ass + nvl(l_price_by_symbol*p_qttybuy,0),
                                   return_limit_prd = return_limit_prd + nvl(l_price_by_product*p_qttybuy,0)
                                 where autoid = rec.autoid;

                INSERT INTO BOUGHTDTL
                    (AUTOID, ACCTNO, SYMBOL, TLTXCD, PRICE, PARVALUE, QTTY, CONFIRMNO, TRNTYPE, RETURN_QTTY, RETURN_CONFIRMNO, TRNDATE,
                    BEFORE_LIMIT, REMAIN_LIMIT, RETURN_LIMIT,
                     BEFORE_LIMIT_ASS, REMAIN_LIMIT_ASS, RETURN_LIMIT_ASS,
                      BEFORE_LIMIT_PRD, REMAIN_LIMIT_PRD, RETURN_LIMIT_PRD,

                    DELTD, product)
                    VALUES(seq_boughtdtl.NEXTVAL, l_afacctno, l_symbol, '8725', rec.price, l_parvalue, p_qttybuy,l_confirmno, 'C',0, rec.confirmno, sysdate,
                     NVL( l_limitBuyTotalRemain,''),
                     nvl(LEAST(l_limitTotal, l_limitBuyTotalRemain + l_price_by_total * p_qttybuy),''),
                     0,
                     NVL( l_limitBuySymbolRemain,''),
                     nvl(LEAST(l_limitAsset, l_limitBuySymbolRemain + l_price_by_symbol * p_qttybuy),''),
                     0,
                     NVL( l_limitBuyProductRemain,''),
                     nvl(LEAST(l_limitProduct, l_limitBuyProductRemain + l_price_by_product * p_qttybuy),''),
                     0,
                    'N', l_shortname);
                p_qttybuy:=p_qttybuy- p_qttybuy;

            else

                update boughtdtl  set return_qtty = rec.qtty ,
                                   return_limit = return_limit + nvl(l_price_by_total*
                                   (rec.qtty-rec.return_qtty),0),
                                   return_limit_ass = return_limit_ass + nvl(l_price_by_symbol*(rec.qtty-rec.return_qtty),0),
                                   return_limit_prd = return_limit_prd + nvl(l_price_by_product*(rec.qtty-rec.return_qtty),0)
                                 where autoid = rec.autoid;
                  INSERT INTO BOUGHTDTL
                    (AUTOID, ACCTNO, SYMBOL, TLTXCD, PRICE, PARVALUE, QTTY, CONFIRMNO, TRNTYPE, RETURN_QTTY, RETURN_CONFIRMNO, TRNDATE,
                    BEFORE_LIMIT, REMAIN_LIMIT, RETURN_LIMIT,
                     BEFORE_LIMIT_ASS, REMAIN_LIMIT_ASS, RETURN_LIMIT_ASS,
                      BEFORE_LIMIT_PRD, REMAIN_LIMIT_PRD, RETURN_LIMIT_PRD,

                    DELTD, product)
                    VALUES(seq_boughtdtl.NEXTVAL, l_afacctno, l_symbol, '8725', rec.price, l_parvalue, rec.qtty-rec.return_qtty,l_confirmno, 'C',0, rec.confirmno, sysdate,
                     NVL( l_limitBuyTotalRemain,''),
                     nvl(LEAST(l_limitTotal, l_limitBuyTotalRemain + l_price_by_total * (rec.qtty-rec.return_qtty)),''),
                     0,
                     NVL( l_limitBuySymbolRemain,''),
                     nvl(LEAST(l_limitAsset, l_limitBuySymbolRemain + l_price_by_symbol * (rec.qtty-rec.return_qtty)),''),
                     0,
                     NVL( l_limitBuyProductRemain,''),
                     nvl(LEAST(l_limitProduct, l_limitBuyProductRemain + l_price_by_product * (rec.qtty-rec.return_qtty)),''),
                     0,
                    'N', l_shortname);
                p_qttybuy:=p_qttybuy-(rec.qtty - rec.return_qtty);
            end if;

                if p_qttybuy <=0 then
                    exit;
                end if;
            END LOOP;

            end if;
        end if;
         -- TH khach hang d?t mua ==> g?i d?n KSV phê duy?t h? so bán
            if p_tlid ='686868' then
                prc_process_8102(P_TXNUM=>p_txnum,
                P_TXDATE=>p_txdate,
                P_BUSDATE=>p_busdate,
                P_TXTIME=>p_txtime,
                P_TLTXCD=>p_tltxcd,
                P_TXDESC=>p_txdesc,
                P_TLID=>p_tlid,
                P_OFFID=>p_offid,
                P_CONFIRMNO=>l_confirmno,
                P_TXNUMREF=>'',
                P_MODE=>'C',
                P_REASON=>'',
                P_ERR_CODE=>p_err_code);
            end if;
      p_err_code := '';
    plog.setEndSection(pkgctx, 'prc_sysprocess');
exception when others then
    p_err_code := errnums.C_SYSTEM_ERROR;
    plog.debug(pkgctx,'LOG.8725.ERRR');
    RAISE;

end;
/

DROP PROCEDURE prc_report_create_rpt_request_manageracct
/

CREATE OR REPLACE 
PROCEDURE prc_report_create_rpt_request_manageracct (p_reqid varchar2, p_rptid varchar2, p_rptparam varchar2, p_exptype varchar2, p_tlid varchar2, p_tlname varchar2, p_role varchar2, p_reflogid varchar2, p_priority varchar2, p_export_path varchar2,  p_refrptlogs in out varchar2, p_refrptauto varchar2, p_isauto varchar2, p_err_code in out varchar2, p_err_param in out varchar2)


as

/**----------------------------------------------------------------------------------------------------
 **  FUNCTION: prc_report_create_rpt_request: T?o yêu c?u k?t xu?t d? li?u
 **  Person         Date            Comments
 **  DieuNDA       02/05/2018       Created
 ** (c) 2018 by Financial Software Solutions. JSC.
 ** ----------------------------------------------------------------------------------------------------*/

    l_count number;
    v_logsctx       varchar2(500);
    v_logsbody      varchar2(500);
    v_exception     varchar2(500);
    v_currdate      date;
    pv_language     varchar2(500);
    l_isauto        char(1);
    v_fromdate      varchar2(500);
    v_todate        varchar2(500);
    v_fdate         date;
    v_tdate         date;
    t_priority      varchar2(500);
     pkgctx   plog.log_ctx;

BEGIN
    plog.setBeginSection(pkgctx, 'prc_report_create_rpt_request_manageracct');
    plog.error(pkgctx, 'prc_report_create_rpt_request_manageracct');
    p_err_code  := systemnums.C_SUCCESS;
    p_err_param := 'SUCCESS';

    --Check khi batch không du?c phép t?o báo cáo
    SELECT count(*) INTO l_count
    FROM SYSVAR
    WHERE GRNAME='SYSTEM'
    AND VARNAME='HOSTATUS'
    AND VARVALUE= fn_systemnums('systemnums.C_OPERATION_ACTIVE');

    IF l_count = 0 THEN
        p_err_code := fn_systemnums('errnums.C_HOST_OPERATION_ISINACTIVE');
        p_err_param := fn_get_errmsg(p_err_code);
        plog.error(pkgctx, 'prc_report_create_rpt_request_manageracct'||p_err_code);
        RETURN ;
    END IF;

    t_priority := nvl(p_priority,'0');
    /*
    begin
        SELECT string_to_array(p_rptparam, ',') into v_arrparam;
    EXCEPTION
       WHEN OTHERS then
            v_arrparam := '';
    end;
*/
--  v_fromdate  := null;
--  v_todate    := null;
    SELECT count(1) INTO l_count
    FROM (
        SELECT
        REGEXP_REPLACE(TRIM (fil.char_value), '\(|\)', '') fil_cond, fil.rid
        FROM
        (
            SELECT
                fn_pivot_string ( REGEXP_REPLACE (p_rptparam, ',', '|')) filter_row
            FROM
                DUAL ), TABLE (filter_row) fil
    )twt;
    if l_count <> 0 then
        for rec in
        (
            select defname,  odrnum
            from rptfields where objname = p_rptid  --; and defname in ('F_DATE', 'T_DATE')
            order by odrnum
        )loop
            FOR i IN  (SELECT * FROM  (

            SELECT
            REGEXP_REPLACE(TRIM (fil.char_value), '\(|\)', '') fil_cond, fil.rid
            FROM
            (
                SELECT
                    fn_pivot_string ( REGEXP_REPLACE (t_priority, ',', '|')) filter_row
                FROM
                    DUAL ), TABLE (filter_row) fil
                ) a
                )
            LOOP
                IF rec.defname = 'F_DATE'
                THEN
                    IF i.rid = rec.odrnum
                        THEN
                        v_fromdate := i.fil_cond;
                    END IF;
                ELSIF rec.defname = 'T_DATE' THEN
                    IF i.rid = rec.odrnum
                        THEN
                            v_todate := i.fil_cond;
                    END IF;
                END IF;

            END LOOP;

        end loop;

        if v_fromdate is not null and length(v_fromdate) > 0 then
            if v_todate is not null and length(v_todate) > 0 then

                if  to_date(v_fromdate, 'dd/mm/yyyy') >  to_date(v_todate, 'dd/mm/yyyy') then
                    p_err_code := '-100424';
                    p_err_param := fn_get_errmsg(p_err_code);

                    RETURN ;
                end if;
            end if;
        end if;
    end if;

    --tao request tron rptlogs
    IF length(p_refrptlogs) > 0  THEN
        INSERT INTO  rptlogs(autoid,reqid,rptid,rptparam,status,subuserid,exportpath,priority,crtdatetime,txdate,exptype,refemaillog,refrptauto,isauto,tlid,tlname,lang, custodycd)
        VALUES(p_refrptlogs,p_reqid,p_rptid,p_rptparam,'P',p_tlid,p_export_path,p_priority,LOCALTIMESTAMP,getcurrdate(),p_exptype,null,p_refrptauto,p_isauto, p_tlid, p_tlname,pv_language, p_reflogid);
    ELSE
        p_refrptlogs := seq_rptlogs.nextval;
        INSERT INTO  rptlogs(autoid,reqid,rptid,rptparam,status,subuserid,exportpath,priority,crtdatetime,txdate,exptype,refemaillog,refrptauto,isauto,tlid,tlname,lang, custodycd)
        VALUES(p_refrptlogs,p_reqid,p_rptid,p_rptparam,'P',p_tlid,p_export_path,p_priority,LOCALTIMESTAMP,getcurrdate(),p_exptype,null,p_refrptauto,p_isauto, p_tlid, p_tlname,pv_language, p_reflogid);
    END IF;


exception
when others then
  p_err_code := errnums.C_SYSTEM_ERROR;
  plog.error(pkgctx,'Err: ' || sqlerrm || ' Trace: ' || dbms_utility.format_error_backtrace );
  plog.setEndSection(pkgctx, 'prc_report_create_rpt_request_manageracct');
end prc_report_create_rpt_request_manageracct;
/

DROP PROCEDURE prc_reset_tlpassword
/

CREATE OR REPLACE 
PROCEDURE prc_reset_tlpassword (p_fullname IN VARCHAR2,
                                   p_email IN VARCHAR2,
                                   p_mobile IN VARCHAR2,
                                   p_tlname IN VARCHAR2,
                                   p_templateEmail IN VARCHAR2,
                                   p_templateSMS IN VARCHAR2)
is
    l_password varchar2(6);
    l_encryptpassword varchar2(1000);
    l_data_source varchar2(4000);
    l_currdate date;
    l_count number;
begin
    l_currdate := getcurrdate();


    -- Gen lai mat khau
    l_password := fn_passwordgenerator();

    -- Ma hoa mat khau
    l_encryptpassword := genencryptpassword(l_password);

    l_data_source := 'SELECT '''||p_tlname||''' varvalue, ''tlname'' varname from dual '|| CHR (10)
                        || 'union all ' || CHR (10)
                        ||'select '''||p_fullname||''' varvalue, ''tlfullname'' varname from dual '|| CHR (10)
                        || 'union all ' || CHR (10)
                        ||'select '''||to_char(l_currdate,'DD-MM-YYYY')||''' varvalue, ''currdate'' varname from dual '|| CHR (10)
                        || 'union all ' || CHR (10)
                        ||'select '''||l_password||''' varvalue, ''password'' varname from dual ';

    -- Gui email cho KH
    prc_insertemaillog(p_email,p_templateEmail,l_data_source, null,l_currdate, l_password);

    l_data_source := '';
    select count(1) into l_count
    from templates where code =p_templateSMS;

    if l_count > 0 then
        select coalesce(msgcontent,'')
            into l_data_source
        from templates where code =p_templateSMS;
    end if;


    if length(l_data_source) > 0 then
        l_data_source := replace(l_data_source, '[p_tlname]', p_tlname);
        l_data_source := replace(l_data_source, '[p_password]', l_password);
    else
        l_data_source := fn_systemnums('sysvar.brname') || ' thong bao tai khoan '||p_tlname||' cua co Mat khau dang nhap moi: '||l_password||'';
    end if;

    prc_insertemaillog(p_mobile,p_templateSMS,l_data_source, '',l_currdate, l_password);



    -- Cap nhat tlprofiles

    update tlprofiles
    set password = l_encryptpassword
    where upper(tlname) = upper(p_tlname);

exception when others then
    RAISE;

end;
/

DROP PROCEDURE prc_reset_userlogin
/

CREATE OR REPLACE 
PROCEDURE prc_reset_userlogin (p_custodycd IN VARCHAR2,
                                   p_fullname IN VARCHAR2,
                                   p_email IN VARCHAR2,
                                   p_mobile IN VARCHAR2,
                                   p_username IN VARCHAR2,
                                   p_templateEmail IN VARCHAR2,
                                   p_templateSMS IN VARCHAR2)
is
    l_password varchar2(6);
    l_encryptpassword varchar2(1000);
    l_data_source varchar2(4000);
    l_currdate date;
    l_count number;
begin
    l_currdate := getcurrdate();


    -- Gen lai mat khau
    l_password := fn_passwordgenerator();

    -- Ma hoa mat khau
    l_encryptpassword := genencryptpassword(l_password);

    l_data_source := 'SELECT '''||p_username||''' varvalue, ''username'' varname from dual '|| CHR (10)
                        || 'union all ' || CHR (10)
                        ||'select '''||p_username||''' varvalue, ''custodycd'' varname from dual '|| CHR (10)
                        || 'union all ' || CHR (10)
                        ||'select '''||p_fullname||''' varvalue, ''fullname'' varname from dual '|| CHR (10)
                        || 'union all ' || CHR (10)
                        ||'select '''||to_char(l_currdate,'DD-MM-YYYY')||''' varvalue, ''currdate'' varname from dual '|| CHR (10)
                        || 'union all ' || CHR (10)
                        ||'select '''||l_password||''' varvalue, ''password'' varname from dual ';

    -- Gui email cho KH

    prc_insertemaillog(p_email,p_templateEmail,l_data_source, p_custodycd,l_currdate, l_password);



    -- Gui SMS cho KH
    l_data_source := '';
    select count(1) into l_count
    from templates where code =p_templateSMS;

    if l_count > 0 then
        select coalesce(msgcontent,'')
            into l_data_source
        from templates where code =p_templateSMS;
    end if;


    if length(l_data_source) > 0 then
        l_data_source := replace(l_data_source, '[p_tlname]', p_username);
        l_data_source := replace(l_data_source, '[p_password]', l_password);
    else
        l_data_source := fn_systemnums('sysvar.brname') || ' thong bao So TKGD '||p_custodycd||' cua Quy Nha Dau Tu co Mat khau GD moi: '||l_password||'';
    end if;

    prc_insertemaillog(p_mobile,p_templateSMS,l_data_source, p_custodycd,l_currdate, l_password);



    -- Dong dong thong tin cu trong userlogin
    insert into userloginhist(username, handphone, loginpwd, tradingpwd, authtype,
                               status, loginstatus, lastchanged, numberofday,
                               lastlogin, isreset, ismaster, tokenid, custodycd)
    select username, handphone, loginpwd, tradingpwd, authtype,
           'E', loginstatus, lastchanged, numberofday,
           lastlogin, isreset, ismaster, tokenid, custodycd
    from userlogin u
    where USERNAME = p_username;

    --delete userlogin where username = p_username;
    update userlogin set status = 'E' where username = p_username;

    INSERT INTO userlogin (USERNAME,CUSTODYCD,LOGINPWD,TRADINGPWD,AUTHTYPE,STATUS,LOGINSTATUS,LASTCHANGED,NUMBEROFDAY,ISRESET,ISMASTER,TOKENID)
    VALUES(p_username,p_custodycd,l_encryptpassword,l_encryptpassword,'1','A','O',to_date(sysdate,'dd/mm/yyyy hh24:mi:ss'),30,'Y','N',NULL);

    update cfmast set username = p_username where custodycd = p_custodycd;

    txpks_notify.prc_system_logevent('USER', 'USER', 'ALL'|| '~#~' ||'ALL'|| '~#~' ||'ALL', 'R','refesh user');

exception when others then
    RAISE;

end;
/

DROP PROCEDURE prc_schdsts_processing
/

CREATE OR REPLACE 
PROCEDURE prc_schdsts_processing 
AS

--Tao mot scheduler chay thu tuc v_PrcName, sau do Scheduler tu dong drop.-
  v_count number(10);
  l_errcode VARCHAR2(100);
l_errmsg VARCHAR2(200);
    pkgctx     plog.log_ctx;
    l_pr_store varchar2(100);
BEGIN

FOR rec IN (SELECT * FROM schdsts WHERE status ='P'  )
LOOP
   UPDATE schdsts SET STATUS ='K' WHERE status ='P' AND ID = REC.ID;
   COMMIT;

IF  rec.schdtype='SRMATCHRED' THEN

l_pr_store:=  'txpks_auto.pr_excecute('''|| rec.sessionno ||''' , '''|| rec.codeid ||''',''NR'',''N'')';

ELSIF  rec.schdtype='SRMATCHSUB' THEN

l_pr_store:=  'txpks_auto.pr_excecute('''|| rec.sessionno ||''' , '''|| rec.codeid ||''',''NS'',''N'')';

ELSIF rec.schdtype='SRMATCHREDY' THEN

l_pr_store:=  'txpks_auto.pr_excecute('''|| rec.sessionno ||''' , '''|| rec.codeid ||''',''NR'',''Y'')';

ELSIF  rec.schdtype='SRMATCHSUBY' THEN

l_pr_store:=  'txpks_auto.pr_excecute('''|| rec.sessionno ||''' , '''|| rec.codeid ||''',''NS'',''Y'')';

ELSIF rec.schdtype='SRMATCHREDT' THEN

l_pr_store:=  'txpks_auto.pr_excecute('''|| rec.sessionno ||''' , '''|| rec.codeid ||''',''NR'',''T'')';

ELSIF  rec.schdtype='SRMATCHSUBT' THEN

l_pr_store:=  'txpks_auto.pr_excecute('''|| rec.sessionno ||''' , '''|| rec.codeid ||''',''NS'',''T'')';

ELSIF  rec.schdtype='SRALLOCATESE' THEN

l_pr_store:=  'txpks_auto.pr_excereceive('''|| rec.sessionno ||''' , '''|| rec.codeid ||''',''NS'')';

ELSIF  rec.schdtype='SRALLOCATECI' THEN

l_pr_store:=  'txpks_auto.pr_excereceive('''|| rec.sessionno ||''' , '''|| rec.codeid ||''',''NR'')';

ELSIF  rec.schdtype='SRCLS' THEN
l_pr_store:=
           'txpks_auto.pr_clsorder('''|| rec.sessionno ||''')';
ELSIF  rec.schdtype='PRGEN' THEN
l_pr_store:=
           'txpks_auto.pr_srsellagain('''|| rec.sessionno ||''')';
 ELSIF  rec.schdtype='SWH' THEN
 l_pr_store:=' txpks_auto.pr_taswitch('''|| rec.sessionno ||''')';

 ELSIF  rec.schdtype='REVERTEXEC' THEN
 l_pr_store:=' txpks_auto.pr_revertexcec('''|| rec.sessionno ||''')';
 END IF;

prc_create_schd(/*rec.sessionno|| */'TA' ||TO_CHAR(seq_schdsts_processing.NEXTVAL) ,l_pr_store );
--prc_create_schd(rec.schdtype,l_pr_store );

END LOOP;

   EXCEPTION
    WHEN OTHERS THEN

      plog.error(pkgctx, sqlerrm || dbms_utility.format_error_backtrace);
      plog.setendsection(pkgctx, 'pr_genIPOSession');

END;
/

DROP PROCEDURE prc_update_cfmast
/

CREATE OR REPLACE 
PROCEDURE prc_update_cfmast (p_custodycd IN VARCHAR2,
                                   p_isprofession IN VARCHAR2,
                                   p_professiontodate IN VARCHAR2,
                                   p_professionfrdate IN VARCHAR2,
                                   pv_action IN VARCHAR2,
                                   p_tlid IN VARCHAR2,
                                   p_role IN VARCHAR2,
                                   pv_objname IN VARCHAR2,
                                   p_err_code IN OUT VARCHAR2,
                                   p_err_param IN OUT VARCHAR2
                                   )
is

begin




    update cfmast set isprofession = p_isprofession , professiontodate= p_professiontodate,professionfrdate= p_professionfrdate , isexists= 'Y'
    where custodycd = p_custodycd;

exception when others then
    RAISE;

end;
/

DROP PROCEDURE prc_update_tlpassword
/

CREATE OR REPLACE 
PROCEDURE prc_update_tlpassword (p_fullname IN VARCHAR2,
                                   p_email IN VARCHAR2,
                                   p_mobile IN VARCHAR2,
                                   p_tlname IN VARCHAR2,
                                   p_newpass IN VARCHAR2,
                                   p_templateEmail IN VARCHAR2)
is
    l_password varchar2(6);
    l_encryptpassword varchar2(1000);
    l_data_source varchar2(4000);
    l_currdate date;
begin
    l_currdate := getcurrdate();


    -- Ma hoa mat khau
    --l_encryptpassword := genencryptpassword(p_newpass);

    l_data_source := 'SELECT '''||p_tlname||''' varvalue, ''tlname'' varname from dual '|| CHR (10)
                        || 'union all ' || CHR (10)
                        ||'select '''||p_fullname||''' varvalue, ''tlfullname'' varname from dual '|| CHR (10)
                        || 'union all ' || CHR (10)
                        ||'select '''||to_char(l_currdate,'DD-MM-YYYY')||''' varvalue, ''currdate'' varname from dual '|| CHR (10)
                        || 'union all ' || CHR (10)
                        ||'select '''||p_newpass||''' varvalue, ''password'' varname from dual ';

    -- Gui email cho KH
    prc_insertemaillog(p_email,p_templateEmail,l_data_source, null,l_currdate, p_newpass);



    -- Cap nhat tlprofiles

    update tlprofiles
    set password = genencryptpassword(p_newpass||salt)
    where upper(tlname) = upper(p_tlname);

exception when others then
    RAISE;

end;
/

DROP PROCEDURE prc_update_userpass
/

CREATE OR REPLACE 
PROCEDURE prc_update_userpass (p_custodycd IN VARCHAR2,
                                   p_fullname IN VARCHAR2,
                                   p_email IN VARCHAR2,
                                   p_mobile IN VARCHAR2,
                                   p_username IN VARCHAR2,
                                   p_newpass IN VARCHAR2,
                                   p_templateEmail IN VARCHAR2)
is
    l_password varchar2(6);
    l_encryptpassword varchar2(1000);
    l_data_source varchar2(4000);
    l_currdate date;
    l_count number;

    l_salt  varchar2(50);
begin
    l_currdate := getcurrdate();

    -- Ma hoa mat khau
    l_salt := fn_passwordgenerator();
    l_encryptpassword := genencryptpassword(p_newpass || l_salt);

    l_data_source := 'SELECT '''||p_username||''' varvalue, ''username'' varname from dual '|| CHR (10)
                        || 'union all ' || CHR (10)
                        ||'select '''||p_fullname||''' varvalue, ''fullname'' varname from dual '|| CHR (10)
                        || 'union all ' || CHR (10)
                        ||'select '''||to_char(l_currdate,'DD-MM-YYYY')||''' varvalue, ''currdate'' varname from dual '|| CHR (10)
                        || 'union all ' || CHR (10)
                        ||'select '''||p_newpass||''' varvalue, ''passtrade'' varname from dual ';

    -- Gui email cho KH
    prc_insertemaillog(p_email,p_templateEmail,l_data_source, p_custodycd,l_currdate, p_newpass);





    -- Dong dong thong tin cu trong userlogin
    insert into userloginhist(username, handphone, loginpwd, tradingpwd, authtype,
                               status, loginstatus, lastchanged, numberofday,
                               lastlogin, isreset, ismaster, tokenid, custodycd)
    select username, handphone, loginpwd, tradingpwd, authtype,
           'E', loginstatus, lastchanged, numberofday,
           lastlogin, isreset, ismaster, tokenid, custodycd
    from userlogin u
    where USERNAME = p_username;

    --delete userlogin where username = p_username;
    update userlogin set status = 'E' where username = p_username;

    INSERT INTO userlogin (USERNAME,CUSTODYCD,LOGINPWD,TRADINGPWD,AUTHTYPE,STATUS,LOGINSTATUS,LASTCHANGED,NUMBEROFDAY,ISRESET,ISMASTER,TOKENID, salt)
    VALUES(p_username,p_custodycd,l_encryptpassword,l_encryptpassword,'1','A','O',to_date(sysdate,'dd/mm/yyyy hh24:mi:ss'),30,'N','N',NULL, l_salt);

    update cfmast set username = p_username where custodycd = p_custodycd;

exception when others then
    RAISE;

end;
/

DROP PROCEDURE proc_get_thoi_gian_ky_truoc
/

CREATE OR REPLACE 
PROCEDURE proc_get_thoi_gian_ky_truoc 
(
  p_from_date           IN VARCHAR2,
  p_to_date             IN VARCHAR2,
  p_before_from_date    OUT VARCHAR2,
  p_before_to_date      OUT VARCHAR2
) AS
  l_date_format VARCHAR(12) := 'dd-MM-yyyy';

  l_from_date DATE := TO_DATE(p_from_date, l_date_format);
  l_to_date   DATE := TO_DATE(p_to_date, l_date_format);

  l_date_diff NUMBER := 0;
  l_before_from_date DATE;
  l_before_to_date   DATE;
BEGIN
  l_to_date := TRUNC(l_to_date) + 1 - 1/86400;

  l_date_diff := l_to_date - l_from_date;

  l_before_to_date   := TRUNC(l_from_date) - 1/86400;
  l_before_from_date := l_before_to_date - l_date_diff;

  p_before_from_date := TO_DATE(l_before_from_date, l_date_format);
  p_before_to_date   := TO_DATE(l_before_to_date, l_date_format);
END proc_get_thoi_gian_ky_truoc;
/

DROP PROCEDURE reset_seq
/

CREATE OR REPLACE 
PROCEDURE reset_seq ( p_seq_name in varchar2 )
is
    l_val number;
begin
    execute immediate
    'select ' || p_seq_name || '.nextval from dual' INTO l_val;

    execute immediate
    'alter sequence ' || p_seq_name || ' increment by -' || l_val || 
                                                          ' minvalue 0';

    execute immediate
    'select ' || p_seq_name || '.nextval from dual' INTO l_val;

    execute immediate
    'alter sequence ' || p_seq_name || ' increment by 1 minvalue 0';
end;
/

DROP PROCEDURE reset_sequence
/

CREATE OR REPLACE 
PROCEDURE reset_sequence (
seq_name IN VARCHAR2, startvalue IN PLS_INTEGER) AS

cval   INTEGER;
inc_by VARCHAR2(25);

BEGIN
  EXECUTE IMMEDIATE 'ALTER SEQUENCE ' ||seq_name||' MINVALUE 0';

  EXECUTE IMMEDIATE 'SELECT ' ||seq_name ||'.NEXTVAL FROM dual'
  INTO cval;

  cval := cval - startvalue + 1;
  IF cval < 0 THEN
    inc_by := ' INCREMENT BY ';
    cval:= ABS(cval);
  ELSE
    inc_by := ' INCREMENT BY -';
  END IF;

  EXECUTE IMMEDIATE 'ALTER SEQUENCE ' || seq_name || inc_by ||
  cval;

  EXECUTE IMMEDIATE 'SELECT ' ||seq_name ||'.NEXTVAL FROM dual'
  INTO cval;

  EXECUTE IMMEDIATE 'ALTER SEQUENCE ' || seq_name ||
  ' INCREMENT BY 1';

END reset_sequence;
/

DROP PROCEDURE sa0001
/

CREATE OR REPLACE 
PROCEDURE sa0001 (PV_REFCURSOR IN OUT PKG_REPORT.REF_CURSOR,
                                   PV_TLID      IN VARCHAR2,
                                   PV_BRID      IN VARCHAR2,
                                   PV_ROLECODE  IN VARCHAR2,
                                   PV_GROUP    IN VARCHAR2) IS
-- PURPOSE: BRIEFLY EXPLAIN THE FUNCTIONALITY OF THE PROCEDURE
--
-- MODIFICATION HISTORY
-- PERSON      DATE    COMMENTS
-- MINHTK   21-NOV-06  CREATED
-- ---------   ------  -------------------------------------------
   V_STRBRID          VARCHAR2 (10);        -- USED WHEN V_NUMOPTION > 0
   V_STRGRPID              VARCHAR2 (10);
   V_STRGRPID1              VARCHAR2 (60);
   V_STRGRPNAME            VARCHAR2 (500);
   V_STRACTIVE             VARCHAR2 (500);
   V_STRDESCRIPTION        VARCHAR2 (500);
   V_STRCOU                VARCHAR2 (500);
   V_STRGRPTYPE           VARCHAR2 (500);
   V_GRTYPE              VARCHAR2(100);
   V_STATUS              VARCHAR2(5);

   PV_CUR      PKG_REPORT.REF_CURSOR;

BEGIN

OPEN PV_REFCURSOR
  FOR
select TLG.GRPID, TLG.GRPNAME, tp.tlfullname ,tp.tlname ,m.mbname , tp.tlid , tp.department, tp.tltitle
from tlgrpusers tl, tlgroups tlg, tlprofiles tp, members m
where tl.grpid = tlg.grpid and tl.tlid = tp.tlid and m.mbcode = tp.mbid
and tl.grpid = PV_GROUP
;


 EXCEPTION
   WHEN OTHERS
   THEN

      RETURN;
END;                                                              -- PROCEDURE
/

DROP PROCEDURE sa0002
/

CREATE OR REPLACE 
PROCEDURE sa0002 (
                                   PV_REFCURSOR IN OUT PKG_REPORT.REF_CURSOR,
                                   PV_TLID      IN VARCHAR2,
                                   PV_BRID      IN VARCHAR2,
                                   PV_ROLECODE  IN VARCHAR2,
                                   PV_AAUTHID   IN VARCHAR2,
                                   PV_AUTHTYPE    IN VARCHAR2,
                                   PV_PLSENT    IN VARCHAR2
   )
IS
--
-- PURPOSE: BRIEFLY EXPLAIN THE FUNCTIONALITY OF THE PROCEDURE
--
-- MODIFICATION HISTORY
-- PERSON      DATE    COMMENTS
-- THENN   12-OCT-12  CREATED
-- ---------   ------  -------------------------------------------
   V_STROPTION        VARCHAR2 (5);       -- A: ALL; B: BRANCH; S: SUB-BRANCH
   V_STRBRID          VARCHAR2 (4);              -- USED WHEN V_NUMOPTION > 0
   V_STRAUTHID         VARCHAR2 (6);
   V_STRTLID                 VARCHAR2 (6);
   V_STRTLNAME               VARCHAR2 (30);
   V_STRTLFULLNAME           VARCHAR2 (50);
   V_STRTLLEV                VARCHAR2 (6);
   V_STRTLGROUP              VARCHAR2 (36);
   V_AUTHTYPE                VARCHAR2(1);
   V_STATUS                  VARCHAR2(5);
BEGIN

IF(PV_PLSENT <> 'ALL')
   THEN
        V_STATUS  := PV_PLSENT;
   ELSE
        V_STATUS  := '%%';
   END IF;

   -- GET REPORT'S PARAMETERS

    V_STRAUTHID:= PV_AAUTHID;
    V_AUTHTYPE := PV_AUTHTYPE;

   -- END OF GETTING REPORT'S PARAMETERS

    SELECT nvl(tl.tlid,''), nvl(tl.tlname,''), nvl(tl.tlfullname,'')/*, nvl(tl.tllev,'')*/--, nvl(tlg.grpname,'')
    INTO V_STRTLID,V_STRTLNAME,V_STRTLFULLNAME/*,V_STRTLLEV*/--,V_STRTLGROUP
    FROM tlprofiles tl
    WHERE tl.tlid = V_STRAUTHID and tl.active like v_status
        ;

    OPEN PV_REFCURSOR
    FOR
        SELECT V_STRTLID TLID,V_STRTLNAME TLNAME,V_STRTLFULLNAME FULLNAME/*,V_STRTLLEV LEV*/ /*,V_STRTLGROUP TLGROUP*/, DT.*
        FROM
            (
                -- QUYEN CHUC NANG
                SELECT /*fn_getparentgroupmenu(a.cmdcode,'M',null, 'Y') groupname,*/ a.cmdcode, a.txname,
                    DECODE(CASE WHEN a.uc1 IS NOT NULL THEN a.uc1 ELSE a.gc1 END,'Y','X','') c1,
                    DECODE(CASE WHEN a.uc2 IS NOT NULL THEN a.uc2 ELSE a.gc2 END,'Y','X','') c2,
                    DECODE(CASE WHEN a.uc3 IS NOT NULL THEN a.uc3 ELSE a.gc3 END,'Y','X','') c3,
                    DECODE(CASE WHEN a.uc4 IS NOT NULL THEN a.uc4 ELSE a.gc4 END,'Y','X','') c4,
                    DECODE(CASE WHEN a.uc5 IS NOT NULL THEN a.uc5 ELSE a.gc5 END,'Y','X','') c5,
                    DECODE(CASE WHEN a.uc6 IS NOT NULL THEN a.uc6 ELSE a.gc6 END,'Y','X','') C6,
                    A.C7 c7,NVL(A.C9,'') C9,A.TENNHOM
                FROM
                    (
                        SELECT gr.cmdcode, max(gr.txname) txname,
                            max(CASE WHEN gr.atype = 'U' THEN gr.c1 ELSE '' END) UC1,
                            max(CASE WHEN gr.atype = 'U' THEN gr.c2 ELSE '' END) UC2,
                            max(CASE WHEN gr.atype = 'U' THEN gr.c3 ELSE '' END) UC3,
                            max(CASE WHEN gr.atype = 'U' THEN gr.c4 ELSE '' END) UC4,
                            max(CASE WHEN gr.atype = 'U' THEN gr.c5 ELSE '' END) UC5,
                            max(CASE WHEN gr.atype = 'U' THEN gr.c6 ELSE '' END) UC6,
                            max(CASE WHEN gr.atype = 'G' THEN gr.c1 ELSE '' END) GC1,
                            max(CASE WHEN gr.atype = 'G' THEN gr.c2 ELSE '' END) GC2,
                            max(CASE WHEN gr.atype = 'G' THEN gr.c3 ELSE '' END) GC3,
                            max(CASE WHEN gr.atype = 'G' THEN gr.c4 ELSE '' END) GC4,
                            max(CASE WHEN gr.atype = 'G' THEN gr.c5 ELSE '' END) GC5,
                            max(CASE WHEN gr.atype = 'G' THEN gr.c6 ELSE '' END) GC6, max(C7) C7/*,nvl(gr.C8,'') C8*/,'' C9,NVL(GR.TENNHOM,'') TENNHOM
                        FROM
                            (
                                SELECT AU.AUTHID,au.cmdcode, MAX(au.cmdcode || ': ' || TO_CHAR(ME.CMDNAME))TXNAME, MAX(AU.CMDALLOW) C1,
                                    MAX(CASE WHEN ME.MENUTYPE IN ('A','P') THEN '' ELSE SUBSTR(AU.STRAUTH,1,1) END) C2,
                                    MAX(CASE WHEN ME.MENUTYPE IN ('A','P') THEN '' ELSE SUBSTR(AU.STRAUTH,2,1) END) C3,
                                    MAX(CASE WHEN ME.MENUTYPE IN ('A','P') THEN '' ELSE SUBSTR(AU.STRAUTH,3,1) END) C4,
                                    MAX(CASE WHEN ME.MENUTYPE IN ('A','P') THEN '' ELSE SUBSTR(AU.STRAUTH,4,1) END) C5,
                                     MAX(CASE WHEN ME.MENUTYPE IN ('A','P') THEN '' ELSE SUBSTR(AU.STRAUTH,5,1) END) C6,
                                      'M' C7, 'U' ATYPE,'' TENNHOM
                                FROM CMDMENU ME,CMDAUTH AU, VW_CMDMENU_ALL_RPT PT
                                WHERE ME.CMDID = AU.CMDCODE
                                    AND AU.CMDTYPE ='M' AND ME.MENUTYPE IN ('M','O','A','P')
                                    AND AU.AUTHTYPE ='U' and ME.last = 'Y'
                                    AND ME.CMDID=PT.CMDID
                                    AND AU.AUTHID =V_STRAUTHID
                                    AND INSTR(PT.en_cmdname,'General view')=0
                                    AND (AU.STRAUTH<>'NN' OR AU.CMDALLOW<>'N' OR  AU.STRAUTH<>'NNNN' )
                                GROUP BY AU.CMDCODE,AU.AUTHID
                                UNION ALL
                                -- quyen group
                                SELECT AU.AUTHID,au.cmdcode, MAX(au.cmdcode || ': ' || TO_CHAR(ME.CMDNAME))TXNAME,  MAX(AU.CMDALLOW) C1,
                                    MAX(CASE WHEN ME.MENUTYPE IN ('A','P') THEN '' ELSE SUBSTR(AU.STRAUTH,1,1) END) C2,
                                    MAX(CASE WHEN ME.MENUTYPE IN ('A','P') THEN '' ELSE SUBSTR(AU.STRAUTH,2,1) END) C3,
                                    MAX(CASE WHEN ME.MENUTYPE IN ('A','P') THEN '' ELSE SUBSTR(AU.STRAUTH,3,1) END) C4,
                                    MAX(CASE WHEN ME.MENUTYPE IN ('A','P') THEN '' ELSE SUBSTR(AU.STRAUTH,4,1) END) C5,
                                    MAX(CASE WHEN ME.MENUTYPE IN ('A','P') THEN '' ELSE SUBSTR(AU.STRAUTH,5,1) END) C6,
                                     'M' C7, 'G' ATYPE, TL.GRPNAME TENNHOM
                                FROM cmdmenu ME ,CMDAUTH AU, allcode a1, TLGROUPS TL, VW_CMDMENU_ALL_RPT PT
                                WHERE ME.CMDID = AU.CMDCODE
                                    AND AU.CMDTYPE ='M' AND ME.MENUTYPE IN ('M','O','A','P')
                                    AND AU.AUTHTYPE ='G' and ME.last = 'Y'
                                    AND V_AUTHTYPE = 'G'
                                    AND ME.CMDID=PT.CMDID
                                     AND INSTR(PT.en_cmdname,'General view')=0
                                     and tl.active like v_status
                                     AND AU.AUTHID=TL.GRPID
                                     AND TL.ACTIVE LIKE V_STATUS
                                     AND (AU.STRAUTH<>'NN' OR AU.CMDALLOW<>'N' OR  AU.STRAUTH<>'NNNN' )
                                 AND EXISTS (SELECT tlg.grpid
                                                FROM tlgrpusers tlg, tlgroups tlr, tlprofiles tlp
                                                WHERE tlr.grpid = tlg.grpid AND tlp.tlid = tlg.tlid
                                                    AND tlr.active = 'Y'
                                                    AND tlg.grpid = au.AUTHID AND tlg.tlid =V_STRAUTHID
                                                )
                                GROUP BY au.cmdcode,A1.CDCONTENT,AU.AUTHID, TL.GRPNAME
                            ) gr
                        GROUP BY gr.cmdcode, GR.TENNHOM
                            ) a
                -- QUYEN BAO CAO
                UNION ALL
                 SELECT /*fn_getparentgroupmenu(a.cmdcode,'R',modcode, 'Y') groupname,*/ a.cmdcode, a.txname,
                    DECODE(CASE WHEN a.uc1 IS NOT NULL THEN a.uc1 ELSE a.gc1 END,'Y','X','') c1,
                    DECODE(CASE WHEN a.uc2 IS NOT NULL THEN a.uc2 ELSE a.gc2 END,'Y','X','') c2,
                    DECODE(CASE WHEN a.uc3 IS NOT NULL THEN a.uc3 ELSE a.gc3 END,'Y','X','') c3,
                    '' C4,
                    DECODE(CASE WHEN a.uc5 IS NOT NULL THEN a.uc5 ELSE a.gc5 END,'Y','X','') c5,
                    NVL(C6,'') C6, A.C7,NVL(A.C9,'') C9,A.TENNHOM
                FROM
                    (
                        SELECT gr.cmdcode, GR.MODCODE, max(gr.txname) txname,
                            max(CASE WHEN gr.atype = 'U' THEN gr.c1 ELSE '' END) UC1,
                            max(CASE WHEN gr.atype = 'U' THEN gr.c2 ELSE '' END) UC2,
                            max(CASE WHEN gr.atype = 'U' THEN gr.c3 ELSE '' END) UC3,
                            MIN(CASE WHEN gr.atype = 'U' THEN gr.c4 ELSE '' END) UC4,
                            max(CASE WHEN gr.atype = 'U' THEN gr.c5 ELSE '' END) UC5,
                            max(CASE WHEN gr.atype = 'G' THEN gr.c1 ELSE '' END) GC1,
                            max(CASE WHEN gr.atype = 'G' THEN gr.c2 ELSE '' END) GC2,
                            max(CASE WHEN gr.atype = 'G' THEN gr.c3 ELSE '' END) GC3,
                            MIN(CASE WHEN gr.atype = 'G' THEN gr.c4 ELSE '' END) GC4,
                            max(CASE WHEN gr.atype = 'G' THEN gr.c5 ELSE '' END) GC5,
                            max(C6) C6, MAX(C7) C7,'' C9, NVL(GR.TENNHOM,'') TENNHOM
                        FROM
                            (
                                SELECT AU.AUTHID,AU.CMDCODE, RPT.MODCODE, MAX(TO_CHAR(RPT.RPTID)||': '||TO_CHAR(RPT.DESCRIPTION)) TXNAME,
                                    MAX(AU.CMDALLOW) C1, MAX(SUBSTR(AU.STRAUTH,1,1)) C2, MAX(SUBSTR(AU.STRAUTH,2,1)) C3,
                                    MIN(SUBSTR(AU.STRAUTH,3,1)) C4 ,'' C5,'' C6, 'R' C7, 'U' ATYPE,'' TENNHOM
                                FROM RPTMASTER RPT ,CMDAUTH AU
                                WHERE RPT.RPTID = AU.CMDCODE
                                    AND AU.AUTHID = V_STRAUTHID
                                    AND RPT.VISIBLE='Y'
                                    AND RPT.CMDTYPE = 'R'
                                    AND (AU.STRAUTH<>'NN' OR AU.CMDALLOW<>'N')
                                    AND AU.AUTHTYPE='U'
                                GROUP BY AU.CMDCODE, RPT.MODCODE,AU.AUTHID
                                UNION ALL
                                -- QUYEN GROUP
                                SELECT AU.AUTHID,AU.CMDCODE, RPT.MODCODE, MAX(TO_CHAR(RPT.RPTID)||': '||TO_CHAR(RPT.DESCRIPTION)) TXNAME,
                                    MAX(AU.CMDALLOW) C1, MAX(SUBSTR(AU.STRAUTH,1,1)) C2, MAX(SUBSTR(AU.STRAUTH,2,1)) C3,
                                    MIN(SUBSTR(AU.STRAUTH,3,1)) C4 ,'' C5,'' C6, 'R' C7, 'G' ATYPE/*,A1.CDCONTENT C8*/, TL.GRPNAME TENNHOM
                                FROM RPTMASTER RPT ,CMDAUTH AU/*,ALLCODE A1*/, TLGROUPS TL
                                WHERE RPT.RPTID = AU.CMDCODE
                                AND AU.AUTHID=TL.GRPID
                                    AND RPT.VISIBLE='Y'
                                    AND RPT.CMDTYPE = 'R'
                                    AND (AU.STRAUTH<>'NN' OR AU.CMDALLOW<>'N')
                                    AND AU.AUTHTYPE='G'
                                    AND TL.ACTIVE LIKE V_STATUS
                                    AND  V_AUTHTYPE = 'G'
                                    AND EXISTS (SELECT tlg.grpid
                                                FROM tlgrpusers tlg, tlgroups tlr, tlprofiles tlp
                                                WHERE tlr.grpid = tlg.grpid AND tlp.tlid = tlg.tlid
                                                    AND tlr.active = 'Y'
                                                    AND tlg.grpid = au.AUTHID AND tlg.tlid =V_STRAUTHID
                                                )
                                GROUP BY AU.CMDCODE, RPT.MODCODE,AU.AUTHID, TL.GRPNAME

                            ) GR
                        GROUP BY GR.CMDCODE, GR.MODCODE,GR.TENNHOM
                    ) a
   -- QUYEN GIAO DICH
                UNION ALL
         SELECT /*fn_getparentgroupmenu(a.cmdcode,'R',modcode, 'Y') groupname,*/ a.cmdcode, a.txname,
                    DECODE(CASE WHEN a.uc1 IS NOT NULL THEN a.uc1 ELSE a.gc1 END,'Y','X','') c1,
                    DECODE(CASE WHEN a.uc2 IS NOT NULL THEN a.uc2 ELSE a.gc2 END,'Y','X','') c2,
                    DECODE(CASE WHEN a.uc3 IS NOT NULL THEN a.uc3 ELSE a.gc3 END,'Y','X','') c3,
                    '' C4,
                    DECODE(CASE WHEN a.uc5 IS NOT NULL THEN a.uc5 ELSE a.gc5 END,'Y','X','') c5,
                    NVL(C6,'') C6, A.C7,NVL(A.C9,'') C9,A.TENNHOM
                FROM
                    (
         SELECT gr.cmdcode, max(gr.txname) txname,
                            max(CASE WHEN gr.atype = 'U' THEN gr.c1 ELSE '' END) UC1,
                            max(CASE WHEN gr.atype = 'U' THEN gr.c2 ELSE '' END) UC2,
                            max(CASE WHEN gr.atype = 'U' THEN gr.c3 ELSE '' END) UC3,
                            MIN(CASE WHEN gr.atype = 'U' THEN gr.c4 ELSE '' END) UC4,
                            max(CASE WHEN gr.atype = 'U' THEN gr.c5 ELSE '' END) UC5,
                            max(CASE WHEN gr.atype = 'G' THEN gr.c1 ELSE '' END) GC1,
                            max(CASE WHEN gr.atype = 'G' THEN gr.c2 ELSE '' END) GC2,
                            max(CASE WHEN gr.atype = 'G' THEN gr.c3 ELSE '' END) GC3,
                            MIN(CASE WHEN gr.atype = 'G' THEN gr.c4 ELSE '' END) GC4,
                            max(CASE WHEN gr.atype = 'G' THEN gr.c5 ELSE '' END) GC5,
                            max(C6) C6, MAX(C7) C7,'' C9, NVL(GR.TENNHOM,'') TENNHOM
                        FROM
                            (
                                SELECT AU.AUTHID,AU.CMDCODE, MAX(TO_CHAR(TL.TLTXCD )||': '||TO_CHAR(TL.TXDESC)) TXNAME,
                                    MAX(case when substr(au.strauth,1,1) = 'Y' OR substr(au.strauth,3,1) = 'Y' OR substr(au.strauth,5,1) = 'Y' OR substr(au.strauth,7,1) = 'Y' THEN 'Y' ELSE 'N' END) C1,
                                    '' C2,
                                    MAX(case when SUBSTR(AU.STRAUTH,2,1) = 'Y' OR SUBSTR(AU.STRAUTH,4,1) = 'Y' OR SUBSTR(AU.STRAUTH,6,1) = 'Y' OR SUBSTR(AU.STRAUTH,8,1) = 'Y' THEN 'Y' ELSE 'N' END) C3,
                                    '' C4 ,'' C5,'' C6, 'T' C7, 'U' ATYPE,'' TENNHOM
                                FROM TLTX TL ,CMDAUTH AU
                                WHERE
                                     AU.AUTHID = V_STRAUTHID
                                     AND TL.TLTXCD = AU.CMDCODE
                                    AND (AU.STRAUTH<>'NN' OR AU.CMDALLOW<>'N')
                                    AND AU.AUTHTYPE='U'
                                GROUP BY AU.CMDCODE,AU.AUTHID
                                UNION ALL
                                -- QUYEN GROUP
                                SELECT AU.AUTHID,AU.CMDCODE, MAX(TO_CHAR(TL.TLTXCD)||': '||TO_CHAR(TL.TXDESC)) TXNAME,
                                    MAX(case when substr(au.strauth,1,1) = 'Y' OR substr(au.strauth,3,1) = 'Y' OR substr(au.strauth,5,1) = 'Y' OR substr(au.strauth,7,1) = 'Y' THEN 'Y' ELSE 'N' END) C1,
                                    '' C2,
                                    MAX(case when SUBSTR(AU.STRAUTH,2,1) = 'Y' OR SUBSTR(AU.STRAUTH,4,1) = 'Y' OR SUBSTR(AU.STRAUTH,6,1) = 'Y' OR SUBSTR(AU.STRAUTH,8,1) = 'Y' THEN 'Y' ELSE 'N' END) C3,
                                    '' C4 ,'' C5,'' C6, 'T' C7, 'G' ATYPE, TL.GRPNAME TENNHOM
                                FROM TLTX TL ,CMDAUTH AU, TLGROUPS TL
                                WHERE TL.TLTXCD = AU.CMDCODE
                                    AND AU.AUTHID=TL.GRPID
                                    AND (AU.STRAUTH<>'NN' OR AU.CMDALLOW<>'N')
                                    AND AU.AUTHTYPE='G'
                                    AND TL.ACTIVE LIKE V_STATUS
                                    AND  V_AUTHTYPE = 'G'
                                    AND EXISTS (SELECT tlg.grpid
                                                FROM tlgrpusers tlg, tlgroups tlr, tlprofiles tlp
                                                WHERE tlr.grpid = tlg.grpid AND tlp.tlid = tlg.tlid
                                                    AND tlr.active = 'Y'
                                                    AND tlg.grpid = au.AUTHID AND tlg.tlid =V_STRAUTHID
                                                )
                                GROUP BY AU.CMDCODE,AU.AUTHID, TL.GRPNAME
                            ) GR
                        GROUP BY GR.CMDCODE,GR.TENNHOM
                       ) A
                union ALL
    -- QUYEN TRA CUU TONG HOP
                SELECT /*fn_getparentgroupmenu(a.cmdcode,'S',modcode, 'Y') groupname,*/ A.CMDCODE, A.TXNAME, A.TRUYCAP C1, NVL(B.C1,'') C2,
                 NVL(B.C3,'') C3, '' c4, '' C5, '' C6, 'G' C7,A.C9,A.TENNHOM
                FROM
                    (   -- DANH SACH TRA CUU TONG HOP
                        SELECT GR.CMDCODE, GR.MODCODE,GR.TRUYCAP, MAX(GR.TLTXCD) TLTXCD, MAX(GR.TXNAME) TXNAME,NVL(GR.C9,'') C9,NVL(GR.TENNHOM,'') TENNHOM
                        FROM
                            (
                                SELECT AU.AUTHID,AU.CMDCODE, RPT.modcode, max(nvl(sr.tltxcd,'')) tltxcd,
                                  MAX(DECODE(AU.CMDALLOW,'Y','X','')) TRUYCAP,MAX(DECODE(SUBSTR(AU.STRAUTH,1,1),'Y','X',''))  C9,
                                 MAX(RPT.RPTID ||'-'|| CASE WHEN SR.TLTXCD IS NULL THEN 'VIEW' ELSE SR.TLTXCD END ||': '|| RPT.DESCRIPTION) TXNAME, '' TENNHOM
                                FROM RPTMASTER RPT ,CMDAUTH AU, search sr, VW_CMDMENU_ALL_RPT PT
                                WHERE RPT.RPTID = AU.CMDCODE AND SR.SEARCHCODE = RPT.RPTID
                                    AND RPT.CMDTYPE in ('V','D','L') AND rpt.visible = 'Y'
                                    AND RPT.RPTID=PT.CMDID
                                    AND au.cmdtype = 'G'
                                    --AND INSTR(PT.en_cmdname,'General view')=0
                                    AND AU.AUTHID = V_STRAUTHID
                                    AND AU.AUTHTYPE='U'
                                GROUP BY AU.CMDCODE, RPT.modcode,AU.AUTHID
                                UNION ALL
                                -- QUYEN GROUP
                               SELECT GD.*, A.GRPNAME TENNHOM FROM
                                  (  SELECT AU.AUTHID,AU.CMDCODE, RPT.modcode, max(nvl(sr.tltxcd,'')) tltxcd,
                                MAX(DECODE(AU.CMDALLOW,'Y','X','')) TRUYCAP,MAX(DECODE(SUBSTR(AU.STRAUTH,1,1),'Y','X',''))  C9,
                                 MAX(RPT.RPTID ||'-'|| CASE WHEN SR.TLTXCD IS NULL THEN 'VIEW' ELSE SR.TLTXCD END ||': '|| RPT.DESCRIPTION) TXNAME
                                FROM RPTMASTER RPT ,CMDAUTH AU, search sr,ALLCODE A1, VW_CMDMENU_ALL_RPT PT
                                WHERE RPT.RPTID = AU.CMDCODE AND SR.SEARCHCODE = RPT.RPTID
                                    AND RPT.CMDTYPE in ('V','D','L') AND rpt.visible = 'Y'
                                    AND au.cmdtype = 'G'
                                    AND RPT.RPTID=PT.CMDID
                                    AND AU.AUTHTYPE='G'
                                    AND INSTR(PT.en_cmdname,'General view')=0
                                    AND V_AUTHTYPE = 'G'
                                    AND EXISTS (SELECT tlg.grpid
                                                FROM tlgrpusers tlg, tlgroups tlr, tlprofiles tlp
                                                WHERE tlr.grpid = tlg.grpid AND tlp.tlid = tlg.tlid
                                                    AND tlr.active = 'Y'
                                                    AND tlg.grpid = au.AUTHID AND tlg.tlid =V_STRAUTHID
                                                )
                                GROUP BY AU.CMDCODE, RPT.modcode,A1.CDCONTENT,AU.AUTHID) GD,
                                    (SELECT AU.*,TL.GRPNAME FROM CMDAUTH AU , TLGROUPS TL
                                             WHERE AU.CMDTYPE='G'
                                              AND AUTHTYPE='G'
                                              AND AU.AUTHID=TL.GRPID ) A
                                  WHERE  GD.AUTHID=A.AUTHID AND GD.CMDCODE=A.CMDCODE
                            ) GR
                        GROUP BY GR.CMDCODE, GR.modcode,GR.TRUYCAP,GR.C9,GR.TENNHOM
                    ) A
                    LEFT JOIN
                    (
                    SELECT /*fn_getparentgroupmenu(a.cmdcode,'R',modcode, 'Y') groupname,*/ a.cmdcode, a.txname,
                    DECODE(CASE WHEN a.uc1 IS NOT NULL THEN a.uc1 ELSE a.gc1 END,'Y','X','') c1,
                    DECODE(CASE WHEN a.uc2 IS NOT NULL THEN a.uc2 ELSE a.gc2 END,'Y','X','') c2,
                    DECODE(CASE WHEN a.uc3 IS NOT NULL THEN a.uc3 ELSE a.gc3 END,'Y','X','') c3,
                    '' C4,
                    DECODE(CASE WHEN a.uc5 IS NOT NULL THEN a.uc5 ELSE a.gc5 END,'Y','X','') c5,
                    NVL(C6,'') C6, A.C7,NVL(A.C9,'') C9,A.TENNHOM
                FROM
                    (
         SELECT gr.cmdcode, max(gr.txname) txname,
                            max(CASE WHEN gr.atype = 'U' THEN gr.c1 ELSE '' END) UC1,
                            max(CASE WHEN gr.atype = 'U' THEN gr.c2 ELSE '' END) UC2,
                            max(CASE WHEN gr.atype = 'U' THEN gr.c3 ELSE '' END) UC3,
                            MIN(CASE WHEN gr.atype = 'U' THEN gr.c4 ELSE '' END) UC4,
                            max(CASE WHEN gr.atype = 'U' THEN gr.c5 ELSE '' END) UC5,
                            max(CASE WHEN gr.atype = 'G' THEN gr.c1 ELSE '' END) GC1,
                            max(CASE WHEN gr.atype = 'G' THEN gr.c2 ELSE '' END) GC2,
                            max(CASE WHEN gr.atype = 'G' THEN gr.c3 ELSE '' END) GC3,
                            MIN(CASE WHEN gr.atype = 'G' THEN gr.c4 ELSE '' END) GC4,
                            max(CASE WHEN gr.atype = 'G' THEN gr.c5 ELSE '' END) GC5,
                            max(C6) C6, MAX(C7) C7,'' C9, NVL(GR.TENNHOM,'') TENNHOM
                        FROM
                            (
                                SELECT AU.AUTHID,AU.CMDCODE, MAX(TO_CHAR(TL.TLTXCD )||': '||TO_CHAR(TL.TXDESC)) TXNAME,
                                    MAX(case when substr(au.strauth,1,1) = 'Y' OR substr(au.strauth,3,1) = 'Y' OR substr(au.strauth,5,1) = 'Y' OR substr(au.strauth,7,1) = 'Y' THEN 'Y' ELSE 'N' END) C1,
                                    '' C2,
                                    MAX(case when SUBSTR(AU.STRAUTH,2,1) = 'Y' OR SUBSTR(AU.STRAUTH,4,1) = 'Y' OR SUBSTR(AU.STRAUTH,6,1) = 'Y' OR SUBSTR(AU.STRAUTH,8,1) = 'Y' THEN 'Y' ELSE 'N' END) C3,
                                    '' C4 ,'' C5,'' C6, 'G' C7, 'U' ATYPE,'' TENNHOM
                                FROM TLTX TL ,CMDAUTH AU
                                WHERE
                                     AU.AUTHID = V_STRAUTHID
                                     AND TL.TLTXCD = AU.CMDCODE
                                    AND (AU.STRAUTH<>'NN' OR AU.CMDALLOW<>'N')
                                    AND AU.AUTHTYPE='U'
                                GROUP BY AU.CMDCODE,AU.AUTHID
                                UNION ALL
                                -- QUYEN GROUP
                                SELECT AU.AUTHID,AU.CMDCODE, MAX(TO_CHAR(TL.TLTXCD)||': '||TO_CHAR(TL.TXDESC)) TXNAME,
                                    MAX(case when substr(au.strauth,1,1) = 'Y' OR substr(au.strauth,3,1) = 'Y' OR substr(au.strauth,5,1) = 'Y' OR substr(au.strauth,7,1) = 'Y' THEN 'Y' ELSE 'N' END) C1,
                                    '' C2,
                                    MAX(case when SUBSTR(AU.STRAUTH,2,1) = 'Y' OR SUBSTR(AU.STRAUTH,4,1) = 'Y' OR SUBSTR(AU.STRAUTH,6,1) = 'Y' OR SUBSTR(AU.STRAUTH,8,1) = 'Y' THEN 'Y' ELSE 'N' END) C3,
                                    '' C4 ,'' C5,'' C6, 'G' C7, 'G' ATYPE, TL.GRPNAME TENNHOM
                                FROM TLTX TL ,CMDAUTH AU, TLGROUPS TL
                                WHERE TL.TLTXCD = AU.CMDCODE
                                    AND AU.AUTHID=TL.GRPID
                                    AND (AU.STRAUTH<>'NN' OR AU.CMDALLOW<>'N')
                                    AND AU.AUTHTYPE='G'
                                    AND TL.ACTIVE LIKE V_STATUS
                                    AND  V_AUTHTYPE = 'G'
                                    AND EXISTS (SELECT tlg.grpid
                                                FROM tlgrpusers tlg, tlgroups tlr, tlprofiles tlp
                                                WHERE tlr.grpid = tlg.grpid AND tlp.tlid = tlg.tlid
                                                    AND tlr.active = 'Y'
                                                    AND tlg.grpid = au.AUTHID AND tlg.tlid =V_STRAUTHID
                                                )
                                GROUP BY AU.CMDCODE,AU.AUTHID, TL.GRPNAME
                            ) GR
                        GROUP BY GR.CMDCODE,GR.TENNHOM
                       ) A
                    ) B
                    ON A.TLTXCD = B.CMDCODE
            ) DT
        ORDER BY DT.C7, DT.CMDCODE, DT.TXNAME,DT.TENNHOM
    ;

    EXCEPTION
    WHEN OTHERS THEN
        RETURN;
    END;                                                              -- PROCEDURE
/

DROP PROCEDURE sa0003
/

CREATE OR REPLACE 
PROCEDURE sa0003 (
                                   PV_REFCURSOR IN OUT PKG_REPORT.REF_CURSOR,
                                   PV_TLID      IN VARCHAR2,
                                   PV_BRID      IN VARCHAR2,
                                   PV_ROLECODE  IN VARCHAR2,
                                   PV_AUTHID   IN VARCHAR2,
                                   PV_STATUS    IN VARCHAR2
   )
   IS
--
-- PURPOSE: BRIEFLY EXPLAIN THE FUNCTIONALITY OF THE PROCEDURE
--
-- MODIFICATION HISTORY
-- PERSON      DATE    COMMENTS
-- THENN   12-Oct-12  CREATED
-- ---------   ------  -------------------------------------------
   V_STROPTION        VARCHAR2 (5);       -- A: ALL; B: BRANCH; S: SUB-BRANCH
   V_STRBRID          VARCHAR2 (4);              -- USED WHEN V_NUMOPTION > 0
   V_STRAUTHID         VARCHAR2 (6);
   V_STRGRPID              VARCHAR2 (6);
    V_STRGRPID1              VARCHAR2 (6);
   V_STRGRPNAME            VARCHAR2 (500);
   V_STRACTIVE             VARCHAR2 (6);
   V_STRDESCRIPTION        VARCHAR2 (500);
   V_STRCOU                VARCHAR2 (6);
   V_STRGRPTYPE            VARCHAR2 (500);
   V_STATUS                VARCHAR2 (500);

 PV_CUR      PKG_REPORT.REF_CURSOR;
BEGIN
   -- GET REPORT'S PARAMETERS

   IF(PV_AUTHID <> 'ALL')
   THEN
        V_STRAUTHID  := PV_AUTHID;
   ELSE
        V_STRAUTHID  := '%%';
   END IF;

   IF(PV_STATUS <> 'ALL')
   THEN
        V_STATUS  := PV_STATUS;
   ELSE
        V_STATUS  := '%%';
   END IF;

   -- END OF GETTING REPORT'S PARAMETERS
/*OPEN PV_CUR
    FOR
    SELECT TLGR.GRPID, TLGR.GRPNAME, AL2.CDCONTENT ACTIVE, TLGR.DESCRIPTION
    FROM TLGROUPS TLGR, ALLCODE AL2
    WHERE AL2.CDNAME='YESNO' AND  AL2.CDTYPE='SY' AND  AL2.CDVAL =TLGR.ACTIVE
        AND TLGR.ACTIVE LIKE V_STATUS
        AND TLGR.GRPID LIKE V_STRAUTHID;
LOOP
FETCH PV_CUR
   INTO V_STRGRPID1,V_STRGRPNAME,V_STRACTIVE,V_STRDESCRIPTION;
  EXIT WHEN PV_CUR%NOTFOUND;

END LOOP;*/

    OPEN PV_REFCURSOR
    FOR
        SELECT TG.GRPID GRPID,TG.GRPNAME GRPNAME,AL.CDCONTENT ACTIVE,TG.DESCRIPTION DESCRIPTION,V_STATUS STATUS1,
            DT.*
        FROM
            (
                -- QUYEN CHUC NANG
                SELECT PT.LEV,PT.ODRID/*,fn_getparentgroupmenu(au.cmdcode,'M',null, 'Y') groupname*/,TL.GRPID GRP,TL.GRPNAME TEN,  MAX(au.cmdcode || ': ' || TO_CHAR(ME.CMDNAME))TXNAME,
                    MAX(DECODE(AU.CMDALLOW,'Y','X','')) C1,
                    MAX(DECODE(CASE WHEN ME.MENUTYPE IN ('A','P') THEN '' ELSE SUBSTR(AU.STRAUTH,1,1) END,'Y','X','')) C2,
                    MAX(DECODE(CASE WHEN ME.MENUTYPE IN ('A','P') THEN '' ELSE SUBSTR(AU.STRAUTH,2,1) END,'Y','X','')) C3,
                    MAX(DECODE(CASE WHEN ME.MENUTYPE IN ('A','P') THEN '' ELSE SUBSTR(AU.STRAUTH,3,1) END,'Y','X','')) C4,
                    MAX(DECODE(CASE WHEN ME.MENUTYPE IN ('A','P') THEN '' ELSE SUBSTR(AU.STRAUTH,4,1) END,'Y','X','')) C5,
                    MAX(DECODE(CASE WHEN ME.MENUTYPE IN ('A','P') THEN '' ELSE SUBSTR(AU.STRAUTH,5,1) END,'Y','X','')) C6, 'M' C7,
                    '' C9
                FROM CMDMENU ME, CMDAUTH AU, TLGROUPS TL, VW_CMDMENU_ALL_RPT PT
                WHERE ME.CMDID = AU.CMDCODE
                    AND AU.CMDTYPE ='M' AND ME.MENUTYPE not in ('T','R')
                    AND AU.AUTHTYPE ='G' and ME.last = 'Y'
                    AND ME.CMDID=PT.CMDID
                    AND (AU.STRAUTH<>'NN' OR AU.CMDALLOW<>'N' OR  AU.STRAUTH<>'NNNN' )
                    and ME.LEV >= 0
                    AND AU.AUTHID=TL.GRPID
                    AND INSTR(PT.en_cmdname,'General view')=0
                    AND AU.AUTHID LIKE V_STRAUTHID
                    AND TL.ACTIVE LIKE V_STATUS
                GROUP BY PT.LEV,PT.ODRID, AU.CMDCODE,TL.GRPNAME,TL.GRPID
                UNION ALL
                -- QUYEN GIAO DICH
           SELECT PT.LEV,'' ODRID/*, fn_getparentgroupmenu(RPT.RPTID,'R',RPT.modcode, 'Y') groupname*/,TL.GRPID GRP,TL.GRPNAME TEN,
                    TO_CHAR(TL.TLTXCD)||'-'||TO_CHAR(TL.TXDESC) TXNAME,
                    MAX(case when substr(au.strauth,1,1) = 'Y' OR substr(au.strauth,3,1) = 'Y' OR substr(au.strauth,5,1) = 'Y' OR substr(au.strauth,7,1) = 'Y' THEN 'X' ELSE '' END) C1,
                    '' C2,
                    '' C3,
                    '' C4,
                    '' C5,
                    MAX(case when substr(au.strauth,2,1) = 'Y' OR substr(au.strauth,4,1) = 'Y' OR substr(au.strauth,6,1) = 'Y' OR substr(au.strauth,8,1) = 'Y' THEN 'X' ELSE '' END) C6, 'O' c7,'' C9
                FROM TLTX TL ,CMDAUTH AU, TLGROUPS TL, VW_CMDMENU_ALL_RPT PT
                WHERE TL.TLTXCD  = AU.CMDCODE
                    AND AU.AUTHID LIKE V_STRAUTHID
                    AND TL.ACTIVE LIKE V_STATUS
                    AND (AU.STRAUTH<>'NN' OR AU.CMDALLOW<>'N')
                    AND AU.AUTHTYPE='G'
                    AND PT.CMDID = TL.TLTXCD
                    --AND INSTR(PT.en_cmdname,'General view')=0
                    AND AU.AUTHID=TL.GRPID
                GROUP BY PT.LEV,TL.TLTXCD,TL.TXDESC,TL.GRPNAME,TL.GRPID
                UNION ALL
                -- QUYEN BAO CAO
                SELECT PT.LEV,PT.ODRID/*, fn_getparentgroupmenu(RPT.RPTID,'R',RPT.modcode, 'Y') groupname*/, TL.GRPID GRP,TL.GRPNAME TEN,
                    TO_CHAR(RPT.RPTID)||'-'||TO_CHAR(RPT.DESCRIPTION) TXNAME,
                    MAX(DECODE(SUBSTR(AU.STRAUTH,2,1),'Y','X','')) C1,
                    MAX(DECODE(AU.CMDALLOW,'Y','X','')) C2,
                    MAX(DECODE(SUBSTR(AU.STRAUTH,1,1),'Y','X','')) C3,
                    --MAX(SUBSTR(AU.STRAUTH,3,1)) C4,
                   /* max(a1.cdcontent) c4,*/  '' C4,
                    '' C5,'' C6, 'R' c7,'' C9
                FROM RPTMASTER RPT ,CMDAUTH AU, ALLCODE A1, TLGROUPS TL,VW_CMDMENU_ALL_RPT PT
                WHERE RPT.RPTID  = AU.CMDCODE
                    AND AU.AUTHID LIKE V_STRAUTHID
                       AND TL.ACTIVE LIKE V_STATUS
                    AND RPT.CMDTYPE ='R'
                    AND RPT.RPTID=PT.CMDID
                    AND (AU.STRAUTH<>'NN' OR AU.CMDALLOW<>'N')
                    AND AU.AUTHTYPE='G'
                    AND INSTR(PT.en_cmdname,'General view')=0
                    AND RPT.VISIBLE = 'Y'
                    AND AU.AUTHID=TL.GRPID
                GROUP BY PT.LEV,PT.ODRID,RPT.RPTID,RPT.DESCRIPTION,RPT.modcode,TL.GRPNAME,TL.GRPID
                UNION ALL
                -- QUYEN TRA CUU TONG HOP
                -- QUYEN TRA CUU TONG HOP
                SELECT A.LEV,A.ODRID/*,fn_getparentgroupmenu(A.CMDCODE,'S',A.modcode, 'Y') groupname*/,A.GRP,A.TEN,
                    A.TXNAME, NVL(A.C1,'') C1, NVL(B.C2,'') C2, NVL(B.C3,'') C3,
                    NVL(B.C4,'') C4, '' C5,NVL(B.C6,'')  C6, 'S' C7,NVL(B.C9,'') C9
                FROM
                    (   -- DANH SACH TRA CUU TONG HOP
                        SELECT AU.AUTHID,PT.LEV, PT.ODRID, AU.CMDCODE, RPT.MODCODE, max(nvl(sr.tltxcd,'')) tltxcd,TL.GRPID GRP, TL.GRPNAME TEN,
                         MAX(RPT.RPTID ||'-'|| CASE WHEN SR.TLTXCD IS NULL THEN 'VIEW' ELSE SR.TLTXCD END ||': '|| RPT.DESCRIPTION) TXNAME,
                           MAX(DECODE(SUBSTR(AU.STRAUTH,1,1),'Y','X','')) C9, MAX(DECODE(AU.CMDALLOW,'Y','X','')) C1
                        FROM RPTMASTER RPT ,CMDAUTH AU, search sr, TLGROUPS TL, VW_CMDMENU_ALL_RPT PT
                        WHERE RPT.RPTID = AU.CMDCODE AND SR.SEARCHCODE = RPT.RPTID
                            AND RPT.CMDTYPE in ('V','D','L') AND rpt.visible = 'Y'
                            AND au.cmdtype = 'G'
                            AND RPT.RPTID=PT.CMDID
                          AND AU.AUTHID LIKE V_STRAUTHID
                             AND TL.ACTIVE LIKE V_STATUS
                            AND AU.AUTHTYPE='G'
                            AND AU.AUTHID=TL.GRPID
                            AND INSTR(PT.en_cmdname,'General view')=0
                        GROUP BY AU.AUTHID,PT.LEV,PT.ODRID,AU.CMDCODE, RPT.MODCODE,TL.GRPID , TL.GRPNAME
                   ) A
                    LEFT JOIN
                    ( SELECT PT.LEV,AU.AUTHID,PT.ODRID,AU.CMDCODE/*,PT.ODRID*//*, fn_getparentgroupmenu(RPT.RPTID,'R',RPT.modcode, 'Y') groupname*/, TL.GRPID GRP,TL.GRPNAME TEN,
                    TO_CHAR(TL.TLTXCD)||'-'||TO_CHAR(TL.TXDESC) TXNAME,
                    MAX(case when substr(au.strauth,1,1) = 'Y' OR substr(au.strauth,3,1) = 'Y' OR substr(au.strauth,5,1) = 'Y' OR substr(au.strauth,7,1) = 'Y' THEN 'X' ELSE '' END) C1,
                    '' C2,
                    '' C3,
                    '' C4,
                    '' C5,
                    MAX(case when substr(au.strauth,2,1) = 'Y' OR substr(au.strauth,4,1) = 'Y' OR substr(au.strauth,6,1) = 'Y' OR substr(au.strauth,8,1) = 'Y' THEN 'X' ELSE '' END) C6, 'O' c7,'' C9
                FROM TLTX TL ,CMDAUTH AU, TLGROUPS TL,VW_CMDMENU_ALL_RPT PT
                WHERE TL.TLTXCD  = AU.CMDCODE
                    AND AU.AUTHID LIKE V_STRAUTHID
                    AND TL.ACTIVE LIKE V_STATUS
                    AND (AU.STRAUTH<>'NN' OR AU.CMDALLOW<>'N')
                    AND AU.AUTHTYPE='G'
                    AND PT.CMDID = TL.TLTXCD
                    --AND INSTR(PT.en_cmdname,'General view')=0
                    AND AU.AUTHID=TL.GRPID
                GROUP BY PT.LEV,TL.TLTXCD,TL.TXDESC,TL.GRPNAME,TL.GRPID,PT.ODRID,AU.AUTHID,AU.CMDCODE

                    ) B
                    ON A.TLTXCD = B.CMDCODE AND A.AUTHID=B.AUTHID
            ) DT, TLGROUPS TG, ALLCODE AL
            WHERE DT.GRP = TG.GRPID
            AND AL.CDNAME='YESNO' AND  AL.CDTYPE='SY' AND  AL.CDVAL =TG.ACTIVE
        order by DT.ODRID --,DT.GRP,DT.C7, DT.TXNAME
    ;

    EXCEPTION
    WHEN OTHERS THEN
        RETURN;
    END;                                                              -- PROCEDURE
/

DROP PROCEDURE sa0007
/

CREATE OR REPLACE 
PROCEDURE sa0007 (
                                   PV_REFCURSOR IN OUT PKG_REPORT.REF_CURSOR,
                                   PV_TLID      IN VARCHAR2,
                                   PV_BRID      IN VARCHAR2,
                                   PV_ROLECODE  IN VARCHAR2,
                                   PV_F_DATE    IN VARCHAR2,
                                   PV_T_DATE    IN VARCHAR2,
                                   PV_OBJTYPE   IN VARCHAR2,
                                   PV_OBJID            IN      VARCHAR2,
                                   PV_STATUS      IN       VARCHAR2
   )
IS
--
-- PURPOSE: BRIEFLY EXPLAIN THE FUNCTIONALITY OF THE PROCEDURE
-- BAO CAO THAY DOI QUYEN CUA CHI NHANH/ NHOM NSD/ NSD
-- MODIFICATION HISTORY
-- PERSON      DATE    COMMENTS
-- THENN   27-FEB-13  CREATED
-- ---------   ------  -------------------------------------------
   V_OBJTYPE            VARCHAR2(1);
   V_OBJID              VARCHAR2(50);
   V_STATUS                VARCHAR2 (10);

BEGIN
   -- GET REPORT'S PARAMETERS
    V_OBJTYPE := PV_OBJTYPE;
    IF (PV_OBJID <> 'ALL')
    THEN
        V_OBJID := substr(PV_OBJID,2);
    ELSE
        V_OBJID := '%%';
    END IF;

  IF(PV_STATUS <> 'ALL')
   THEN
        V_STATUS  := PV_STATUS;
   ELSE
        V_STATUS  := '%%';
   END IF;
   -- END OF GETTING REPORT'S PARAMETERS

  IF V_OBJTYPE = 'G' THEN
        OPEN PV_REFCURSOR
        FOR
            SELECT rl.OBJTYPE, rl.OBJID, rl.AUTHID, TLG.GRPNAME authname, rl.cmdcode, rl.cmdname, rl.cmdtype, rl.chgtype,
                       rl.oldvalue, rl.newvalue, rl.chgtlid, TL2.TLNAME CHGTLNAME, rl.chgtime,rl.odrnum, rl.busdate,RL.BACK
            FROM
                (
                    -- thay doi quyen cua nhom
                  SELECT TA.OBJTYPE, TA.OBJID, TA.AUTHID,TA.cmdcode, TA.cmdname,TA.cmdtype, TA.chgtype,
                  fn_get_changtype( TA.oldvalue,TA.cmdtype) oldvalue, fn_get_changtype( TA.newvalue,TA.cmdtype) newvalue,
                  TA.chgtlid,TA.chgtime,TA.odrnum,TA.busdate,'' AREA,A.BACK
                    FROM(SELECT V_OBJTYPE OBJTYPE, V_OBJID OBJID, rl.AUTHID, rl.cmdcode, aun.cmdname, decode(rl.logtable,'TLAUTH',rl.cmdtype||rl.tltype,rl.cmdtype) cmdtype,
                        CASE WHEN rl.newvalue = 'D' THEN 'D'
                            WHEN rl.oldvalue IS NULL AND rl.newvalue IS NOT NULL THEN 'A'
                            ELSE 'E' END chgtype,
                         rl.oldvalue oldvalue,
                         decode(rl.newvalue,'D','',rl.newvalue) newvalue,
                        rl.chgtlid, to_char(rl.chgtime,'dd/mm/yyyy hh:mi:ss') chgtime,
                        decode(rl.cmdtype,'M','1','T','2','G','3','R','4') odrnum, to_char(rl.busdate,'dd/mm/yyyy') busdate
                    FROM rightassign_log rl,
                        (SELECT cmd.cmdid, cmd.cmdid || ': ' || cmd.cmdname cmdname, 'M' cmdtype
                        FROM cmdmenu cmd
                        UNION ALL
                        SELECT tl.tltxcd cmdid, tl.tltxcd || ': ' || tl.txdesc cmdname, 'T' cmdtype
                        FROM tltx tl
                        UNION ALL
                        SELECT rpt.rptid cmdid, rpt.rptid || ': ' || rpt.description cmdname, decode(rpt.cmdtype,'R','R','V','G') cmdtype
                        FROM rptmaster rpt
                        ) aun, VW_CMDMENU_ALL_RPT PT
                    WHERE rl.authtype = 'G' AND rl.logtable in ('CMDAUTH', 'TLAUTH')
                        AND CASE WHEN rl.logtable = 'CMDAUTH' AND rl.cmdtype = 'T' THEN 0 ELSE 1 END = 1
                        AND (rl.oldvalue IS NOT NULL OR rl.newvalue IS NOT null)
                        AND rl.cmdcode = aun.cmdid AND rl.cmdtype = aun.cmdtype AND AUN.CMDID=PT.CMDID
                         AND (PT.LAST<>'N' OR PT.MENUTYPE NOT IN ('R','G','T'))
                     and NVL(rl.strauth,'YY') NOT IN ('NN','NNNNN','NNNN') AND NVL(RL.OLDVALUE,'YYYYY') NOT LIKE '%YNNNNNA'
                        AND to_date(PV_F_DATE,'dd/mm/yyyy') <= rl.busdate
                        AND to_date(PV_T_DATE,'dd/mm/yyyy') >= rl.busdate
                        AND rl.AUTHID LIKE V_OBJID) TA
                          LEFT JOIN ( SELECT CMDTYPE,AUTHID,CMDCODE,(CASE WHEN CMDTYPE='M' THEN '' WHEN CMDTYPE='R' THEN '' ELSE BACK END) BACK FROM
                          (SELECT  AU.CMDTYPE ,MAX(DECODE(SUBSTR(AU.STRAUTH,1,1),'Y','Co','Kh?ng')) BACK, AU.AUTHID,AU.CMDCODE
                             FROM CMDAUTH AU
                            WHERE AU.AUTHID LIKE V_OBJID
                                   GROUP BY  AU.AUTHID,AU.CMDCODE, AU.CMDTYPE)
                     ) A ON TA.AUTHID=A.AUTHID AND TA.CMDCODE=A.CMDCODE
                    UNION all
                    -- thay doi NSD cua nhom
                        SELECT OBJTYPE,OBJID, AUTHID ,CMDCODE, CMDNAME, CMDTYPE,
                        (CASE WHEN OLDVALUE IS NULL THEN 'EN' ELSE 'EO' END) CHGTYPE, OLDVALUE, NEWVALUE,chgtlid,chgtime,odrnum,busdate,AREA, BACK
                        FROM( SELECT OBJTYPE,OBJID,AUTHID ,CMDCODE, CMDNAME, CMDTYPE, CHGTYPE, OLDVALUE, NEWVALUE,chgtlid,chgtime,odrnum,busdate,NVL(AREA,'')AREA,NVL(BACK,'') BACK
                        FROM( SELECT  V_OBJTYPE OBJTYPE, V_OBJID OBJID,rl.grpid authid, rl.brid cmdcode, '' cmdname, 'U' cmdtype, 'E' chgtype,/* rl.oldvalue, rl.newvalue,*/
                    fn_get_username(rl.oldvalue) oldvalue, fn_get_username(rl.newvalue) newvalue,
                     rl.chgtlid, to_char(rl.chgtime,'dd/mm/yyyy hh:mi:ss') chgtime, '5' odrnum,
                      to_char(rl.busdate,'dd/mm/yyyy') busdate,'' AREA,''BACK
                    FROM rightassign_log rl
                    WHERE rl.authtype = 'G' AND rl.logtable in ('TLGRPUSERS')
                        AND (rl.oldvalue IS NOT NULL OR rl.newvalue IS NOT null)
                         AND to_date(PV_F_DATE,'dd/mm/yyyy') <= rl.busdate
                        AND to_date(PV_T_DATE,'dd/mm/yyyy') >= rl.busdate
                        AND rl.grpid LIKE V_OBJID) WHERE OLDVALUE IS NULL
                        UNION ALL
                        SELECT OBJTYPE,OBJID,AUTHID ,CMDCODE, CMDNAME, CMDTYPE, CHGTYPE, OLDVALUE, NEWVALUE,chgtlid,chgtime,odrnum,busdate,NVL(AREA,'')AREA,NVL(BACK,'') BACK
                        FROM( SELECT  V_OBJTYPE OBJTYPE, V_OBJID OBJID,rl.grpid authid, rl.brid cmdcode, '' cmdname, 'U' cmdtype, 'E' chgtype,/* rl.oldvalue, rl.newvalue,*/
                    fn_get_username(rl.oldvalue) oldvalue, fn_get_username(rl.newvalue) newvalue,
                     rl.chgtlid, to_char(rl.chgtime,'dd/mm/yyyy hh:mi:ss') chgtime, '5' odrnum,
                      to_char(rl.busdate,'dd/mm/yyyy') busdate,'' AREA,''BACK
                    FROM rightassign_log rl
                    WHERE rl.authtype = 'G' AND rl.logtable in ('TLGRPUSERS')
                        AND (rl.oldvalue IS NOT NULL OR rl.newvalue IS NOT null)
                         AND to_date(PV_F_DATE,'dd/mm/yyyy') <= rl.busdate
                        AND to_date(PV_T_DATE,'dd/mm/yyyy') >= rl.busdate
                        AND rl.grpid LIKE V_OBJID) WHERE OLDVALUE IS  NOT NULL  AND NEWVALUE IS NULL

                          UNION ALL
                          SELECT OBJTYPE,OBJID,AUTHID ,CMDCODE, CMDNAME, CMDTYPE, CHGTYPE, OLDVALUE, '' NEWVALUE,chgtlid,chgtime,odrnum,busdate,NVL(AREA,'')AREA,NVL(BACK,'') BACK
                          FROM( SELECT V_OBJTYPE OBJTYPE, V_OBJID OBJID, rl.grpid authid, rl.brid cmdcode, '' cmdname, 'U' cmdtype, 'E' chgtype,/* rl.oldvalue, rl.newvalue,*/
                    fn_get_username(rl.oldvalue) oldvalue, fn_get_username(rl.newvalue) newvalue,
                     rl.chgtlid, to_char(rl.chgtime,'dd/mm/yyyy hh:mi:ss') chgtime, '5' odrnum,
                      to_char(rl.busdate,'dd/mm/yyyy') busdate,'' AREA,''BACK
                    FROM rightassign_log rl
                    WHERE rl.authtype = 'G' AND rl.logtable in ('TLGRPUSERS')
                        AND (rl.oldvalue IS NOT NULL OR rl.newvalue IS NOT null)
                         AND to_date(PV_F_DATE,'dd/mm/yyyy') <= rl.busdate
                        AND to_date(PV_T_DATE,'dd/mm/yyyy') >= rl.busdate
                        AND rl.grpid LIKE V_OBJID) WHERE OLDVALUE IS  NOT NULL  AND NEWVALUE IS NOT NULL
                          UNION ALL
                          SELECT OBJTYPE,OBJID,AUTHID ,CMDCODE, CMDNAME, CMDTYPE, CHGTYPE, '' OLDVALUE, NEWVALUE ,chgtlid,chgtime,odrnum,busdate,NVL(AREA,'')AREA,NVL(BACK,'') BACK
                          FROM( SELECT V_OBJTYPE OBJTYPE, V_OBJID OBJID, rl.grpid authid, rl.brid cmdcode, '' cmdname, 'U' cmdtype, 'E' chgtype,/* rl.oldvalue, rl.newvalue,*/
                    fn_get_username(rl.oldvalue) oldvalue, fn_get_username(rl.newvalue) newvalue,
                     rl.chgtlid, to_char(rl.chgtime,'dd/mm/yyyy hh:mi:ss') chgtime, '5' odrnum,
                      to_char(rl.busdate,'dd/mm/yyyy') busdate,'' AREA,''BACK
                    FROM rightassign_log rl
                    WHERE rl.authtype = 'G' AND rl.logtable in ('TLGRPUSERS')
                        AND (rl.oldvalue IS NOT NULL OR rl.newvalue IS NOT null)
                        AND to_date(PV_F_DATE,'dd/mm/yyyy') <= rl.busdate
                        AND to_date(PV_T_DATE,'dd/mm/yyyy') >= rl.busdate
                        AND rl.grpid LIKE V_OBJID) WHERE OLDVALUE IS  NOT NULL  AND NEWVALUE IS NOT NULL )
                ) rl,
                (SELECT TLG.grpid, TLG.grpid || ': ' || TLG.grpname GRPNAME FROM TLGROUPS TLG WHERE /*TLG.GRPTYPE='1' and */tlg.active like v_status) TLG,
                (SELECT /*TL.Tlgroup,*/ TL.tlid, TL.tlid || ': ' || TL.tlname tlNAME FROM tlprofiles TL ) TL2
            WHERE RL.AUTHID = TLG.GRPID
                AND RL.chgtlid = TL2.TLID

            ORDER BY rl.authid, rl.chgtime, rl.odrnum, rl.cmdcode, rl.chgtype;
    ELSIF V_OBJTYPE = 'U' THEN
        OPEN PV_REFCURSOR
        FOR
            SELECT rl.OBJTYPE, rl.OBJID, rl.AUTHID, TL.TLNAME authname, rl.cmdcode, rl.cmdname, rl.cmdtype, rl.chgtype,
                   rl.oldvalue, rl.newvalue, rl.chgtlid, TL2.TLNAME CHGTLNAME, rl.chgtime,rl.odrnum, rl.busdate,'' AREA, RL.BACK
            FROM
                (
                    -- thay doi quyen cua NSD
                   SELECT TA.OBJTYPE, TA.OBJID, TA.AUTHID,TA.cmdcode, TA.cmdname,TA.cmdtype, TA.chgtype,
                   fn_get_changtype( TA.oldvalue,TA.cmdtype) oldvalue, fn_get_changtype( TA.newvalue,TA.cmdtype) newvalue,
                   TA.chgtlid,TA.chgtime,TA.odrnum,TA.busdate,'' AREA,A.BACK
                    FROM(SELECT V_OBJTYPE OBJTYPE, V_OBJID OBJID, rl.AUTHID, rl.cmdcode, aun.cmdname, decode(rl.logtable,'TLAUTH',rl.cmdtype||rl.tltype,rl.cmdtype) cmdtype,
                        CASE WHEN rl.newvalue = 'D' THEN 'D'
                            WHEN rl.oldvalue IS NULL AND rl.newvalue IS NOT NULL THEN 'A'
                            ELSE 'E' END chgtype,

                        rl.oldvalue oldvalue,
                        decode(rl.newvalue,'D','',rl.newvalue) newvalue,
                        rl.chgtlid, to_char(rl.chgtime,'dd/mm/yyyy hh:mi:ss') chgtime,
                        decode(rl.cmdtype,'M','1','T','2','G','3','R','4') odrnum, to_char(rl.busdate,'dd/mm/yyyy') busdate
                    FROM rightassign_log rl,
                        (SELECT cmd.cmdid, cmd.cmdid || ': ' || cmd.cmdname cmdname, 'M' cmdtype
                        FROM cmdmenu cmd
                        UNION ALL
                        SELECT tl.tltxcd cmdid, tl.tltxcd || ': ' || tl.txdesc cmdname, 'T' cmdtype
                        FROM tltx tl
                        UNION ALL
                        SELECT rpt.rptid cmdid, rpt.rptid || ': ' || rpt.description cmdname, decode(rpt.cmdtype,'R','R','V','G') cmdtype
                        FROM rptmaster rpt
                        ) aun, VW_CMDMENU_ALL_RPT PT
                    WHERE rl.authtype = 'U' AND rl.logtable in ('CMDAUTH', 'TLAUTH')
                        AND CASE WHEN rl.logtable = 'CMDAUTH' AND rl.cmdtype = 'T' THEN 0 ELSE 1 END = 1
                        AND (rl.oldvalue IS NOT NULL OR rl.newvalue IS NOT null)
                        AND rl.cmdcode = aun.cmdid AND rl.cmdtype = aun.cmdtype AND AUN.CMDID=PT.CMDID
                        and NVL(rl.strauth,'YY') NOT IN ('NN','NNNNN','NNNN') AND NVL(RL.OLDVALUE,'YYYYY') NOT LIKE '%YNNNNNA'
                        AND to_date(PV_F_DATE,'dd/mm/yyyy') <= rl.busdate
                        AND to_date(PV_T_DATE,'dd/mm/yyyy') >= rl.busdate
                        AND rl.AUTHID LIKE V_OBJID) TA
                          LEFT JOIN ( SELECT CMDTYPE,AUTHID,CMDCODE,(CASE WHEN CMDTYPE='M' THEN '' WHEN CMDTYPE='R' THEN '' ELSE BACK END) BACK FROM
                          (SELECT  AU.CMDTYPE ,MAX(DECODE(SUBSTR(AU.STRAUTH,1,1),'Y','Co','Kh?ng')) BACK, AU.AUTHID,AU.CMDCODE
                             FROM CMDAUTH AU
                            WHERE  AU.AUTHID LIKE V_OBJID
                                   GROUP BY  AU.AUTHID,AU.CMDCODE, AU.CMDTYPE)
                     ) A ON TA.AUTHID=A.AUTHID AND TA.CMDCODE=A.CMDCODE
                    UNION all
                    -- thay doi nhom cua NSD
                        SELECT OBJTYPE,OBJID, AUTHID ,CMDCODE, CMDNAME, CMDTYPE,
                        (CASE WHEN OLDVALUE IS NULL THEN 'EN' ELSE 'EO' END) CHGTYPE, OLDVALUE, NEWVALUE,chgtlid,chgtime,odrnum,busdate,AREA, BACK
                        FROM( SELECT OBJTYPE,OBJID, AUTHID ,CMDCODE, CMDNAME, CMDTYPE, CHGTYPE, OLDVALUE, NEWVALUE,chgtlid,chgtime,odrnum,busdate,NVL(AREA,'')AREA,NVL(BACK,'') BACK
                        FROM(   SELECT V_OBJTYPE OBJTYPE, V_OBJID OBJID, rl.grpid authid, rl.cmdtype cmdcode, '' cmdname, 'GU' cmdtype, 'E' chgtype,
                        FN_GET_GROUPNAME(rl.oldvalue) oldvalue, FN_GET_GROUPNAME(rl.newvalue) newvalue,
                        rl.chgtlid, to_char(rl.chgtime,'dd/mm/yyyy hh:mi:ss') chgtime, '5' odrnum,
                        to_char(rl.busdate,'dd/mm/yyyy') busdate,'' AREA,'' BACK
                    FROM rightassign_log rl
                    WHERE rl.authtype = 'U' AND rl.logtable in ('TLGRPUSERS')
                        AND (rl.oldvalue IS NOT NULL OR rl.newvalue IS NOT null)
                        AND to_date(PV_F_DATE,'dd/mm/yyyy') <= rl.busdate
                        AND to_date(PV_T_DATE,'dd/mm/yyyy') >= rl.busdate
                        AND rl.grpid LIKE V_OBJID) WHERE OLDVALUE IS NULL
                        UNION ALL
                        SELECT OBJTYPE,OBJID,AUTHID ,CMDCODE, CMDNAME, CMDTYPE, CHGTYPE, OLDVALUE, NEWVALUE,chgtlid,chgtime,odrnum,busdate,NVL(AREA,'')AREA,NVL(BACK,'') BACK
                        FROM(   SELECT V_OBJTYPE OBJTYPE, V_OBJID OBJID, rl.grpid authid, rl.cmdtype cmdcode, '' cmdname, 'GU' cmdtype, 'E' chgtype,
                        FN_GET_GROUPNAME(rl.oldvalue) oldvalue, FN_GET_GROUPNAME(rl.newvalue) newvalue,
                        rl.chgtlid, to_char(rl.chgtime,'dd/mm/yyyy hh:mi:ss') chgtime, '5' odrnum,
                        to_char(rl.busdate,'dd/mm/yyyy') busdate,'' AREA,'' BACK
                    FROM rightassign_log rl
                    WHERE rl.authtype = 'U' AND rl.logtable in ('TLGRPUSERS')
                        AND (rl.oldvalue IS NOT NULL OR rl.newvalue IS NOT null)
                        AND to_date(PV_F_DATE,'dd/mm/yyyy') <= rl.busdate
                        AND to_date(PV_T_DATE,'dd/mm/yyyy') >= rl.busdate
                        AND rl.grpid LIKE V_OBJID) WHERE OLDVALUE IS  NOT NULL  AND NEWVALUE IS NULL

                          UNION ALL
                          SELECT OBJTYPE,OBJID,AUTHID ,CMDCODE, CMDNAME, CMDTYPE, CHGTYPE, OLDVALUE, '' NEWVALUE,chgtlid,chgtime,odrnum,busdate,NVL(AREA,'')AREA,NVL(BACK,'') BACK
                          FROM(  SELECT V_OBJTYPE OBJTYPE, V_OBJID OBJID, rl.grpid authid, rl.cmdtype cmdcode, '' cmdname, 'GU' cmdtype, 'E' chgtype,
                     FN_GET_GROUPNAME(rl.oldvalue) oldvalue, FN_GET_GROUPNAME(rl.newvalue) newvalue,
                        rl.chgtlid, to_char(rl.chgtime,'dd/mm/yyyy hh:mi:ss') chgtime, '5' odrnum,
                        to_char(rl.busdate,'dd/mm/yyyy') busdate,'' AREA,'' BACK
                    FROM rightassign_log rl
                    WHERE rl.authtype = 'U' AND rl.logtable in ('TLGRPUSERS')
                        AND (rl.oldvalue IS NOT NULL OR rl.newvalue IS NOT null)
                        AND to_date(PV_F_DATE,'dd/mm/yyyy') <= rl.busdate
                        AND to_date(PV_T_DATE,'dd/mm/yyyy') >= rl.busdate
                        AND rl.grpid LIKE V_OBJID) WHERE OLDVALUE IS  NOT NULL  AND NEWVALUE IS NOT NULL
                          UNION ALL
                          SELECT OBJTYPE,OBJID,AUTHID ,CMDCODE, CMDNAME, CMDTYPE, CHGTYPE, '' OLDVALUE, NEWVALUE ,chgtlid,chgtime,odrnum,busdate,NVL(AREA,'')AREA,NVL(BACK,'') BACK
                          FROM(  SELECT V_OBJTYPE OBJTYPE, V_OBJID OBJID, rl.grpid authid, rl.cmdtype cmdcode, '' cmdname, 'GU' cmdtype, 'E' chgtype,
                     FN_GET_GROUPNAME(rl.oldvalue) oldvalue, FN_GET_GROUPNAME(rl.newvalue) newvalue,
                        rl.chgtlid, to_char(rl.chgtime,'dd/mm/yyyy hh:mi:ss') chgtime, '5' odrnum,
                        to_char(rl.busdate,'dd/mm/yyyy') busdate,'' AREA,'' BACK
                    FROM rightassign_log rl
                    WHERE rl.authtype = 'U' AND rl.logtable in ('TLGRPUSERS')
                        AND (rl.oldvalue IS NOT NULL OR rl.newvalue IS NOT null)
                        AND to_date(PV_F_DATE,'dd/mm/yyyy') <= rl.busdate
                        AND to_date(PV_T_DATE,'dd/mm/yyyy') >= rl.busdate
                        AND rl.grpid LIKE V_OBJID) WHERE OLDVALUE IS  NOT NULL  AND NEWVALUE IS NOT NULL )
                ) rl,
                (SELECT TL.tlid, TL.tlid || ': ' || TL.tlname tlNAME FROM tlprofiles TL where TL.active like v_status) TL,
                (SELECT /*tl.tlgroup,*/ TL.tlid, TL.tlid || ': ' || TL.tlname tlNAME FROM tlprofiles TL ) TL2
            WHERE rl.AUTHID = tl.tlid AND RL.CMDCODE<>'2'
                AND RL.chgtlid = TL2.TLID
            ORDER BY rl.authid, rl.chgtime, rl.odrnum, rl.cmdcode, rl.chgtype;
    END IF;

    EXCEPTION
    WHEN OTHERS THEN
        RETURN;
    END;                                                              -- PROCEDURE
/

DROP PROCEDURE se0035b
/

CREATE OR REPLACE 
PROCEDURE se0035b (PV_REFCURSOR IN OUT PKG_REPORT.REF_CURSOR,
                                   PV_TLID      IN VARCHAR2,
                                   PV_BRID      IN VARCHAR2,
                                   PV_ROLECODE  IN VARCHAR2,
                                   PV_SYMBOL    IN VARCHAR2) IS
  --
  -- PURPOSE: BRIEFLY EXPLAIN THE FUNCTIONALITY OF THE PROCEDURE
  -- BAO CAO TAI KHOAN TIEN TONG HOP CUA NGUOI DAU TU
  -- MODIFICATION HISTORY
  -- PERSON      DATE    COMMENTS
  -- NAMNT   20-DEC-06  CREATED
  -- ---------   ------  -------------------------------------------

  CUR            PKG_REPORT.REF_CURSOR;
  V_STROPTION    VARCHAR2(5); -- A: ALL; B: BRANCH; S: SUB-BRANCH
  V_STRBRID      VARCHAR2(4);
  V_STRACCTNO    VARCHAR2(20);
  V_STRCUSTODYCD VARCHAR2(20);
  V_STRISCOM     VARCHAR2(40);
  v_strTLID      varchar2(10);
  P_BRID         VARCHAR2(100);
  v_memberid     VARCHAR2(200);

BEGIN
  --TINH NGAY NHAN THANH TOAN BU TRU
  P_BRID    := PV_BRID;
  v_strTLID := PV_TLID;
  IF PV_TLID = '0000' then
    --user gen bao cao tu dong
    v_memberid := PV_BRID;
  ELSE
    select mbid into v_memberid from tlprofiles where tlid = v_strTLID;
  END IF;

  IF v_memberid = '000001' THEN
    OPEN PV_REFCURSOR FOR
    SELECT T.SYMBOL,CF.IDCODE,CF.CUSTODYCD,CF.FULLNAME,CF.DBCODE,
    TO_CHAR(CF.IDDATE,'dd/MM/rrrr') IDDATE,T.FEEID,T.TRADE,
    TO_CHAR(T.TXDATE,'dd/MM/rrrr') TXDATE
    from  SEDTL T,CFMAST CF WHERE T.CUSTODYCD = CF.CUSTODYCD 
    AND (T.SYMBOL = PV_SYMBOL OR PV_SYMBOL = 'ALL') order by T.SYMBOL,T.TXDATE ;
  END IF;
END; -- PROCEDURE
/

DROP PROCEDURE se0042
/

CREATE OR REPLACE 
PROCEDURE se0042 (PV_REFCURSOR IN OUT PKG_REPORT.REF_CURSOR,
                                   PV_TLID      IN VARCHAR2,
                                   PV_BRID      IN VARCHAR2,
                                   PV_ROLECODE  IN VARCHAR2,
                                   F_DATE       IN VARCHAR2,
                                   T_DATE       IN VARCHAR2) IS

  -- PURPOSE: BRIEFLY EXPLAIN THE FUNCTIONALITY OF THE PROCEDURE
  -- BAO CAO THONG TIN CHUNG CHI QUY MO DANG LUU HANH
  -- MODIFICATION HISTORY
  -- PERSON      DATE    COMMENTS
  -- BANHGAO   08-04-18  CREATED
  -- ---------   ------  -------------------------------------------

  CUR              PKG_REPORT.REF_CURSOR;
  V_STROPTION      VARCHAR2(5); -- A: ALL; B: BRANCH; S: SUB-BRANCH
  V_STRBRID        VARCHAR2(4);
  V_STRACCTNO      VARCHAR2(20);
  V_STRMBNAME      VARCHAR2(200);
  V_STRISCOM       VARCHAR2(40);
  v_strTLID        VARCHAR2(10);
  V_SYMBOL         VARCHAR2(100);
  l_codeid         varchar2(100);
  v_fdate          date;
  v_tdate          date;
  l_ps_next        number;
  l_ps_in          number;
  l_ps_next_nocurr number;
  L_EXECDATECCQ    date;

  SYMBOL     VARCHAR2(100); --Ma quy
  FIDCODE    VARCHAR2(100); --So giay chung nhan thanh lap quy
  FIDDATE    varchar2(100); --Ngay cap
  P_BRID     VARCHAR2(100);
  v_memberid VARCHAR2(200);
BEGIN
  v_strTLID := PV_TLID;
  P_BRID    := PV_BRID;
  v_fdate   := to_date(f_date, 'dd/MM/rrrr');
  v_tdate   := to_date(t_date, 'dd/MM/rrrr');
  IF PV_TLID = '0000' then
    --user gen bao cao tu dong
    v_memberid := PV_BRID;
  ELSE
    select mbid into v_memberid from tlprofiles where tlid = v_strTLID;
  END IF;

  --IF v_memberid = '000001' THEN
  -- begin iss: 1613
  OPEN PV_REFCURSOR FOR
    select F_DATE F_DATE, T_DATE T_DATE, dt.symbol, dt.ckqtty, dt.ck_number, dt.cqqtty, dt.cq_number
    from (
       select sum(decode(fld.CVALUE, 'TRFTYPEDTL', tl.msgamt, 0)) + sum(decode(fld.CVALUE, 'AUTHTYPETT', tl.msgamt, 0)) ckqtty,
              sum(decode(fld.CVALUE, 'AUTHTYPE',  tl.msgamt, 0)) cqqtty,
              sum(decode(fld.CVALUE, 'TRFTYPEDTL', 1, 0)) + sum(decode(fld.CVALUE, 'AUTHTYPETT', 1, 0)) ck_number,
              sum(decode(fld.CVALUE, 'AUTHTYPE', 1, 0)) cq_number,
              d.symbol
       from vw_tllog_all tl, vw_tllogfld_all fld, fund d
       where tl.TXNUM = fld.TXNUM
         and tl.TXDATE = fld.TXDATE
         and tl.TLTXCD in ('4002','4052')
         and tl.TXSTATUS = '1'
         and fld.FLDCD = '14'
         and fld.CVALUE in ('TRFTYPEDTL', 'AUTHTYPE','AUTHTYPETT')
         and d.codeid = tl.CCYUSAGE
         and fld.TXDATE >= v_fdate
         and fld.txdate <= v_tdate
       group by d.symbol
    ) dt;
  /*
  OPEN PV_REFCURSOR FOR
    select F_DATE F_DATE,
           T_DATE T_DATE,
           ck.symbol,
           ck.ckqtty,
           ck.ck_number,
           cq.cqqtty,
           cq.cq_number
      from (select d.symbol, sum(tl.msgamt) ckqtty, count(1) ck_number
              from vw_tllog_all tl, vw_tllogfld_all fld, fund d
             where tl.TXNUM = fld.TXNUM
               and tl.TXDATE = fld.TXDATE
               and tl.TLTXCD = '4002'
               and tl.TXSTATUS = '1'
               and fld.FLDCD = '14'
               and fld.CVALUE = 'TRFTYPEDTL'
               and d.codeid = tl.CCYUSAGE
               and fld.TXDATE >= v_fdate
               and fld.txdate <= v_tdate
             group by d.symbol) ck,
           (select d.symbol, sum(tl.msgamt) cqqtty, count(1) cq_number
              from vw_tllog_all tl, vw_tllogfld_all fld, fund d
             where tl.TXNUM = fld.TXNUM
               and tl.TXDATE = fld.TXDATE
               and tl.TLTXCD = '4002'
               and tl.TXSTATUS = '1'
               and fld.FLDCD = '14'
               and fld.CVALUE = 'AUTHTYPE'
               and d.codeid = tl.CCYUSAGE
               and fld.TXDATE >= v_fdate
               and fld.txdate <= v_tdate
             group by d.symbol) cq
     where ck.symbol = cq.symbol;
     */
     -- end iss: 1613
EXCEPTION
  WHEN OTHERS THEN
    RETURN;
END;
/

DROP PROCEDURE set_dom_holiday
/

CREATE OR REPLACE 
PROCEDURE set_dom_holiday 
   ( pv_strDay IN VARCHAR2,
     pv_strMonth IN VARCHAR2,
     pv_strYear IN VARCHAR2,
     pv_isHoliday IN VARCHAR2,
     pv_strCLDRTYPE IN VARCHAR2
   )
   IS
--
-- To modify this template, edit file PROC.TXT in TEMPLATE 
-- directory of SQL Navigator
--
-- Purpose: Briefly explain the functionality of the procedure
--
-- MODIFICATION HISTORY
-- Person      Date    Comments
-- ---------   ------  -------------------------------------------       
   pv_strSBBOW VARCHAR2(1);
   pv_strSBBOM VARCHAR2(1);
   pv_strSBBOQ VARCHAR2(1);
   pv_strSBBOY VARCHAR2(1);
   pv_strSBEOW VARCHAR2(1);
   pv_strSBEOM VARCHAR2(1);
   pv_strSBEOQ VARCHAR2(1);
   pv_strSBEOY VARCHAR2(1);
   
   pv_iTmp INT;
   
   CURSOR curDate IS
            SELECT TO_CHAR(SBDATE,'DD/MM/YYYY') FROM SBCLDR 
            WHERE TO_CHAR(SBDATE,'D') = pv_strDay AND 
            TO_CHAR(SBDATE,'MM') = LPAD(pv_strMonth,2,'0')                                       
            AND TO_CHAR(SBDATE,'YYYY') = pv_strYear
            AND CLDRTYPE = pv_strCLDRTYPE;       
   pv_strDate VARCHAR2(10);
BEGIN
    OPEN curDate;
    LOOP
        FETCH curDate INTO pv_strDate;
        EXIT WHEN curDate%NOTFOUND;
        
        pv_strSBBOW := 'N';
        pv_strSBBOM := 'N';
        pv_strSBBOQ := 'N';
        pv_strSBBOY := 'N';
        pv_strSBEOW := 'N';
        pv_strSBEOM := 'N';
        pv_strSBEOQ := 'N';
        pv_strSBEOY := 'N';
        select count(*) into pv_iTmp from SBCLDR where SBDATE = to_date(pv_strDate,'dd/mm/yyyy') and CLDRTYPE = pv_strCLDRTYPE;
    
        if pv_iTmp > 0 then
        
            select SBBOW , SBBOM , SBBOQ , SBBOY , SBEOW , SBEOM , SBEOQ , SBEOY
            into pv_strSBBOW, pv_strSBBOM, pv_strSBBOQ, pv_strSBBOY, pv_strSBEOW, pv_strSBEOM, pv_strSBEOQ, pv_strSBEOY
            from SBCLDR where SBDATE = to_date(pv_strDate,'dd/mm/yyyy') and CLDRTYPE = pv_strCLDRTYPE;
            
        end if;
        
        IF pv_isHoliday = 'Y' THEN
            UPDATE SBCLDR
            SET HOLIDAY = 'Y', SBBOW = 'N', SBBOM = 'N', SBBOQ = 'N', SBBOY = 'N',
                SBEOW = 'N', SBEOM = 'N', SBEOQ = 'N', SBEOY = 'N'
            WHERE SBDATE = to_date(pv_strDate, 'dd/mm/yyyy') AND CLDRTYPE = pv_strCLDRTYPE;
            
            UPDATE SBCLDR SET SBBOW = pv_strSBBOW
            WHERE SBDATE in (select min(SBDATE) from sbcldr
                            where sbdate > to_date(pv_strDate,'dd/mm/yyyy')
                            and to_number(to_char(SBDATE,'d')) > to_number(to_char(to_date(pv_strDate,'dd/mm/yyyy'),'d'))
                            and SBDATE - to_date(pv_strDate,'dd/mm/yyyy') < 7
                            AND CLDRTYPE = pv_strCLDRTYPE
                            and holiday = 'N')
            AND CLDRTYPE = pv_strCLDRTYPE;
            
                            
            UPDATE SBCLDR SET SBBOM = pv_strSBBOM, SBBOQ = pv_strSBBOQ
            WHERE SBDATE in (select min(SBDATE) from sbcldr
                            where sbdate > to_date(pv_strDate,'dd/mm/yyyy')
                            and to_char(sbdate,'mm') = to_char(to_date(pv_strDate,'dd/mm/yyyy'), 'mm')
                            AND CLDRTYPE = pv_strCLDRTYPE
                            and holiday = 'N')
            AND CLDRTYPE = pv_strCLDRTYPE;
            
            
            UPDATE SBCLDR SET SBBOY = pv_strSBBOY
            WHERE SBDATE in (select min(SBDATE) from sbcldr
                            where sbdate > to_date(pv_strDate,'dd/mm/yyyy')
                            and to_char(sbdate,'yyyy') = to_char(to_date(pv_strDate,'dd/mm/yyyy'), 'yyyy')
                            AND CLDRTYPE = pv_strCLDRTYPE
                            and holiday = 'N')
            AND CLDRTYPE = pv_strCLDRTYPE
            and holiday = 'N';
    
            
            UPDATE SBCLDR SET SBEOW = pv_strSBEOW
            WHERE SBDATE in (select max(SBDATE) from sbcldr
                            where sbdate < to_date(pv_strDate,'dd/mm/yyyy')
                            and holiday = 'N'
                            and to_number(to_char(SBDATE,'d')) < to_number(to_char(to_date(pv_strDate,'dd/mm/yyyy'),'d'))
                            and to_date(pv_strDate,'dd/mm/yyyy') - sbdate < 7
                            AND CLDRTYPE = pv_strCLDRTYPE)
            AND CLDRTYPE = pv_strCLDRTYPE;
    
            UPDATE SBCLDR SET SBEOM = pv_strSBEOM, SBEOQ = pv_strSBEOQ
            WHERE SBDATE in (select max(SBDATE) from sbcldr
                            where sbdate < to_date(pv_strDate,'dd/mm/yyyy')
                            and to_char(sbdate,'mm') = to_char(to_date(pv_strDate,'dd/mm/yyyy'), 'mm')
                            and holiday = 'N'
                            AND CLDRTYPE = pv_strCLDRTYPE)
            AND CLDRTYPE = pv_strCLDRTYPE;
                            
            UPDATE SBCLDR SET SBEOY = pv_strSBEOY
            WHERE SBDATE in (select max(SBDATE) from sbcldr
                            where sbdate < to_date(pv_strDate,'dd/mm/yyyy')
                            and holiday = 'N'
                            and to_char(sbdate,'yyyy') = to_char(to_date(pv_strDate,'dd/mm/yyyy'), 'yyyy')
                            AND CLDRTYPE = pv_strCLDRTYPE)
            AND CLDRTYPE = pv_strCLDRTYPE;
            
          
        ELSE
            select count(*) into pv_iTmp
            from sbcldr
            WHERE SBDATE in (SELECT min(SBDATE) FROM SBCLDR
                            WHERE SBDATE > to_date(pv_strDate,'dd/mm/yyyy')
                            and holiday = 'N'
                            and to_number(to_char(SBDATE,'d')) > to_number(to_char(to_date(pv_strDate,'dd/mm/yyyy'),'d'))
                            and SBDATE - to_date(pv_strDate,'dd/mm/yyyy') < 7
                            AND CLDRTYPE = pv_strCLDRTYPE)
            AND CLDRTYPE = pv_strCLDRTYPE;
            
            if pv_iTmp > 0 then
                SELECT SBBOW INTO pv_strSBBOW
                FROM SBCLDR
                WHERE SBDATE in (SELECT min(SBDATE) FROM SBCLDR
                                WHERE SBDATE > to_date(pv_strDate,'dd/mm/yyyy')
                                and holiday = 'N'
                                and to_number(to_char(SBDATE,'d')) > to_number(to_char(to_date(pv_strDate,'dd/mm/yyyy'),'d'))
                                and SBDATE - to_date(pv_strDate,'dd/mm/yyyy') < 7
                                AND CLDRTYPE = pv_strCLDRTYPE)
                AND CLDRTYPE = pv_strCLDRTYPE;
            else
                SELECT COUNT(*) INTO pv_iTmp
                FROM SBCLDR
                WHERE to_date(pv_strDate,'dd/mm/yyyy') - SBDATE < 7
                AND SBDATE < to_date(pv_strDate,'dd/mm/yyyy')
                AND holiday = 'N'
                AND to_number(to_char(SBDATE,'d')) < to_number(to_char(to_date(pv_strDate,'dd/mm/yyyy'),'d'))
                AND CLDRTYPE = pv_strCLDRTYPE;
                
                if pv_iTmp <= 0 then
                    pv_strSBBOW := 'Y';
                end if;
            end if;
            
            
            
            select count(*) into pv_iTmp
            from sbcldr
            WHERE SBDATE in (SELECT min(SBDATE) FROM SBCLDR
                            WHERE SBDATE > to_date(pv_strDate,'dd/mm/yyyy')
                            and holiday = 'N'
                            AND CLDRTYPE = pv_strCLDRTYPE
                            and to_char(SBDATE,'mm') = to_char(to_date(pv_strDate, 'dd/mm/yyyy'), 'mm'))
            AND CLDRTYPE = pv_strCLDRTYPE;
            
            if pv_iTmp > 0 then
    
                SELECT SBBOM, SBBOQ
                INTO pv_strSBBOM, pv_strSBBOQ
                FROM SBCLDR
                WHERE SBDATE in (SELECT min(SBDATE) FROM SBCLDR
                                WHERE SBDATE > to_date(pv_strDate,'dd/mm/yyyy')
                                and holiday = 'N'
                                AND CLDRTYPE = pv_strCLDRTYPE
                                and to_char(SBDATE,'mm') = to_char(to_date(pv_strDate, 'dd/mm/yyyy'), 'mm'))
                AND CLDRTYPE = pv_strCLDRTYPE;
            end if;
           
            
            select count(*) into pv_iTmp
            from sbcldr
            WHERE SBDATE in (SELECT min(SBDATE) FROM SBCLDR
                            WHERE SBDATE > to_date(pv_strDate,'dd/mm/yyyy')
                            and holiday = 'N'
                            AND CLDRTYPE = pv_strCLDRTYPE
                            and to_char(sbdate,'yyyy') = to_char(to_date(pv_strDate,'dd/mm/yyyy'), 'yyyy'))
            AND CLDRTYPE = pv_strCLDRTYPE;
            
            if pv_iTmp > 0 then
    
                SELECT SBBOY INTO pv_strSBBOY
                FROM SBCLDR
                WHERE SBDATE in (SELECT min(SBDATE) FROM SBCLDR
                                WHERE SBDATE > to_date(pv_strDate,'dd/mm/yyyy')
                                and holiday = 'N'
                                AND CLDRTYPE = pv_strCLDRTYPE
                                and to_char(sbdate,'yyyy') = to_char(to_date(pv_strDate,'dd/mm/yyyy'), 'yyyy'))
                AND CLDRTYPE = pv_strCLDRTYPE;
            end if;
            
            
            select count(*) into pv_iTmp
            from sbcldr
            WHERE SBDATE in (SELECT max(SBDATE) FROM SBCLDR
                            WHERE SBDATE < to_date(pv_strDate,'dd/mm/yyyy') and holiday = 'N' AND CLDRTYPE = pv_strCLDRTYPE
                            and to_date(pv_strDate,'dd/mm/yyyy') - sbdate < 7
                            and to_number(to_char(SBDATE,'d')) < to_number(to_char(to_date(pv_strDate,'dd/mm/yyyy'),'d')))
            AND CLDRTYPE = pv_strCLDRTYPE;
            
            if pv_iTmp > 0 then
    
                SELECT SBEOW INTO pv_strSBEOW
                FROM SBCLDR
                WHERE SBDATE in (SELECT max(SBDATE) FROM SBCLDR
                                WHERE SBDATE < to_date(pv_strDate,'dd/mm/yyyy') and holiday = 'N' AND CLDRTYPE = pv_strCLDRTYPE
                                and to_date(pv_strDate,'dd/mm/yyyy') - sbdate < 7
                                and to_number(to_char(SBDATE,'d')) < to_number(to_char(to_date(pv_strDate,'dd/mm/yyyy'),'d')))
                AND CLDRTYPE = pv_strCLDRTYPE;
            else
                SELECT COUNT(*) INTO pv_iTmp
                FROM SBCLDR
                WHERE SBDATE - to_date(pv_strDate,'dd/mm/yyyy') < 7
                AND SBDATE > to_date(pv_strDate,'dd/mm/yyyy')
                AND holiday = 'N'
                AND to_number(to_char(SBDATE,'d')) > to_number(to_char(to_date(pv_strDate,'dd/mm/yyyy'),'d'))
                AND CLDRTYPE = pv_strCLDRTYPE;
    
                if pv_iTmp <= 0 then
                    pv_strSBEOW := 'Y';
                end if;
    
            end if;
           
    
    
            select count(*) into pv_iTmp
            from sbcldr
            WHERE SBDATE in (SELECT max(SBDATE) FROM SBCLDR
                            WHERE SBDATE < to_date(pv_strDate,'dd/mm/yyyy')
                            and holiday = 'N'
                            AND CLDRTYPE = pv_strCLDRTYPE
                            and to_char(SBDATE,'mm') = to_char(to_date(pv_strDate, 'dd/mm/yyyy'), 'mm'))
            AND CLDRTYPE = pv_strCLDRTYPE;
            
            if pv_iTmp > 0 then
            
                SELECT SBEOM, SBEOQ
                INTO pv_strSBEOM, pv_strSBEOQ
                FROM SBCLDR
                WHERE SBDATE in (SELECT max(SBDATE) FROM SBCLDR
                                WHERE SBDATE < to_date(pv_strDate,'dd/mm/yyyy')
                                and holiday = 'N'
                                AND CLDRTYPE = pv_strCLDRTYPE
                                and to_char(SBDATE,'mm') = to_char(to_date(pv_strDate, 'dd/mm/yyyy'), 'mm'))
                AND CLDRTYPE = pv_strCLDRTYPE;
            end if;
            
            
            select count(*) into pv_iTmp
            from sbcldr
            WHERE SBDATE in (SELECT max(SBDATE) FROM SBCLDR
                            WHERE SBDATE < to_date(pv_strDate,'dd/mm/yyyy')
                            and holiday = 'N'
                            AND CLDRTYPE = pv_strCLDRTYPE
                            and to_char(sbdate,'yyyy') = to_char(to_date(pv_strDate,'dd/mm/yyyy'), 'yyyy'))
            AND CLDRTYPE = pv_strCLDRTYPE;
    
            if pv_iTmp > 0 then
    
                SELECT SBEOY INTO pv_strSBEOY
                FROM SBCLDR
                WHERE SBDATE in (SELECT max(SBDATE) FROM SBCLDR
                                WHERE SBDATE < to_date(pv_strDate,'dd/mm/yyyy')
                                and holiday = 'N'
                                AND CLDRTYPE = pv_strCLDRTYPE
                                and to_char(sbdate,'yyyy') = to_char(to_date(pv_strDate,'dd/mm/yyyy'), 'yyyy'))
                AND CLDRTYPE = pv_strCLDRTYPE;
            end if;
            
                                        
            UPDATE SBCLDR
            SET HOLIDAY = 'N', SBBOW = pv_strSBBOW, SBBOM = pv_strSBBOM, SBBOQ = pv_strSBBOQ, SBBOY = pv_strSBBOY,
                SBEOW = pv_strSBEOW, SBEOM = pv_strSBEOM, SBEOQ = pv_strSBEOQ, SBEOY = pv_strSBEOY
            WHERE SBDATE = to_date(pv_strDate, 'dd/mm/yyyy') AND CLDRTYPE = pv_strCLDRTYPE;
            
            UPDATE SBCLDR SET SBBOW = 'N'
            WHERE SBDATE in (select min(SBDATE) from sbcldr
                            where sbdate > to_date(pv_strDate,'dd/mm/yyyy')
                            and holiday = 'N'
                            AND CLDRTYPE = pv_strCLDRTYPE
                            and to_number(to_char(SBDATE,'d')) > to_number(to_char(to_date(pv_strDate,'dd/mm/yyyy'),'d')))
            AND CLDRTYPE = pv_strCLDRTYPE;
    
            UPDATE SBCLDR SET SBBOM = 'N', SBBOQ = 'N'
            WHERE SBDATE in (select min(SBDATE) from sbcldr
                            where sbdate > to_date(pv_strDate,'dd/mm/yyyy')
                            and to_char(sbdate,'mm') = to_char(to_date(pv_strDate,'dd/mm/yyyy'), 'mm')
                            and holiday = 'N'
                            AND CLDRTYPE = pv_strCLDRTYPE)
            AND CLDRTYPE = pv_strCLDRTYPE;
            
            UPDATE SBCLDR SET SBBOY = 'N'
            WHERE SBDATE in (select min(SBDATE) from sbcldr
                            where sbdate > to_date(pv_strDate,'dd/mm/yyyy')
                            and holiday = 'N'
                            AND CLDRTYPE = pv_strCLDRTYPE
                            and to_char(sbdate,'yyyy') = to_char(to_date(pv_strDate,'dd/mm/yyyy'), 'yyyy'))
            AND CLDRTYPE = pv_strCLDRTYPE;
    
            UPDATE SBCLDR SET SBEOW = 'N'
            WHERE SBDATE in (select max(SBDATE) from sbcldr
                            where sbdate < to_date(pv_strDate,'dd/mm/yyyy')
                            and holiday = 'N'
                            AND CLDRTYPE = pv_strCLDRTYPE
                            and to_number(to_char(SBDATE,'d')) < to_number(to_char(to_date(pv_strDate,'dd/mm/yyyy'),'d')))
            AND CLDRTYPE = pv_strCLDRTYPE;
    
            UPDATE SBCLDR SET SBEOM = 'N', SBEOQ = 'N'
            WHERE SBDATE in (select max(SBDATE) from sbcldr
                            where sbdate < to_date(pv_strDate,'dd/mm/yyyy')
                            and to_char(sbdate,'mm') = to_char(to_date(pv_strDate,'dd/mm/yyyy'), 'mm')
                            and holiday = 'N'
                            AND CLDRTYPE = pv_strCLDRTYPE)
            AND CLDRTYPE = pv_strCLDRTYPE;
            
            UPDATE SBCLDR SET SBEOY = 'N'
            WHERE SBDATE in (select max(SBDATE) from sbcldr
                            where sbdate < to_date(pv_strDate,'dd/mm/yyyy')
                            and holiday = 'N'
                            AND CLDRTYPE = pv_strCLDRTYPE
                            and to_char(sbdate,'yyyy') = to_char(to_date(pv_strDate,'dd/mm/yyyy'), 'yyyy'))
            AND CLDRTYPE = pv_strCLDRTYPE;
            
               
            
        END IF;    
    END LOOP;
    CLOSE curDate;
    --commit;
EXCEPTION
    WHEN OTHERS THEN
        BEGIN
            dbms_output.put_line('Error... ');
            rollback;
            raise;
            return;
        END;
END; -- Procedure
/

DROP PROCEDURE set_doy_holiday
/

CREATE OR REPLACE 
PROCEDURE set_doy_holiday 
   ( pv_strDay IN VARCHAR2,     
     pv_strYear IN VARCHAR2,
     pv_isHoliday IN VARCHAR2,
     pv_strCLDRTYPE IN VARCHAR2
   )
   IS
--
-- To modify this template, edit file PROC.TXT in TEMPLATE 
-- directory of SQL Navigator
--
-- Purpose: Briefly explain the functionality of the procedure
--
-- MODIFICATION HISTORY
-- Person      Date    Comments
-- ---------   ------  -------------------------------------------       
   pv_strSBBOW VARCHAR2(1);
   pv_strSBBOM VARCHAR2(1);
   pv_strSBBOQ VARCHAR2(1);
   pv_strSBBOY VARCHAR2(1);
   pv_strSBEOW VARCHAR2(1);
   pv_strSBEOM VARCHAR2(1);
   pv_strSBEOQ VARCHAR2(1);
   pv_strSBEOY VARCHAR2(1);
   
   pv_iTmp INT;
   
   CURSOR curDate IS
            SELECT TO_CHAR(SBDATE,'DD/MM/YYYY') FROM SBCLDR 
            WHERE TO_CHAR(SBDATE,'D') = pv_strDay                                                   
            AND TO_CHAR(SBDATE,'YYYY') = pv_strYear
            AND CLDRTYPE = pv_strCLDRTYPE;       
   pv_strDate VARCHAR2(10);
BEGIN
    OPEN curDate;
    LOOP
        FETCH curDate INTO pv_strDate;
        EXIT WHEN curDate%NOTFOUND;
        
        pv_strSBBOW := 'N';
        pv_strSBBOM := 'N';
        pv_strSBBOQ := 'N';
        pv_strSBBOY := 'N';
        pv_strSBEOW := 'N';
        pv_strSBEOM := 'N';
        pv_strSBEOQ := 'N';
        pv_strSBEOY := 'N';
        select count(*) into pv_iTmp from SBCLDR where SBDATE = to_date(pv_strDate,'dd/mm/yyyy') and CLDRTYPE = pv_strCLDRTYPE;
    
        if pv_iTmp > 0 then
        
            select SBBOW , SBBOM , SBBOQ , SBBOY , SBEOW , SBEOM , SBEOQ , SBEOY
            into pv_strSBBOW, pv_strSBBOM, pv_strSBBOQ, pv_strSBBOY, pv_strSBEOW, pv_strSBEOM, pv_strSBEOQ, pv_strSBEOY
            from SBCLDR where SBDATE = to_date(pv_strDate,'dd/mm/yyyy') and CLDRTYPE = pv_strCLDRTYPE;
            
        end if;
        
        IF pv_isHoliday = 'Y' THEN
            UPDATE SBCLDR
            SET HOLIDAY = 'Y', SBBOW = 'N', SBBOM = 'N', SBBOQ = 'N', SBBOY = 'N',
                SBEOW = 'N', SBEOM = 'N', SBEOQ = 'N', SBEOY = 'N'
            WHERE SBDATE = to_date(pv_strDate, 'dd/mm/yyyy') AND CLDRTYPE = pv_strCLDRTYPE;
            
            UPDATE SBCLDR SET SBBOW = pv_strSBBOW
            WHERE SBDATE in (select min(SBDATE) from sbcldr
                            where sbdate > to_date(pv_strDate,'dd/mm/yyyy')
                            and to_number(to_char(SBDATE,'d')) > to_number(to_char(to_date(pv_strDate,'dd/mm/yyyy'),'d'))
                            and SBDATE - to_date(pv_strDate,'dd/mm/yyyy') < 7
                            AND CLDRTYPE = pv_strCLDRTYPE
                            and holiday = 'N')
            AND CLDRTYPE = pv_strCLDRTYPE;
            
                            
            UPDATE SBCLDR SET SBBOM = pv_strSBBOM, SBBOQ = pv_strSBBOQ
            WHERE SBDATE in (select min(SBDATE) from sbcldr
                            where sbdate > to_date(pv_strDate,'dd/mm/yyyy')
                            and to_char(sbdate,'mm') = to_char(to_date(pv_strDate,'dd/mm/yyyy'), 'mm')
                            AND CLDRTYPE = pv_strCLDRTYPE
                            and holiday = 'N')
            AND CLDRTYPE = pv_strCLDRTYPE;
            
            
            UPDATE SBCLDR SET SBBOY = pv_strSBBOY
            WHERE SBDATE in (select min(SBDATE) from sbcldr
                            where sbdate > to_date(pv_strDate,'dd/mm/yyyy')
                            and to_char(sbdate,'yyyy') = to_char(to_date(pv_strDate,'dd/mm/yyyy'), 'yyyy')
                            AND CLDRTYPE = pv_strCLDRTYPE
                            and holiday = 'N')
            AND CLDRTYPE = pv_strCLDRTYPE
            and holiday = 'N';
    
            
            UPDATE SBCLDR SET SBEOW = pv_strSBEOW
            WHERE SBDATE in (select max(SBDATE) from sbcldr
                            where sbdate < to_date(pv_strDate,'dd/mm/yyyy')
                            and holiday = 'N'
                            and to_number(to_char(SBDATE,'d')) < to_number(to_char(to_date(pv_strDate,'dd/mm/yyyy'),'d'))
                            and to_date(pv_strDate,'dd/mm/yyyy') - sbdate < 7
                            AND CLDRTYPE = pv_strCLDRTYPE)
            AND CLDRTYPE = pv_strCLDRTYPE;
    
            UPDATE SBCLDR SET SBEOM = pv_strSBEOM, SBEOQ = pv_strSBEOQ
            WHERE SBDATE in (select max(SBDATE) from sbcldr
                            where sbdate < to_date(pv_strDate,'dd/mm/yyyy')
                            and to_char(sbdate,'mm') = to_char(to_date(pv_strDate,'dd/mm/yyyy'), 'mm')
                            and holiday = 'N'
                            AND CLDRTYPE = pv_strCLDRTYPE)
            AND CLDRTYPE = pv_strCLDRTYPE;
                            
            UPDATE SBCLDR SET SBEOY = pv_strSBEOY
            WHERE SBDATE in (select max(SBDATE) from sbcldr
                            where sbdate < to_date(pv_strDate,'dd/mm/yyyy')
                            and holiday = 'N'
                            and to_char(sbdate,'yyyy') = to_char(to_date(pv_strDate,'dd/mm/yyyy'), 'yyyy')
                            AND CLDRTYPE = pv_strCLDRTYPE)
            AND CLDRTYPE = pv_strCLDRTYPE;
            
           
        ELSE
            select count(*) into pv_iTmp
            from sbcldr
            WHERE SBDATE in (SELECT min(SBDATE) FROM SBCLDR
                            WHERE SBDATE > to_date(pv_strDate,'dd/mm/yyyy')
                            and holiday = 'N'
                            and to_number(to_char(SBDATE,'d')) > to_number(to_char(to_date(pv_strDate,'dd/mm/yyyy'),'d'))
                            and SBDATE - to_date(pv_strDate,'dd/mm/yyyy') < 7
                            AND CLDRTYPE = pv_strCLDRTYPE)
            AND CLDRTYPE = pv_strCLDRTYPE;
            
            if pv_iTmp > 0 then
                SELECT SBBOW INTO pv_strSBBOW
                FROM SBCLDR
                WHERE SBDATE in (SELECT min(SBDATE) FROM SBCLDR
                                WHERE SBDATE > to_date(pv_strDate,'dd/mm/yyyy')
                                and holiday = 'N'
                                and to_number(to_char(SBDATE,'d')) > to_number(to_char(to_date(pv_strDate,'dd/mm/yyyy'),'d'))
                                and SBDATE - to_date(pv_strDate,'dd/mm/yyyy') < 7
                                AND CLDRTYPE = pv_strCLDRTYPE)
                AND CLDRTYPE = pv_strCLDRTYPE;
            else
                SELECT COUNT(*) INTO pv_iTmp
                FROM SBCLDR
                WHERE to_date(pv_strDate,'dd/mm/yyyy') - SBDATE < 7
                AND SBDATE < to_date(pv_strDate,'dd/mm/yyyy')
                AND holiday = 'N'
                AND to_number(to_char(SBDATE,'d')) < to_number(to_char(to_date(pv_strDate,'dd/mm/yyyy'),'d'))
                AND CLDRTYPE = pv_strCLDRTYPE;
                
                if pv_iTmp <= 0 then
                    pv_strSBBOW := 'Y';
                end if;
            end if;
            
            
            
            select count(*) into pv_iTmp
            from sbcldr
            WHERE SBDATE in (SELECT min(SBDATE) FROM SBCLDR
                            WHERE SBDATE > to_date(pv_strDate,'dd/mm/yyyy')
                            and holiday = 'N'
                            AND CLDRTYPE = pv_strCLDRTYPE
                            and to_char(SBDATE,'mm') = to_char(to_date(pv_strDate, 'dd/mm/yyyy'), 'mm'))
            AND CLDRTYPE = pv_strCLDRTYPE;
            
            if pv_iTmp > 0 then
    
                SELECT SBBOM, SBBOQ
                INTO pv_strSBBOM, pv_strSBBOQ
                FROM SBCLDR
                WHERE SBDATE in (SELECT min(SBDATE) FROM SBCLDR
                                WHERE SBDATE > to_date(pv_strDate,'dd/mm/yyyy')
                                and holiday = 'N'
                                AND CLDRTYPE = pv_strCLDRTYPE
                                and to_char(SBDATE,'mm') = to_char(to_date(pv_strDate, 'dd/mm/yyyy'), 'mm'))
                AND CLDRTYPE = pv_strCLDRTYPE;
            end if;
           
            
            select count(*) into pv_iTmp
            from sbcldr
            WHERE SBDATE in (SELECT min(SBDATE) FROM SBCLDR
                            WHERE SBDATE > to_date(pv_strDate,'dd/mm/yyyy')
                            and holiday = 'N'
                            AND CLDRTYPE = pv_strCLDRTYPE
                            and to_char(sbdate,'yyyy') = to_char(to_date(pv_strDate,'dd/mm/yyyy'), 'yyyy'))
            AND CLDRTYPE = pv_strCLDRTYPE;
            
            if pv_iTmp > 0 then
    
                SELECT SBBOY INTO pv_strSBBOY
                FROM SBCLDR
                WHERE SBDATE in (SELECT min(SBDATE) FROM SBCLDR
                                WHERE SBDATE > to_date(pv_strDate,'dd/mm/yyyy')
                                and holiday = 'N'
                                AND CLDRTYPE = pv_strCLDRTYPE
                                and to_char(sbdate,'yyyy') = to_char(to_date(pv_strDate,'dd/mm/yyyy'), 'yyyy'))
                AND CLDRTYPE = pv_strCLDRTYPE;
            end if;
            
            
            select count(*) into pv_iTmp
            from sbcldr
            WHERE SBDATE in (SELECT max(SBDATE) FROM SBCLDR
                            WHERE SBDATE < to_date(pv_strDate,'dd/mm/yyyy') and holiday = 'N' AND CLDRTYPE = pv_strCLDRTYPE
                            and to_date(pv_strDate,'dd/mm/yyyy') - sbdate < 7
                            and to_number(to_char(SBDATE,'d')) < to_number(to_char(to_date(pv_strDate,'dd/mm/yyyy'),'d')))
            AND CLDRTYPE = pv_strCLDRTYPE;
            
            if pv_iTmp > 0 then
    
                SELECT SBEOW INTO pv_strSBEOW
                FROM SBCLDR
                WHERE SBDATE in (SELECT max(SBDATE) FROM SBCLDR
                                WHERE SBDATE < to_date(pv_strDate,'dd/mm/yyyy') and holiday = 'N' AND CLDRTYPE = pv_strCLDRTYPE
                                and to_date(pv_strDate,'dd/mm/yyyy') - sbdate < 7
                                and to_number(to_char(SBDATE,'d')) < to_number(to_char(to_date(pv_strDate,'dd/mm/yyyy'),'d')))
                AND CLDRTYPE = pv_strCLDRTYPE;
            else
                SELECT COUNT(*) INTO pv_iTmp
                FROM SBCLDR
                WHERE SBDATE - to_date(pv_strDate,'dd/mm/yyyy') < 7
                AND SBDATE > to_date(pv_strDate,'dd/mm/yyyy')
                AND holiday = 'N'
                AND to_number(to_char(SBDATE,'d')) > to_number(to_char(to_date(pv_strDate,'dd/mm/yyyy'),'d'))
                AND CLDRTYPE = pv_strCLDRTYPE;
    
                if pv_iTmp <= 0 then
                    pv_strSBEOW := 'Y';
                end if;
    
            end if;
           
    
    
            select count(*) into pv_iTmp
            from sbcldr
            WHERE SBDATE in (SELECT max(SBDATE) FROM SBCLDR
                            WHERE SBDATE < to_date(pv_strDate,'dd/mm/yyyy')
                            and holiday = 'N'
                            AND CLDRTYPE = pv_strCLDRTYPE
                            and to_char(SBDATE,'mm') = to_char(to_date(pv_strDate, 'dd/mm/yyyy'), 'mm'))
            AND CLDRTYPE = pv_strCLDRTYPE;
            
            if pv_iTmp > 0 then
            
                SELECT SBEOM, SBEOQ
                INTO pv_strSBEOM, pv_strSBEOQ
                FROM SBCLDR
                WHERE SBDATE in (SELECT max(SBDATE) FROM SBCLDR
                                WHERE SBDATE < to_date(pv_strDate,'dd/mm/yyyy')
                                and holiday = 'N'
                                AND CLDRTYPE = pv_strCLDRTYPE
                                and to_char(SBDATE,'mm') = to_char(to_date(pv_strDate, 'dd/mm/yyyy'), 'mm'))
                AND CLDRTYPE = pv_strCLDRTYPE;
            end if;
            
            
            select count(*) into pv_iTmp
            from sbcldr
            WHERE SBDATE in (SELECT max(SBDATE) FROM SBCLDR
                            WHERE SBDATE < to_date(pv_strDate,'dd/mm/yyyy')
                            and holiday = 'N'
                            AND CLDRTYPE = pv_strCLDRTYPE
                            and to_char(sbdate,'yyyy') = to_char(to_date(pv_strDate,'dd/mm/yyyy'), 'yyyy'))
            AND CLDRTYPE = pv_strCLDRTYPE;
    
            if pv_iTmp > 0 then
    
                SELECT SBEOY INTO pv_strSBEOY
                FROM SBCLDR
                WHERE SBDATE in (SELECT max(SBDATE) FROM SBCLDR
                                WHERE SBDATE < to_date(pv_strDate,'dd/mm/yyyy')
                                and holiday = 'N'
                                AND CLDRTYPE = pv_strCLDRTYPE
                                and to_char(sbdate,'yyyy') = to_char(to_date(pv_strDate,'dd/mm/yyyy'), 'yyyy'))
                AND CLDRTYPE = pv_strCLDRTYPE;
            end if;
            
                                        
            UPDATE SBCLDR
            SET HOLIDAY = 'N', SBBOW = pv_strSBBOW, SBBOM = pv_strSBBOM, SBBOQ = pv_strSBBOQ, SBBOY = pv_strSBBOY,
                SBEOW = pv_strSBEOW, SBEOM = pv_strSBEOM, SBEOQ = pv_strSBEOQ, SBEOY = pv_strSBEOY
            WHERE SBDATE = to_date(pv_strDate, 'dd/mm/yyyy') AND CLDRTYPE = pv_strCLDRTYPE;
            
            UPDATE SBCLDR SET SBBOW = 'N'
            WHERE SBDATE in (select min(SBDATE) from sbcldr
                            where sbdate > to_date(pv_strDate,'dd/mm/yyyy')
                            and holiday = 'N'
                            AND CLDRTYPE = pv_strCLDRTYPE
                            and to_number(to_char(SBDATE,'d')) > to_number(to_char(to_date(pv_strDate,'dd/mm/yyyy'),'d')))
            AND CLDRTYPE = pv_strCLDRTYPE;
    
            UPDATE SBCLDR SET SBBOM = 'N', SBBOQ = 'N'
            WHERE SBDATE in (select min(SBDATE) from sbcldr
                            where sbdate > to_date(pv_strDate,'dd/mm/yyyy')
                            and to_char(sbdate,'mm') = to_char(to_date(pv_strDate,'dd/mm/yyyy'), 'mm')
                            and holiday = 'N'
                            AND CLDRTYPE = pv_strCLDRTYPE)
            AND CLDRTYPE = pv_strCLDRTYPE;
            
            UPDATE SBCLDR SET SBBOY = 'N'
            WHERE SBDATE in (select min(SBDATE) from sbcldr
                            where sbdate > to_date(pv_strDate,'dd/mm/yyyy')
                            and holiday = 'N'
                            AND CLDRTYPE = pv_strCLDRTYPE
                            and to_char(sbdate,'yyyy') = to_char(to_date(pv_strDate,'dd/mm/yyyy'), 'yyyy'))
            AND CLDRTYPE = pv_strCLDRTYPE;
    
            UPDATE SBCLDR SET SBEOW = 'N'
            WHERE SBDATE in (select max(SBDATE) from sbcldr
                            where sbdate < to_date(pv_strDate,'dd/mm/yyyy')
                            and holiday = 'N'
                            AND CLDRTYPE = pv_strCLDRTYPE
                            and to_number(to_char(SBDATE,'d')) < to_number(to_char(to_date(pv_strDate,'dd/mm/yyyy'),'d')))
            AND CLDRTYPE = pv_strCLDRTYPE;
    
            UPDATE SBCLDR SET SBEOM = 'N', SBEOQ = 'N'
            WHERE SBDATE in (select max(SBDATE) from sbcldr
                            where sbdate < to_date(pv_strDate,'dd/mm/yyyy')
                            and to_char(sbdate,'mm') = to_char(to_date(pv_strDate,'dd/mm/yyyy'), 'mm')
                            and holiday = 'N'
                            AND CLDRTYPE = pv_strCLDRTYPE)
            AND CLDRTYPE = pv_strCLDRTYPE;
            
            UPDATE SBCLDR SET SBEOY = 'N'
            WHERE SBDATE in (select max(SBDATE) from sbcldr
                            where sbdate < to_date(pv_strDate,'dd/mm/yyyy')
                            and holiday = 'N'
                            AND CLDRTYPE = pv_strCLDRTYPE
                            and to_char(sbdate,'yyyy') = to_char(to_date(pv_strDate,'dd/mm/yyyy'), 'yyyy'))
            AND CLDRTYPE = pv_strCLDRTYPE;
            
                
            
        END IF;    
    END LOOP;
    CLOSE curDate;
   -- commit;
EXCEPTION
    WHEN OTHERS THEN
        BEGIN
            dbms_output.put_line('Error... ');
            rollback;
            raise;
            return;
        END;
END; -- Procedure
/

DROP PROCEDURE sp_getinventory
/

CREATE OR REPLACE 
PROCEDURE sp_getinventory (
          PV_REFCURSOR  IN OUT PKG_REPORT.REF_CURSOR,
          CLAUSE        IN VARCHAR2,
          BRID          IN VARCHAR2,
          SSYSVAR       IN VARCHAR2,
          RefLength     IN NUMBER,
          REFERENCE     IN VARCHAR2

       )
IS
          V_CLAUSE          VARCHAR2(100);
          V_BRID            VARCHAR2(100);
          V_SSYSVAR         VARCHAR2(100);
          V_iRefLength      NUMBER(20);
          V_REFERENCE       VARCHAR2(100);
          v_startnumtemp  number;
          v_endnumtemp    number;

          v_prefix          varchar2(4);
          v_AUTOINV         varchar2(6);
          v_AUTOINVTEMP     varchar2(6);
          v_startnum    number;
          v_endnum      number;
          pkgctx   plog.log_ctx;
          logrow   tlogdebug%ROWTYPE;
BEGIN
          V_CLAUSE          := UPPER(CLAUSE);
          V_BRID            := UPPER(BRID);
          V_SSYSVAR         := SSYSVAR;
          V_iRefLength      := RefLength;
          V_REFERENCE       := REFERENCE;



          IF (V_CLAUSE = 'CUSTID') THEN
             OPEN PV_REFCURSOR
             FOR
                  SELECT SUBSTR(INVACCT,1,4), MAX(ODR)+1 AUTOINV FROM
                  (SELECT ROWNUM ODR, INVACCT
                  FROM (SELECT CUSTID INVACCT FROM CFMAST WHERE SUBSTR(CUSTID,1,4)= V_BRID ORDER BY CUSTID) DAT
                  WHERE TO_NUMBER(SUBSTR(INVACCT,5,6))=ROWNUM) INVTAB
                  GROUP BY SUBSTR(INVACCT,1,4);
         /* ELSIF (V_CLAUSE IN ('RETAX','RERFEEID','REACTYPE','CITYPE', 'ODTYPE', 'SETYPE', 'AFTYPE', 'RPTYPE', 'FOTYPE', 'CLTYPE', 'LNTYPE', 'DDTYPE', 'MRTYPE', 'MTTYPE','PRTYPE')) THEN
             OPEN PV_REFCURSOR
             FOR
                  SELECT NVL(MAX(ODR)+1,1) AUTOINV FROM
                  (SELECT ROWNUM ODR, INVACCT
                  FROM (SELECT * FROM (SELECT actype INVACCT FROM CITYPE WHERE V_CLAUSE = 'CITYPE'
                        UNION ALL
                        SELECT actype INVACCT FROM ODTYPE WHERE V_CLAUSE = 'ODTYPE'
                        UNION ALL
                        SELECT actype INVACCT FROM SETYPE WHERE V_CLAUSE = 'SETYPE'
                        UNION ALL
                        SELECT TO_CHAR(actype) INVACCT FROM AFTYPE WHERE V_CLAUSE = 'AFTYPE'
                        UNION ALL
                        SELECT actype INVACCT FROM FOTYPE WHERE V_CLAUSE = 'FOTYPE'
                        UNION ALL
                        SELECT actype INVACCT FROM CLTYPE WHERE V_CLAUSE = 'CLTYPE'
                        UNION ALL
                        SELECT actype INVACCT FROM LNTYPE WHERE V_CLAUSE = 'LNTYPE'
                        UNION ALL
                        SELECT actype INVACCT FROM MRTYPE WHERE V_CLAUSE = 'MRTYPE'
                        UNION ALL
                        SELECT actype INVACCT FROM PRTYPE WHERE V_CLAUSE = 'PRTYPE'
                        UNION ALL
                        SELECT actype INVACCT FROM RETYPE WHERE V_CLAUSE = 'REACTYPE'
                        Union all
                        SELECT RERFID INVACCT FROM RERFEE WHERE V_CLAUSE = 'RERFEEID'
                         Union all
                        SELECT ACTYPE INVACCT FROM RETAX WHERE V_CLAUSE = 'RETAX'
                        ) ORDER BY INVACCT) DAT
                  WHERE TO_NUMBER(INVACCT)=ROWNUM) INVTAB;*/
          ELSIF (V_CLAUSE = 'CUSTODYCD') THEN
             /*OPEN PV_REFCURSOR
             FOR
                  SELECT SUBSTR(INVACCT,1,4), MAX(ODR)+1 AUTOINV FROM
                  (SELECT ROWNUM ODR, INVACCT
                  FROM (SELECT CUSTODYCD INVACCT FROM CFMAST
                  WHERE SUBSTR(CUSTODYCD,1,4)= V_SSYSVAR || 'C' AND TRIM(TO_CHAR(TRANSLATE(SUBSTR(CUSTODYCD,5,6),'0123456789',' '))) IS NULL
                  ORDER BY CUSTODYCD) DAT
                  WHERE TO_NUMBER(SUBSTR(INVACCT,5,6))=ROWNUM) INVTAB
                  GROUP BY SUBSTR(INVACCT,1,4);*/
            /*begin
                SELECT CUSTODYCDFROM,CUSTODYCDTO
                       INTO v_startnumtemp,v_endnumtemp
                      FROM BRGRP WHERE BRID = V_BRID;
            exception when others then*/
                v_startnum:= 0;
                v_endnum:= 999999;
            /*end;*/
            v_startnum:= v_startnumtemp;
            v_endnum:= v_endnumtemp;
            begin
                SELECT SUBSTR(INVACCT,1,4), to_number(v_startnum) + MAX(ODR)+1 AUTOINV
                into v_prefix, v_AUTOINV
                FROM
                (SELECT ROWNUM ODR, INVACCT
                    FROM (SELECT CUSTODYCD INVACCT
                                  FROM ( select custodycd FROM CFMAST
                                        WHERE SUBSTR(CUSTODYCD,1,4)= V_SSYSVAR || 'C' AND TRIM(TO_CHAR(TRANSLATE(SUBSTR(CUSTODYCD,5,6),'0123456789',' '))) IS NULL
                                        )CFMAST
                            WHERE TO_NUMBER(SUBSTR(trim(CUSTODYCD),5,6)) >= to_number(v_startnum) and TO_NUMBER(SUBSTR(trim(CUSTODYCD),5,6))<= to_number(v_endnum)
                            ORDER BY CUSTODYCD
                         ) DAT
                    WHERE TO_NUMBER(SUBSTR(INVACCT,5,6))=ROWNUM+to_number(v_startnum)
                ) INVTAB
                GROUP BY SUBSTR(INVACCT,1,4);
               /*   If(v_AUTOINVTEMP < v_endnum) then
                          v_AUTOINV := v_AUTOINVTEMP;
                  else
                         plog.setendsection (pkgctx, 'fn_txAppUpdate');
                         p_err_code:=-670101;--So luu ky da het han muc cap phep

                  end if;*/
            exception when others then
              v_prefix:='';
              v_AUTOINV:=v_startnum + 1;
            end;
            OPEN PV_REFCURSOR
            FOR
            select v_prefix ODR,  v_AUTOINV AUTOINV from dual ;
         /* ELSIF (V_CLAUSE = 'AFACCTNO') THEN
             OPEN PV_REFCURSOR
             FOR
                  SELECT SUBSTR(INVACCT,1,4), MAX(ODR)+1 AUTOINV FROM
                   (
                   SELECT ROWNUM ODR, INVACCT
                   FROM (   select ACCTNO INVACCT from (
                                 SELECT ACCTNO FROM AFMAST WHERE SUBSTR(ACCTNO,1,4) = V_BRID
                                 union all
                                 SELECT substr(CHILD_RECORD_KEY,-11,10) ACCTNO  FROM APPRVEXEC WHERE CHILD_TABLE_NAME = 'AFMAST' and ACTION_FLAG = 'ADD' AND STATUS = 'N'
                             ) ORDER BY ACCTNO
                         ) DAT
                   WHERE TO_NUMBER(SUBSTR(INVACCT,5,6))=ROWNUM
                   ) INVTAB
                   GROUP BY SUBSTR(INVACCT,1,4);*/
          /*ELSIF (V_CLAUSE = 'GRACCTNO') THEN
             OPEN PV_REFCURSOR
             FOR
                  SELECT SUBSTR(INVACCT, 1, V_iRefLength), MAX(ODR)+1 AUTOINV FROM
                  (SELECT ROWNUM ODR, INVACCT
                  FROM (SELECT ACCTNO INVACCT FROM GRMAST WHERE SUBSTR(ACCTNO, 1, V_iRefLength)= V_REFERENCE ORDER BY ACCTNO) DAT
                  WHERE TO_NUMBER(SUBSTR(INVACCT,13,4))=ROWNUM) INVTAB
                  GROUP BY SUBSTR(INVACCT, 1, V_iRefLength);*/
          /*ELSIF (V_CLAUSE = 'LMACCTNO') THEN
             OPEN PV_REFCURSOR
             FOR
                  SELECT SUBSTR(INVACCT, 1, V_iRefLength), MAX(ODR)+1 AUTOINV FROM
                  (SELECT ROWNUM ODR, INVACCT
                  FROM (SELECT ACCTNO INVACCT FROM LMMAST WHERE SUBSTR(ACCTNO, 1, V_iRefLength)= V_REFERENCE ORDER BY ACCTNO) DAT
                  WHERE TO_NUMBER(SUBSTR(INVACCT,13,4))=ROWNUM) INVTAB
                  GROUP BY SUBSTR(INVACCT, 1, V_iRefLength);*/
          /*ELSIF (V_CLAUSE = 'CLACCTNO') THEN
             OPEN PV_REFCURSOR
             FOR
                  SELECT SUBSTR(INVACCT, 1, V_iRefLength), MAX(ODR)+1 AUTOINV FROM
                  (SELECT ROWNUM ODR, INVACCT
                  FROM (SELECT ACCTNO INVACCT FROM CLMAST WHERE SUBSTR(ACCTNO, 1, V_iRefLength)= V_REFERENCE ORDER BY ACCTNO) DAT
                  WHERE TO_NUMBER(SUBSTR(INVACCT,13,4))=ROWNUM) INVTAB
                  GROUP BY SUBSTR(INVACCT, 1, V_iRefLength);*/
          /*ELSIF (V_CLAUSE = 'LNAPPLID') THEN
             OPEN PV_REFCURSOR
             FOR
                  SELECT SUBSTR(INVACCT, 1, V_iRefLength), MAX(ODR)+1 AUTOINV FROM
                  (SELECT ROWNUM ODR, INVACCT
                  FROM (SELECT APPLID INVACCT FROM LNAPPL WHERE SUBSTR(APPLID, 1, V_iRefLength)= V_REFERENCE ORDER BY APPLID) DAT
                  WHERE TO_NUMBER(SUBSTR(INVACCT,13,3))=ROWNUM) INVTAB
                  GROUP BY SUBSTR(INVACCT, 1, V_iRefLength);*/
         /* ELSIF (V_CLAUSE = 'LNACCTNO') THEN
             OPEN PV_REFCURSOR
             FOR
                  SELECT SUBSTR(INVACCT, 1, V_iRefLength), MAX(ODR)+1 AUTOINV FROM
                  (SELECT ROWNUM ODR, INVACCT
                  FROM (SELECT ACCTNO INVACCT FROM LNMAST WHERE SUBSTR(ACCTNO, 1, V_iRefLength)= V_REFERENCE ORDER BY ACCTNO) DAT
                  WHERE TO_NUMBER(SUBSTR(INVACCT,16,3))=ROWNUM) INVTAB
                  GROUP BY SUBSTR(INVACCT, 1, V_iRefLength);*/
          ELSIF (V_CLAUSE = 'OPTCODEID') THEN
             OPEN PV_REFCURSOR
             FOR
                  SELECT TO_NUMBER(SUBSTR((TO_CHAR(MAX(TO_NUMBER(nvl(invacct,0))) + 1)), 2, LENGTH((TO_CHAR(MAX(TO_NUMBER(nvl(invacct,0))) + 1))) - 1)) autoinv,
                  (MAX(nvl(odr,0)) + 1) odr
                  FROM   (SELECT   ROWNUM odr, invacct
                  FROM   (SELECT   invacct
                  FROM   (SELECT   codeid invacct FROM sbsecurities WHERE substr(codeid, 1, 1)=9 UNION ALL SELECT '900001' FROM dual)
                  ORDER BY   invacct) dat
                  ) invtab;

          ELSIF (V_CLAUSE = 'SEQ_FILEIMPORT') THEN
             OPEN PV_REFCURSOR
             FOR
                  SELECT SEQ_FILEIMPORT.NEXTVAL FROM dual  ;
         /*ELSIF (V_CLAUSE = 'SEQ_ODMAST') THEN
             OPEN PV_REFCURSOR
             FOR
                  SELECT SEQ_ODMAST.NEXTVAL AUTOINV FROM DUAL;*/
        --Ducnv FF Gateway
       /* ELSIF (V_CLAUSE = 'SEQ_ODMASTPT') THEN
             OPEN PV_REFCURSOR
             FOR
                SELECT SEQ_ODMASTPT.NEXTVAL AUTOINV FROM DUAL;*/
        --end Ducnv FF Gateway
         /*ELSIF (V_CLAUSE = 'SEQ_DFMAST') THEN
             OPEN PV_REFCURSOR
             FOR
                  SELECT SEQ_DFMAST.NEXTVAL AUTOINV FROM DUAL;
         ELSIF (V_CLAUSE = 'SEQ_WITHDRAWN') THEN
             OPEN PV_REFCURSOR
             FOR
                  SELECT SEQ_WITHDRAWN.NEXTVAL AUTOINV FROM DUAL;
         ELSIF (V_CLAUSE = 'SEQ_SMSMOBILE') THEN
             OPEN PV_REFCURSOR
             FOR
                  SELECT SEQ_SMSMOBILE.NEXTVAL AUTOINV FROM DUAL;
         ELSIF (V_CLAUSE = 'PRTYPE') THEN
             OPEN PV_REFCURSOR
             FOR
                  SELECT SEQ_PRTYPE.NEXTVAL AUTOINV FROM DUAL;*/
         /*ELSIF (V_CLAUSE = 'MBCODE') THEN
             OPEN PV_REFCURSOR
             FOR
                  SELECT (MAX(TO_NUMBER(AUTOID)) + 1) AUTOINV FROM MEMBERS;*/
         ELSIF (V_CLAUSE = 'CODEID') THEN
             OPEN PV_REFCURSOR
             FOR


                  SELECT (MAX(TO_NUMBER(INVACCT)) + 1) AUTOINV FROM
                  (SELECT ROWNUM ODR, INVACCT
                  FROM (SELECT CODEID INVACCT FROM SBSECURITIES WHERE SUBSTR(CODEID, 1, 1) <> 9 ORDER BY CODEID) DAT
                  ) INVTAB;
         /*ELSIF (V_CLAUSE = 'POTXNUM') THEN
             OPEN PV_REFCURSOR
             FOR
                  SELECT NVL(MAX(ODR)+1,1) AUTOINV FROM
                  (SELECT ROWNUM ODR, INVACCT
                  FROM (SELECT TXNUM INVACCT FROM POMAST WHERE BRID = V_BRID ORDER BY TXNUM) DAT
                  ) INVTAB;
        ELSIF (V_CLAUSE = 'ADTXNUM') THEN
             OPEN PV_REFCURSOR
             FOR
                  SELECT NVL(MAX(ODR)+1,1) AUTOINV FROM
                  (SELECT ROWNUM ODR, INVACCT
                  FROM (SELECT TXNUM INVACCT FROM ADMAST WHERE BRID = V_BRID ORDER BY TXNUM) DAT
                  ) INVTAB;
        ELSIF (V_CLAUSE = 'PRMASTER') THEN
             OPEN PV_REFCURSOR
             FOR
                SELECT  NVL(MAX(ODR)+1,1) AUTOINV FROM
                    (SELECT ROWNUM ODR, INVACCT
                        FROM (SELECT prcode INVACCT FROM PRMASTER  ORDER BY prcode) DAT
                        WHERE TO_NUMBER(INVACCT)=ROWNUM) INVTAB;

        ELSIF (V_CLAUSE = 'CAMASTID') THEN
             OPEN PV_REFCURSOR
             FOR
                  /*SELECT SEQ_CAMAST.NEXTVAL AUTOINV FROM DUAL;  */

            /* v_strSQL = "SELECT SUBSTR(INVACCT,1,10), MAX(ODR)+1 AUTOINV FROM " & ControlChars.CrLf _
            '            & "(SELECT ROWNUM ODR, INVACCT " & ControlChars.CrLf _
            '            & "FROM (SELECT CAMASTID INVACCT FROM CAMAST WHERE SUBSTR(CAMASTID,1,10)='" & v_strREFERENCE & "' ORDER BY CAMASTID) DAT " & ControlChars.CrLf _
            '            & "WHERE TO_NUMBER(SUBSTR(INVACCT,11,6))=ROWNUM) INVTAB " & ControlChars.CrLf _
            '            & "GROUP BY SUBSTR(INVACCT,1,10)"*/


                /*   SELECT  NVL(MAX(ODR)+1,1) AUTOINV FROM
                    (SELECT ROWNUM ODR, INVACCT
                        FROM (SELECT CAMASTID INVACCT FROM CAMAST  ORDER BY CAMASTID) DAT
                        ) INVTAB;*/

                     /*    SELECT  NVL(INVACCT+1,1) AUTOINV FROM
                    (SELECT  (CASE WHEN INVACCT1>INVACCT2 THEN inVACCT1 ELSE INVACCT2 END )INVACCT
                        FROM (select sum(INVACCT1) INVACCT1, sum(INVACCT2) INVACCT2 from (
                                    SELECT max(TO_NUMBER(SUBSTR(CAMAST.CAMASTID,11,6))) INVACCT1, 0 INVACCT2 from camast
                                    union
                                    SELECT 0 INVACCT1, max(TO_NUMBER(SUBSTR(CAMASTHIST.CAMASTID,11,6))) INVACCT2 from camasthist
                                )
                             ) DAT
                        ) INVTAB;*/



       /* ELSIF (V_CLAUSE = 'BANKNOSTRO') THEN
             OPEN PV_REFCURSOR
             FOR
                  SELECT  NVL(MAX(ODR)+1,1) AUTOINV FROM
                    (SELECT ROWNUM ODR, INVACCT
                    FROM (SELECT SHORTNAME INVACCT FROM BANKNOSTRO ORDER BY SHORTNAME) DAT
                    WHERE TO_NUMBER(INVACCT)=ROWNUM) INVTAB;
        ELSIF (V_CLAUSE = 'TRFACINV') THEN
            OPEN PV_REFCURSOR
             FOR
                  SELECT  NVL(MAX(ODR)+1,1) AUTOINV FROM
                    (SELECT ROWNUM ODR, INVACCT
                    FROM (SELECT AUTOID INVACCT FROM CRBTRFACCTSRC ORDER BY AUTOID) DAT
                    WHERE TO_NUMBER(INVACCT)=ROWNUM) INVTAB;*/
        END IF;



EXCEPTION
   WHEN OTHERS
   THEN
      RETURN;
END;
/

DROP PROCEDURE update_cfsign
/

CREATE OR REPLACE 
PROCEDURE update_cfsign 
(V_CUSTID varchar2, 
V_SIGNATURE varchar2, 
V_VALDATE varchar2, 
V_TYPE varchar2,
V_AUTOID NUMBER,
V_DESC varchar2) IS
    LONGLITERAL VARCHAR2(32767);

    BEGIN
       LONGLITERAL:=V_SIGNATURE;
       UPDATE CFSIGN
       SET SIGNATURE=LONGLITERAL, VALDATE = GETCURRDATE,
           EXPDATE = GETCURRDATE,DESCRIPTION = V_DESC, TYPE = V_TYPE 
       WHERE AUTOID=V_AUTOID;

    END ;
/

DROP PROCEDURE update_year_4sip_temp
/

CREATE OR REPLACE 
PROCEDURE update_year_4sip_temp 
   ( pv_strNewYear IN VARCHAR2,
   pv_strHoliday IN VARCHAR2,
   pv_strfund in VARCHAR2,
   pv_strtype IN VARCHAR2,
   pv_fromDate IN VARCHAR2 DEFAULT '',
   pv_toDate IN VARCHAR2 DEFAULT '',
   pv_action IN VARCHAR2 DEFAULT 'EDIT'
   )
IS
-- Purpose: Add a new year
-- MODIFICATION HISTORY
-- Person      Date        Comments
-- NAMNT      01/01/2018
-- ---------   ------  -------------------------------------------
   v_dCurDate DATE;
   v_LastDate DATE;
   v_TmpDate  DATE;
   v_NextDate DATE;
   v_NextDate_real DATE;
   l_holiday varchar2(20);
   l_count NUMBER;
   pkgctx   plog.log_ctx;
   l_fstdate DATE;
   l_count_fund NUMBER;
   l_tradingdatedtl DATE;
   v_TmpDate_dtl date;
   l_curryear varchar2(20);
   l_count_dtl NUMBER;
BEGIN
  plog.ERROR (pkgctx, 'pv_strfund: '||pv_strfund);
    --Init session
    plog.setbeginsection (pkgctx, 'update_year_4sip');
    l_curryear := TO_CHAR(getcurrdate,'RRRR');
    --Sua mod update lich sip tu ngay den ngay
    IF pv_strtype ='EXP' THEN
        -- Khoi tao tu ngay den ngay
        v_dCurDate := to_date(pv_fromDate,'dd/mm/rrrr');
        v_LastDate := to_date(pv_toDate,'dd/mm/rrrr');
    ELSE
      if pv_strHoliday = '1001' then
        --Th thay doi ngay nghi bang giao dich 1001 thi chi gen lai 1 nam
        v_dCurDate := to_date(concat('01-Jan-',pv_strNewYear),'dd/mm/yyyy');
        v_LastDate := to_date(concat('31-Dec-',pv_strNewYear),'dd/mm/yyyy');
      else
        --TH them nam lich he thong thi phai gen den het ngay cuoi cung
        -- Khoi tao ngay dau cua nam 01/01
        v_dCurDate := to_date(concat('01-Jan-',pv_strNewYear),'dd/mm/yyyy');
        --v_LastDate := to_date(concat('31-Dec-',pv_strNewYear),'dd/mm/yyyy');
        SELECT MAX(SB.SBDATE) INTO v_LastDate FROM SBCLDR SB WHERE SB.CLDRTYPE = '000';
      end if;
    END IF;

    --Kiem tra xem co ton tai lich sip giong lich he thong chua. Neu chua co thi sinh
    SELECT count(*) INTO l_count FROM sbcldr WHERE CLDRTYPE='000' AND sbdate>=v_dCurDate AND sbdate<=v_LastDate;
    SELECT count(*) INTO l_count_fund FROM sbcldr WHERE CLDRTYPE= pv_strfund AND sbdate>=v_dCurDate AND sbdate<=v_LastDate;
    IF l_count <> l_count_fund THEN
        DELETE FROM  sbcldr WHERE CLDRTYPE= pv_strfund AND sbdate>=v_dCurDate;
        INSERT INTO SBCLDR (Autoid,SBDATE,SBBUSDAY,SBBOW,SBBOM,SBBOQ,SBBOY,SBEOW,SBEOM,SBEOQ,SBEOY,HOLIDAY,CLDRTYPE)
            SELECT seq_SBCLDR.NEXTVAL, SBDATE,SBBUSDAY,SBBOW,SBBOM,SBBOQ,SBBOY,SBEOW,SBEOM,SBEOQ,SBEOY,HOLIDAY,pv_strfund CLDRTYPE
            FROM sbcldr WHERE CLDRTYPE = '000' AND sbdate>=v_dCurDate;
        --UPDATE sbcldr SET SIP ='N', sipcode ='' WHERE cldrtype = pv_strfund AND sbdate >= v_dCurDate AND sbdate<=v_LastDate;
        --UPDATE sbcldr SET holiday ='Y' WHERE cldrtype = pv_strfund AND sbdate >= v_dCurDate AND sbdate<=v_LastDate;
    END IF;

    IF pv_strtype ='SIP' OR pv_strtype ='EXP' THEN
      plog.error (pkgctx, 'pv_strtype: '||pv_strtype || 'pv_action: '|| pv_action || 'l_count: '|| l_count || 'l_count_fund: '||l_count_fund );
      /*if pv_action = 'ADD' AND l_count <> l_count_fund THEN
        UPDATE sbcldr SET SIP ='N', sipcode ='' WHERE cldrtype = pv_strfund AND sbdate >= v_dCurDate AND sbdate<=v_LastDate;
      ELSE*/
        UPDATE sbcldr SET SIP ='N', sipcode ='' WHERE cldrtype = pv_strfund AND sbdate >= v_dCurDate AND sbdate<=v_LastDate /*and sbdate>=getcurrdate*/ ;
      /*END IF;*/

        FOR rec IN (SELECT codeid, SPCODE, (CASE WHEN SPCODE IS NULL THEN 'xxx' ELSE 'SIP' END) SPTYPE,tradingcycle,t.autoid,
                    T.ADJTRADERULE,nvl(t.fstdate,getcurrdate) fstdate
                    FROM tradingcycle T WHERE T.codeid = pv_strfund AND SPCODE IS NOT NULL AND T.STATUS='A')
        LOOP
          begin
              select tc.fstdate into l_fstdate from tradingcycle tc where tc.codeid = rec.codeid and tc.spcode is null;
          exception when others then
            plog.error (pkgctx, ' loi rec.codeid: '||rec.codeid);
            l_fstdate := getcurrdate;
          end;
              --v_TmpDate :=  v_dCurDate-1;
              IF pv_strtype ='EXP' THEN
                v_TmpDate := v_dCurDate -1;
              ELSE
                IF l_curryear < pv_strNewYear THEN
                    --gen cho nam sau
                    v_TmpDate := v_dCurDate -1;
                ELSE
                    v_TmpDate := v_dCurDate -1;
                END IF;
              END IF;
              --plog.error (pkgctx, 'begin v_TmpDate:' || v_TmpDate);
              l_count:=0;
              LOOP
                  v_TmpDate_dtl := v_TmpDate;
                  v_NextDate:= pck_cldr.fn_caltradingcycle(v_TmpDate, rec.autoid);
                  v_TmpDate :=v_NextDate;
                  --plog.error (pkgctx, 'begin v_NextDate:' || v_NextDate);
                  BEGIN
                        SELECT holiday INTO l_holiday FROM sbcldr WHERE cldrtype = pv_strfund AND sbdate = v_NextDate;
                  EXCEPTION WHEN OTHERS THEN
                        l_holiday :='N';
                  END;
                  IF l_holiday ='Y' THEN
                      IF rec.adjtraderule = 'N' THEN
                         SELECT MIN(SBDATE) INTO v_NextDate_real FROM sbcldr sb
                         WHERE sb.cldrtype = pv_strfund AND sb.sbdate >= v_NextDate AND SB.HOLIDAY = 'N';
                         v_TmpDate :=v_NextDate_real;
                         --plog.error (pkgctx, 'begin v_NextDate_real:' || v_NextDate_real);
                       ELSIF rec.adjtraderule = 'P' THEN
                         SELECT MAX(SBDATE) INTO v_NextDate_real FROM sbcldr sb
                         WHERE sb.cldrtype = pv_strfund  AND sb.sbdate <= v_NextDate AND SB.HOLIDAY = 'N';
                       ELSIF rec.adjtraderule = 'I' THEN
                            -- lay ngay lam lam viec cua lich ke tiep. De quy
                            loop

                                 v_NextDate_real := pck_cldr.fn_caltradingcycle(v_TmpDate,rec.autoid);

                                 BEGIN
                                        SELECT holiday INTO l_holiday FROM sbcldr WHERE cldrtype = pv_strfund AND sbdate = v_NextDate_real;
                                 EXCEPTION WHEN OTHERS THEN
                                        l_holiday :='N';
                                 END;
                                 v_TmpDate :=v_NextDate_real;
                            exit when l_holiday ='N';
                            end loop;

                       END IF;
                       v_NextDate := v_NextDate_real;
                  END IF;

                  IF v_NextDate <=v_LastDate AND v_NextDate >=v_dCurDate /*AND v_NextDate>=getcurrdate*/ THEN
                    l_count_dtl :=0;
                    FOR I IN (SELECT dtl.autoid, tc.traddingtype, dtl.tradingcycledtl FROM TRADINGCYCLE TC, TRADINGCYCLEDTL DTL
                                     WHERE TC.AUTOID =  DTL.REFAUTOID AND TC.AUTOID = REC.AUTOID)
                    LOOP
                      IF i.traddingtype = 'CD' THEN
                        l_tradingdatedtl := pck_cldr.fn_caltradingcycledtl(v_TmpDate_dtl,i.autoid);
                        plog.error (pkgctx, 'begin l_tradingdatedtl:' || l_tradingdatedtl || 'v_NextDate:'||v_NextDate );
                        IF l_tradingdatedtl = v_NextDate THEN
                           UPDATE sbcldr SET SIP ='Y', sipcode = sipcode||'|'||rec.spcode||'#'||i.tradingcycledtl
                               WHERE sbdate = v_NextDate AND cldrtype = pv_strfund;
                           l_count_dtl :=l_count_dtl+1;
                        END IF;
                      ELSE
                        UPDATE sbcldr SET SIP ='Y', sipcode = sipcode||'|'||rec.spcode||'#'||rec.tradingcycle
                               WHERE sbdate = v_NextDate AND cldrtype = pv_strfund;
                        l_count_dtl :=l_count_dtl+1;
                      END IF;
                    END LOOP;
                    IF l_count_dtl = 0 THEN
                        UPDATE sbcldr SET SIP ='Y', sipcode = sipcode||'|'||rec.spcode||'#'||rec.tradingcycle
                               WHERE sbdate = v_NextDate AND cldrtype = pv_strfund;
                    END IF;
                  END IF;
                  l_count :=l_count+1;
              EXIT WHEN  v_TmpDate> v_LastDate OR v_TmpDate = TO_DATE('01/01/2000','DD/MM/RRRR') OR v_TmpDate = '' OR v_TmpDate IS NULL;
              END LOOP;
        END LOOP;
    ELSE
        --cap nhat ngay nghi toan bo cua lich
     if pv_action = 'ADD' /*AND l_count <> l_count_fund*/ THEN
         UPDATE sbcldr SET holiday ='Y' WHERE cldrtype = pv_strfund AND sbdate >= v_dCurDate AND sbdate<=v_LastDate ;
      ELSE
         UPDATE sbcldr SET holiday ='Y' WHERE cldrtype = pv_strfund AND sbdate >= v_dCurDate AND sbdate<=v_LastDate /*and sbdate>=getcurrdate*/;
      END IF;

        FOR rec IN (SELECT codeid, SPCODE, (CASE WHEN SPCODE IS NULL THEN 'xxx' ELSE 'SIP' END) SPTYPE,tradingcycle,t.autoid,
                    t.adjtraderule,nvl(t.fstdate,getcurrdate) fstdate
                    FROM tradingcycle T WHERE T.codeid = pv_strfund AND SPCODE IS NULL AND T.STATUS='A')
        LOOP
              --v_TmpDate := rec.fstdate -1;
              IF l_curryear < pv_strNewYear THEN
                  --gen cho nam sau
                  v_TmpDate := v_dCurDate -1;
              ELSE
                  v_TmpDate := v_dCurDate -1;
              END IF;

              l_count:=0;
              LOOP
                plog.ERROR (pkgctx, 'v_TmpDate: '||v_TmpDate );
                  v_NextDate:= pck_cldr.fn_caltradingcycle(v_TmpDate, rec.autoid);
                  v_TmpDate :=v_NextDate;
                  --Kiem tra ngya nghi thi ap dung luat theo traderule
                  BEGIN
                        SELECT holiday INTO l_holiday FROM sbcldr WHERE cldrtype ='000' AND sbdate = v_NextDate;
                  EXCEPTION WHEN OTHERS THEN
                        l_holiday :='N';
                  END;
                  IF l_holiday ='Y' THEN
                      IF rec.adjtraderule = 'N' THEN
                         SELECT MIN(SBDATE) INTO v_NextDate_real FROM sbcldr sb
                         WHERE sb.cldrtype = '000' AND sb.sbdate >= v_NextDate AND SB.HOLIDAY = 'N';
                         v_TmpDate :=v_NextDate_real;
                       ELSIF rec.adjtraderule = 'P' THEN
                         SELECT MAX(SBDATE) INTO v_NextDate_real FROM sbcldr sb
                         WHERE sb.cldrtype = '000'  AND sb.sbdate <= v_NextDate AND SB.HOLIDAY = 'N';
                       ELSIF rec.adjtraderule = 'I' THEN
                            -- lay ngay lam lam viec cua lich ke tiep. De quy
                            loop

                                 v_NextDate_real := pck_cldr.fn_caltradingcycle(v_TmpDate,rec.autoid);
                                 BEGIN
                                        SELECT holiday INTO l_holiday FROM sbcldr WHERE cldrtype = '000' AND sbdate = v_NextDate_real;
                                 EXCEPTION WHEN OTHERS THEN
                                        l_holiday :='N';
                                 END;
                                 v_TmpDate :=v_NextDate_real;
                            exit when l_holiday ='N';
                            end loop;
                       END IF;
                       v_NextDate := v_NextDate_real;
                  END IF;

                  IF v_NextDate <=v_LastDate AND v_NextDate >=v_dCurDate /*AND v_NextDate>=getcurrdate*/ THEN
                        UPDATE sbcldr SET holiday ='N'
                               WHERE sbdate = v_NextDate AND cldrtype = pv_strfund;
                  END IF;
                  --v_TmpDate :=v_NextDate;
                  l_count :=l_count+1;
              EXIT WHEN  v_TmpDate> v_LastDate OR v_TmpDate = TO_DATE('01/01/2000','DD/MM/RRRR') OR v_TmpDate = '' OR v_TmpDate IS NULL ;
              END LOOP;
        END LOOP;
    END IF;

    plog.setendsection (pkgctx, 'update_year_4sip');
EXCEPTION
   WHEN OTHERS THEN
        BEGIN
            rollback;
            plog.error (pkgctx, '[SQLERRM] ' || SQLERRM); --Log trace exception
            plog.error (pkgctx, '[Format_error_backtrace] ' || dbms_utility.format_error_backtrace); --Log trace
            plog.setendsection (pkgctx, 'update_year_4sip');
            return;
        END;
END;
/

