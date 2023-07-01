DROP VIEW aq$_push2fo_queue_table_f
/

CREATE OR REPLACE VIEW aq$_push2fo_queue_table_f (
   q_name,
   row_id,
   msgid,
   corrid,
   priority,
   state,
   delay,
   expiration,
   enq_time,
   enq_uid,
   enq_tid,
   deq_time,
   deq_uid,
   deq_tid,
   retry_count,
   exception_qschema,
   exception_queue,
   cscn,
   dscn,
   chain_no,
   local_order_no,
   time_manager_info,
   step_no,
   user_data,
   sender_name,
   sender_address,
   sender_protocol,
   dequeue_msgid,
   delivery_mode,
   sequence_num,
   msg_num,
   queue_id,
   user_prop )
AS
SELECT  /*+ NO_MERGE (qo) USE_NL(qt) */ qt.q_name Q_NAME, qt.rowid ROW_ID, qt.msgid MSGID, qt.corrid CORRID, qt.priority PRIORITY, qt.state STATE, cast(FROM_TZ(qt.delay, '00:00') at time zone sessiontimezone as timestamp) DELAY, qt.expiration EXPIRATION, cast(FROM_TZ(qt.enq_time, '00:00') at time zone sessiontimezone as timestamp) ENQ_TIME, qt.enq_uid ENQ_UID, qt.enq_tid ENQ_TID, cast(FROM_TZ(qt.deq_time, '00:00') at time zone sessiontimezone as timestamp) DEQ_TIME, qt.deq_uid DEQ_UID, qt.deq_tid DEQ_TID, qt.retry_count RETRY_COUNT, qt.exception_qschema EXCEPTION_QSCHEMA, qt.exception_queue EXCEPTION_QUEUE, qt.cscn CSCN, qt.dscn DSCN, qt.chain_no CHAIN_NO, qt.local_order_no LOCAL_ORDER_NO, cast(FROM_TZ(qt.time_manager_info, '00:00') at time zone sessiontimezone as timestamp)   TIME_MANAGER_INFO, qt.step_no STEP_NO, qt.user_data USER_DATA ,qt.sender_name SENDER_NAME, qt.sender_address SENDER_ADDRESS, qt.sender_protocol SENDER_PROTOCOL, qt.dequeue_msgid DEQUEUE_MSGID, 'PERSISTENT' DELIVERY_MODE, 0 SEQUENCE_NUM, 0 MSG_NUM, qo.qid QUEUE_ID, qt.user_prop USER_PROP FROM "SHBCBD"."PUSH2FO_QUEUE_TABLE" qt, SYS.ALL_INT_DEQUEUE_QUEUES qo  WHERE qt.q_name = qo.name AND qo.owner = 'SHBCBD' WITH READ ONLY
/
DROP VIEW aq$_txaqs_rptflex2fo_queue_table_f
/

CREATE OR REPLACE VIEW aq$_txaqs_rptflex2fo_queue_table_f (
   q_name,
   row_id,
   msgid,
   corrid,
   priority,
   state,
   delay,
   expiration,
   enq_time,
   enq_uid,
   enq_tid,
   deq_time,
   deq_uid,
   deq_tid,
   retry_count,
   exception_qschema,
   exception_queue,
   cscn,
   dscn,
   chain_no,
   local_order_no,
   time_manager_info,
   step_no,
   user_data,
   sender_name,
   sender_address,
   sender_protocol,
   dequeue_msgid,
   delivery_mode,
   sequence_num,
   msg_num,
   queue_id,
   user_prop )
AS
SELECT  /*+ NO_MERGE (qo) USE_NL(qt) */ qt.q_name Q_NAME, qt.rowid ROW_ID, qt.msgid MSGID, qt.corrid CORRID, qt.priority PRIORITY, qt.state STATE, cast(FROM_TZ(qt.delay, '00:00') at time zone sessiontimezone as timestamp) DELAY, qt.expiration EXPIRATION, cast(FROM_TZ(qt.enq_time, '00:00') at time zone sessiontimezone as timestamp) ENQ_TIME, qt.enq_uid ENQ_UID, qt.enq_tid ENQ_TID, cast(FROM_TZ(qt.deq_time, '00:00') at time zone sessiontimezone as timestamp) DEQ_TIME, qt.deq_uid DEQ_UID, qt.deq_tid DEQ_TID, qt.retry_count RETRY_COUNT, qt.exception_qschema EXCEPTION_QSCHEMA, qt.exception_queue EXCEPTION_QUEUE, qt.cscn CSCN, qt.dscn DSCN, qt.chain_no CHAIN_NO, qt.local_order_no LOCAL_ORDER_NO, cast(FROM_TZ(qt.time_manager_info, '00:00') at time zone sessiontimezone as timestamp)   TIME_MANAGER_INFO, qt.step_no STEP_NO, qt.user_data USER_DATA ,qt.sender_name SENDER_NAME, qt.sender_address SENDER_ADDRESS, qt.sender_protocol SENDER_PROTOCOL, qt.dequeue_msgid DEQUEUE_MSGID, 'PERSISTENT' DELIVERY_MODE, 0 SEQUENCE_NUM, 0 MSG_NUM, qo.qid QUEUE_ID, qt.user_prop USER_PROP FROM "SHBCBD"."TXAQS_RPTFLEX2FO_QUEUE_TABLE" qt, SYS.ALL_INT_DEQUEUE_QUEUES qo  WHERE qt.q_name = qo.name AND qo.owner = 'SHBCBD' WITH READ ONLY
/
DROP VIEW aq$push2fo_queue_table
/

CREATE OR REPLACE VIEW aq$push2fo_queue_table (
   queue,
   msg_id,
   corr_id,
   msg_priority,
   msg_state,
   delay,
   delay_timestamp,
   expiration,
   enq_time,
   enq_timestamp,
   enq_user_id,
   enq_txn_id,
   deq_time,
   deq_timestamp,
   deq_user_id,
   deq_txn_id,
   retry_count,
   exception_queue_owner,
   exception_queue,
   user_data,
   original_queue_name,
   original_queue_owner,
   expiration_reason,
   sender_name,
   sender_address,
   sender_protocol,
   original_msgid )
AS
SELECT q_name QUEUE, msgid MSG_ID, corrid CORR_ID, priority MSG_PRIORITY, decode(state, 0,   'READY',
                                1,   'WAIT',
                                2,   'PROCESSED',
                                3,   'EXPIRED',
                                10,  'BUFFERED_EXPIRED') MSG_STATE, cast(FROM_TZ(delay, '00:00')
                  at time zone sessiontimezone as date) DELAY, cast(FROM_TZ(delay, '00:00')
               at time zone sessiontimezone as timestamp) DELAY_TIMESTAMP, expiration, cast(FROM_TZ(enq_time, '00:00')
                  at time zone sessiontimezone as date) ENQ_TIME, cast(FROM_TZ(enq_time, '00:00')
                  at time zone sessiontimezone as timestamp) 
                  ENQ_TIMESTAMP, enq_uid ENQ_USER_ID, enq_tid ENQ_TXN_ID, cast(FROM_TZ(deq_time, '00:00')
                  at time zone sessiontimezone as date) DEQ_TIME, cast(FROM_TZ(deq_time, '00:00')
                  at time zone sessiontimezone as timestamp) 
                  DEQ_TIMESTAMP, deq_uid DEQ_USER_ID, deq_tid DEQ_TXN_ID, retry_count,  decode (state, 0, exception_qschema, 
                                  1, exception_qschema, 
                                  2, exception_qschema,  
                                  NULL) EXCEPTION_QUEUE_OWNER,  decode (state, 0, exception_queue, 
                                  1, exception_queue, 
                                  2, exception_queue,  
                                  NULL) EXCEPTION_QUEUE,  user_data,  decode (state, 3, 
                     decode (deq_tid, 'INVALID_TRANSACTION', NULL, 
                             exception_queue), NULL)
                                ORIGINAL_QUEUE_NAME,  decode (state, 3, 
                     decode (deq_tid, 'INVALID_TRANSACTION', NULL, 
                             exception_qschema), NULL)
                                ORIGINAL_QUEUE_OWNER,  decode(state, 3, 
                     decode(deq_time, NULL, 
                       decode(deq_tid, NULL,
                       decode (expiration , NULL , 'MAX_RETRY_EXCEEDED',
                            'TIME_EXPIRATION'),
                              'INVALID_TRANSACTION', NULL,
                              'MAX_RETRY_EXCEEDED'), NULL), NULL) 
                             EXPIRATION_REASON , sender_name SENDER_NAME, sender_address SENDER_ADDRESS, sender_protocol SENDER_PROTOCOL, dequeue_msgid ORIGINAL_MSGID  FROM "PUSH2FO_QUEUE_TABLE" WHERE state != 7 AND   state != 9 WITH READ ONLY
/
DROP VIEW aq$txaqs_rptflex2fo_queue_table
/

CREATE OR REPLACE VIEW aq$txaqs_rptflex2fo_queue_table (
   queue,
   msg_id,
   corr_id,
   msg_priority,
   msg_state,
   delay,
   delay_timestamp,
   expiration,
   enq_time,
   enq_timestamp,
   enq_user_id,
   enq_txn_id,
   deq_time,
   deq_timestamp,
   deq_user_id,
   deq_txn_id,
   retry_count,
   exception_queue_owner,
   exception_queue,
   user_data,
   original_queue_name,
   original_queue_owner,
   expiration_reason,
   sender_name,
   sender_address,
   sender_protocol,
   original_msgid )
AS
SELECT q_name QUEUE, msgid MSG_ID, corrid CORR_ID, priority MSG_PRIORITY, decode(state, 0,   'READY',
                                1,   'WAIT',
                                2,   'PROCESSED',
                                3,   'EXPIRED',
                                10,  'BUFFERED_EXPIRED') MSG_STATE, cast(FROM_TZ(delay, '00:00')
                  at time zone sessiontimezone as date) DELAY, cast(FROM_TZ(delay, '00:00')
               at time zone sessiontimezone as timestamp) DELAY_TIMESTAMP, expiration, cast(FROM_TZ(enq_time, '00:00')
                  at time zone sessiontimezone as date) ENQ_TIME, cast(FROM_TZ(enq_time, '00:00')
                  at time zone sessiontimezone as timestamp) 
                  ENQ_TIMESTAMP, enq_uid ENQ_USER_ID, enq_tid ENQ_TXN_ID, cast(FROM_TZ(deq_time, '00:00')
                  at time zone sessiontimezone as date) DEQ_TIME, cast(FROM_TZ(deq_time, '00:00')
                  at time zone sessiontimezone as timestamp) 
                  DEQ_TIMESTAMP, deq_uid DEQ_USER_ID, deq_tid DEQ_TXN_ID, retry_count,  decode (state, 0, exception_qschema, 
                                  1, exception_qschema, 
                                  2, exception_qschema,  
                                  NULL) EXCEPTION_QUEUE_OWNER,  decode (state, 0, exception_queue, 
                                  1, exception_queue, 
                                  2, exception_queue,  
                                  NULL) EXCEPTION_QUEUE,  user_data,  decode (state, 3, 
                     decode (deq_tid, 'INVALID_TRANSACTION', NULL, 
                             exception_queue), NULL)
                                ORIGINAL_QUEUE_NAME,  decode (state, 3, 
                     decode (deq_tid, 'INVALID_TRANSACTION', NULL, 
                             exception_qschema), NULL)
                                ORIGINAL_QUEUE_OWNER,  decode(state, 3, 
                     decode(deq_time, NULL, 
                       decode(deq_tid, NULL,
                       decode (expiration , NULL , 'MAX_RETRY_EXCEEDED',
                            'TIME_EXPIRATION'),
                              'INVALID_TRANSACTION', NULL,
                              'MAX_RETRY_EXCEEDED'), NULL), NULL) 
                             EXPIRATION_REASON , sender_name SENDER_NAME, sender_address SENDER_ADDRESS, sender_protocol SENDER_PROTOCOL, dequeue_msgid ORIGINAL_MSGID  FROM "TXAQS_RPTFLEX2FO_QUEUE_TABLE" WHERE state != 7 AND   state != 9 WITH READ ONLY
/
DROP VIEW natural_numbers
/

CREATE OR REPLACE VIEW natural_numbers (
   n )
AS
SELECT row_number() OVER (ORDER BY 1) AS n
   FROM ( SELECT 1 FROM dual
        UNION
         SELECT 2 FROM dual) t1
     JOIN ( SELECT 1 FROM dual
        UNION
         SELECT 2 FROM dual) t2 ON 1 = 1
     JOIN ( SELECT 1 FROM dual
        UNION
         SELECT 2 FROM dual) t3 ON 1 = 1
     JOIN ( SELECT 1 FROM dual
        UNION
         SELECT 2 FROM dual) t4 ON 1 = 1
     JOIN ( SELECT 1 FROM dual
        UNION
         SELECT 2 FROM dual) t5 ON 1 = 1
     JOIN ( SELECT 1 FROM dual
        UNION
         SELECT 2 FROM dual) t6 ON 1 = 1
     JOIN ( SELECT 1 FROM dual
        UNION
         SELECT 2 FROM dual) t7 ON 1 = 1
     JOIN ( SELECT 1 FROM dual
        UNION
         SELECT 2 FROM dual) t8 ON 1 = 1
     JOIN ( SELECT 1 FROM dual
        UNION
         SELECT 2 FROM dual) t9 ON 1 = 1
     JOIN ( SELECT 1 FROM dual
        UNION
         SELECT 2 FROM dual) t10 ON 1 = 1
/
DROP VIEW v_appmap_by_tltxcd
/

CREATE OR REPLACE VIEW v_appmap_by_tltxcd (
   tltxcd,
   apptype,
   tblname,
   apptxcd,
   acfld,
   amtexp,
   cond,
   fldkey,
   acfldref,
   txtype,
   field,
   fldtype,
   tranf,
   ofile,
   ofileact,
   isrun,
   fldrnd,
   trdesc )
AS
SELECT M.TLTXCD TLTXCD, M.APPTYPE APPTYPE, T.TBLNAME, M.APPTXCD APPTXCD, M.ACFLD ACFLD, M.AMTEXP AMTEXP, M.COND COND,
    M.FLDKEY, M.ACFLDREF ACFLDREF, T.TXTYPE TXTYPE, T.FIELD FIELD, T.FLDTYPE FLDTYPE, T.TRANF TRANF, T.OFILE OFILE,
    T.OFILEACT, M.ISRUN, T.FLDRND,M.TRDESC
FROM APPMAP M, APPTX T
WHERE M.APPTYPE = T.APPTYPE AND M.APPTXCD =T.TXCD
/
DROP VIEW vw_cf4feeapflt
/

CREATE OR REPLACE VIEW vw_cf4feeapflt (
   custid,
   custodycd,
   sid,
   firstname,
   middlename,
   lastname,
   fullname,
   acctype,
   custtype,
   grinvestor,
   sex,
   birthdate,
   idtype,
   idcode,
   iddate,
   idexpdated,
   idplace,
   tradingcode,
   tradingdate,
   taxno,
   regaddress,
   address,
   country,
   province,
   phone,
   mobile,
   email,
   status,
   pstatus,
   lastchange,
   bankacc,
   bankcode,
   citybank,
   bankacname,
   shortname,
   refname1,
   refmobile1,
   refname2,
   refmobile2,
   refpost1,
   refpost2,
   dbcode,
   afacctno )
AS
SELECT cf."CUSTID",cf."CUSTODYCD",cf."SID",cf."FIRSTNAME",cf."MIDDLENAME",cf."LASTNAME",cf."FULLNAME",cf."ACCTYPE",cf."CUSTTYPE",cf."GRINVESTOR",cf."SEX",cf."BIRTHDATE",cf."IDTYPE",cf."IDCODE",cf."IDDATE",cf."IDEXPDATED",cf."IDPLACE",cf."TRADINGCODE",cf."TRADINGDATE",cf."TAXNO",cf."REGADDRESS",cf."ADDRESS",cf."COUNTRY",cf."PROVINCE",cf."PHONE",cf."MOBILE",cf."EMAIL",cf."STATUS",cf."PSTATUS",cf."LASTCHANGE",cf."BANKACC",cf."BANKCODE",cf."CITYBANK",cf."BANKACNAME",cf."SHORTNAME",cf."REFNAME1",cf."REFMOBILE1",cf."REFNAME2",cf."REFMOBILE2",cf."REFPOST1",cf."REFPOST2",cf.DBCODE, af.acctno afacctno
FROM cfmast cf,afmast af
where cf.custid = af.custid
/
DROP VIEW vw_cmdmenu_all_rpt
/

CREATE OR REPLACE VIEW vw_cmdmenu_all_rpt (
   odrid,
   cmdid,
   prid,
   cmdname,
   en_cmdname,
   last,
   authcode,
   lev,
   imgindex,
   modcode,
   objname,
   menutype,
   cmdcode,
   cmdtype )
AS
SELECT M.CMDID ODRID, M.CMDID, M.PRID, M.CMDNAME, M.EN_CMDNAME,
        (CASE WHEN M.MENUTYPE='R' OR INSTR(M.OBJNAME,'GENERALVIEW')>0 THEN 'N' ELSE M.LAST END) LAST,
        M.AUTHCODE, M.LEV,
        (CASE WHEN M.LEV=1 THEN 0 ELSE (CASE WHEN (CASE WHEN M.MENUTYPE='R' OR INSTR(M.OBJNAME,'GENERALVIEW')>0 THEN 'N' ELSE M.LAST END)='Y' THEN 3 ELSE 1 END) END) IMGINDEX,
        M.MODCODE, M.OBJNAME, /*M.MENUTYPE*/case when INSTR(M.OBJNAME,'GENERALVIEW')>0 then 'G' else M.MENUTYPE end MENUTYPE, M.CMDID CMDCODE, 'M' CMDTYPE
FROM CMDMENU M
UNION ALL
SELECT M.CMDID || '.' || T.TLTXCD ODRID, T.TLTXCD CMDID, M.CMDID PRID, T.TLTXCD ||'-'|| T.TXDESC CMDNAME, T.TLTXCD ||'-'|| T.EN_TXDESC EN_CMDNAME, 'Y' LAST, M.AUTHCODE, M.LEV,
        3 IMGINDEX, M.MODCODE, M.OBJNAME, M.MENUTYPE, T.TLTXCD CMDCODE, T.TXTYPE CMDTYPE
FROM TLTX T, APPMODULES A, CMDMENU M
WHERE T.DIRECT='Y' AND T.TLTXCD LIKE A.TXCODE || '%' AND NOT (A.MODCODE IS NULL)
  AND M.MENUTYPE='T' AND M.MODCODE=A.MODCODE
UNION ALL
SELECT M.CMDID || '.' || T.TLTXCD ODRID, T.TLTXCD CMDID, M.CMDID PRID, T.TLTXCD ||'-'|| T.TXDESC CMDNAME, T.TLTXCD ||'-'|| T.EN_TXDESC EN_CMDNAME, 'Y' LAST, M.AUTHCODE, M.LEV,
        3 IMGINDEX, M.MODCODE, M.OBJNAME, M.MENUTYPE, T.TLTXCD CMDCODE, T.TXTYPE CMDTYPE
FROM TLTX T, APPMODULES A, CMDMENU M
WHERE T.direct='N' AND T.TLTXCD LIKE A.TXCODE || '%' AND NOT (A.MODCODE IS NULL)
  AND M.MENUTYPE='T' AND M.MODCODE=A.MODCODE
  --AND T.OVRRQD = 'Y' AND T.VISIBLE = 'Y'
  AND (EXISTS(SELECT TLTXCD FROM CMDMENU CM WHERE CM.tltxcd IS NOT NULL AND INSTR(CM.tltxcd, T.tltxcd) > 0)
   or EXISTS(SELECT TLTXCD FROM CMDMENU CM WHERE CM.tltxcd IS NOT NULL AND INSTR(CM.tltxcd, T.tltxcd) > 0))
UNION ALL
SELECT M.CMDID || '.' || R.RPTID ODRID, R.RPTID CMDID, M.CMDID PRID, R.RPTID ||'-'|| R.DESCRIPTION CMDNAME, R.RPTID ||'-'|| R.EN_DESCRIPTION EN_CMDNAME, 'Y' LAST, M.AUTHCODE, M.LEV + 1 LEV,
        3 IMGINDEX, M.MODCODE, M.OBJNAME, M.MENUTYPE, R.RPTID CMDCODE, R.CMDTYPE CMDTYPE
FROM RPTMASTER R, APPMODULES A, CMDMENU M
WHERE R.MODCODE=M.MODCODE AND R.CMDTYPE='R'
  AND M.MENUTYPE='R' AND M.MODCODE=A.MODCODE
  and r.visible='Y'
UNION ALL
/*SELECT M.CMDID || '.' || R.RPTID ODRID, R.RPTID CMDID, M.CMDID PRID, R.DESCRIPTION CMDNAME, R.EN_DESCRIPTION EN_CMDNAME, 'Y' LAST, M.AUTHCODE, M.LEV + 1 LEV,
        3 IMGINDEX, M.MODCODE, M.OBJNAME, 'G' MENUTYPE, R.RPTID CMDCODE, 'E' CMDTYPE
FROM RPTMASTER R, APPMODULES A, CMDMENU M
WHERE R.MODCODE=M.MODCODE AND R.CMDTYPE='V'
  AND M.MENUTYPE='A' AND M.OBJNAME LIKE '%GENERALVIEW' AND M.MODCODE=A.MODCODE*/
SELECT M.CMDID || '.' || R.RPTID ODRID, R.RPTID /*|| '^' || CASE WHEN SR.TLTXCD IS NULL THEN 'VIEW' ELSE SR.TLTXCD END*/  CMDID,
    M.CMDID PRID,
    R.RPTID ||'-'|| CASE WHEN SR.TLTXCD IS NULL THEN 'VIEW' ELSE SR.TLTXCD END ||': '|| R.DESCRIPTION CMDNAME,
    R.RPTID ||'-'|| CASE WHEN SR.TLTXCD IS NULL THEN 'VIEW' ELSE SR.TLTXCD END ||': '|| R.EN_DESCRIPTION EN_CMDNAME, 'Y' LAST, M.AUTHCODE, M.LEV + 1 LEV,
        3 IMGINDEX, M.MODCODE, M.OBJNAME, 'G' MENUTYPE, R.RPTID || '^' || CASE WHEN SR.TLTXCD IS NULL THEN 'VIEW' ELSE SR.TLTXCD END CMDCODE, 'E' CMDTYPE
FROM RPTMASTER R, APPMODULES A, CMDMENU M, SEARCH SR
WHERE R.MODCODE=M.MODCODE AND R.CMDTYPE IN ('V','D','L') AND SR.SEARCHCODE = R.RPTID
  AND M.MENUTYPE='A' AND M.OBJNAME LIKE '%GENERALVIEW' AND M.MODCODE=A.MODCODE
  and r.visible='Y'
/
DROP VIEW vw_objlog_all
/

CREATE OR REPLACE VIEW vw_objlog_all (
   autoid,
   txnum,
   txdate,
   txtime,
   brid,
   tlid,
   offid,
   ovrrqs,
   chid,
   chkid,
   tltxcd,
   ibt,
   brid2,
   tlid2,
   ccyusage,
   off_line,
   deltd,
   brdate,
   busdate,
   txdesc,
   ipaddress,
   wsname,
   txstatus,
   msgsts,
   ovrsts,
   batchname,
   msgamt,
   msgacct,
   chktime,
   offtime,
   carebygrp,
   reftxnum,
   namenv,
   cfcustodycd,
   createdt,
   cffullname,
   ptxstatus,
   lvel,
   dstatus,
   last_lvel,
   last_dstatus,
   childkey,
   childvalue,
   chiltable,
   parentkey,
   parentvalue,
   parenttable,
   modulcode,
   cmdobjname,
   objtype )
AS
SELECT tllog.autoid,
    tllog.txnum,
    tllog.txdate,
    tllog.txtime,
    tllog.brid,
    tllog.tlid,
    tllog.offid,
    tllog.ovrrqs,
    tllog.chid,
    tllog.chkid,
    tllog.tltxcd,
    tllog.ibt,
    tllog.brid2,
    tllog.tlid2,
    tllog.ccyusage,
    tllog.off_line,
    tllog.deltd,
    tllog.brdate,
    tllog.busdate,
    tllog.txdesc,
    tllog.ipaddress,
    tllog.wsname,
    tllog.txstatus,
    tllog.msgsts,
    tllog.ovrsts,
    tllog.batchname,
    tllog.msgamt,
    tllog.msgacct,
    tllog.chktime,
    tllog.offtime,
    tllog.carebygrp,
    tllog.reftxnum,
    tllog.namenv,
    tllog.cfcustodycd,
    tllog.createdt,
    tllog.cffullname,
    tllog.ptxstatus,
    tllog.lvel,
    tllog.dstatus,
    tllog.last_lvel,
    tllog.last_dstatus,
    '' AS childkey,
    '' AS childvalue,
    '' AS chiltable,
    '' AS parentkey,
    '' AS parentvalue,
    '' AS parenttable,
    '' AS modulcode,
    tllog.cmdobjname,
    'TX' AS objtype
   FROM tllog
UNION
 SELECT objlog.autoid,
    objlog.txnum,
    objlog.txdate,
    objlog.txtime,
    objlog.brid,
    objlog.tlid,
    objlog.offid,
    objlog.ovrrqs,
    objlog.chid,
    objlog.chkid,
    objlog.tltxcd,
    objlog.ibt,
    objlog.brid2,
    objlog.tlid2,
    objlog.ccyusage,
    objlog.off_line,
    objlog.deltd,
    objlog.brdate,
    objlog.busdate,
    objlog.txdesc,
    objlog.ipaddress,
    objlog.wsname,
    objlog.txstatus,
    objlog.msgsts,
    objlog.ovrsts,
    objlog.batchname,
    objlog.msgamt,
    objlog.msgacct,
    objlog.chktime,
    objlog.offtime,
    objlog.carebygrp,
    objlog.reftxnum,
    objlog.namenv,
    objlog.cfcustodycd,
    objlog.createdt,
    objlog.cffullname,
    objlog.ptxstatus,
    objlog.lvel,
    objlog.dstatus,
    objlog.last_lvel,
    objlog.last_dstatus,
    objlog.childkey,
    objlog.childvalue,
    objlog.chiltable,
    objlog.parentkey,
    objlog.parentvalue,
    objlog.parenttable,
    objlog.modulcode,
    objlog.cmdobjname,
    'MT' AS objtype
   FROM objlog
  WHERE objlog.pautoid IS NULL
/
DROP VIEW vw_ratehistory
/

CREATE OR REPLACE VIEW vw_ratehistory (
   symbol,
   effdate,
   expdate,
   rate )
AS
SELECT ad.symbol,
    b.effdate,
    b.expdate,
    a.rate + ad.bien_do AS rate
   FROM ratereference a
     JOIN ( SELECT max(a2.datevali) AS effdate,
            COALESCE(a1.datevali, to_date('20991231', 'YYYYMMDD')) AS expdate
           FROM ratereference a2
             LEFT JOIN ratereference a1 ON a1.datevali > a2.datevali AND a1.status = 'A'
          WHERE a2.status = 'A'
          GROUP BY a1.datevali, (COALESCE(a1.datevali, to_date('20991231', 'YYYYMMDD')))) b ON a.datevali = b.effdate
     JOIN assetdtl ad ON ad.status = 'A' AND ad.intratefltcd = 'Y'
  WHERE a.status = 'A'
/
DROP VIEW vw_reinvest_rate
/

CREATE OR REPLACE VIEW vw_reinvest_rate (
   effdate,
   expdate,
   rate,
   min_month,
   max_month,
   status )
AS
SELECT p.effdate,
    p.expdate,
    p.rate00 AS rate,
    0 AS min_month,
    1 AS max_month,
    p.status
   FROM reinvest_rate p
UNION ALL
 SELECT p.effdate,
    p.expdate,
    p.rate01 AS rate,
    1 AS min_month,
    2 AS max_month,
    p.status
   FROM reinvest_rate p
UNION ALL
 SELECT p.effdate,
    p.expdate,
    p.rate02 AS rate,
    2 AS min_month,
    3 AS max_month,
    p.status
   FROM reinvest_rate p
UNION ALL
 SELECT p.effdate,
    p.expdate,
    p.rate03 AS rate,
    3 AS min_month,
    4 AS max_month,
    p.status
   FROM reinvest_rate p
UNION ALL
 SELECT p.effdate,
    p.expdate,
    p.rate04 AS rate,
    4 AS min_month,
    5 AS max_month,
    p.status
   FROM reinvest_rate p
UNION ALL
 SELECT p.effdate,
    p.expdate,
    p.rate05 AS rate,
    5 AS min_month,
    6 AS max_month,
    p.status
   FROM reinvest_rate p
UNION ALL
 SELECT p.effdate,
    p.expdate,
    p.rate06 AS rate,
    6 AS min_month,
    7 AS max_month,
    p.status
   FROM reinvest_rate p
UNION ALL
 SELECT p.effdate,
    p.expdate,
    p.rate07 AS rate,
    7 AS min_month,
    8 AS max_month,
    p.status
   FROM reinvest_rate p
UNION ALL
 SELECT p.effdate,
    p.expdate,
    p.rate08 AS rate,
    8 AS min_month,
    9 AS max_month,
    p.status
   FROM reinvest_rate p
UNION ALL
 SELECT p.effdate,
    p.expdate,
    p.rate09 AS rate,
    9 AS min_month,
    10 AS max_month,
    p.status
   FROM reinvest_rate p
UNION ALL
 SELECT p.effdate,
    p.expdate,
    p.rate10 AS rate,
    10 AS min_month,
    11 AS max_month,
    p.status
   FROM reinvest_rate p
UNION ALL
 SELECT p.effdate,
    p.expdate,
    p.rate11 AS rate,
    11 AS min_month,
    12 AS max_month,
    p.status
   FROM reinvest_rate p
UNION ALL
 SELECT p.effdate,
    p.expdate,
    p.rate12 AS rate,
    12 AS min_month,
    13 AS max_month,
    p.status
   FROM reinvest_rate p
UNION ALL
 SELECT p.effdate,
    p.expdate,
    p.rate13 AS rate,
    13 AS min_month,
    14 AS max_month,
    p.status
   FROM reinvest_rate p
UNION ALL
 SELECT p.effdate,
    p.expdate,
    p.rate14 AS rate,
    14 AS min_month,
    15 AS max_month,
    p.status
   FROM reinvest_rate p
UNION ALL
 SELECT p.effdate,
    p.expdate,
    p.rate15 AS rate,
    15 AS min_month,
    16 AS max_month,
    p.status
   FROM reinvest_rate p
UNION ALL
 SELECT p.effdate,
    p.expdate,
    p.rate16 AS rate,
    16 AS min_month,
    9999 AS max_month,
    p.status
   FROM reinvest_rate p
/
DROP VIEW vw_setran_gen
/

CREATE OR REPLACE VIEW vw_setran_gen (
   autoid,
   custodycd,
   custid,
   txnum,
   txdate,
   acctno,
   txcd,
   namt,
   camt,
   ref,
   deltd,
   acctref,
   tltxcd,
   busdate,
   txdesc,
   txtime,
   brid,
   tlid,
   offid,
   chid,
   afacctno,
   symbol,
   txtype,
   field,
   codeid,
   tllog_autoid,
   trdesc,
   vermatching,
   sessionno,
   orderid,
   feeid )
AS
select tr.autoid, cf.custodycd, cf.custid, tr.txnum, tr.txdate, tr.acctno, tr.txcd, tr.namt, tr.camt, tr.ref, tr.deltd, tr.acctref,
    tl.tltxcd, tl.busdate,
    txdesc,
    tl.txtime, tl.brid, tl.tlid, tl.offid, tl.chid,
    se.afacctno, f.symbol,  ap.txtype, ap.field, f.codeid, tl.autoid tllog_autoid,
    trdesc, tr.vermatching, TR.SESSIONNO, null ORDERID, NULL FEEID
from setran tr, tllog tl, fund f, semast se, cfmast cf, apptx ap
where tr.txdate = tl.txdate and tr.txnum = tl.txnum
    and tr.acctno = se.acctno
    and f.codeid = se.codeid
    and se.custodycd = cf.custodycd
    and tr.txcd = ap.txcd and ap.apptype = 'SE' and ap.txtype in ('D','C')
    and tr.namt <> 0
union all
select AUTOID,CUSTODYCD,CUSTID,TXNUM,TXDATE,ACCTNO,TXCD,NAMT,CAMT,REF,DELTD,ACCTREF,TLTXCD,BUSDATE,TXDESC,TXTIME,BRID,TLID,OFFID,CHID,AFACCTNO,SYMBOL,TXTYPE,FIELD,CODEID, TLLOG_AUTOID, TRDESC,
VERMATCHING, SESSIONNO, NULL ORDERID, NULL FEEID
from setran_gen
/
DROP VIEW vw_tllog_all
/

CREATE OR REPLACE VIEW vw_tllog_all (
   autoid,
   txnum,
   txdate,
   txtime,
   brid,
   tlid,
   offid,
   ovrrqs,
   chid,
   chkid,
   tltxcd,
   ibt,
   brid2,
   tlid2,
   ccyusage,
   off_line,
   deltd,
   brdate,
   busdate,
   txdesc,
   ipaddress,
   wsname,
   txstatus,
   msgsts,
   ovrsts,
   batchname,
   msgamt,
   msgacct,
   chktime,
   offtime,
   carebygrp,
   cfcustodycd,
   cffullname )
AS
select "AUTOID","TXNUM","TXDATE","TXTIME","BRID","TLID","OFFID","OVRRQS","CHID","CHKID","TLTXCD","IBT","BRID2","TLID2","CCYUSAGE","OFF_LINE","DELTD","BRDATE","BUSDATE","TXDESC","IPADDRESS","WSNAME","TXSTATUS","MSGSTS","OVRSTS","BATCHNAME","MSGAMT","MSGACCT","CHKTIME","OFFTIME","CAREBYGRP","CFCUSTODYCD","CFFULLNAME" from tllog where deltd <> 'Y'
union all
select "AUTOID","TXNUM","TXDATE","TXTIME","BRID","TLID","OFFID","OVRRQS","CHID","CHKID","TLTXCD","IBT","BRID2","TLID2","CCYUSAGE","OFF_LINE","DELTD","BRDATE","BUSDATE","TXDESC","IPADDRESS","WSNAME","TXSTATUS","MSGSTS","OVRSTS","BATCHNAME","MSGAMT","MSGACCT","CHKTIME","OFFTIME","CAREBYGRP","CFCUSTODYCD","CFFULLNAME" from tllogall where deltd <> 'Y'
/
DROP VIEW vw_tllogfld_all
/

CREATE OR REPLACE VIEW vw_tllogfld_all (
   autoid,
   txnum,
   txdate,
   fldcd,
   nvalue,
   cvalue,
   txdesc )
AS
select "AUTOID","TXNUM","TXDATE","FLDCD","NVALUE","CVALUE","TXDESC" from tllogfld 
union all
select "AUTOID","TXNUM","TXDATE","FLDCD","NVALUE","CVALUE","TXDESC" from tllogfldall
/
DROP VIEW vw_tradingsession
/

CREATE OR REPLACE VIEW vw_tradingsession (
   tradingid,
   codeid,
   tradingdate,
   matchdate,
   execdateccq,
   execdatecash,
   txdate,
   enav,
   nav,
   buyamt,
   tradingstatus,
   lastchange,
   clsorddate,
   sip,
   tradingtype,
   vermatching,
   totalenav,
   totalnav )
AS
SELECT tradingsession.tradingid,
    tradingsession.codeid,
    tradingsession.tradingdate,
    tradingsession.matchdate,
    tradingsession.execdateccq,
    tradingsession.execdatecash,
    tradingsession.txdate,
    tradingsession.enav,
    tradingsession.nav,
    tradingsession.buyamt,
    tradingsession.tradingstatus,
    tradingsession.lastchange,
    tradingsession.clsorddate,
    tradingsession.sip,
    tradingsession.tradingtype,
    tradingsession.vermatching,
    tradingsession.totalenav,
    tradingsession.totalnav
   FROM tradingsession
UNION ALL
 SELECT tradingsessionhist.tradingid,
    tradingsessionhist.codeid,
    tradingsessionhist.tradingdate,
    tradingsessionhist.matchdate,
    tradingsessionhist.execdateccq,
    tradingsessionhist.execdatecash,
    tradingsessionhist.txdate,
    tradingsessionhist.enav,
    tradingsessionhist.nav,
    tradingsessionhist.buyamt,
    tradingsessionhist.tradingstatus,
    tradingsessionhist.lastchange,
    tradingsessionhist.clsorddate,
    tradingsessionhist.sip,
    tradingsessionhist.tradingtype,
    tradingsessionhist.vermatching,
    tradingsessionhist.totalenav,
    tradingsessionhist.totalnav
   FROM tradingsessionhist
/
