DROP PACKAGE txpks_#ca_camast
/

CREATE OR REPLACE 
PACKAGE txpks_#ca_camast 
/** ----------------------------------------------------------------------------------------------------
 dung cho form maintenance
 ----------------------------------------------------------------------------------------------------*/
IS

FUNCTION fn_Transfer(p_xmlmsg in out varchar2,p_err_code in out varchar2,p_err_param out varchar2)
RETURN NUMBER;
FUNCTION fn_Add(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Edit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Delete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Adhoc(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Approve(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Reject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;

--rieng
FUNCTION fn_CheckBeforeAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;

END;
/

CREATE OR REPLACE 
PACKAGE BODY txpks_#ca_camast 
IS
   pkgctx   plog.log_ctx;
   logrow   tlogdebug%ROWTYPE;

FUNCTION fn_Transfer(p_xmlmsg in out varchar2,p_err_code in out varchar2,p_err_param out varchar2)
RETURN NUMBER
IS
   l_return_code VARCHAR2(30) := systemnums.C_SUCCESS;
   l_objmsg tx.obj_rectype;
   l_count NUMBER(3);
   l_msgtype VARCHAR2(10);
   l_objname VARCHAR2(100);
   l_actionflag varchar2(100);
   l_currdate varchar2(10);
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Transfer');
   plog.debug(pkgctx, 'fn_Transfer');
   --get object
   l_objmsg:= txpks_msg.fn_mt_xml2obj(p_xmlmsg);
   l_msgtype:= l_objmsg.MSGTYPE;
   l_objname:= l_objmsg.OBJNAME;
   l_actionflag:= l_objmsg.ACTIONFLAG;
   --Kiem tra msgtype de phan luong xu ly
   IF l_actionflag ='ADD' THEN
        IF fn_Add(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;
   ELSIF l_actionflag ='EDIT' THEN
        IF fn_Edit(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;

   ELSIF l_actionflag ='DELETE' THEN
        IF fn_Delete(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;
   ELSIF l_actionflag ='ADHOC' THEN
        IF fn_Adhoc(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;
   ELSIF l_actionflag ='APPROVE' THEN
        IF fn_Approve(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;
   ELSIF l_actionflag ='REJECT' THEN
        IF fn_Reject(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;
   END IF;

   plog.debug(pkgctx, 'fn_Transfer');
   plog.setendsection (pkgctx, 'fn_Transfer');
   RETURN l_return_code;
EXCEPTION
WHEN errnums.E_BIZ_RULE_INVALID
   THEN
      FOR I IN (
           SELECT ERRDESC,EN_ERRDESC FROM deferror
           WHERE ERRNUM= p_err_code
      ) LOOP
           p_err_param := i.errdesc;
      END LOOP;
      p_xmlmsg := txpks_msg.fn_mt_obj2xml(l_objmsg);
      plog.setendsection (pkgctx, 'fn_Transfer');
      ROLLBACK;
      RETURN errnums.C_BIZ_RULE_INVALID;
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      p_err_param := 'SYSTEM_ERROR';
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      p_xmlmsg := txpks_msg.fn_mt_obj2xml(l_objmsg);
      plog.setendsection (pkgctx, 'fn_Transfer');
      RETURN errnums.C_SYSTEM_ERROR;
END fn_Transfer;

FUNCTION fn_Add(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Add');
-- Check befor add
   IF txpks_#ca_CAMAST.fn_CheckBeforeAdd(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- Auto add
   IF txpks_maintain.fn_ProcessAdd(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- After Add
   IF txpks_#ca_CAMAST.fn_ProcessAfterAdd(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
--ghi log
   IF txpks_maintain.fn_MaintainLog(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   plog.setendsection (pkgctx, 'fn_Add');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Add');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Add;

FUNCTION fn_Edit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Edit');
-- Check befor edit
   IF txpks_#ca_CAMAST.fn_CheckBeforeEdit(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- Auto Edit
   IF txpks_maintain.fn_ProcessEdit(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- After Edit
   IF txpks_#ca_CAMAST.fn_ProcessAfterEdit(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   --ghi log
   IF txpks_maintain.fn_MaintainLog(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   plog.setendsection (pkgctx, 'fn_Edit');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Edit');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Edit;

FUNCTION fn_Delete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Delete');
-- Check befor Delete
   IF txpks_#ca_CAMAST.fn_CheckBeforeDelete(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- Auto Delete
   IF txpks_maintain.fn_ProcessDelete(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- After Delete
   IF txpks_#ca_CAMAST.fn_ProcessAfterDelete(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   --ghi log
   IF txpks_maintain.fn_MaintainLog(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   plog.setendsection (pkgctx, 'fn_Delete');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Delete');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Delete;

FUNCTION fn_Adhoc(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Adhoc');

   plog.setendsection (pkgctx, 'fn_Adhoc');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Adhoc');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Adhoc;

FUNCTION fn_Approve(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Approve');

  IF txpks_maintain.fn_Approve(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;

   plog.setendsection (pkgctx, 'fn_Approve');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Approve');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Approve;

FUNCTION fn_Reject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.error (pkgctx, 'fn_Reject test');

    IF txpks_maintain.fn_Reject(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;

   plog.setendsection (pkgctx, 'fn_Reject');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Reject');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Reject;


FUNCTION fn_CheckBeforeAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
    V_COUNT NUMBER;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_CheckBeforeAdd');
    if (p_objmsg.OBJFIELDS('CATYPE').value in ('005','011')   and (p_objmsg.OBJFIELDS('DEVIDENTSHARES').value is null )) then -- Tien
       p_err_code := '-800010';
       plog.setendsection (pkgctx, 'fn_txPreAppCheck');
       RETURN errnums.C_BIZ_RULE_INVALID;
    end if; --DEVIDENTSHARES
    if (p_objmsg.OBJFIELDS('CATYPE').value = '010' and (p_objmsg.OBJFIELDS('DEVIDENTRATE').value = 0 )) then -- Tien
       p_err_code := '-800011';
       plog.setendsection (pkgctx, 'fn_txPreAppCheck');
       RETURN errnums.C_BIZ_RULE_INVALID;
    end if; --DEVIDENTSHARES
     if (p_objmsg.OBJFIELDS('CATYPE').value = '010' and (p_objmsg.OBJFIELDS('PARVALUE').value = 0 )) then -- Tien
       p_err_code := '-800012';
       plog.setendsection (pkgctx, 'fn_txPreAppCheck');
       RETURN errnums.C_BIZ_RULE_INVALID;
    end if; --DEVIDENTSHARES

    if (p_objmsg.OBJFIELDS('CATYPE').value = '010' and (p_objmsg.OBJFIELDS('DEVIDENTRATE').value <0 )) then -- Tien
       p_err_code := '-800001';
       plog.setendsection (pkgctx, 'fn_txPreAppCheck');
       RETURN errnums.C_BIZ_RULE_INVALID;
    end if; --DEVIDENTSHARES
     if (p_objmsg.OBJFIELDS('CATYPE').value = '010' and (p_objmsg.OBJFIELDS('TAXRATE').value <0  or p_objmsg.OBJFIELDS('TAXRATE').value >100) ) then -- Tien
       p_err_code := '-800006';
       plog.setendsection (pkgctx, 'fn_txPreAppCheck');
       RETURN errnums.C_BIZ_RULE_INVALID;
    end if; --DEVIDENTSHARES
    if (p_objmsg.OBJFIELDS('CATYPE').value = '010' and (p_objmsg.OBJFIELDS('PARVALUE').value <0 )) then -- Tien
       p_err_code := '-800007';
       plog.setendsection (pkgctx, 'fn_txPreAppCheck');
       RETURN errnums.C_BIZ_RULE_INVALID;
    end if; --DEVIDENTSHARES
    if ((p_objmsg.OBJFIELDS('CATYPE').value = '011' or p_objmsg.OBJFIELDS('CATYPE').value = '005') and
      (isnumber(substr(p_objmsg.OBJFIELDS('DEVIDENTSHARES').value,0,instr(p_objmsg.OBJFIELDS('DEVIDENTSHARES').value,'/')-1)) = 'N' OR
      isnumber(substr(p_objmsg.OBJFIELDS('DEVIDENTSHARES').value,instr(p_objmsg.OBJFIELDS('DEVIDENTSHARES').value,'/')+1)) = 'N' )) then -- ccq
        p_err_code := '-800002';
        plog.setendsection (pkgctx, 'fn_txPreAppCheck');
       RETURN errnums.C_BIZ_RULE_INVALID;
    end if;
   IF to_date(p_objmsg.OBJFIELDS('REPORTDATE').value,'dd/MM/rrrr') > to_date(p_objmsg.OBJFIELDS('ACTIONDATE').value,'dd/MM/rrrr') THEN
       p_err_code := '-800003';
       plog.setendsection (pkgctx, 'fn_txPreAppCheck');
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
      -- quyen dai hoi nha dau tu khong check ngay nghi
   IF fn_getholiday(p_objmsg.OBJFIELDS('REPORTDATE').value,'000') = 'Y' and p_objmsg.OBJFIELDS('CATYPE').value <> '005' THEN
       p_err_code := '-800008';
       plog.setendsection (pkgctx, 'fn_txPreAppCheck');
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   IF fn_getholiday(p_objmsg.OBJFIELDS('ACTIONDATE').value,'000') = 'Y' and p_objmsg.OBJFIELDS('CATYPE').value <> '005' THEN
       p_err_code := '-800009';
       plog.setendsection (pkgctx, 'fn_txPreAppCheck');
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   /* select COUNT(1) INTO V_COUNT from TAXRATE B
    WHERE upper(B.TYPECF) = upper(p_objmsg.OBJFIELDS('TYPECF').value);
    --AND b.status = 'A';
    IF V_COUNT > 0 THEN
       p_err_code := '-112222';
       plog.setendsection (pkgctx, 'fn_txPreAppCheck');
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;*/

    plog.setendsection (pkgctx, 'fn_CheckBeforeAdd');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_CheckBeforeAdd');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_CheckBeforeAdd;

FUNCTION fn_ProcessAfterAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_ProcessAfterAdd');

    plog.setendsection (pkgctx, 'fn_ProcessAfterAdd');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessAfterAdd');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessAfterAdd;

FUNCTION fn_CheckBeforeEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN

    if (p_objmsg.OBJFIELDS('CATYPE').value in ('005','011')   and (p_objmsg.OBJFIELDS('DEVIDENTSHARES').value is null )) then -- Tien
       p_err_code := '-800010';
       plog.setendsection (pkgctx, 'fn_txPreAppCheck');
       RETURN errnums.C_BIZ_RULE_INVALID;
    end if; --DEVIDENTSHARES
    if (p_objmsg.OBJFIELDS('CATYPE').value = '010' and (p_objmsg.OBJFIELDS('DEVIDENTRATE').value = 0 )) then -- Tien
       p_err_code := '-800011';
       plog.setendsection (pkgctx, 'fn_txPreAppCheck');
       RETURN errnums.C_BIZ_RULE_INVALID;
    end if; --DEVIDENTSHARES
     if (p_objmsg.OBJFIELDS('CATYPE').value = '010' and (p_objmsg.OBJFIELDS('PARVALUE').value = 0 )) then -- Tien
       p_err_code := '-800012';
       plog.setendsection (pkgctx, 'fn_txPreAppCheck');
       RETURN errnums.C_BIZ_RULE_INVALID;
    end if; --DEVIDENTSHARES
    if (p_objmsg.OBJFIELDS('CATYPE').value = '010' and (p_objmsg.OBJFIELDS('DEVIDENTRATE').value <0) ) then -- Tien
       p_err_code := '-800001';
       plog.setendsection (pkgctx, 'fn_txPreAppCheck');
       RETURN errnums.C_BIZ_RULE_INVALID;
    end if; --DEVIDENTSHARES
    if (p_objmsg.OBJFIELDS('CATYPE').value = '011' and
      (isnumber(substr(p_objmsg.OBJFIELDS('DEVIDENTSHARES').value,0,instr(p_objmsg.OBJFIELDS('DEVIDENTSHARES').value,'/')-1)) = 'N' OR
      isnumber(substr(p_objmsg.OBJFIELDS('DEVIDENTSHARES').value,instr(p_objmsg.OBJFIELDS('DEVIDENTSHARES').value,'/')+1)) = 'N' )) then -- ccq
        p_err_code := '-800002';
        plog.setendsection (pkgctx, 'fn_txPreAppCheck');
       RETURN errnums.C_BIZ_RULE_INVALID;
    end if;
     if (p_objmsg.OBJFIELDS('CATYPE').value = '010' and (p_objmsg.OBJFIELDS('TAXRATE').value <0  or p_objmsg.OBJFIELDS('TAXRATE').value >100)) then -- Tien
       p_err_code := '-800006';
       plog.setendsection (pkgctx, 'fn_txPreAppCheck');
       RETURN errnums.C_BIZ_RULE_INVALID;
    end if; --DEVIDENTSHARES
    if (p_objmsg.OBJFIELDS('CATYPE').value = '010' and (p_objmsg.OBJFIELDS('PARVALUE').value <0  )) then -- Tien
       p_err_code := '-800007';
       plog.setendsection (pkgctx, 'fn_txPreAppCheck');
       RETURN errnums.C_BIZ_RULE_INVALID;
    end if; --DEVIDENTSHARES
   IF to_date(p_objmsg.OBJFIELDS('REPORTDATE').value,'dd/MM/rrrr') > to_date(p_objmsg.OBJFIELDS('ACTIONDATE').value,'dd/MM/rrrr') THEN
       p_err_code := '-800003';
       plog.setendsection (pkgctx, 'fn_txPreAppCheck');
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   IF fn_getholiday(p_objmsg.OBJFIELDS('REPORTDATE').value,'000') = 'Y' and p_objmsg.OBJFIELDS('CATYPE').value <> '005' THEN
       p_err_code := '-800008';
       plog.setendsection (pkgctx, 'fn_txPreAppCheck');
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   IF fn_getholiday(p_objmsg.OBJFIELDS('ACTIONDATE').value,'000') = 'Y' and p_objmsg.OBJFIELDS('CATYPE').value <> '005' THEN
       p_err_code := '-800009';
       plog.setendsection (pkgctx, 'fn_txPreAppCheck');
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
    plog.setbeginsection (pkgctx, 'fn_CheckBeforeEdit');
    plog.setendsection (pkgctx, 'fn_CheckBeforeEdit');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_CheckBeforeEdit');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_CheckBeforeEdit;

FUNCTION fn_ProcessAfterEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_ProcessAfterEdit');

    plog.setendsection (pkgctx, 'fn_ProcessAfterEdit');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessAfterEdit');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessAfterEdit;

FUNCTION fn_CheckBeforeDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    v_count number;
    v_strParentClause varchar2(100);
    v_strRecord_Key varchar2(100);
    v_strRecord_Value varchar2(100);
    v_codeid varchar2(100);
BEGIN
    plog.setbeginsection (pkgctx, 'fn_CheckBeforeDelete');
   v_strParentClause := p_objmsg.CLAUSE;
       IF  length(v_strParentClause) <> 0 THEN
        v_strRecord_Key := Trim(substr(v_strParentClause,1, InStr(v_strParentClause, '=')-1));
        v_strRecord_Value := Trim(substr(v_strParentClause,InStr(v_strParentClause, '=') +1));
        v_strRecord_Value := REPLACE(v_strRecord_Value,'''','');
       end if;
   select count(1) INTO v_count from camast ca where
   ca.camastid = v_strRecord_Value
   and ca.status IN ('P','A');
   if (v_count <= 0) then --
       p_err_code := '-800004';
       plog.setendsection (pkgctx, 'fn_txPreAppCheck');
       RETURN errnums.C_BIZ_RULE_INVALID;
   end if;
    plog.setendsection (pkgctx, 'fn_CheckBeforeDelete');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_CheckBeforeDelete');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_CheckBeforeDelete;

FUNCTION fn_ProcessAfterDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_ProcessAfterDelete');

    plog.setendsection (pkgctx, 'fn_ProcessAfterDelete');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessAfterDelete');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessAfterDelete;

FUNCTION fn_CheckBeforeApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_CheckBeforeApprove');

    plog.setendsection (pkgctx, 'fn_CheckBeforeApprove');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_CheckBeforeApprove');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_CheckBeforeApprove;

FUNCTION fn_ProcessAfterApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_ProcessAfterApprove');

    plog.setendsection (pkgctx, 'fn_ProcessAfterApprove');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessAfterApprove');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessAfterApprove;

FUNCTION fn_CheckBeforeReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_CheckBeforeReject');

    plog.setendsection (pkgctx, 'fn_CheckBeforeReject');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_CheckBeforeReject');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_CheckBeforeReject;

FUNCTION fn_ProcessAfterReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_ProcessAfterReject');

    plog.setendsection (pkgctx, 'fn_ProcessAfterReject');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessAfterReject');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessAfterReject;

BEGIN
      FOR i IN (SELECT *
                FROM tlogdebug)
      LOOP
         logrow.loglevel    := i.loglevel;
         logrow.log4table   := i.log4table;
         logrow.log4alert   := i.log4alert;
         logrow.log4trace   := i.log4trace;
      END LOOP;
      pkgctx    :=
         plog.init ('txpks_#sa.funddtl',
                    plevel => NVL(logrow.loglevel,30),
                    plogtable => (NVL(logrow.log4table,'N') = 'Y'),
                    palert => (NVL(logrow.log4alert,'N') = 'Y'),
                    ptrace => (NVL(logrow.log4trace,'N') = 'Y')
            );
END txpks_#ca_CAMAST;
/

DROP PACKAGE txpks_#cf_cfauth
/

CREATE OR REPLACE 
PACKAGE txpks_#cf_cfauth 
/** ----------------------------------------------------------------------------------------------------
 dung cho form maintenance
 ----------------------------------------------------------------------------------------------------*/
IS

FUNCTION fn_Transfer(p_xmlmsg in out varchar2,p_err_code in out varchar2,p_err_param out varchar2)
RETURN NUMBER;
FUNCTION fn_Add(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Edit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Delete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Adhoc(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Approve(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Reject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;

--rieng
FUNCTION fn_CheckBeforeAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;

END;
/

CREATE OR REPLACE 
PACKAGE BODY txpks_#cf_cfauth 
IS
   pkgctx   plog.log_ctx;
   logrow   tlogdebug%ROWTYPE;

FUNCTION fn_Transfer(p_xmlmsg in out varchar2,p_err_code in out varchar2,p_err_param out varchar2)
RETURN NUMBER
IS
   l_return_code VARCHAR2(30) := systemnums.C_SUCCESS;
   l_objmsg tx.obj_rectype;
   l_count NUMBER(3);
   l_msgtype VARCHAR2(10);
   l_objname VARCHAR2(100);
   l_actionflag varchar2(100);
   l_currdate varchar2(10);
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Transfer');
   plog.debug(pkgctx, 'fn_Transfer');
   --get object
   l_objmsg:= txpks_msg.fn_mt_xml2obj(p_xmlmsg);
   l_msgtype:= l_objmsg.MSGTYPE;
   l_objname:= l_objmsg.OBJNAME;
   l_actionflag:= l_objmsg.ACTIONFLAG;
   --Kiem tra msgtype de phan luong xu ly
   IF l_actionflag ='ADD' THEN
        IF fn_Add(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;
   ELSIF l_actionflag ='EDIT' THEN
        IF fn_Edit(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;

   ELSIF l_actionflag ='DELETE' THEN
        IF fn_Delete(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;
   ELSIF l_actionflag ='ADHOC' THEN
        IF fn_Adhoc(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;
   ELSIF l_actionflag ='APPROVE' THEN
        IF fn_Approve(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;
   ELSIF l_actionflag ='REJECT' THEN
        IF fn_Reject(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;
   END IF;

   plog.debug(pkgctx, 'fn_Transfer');
   plog.setendsection (pkgctx, 'fn_Transfer');
   RETURN l_return_code;
EXCEPTION
WHEN errnums.E_BIZ_RULE_INVALID
   THEN
      FOR I IN (
           SELECT ERRDESC,EN_ERRDESC FROM deferror
           WHERE ERRNUM= p_err_code
      ) LOOP
           p_err_param := i.errdesc;
      END LOOP;
      p_xmlmsg := txpks_msg.fn_mt_obj2xml(l_objmsg);
      plog.setendsection (pkgctx, 'fn_Transfer');
      ROLLBACK;
      RETURN errnums.C_BIZ_RULE_INVALID;
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      p_err_param := 'SYSTEM_ERROR';
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      p_xmlmsg := txpks_msg.fn_mt_obj2xml(l_objmsg);
      plog.setendsection (pkgctx, 'fn_Transfer');
      RETURN errnums.C_SYSTEM_ERROR;
END fn_Transfer;

FUNCTION fn_Add(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Add');
-- Check befor add
   IF txpks_#cf_cfauth.fn_CheckBeforeAdd(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- Auto add
   IF txpks_maintain.fn_ProcessAdd(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- After Add
   IF txpks_#cf_cfauth.fn_ProcessAfterAdd(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
--ghi log
   IF txpks_maintain.fn_MaintainLog(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   plog.setendsection (pkgctx, 'fn_Add');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Add');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Add;

FUNCTION fn_Edit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Edit');
-- Check befor edit
   IF txpks_#cf_cfauth.fn_CheckBeforeEdit(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- Auto Edit
   IF txpks_maintain.fn_ProcessEdit(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- After Edit
   IF txpks_#cf_cfauth.fn_ProcessAfterEdit(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   --ghi log
   IF txpks_maintain.fn_MaintainLog(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   plog.setendsection (pkgctx, 'fn_Edit');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Edit');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Edit;

FUNCTION fn_Delete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Delete');
-- Check befor Delete
   IF txpks_#cf_cfauth.fn_CheckBeforeDelete(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- Auto Delete
   IF txpks_maintain.fn_ProcessDelete(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- After Delete
   IF txpks_#cf_cfauth.fn_ProcessAfterDelete(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   --ghi log
   IF txpks_maintain.fn_MaintainLog(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   plog.setendsection (pkgctx, 'fn_Delete');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Delete');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Delete;

FUNCTION fn_Adhoc(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Adhoc');

   plog.setendsection (pkgctx, 'fn_Adhoc');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Adhoc');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Adhoc;

FUNCTION fn_Approve(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Approve');
   IF txpks_maintain.fn_Approve(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   plog.setendsection (pkgctx, 'fn_Approve');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Approve');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Approve;

FUNCTION fn_Reject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Reject');

   IF txpks_maintain.fn_Reject(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;

   plog.setendsection (pkgctx, 'fn_Reject');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Reject');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Reject;


FUNCTION fn_CheckBeforeAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
   plog.setbeginsection (pkgctx, 'fn_CheckBeforeAdd');
   --Kiem tra cmnd khong duoc trung
   SELECT COUNT(IDCODE) INTO l_count FROM CFAUTH WHERE CUSTID = p_objmsg.OBJFIELDS('CUSTID').value
   AND IDCODE = p_objmsg.OBJFIELDS('IDCODE').value  And STATUS <> 'C';

   IF l_count >0 THEN
        p_err_code := '-200001';
        plog.setendsection (pkgctx, 'fn_CheckBeforeAdd');
        RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   --Check ngay hieu luc phai lon hon ngay hien tai
   IF to_date(p_objmsg.OBJFIELDS('EXDATE').value,systemnums.C_DATE_FORMAT) < getcurrdate THEN
        p_err_code := '-200001';
        plog.setendsection (pkgctx, 'fn_CheckBeforeAdd');
        RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;

    plog.setendsection (pkgctx, 'fn_CheckBeforeAdd');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_CheckBeforeAdd');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_CheckBeforeAdd;

FUNCTION fn_ProcessAfterAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_ProcessAfterAdd');

    plog.setendsection (pkgctx, 'fn_ProcessAfterAdd');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessAfterAdd');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessAfterAdd;

FUNCTION fn_CheckBeforeEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_CheckBeforeEdit');

    plog.setendsection (pkgctx, 'fn_CheckBeforeEdit');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_CheckBeforeEdit');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_CheckBeforeEdit;

FUNCTION fn_ProcessAfterEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_ProcessAfterEdit');

    plog.setendsection (pkgctx, 'fn_ProcessAfterEdit');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessAfterEdit');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessAfterEdit;

FUNCTION fn_CheckBeforeDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_CheckBeforeDelete');

    plog.setendsection (pkgctx, 'fn_CheckBeforeDelete');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_CheckBeforeDelete');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_CheckBeforeDelete;

FUNCTION fn_ProcessAfterDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_ProcessAfterDelete');

    plog.setendsection (pkgctx, 'fn_ProcessAfterDelete');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessAfterDelete');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessAfterDelete;

FUNCTION fn_CheckBeforeApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_CheckBeforeApprove');

    plog.setendsection (pkgctx, 'fn_CheckBeforeApprove');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_CheckBeforeApprove');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_CheckBeforeApprove;

FUNCTION fn_ProcessAfterApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_ProcessAfterApprove');

    plog.setendsection (pkgctx, 'fn_ProcessAfterApprove');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessAfterApprove');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessAfterApprove;

FUNCTION fn_CheckBeforeReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_CheckBeforeReject');

    plog.setendsection (pkgctx, 'fn_CheckBeforeReject');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_CheckBeforeReject');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_CheckBeforeReject;

FUNCTION fn_ProcessAfterReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_ProcessAfterReject');

    plog.setendsection (pkgctx, 'fn_ProcessAfterReject');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessAfterReject');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessAfterReject;

BEGIN
      FOR i IN (SELECT *
                FROM tlogdebug)
      LOOP
         logrow.loglevel    := i.loglevel;
         logrow.log4table   := i.log4table;
         logrow.log4alert   := i.log4alert;
         logrow.log4trace   := i.log4trace;
      END LOOP;
      pkgctx    :=
         plog.init ('txpks_#cf.cfauth',
                    plevel => NVL(logrow.loglevel,30),
                    plogtable => (NVL(logrow.log4table,'N') = 'Y'),
                    palert => (NVL(logrow.log4alert,'N') = 'Y'),
                    ptrace => (NVL(logrow.log4trace,'N') = 'Y')
            );
END txpks_#cf_cfauth;
/

DROP PACKAGE txpks_#cf_cfmast
/

CREATE OR REPLACE 
PACKAGE txpks_#cf_cfmast 
/** ----------------------------------------------------------------------------------------------------
 dung cho form maintenance
 ----------------------------------------------------------------------------------------------------*/
IS

FUNCTION fn_Transfer(p_xmlmsg in out varchar2,p_err_code in out varchar2,p_err_param out varchar2)
RETURN NUMBER;
FUNCTION fn_Add(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Edit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Delete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Adhoc(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Approve(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Reject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;

--rieng
FUNCTION fn_CheckBeforeAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;

END;
/

DROP PACKAGE txpks_#cf_fatca
/

CREATE OR REPLACE 
PACKAGE txpks_#cf_fatca 
/** ----------------------------------------------------------------------------------------------------
 dung cho form maintenance
 ----------------------------------------------------------------------------------------------------*/
IS

FUNCTION fn_Transfer(p_xmlmsg in out varchar2,p_err_code in out varchar2,p_err_param out varchar2)
RETURN NUMBER;
FUNCTION fn_Add(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Edit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Delete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Adhoc(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Approve(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Reject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;

--rieng
FUNCTION fn_CheckBeforeAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;

END;
/

CREATE OR REPLACE 
PACKAGE BODY txpks_#cf_fatca 
IS
   pkgctx   plog.log_ctx;
   logrow   tlogdebug%ROWTYPE;

FUNCTION fn_Transfer(p_xmlmsg in out varchar2,p_err_code in out varchar2,p_err_param out varchar2)
RETURN NUMBER
IS
   l_return_code VARCHAR2(30) := systemnums.C_SUCCESS;
   l_objmsg tx.obj_rectype;
   l_count NUMBER(3);
   l_msgtype VARCHAR2(10);
   l_objname VARCHAR2(100);
   l_actionflag varchar2(100);
   l_currdate varchar2(10);
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Transfer');
   plog.debug(pkgctx, 'fn_Transfer');
   --get object
   l_objmsg:= txpks_msg.fn_mt_xml2obj(p_xmlmsg);
   l_msgtype:= l_objmsg.MSGTYPE;
   l_objname:= l_objmsg.OBJNAME;
   l_actionflag:= l_objmsg.ACTIONFLAG;
   --Kiem tra msgtype de phan luong xu ly
   IF l_actionflag ='ADD' THEN
        IF fn_Add(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;
   ELSIF l_actionflag ='EDIT' THEN
        IF fn_Edit(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;

   ELSIF l_actionflag ='DELETE' THEN
        IF fn_Delete(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;
   ELSIF l_actionflag ='ADHOC' THEN
        IF fn_Adhoc(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;
   ELSIF l_actionflag ='APPROVE' THEN
        IF fn_Approve(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;
   ELSIF l_actionflag ='REJECT' THEN
        IF fn_Reject(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;
   END IF;

   plog.debug(pkgctx, 'fn_Transfer');
   plog.setendsection (pkgctx, 'fn_Transfer');
   RETURN l_return_code;
EXCEPTION
WHEN errnums.E_BIZ_RULE_INVALID
   THEN
      FOR I IN (
           SELECT ERRDESC,EN_ERRDESC FROM deferror
           WHERE ERRNUM= p_err_code
      ) LOOP
           p_err_param := i.errdesc;
      END LOOP;
      p_xmlmsg := txpks_msg.fn_mt_obj2xml(l_objmsg);
      plog.setendsection (pkgctx, 'fn_Transfer');
      ROLLBACK;
      RETURN errnums.C_BIZ_RULE_INVALID;
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      p_err_param := 'SYSTEM_ERROR';
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      p_xmlmsg := txpks_msg.fn_mt_obj2xml(l_objmsg);
      plog.setendsection (pkgctx, 'fn_Transfer');
      RETURN errnums.C_SYSTEM_ERROR;
END fn_Transfer;

FUNCTION fn_Add(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Add');
-- Check befor add
   IF txpks_#cf_fatca.fn_CheckBeforeAdd(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- Auto add
   IF txpks_maintain.fn_ProcessAdd(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- After Add
   IF txpks_#cf_fatca.fn_ProcessAfterAdd(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
--ghi log
   IF txpks_maintain.fn_MaintainLog(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   plog.setendsection (pkgctx, 'fn_Add');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Add');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Add;

FUNCTION fn_Edit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Edit');
-- Check befor edit
   IF txpks_#cf_fatca.fn_CheckBeforeEdit(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- Auto Edit
   IF txpks_maintain.fn_ProcessEdit(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- After Edit
   IF txpks_#cf_fatca.fn_ProcessAfterEdit(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   --ghi log
   IF txpks_maintain.fn_MaintainLog(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   plog.setendsection (pkgctx, 'fn_Edit');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Edit');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Edit;

FUNCTION fn_Delete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Delete');
-- Check befor Delete
   IF txpks_#cf_fatca.fn_CheckBeforeDelete(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- Auto Delete
   IF txpks_maintain.fn_ProcessDelete(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- After Delete
   IF txpks_#cf_fatca.fn_ProcessAfterDelete(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   --ghi log
   IF txpks_maintain.fn_MaintainLog(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   plog.setendsection (pkgctx, 'fn_Delete');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Delete');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Delete;

FUNCTION fn_Adhoc(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Adhoc');

   plog.setendsection (pkgctx, 'fn_Adhoc');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Adhoc');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Adhoc;

FUNCTION fn_Approve(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Approve');
   IF txpks_maintain.fn_Approve(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF; 
   plog.setendsection (pkgctx, 'fn_Approve');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Approve');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Approve;

FUNCTION fn_Reject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Reject');

   IF txpks_maintain.fn_Reject(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;

   plog.setendsection (pkgctx, 'fn_Reject');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Reject');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Reject;


FUNCTION fn_CheckBeforeAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_CheckBeforeAdd');

    plog.setendsection (pkgctx, 'fn_CheckBeforeAdd');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_CheckBeforeAdd');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_CheckBeforeAdd;

FUNCTION fn_ProcessAfterAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_ProcessAfterAdd');

    plog.setendsection (pkgctx, 'fn_ProcessAfterAdd');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessAfterAdd');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessAfterAdd;

FUNCTION fn_CheckBeforeEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_CheckBeforeEdit');

    plog.setendsection (pkgctx, 'fn_CheckBeforeEdit');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_CheckBeforeEdit');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_CheckBeforeEdit;

FUNCTION fn_ProcessAfterEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_ProcessAfterEdit');

    plog.setendsection (pkgctx, 'fn_ProcessAfterEdit');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessAfterEdit');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessAfterEdit;

FUNCTION fn_CheckBeforeDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_CheckBeforeDelete');

    plog.setendsection (pkgctx, 'fn_CheckBeforeDelete');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_CheckBeforeDelete');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_CheckBeforeDelete;

FUNCTION fn_ProcessAfterDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_ProcessAfterDelete');

    plog.setendsection (pkgctx, 'fn_ProcessAfterDelete');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessAfterDelete');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessAfterDelete;

FUNCTION fn_CheckBeforeApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_CheckBeforeApprove');

    plog.setendsection (pkgctx, 'fn_CheckBeforeApprove');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_CheckBeforeApprove');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_CheckBeforeApprove;

FUNCTION fn_ProcessAfterApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_ProcessAfterApprove');

    plog.setendsection (pkgctx, 'fn_ProcessAfterApprove');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessAfterApprove');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessAfterApprove;

FUNCTION fn_CheckBeforeReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_CheckBeforeReject');

    plog.setendsection (pkgctx, 'fn_CheckBeforeReject');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_CheckBeforeReject');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_CheckBeforeReject;

FUNCTION fn_ProcessAfterReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_ProcessAfterReject');

    plog.setendsection (pkgctx, 'fn_ProcessAfterReject');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessAfterReject');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessAfterReject;

BEGIN
      FOR i IN (SELECT *
                FROM tlogdebug)
      LOOP
         logrow.loglevel    := i.loglevel;
         logrow.log4table   := i.log4table;
         logrow.log4alert   := i.log4alert;
         logrow.log4trace   := i.log4trace;
      END LOOP;
      pkgctx    :=
         plog.init ('txpks_#cf_fatca',
                    plevel => NVL(logrow.loglevel,30),
                    plogtable => (NVL(logrow.log4table,'N') = 'Y'),
                    palert => (NVL(logrow.log4alert,'N') = 'Y'),
                    ptrace => (NVL(logrow.log4trace,'N') = 'Y')
            );
END txpks_#cf_fatca;
/

DROP PACKAGE txpks_#cf_upload
/

CREATE OR REPLACE 
PACKAGE txpks_#cf_upload 
/** ----------------------------------------------------------------------------------------------------
 dung cho form maintenance
 ----------------------------------------------------------------------------------------------------*/
IS

FUNCTION fn_Transfer(p_xmlmsg in out varchar2,p_err_code in out varchar2,p_err_param out varchar2)
RETURN NUMBER;
FUNCTION fn_Add(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Edit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Delete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Adhoc(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Approve(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Reject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;

--rieng
FUNCTION fn_CheckBeforeAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;

END;
/

CREATE OR REPLACE 
PACKAGE BODY txpks_#cf_upload 
IS
   pkgctx   plog.log_ctx;
   logrow   tlogdebug%ROWTYPE;

FUNCTION fn_Transfer(p_xmlmsg in out varchar2,p_err_code in out varchar2,p_err_param out varchar2)
RETURN NUMBER
IS
   l_return_code VARCHAR2(30) := systemnums.C_SUCCESS;
   l_objmsg tx.obj_rectype;
   l_count NUMBER(3);
   l_msgtype VARCHAR2(10);
   l_objname VARCHAR2(100);
   l_actionflag varchar2(100);
   l_currdate varchar2(10);
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Transfer');
   plog.debug(pkgctx, 'fn_Transfer');
   --get object
   l_objmsg:= txpks_msg.fn_mt_xml2obj(p_xmlmsg);
   l_msgtype:= l_objmsg.MSGTYPE;
   l_objname:= l_objmsg.OBJNAME;
   l_actionflag:= l_objmsg.ACTIONFLAG;
   --Kiem tra msgtype de phan luong xu ly
   IF l_actionflag ='ADD' THEN
        IF fn_Add(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;
   ELSIF l_actionflag ='EDIT' THEN 
        IF fn_Edit(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;
   
   ELSIF l_actionflag ='DELETE' THEN 
        IF fn_Delete(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;
   ELSIF l_actionflag ='ADHOC' THEN
        IF fn_Adhoc(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;
   ELSIF l_actionflag ='APPROVE' THEN 
        IF fn_Approve(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;
   ELSIF l_actionflag ='REJECT' THEN 
        IF fn_Reject(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;
   END IF;
   
   plog.debug(pkgctx, 'fn_Transfer');
   plog.setendsection (pkgctx, 'fn_Transfer');
   RETURN l_return_code;
EXCEPTION
WHEN errnums.E_BIZ_RULE_INVALID
   THEN
      FOR I IN (
           SELECT ERRDESC,EN_ERRDESC FROM deferror
           WHERE ERRNUM= p_err_code
      ) LOOP
           p_err_param := i.errdesc;
      END LOOP;      
      p_xmlmsg := txpks_msg.fn_mt_obj2xml(l_objmsg);
      plog.setendsection (pkgctx, 'fn_Transfer');
      ROLLBACK;
      RETURN errnums.C_BIZ_RULE_INVALID;
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      p_err_param := 'SYSTEM_ERROR';
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      p_xmlmsg := txpks_msg.fn_mt_obj2xml(l_objmsg);
      plog.setendsection (pkgctx, 'fn_Transfer');
      RETURN errnums.C_SYSTEM_ERROR;
END fn_Transfer;

FUNCTION fn_Add(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Add');
-- Check befor add
   IF txpks_#cf_upload.fn_CheckBeforeAdd(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- Auto add
   IF txpks_maintain.fn_ProcessAdd(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- After Add
   IF txpks_#cf_upload.fn_ProcessAfterAdd(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
--ghi log
   IF txpks_maintain.fn_MaintainLog(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF; 
   plog.setendsection (pkgctx, 'fn_Add');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Add');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Add;

FUNCTION fn_Edit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Edit');
-- Check befor edit
   IF txpks_#cf_upload.fn_CheckBeforeEdit(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- Auto Edit
   IF txpks_maintain.fn_ProcessEdit(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- After Edit
   IF txpks_#cf_upload.fn_ProcessAfterEdit(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   --ghi log
   IF txpks_maintain.fn_MaintainLog(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF; 
   plog.setendsection (pkgctx, 'fn_Edit');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Edit');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Edit;

FUNCTION fn_Delete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Delete');
-- Check befor Delete
   IF txpks_#cf_upload.fn_CheckBeforeDelete(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- Auto Delete
   IF txpks_maintain.fn_ProcessDelete(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- After Delete
   IF txpks_#cf_upload.fn_ProcessAfterDelete(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   --ghi log
   IF txpks_maintain.fn_MaintainLog(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF; 
   plog.setendsection (pkgctx, 'fn_Delete');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Delete');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Delete;

FUNCTION fn_Adhoc(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Adhoc');

   plog.setendsection (pkgctx, 'fn_Adhoc');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Adhoc');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Adhoc;

FUNCTION fn_Approve(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Approve');
   IF txpks_maintain.fn_Approve(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;  
   plog.setendsection (pkgctx, 'fn_Approve');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Approve');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Approve;

FUNCTION fn_Reject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Reject');

   plog.setendsection (pkgctx, 'fn_Reject');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Reject');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Reject;


FUNCTION fn_CheckBeforeAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_CheckBeforeAdd');
    
   
    plog.setendsection (pkgctx, 'fn_CheckBeforeAdd');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_CheckBeforeAdd');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_CheckBeforeAdd;

FUNCTION fn_ProcessAfterAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_ProcessAfterAdd');
  
    plog.setendsection (pkgctx, 'fn_ProcessAfterAdd');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessAfterAdd');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessAfterAdd;

FUNCTION fn_CheckBeforeEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_CheckBeforeEdit');
      
    plog.setendsection (pkgctx, 'fn_CheckBeforeEdit');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_CheckBeforeEdit');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_CheckBeforeEdit;

FUNCTION fn_ProcessAfterEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_ProcessAfterEdit');
  
    plog.setendsection (pkgctx, 'fn_ProcessAfterEdit');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessAfterEdit');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessAfterEdit;

FUNCTION fn_CheckBeforeDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_CheckBeforeDelete');
      
    plog.setendsection (pkgctx, 'fn_CheckBeforeDelete');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_CheckBeforeDelete');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_CheckBeforeDelete;

FUNCTION fn_ProcessAfterDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_ProcessAfterDelete');
  
    plog.setendsection (pkgctx, 'fn_ProcessAfterDelete');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessAfterDelete');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessAfterDelete;

FUNCTION fn_CheckBeforeApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_CheckBeforeApprove');
      
    plog.setendsection (pkgctx, 'fn_CheckBeforeApprove');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_CheckBeforeApprove');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_CheckBeforeApprove;

FUNCTION fn_ProcessAfterApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_ProcessAfterApprove');
  
    plog.setendsection (pkgctx, 'fn_ProcessAfterApprove');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessAfterApprove');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessAfterApprove;

FUNCTION fn_CheckBeforeReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_CheckBeforeReject');
    
    plog.setendsection (pkgctx, 'fn_CheckBeforeReject');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_CheckBeforeReject');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_CheckBeforeReject;

FUNCTION fn_ProcessAfterReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_ProcessAfterReject');
  
    plog.setendsection (pkgctx, 'fn_ProcessAfterReject');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessAfterReject');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessAfterReject;

BEGIN
      FOR i IN (SELECT *
                FROM tlogdebug)
      LOOP
         logrow.loglevel    := i.loglevel;
         logrow.log4table   := i.log4table;
         logrow.log4alert   := i.log4alert;
         logrow.log4trace   := i.log4trace;
      END LOOP;
      pkgctx    :=
         plog.init ('txpks_#cf_upload',
                    plevel => NVL(logrow.loglevel,30),
                    plogtable => (NVL(logrow.log4table,'N') = 'Y'),
                    palert => (NVL(logrow.log4alert,'N') = 'Y'),
                    ptrace => (NVL(logrow.log4trace,'N') = 'Y')
            );
END txpks_#cf_upload;
/

DROP PACKAGE txpks_#fa_faautosch
/

CREATE OR REPLACE 
PACKAGE txpks_#fa_faautosch 
/** ----------------------------------------------------------------------------------------------------
 dung cho form maintenance
 ----------------------------------------------------------------------------------------------------*/
IS
   FUNCTION fn_Transfer (p_xmlmsg      IN OUT VARCHAR2,
                         p_err_code    IN OUT VARCHAR2,
                         p_err_param      OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_Add (p_objmsg     IN OUT tx.obj_rectype,
                    p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_Edit (p_objmsg     IN OUT tx.obj_rectype,
                     p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_Delete (p_objmsg     IN OUT tx.obj_rectype,
                       p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_Adhoc (p_objmsg     IN OUT tx.obj_rectype,
                      p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_Approve (p_objmsg     IN OUT tx.obj_rectype,
                        p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_Reject (p_objmsg     IN OUT tx.obj_rectype,
                       p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   --rieng
   FUNCTION fn_CheckBeforeAdd (p_objmsg     IN OUT tx.obj_rectype,
                               p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_CheckBeforeEdit (p_objmsg     IN OUT tx.obj_rectype,
                                p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_CheckBeforeDelete (p_objmsg     IN OUT tx.obj_rectype,
                                  p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_CheckBeforeApprove (p_objmsg     IN OUT tx.obj_rectype,
                                   p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_CheckBeforeReject (p_objmsg     IN OUT tx.obj_rectype,
                                  p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_ProcessAfterAdd (p_objmsg     IN OUT tx.obj_rectype,
                                p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_ProcessAfterEdit (p_objmsg     IN OUT tx.obj_rectype,
                                 p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_ProcessAfterDelete (p_objmsg     IN OUT tx.obj_rectype,
                                   p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_ProcessAfterApprove (p_objmsg     IN OUT tx.obj_rectype,
                                    p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_ProcessAfterReject (p_objmsg     IN OUT tx.obj_rectype,
                                   p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;
END;
/

DROP PACKAGE txpks_#fa_facollectionschedule
/

CREATE OR REPLACE 
PACKAGE txpks_#fa_facollectionschedule 
/** ----------------------------------------------------------------------------------------------------
 dung cho form maintenance
 ----------------------------------------------------------------------------------------------------*/
IS
   FUNCTION fn_Transfer (p_xmlmsg      IN OUT VARCHAR2,
                         p_err_code    IN OUT VARCHAR2,
                         p_err_param      OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_Add (p_objmsg     IN OUT tx.obj_rectype,
                    p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_Edit (p_objmsg     IN OUT tx.obj_rectype,
                     p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_Delete (p_objmsg     IN OUT tx.obj_rectype,
                       p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_Adhoc (p_objmsg     IN OUT tx.obj_rectype,
                      p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_Approve (p_objmsg     IN OUT tx.obj_rectype,
                        p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_Reject (p_objmsg     IN OUT tx.obj_rectype,
                       p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   --rieng
   FUNCTION fn_CheckBeforeAdd (p_objmsg     IN OUT tx.obj_rectype,
                               p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_CheckBeforeEdit (p_objmsg     IN OUT tx.obj_rectype,
                                p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_CheckBeforeDelete (p_objmsg     IN OUT tx.obj_rectype,
                                  p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_CheckBeforeApprove (p_objmsg     IN OUT tx.obj_rectype,
                                   p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_CheckBeforeReject (p_objmsg     IN OUT tx.obj_rectype,
                                  p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_ProcessAfterAdd (p_objmsg     IN OUT tx.obj_rectype,
                                p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_ProcessAfterEdit (p_objmsg     IN OUT tx.obj_rectype,
                                 p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_ProcessAfterDelete (p_objmsg     IN OUT tx.obj_rectype,
                                   p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_ProcessAfterApprove (p_objmsg     IN OUT tx.obj_rectype,
                                    p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_ProcessAfterReject (p_objmsg     IN OUT tx.obj_rectype,
                                   p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;
END;
/

CREATE OR REPLACE 
PACKAGE BODY txpks_#fa_facollectionschedule 
IS
   pkgctx   plog.log_ctx;
   logrow   tlogdebug%ROWTYPE;

   FUNCTION fn_Transfer (p_xmlmsg      IN OUT VARCHAR2,
                         p_err_code    IN OUT VARCHAR2,
                         p_err_param      OUT VARCHAR2)
      RETURN NUMBER
   IS
      l_return_code   VARCHAR2 (30) := systemnums.C_SUCCESS;
      l_objmsg        tx.obj_rectype;
      l_count         NUMBER (3);
      l_msgtype       VARCHAR2 (10);
      l_objname       VARCHAR2 (100);
      l_actionflag    VARCHAR2 (100);
      l_currdate      VARCHAR2 (10);
   BEGIN
      plog.setbeginsection (pkgctx, 'fn_Transfer');
      plog.debug (pkgctx, 'fn_Transfer');
      --get object
      l_objmsg := txpks_msg.fn_mt_xml2obj (p_xmlmsg);
      l_msgtype := l_objmsg.MSGTYPE;
      l_objname := l_objmsg.OBJNAME;
      l_actionflag := l_objmsg.ACTIONFLAG;

      --Kiem tra msgtype de phan luong xu ly
      IF l_actionflag = 'ADD'
      THEN
         IF fn_Add (l_objmsg, p_err_code) <> systemnums.C_SUCCESS
         THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
         END IF;
      ELSIF l_actionflag = 'EDIT'
      THEN
         IF fn_Edit (l_objmsg, p_err_code) <> systemnums.C_SUCCESS
         THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
         END IF;
      ELSIF l_actionflag = 'DELETE'
      THEN
         IF fn_Delete (l_objmsg, p_err_code) <> systemnums.C_SUCCESS
         THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
         END IF;
      ELSIF l_actionflag = 'ADHOC'
      THEN
         IF fn_Adhoc (l_objmsg, p_err_code) <> systemnums.C_SUCCESS
         THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
         END IF;
      ELSIF l_actionflag = 'APPROVE'
      THEN
         IF fn_Approve (l_objmsg, p_err_code) <> systemnums.C_SUCCESS
         THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
         END IF;
      ELSIF l_actionflag = 'REJECT'
      THEN
         IF fn_Reject (l_objmsg, p_err_code) <> systemnums.C_SUCCESS
         THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
         END IF;
      END IF;

      plog.debug (pkgctx, 'fn_Transfer');
      plog.setendsection (pkgctx, 'fn_Transfer');
      RETURN l_return_code;
   EXCEPTION
      WHEN errnums.E_BIZ_RULE_INVALID
      THEN
         FOR I IN (SELECT ERRDESC, EN_ERRDESC
                     FROM deferror
                    WHERE ERRNUM = p_err_code)
         LOOP
            p_err_param := i.errdesc;
         END LOOP;

         p_xmlmsg := txpks_msg.fn_mt_obj2xml (l_objmsg);
         plog.setendsection (pkgctx, 'fn_Transfer');
         ROLLBACK;
         RETURN errnums.C_BIZ_RULE_INVALID;
      WHEN OTHERS
      THEN
         p_err_code := errnums.C_SYSTEM_ERROR;
         p_err_param := 'SYSTEM_ERROR';
         plog.error (pkgctx, SQLERRM || DBMS_UTILITY.format_error_backtrace);
         p_xmlmsg := txpks_msg.fn_mt_obj2xml (l_objmsg);
         plog.setendsection (pkgctx, 'fn_Transfer');
         RETURN errnums.C_SYSTEM_ERROR;
   END fn_Transfer;

   FUNCTION fn_Add (p_objmsg     IN OUT tx.obj_rectype,
                    p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER
   IS
   BEGIN
      plog.setbeginsection (pkgctx, 'fn_Add');

      -- Check befor add
      IF txpks_#FA_FACOLLECTIONSCHEDULE.fn_CheckBeforeAdd (p_objmsg,
                                                           p_err_code) <>
            systemnums.C_SUCCESS
      THEN
         RETURN errnums.C_BIZ_RULE_INVALID;
      END IF;

      -- Auto add
      IF txpks_maintain.fn_ProcessAdd (p_objmsg, p_err_code) <>
            systemnums.C_SUCCESS
      THEN
         RETURN errnums.C_BIZ_RULE_INVALID;
      END IF;

      -- After Add
      IF txpks_#FA_FACOLLECTIONSCHEDULE.fn_ProcessAfterAdd (p_objmsg,
                                                            p_err_code) <>
            systemnums.C_SUCCESS
      THEN
         RETURN errnums.C_BIZ_RULE_INVALID;
      END IF;

      --ghi log

      IF txpks_maintain.fn_MaintainLog (p_objmsg, p_err_code) <>
            systemnums.C_SUCCESS
      THEN
         RETURN errnums.C_BIZ_RULE_INVALID;
      END IF;

      plog.setendsection (pkgctx, 'fn_Add');
      RETURN systemnums.C_SUCCESS;
   EXCEPTION
      WHEN OTHERS
      THEN
         p_err_code := errnums.C_SYSTEM_ERROR;
         plog.error (pkgctx, SQLERRM || DBMS_UTILITY.format_error_backtrace);
         plog.setendsection (pkgctx, 'fn_Add');
         ROLLBACK;
         RAISE errnums.E_SYSTEM_ERROR;
   END fn_Add;

   FUNCTION fn_Edit (p_objmsg     IN OUT tx.obj_rectype,
                     p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER
   IS
   BEGIN
      plog.setbeginsection (pkgctx, 'fn_Edit');

      -- Check befor edit
      IF txpks_#FA_FACOLLECTIONSCHEDULE.fn_CheckBeforeEdit (p_objmsg,
                                                            p_err_code) <>
            systemnums.C_SUCCESS
      THEN
         RETURN errnums.C_BIZ_RULE_INVALID;
      END IF;

      -- Auto Edit
      IF txpks_maintain.fn_ProcessEdit (p_objmsg, p_err_code) <>
            systemnums.C_SUCCESS
      THEN
         RETURN errnums.C_BIZ_RULE_INVALID;
      END IF;

      -- After Edit
      IF txpks_#FA_FACOLLECTIONSCHEDULE.fn_ProcessAfterEdit (p_objmsg,
                                                             p_err_code) <>
            systemnums.C_SUCCESS
      THEN
         RETURN errnums.C_BIZ_RULE_INVALID;
      END IF;

      --ghi log
      IF txpks_maintain.fn_MaintainLog (p_objmsg, p_err_code) <>
            systemnums.C_SUCCESS
      THEN
         RETURN errnums.C_BIZ_RULE_INVALID;
      END IF;

      plog.setendsection (pkgctx, 'fn_Edit');
      RETURN systemnums.C_SUCCESS;
   EXCEPTION
      WHEN OTHERS
      THEN
         p_err_code := errnums.C_SYSTEM_ERROR;
         plog.error (pkgctx, SQLERRM || DBMS_UTILITY.format_error_backtrace);
         plog.setendsection (pkgctx, 'fn_Edit');
         ROLLBACK;
         RAISE errnums.E_SYSTEM_ERROR;
   END fn_Edit;

   FUNCTION fn_Delete (p_objmsg     IN OUT tx.obj_rectype,
                       p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER
   IS
   BEGIN
      plog.setbeginsection (pkgctx, 'fn_Delete');

      -- Check befor Delete
      IF txpks_#FA_FACOLLECTIONSCHEDULE.fn_CheckBeforeDelete (p_objmsg,
                                                              p_err_code) <>
            systemnums.C_SUCCESS
      THEN
         RETURN errnums.C_BIZ_RULE_INVALID;
      END IF;

      -- Auto Delete
      IF txpks_maintain.fn_ProcessDelete (p_objmsg, p_err_code) <>
            systemnums.C_SUCCESS
      THEN
         RETURN errnums.C_BIZ_RULE_INVALID;
      END IF;

      -- After Delete
      IF txpks_#FA_FACOLLECTIONSCHEDULE.fn_ProcessAfterDelete (p_objmsg,
                                                               p_err_code) <>
            systemnums.C_SUCCESS
      THEN
         RETURN errnums.C_BIZ_RULE_INVALID;
      END IF;

      --ghi log
      IF txpks_maintain.fn_MaintainLog (p_objmsg, p_err_code) <>
            systemnums.C_SUCCESS
      THEN
         RETURN errnums.C_BIZ_RULE_INVALID;
      END IF;

      plog.setendsection (pkgctx, 'fn_Delete');
      RETURN systemnums.C_SUCCESS;
   EXCEPTION
      WHEN OTHERS
      THEN
         p_err_code := errnums.C_SYSTEM_ERROR;
         plog.error (pkgctx, SQLERRM || DBMS_UTILITY.format_error_backtrace);
         plog.setendsection (pkgctx, 'fn_Delete');
         ROLLBACK;
         RAISE errnums.E_SYSTEM_ERROR;
   END fn_Delete;

   FUNCTION fn_Adhoc (p_objmsg     IN OUT tx.obj_rectype,
                      p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER
   IS
   BEGIN
      plog.setbeginsection (pkgctx, 'fn_Adhoc');

      plog.setendsection (pkgctx, 'fn_Adhoc');
      RETURN systemnums.C_SUCCESS;
   EXCEPTION
      WHEN OTHERS
      THEN
         p_err_code := errnums.C_SYSTEM_ERROR;
         plog.error (pkgctx, SQLERRM || DBMS_UTILITY.format_error_backtrace);
         plog.setendsection (pkgctx, 'fn_Adhoc');
         ROLLBACK;
         RAISE errnums.E_SYSTEM_ERROR;
   END fn_Adhoc;

   FUNCTION fn_Approve (p_objmsg     IN OUT tx.obj_rectype,
                        p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER
   IS
   BEGIN
      plog.setbeginsection (pkgctx, 'fn_Approve');

      -- Check befor Approve
      IF txpks_#FA_FACOLLECTIONSCHEDULE.fn_CheckBeforeApprove (p_objmsg,
                                                               p_err_code) <>
            systemnums.C_SUCCESS
      THEN
         RETURN errnums.C_BIZ_RULE_INVALID;
      END IF;

      IF txpks_maintain.fn_Approve (p_objmsg, p_err_code) <>
            systemnums.C_SUCCESS
      THEN
         RETURN errnums.C_BIZ_RULE_INVALID;
      END IF;

      -- After Approve
      IF txpks_#FA_FACOLLECTIONSCHEDULE.fn_ProcessAfterApprove (p_objmsg,
                                                                p_err_code) <>
            systemnums.C_SUCCESS
      THEN
         RETURN errnums.C_BIZ_RULE_INVALID;
      END IF;

      plog.setendsection (pkgctx, 'fn_Approve');
      RETURN systemnums.C_SUCCESS;
   EXCEPTION
      WHEN OTHERS
      THEN
         p_err_code := errnums.C_SYSTEM_ERROR;
         plog.error (pkgctx, SQLERRM || DBMS_UTILITY.format_error_backtrace);
         plog.setendsection (pkgctx, 'fn_Approve');
         ROLLBACK;
         RAISE errnums.E_SYSTEM_ERROR;
   END fn_Approve;

   FUNCTION fn_Reject (p_objmsg     IN OUT tx.obj_rectype,
                       p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER
   IS
   BEGIN
      plog.setbeginsection (pkgctx, 'fn_Reject');

      -- Check befor reject
      IF txpks_#FA_FACOLLECTIONSCHEDULE.fn_CheckBeforeReject (p_objmsg,
                                                              p_err_code) <>
            systemnums.C_SUCCESS
      THEN
         RETURN errnums.C_BIZ_RULE_INVALID;
      END IF;

      -- Auto reject
      IF txpks_maintain.fn_Reject (p_objmsg, p_err_code) <>
            systemnums.C_SUCCESS
      THEN
         RETURN errnums.C_BIZ_RULE_INVALID;
      END IF;

      -- After reject
      IF txpks_#FA_FACOLLECTIONSCHEDULE.fn_ProcessAfterReject (p_objmsg,
                                                               p_err_code) <>
            systemnums.C_SUCCESS
      THEN
         RETURN errnums.C_BIZ_RULE_INVALID;
      END IF;

      plog.setendsection (pkgctx, 'fn_Reject');
      RETURN systemnums.C_SUCCESS;
   EXCEPTION
      WHEN OTHERS
      THEN
         p_err_code := errnums.C_SYSTEM_ERROR;
         plog.error (pkgctx, SQLERRM || DBMS_UTILITY.format_error_backtrace);
         plog.setendsection (pkgctx, 'fn_Reject');
         ROLLBACK;
         RAISE errnums.E_SYSTEM_ERROR;
   END fn_Reject;


   FUNCTION fn_CheckBeforeAdd (p_objmsg     IN OUT tx.obj_rectype,
                               p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER
   IS
      l_count          NUMBER;
      l_monthtype      VARCHAR2 (10);
      l_cycletype      VARCHAR2 (10);
      l_tradingcycle   VARCHAR2 (500);
      l_strCYCLE       VARCHAR2 (500);
      n                NUMBER;
      l_str1           VARCHAR2 (200);
      l_str2           VARCHAR2 (200);
      l_str3           VARCHAR2 (200);
      l_str4           VARCHAR2 (200);
      l_check          NUMBER;
      l_err            BOOLEAN;
      l_confirm        BOOLEAN;
      l_adjtraderule   VARCHAR2 (10);
   BEGIN
      plog.setendsection (pkgctx, 'fn_CheckBeforeAdd');
      RETURN systemnums.C_SUCCESS;
   EXCEPTION
      WHEN OTHERS
      THEN
         p_err_code := errnums.C_SYSTEM_ERROR;
         plog.error (pkgctx, SQLERRM || DBMS_UTILITY.format_error_backtrace);
         plog.setendsection (pkgctx, 'fn_CheckBeforeAdd');
         ROLLBACK;
         RAISE errnums.E_SYSTEM_ERROR;
   END fn_CheckBeforeAdd;

   FUNCTION fn_ProcessAfterAdd (p_objmsg     IN OUT tx.obj_rectype,
                                p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER
   IS
      l_count          NUMBER;
      l_tradingcycle   VARCHAR2 (500);
      l_cycletype      VARCHAR2 (10);
      l_monthtype      VARCHAR2 (10);
      l_autoid         VARCHAR2 (10);
      c                VARCHAR2 (10);
      l_str1           VARCHAR2 (500);
      l_str2           VARCHAR2 (500);
      l_str3           VARCHAR2 (500);
      l_str4           VARCHAR2 (500);
      l_RESULT         VARCHAR2 (500);
      l_TDATE          NUMBER;
      m                NUMBER;
      l_tradingtype    VARCHAR2 (10);
      l_ftype          VARCHAR2 (3);
   BEGIN
      plog.setendsection (pkgctx, 'fn_ProcessAfterAdd');
      RETURN systemnums.C_SUCCESS;
   EXCEPTION
      WHEN OTHERS
      THEN
         p_err_code := errnums.C_SYSTEM_ERROR;
         plog.error (pkgctx, SQLERRM || DBMS_UTILITY.format_error_backtrace);
         plog.setendsection (pkgctx, 'fn_ProcessAfterAdd');
         ROLLBACK;
         RAISE errnums.E_SYSTEM_ERROR;
   END fn_ProcessAfterAdd;

   FUNCTION fn_CheckBeforeEdit (p_objmsg     IN OUT tx.obj_rectype,
                                p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER
   IS
      l_count                   NUMBER;
      L_STRCLAUSE               VARCHAR2 (100);
      v_strChild_Record_Key     VARCHAR2 (100);
      v_strChild_Record_Value   VARCHAR2 (100);
      L_TRADINGCYCLE            VARCHAR2 (100);
      l_last_date_of_cycle      DATE;
      l_fldname                 VARCHAR2 (100);
      l_fldval                  VARCHAR2 (4000);
      l_fldtype                 VARCHAR2 (100);
      l_fldoldval               VARCHAR2 (4000);
      L_SPCODE                  VARCHAR2 (20);

      l_monthtype               VARCHAR2 (10);
      l_cycletype               VARCHAR2 (10);
      --l_tradingcycle VARCHAR2(500);
      l_strCYCLE                VARCHAR2 (500);
      n                         NUMBER;
      l_str1                    VARCHAR2 (200);
      l_str2                    VARCHAR2 (200);
      l_str3                    VARCHAR2 (200);
      l_str4                    VARCHAR2 (200);
      l_check                   NUMBER;
      l_err                     BOOLEAN;
      l_confirm                 BOOLEAN;
      l_adjtraderule            VARCHAR2 (10);
   BEGIN
      plog.setbeginsection (pkgctx, 'fn_CheckBeforeEdit');

      plog.setendsection (pkgctx, 'fn_CheckBeforeEdit');
      RETURN systemnums.C_SUCCESS;
   EXCEPTION
      WHEN OTHERS
      THEN
         p_err_code := errnums.C_SYSTEM_ERROR;
         plog.error (pkgctx, SQLERRM || DBMS_UTILITY.format_error_backtrace);
         plog.setendsection (pkgctx, 'fn_CheckBeforeEdit');
         ROLLBACK;
         RAISE errnums.E_SYSTEM_ERROR;
   END fn_CheckBeforeEdit;

   FUNCTION fn_ProcessAfterEdit (p_objmsg     IN OUT tx.obj_rectype,
                                 p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER
   IS
      l_count          NUMBER;
      l_tradingcycle   VARCHAR2 (500);
      l_cycletype      VARCHAR2 (10);
      l_monthtype      VARCHAR2 (10);
      l_autoid         VARCHAR2 (10);
      c                VARCHAR2 (10);
      l_str1           VARCHAR2 (500);
      l_str2           VARCHAR2 (500);
      l_str3           VARCHAR2 (500);
      l_str4           VARCHAR2 (500);
      l_RESULT         VARCHAR2 (500);
      m                NUMBER;
   BEGIN
      plog.setbeginsection (pkgctx, 'fn_ProcessAfterEdit');

      /*l_cycletype := p_objmsg.OBJFIELDS('CYCLETYPE').value;
      l_monthtype := p_objmsg.OBJFIELDS('MONTHTYPE').value;
      l_tradingcycle := p_objmsg.OBJFIELDS('TRADINGCYCLE').value;
      l_autoid :=  p_objmsg.OBJFIELDS('AUTOID').value;

      DELETE tradingcycledtl WHERE refautoid = l_autoid;
      IF l_cycletype = 'D' THEN  -- HANG NGAY
        INSERT INTO tradingcycledtl(autoid, refautoid, symbol,content,tradingcycledtl )
        VALUES (SEQ_TRADINGCYCLEDTL.NEXTVAL,l_autoid,p_objmsg.OBJFIELDS('SYMBOL').value,
                    LOAD_TRADINGCYCLE(l_tradingcycle,l_cycletype,l_monthtype),l_tradingcycle);
      END IF;

      if l_cycletype = 'W' THEN -- THEO TUAN
        l_count := 1;
        LOOP
          l_RESULT := SUBSTR(l_tradingcycle,l_count,3);
          IF l_RESULT IS NOT NULL THEN
              INSERT INTO tradingcycledtl(autoid, refautoid, symbol,content,tradingcycledtl )
              VALUES (SEQ_TRADINGCYCLEDTL.NEXTVAL,l_autoid,p_objmsg.OBJFIELDS('SYMBOL').value,
                        LOAD_TRADINGCYCLE(l_RESULT,l_cycletype,l_monthtype),l_RESULT);
          END IF;
          l_count := l_count + 3;
        EXIT WHEN l_RESULT IS NULL;
        END LOOP;
        IF l_count > 7 THEN
              INSERT INTO tradingcycledtl(autoid, refautoid, symbol,content,tradingcycledtl)
              VALUES (SEQ_TRADINGCYCLEDTL.NEXTVAL,l_autoid,p_objmsg.OBJFIELDS('SYMBOL').value,
                        LOAD_TRADINGCYCLE(l_tradingcycle,l_cycletype,l_monthtype),l_tradingcycle);
         END IF;
      END IF;

      IF l_cycletype = 'M' AND l_monthtype = 'D' THEN -- hang thang theo ngay
        IF l_tradingcycle = 'MD' THEN
          INSERT INTO tradingcycledtl(autoid, refautoid, symbol,content, tradingcycledtl)
            VALUES (SEQ_TRADINGCYCLEDTL.NEXTVAL,l_autoid,p_objmsg.OBJFIELDS('SYMBOL').value,
                      LOAD_TRADINGCYCLE(l_tradingcycle,l_cycletype,l_monthtype),l_tradingcycle);
        ELSE
        l_count := 1;
        LOOP
          l_RESULT := SUBSTR(l_tradingcycle,l_count,4);
          IF l_RESULT IS NOT NULL THEN
            INSERT INTO tradingcycledtl(autoid, refautoid, symbol,content, tradingcycledtl)
            VALUES (SEQ_TRADINGCYCLEDTL.NEXTVAL,l_autoid,p_objmsg.OBJFIELDS('SYMBOL').value,
                      LOAD_TRADINGCYCLE(l_RESULT,l_cycletype,l_monthtype),l_RESULT);
          END IF;
          l_count := l_count + 4;
        EXIT WHEN l_RESULT IS NULL;
        END LOOP;
        IF l_count > 9 THEN
              INSERT INTO tradingcycledtl(autoid, refautoid, symbol,content,tradingcycledtl)
              VALUES (SEQ_TRADINGCYCLEDTL.NEXTVAL,l_autoid,p_objmsg.OBJFIELDS('SYMBOL').value,
                        LOAD_TRADINGCYCLE(l_tradingcycle,l_cycletype,l_monthtype),l_tradingcycle);
          END IF;
        END IF;
      END IF;


      if l_cycletype = 'M' AND l_monthtype = 'T' THEN -- hang thang theo thu
              l_str2 := l_tradingcycle;--'MW1D2D3MW2D3D4'
              m :=0;
           LOOP
              l_str1 :=  pck_cldr.fn_get_fist_tradingcycle(l_str2,'M');
              l_count := 4;
                    LOOP
                      l_RESULT := substr(l_str1,1,3) || substr(l_str1,l_count,2);
                    IF l_RESULT IS NOT NULL AND LENGTH(l_RESULT) > 3 THEN
                      INSERT INTO tradingcycledtl(autoid, refautoid, symbol,content,tradingcycledtl )
                      VALUES (SEQ_TRADINGCYCLEDTL.NEXTVAL,l_autoid,p_objmsg.OBJFIELDS('SYMBOL').value,
                            LOAD_TRADINGCYCLE(l_RESULT,l_cycletype,l_monthtype),l_RESULT);
                    END IF;
                      l_count := l_count + 2;
                    EXIT WHEN length(l_RESULT) < 4 ;
                    END LOOP;
                    l_str2 := substr(l_str2,length(l_str1)+1);
                    m :=m+1;
            EXIT WHEN l_str2 IS NULL or l_str2 = '';
            END LOOP;
            IF m >1 THEN
              INSERT INTO tradingcycledtl(autoid, refautoid, symbol,content,tradingcycledtl )
                      VALUES (SEQ_TRADINGCYCLEDTL.NEXTVAL,l_autoid,p_objmsg.OBJFIELDS('SYMBOL').value,
                            LOAD_TRADINGCYCLE(l_tradingcycle,l_cycletype,l_monthtype),l_tradingcycle);
            END IF;
      END IF;

      --NEU LA TRUOC HOAC SAU NGAY BAO NHIEU CUA THANG
      if l_cycletype = 'M' and (l_monthtype = 'N' or l_monthtype = 'P') THEN
         INSERT INTO tradingcycledtl(autoid, refautoid, symbol,content, tradingcycledtl)
                  VALUES (SEQ_TRADINGCYCLEDTL.NEXTVAL,l_autoid,p_objmsg.OBJFIELDS('SYMBOL').value,
                        LOAD_TRADINGCYCLE(l_tradingcycle,l_cycletype,l_monthtype),l_tradingcycle);
      END IF;
      --TRUOC HOAC SAU NGAY BAO NHIEU THANG BNHIEU HANG QUY
      if l_cycletype = 'Q' and (l_monthtype = 'N' or l_monthtype = 'P') THEN
          l_str2 := l_tradingcycle;
          LOOP
               l_str1 :=  pck_cldr.fn_get_fist_tradingcycle(l_str2,'Q');
               INSERT INTO tradingcycledtl(autoid, refautoid, symbol,content, tradingcycledtl)
               VALUES (SEQ_TRADINGCYCLEDTL.NEXTVAL,l_autoid,p_objmsg.OBJFIELDS('SYMBOL').value,
                       LOAD_TRADINGCYCLE(l_str1,l_cycletype,l_monthtype),l_str1);
               l_str2 := substr(l_str2,length(l_str1)+1);
          EXIT WHEN l_str2 IS NULL or l_str2 = '';
          END LOOP;
      END IF;

      -- HANG QUY THEO NGAY
      if l_cycletype = 'Q'  AND l_monthtype = 'D' THEN -- HANG QUY THEO NGAY
          l_str2 := l_tradingcycle;
          m := 0;
          LOOP
               l_str1 :=  pck_cldr.fn_get_fist_tradingcycle(l_str2,'Q');
                l_count := 4;
                 LOOP
                    l_RESULT := substr(l_str1,1,3) || substr(l_str1,l_count,3);
                  IF l_RESULT IS NOT NULL AND LENGTH(l_RESULT) > 3  THEN
                    INSERT INTO tradingcycledtl(autoid, refautoid, symbol,content ,tradingcycledtl)
                    VALUES (SEQ_TRADINGCYCLEDTL.NEXTVAL,l_autoid,p_objmsg.OBJFIELDS('SYMBOL').value,
                            LOAD_TRADINGCYCLE(l_RESULT,l_cycletype,l_monthtype),l_RESULT);
                  END IF;
                    l_count := l_count + 3;
                 EXIT WHEN length(l_RESULT) < 4;
                 END LOOP;
                 l_str2 := substr(l_str2,length(l_str1)+1);
                 m := m+1;
          EXIT WHEN l_str2 IS NULL;
          END LOOP;
          IF m >1 THEN
              INSERT INTO tradingcycledtl(autoid, refautoid, symbol,content,tradingcycledtl )
                      VALUES (SEQ_TRADINGCYCLEDTL.NEXTVAL,l_autoid,p_objmsg.OBJFIELDS('SYMBOL').value,
                            LOAD_TRADINGCYCLE(l_tradingcycle,l_cycletype,l_monthtype),l_tradingcycle);
            END IF;
      END IF;

      -- HANG QUY THEO  THU
      if l_cycletype = 'Q'  AND l_monthtype = 'T' THEN
        l_str2 := l_tradingcycle;
        m := 0;
        LOOP
          l_str1 :=  pck_cldr.fn_get_fist_tradingcycle(l_str2,'Q');
              l_count := 6;
               LOOP
                  l_RESULT := substr(l_str1,1,5) || substr(l_str1,l_count,2);
               IF l_RESULT IS NOT NULL and length(l_RESULT) > 5 THEN
                  INSERT INTO tradingcycledtl(autoid, refautoid, symbol,content,tradingcycledtl)
                  VALUES (SEQ_TRADINGCYCLEDTL.NEXTVAL,l_autoid,p_objmsg.OBJFIELDS('SYMBOL').value,
                          LOAD_TRADINGCYCLE(l_RESULT,l_cycletype,l_monthtype),l_RESULT);
               END IF;
                  l_count := l_count + 2;
               EXIT WHEN length(l_RESULT) < 6;
               END LOOP;
               l_str2 := substr(l_str2,length(l_str1)+1);
               m := m+1;
         EXIT WHEN l_str2 IS NULL;
         END LOOP;
         IF m >1 THEN
              INSERT INTO tradingcycledtl(autoid, refautoid, symbol,content,tradingcycledtl )
                      VALUES (SEQ_TRADINGCYCLEDTL.NEXTVAL,l_autoid,p_objmsg.OBJFIELDS('SYMBOL').value,
                            LOAD_TRADINGCYCLE(l_tradingcycle,l_cycletype,l_monthtype),l_tradingcycle);
            END IF;
       END IF;*/
      plog.setendsection (pkgctx, 'fn_ProcessAfterEdit');
      RETURN systemnums.C_SUCCESS;
   EXCEPTION
      WHEN OTHERS
      THEN
         p_err_code := errnums.C_SYSTEM_ERROR;
         plog.error (pkgctx, SQLERRM || DBMS_UTILITY.format_error_backtrace);
         plog.setendsection (pkgctx, 'fn_ProcessAfterEdit');
         ROLLBACK;
         RAISE errnums.E_SYSTEM_ERROR;
   END fn_ProcessAfterEdit;

   FUNCTION fn_CheckBeforeDelete (p_objmsg     IN OUT tx.obj_rectype,
                                  p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER
   IS
      l_count                   NUMBER;
      L_STRCLAUSE               VARCHAR2 (100);
      v_strChild_Record_Key     VARCHAR2 (100);
      v_strChild_Record_Value   VARCHAR2 (100);
   BEGIN
      plog.setbeginsection (pkgctx, 'fn_CheckBeforeDelete');


      plog.setendsection (pkgctx, 'fn_CheckBeforeDelete');
      RETURN systemnums.C_SUCCESS;
   EXCEPTION
      WHEN OTHERS
      THEN
         p_err_code := errnums.C_SYSTEM_ERROR;
         plog.error (pkgctx, SQLERRM || DBMS_UTILITY.format_error_backtrace);
         plog.setendsection (pkgctx, 'fn_CheckBeforeDelete');
         ROLLBACK;
         RAISE errnums.E_SYSTEM_ERROR;
   END fn_CheckBeforeDelete;

   FUNCTION fn_ProcessAfterDelete (p_objmsg     IN OUT tx.obj_rectype,
                                   p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER
   IS
      l_count                   NUMBER;
      L_STRCLAUSE               VARCHAR2 (100);
      v_strChild_Record_Key     VARCHAR2 (100);
      v_strChild_Record_Value   VARCHAR2 (100);
   BEGIN
      plog.setendsection (pkgctx, 'fn_ProcessAfterDelete');
      RETURN systemnums.C_SUCCESS;
   EXCEPTION
      WHEN OTHERS
      THEN
         p_err_code := errnums.C_SYSTEM_ERROR;
         plog.error (pkgctx, SQLERRM || DBMS_UTILITY.format_error_backtrace);
         plog.setendsection (pkgctx, 'fn_ProcessAfterDelete');
         ROLLBACK;
         RAISE errnums.E_SYSTEM_ERROR;
   END fn_ProcessAfterDelete;

   FUNCTION fn_CheckBeforeApprove (p_objmsg     IN OUT tx.obj_rectype,
                                   p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER
   IS
      l_count   NUMBER;
   BEGIN
      plog.setbeginsection (pkgctx, 'fn_CheckBeforeApprove');

      plog.setendsection (pkgctx, 'fn_CheckBeforeApprove');
      RETURN systemnums.C_SUCCESS;
   EXCEPTION
      WHEN OTHERS
      THEN
         p_err_code := errnums.C_SYSTEM_ERROR;
         plog.error (pkgctx, SQLERRM || DBMS_UTILITY.format_error_backtrace);
         plog.setendsection (pkgctx, 'fn_CheckBeforeApprove');
         ROLLBACK;
         RAISE errnums.E_SYSTEM_ERROR;
   END fn_CheckBeforeApprove;

   FUNCTION fn_ProcessAfterApprove (p_objmsg     IN OUT tx.obj_rectype,
                                    p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER
   IS
      l_count          NUMBER;
      l_refobjid       VARCHAR2 (1000);
      l_actionflag     VARCHAR2 (100);
      l_childvalue     VARCHAR2 (100);
      l_childkey       VARCHAR2 (100);
      l_chiltable      VARCHAR2 (100);
      l_year           VARCHAR2 (100);
      l_codeid         VARCHAR2 (100);
      l_TRADINGDATE    DATE;
      l_TRADINGID      VARCHAR2 (100);
      l_SYMBOL         VARCHAR2 (20);
      l_CLSORDDAY      VARCHAR2 (100);
      l_MATCHDAY       VARCHAR2 (100);
      l_EXECDAY        VARCHAR2 (100);
      L_EXECMONNEYD    VARCHAR2 (100);
      l_CLSORDTIME     VARCHAR2 (100);
      l_MATCHTIME      VARCHAR2 (100);
      l_EXECTIME       VARCHAR2 (100);
      l_EXECMONNEYT    VARCHAR2 (100);
      l_sip            VARCHAR2 (10);
      l_fstdate        DATE;
      l_tradingcycle   VARCHAR2 (500);
      l_cycletype      VARCHAR2 (10);
      l_monthtype      VARCHAR2 (10);
      l_autoid         VARCHAR2 (10);
      c                VARCHAR2 (10);
      l_str1           VARCHAR2 (500);
      l_str2           VARCHAR2 (500);
      l_str3           VARCHAR2 (500);
      l_str4           VARCHAR2 (500);
      l_RESULT         VARCHAR2 (500);
      m                NUMBER;
      l_FROM_VALUE     VARCHAR2 (50);
      l_holiday        VARCHAR2 (10);
      l_parentvalue    VARCHAR2 (100);
      l_tradingtype    VARCHAR2 (10);
      l_fromdate       VARCHAR2 (20);
      l_todate         VARCHAR2 (20);
      l_next_month     DATE;
      l_rbanktime      VARCHAR2 (20);
      l_isauto         VARCHAR2 (10);
      l_rbankday       VARCHAR2 (10);
      l_swrbankday     VARCHAR2 (10);
      l_ftype          VARCHAR2 (10);
      l_genschdday     VARCHAR2 (100);
      l_genschdtime    VARCHAR2 (100);
      l_naveom         VARCHAR2 (10);
   BEGIN
      plog.setbeginsection (pkgctx, 'fn_ProcessAfterApprove');

      plog.setendsection (pkgctx, 'fn_ProcessAfterApprove');
      RETURN systemnums.C_SUCCESS;
   EXCEPTION
      WHEN OTHERS
      THEN
         p_err_code := errnums.C_SYSTEM_ERROR;
         plog.error (pkgctx, SQLERRM || DBMS_UTILITY.format_error_backtrace);
         plog.setendsection (pkgctx, 'fn_ProcessAfterApprove');
         ROLLBACK;
         RAISE errnums.E_SYSTEM_ERROR;
   END fn_ProcessAfterApprove;

   FUNCTION fn_CheckBeforeReject (p_objmsg     IN OUT tx.obj_rectype,
                                  p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER
   IS
      l_count   NUMBER;
   BEGIN
      plog.setbeginsection (pkgctx, 'fn_CheckBeforeReject');

      plog.setendsection (pkgctx, 'fn_CheckBeforeReject');
      RETURN systemnums.C_SUCCESS;
   EXCEPTION
      WHEN OTHERS
      THEN
         p_err_code := errnums.C_SYSTEM_ERROR;
         plog.error (pkgctx, SQLERRM || DBMS_UTILITY.format_error_backtrace);
         plog.setendsection (pkgctx, 'fn_CheckBeforeReject');
         ROLLBACK;
         RAISE errnums.E_SYSTEM_ERROR;
   END fn_CheckBeforeReject;

   FUNCTION fn_ProcessAfterReject (p_objmsg     IN OUT tx.obj_rectype,
                                   p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER
   IS
      l_count        NUMBER;
      l_refobjid     VARCHAR2 (1000);
      l_actionflag   VARCHAR2 (100);
      l_childvalue   VARCHAR2 (100);
      l_childkey     VARCHAR2 (100);
      l_chiltable    VARCHAR2 (100);
   BEGIN
      plog.setbeginsection (pkgctx, 'fn_ProcessAfterReject');

      RETURN systemnums.C_SUCCESS;
   EXCEPTION
      WHEN OTHERS
      THEN
         p_err_code := errnums.C_SYSTEM_ERROR;
         plog.error (pkgctx, SQLERRM || DBMS_UTILITY.format_error_backtrace);
         plog.setendsection (pkgctx, 'fn_ProcessAfterReject');
         ROLLBACK;
         RAISE errnums.E_SYSTEM_ERROR;
   END fn_ProcessAfterReject;
BEGIN
   FOR i IN (SELECT * FROM tlogdebug)
   LOOP
      logrow.loglevel := i.loglevel;
      logrow.log4table := i.log4table;
      logrow.log4alert := i.log4alert;
      logrow.log4trace := i.log4trace;
   END LOOP;

   pkgctx :=
      plog.init ('txpks_#sa.tradingcycle',
                 plevel      => NVL (logrow.loglevel, 30),
                 plogtable   => (NVL (logrow.log4table, 'N') = 'Y'),
                 palert      => (NVL (logrow.log4alert, 'N') = 'Y'),
                 ptrace      => (NVL (logrow.log4trace, 'N') = 'Y'));
END txpks_#FA_FACOLLECTIONSCHEDULE;
/

DROP PACKAGE txpks_#fa_fafeeservice
/

CREATE OR REPLACE 
PACKAGE txpks_#fa_fafeeservice 
/** ----------------------------------------------------------------------------------------------------
 dung cho form maintenance
 ----------------------------------------------------------------------------------------------------*/
IS
   FUNCTION fn_Transfer (p_xmlmsg      IN OUT VARCHAR2,
                         p_err_code    IN OUT VARCHAR2,
                         p_err_param      OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_Add (p_objmsg     IN OUT tx.obj_rectype,
                    p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_Edit (p_objmsg     IN OUT tx.obj_rectype,
                     p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_Delete (p_objmsg     IN OUT tx.obj_rectype,
                       p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_Adhoc (p_objmsg     IN OUT tx.obj_rectype,
                      p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_Approve (p_objmsg     IN OUT tx.obj_rectype,
                        p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_Reject (p_objmsg     IN OUT tx.obj_rectype,
                       p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   --rieng
   FUNCTION fn_CheckBeforeAdd (p_objmsg     IN OUT tx.obj_rectype,
                               p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_CheckBeforeEdit (p_objmsg     IN OUT tx.obj_rectype,
                                p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_CheckBeforeDelete (p_objmsg     IN OUT tx.obj_rectype,
                                  p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_CheckBeforeApprove (p_objmsg     IN OUT tx.obj_rectype,
                                   p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_CheckBeforeReject (p_objmsg     IN OUT tx.obj_rectype,
                                  p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_ProcessAfterAdd (p_objmsg     IN OUT tx.obj_rectype,
                                p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_ProcessAfterEdit (p_objmsg     IN OUT tx.obj_rectype,
                                 p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_ProcessAfterDelete (p_objmsg     IN OUT tx.obj_rectype,
                                   p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_ProcessAfterApprove (p_objmsg     IN OUT tx.obj_rectype,
                                    p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_ProcessAfterReject (p_objmsg     IN OUT tx.obj_rectype,
                                   p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;
END;
/

DROP PACKAGE txpks_#fa_fafund
/

CREATE OR REPLACE 
PACKAGE txpks_#fa_fafund 
/** ----------------------------------------------------------------------------------------------------
 dung cho form maintenance
 ----------------------------------------------------------------------------------------------------*/
IS
   FUNCTION fn_Transfer (p_xmlmsg      IN OUT VARCHAR2,
                         p_err_code    IN OUT VARCHAR2,
                         p_err_param      OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_Add (p_objmsg     IN OUT tx.obj_rectype,
                    p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_Edit (p_objmsg     IN OUT tx.obj_rectype,
                     p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_Delete (p_objmsg     IN OUT tx.obj_rectype,
                       p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_Adhoc (p_objmsg     IN OUT tx.obj_rectype,
                      p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_Approve (p_objmsg     IN OUT tx.obj_rectype,
                        p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_Reject (p_objmsg     IN OUT tx.obj_rectype,
                       p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   --rieng
   FUNCTION fn_CheckBeforeAdd (p_objmsg     IN OUT tx.obj_rectype,
                               p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_CheckBeforeEdit (p_objmsg     IN OUT tx.obj_rectype,
                                p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_CheckBeforeDelete (p_objmsg     IN OUT tx.obj_rectype,
                                  p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_CheckBeforeApprove (p_objmsg     IN OUT tx.obj_rectype,
                                   p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_CheckBeforeReject (p_objmsg     IN OUT tx.obj_rectype,
                                  p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_ProcessAfterAdd (p_objmsg     IN OUT tx.obj_rectype,
                                p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_ProcessAfterEdit (p_objmsg     IN OUT tx.obj_rectype,
                                 p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_ProcessAfterDelete (p_objmsg     IN OUT tx.obj_rectype,
                                   p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_ProcessAfterApprove (p_objmsg     IN OUT tx.obj_rectype,
                                    p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_ProcessAfterReject (p_objmsg     IN OUT tx.obj_rectype,
                                   p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;
END;
/

DROP PACKAGE txpks_#fa_fafundacctbnk
/

CREATE OR REPLACE 
PACKAGE txpks_#fa_fafundacctbnk 
/** ----------------------------------------------------------------------------------------------------
 dung cho form maintenance
 ----------------------------------------------------------------------------------------------------*/
IS
   FUNCTION fn_Transfer (p_xmlmsg      IN OUT VARCHAR2,
                         p_err_code    IN OUT VARCHAR2,
                         p_err_param      OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_Add (p_objmsg     IN OUT tx.obj_rectype,
                    p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_Edit (p_objmsg     IN OUT tx.obj_rectype,
                     p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_Delete (p_objmsg     IN OUT tx.obj_rectype,
                       p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_Adhoc (p_objmsg     IN OUT tx.obj_rectype,
                      p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_Approve (p_objmsg     IN OUT tx.obj_rectype,
                        p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_Reject (p_objmsg     IN OUT tx.obj_rectype,
                       p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   --rieng
   FUNCTION fn_CheckBeforeAdd (p_objmsg     IN OUT tx.obj_rectype,
                               p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_CheckBeforeEdit (p_objmsg     IN OUT tx.obj_rectype,
                                p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_CheckBeforeDelete (p_objmsg     IN OUT tx.obj_rectype,
                                  p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_CheckBeforeApprove (p_objmsg     IN OUT tx.obj_rectype,
                                   p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_CheckBeforeReject (p_objmsg     IN OUT tx.obj_rectype,
                                  p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_ProcessAfterAdd (p_objmsg     IN OUT tx.obj_rectype,
                                p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_ProcessAfterEdit (p_objmsg     IN OUT tx.obj_rectype,
                                 p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_ProcessAfterDelete (p_objmsg     IN OUT tx.obj_rectype,
                                   p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_ProcessAfterApprove (p_objmsg     IN OUT tx.obj_rectype,
                                    p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_ProcessAfterReject (p_objmsg     IN OUT tx.obj_rectype,
                                   p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;
END;
/

DROP PACKAGE txpks_#fa_fafundacctsf
/

CREATE OR REPLACE 
PACKAGE txpks_#fa_fafundacctsf 
/** ----------------------------------------------------------------------------------------------------
 dung cho form maintenance
 ----------------------------------------------------------------------------------------------------*/
IS
   FUNCTION fn_Transfer (p_xmlmsg      IN OUT VARCHAR2,
                         p_err_code    IN OUT VARCHAR2,
                         p_err_param      OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_Add (p_objmsg     IN OUT tx.obj_rectype,
                    p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_Edit (p_objmsg     IN OUT tx.obj_rectype,
                     p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_Delete (p_objmsg     IN OUT tx.obj_rectype,
                       p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_Adhoc (p_objmsg     IN OUT tx.obj_rectype,
                      p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_Approve (p_objmsg     IN OUT tx.obj_rectype,
                        p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_Reject (p_objmsg     IN OUT tx.obj_rectype,
                       p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   --rieng
   FUNCTION fn_CheckBeforeAdd (p_objmsg     IN OUT tx.obj_rectype,
                               p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_CheckBeforeEdit (p_objmsg     IN OUT tx.obj_rectype,
                                p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_CheckBeforeDelete (p_objmsg     IN OUT tx.obj_rectype,
                                  p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_CheckBeforeApprove (p_objmsg     IN OUT tx.obj_rectype,
                                   p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_CheckBeforeReject (p_objmsg     IN OUT tx.obj_rectype,
                                  p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_ProcessAfterAdd (p_objmsg     IN OUT tx.obj_rectype,
                                p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_ProcessAfterEdit (p_objmsg     IN OUT tx.obj_rectype,
                                 p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_ProcessAfterDelete (p_objmsg     IN OUT tx.obj_rectype,
                                   p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_ProcessAfterApprove (p_objmsg     IN OUT tx.obj_rectype,
                                    p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_ProcessAfterReject (p_objmsg     IN OUT tx.obj_rectype,
                                   p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;
END;
/

DROP PACKAGE txpks_#fa_faobject
/

CREATE OR REPLACE 
PACKAGE txpks_#fa_faobject 
/** ----------------------------------------------------------------------------------------------------
 dung cho form maintenance
 ----------------------------------------------------------------------------------------------------*/
IS
   FUNCTION fn_Transfer (p_xmlmsg      IN OUT VARCHAR2,
                         p_err_code    IN OUT VARCHAR2,
                         p_err_param      OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_Add (p_objmsg     IN OUT tx.obj_rectype,
                    p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_Edit (p_objmsg     IN OUT tx.obj_rectype,
                     p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_Delete (p_objmsg     IN OUT tx.obj_rectype,
                       p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_Adhoc (p_objmsg     IN OUT tx.obj_rectype,
                      p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_Approve (p_objmsg     IN OUT tx.obj_rectype,
                        p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_Reject (p_objmsg     IN OUT tx.obj_rectype,
                       p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   --rieng
   FUNCTION fn_CheckBeforeAdd (p_objmsg     IN OUT tx.obj_rectype,
                               p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_CheckBeforeEdit (p_objmsg     IN OUT tx.obj_rectype,
                                p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_CheckBeforeDelete (p_objmsg     IN OUT tx.obj_rectype,
                                  p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_CheckBeforeApprove (p_objmsg     IN OUT tx.obj_rectype,
                                   p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_CheckBeforeReject (p_objmsg     IN OUT tx.obj_rectype,
                                  p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_ProcessAfterAdd (p_objmsg     IN OUT tx.obj_rectype,
                                p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_ProcessAfterEdit (p_objmsg     IN OUT tx.obj_rectype,
                                 p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_ProcessAfterDelete (p_objmsg     IN OUT tx.obj_rectype,
                                   p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_ProcessAfterApprove (p_objmsg     IN OUT tx.obj_rectype,
                                    p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_ProcessAfterReject (p_objmsg     IN OUT tx.obj_rectype,
                                   p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;
END;
/

DROP PACKAGE txpks_#fa_feeinfor
/

CREATE OR REPLACE 
PACKAGE txpks_#fa_feeinfor 
/** ----------------------------------------------------------------------------------------------------
 dung cho form maintenance
 ----------------------------------------------------------------------------------------------------*/
IS
   FUNCTION fn_Transfer (p_xmlmsg      IN OUT VARCHAR2,
                         p_err_code    IN OUT VARCHAR2,
                         p_err_param      OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_Add (p_objmsg     IN OUT tx.obj_rectype,
                    p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_Edit (p_objmsg     IN OUT tx.obj_rectype,
                     p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_Delete (p_objmsg     IN OUT tx.obj_rectype,
                       p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_Adhoc (p_objmsg     IN OUT tx.obj_rectype,
                      p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_Approve (p_objmsg     IN OUT tx.obj_rectype,
                        p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_Reject (p_objmsg     IN OUT tx.obj_rectype,
                       p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   --rieng
   FUNCTION fn_CheckBeforeAdd (p_objmsg     IN OUT tx.obj_rectype,
                               p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_CheckBeforeEdit (p_objmsg     IN OUT tx.obj_rectype,
                                p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_CheckBeforeDelete (p_objmsg     IN OUT tx.obj_rectype,
                                  p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_CheckBeforeApprove (p_objmsg     IN OUT tx.obj_rectype,
                                   p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_CheckBeforeReject (p_objmsg     IN OUT tx.obj_rectype,
                                  p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_ProcessAfterAdd (p_objmsg     IN OUT tx.obj_rectype,
                                p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_ProcessAfterEdit (p_objmsg     IN OUT tx.obj_rectype,
                                 p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_ProcessAfterDelete (p_objmsg     IN OUT tx.obj_rectype,
                                   p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_ProcessAfterApprove (p_objmsg     IN OUT tx.obj_rectype,
                                    p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_ProcessAfterReject (p_objmsg     IN OUT tx.obj_rectype,
                                   p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;
END;
/

CREATE OR REPLACE 
PACKAGE BODY txpks_#fa_feeinfor 
IS
   pkgctx   plog.log_ctx;
   logrow   tlogdebug%ROWTYPE;

   FUNCTION fn_Transfer (p_xmlmsg      IN OUT VARCHAR2,
                         p_err_code    IN OUT VARCHAR2,
                         p_err_param      OUT VARCHAR2)
      RETURN NUMBER
   IS
      l_return_code   VARCHAR2 (30) := systemnums.C_SUCCESS;
      l_objmsg        tx.obj_rectype;
      l_count         NUMBER (3);
      l_msgtype       VARCHAR2 (10);
      l_objname       VARCHAR2 (100);
      l_actionflag    VARCHAR2 (100);
      l_currdate      VARCHAR2 (10);
   BEGIN
      plog.setbeginsection (pkgctx, 'fn_Transfer');
      plog.debug (pkgctx, 'fn_Transfer');
      --get object
      l_objmsg := txpks_msg.fn_mt_xml2obj (p_xmlmsg);
      l_msgtype := l_objmsg.MSGTYPE;
      l_objname := l_objmsg.OBJNAME;
      l_actionflag := l_objmsg.ACTIONFLAG;

      --Kiem tra msgtype de phan luong xu ly
      IF l_actionflag = 'ADD'
      THEN
         IF fn_Add (l_objmsg, p_err_code) <> systemnums.C_SUCCESS
         THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
         END IF;
      ELSIF l_actionflag = 'EDIT'
      THEN
         IF fn_Edit (l_objmsg, p_err_code) <> systemnums.C_SUCCESS
         THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
         END IF;
      ELSIF l_actionflag = 'DELETE'
      THEN
         IF fn_Delete (l_objmsg, p_err_code) <> systemnums.C_SUCCESS
         THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
         END IF;
      ELSIF l_actionflag = 'ADHOC'
      THEN
         IF fn_Adhoc (l_objmsg, p_err_code) <> systemnums.C_SUCCESS
         THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
         END IF;
      ELSIF l_actionflag = 'APPROVE'
      THEN
         IF fn_Approve (l_objmsg, p_err_code) <> systemnums.C_SUCCESS
         THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
         END IF;
      ELSIF l_actionflag = 'REJECT'
      THEN
         IF fn_Reject (l_objmsg, p_err_code) <> systemnums.C_SUCCESS
         THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
         END IF;
      END IF;

      plog.debug (pkgctx, 'fn_Transfer');
      plog.setendsection (pkgctx, 'fn_Transfer');
      RETURN l_return_code;
   EXCEPTION
      WHEN errnums.E_BIZ_RULE_INVALID
      THEN
         FOR I IN (SELECT ERRDESC, EN_ERRDESC
                     FROM deferror
                    WHERE ERRNUM = p_err_code)
         LOOP
            p_err_param := i.errdesc;
         END LOOP;

         p_xmlmsg := txpks_msg.fn_mt_obj2xml (l_objmsg);
         plog.setendsection (pkgctx, 'fn_Transfer');
         ROLLBACK;
         RETURN errnums.C_BIZ_RULE_INVALID;
      WHEN OTHERS
      THEN
         p_err_code := errnums.C_SYSTEM_ERROR;
         p_err_param := 'SYSTEM_ERROR';
         plog.error (pkgctx, SQLERRM || DBMS_UTILITY.format_error_backtrace);
         p_xmlmsg := txpks_msg.fn_mt_obj2xml (l_objmsg);
         plog.setendsection (pkgctx, 'fn_Transfer');
         RETURN errnums.C_SYSTEM_ERROR;
   END fn_Transfer;

   FUNCTION fn_Add (p_objmsg     IN OUT tx.obj_rectype,
                    p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER
   IS
   BEGIN
      plog.setbeginsection (pkgctx, 'fn_Add');

      -- Check befor add
      IF txpks_#fa_FEEINFOR.fn_CheckBeforeAdd (p_objmsg, p_err_code) <>
            systemnums.C_SUCCESS
      THEN
         RETURN errnums.C_BIZ_RULE_INVALID;
      END IF;

      -- Auto add
      IF txpks_maintain.fn_ProcessAdd (p_objmsg, p_err_code) <>
            systemnums.C_SUCCESS
      THEN
         RETURN errnums.C_BIZ_RULE_INVALID;
      END IF;

      -- After Add
      IF txpks_#fa_FEEINFOR.fn_ProcessAfterAdd (p_objmsg, p_err_code) <>
            systemnums.C_SUCCESS
      THEN
         RETURN errnums.C_BIZ_RULE_INVALID;
      END IF;

      --ghi log
      IF txpks_maintain.fn_MaintainLog (p_objmsg, p_err_code) <>
            systemnums.C_SUCCESS
      THEN
         RETURN errnums.C_BIZ_RULE_INVALID;
      END IF;

      plog.setendsection (pkgctx, 'fn_Add');
      RETURN systemnums.C_SUCCESS;
   EXCEPTION
      WHEN OTHERS
      THEN
         p_err_code := errnums.C_SYSTEM_ERROR;
         plog.error (pkgctx, SQLERRM || DBMS_UTILITY.format_error_backtrace);
         plog.setendsection (pkgctx, 'fn_Add');
         ROLLBACK;
         RAISE errnums.E_SYSTEM_ERROR;
   END fn_Add;

   FUNCTION fn_Edit (p_objmsg     IN OUT tx.obj_rectype,
                     p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER
   IS
   BEGIN
      plog.setbeginsection (pkgctx, 'fn_Edit');

      -- Check befor edit
      IF txpks_#fa_FEEINFOR.fn_CheckBeforeEdit (p_objmsg, p_err_code) <>
            systemnums.C_SUCCESS
      THEN
         RETURN errnums.C_BIZ_RULE_INVALID;
      END IF;

      -- Auto Edit
      IF txpks_maintain.fn_ProcessEdit (p_objmsg, p_err_code) <>
            systemnums.C_SUCCESS
      THEN
         RETURN errnums.C_BIZ_RULE_INVALID;
      END IF;

      -- After Edit
      IF txpks_#fa_FEEINFOR.fn_ProcessAfterEdit (p_objmsg, p_err_code) <>
            systemnums.C_SUCCESS
      THEN
         RETURN errnums.C_BIZ_RULE_INVALID;
      END IF;

      --ghi log
      IF txpks_maintain.fn_MaintainLog (p_objmsg, p_err_code) <>
            systemnums.C_SUCCESS
      THEN
         RETURN errnums.C_BIZ_RULE_INVALID;
      END IF;

      plog.setendsection (pkgctx, 'fn_Edit');
      RETURN systemnums.C_SUCCESS;
   EXCEPTION
      WHEN OTHERS
      THEN
         p_err_code := errnums.C_SYSTEM_ERROR;
         plog.error (pkgctx, SQLERRM || DBMS_UTILITY.format_error_backtrace);
         plog.setendsection (pkgctx, 'fn_Edit');
         ROLLBACK;
         RAISE errnums.E_SYSTEM_ERROR;
   END fn_Edit;

   FUNCTION fn_Delete (p_objmsg     IN OUT tx.obj_rectype,
                       p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER
   IS
   BEGIN
      plog.setbeginsection (pkgctx, 'fn_Delete');

      -- Check befor Delete
      IF txpks_#fa_FEEINFOR.fn_CheckBeforeDelete (p_objmsg, p_err_code) <>
            systemnums.C_SUCCESS
      THEN
         RETURN errnums.C_BIZ_RULE_INVALID;
      END IF;

      -- Auto Delete
      IF txpks_maintain.fn_ProcessDelete (p_objmsg, p_err_code) <>
            systemnums.C_SUCCESS
      THEN
         RETURN errnums.C_BIZ_RULE_INVALID;
      END IF;

      -- After Delete
      IF txpks_#fa_FEEINFOR.fn_ProcessAfterDelete (p_objmsg, p_err_code) <>
            systemnums.C_SUCCESS
      THEN
         RETURN errnums.C_BIZ_RULE_INVALID;
      END IF;

      --ghi log
      IF txpks_maintain.fn_MaintainLog (p_objmsg, p_err_code) <>
            systemnums.C_SUCCESS
      THEN
         RETURN errnums.C_BIZ_RULE_INVALID;
      END IF;

      plog.setendsection (pkgctx, 'fn_Delete');
      RETURN systemnums.C_SUCCESS;
   EXCEPTION
      WHEN OTHERS
      THEN
         p_err_code := errnums.C_SYSTEM_ERROR;
         plog.error (pkgctx, SQLERRM || DBMS_UTILITY.format_error_backtrace);
         plog.setendsection (pkgctx, 'fn_Delete');
         ROLLBACK;
         RAISE errnums.E_SYSTEM_ERROR;
   END fn_Delete;

   FUNCTION fn_Adhoc (p_objmsg     IN OUT tx.obj_rectype,
                      p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER
   IS
   BEGIN
      plog.setbeginsection (pkgctx, 'fn_Adhoc');

      plog.setendsection (pkgctx, 'fn_Adhoc');
      RETURN systemnums.C_SUCCESS;
   EXCEPTION
      WHEN OTHERS
      THEN
         p_err_code := errnums.C_SYSTEM_ERROR;
         plog.error (pkgctx, SQLERRM || DBMS_UTILITY.format_error_backtrace);
         plog.setendsection (pkgctx, 'fn_Adhoc');
         ROLLBACK;
         RAISE errnums.E_SYSTEM_ERROR;
   END fn_Adhoc;

   FUNCTION fn_Approve (p_objmsg     IN OUT tx.obj_rectype,
                        p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER
   IS
   BEGIN
      plog.setbeginsection (pkgctx, 'fn_Approve');

      IF txpks_maintain.fn_Approve (p_objmsg, p_err_code) <>
            systemnums.C_SUCCESS
      THEN
         RETURN errnums.C_BIZ_RULE_INVALID;
      END IF;

      plog.setendsection (pkgctx, 'fn_Approve');
      RETURN systemnums.C_SUCCESS;
   EXCEPTION
      WHEN OTHERS
      THEN
         p_err_code := errnums.C_SYSTEM_ERROR;
         plog.error (pkgctx, SQLERRM || DBMS_UTILITY.format_error_backtrace);
         plog.setendsection (pkgctx, 'fn_Approve');
         ROLLBACK;
         RAISE errnums.E_SYSTEM_ERROR;
   END fn_Approve;

   FUNCTION fn_Reject (p_objmsg     IN OUT tx.obj_rectype,
                       p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER
   IS
   BEGIN
      plog.setbeginsection (pkgctx, 'fn_Reject');

      IF txpks_maintain.fn_Reject (p_objmsg, p_err_code) <>
            systemnums.C_SUCCESS
      THEN
         RETURN errnums.C_BIZ_RULE_INVALID;
      END IF;

      plog.setendsection (pkgctx, 'fn_Reject');
      RETURN systemnums.C_SUCCESS;
   EXCEPTION
      WHEN OTHERS
      THEN
         p_err_code := errnums.C_SYSTEM_ERROR;
         plog.error (pkgctx, SQLERRM || DBMS_UTILITY.format_error_backtrace);
         plog.setendsection (pkgctx, 'fn_Reject');
         ROLLBACK;
         RAISE errnums.E_SYSTEM_ERROR;
   END fn_Reject;


   FUNCTION fn_CheckBeforeAdd (p_objmsg     IN OUT tx.obj_rectype,
                               p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER
   IS
      l_count   NUMBER;
   BEGIN
      plog.setbeginsection (pkgctx, 'fn_CheckBeforeAdd');
      plog.setendsection (pkgctx, 'fn_CheckBeforeAdd');
      RETURN systemnums.C_SUCCESS;
   EXCEPTION
      WHEN OTHERS
      THEN
         p_err_code := errnums.C_SYSTEM_ERROR;
         plog.error (pkgctx, SQLERRM || DBMS_UTILITY.format_error_backtrace);
         plog.setendsection (pkgctx, 'fn_CheckBeforeAdd');
         ROLLBACK;
         RAISE errnums.E_SYSTEM_ERROR;
   END fn_CheckBeforeAdd;

   FUNCTION fn_ProcessAfterAdd (p_objmsg     IN OUT tx.obj_rectype,
                                p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER
   IS
      l_count   NUMBER;
   BEGIN
      plog.setbeginsection (pkgctx, 'fn_ProcessAfterAdd');

      plog.setendsection (pkgctx, 'fn_ProcessAfterAdd');
      RETURN systemnums.C_SUCCESS;
   EXCEPTION
      WHEN OTHERS
      THEN
         p_err_code := errnums.C_SYSTEM_ERROR;
         plog.error (pkgctx, SQLERRM || DBMS_UTILITY.format_error_backtrace);
         plog.setendsection (pkgctx, 'fn_ProcessAfterAdd');
         ROLLBACK;
         RAISE errnums.E_SYSTEM_ERROR;
   END fn_ProcessAfterAdd;

   FUNCTION fn_CheckBeforeEdit (p_objmsg     IN OUT tx.obj_rectype,
                                p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER
   IS
      l_count   NUMBER;
   BEGIN
      plog.setbeginsection (pkgctx, 'fn_CheckBeforeEdit');

      plog.setendsection (pkgctx, 'fn_CheckBeforeEdit');
      RETURN systemnums.C_SUCCESS;
   EXCEPTION
      WHEN OTHERS
      THEN
         p_err_code := errnums.C_SYSTEM_ERROR;
         plog.error (pkgctx, SQLERRM || DBMS_UTILITY.format_error_backtrace);
         plog.setendsection (pkgctx, 'fn_CheckBeforeEdit');
         ROLLBACK;
         RAISE errnums.E_SYSTEM_ERROR;
   END fn_CheckBeforeEdit;

   FUNCTION fn_ProcessAfterEdit (p_objmsg     IN OUT tx.obj_rectype,
                                 p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER
   IS
      l_count   NUMBER;
   BEGIN
      plog.setbeginsection (pkgctx, 'fn_ProcessAfterEdit');

      plog.setendsection (pkgctx, 'fn_ProcessAfterEdit');
      RETURN systemnums.C_SUCCESS;
   EXCEPTION
      WHEN OTHERS
      THEN
         p_err_code := errnums.C_SYSTEM_ERROR;
         plog.error (pkgctx, SQLERRM || DBMS_UTILITY.format_error_backtrace);
         plog.setendsection (pkgctx, 'fn_ProcessAfterEdit');
         ROLLBACK;
         RAISE errnums.E_SYSTEM_ERROR;
   END fn_ProcessAfterEdit;

   FUNCTION fn_CheckBeforeDelete (p_objmsg     IN OUT tx.obj_rectype,
                                  p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER
   IS
      l_count   NUMBER;
   BEGIN
      plog.setbeginsection (pkgctx, 'fn_CheckBeforeDelete');

      plog.setendsection (pkgctx, 'fn_CheckBeforeDelete');
      RETURN systemnums.C_SUCCESS;
   EXCEPTION
      WHEN OTHERS
      THEN
         p_err_code := errnums.C_SYSTEM_ERROR;
         plog.error (pkgctx, SQLERRM || DBMS_UTILITY.format_error_backtrace);
         plog.setendsection (pkgctx, 'fn_CheckBeforeDelete');
         ROLLBACK;
         RAISE errnums.E_SYSTEM_ERROR;
   END fn_CheckBeforeDelete;

   FUNCTION fn_ProcessAfterDelete (p_objmsg     IN OUT tx.obj_rectype,
                                   p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER
   IS
      l_count   NUMBER;
   BEGIN
      plog.setbeginsection (pkgctx, 'fn_ProcessAfterDelete');

      plog.setendsection (pkgctx, 'fn_ProcessAfterDelete');
      RETURN systemnums.C_SUCCESS;
   EXCEPTION
      WHEN OTHERS
      THEN
         p_err_code := errnums.C_SYSTEM_ERROR;
         plog.error (pkgctx, SQLERRM || DBMS_UTILITY.format_error_backtrace);
         plog.setendsection (pkgctx, 'fn_ProcessAfterDelete');
         ROLLBACK;
         RAISE errnums.E_SYSTEM_ERROR;
   END fn_ProcessAfterDelete;

   FUNCTION fn_CheckBeforeApprove (p_objmsg     IN OUT tx.obj_rectype,
                                   p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER
   IS
      l_count   NUMBER;
   BEGIN
      plog.setbeginsection (pkgctx, 'fn_CheckBeforeApprove');

      plog.setendsection (pkgctx, 'fn_CheckBeforeApprove');
      RETURN systemnums.C_SUCCESS;
   EXCEPTION
      WHEN OTHERS
      THEN
         p_err_code := errnums.C_SYSTEM_ERROR;
         plog.error (pkgctx, SQLERRM || DBMS_UTILITY.format_error_backtrace);
         plog.setendsection (pkgctx, 'fn_CheckBeforeApprove');
         ROLLBACK;
         RAISE errnums.E_SYSTEM_ERROR;
   END fn_CheckBeforeApprove;

   FUNCTION fn_ProcessAfterApprove (p_objmsg     IN OUT tx.obj_rectype,
                                    p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER
   IS
      l_count   NUMBER;
   BEGIN
      plog.setbeginsection (pkgctx, 'fn_ProcessAfterApprove');

      plog.setendsection (pkgctx, 'fn_ProcessAfterApprove');
      RETURN systemnums.C_SUCCESS;
   EXCEPTION
      WHEN OTHERS
      THEN
         p_err_code := errnums.C_SYSTEM_ERROR;
         plog.error (pkgctx, SQLERRM || DBMS_UTILITY.format_error_backtrace);
         plog.setendsection (pkgctx, 'fn_ProcessAfterApprove');
         ROLLBACK;
         RAISE errnums.E_SYSTEM_ERROR;
   END fn_ProcessAfterApprove;

   FUNCTION fn_CheckBeforeReject (p_objmsg     IN OUT tx.obj_rectype,
                                  p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER
   IS
      l_count   NUMBER;
   BEGIN
      plog.setbeginsection (pkgctx, 'fn_CheckBeforeReject');

      plog.setendsection (pkgctx, 'fn_CheckBeforeReject');
      RETURN systemnums.C_SUCCESS;
   EXCEPTION
      WHEN OTHERS
      THEN
         p_err_code := errnums.C_SYSTEM_ERROR;
         plog.error (pkgctx, SQLERRM || DBMS_UTILITY.format_error_backtrace);
         plog.setendsection (pkgctx, 'fn_CheckBeforeReject');
         ROLLBACK;
         RAISE errnums.E_SYSTEM_ERROR;
   END fn_CheckBeforeReject;

   FUNCTION fn_ProcessAfterReject (p_objmsg     IN OUT tx.obj_rectype,
                                   p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER
   IS
      l_count   NUMBER;
   BEGIN
      plog.setbeginsection (pkgctx, 'fn_ProcessAfterReject');

      plog.setendsection (pkgctx, 'fn_ProcessAfterReject');
      RETURN systemnums.C_SUCCESS;
   EXCEPTION
      WHEN OTHERS
      THEN
         p_err_code := errnums.C_SYSTEM_ERROR;
         plog.error (pkgctx, SQLERRM || DBMS_UTILITY.format_error_backtrace);
         plog.setendsection (pkgctx, 'fn_ProcessAfterReject');
         ROLLBACK;
         RAISE errnums.E_SYSTEM_ERROR;
   END fn_ProcessAfterReject;
BEGIN
   FOR i IN (SELECT * FROM tlogdebug)
   LOOP
      logrow.loglevel := i.loglevel;
      logrow.log4table := i.log4table;
      logrow.log4alert := i.log4alert;
      logrow.log4trace := i.log4trace;
   END LOOP;

   pkgctx :=
      plog.init ('txpks_#sa.fmember',
                 plevel      => NVL (logrow.loglevel, 30),
                 plogtable   => (NVL (logrow.log4table, 'N') = 'Y'),
                 palert      => (NVL (logrow.log4alert, 'N') = 'Y'),
                 ptrace      => (NVL (logrow.log4trace, 'N') = 'Y'));
END txpks_#fa_FEEINFOR;
/

DROP PACKAGE txpks_#fa_instrlist
/

CREATE OR REPLACE 
PACKAGE txpks_#fa_instrlist 
/** ----------------------------------------------------------------------------------------------------
 dung cho form maintenance
 ----------------------------------------------------------------------------------------------------*/
IS
   FUNCTION fn_Transfer (p_xmlmsg      IN OUT VARCHAR2,
                         p_err_code    IN OUT VARCHAR2,
                         p_err_param      OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_Add (p_objmsg     IN OUT tx.obj_rectype,
                    p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_Edit (p_objmsg     IN OUT tx.obj_rectype,
                     p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_Delete (p_objmsg     IN OUT tx.obj_rectype,
                       p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_Adhoc (p_objmsg     IN OUT tx.obj_rectype,
                      p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_Approve (p_objmsg     IN OUT tx.obj_rectype,
                        p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_Reject (p_objmsg     IN OUT tx.obj_rectype,
                       p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   --rieng
   FUNCTION fn_CheckBeforeAdd (p_objmsg     IN OUT tx.obj_rectype,
                               p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_CheckBeforeEdit (p_objmsg     IN OUT tx.obj_rectype,
                                p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_CheckBeforeDelete (p_objmsg     IN OUT tx.obj_rectype,
                                  p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_CheckBeforeApprove (p_objmsg     IN OUT tx.obj_rectype,
                                   p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_CheckBeforeReject (p_objmsg     IN OUT tx.obj_rectype,
                                  p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_ProcessAfterAdd (p_objmsg     IN OUT tx.obj_rectype,
                                p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_ProcessAfterEdit (p_objmsg     IN OUT tx.obj_rectype,
                                 p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_ProcessAfterDelete (p_objmsg     IN OUT tx.obj_rectype,
                                   p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_ProcessAfterApprove (p_objmsg     IN OUT tx.obj_rectype,
                                    p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_ProcessAfterReject (p_objmsg     IN OUT tx.obj_rectype,
                                   p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;
END;
/

DROP PACKAGE txpks_#fa_instrlistinfo
/

CREATE OR REPLACE 
PACKAGE txpks_#fa_instrlistinfo 
/** ----------------------------------------------------------------------------------------------------
 dung cho form maintenance
 ----------------------------------------------------------------------------------------------------*/
IS
   FUNCTION fn_Transfer (p_xmlmsg      IN OUT VARCHAR2,
                         p_err_code    IN OUT VARCHAR2,
                         p_err_param      OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_Add (p_objmsg     IN OUT tx.obj_rectype,
                    p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_Edit (p_objmsg     IN OUT tx.obj_rectype,
                     p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_Delete (p_objmsg     IN OUT tx.obj_rectype,
                       p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_Adhoc (p_objmsg     IN OUT tx.obj_rectype,
                      p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_Approve (p_objmsg     IN OUT tx.obj_rectype,
                        p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_Reject (p_objmsg     IN OUT tx.obj_rectype,
                       p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   --rieng
   FUNCTION fn_CheckBeforeAdd (p_objmsg     IN OUT tx.obj_rectype,
                               p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_CheckBeforeEdit (p_objmsg     IN OUT tx.obj_rectype,
                                p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_CheckBeforeDelete (p_objmsg     IN OUT tx.obj_rectype,
                                  p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_CheckBeforeApprove (p_objmsg     IN OUT tx.obj_rectype,
                                   p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_CheckBeforeReject (p_objmsg     IN OUT tx.obj_rectype,
                                  p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_ProcessAfterAdd (p_objmsg     IN OUT tx.obj_rectype,
                                p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_ProcessAfterEdit (p_objmsg     IN OUT tx.obj_rectype,
                                 p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_ProcessAfterDelete (p_objmsg     IN OUT tx.obj_rectype,
                                   p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_ProcessAfterApprove (p_objmsg     IN OUT tx.obj_rectype,
                                    p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_ProcessAfterReject (p_objmsg     IN OUT tx.obj_rectype,
                                   p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;
END;
/

DROP PACKAGE txpks_#fa_instrregprice
/

CREATE OR REPLACE 
PACKAGE txpks_#fa_instrregprice 
/** ----------------------------------------------------------------------------------------------------
 dung cho form maintenance
 ----------------------------------------------------------------------------------------------------*/
IS
   FUNCTION fn_Transfer (p_xmlmsg      IN OUT VARCHAR2,
                         p_err_code    IN OUT VARCHAR2,
                         p_err_param      OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_Add (p_objmsg     IN OUT tx.obj_rectype,
                    p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_Edit (p_objmsg     IN OUT tx.obj_rectype,
                     p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_Delete (p_objmsg     IN OUT tx.obj_rectype,
                       p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_Adhoc (p_objmsg     IN OUT tx.obj_rectype,
                      p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_Approve (p_objmsg     IN OUT tx.obj_rectype,
                        p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_Reject (p_objmsg     IN OUT tx.obj_rectype,
                       p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   --rieng
   FUNCTION fn_CheckBeforeAdd (p_objmsg     IN OUT tx.obj_rectype,
                               p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_CheckBeforeEdit (p_objmsg     IN OUT tx.obj_rectype,
                                p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_CheckBeforeDelete (p_objmsg     IN OUT tx.obj_rectype,
                                  p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_CheckBeforeApprove (p_objmsg     IN OUT tx.obj_rectype,
                                   p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_CheckBeforeReject (p_objmsg     IN OUT tx.obj_rectype,
                                  p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_ProcessAfterAdd (p_objmsg     IN OUT tx.obj_rectype,
                                p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_ProcessAfterEdit (p_objmsg     IN OUT tx.obj_rectype,
                                 p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_ProcessAfterDelete (p_objmsg     IN OUT tx.obj_rectype,
                                   p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_ProcessAfterApprove (p_objmsg     IN OUT tx.obj_rectype,
                                    p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_ProcessAfterReject (p_objmsg     IN OUT tx.obj_rectype,
                                   p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;
END;
/

DROP PACKAGE txpks_#fa_servicecontract
/

CREATE OR REPLACE 
PACKAGE txpks_#fa_servicecontract 
/** ----------------------------------------------------------------------------------------------------
 dung cho form maintenance
 ----------------------------------------------------------------------------------------------------*/
IS
   FUNCTION fn_Transfer (p_xmlmsg      IN OUT VARCHAR2,
                         p_err_code    IN OUT VARCHAR2,
                         p_err_param      OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_Add (p_objmsg     IN OUT tx.obj_rectype,
                    p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_Edit (p_objmsg     IN OUT tx.obj_rectype,
                     p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_Delete (p_objmsg     IN OUT tx.obj_rectype,
                       p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_Adhoc (p_objmsg     IN OUT tx.obj_rectype,
                      p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_Approve (p_objmsg     IN OUT tx.obj_rectype,
                        p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_Reject (p_objmsg     IN OUT tx.obj_rectype,
                       p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   --rieng
   FUNCTION fn_CheckBeforeAdd (p_objmsg     IN OUT tx.obj_rectype,
                               p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_CheckBeforeEdit (p_objmsg     IN OUT tx.obj_rectype,
                                p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_CheckBeforeDelete (p_objmsg     IN OUT tx.obj_rectype,
                                  p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_CheckBeforeApprove (p_objmsg     IN OUT tx.obj_rectype,
                                   p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_CheckBeforeReject (p_objmsg     IN OUT tx.obj_rectype,
                                  p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_ProcessAfterAdd (p_objmsg     IN OUT tx.obj_rectype,
                                p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_ProcessAfterEdit (p_objmsg     IN OUT tx.obj_rectype,
                                 p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_ProcessAfterDelete (p_objmsg     IN OUT tx.obj_rectype,
                                   p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_ProcessAfterApprove (p_objmsg     IN OUT tx.obj_rectype,
                                    p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;

   FUNCTION fn_ProcessAfterReject (p_objmsg     IN OUT tx.obj_rectype,
                                   p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER;
END;
/

CREATE OR REPLACE 
PACKAGE BODY txpks_#fa_servicecontract 
IS
   pkgctx   plog.log_ctx;
   logrow   tlogdebug%ROWTYPE;

   FUNCTION fn_Transfer (p_xmlmsg      IN OUT VARCHAR2,
                         p_err_code    IN OUT VARCHAR2,
                         p_err_param      OUT VARCHAR2)
      RETURN NUMBER
   IS
      l_return_code   VARCHAR2 (30) := systemnums.C_SUCCESS;
      l_objmsg        tx.obj_rectype;
      l_count         NUMBER (3);
      l_msgtype       VARCHAR2 (10);
      l_objname       VARCHAR2 (100);
      l_actionflag    VARCHAR2 (100);
      l_currdate      VARCHAR2 (10);
   BEGIN
      plog.setbeginsection (pkgctx, 'fn_Transfer');
      plog.debug (pkgctx, 'fn_Transfer');
      --get object
      l_objmsg := txpks_msg.fn_mt_xml2obj (p_xmlmsg);
      l_msgtype := l_objmsg.MSGTYPE;
      l_objname := l_objmsg.OBJNAME;
      l_actionflag := l_objmsg.ACTIONFLAG;

      --Kiem tra msgtype de phan luong xu ly
      IF l_actionflag = 'ADD'
      THEN
         IF fn_Add (l_objmsg, p_err_code) <> systemnums.C_SUCCESS
         THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
         END IF;
      ELSIF l_actionflag = 'EDIT'
      THEN
         IF fn_Edit (l_objmsg, p_err_code) <> systemnums.C_SUCCESS
         THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
         END IF;
      ELSIF l_actionflag = 'DELETE'
      THEN
         IF fn_Delete (l_objmsg, p_err_code) <> systemnums.C_SUCCESS
         THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
         END IF;
      ELSIF l_actionflag = 'ADHOC'
      THEN
         IF fn_Adhoc (l_objmsg, p_err_code) <> systemnums.C_SUCCESS
         THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
         END IF;
      ELSIF l_actionflag = 'APPROVE'
      THEN
         IF fn_Approve (l_objmsg, p_err_code) <> systemnums.C_SUCCESS
         THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
         END IF;
      ELSIF l_actionflag = 'REJECT'
      THEN
         IF fn_Reject (l_objmsg, p_err_code) <> systemnums.C_SUCCESS
         THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
         END IF;
      END IF;

      plog.debug (pkgctx, 'fn_Transfer');
      plog.setendsection (pkgctx, 'fn_Transfer');
      RETURN l_return_code;
   EXCEPTION
      WHEN errnums.E_BIZ_RULE_INVALID
      THEN
         FOR I IN (SELECT ERRDESC, EN_ERRDESC
                     FROM deferror
                    WHERE ERRNUM = p_err_code)
         LOOP
            p_err_param := i.errdesc;
         END LOOP;

         p_xmlmsg := txpks_msg.fn_mt_obj2xml (l_objmsg);
         plog.setendsection (pkgctx, 'fn_Transfer');
         ROLLBACK;
         RETURN errnums.C_BIZ_RULE_INVALID;
      WHEN OTHERS
      THEN
         p_err_code := errnums.C_SYSTEM_ERROR;
         p_err_param := 'SYSTEM_ERROR';
         plog.error (pkgctx, SQLERRM || DBMS_UTILITY.format_error_backtrace);
         p_xmlmsg := txpks_msg.fn_mt_obj2xml (l_objmsg);
         plog.setendsection (pkgctx, 'fn_Transfer');
         RETURN errnums.C_SYSTEM_ERROR;
   END fn_Transfer;

   FUNCTION fn_Add (p_objmsg     IN OUT tx.obj_rectype,
                    p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER
   IS
   BEGIN
      plog.setbeginsection (pkgctx, 'fn_Add');

      -- Check befor add
      IF txpks_#FA_SERVICECONTRACT.fn_CheckBeforeAdd (p_objmsg, p_err_code) <>
            systemnums.C_SUCCESS
      THEN
         RETURN errnums.C_BIZ_RULE_INVALID;
      END IF;

      -- Auto add
      IF txpks_maintain.fn_ProcessAdd (p_objmsg, p_err_code) <>
            systemnums.C_SUCCESS
      THEN
         RETURN errnums.C_BIZ_RULE_INVALID;
      END IF;

      -- After Add
      IF txpks_#FA_SERVICECONTRACT.fn_ProcessAfterAdd (p_objmsg, p_err_code) <>
            systemnums.C_SUCCESS
      THEN
         RETURN errnums.C_BIZ_RULE_INVALID;
      END IF;

      --ghi log
      IF txpks_maintain.fn_MaintainLog (p_objmsg, p_err_code) <>
            systemnums.C_SUCCESS
      THEN
         RETURN errnums.C_BIZ_RULE_INVALID;
      END IF;

      plog.setendsection (pkgctx, 'fn_Add');
      RETURN systemnums.C_SUCCESS;
   EXCEPTION
      WHEN OTHERS
      THEN
         p_err_code := errnums.C_SYSTEM_ERROR;
         plog.error (pkgctx, SQLERRM || DBMS_UTILITY.format_error_backtrace);
         plog.setendsection (pkgctx, 'fn_Add');
         ROLLBACK;
         RAISE errnums.E_SYSTEM_ERROR;
   END fn_Add;

   FUNCTION fn_Edit (p_objmsg     IN OUT tx.obj_rectype,
                     p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER
   IS
   BEGIN
      plog.setbeginsection (pkgctx, 'fn_Edit');

      -- Check befor edit
      IF txpks_#FA_SERVICECONTRACT.fn_CheckBeforeEdit (p_objmsg, p_err_code) <>
            systemnums.C_SUCCESS
      THEN
         RETURN errnums.C_BIZ_RULE_INVALID;
      END IF;

      -- Auto Edit
      IF txpks_maintain.fn_ProcessEdit (p_objmsg, p_err_code) <>
            systemnums.C_SUCCESS
      THEN
         RETURN errnums.C_BIZ_RULE_INVALID;
      END IF;

      -- After Edit
      IF txpks_#FA_SERVICECONTRACT.fn_ProcessAfterEdit (p_objmsg, p_err_code) <>
            systemnums.C_SUCCESS
      THEN
         RETURN errnums.C_BIZ_RULE_INVALID;
      END IF;

      --ghi log
      IF txpks_maintain.fn_MaintainLog (p_objmsg, p_err_code) <>
            systemnums.C_SUCCESS
      THEN
         RETURN errnums.C_BIZ_RULE_INVALID;
      END IF;

      plog.setendsection (pkgctx, 'fn_Edit');
      RETURN systemnums.C_SUCCESS;
   EXCEPTION
      WHEN OTHERS
      THEN
         p_err_code := errnums.C_SYSTEM_ERROR;
         plog.error (pkgctx, SQLERRM || DBMS_UTILITY.format_error_backtrace);
         plog.setendsection (pkgctx, 'fn_Edit');
         ROLLBACK;
         RAISE errnums.E_SYSTEM_ERROR;
   END fn_Edit;

   FUNCTION fn_Delete (p_objmsg     IN OUT tx.obj_rectype,
                       p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER
   IS
   BEGIN
      plog.setbeginsection (pkgctx, 'fn_Delete');

      -- Check befor Delete
      IF txpks_#FA_SERVICECONTRACT.fn_CheckBeforeDelete (p_objmsg,
                                                         p_err_code) <>
            systemnums.C_SUCCESS
      THEN
         RETURN errnums.C_BIZ_RULE_INVALID;
      END IF;

      -- Auto Delete
      IF txpks_maintain.fn_ProcessDelete (p_objmsg, p_err_code) <>
            systemnums.C_SUCCESS
      THEN
         RETURN errnums.C_BIZ_RULE_INVALID;
      END IF;

      -- After Delete
      IF txpks_#FA_SERVICECONTRACT.fn_ProcessAfterDelete (p_objmsg,
                                                          p_err_code) <>
            systemnums.C_SUCCESS
      THEN
         RETURN errnums.C_BIZ_RULE_INVALID;
      END IF;

      --ghi log
      IF txpks_maintain.fn_MaintainLog (p_objmsg, p_err_code) <>
            systemnums.C_SUCCESS
      THEN
         RETURN errnums.C_BIZ_RULE_INVALID;
      END IF;

      plog.setendsection (pkgctx, 'fn_Delete');
      RETURN systemnums.C_SUCCESS;
   EXCEPTION
      WHEN OTHERS
      THEN
         p_err_code := errnums.C_SYSTEM_ERROR;
         plog.error (pkgctx, SQLERRM || DBMS_UTILITY.format_error_backtrace);
         plog.setendsection (pkgctx, 'fn_Delete');
         ROLLBACK;
         RAISE errnums.E_SYSTEM_ERROR;
   END fn_Delete;

   FUNCTION fn_Adhoc (p_objmsg     IN OUT tx.obj_rectype,
                      p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER
   IS
   BEGIN
      plog.setbeginsection (pkgctx, 'fn_Adhoc');

      plog.setendsection (pkgctx, 'fn_Adhoc');
      RETURN systemnums.C_SUCCESS;
   EXCEPTION
      WHEN OTHERS
      THEN
         p_err_code := errnums.C_SYSTEM_ERROR;
         plog.error (pkgctx, SQLERRM || DBMS_UTILITY.format_error_backtrace);
         plog.setendsection (pkgctx, 'fn_Adhoc');
         ROLLBACK;
         RAISE errnums.E_SYSTEM_ERROR;
   END fn_Adhoc;

   FUNCTION fn_Approve (p_objmsg     IN OUT tx.obj_rectype,
                        p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER
   IS
   BEGIN
      plog.setbeginsection (pkgctx, 'fn_Approve');

      plog.ERROR (pkgctx, 'fn_Approve 1');

      IF txpks_maintain.fn_Approve (p_objmsg, p_err_code) <>
            systemnums.C_SUCCESS
      THEN
         RETURN errnums.C_BIZ_RULE_INVALID;
      END IF;

      plog.ERROR (pkgctx, 'fn_Approve 2');

      IF txpks_#FA_SERVICECONTRACT.fn_ProcessAfterApprove (p_objmsg,
                                                           p_err_code) <>
            systemnums.C_SUCCESS
      THEN
         RETURN errnums.C_BIZ_RULE_INVALID;
      END IF;

      plog.ERROR (pkgctx, 'fn_Approve 3');

      plog.setendsection (pkgctx, 'fn_Approve');
      RETURN systemnums.C_SUCCESS;
   EXCEPTION
      WHEN OTHERS
      THEN
         p_err_code := errnums.C_SYSTEM_ERROR;
         plog.error (pkgctx, SQLERRM || DBMS_UTILITY.format_error_backtrace);
         plog.setendsection (pkgctx, 'fn_Approve');
         ROLLBACK;
         RAISE errnums.E_SYSTEM_ERROR;
   END fn_Approve;

   FUNCTION fn_Reject (p_objmsg     IN OUT tx.obj_rectype,
                       p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER
   IS
   BEGIN
      plog.error (pkgctx, 'fn_Reject test');

      IF txpks_maintain.fn_Reject (p_objmsg, p_err_code) <>
            systemnums.C_SUCCESS
      THEN
         RETURN errnums.C_BIZ_RULE_INVALID;
      END IF;

      plog.setendsection (pkgctx, 'fn_Reject');
      RETURN systemnums.C_SUCCESS;
   EXCEPTION
      WHEN OTHERS
      THEN
         p_err_code := errnums.C_SYSTEM_ERROR;
         plog.error (pkgctx, SQLERRM || DBMS_UTILITY.format_error_backtrace);
         plog.setendsection (pkgctx, 'fn_Reject');
         ROLLBACK;
         RAISE errnums.E_SYSTEM_ERROR;
   END fn_Reject;


   FUNCTION fn_CheckBeforeAdd (p_objmsg     IN OUT tx.obj_rectype,
                               p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER
   IS
      l_count   NUMBER;
      V_COUNT   NUMBER;
   BEGIN
      plog.setbeginsection (pkgctx, 'fn_CheckBeforeAdd');
      -- PLOG.error(PKGCTX, 'NAMNT TEST3'||p_objmsg.OBJFIELDS('CATYPE').value||p_objmsg.OBJFIELDS('RIGHTOFFRATE').value);
      /* if (p_objmsg.OBJFIELDS('CATYPE').value = '010' and (p_objmsg.OBJFIELDS('DEVIDENTRATE').value <0 )) then -- Tien
          p_err_code := '-800001';
          plog.setendsection (pkgctx, 'fn_txPreAppCheck');
          RETURN errnums.C_BIZ_RULE_INVALID;
       end if; --DEVIDENTSHARES
        if (p_objmsg.OBJFIELDS('CATYPE').value = '010' and (p_objmsg.OBJFIELDS('TAXRATE').value <0  or p_objmsg.OBJFIELDS('TAXRATE').value >100) ) then -- Tien
          p_err_code := '-800006';
          plog.setendsection (pkgctx, 'fn_txPreAppCheck');
          RETURN errnums.C_BIZ_RULE_INVALID;
       end if; --DEVIDENTSHARES
       if (p_objmsg.OBJFIELDS('CATYPE').value = '010' and (p_objmsg.OBJFIELDS('PARVALUE').value <0 )) then -- Tien
          p_err_code := '-800007';
          plog.setendsection (pkgctx, 'fn_txPreAppCheck');
          RETURN errnums.C_BIZ_RULE_INVALID;
       end if; --DEVIDENTSHARES
       if ((p_objmsg.OBJFIELDS('CATYPE').value = '011' or p_objmsg.OBJFIELDS('CATYPE').value = '005') and
         (isnumber(substr(p_objmsg.OBJFIELDS('DEVIDENTSHARES').value,0,instr(p_objmsg.OBJFIELDS('DEVIDENTSHARES').value,'/')-1)) = 'N' OR
         isnumber(substr(p_objmsg.OBJFIELDS('DEVIDENTSHARES').value,instr(p_objmsg.OBJFIELDS('DEVIDENTSHARES').value,'/')+1)) = 'N' )) then -- ccq
           p_err_code := '-800002';
           plog.setendsection (pkgctx, 'fn_txPreAppCheck');
          RETURN errnums.C_BIZ_RULE_INVALID;
       end if;
      if ((p_objmsg.OBJFIELDS('CATYPE').value = '005') and
        (isnumber(substr(p_objmsg.OBJFIELDS('RIGHTOFFRATE').value,0,instr(p_objmsg.OBJFIELDS('RIGHTOFFRATE').value,'/')-1)) = 'N' OR
         isnumber(substr(p_objmsg.OBJFIELDS('RIGHTOFFRATE').value,instr(p_objmsg.OBJFIELDS('RIGHTOFFRATE').value,'/')+1)) = 'N' )) then -- ccq
           p_err_code := '-800002';
           plog.setendsection (pkgctx, 'fn_txPreAppCheck');
          RETURN errnums.C_BIZ_RULE_INVALID;
       end if;
      IF to_date(p_objmsg.OBJFIELDS('REPORTDATE').value,'dd/MM/rrrr') > to_date(p_objmsg.OBJFIELDS('ACTIONDATE').value,'dd/MM/rrrr') THEN
          p_err_code := '-800003';
          plog.setendsection (pkgctx, 'fn_txPreAppCheck');
          RETURN errnums.C_BIZ_RULE_INVALID;
      END IF;
      IF fn_getholiday(p_objmsg.OBJFIELDS('REPORTDATE').value,'000') = 'Y' THEN
          p_err_code := '-800008';
          plog.setendsection (pkgctx, 'fn_txPreAppCheck');
          RETURN errnums.C_BIZ_RULE_INVALID;
      END IF;
      IF fn_getholiday(p_objmsg.OBJFIELDS('ACTIONDATE').value,'000') = 'Y' THEN
          p_err_code := '-800009';
          plog.setendsection (pkgctx, 'fn_txPreAppCheck');
          RETURN errnums.C_BIZ_RULE_INVALID;
      END IF;
      /* select COUNT(1) INTO V_COUNT from TAXRATE B
       WHERE upper(B.TYPECF) = upper(p_objmsg.OBJFIELDS('TYPECF').value);
       --AND b.status = 'A';
       IF V_COUNT > 0 THEN
          p_err_code := '-112222';
          plog.setendsection (pkgctx, 'fn_txPreAppCheck');
          RETURN errnums.C_BIZ_RULE_INVALID;
      END IF;*/

      plog.setendsection (pkgctx, 'fn_CheckBeforeAdd');
      RETURN systemnums.C_SUCCESS;
   EXCEPTION
      WHEN OTHERS
      THEN
         p_err_code := errnums.C_SYSTEM_ERROR;
         plog.error (pkgctx, SQLERRM || DBMS_UTILITY.format_error_backtrace);
         plog.setendsection (pkgctx, 'fn_CheckBeforeAdd');
         ROLLBACK;
         RAISE errnums.E_SYSTEM_ERROR;
   END fn_CheckBeforeAdd;

   FUNCTION fn_ProcessAfterAdd (p_objmsg     IN OUT tx.obj_rectype,
                                p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER
   IS
      l_count   NUMBER;
   BEGIN
      plog.setbeginsection (pkgctx, 'fn_ProcessAfterAdd');

      plog.setendsection (pkgctx, 'fn_ProcessAfterAdd');
      RETURN systemnums.C_SUCCESS;
   EXCEPTION
      WHEN OTHERS
      THEN
         p_err_code := errnums.C_SYSTEM_ERROR;
         plog.error (pkgctx, SQLERRM || DBMS_UTILITY.format_error_backtrace);
         plog.setendsection (pkgctx, 'fn_ProcessAfterAdd');
         ROLLBACK;
         RAISE errnums.E_SYSTEM_ERROR;
   END fn_ProcessAfterAdd;

   FUNCTION fn_CheckBeforeEdit (p_objmsg     IN OUT tx.obj_rectype,
                                p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER
   IS
      l_count   NUMBER;
   BEGIN
      /* if (p_objmsg.OBJFIELDS('CATYPE').value = '010' and (p_objmsg.OBJFIELDS('DEVIDENTRATE').value <0) ) then -- Tien
          p_err_code := '-800001';
          plog.setendsection (pkgctx, 'fn_txPreAppCheck');
          RETURN errnums.C_BIZ_RULE_INVALID;
       end if; --DEVIDENTSHARES
       if (p_objmsg.OBJFIELDS('CATYPE').value = '011' and
         (isnumber(substr(p_objmsg.OBJFIELDS('DEVIDENTSHARES').value,0,instr(p_objmsg.OBJFIELDS('DEVIDENTSHARES').value,'/')-1)) = 'N' OR
         isnumber(substr(p_objmsg.OBJFIELDS('DEVIDENTSHARES').value,instr(p_objmsg.OBJFIELDS('DEVIDENTSHARES').value,'/')+1)) = 'N' )) then -- ccq
           p_err_code := '-800002';
           plog.setendsection (pkgctx, 'fn_txPreAppCheck');
          RETURN errnums.C_BIZ_RULE_INVALID;
       end if;
       if ((p_objmsg.OBJFIELDS('CATYPE').value = '005') and
        (isnumber(substr(p_objmsg.OBJFIELDS('RIGHTOFFRATE').value,0,instr(p_objmsg.OBJFIELDS('RIGHTOFFRATE').value,'/')-1)) = 'N' OR
         isnumber(substr(p_objmsg.OBJFIELDS('RIGHTOFFRATE').value,instr(p_objmsg.OBJFIELDS('RIGHTOFFRATE').value,'/')+1)) = 'N' )) then -- ccq
           p_err_code := '-800002';
           plog.setendsection (pkgctx, 'fn_txPreAppCheck');
          RETURN errnums.C_BIZ_RULE_INVALID;
       end if;
        if (p_objmsg.OBJFIELDS('CATYPE').value = '010' and (p_objmsg.OBJFIELDS('TAXRATE').value <0  or p_objmsg.OBJFIELDS('TAXRATE').value >100)) then -- Tien
          p_err_code := '-800006';
          plog.setendsection (pkgctx, 'fn_txPreAppCheck');
          RETURN errnums.C_BIZ_RULE_INVALID;
       end if; --DEVIDENTSHARES
       if (p_objmsg.OBJFIELDS('CATYPE').value = '010' and (p_objmsg.OBJFIELDS('PARVALUE').value <0  )) then -- Tien
          p_err_code := '-800007';
          plog.setendsection (pkgctx, 'fn_txPreAppCheck');
          RETURN errnums.C_BIZ_RULE_INVALID;
       end if; --DEVIDENTSHARES
      IF to_date(p_objmsg.OBJFIELDS('REPORTDATE').value,'dd/MM/rrrr') > to_date(p_objmsg.OBJFIELDS('ACTIONDATE').value,'dd/MM/rrrr') THEN
          p_err_code := '-800003';
          plog.setendsection (pkgctx, 'fn_txPreAppCheck');
          RETURN errnums.C_BIZ_RULE_INVALID;
      END IF;
      IF fn_getholiday(p_objmsg.OBJFIELDS('REPORTDATE').value,'000') = 'Y' THEN
          p_err_code := '-800008';
          plog.setendsection (pkgctx, 'fn_txPreAppCheck');
          RETURN errnums.C_BIZ_RULE_INVALID;
      END IF;
      IF fn_getholiday(p_objmsg.OBJFIELDS('ACTIONDATE').value,'000') = 'Y' THEN
          p_err_code := '-800009';
          plog.setendsection (pkgctx, 'fn_txPreAppCheck');
          RETURN errnums.C_BIZ_RULE_INVALID;
      END IF;*/
      plog.setbeginsection (pkgctx, 'fn_CheckBeforeEdit');
      plog.setendsection (pkgctx, 'fn_CheckBeforeEdit');
      RETURN systemnums.C_SUCCESS;
   EXCEPTION
      WHEN OTHERS
      THEN
         p_err_code := errnums.C_SYSTEM_ERROR;
         plog.error (pkgctx, SQLERRM || DBMS_UTILITY.format_error_backtrace);
         plog.setendsection (pkgctx, 'fn_CheckBeforeEdit');
         ROLLBACK;
         RAISE errnums.E_SYSTEM_ERROR;
   END fn_CheckBeforeEdit;

   FUNCTION fn_ProcessAfterEdit (p_objmsg     IN OUT tx.obj_rectype,
                                 p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER
   IS
      l_count   NUMBER;
   BEGIN
      plog.setbeginsection (pkgctx, 'fn_ProcessAfterEdit');

      plog.setendsection (pkgctx, 'fn_ProcessAfterEdit');
      RETURN systemnums.C_SUCCESS;
   EXCEPTION
      WHEN OTHERS
      THEN
         p_err_code := errnums.C_SYSTEM_ERROR;
         plog.error (pkgctx, SQLERRM || DBMS_UTILITY.format_error_backtrace);
         plog.setendsection (pkgctx, 'fn_ProcessAfterEdit');
         ROLLBACK;
         RAISE errnums.E_SYSTEM_ERROR;
   END fn_ProcessAfterEdit;

   FUNCTION fn_CheckBeforeDelete (p_objmsg     IN OUT tx.obj_rectype,
                                  p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER
   IS
      v_count             NUMBER;
      v_strParentClause   VARCHAR2 (100);
      v_strRecord_Key     VARCHAR2 (100);
      v_strRecord_Value   VARCHAR2 (100);
      v_codeid            VARCHAR2 (100);
   BEGIN
      plog.setbeginsection (pkgctx, 'fn_CheckBeforeDelete');
      v_strParentClause := p_objmsg.CLAUSE;
      /* IF  length(v_strParentClause) <> 0 THEN
          v_strRecord_Key := Trim(substr(v_strParentClause,1, InStr(v_strParentClause, '=')-1));
          v_strRecord_Value := Trim(substr(v_strParentClause,InStr(v_strParentClause, '=') +1));
          v_strRecord_Value := REPLACE(v_strRecord_Value,'''','');
       end if;
     v_count := 0;
     select count(1) INTO v_count from paeervesting v where
     v.FAOBJECTid = v_strRecord_Value;
     if (v_count > 0) then --
         p_err_code := '-100100';
         plog.setendsection (pkgctx, 'fn_txPreAppCheck');
         RETURN errnums.C_BIZ_RULE_INVALID;
     end if;
     v_count := 0;
     select count(1) INTO v_count from paeertype t where
     t.FAOBJECTid = v_strRecord_Value;
     if (v_count > 0) then --
         p_err_code := '-100100';
         plog.setendsection (pkgctx, 'fn_txPreAppCheck');
         RETURN errnums.C_BIZ_RULE_INVALID;
     end if;*/
      plog.setendsection (pkgctx, 'fn_CheckBeforeDelete');
      RETURN systemnums.C_SUCCESS;
   EXCEPTION
      WHEN OTHERS
      THEN
         p_err_code := errnums.C_SYSTEM_ERROR;
         plog.error (pkgctx, SQLERRM || DBMS_UTILITY.format_error_backtrace);
         plog.setendsection (pkgctx, 'fn_CheckBeforeDelete');
         ROLLBACK;
         RAISE errnums.E_SYSTEM_ERROR;
   END fn_CheckBeforeDelete;

   FUNCTION fn_ProcessAfterDelete (p_objmsg     IN OUT tx.obj_rectype,
                                   p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER
   IS
      l_count   NUMBER;
   BEGIN
      plog.setbeginsection (pkgctx, 'fn_ProcessAfterDelete');

      plog.setendsection (pkgctx, 'fn_ProcessAfterDelete');
      RETURN systemnums.C_SUCCESS;
   EXCEPTION
      WHEN OTHERS
      THEN
         p_err_code := errnums.C_SYSTEM_ERROR;
         plog.error (pkgctx, SQLERRM || DBMS_UTILITY.format_error_backtrace);
         plog.setendsection (pkgctx, 'fn_ProcessAfterDelete');
         ROLLBACK;
         RAISE errnums.E_SYSTEM_ERROR;
   END fn_ProcessAfterDelete;

   FUNCTION fn_CheckBeforeApprove (p_objmsg     IN OUT tx.obj_rectype,
                                   p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER
   IS
      l_count   NUMBER;
   BEGIN
      plog.setbeginsection (pkgctx, 'fn_CheckBeforeApprove');

      plog.setendsection (pkgctx, 'fn_CheckBeforeApprove');
      RETURN systemnums.C_SUCCESS;
   EXCEPTION
      WHEN OTHERS
      THEN
         p_err_code := errnums.C_SYSTEM_ERROR;
         plog.error (pkgctx, SQLERRM || DBMS_UTILITY.format_error_backtrace);
         plog.setendsection (pkgctx, 'fn_CheckBeforeApprove');
         ROLLBACK;
         RAISE errnums.E_SYSTEM_ERROR;
   END fn_CheckBeforeApprove;

   FUNCTION fn_ProcessAfterApprove (p_objmsg     IN OUT tx.obj_rectype,
                                    p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER
   IS
      l_count         NUMBER;
      l_err_code      VARCHAR2 (100);
      l_err_message   VARCHAR2 (200);
      v_eerqtty       NUMBER;
      v_eeyqtty       NUMBER;
      v_qtty          NUMBER;
      v_amt           NUMBER;
      v_eeramt        NUMBER;
      v_balance       NUMBER;
      v_rate          NUMBER;
      v_rateleft      NUMBER;
      v_rateright     NUMBER;
      v_tax           NUMBER;
      v_eertax        NUMBER;
      v_custax        NUMBER;
      v_taxrate       NUMBER;
      v_dc            NUMBER;
      v_symbol        VARCHAR2 (50);
   BEGIN
      plog.setbeginsection (pkgctx, 'fn_ProcessAfterApprove');



      -- FOR REC IN (SELECT * FROM FAOBJECT ca where ca.status = 'A' and ca.reportdate < getcurrdate)
      --LOOP



      plog.setendsection (pkgctx, 'fn_ProcessAfterApprove');
      RETURN systemnums.C_SUCCESS;
   EXCEPTION
      WHEN OTHERS
      THEN
         p_err_code := errnums.C_SYSTEM_ERROR;
         plog.error (pkgctx, SQLERRM || DBMS_UTILITY.format_error_backtrace);
         plog.setendsection (pkgctx, 'fn_ProcessAfterApprove');
         ROLLBACK;
         RAISE errnums.E_SYSTEM_ERROR;
   END fn_ProcessAfterApprove;

   FUNCTION fn_CheckBeforeReject (p_objmsg     IN OUT tx.obj_rectype,
                                  p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER
   IS
      l_count   NUMBER;
   BEGIN
      plog.setbeginsection (pkgctx, 'fn_CheckBeforeReject');

      plog.setendsection (pkgctx, 'fn_CheckBeforeReject');
      RETURN systemnums.C_SUCCESS;
   EXCEPTION
      WHEN OTHERS
      THEN
         p_err_code := errnums.C_SYSTEM_ERROR;
         plog.error (pkgctx, SQLERRM || DBMS_UTILITY.format_error_backtrace);
         plog.setendsection (pkgctx, 'fn_CheckBeforeReject');
         ROLLBACK;
         RAISE errnums.E_SYSTEM_ERROR;
   END fn_CheckBeforeReject;

   FUNCTION fn_ProcessAfterReject (p_objmsg     IN OUT tx.obj_rectype,
                                   p_err_code   IN OUT VARCHAR2)
      RETURN NUMBER
   IS
      l_count   NUMBER;
   BEGIN
      plog.setbeginsection (pkgctx, 'fn_ProcessAfterReject');

      plog.setendsection (pkgctx, 'fn_ProcessAfterReject');
      RETURN systemnums.C_SUCCESS;
   EXCEPTION
      WHEN OTHERS
      THEN
         p_err_code := errnums.C_SYSTEM_ERROR;
         plog.error (pkgctx, SQLERRM || DBMS_UTILITY.format_error_backtrace);
         plog.setendsection (pkgctx, 'fn_ProcessAfterReject');
         ROLLBACK;
         RAISE errnums.E_SYSTEM_ERROR;
   END fn_ProcessAfterReject;
BEGIN
   FOR i IN (SELECT * FROM tlogdebug)
   LOOP
      logrow.loglevel := i.loglevel;
      logrow.log4table := i.log4table;
      logrow.log4alert := i.log4alert;
      logrow.log4trace := i.log4trace;
   END LOOP;

   pkgctx :=
      plog.init ('txpks_#sa.funddtl',
                 plevel      => NVL (logrow.loglevel, 30),
                 plogtable   => (NVL (logrow.log4table, 'N') = 'Y'),
                 palert      => (NVL (logrow.log4alert, 'N') = 'Y'),
                 ptrace      => (NVL (logrow.log4trace, 'N') = 'Y'));
END txpks_#FA_SERVICECONTRACT;
/

DROP PACKAGE txpks_#pa_pabankacct
/

CREATE OR REPLACE 
PACKAGE txpks_#pa_pabankacct 
/** ----------------------------------------------------------------------------------------------------
 dung cho form maintenance
 ----------------------------------------------------------------------------------------------------*/
IS

FUNCTION fn_Transfer(p_xmlmsg in out varchar2,p_err_code in out varchar2,p_err_param out varchar2)
RETURN NUMBER;
FUNCTION fn_Add(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Edit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Delete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Adhoc(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Approve(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Reject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;

--rieng
FUNCTION fn_CheckBeforeAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;

END;
/

CREATE OR REPLACE 
PACKAGE BODY txpks_#pa_pabankacct 
IS
   pkgctx   plog.log_ctx;
   logrow   tlogdebug%ROWTYPE;

FUNCTION fn_Transfer(p_xmlmsg in out varchar2,p_err_code in out varchar2,p_err_param out varchar2)
RETURN NUMBER
IS
   l_return_code VARCHAR2(30) := systemnums.C_SUCCESS;
   l_objmsg tx.obj_rectype;
   l_count NUMBER(3);
   l_msgtype VARCHAR2(10);
   l_objname VARCHAR2(100);
   l_actionflag varchar2(100);
   l_currdate varchar2(10);
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Transfer');
   plog.debug(pkgctx, 'fn_Transfer');
   --get object
   l_objmsg:= txpks_msg.fn_mt_xml2obj(p_xmlmsg);
   l_msgtype:= l_objmsg.MSGTYPE;
   l_objname:= l_objmsg.OBJNAME;
   l_actionflag:= l_objmsg.ACTIONFLAG;
   --Kiem tra msgtype de phan luong xu ly
   IF l_actionflag ='ADD' THEN
        IF fn_Add(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;
   ELSIF l_actionflag ='EDIT' THEN
        IF fn_Edit(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;

   ELSIF l_actionflag ='DELETE' THEN
        IF fn_Delete(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;
   ELSIF l_actionflag ='ADHOC' THEN
        IF fn_Adhoc(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;
   ELSIF l_actionflag ='APPROVE' THEN
        IF fn_Approve(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;
   ELSIF l_actionflag ='REJECT' THEN
        IF fn_Reject(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;
   END IF;

   plog.debug(pkgctx, 'fn_Transfer');
   plog.setendsection (pkgctx, 'fn_Transfer');
   RETURN l_return_code;
EXCEPTION
WHEN errnums.E_BIZ_RULE_INVALID
   THEN
      FOR I IN (
           SELECT ERRDESC,EN_ERRDESC FROM deferror
           WHERE ERRNUM= p_err_code
      ) LOOP
           p_err_param := i.errdesc;
      END LOOP;
      p_xmlmsg := txpks_msg.fn_mt_obj2xml(l_objmsg);
      plog.setendsection (pkgctx, 'fn_Transfer');
      ROLLBACK;
      RETURN errnums.C_BIZ_RULE_INVALID;
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      p_err_param := 'SYSTEM_ERROR';
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      p_xmlmsg := txpks_msg.fn_mt_obj2xml(l_objmsg);
      plog.setendsection (pkgctx, 'fn_Transfer');
      RETURN errnums.C_SYSTEM_ERROR;
END fn_Transfer;

FUNCTION fn_Add(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Add');
-- Check befor add
   IF txpks_#pa_pabankacct.fn_CheckBeforeAdd(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- Auto add
   IF txpks_maintain.fn_ProcessAdd(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- After Add
   IF txpks_#pa_pabankacct.fn_ProcessAfterAdd(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
--ghi log
   IF txpks_maintain.fn_MaintainLog(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   plog.setendsection (pkgctx, 'fn_Add');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Add');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Add;

FUNCTION fn_Edit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Edit');
-- Check befor edit
   IF txpks_#pa_pabankacct.fn_CheckBeforeEdit(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- Auto Edit
   IF txpks_maintain.fn_ProcessEdit(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- After Edit
   IF txpks_#pa_pabankacct.fn_ProcessAfterEdit(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   --ghi log
   IF txpks_maintain.fn_MaintainLog(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   plog.setendsection (pkgctx, 'fn_Edit');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Edit');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Edit;

FUNCTION fn_Delete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Delete');
-- Check befor Delete
   IF txpks_#pa_pabankacct.fn_CheckBeforeDelete(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- Auto Delete
   IF txpks_maintain.fn_ProcessDelete(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- After Delete
   IF txpks_#pa_pabankacct.fn_ProcessAfterDelete(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   --ghi log
   IF txpks_maintain.fn_MaintainLog(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   plog.setendsection (pkgctx, 'fn_Delete');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Delete');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Delete;

FUNCTION fn_Adhoc(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Adhoc');

   plog.setendsection (pkgctx, 'fn_Adhoc');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Adhoc');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Adhoc;

FUNCTION fn_Approve(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Approve');

   IF txpks_maintain.fn_Approve(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;

   IF txpks_#pa_pabankacct.fn_ProcessAfterApprove(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;

   plog.setendsection (pkgctx, 'fn_Approve');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Approve');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Approve;

FUNCTION fn_Reject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.error (pkgctx, 'fn_Reject test');

   IF txpks_maintain.fn_Reject(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;

   plog.setendsection (pkgctx, 'fn_Reject');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Reject');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Reject;


FUNCTION fn_CheckBeforeAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
   plog.setbeginsection (pkgctx, 'fn_CheckBeforeAdd');
    plog.setendsection (pkgctx, 'fn_CheckBeforeAdd');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_CheckBeforeAdd');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_CheckBeforeAdd;

FUNCTION fn_ProcessAfterAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_ProcessAfterAdd');

    plog.setendsection (pkgctx, 'fn_ProcessAfterAdd');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessAfterAdd');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessAfterAdd;

FUNCTION fn_CheckBeforeEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
    l_fldname varchar2(100);
    l_fldval varchar2(4000);
    l_fldtype varchar2(100);
    l_fldoldval varchar2(4000);
BEGIN
    plog.setbeginsection (pkgctx, 'fn_CheckBeforeEdit');

   /*l_fldname := p_objmsg.OBJFIELDS.FIRST;
   WHILE (l_fldname IS NOT NULL)
   LOOP
       l_fldval := p_objmsg.OBJFIELDS(l_fldname).value;
       l_fldtype := p_objmsg.OBJFIELDS(l_fldname).fldtype;
       l_fldoldval := p_objmsg.OBJFIELDS(l_fldname).oldval;
       IF l_fldname = 'SYMBOL' THEN
       IF  (nvl(l_fldoldval,'#$*') <> nvl(l_fldval,'#$*')) THEN
          SELECT COUNT(*) INTO l_count FROM FUND WHERE UPPER(SYMBOL) = UPPER(nvl(l_fldval,'#$*'));
          if l_count > 0 then
             p_err_code := '-111177';
             plog.setendsection (pkgctx, 'fn_CheckBeforeAdd');
             RETURN errnums.C_BIZ_RULE_INVALID;
           end if;
       END IF;
       END IF;
       l_fldname := p_objmsg.OBJFIELDS.NEXT (l_fldname);
   END LOOP;*/
    plog.setendsection (pkgctx, 'fn_CheckBeforeEdit');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_CheckBeforeEdit');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_CheckBeforeEdit;

FUNCTION fn_ProcessAfterEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_ProcessAfterEdit');

    plog.setendsection (pkgctx, 'fn_ProcessAfterEdit');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessAfterEdit');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessAfterEdit;

FUNCTION fn_CheckBeforeDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
    l_count_taipo NUMBER;
    l_count_funddtl NUMBER;
    l_count_feetype NUMBER;
    l_count_fmembers NUMBER;
    l_count_fund_member NUMBER;
    v_strParentClause varchar2(100);
    v_strRecord_Key varchar2(100);
    v_strRecord_Value varchar2(100);
    v_codeid varchar2(100);
BEGIN
    plog.setbeginsection (pkgctx, 'fn_CheckBeforeDelete');
    plog.setendsection (pkgctx, 'fn_CheckBeforeDelete');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_CheckBeforeDelete');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_CheckBeforeDelete;

FUNCTION fn_ProcessAfterDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
    v_strRecord_Key varchar2(100);
    v_strParentClause varchar2(100);
    v_strRecord_Value varchar2(100);
BEGIN
    plog.setbeginsection (pkgctx, 'fn_ProcessAfterDelete');

    plog.setendsection (pkgctx, 'fn_ProcessAfterDelete');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessAfterDelete');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessAfterDelete;

FUNCTION fn_CheckBeforeApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_CheckBeforeApprove');

    plog.setendsection (pkgctx, 'fn_CheckBeforeApprove');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_CheckBeforeApprove');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_CheckBeforeApprove;

FUNCTION fn_ProcessAfterApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
    l_refobjid  varchar2(12);
    l_actionflag varchar2(400);
    l_childvalue varchar2(400);
    l_childkey varchar2(400);
    l_chiltable varchar2(400);
    l_strcurryear varchar2(20);
BEGIN
    plog.setbeginsection (pkgctx, 'fn_ProcessAfterApprove');

    plog.setendsection (pkgctx, 'fn_ProcessAfterApprove');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessAfterApprove');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessAfterApprove;

FUNCTION fn_CheckBeforeReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_CheckBeforeReject');

    plog.setendsection (pkgctx, 'fn_CheckBeforeReject');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_CheckBeforeReject');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_CheckBeforeReject;

FUNCTION fn_ProcessAfterReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_ProcessAfterReject');

    plog.setendsection (pkgctx, 'fn_ProcessAfterReject');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessAfterReject');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessAfterReject;

BEGIN
      FOR i IN (SELECT *
                FROM tlogdebug)
      LOOP
         logrow.loglevel    := i.loglevel;
         logrow.log4table   := i.log4table;
         logrow.log4alert   := i.log4alert;
         logrow.log4trace   := i.log4trace;
      END LOOP;
      pkgctx    :=
         plog.init ('txpks_#sa.funddtl',
                    plevel => NVL(logrow.loglevel,30),
                    plogtable => (NVL(logrow.log4table,'N') = 'Y'),
                    palert => (NVL(logrow.log4alert,'N') = 'Y'),
                    ptrace => (NVL(logrow.log4trace,'N') = 'Y')
            );
END txpks_#pa_pabankacct;
/

DROP PACKAGE txpks_#pa_pacamast
/

CREATE OR REPLACE 
PACKAGE txpks_#pa_pacamast 
/** ----------------------------------------------------------------------------------------------------
 dung cho form maintenance
 ----------------------------------------------------------------------------------------------------*/
IS

FUNCTION fn_Transfer(p_xmlmsg in out varchar2,p_err_code in out varchar2,p_err_param out varchar2)
RETURN NUMBER;
FUNCTION fn_Add(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Edit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Delete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Adhoc(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Approve(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Reject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;

--rieng
FUNCTION fn_CheckBeforeAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;

END;
/

DROP PACKAGE txpks_#pa_pacmmaster
/

CREATE OR REPLACE 
PACKAGE txpks_#pa_pacmmaster 
/** ----------------------------------------------------------------------------------------------------
 dung cho form maintenance
 ----------------------------------------------------------------------------------------------------*/
IS

FUNCTION fn_Transfer(p_xmlmsg in out varchar2,p_err_code in out varchar2,p_err_param out varchar2)
RETURN NUMBER;
FUNCTION fn_Add(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Edit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Delete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Adhoc(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Approve(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Reject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;

--rieng
FUNCTION fn_CheckBeforeAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;

END;
/

CREATE OR REPLACE 
PACKAGE BODY txpks_#pa_pacmmaster 
IS
   pkgctx   plog.log_ctx;
   logrow   tlogdebug%ROWTYPE;

FUNCTION fn_Transfer(p_xmlmsg in out varchar2,p_err_code in out varchar2,p_err_param out varchar2)
RETURN NUMBER
IS
   l_return_code VARCHAR2(30) := systemnums.C_SUCCESS;
   l_objmsg tx.obj_rectype;
   l_count NUMBER(3);
   l_msgtype VARCHAR2(10);
   l_objname VARCHAR2(100);
   l_actionflag varchar2(100);
   l_currdate varchar2(10);
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Transfer');
   plog.debug(pkgctx, 'fn_Transfer');
   --get object
   l_objmsg:= txpks_msg.fn_mt_xml2obj(p_xmlmsg);
   l_msgtype:= l_objmsg.MSGTYPE;
   l_objname:= l_objmsg.OBJNAME;
   l_actionflag:= l_objmsg.ACTIONFLAG;
   --Kiem tra msgtype de phan luong xu ly
   IF l_actionflag ='ADD' THEN
        IF fn_Add(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;
   ELSIF l_actionflag ='EDIT' THEN
        IF fn_Edit(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;

   ELSIF l_actionflag ='DELETE' THEN
        IF fn_Delete(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;
   ELSIF l_actionflag ='ADHOC' THEN
        IF fn_Adhoc(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;
   ELSIF l_actionflag ='APPROVE' THEN
        IF fn_Approve(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;
   ELSIF l_actionflag ='REJECT' THEN
        IF fn_Reject(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;
   END IF;

   plog.debug(pkgctx, 'fn_Transfer');
   plog.setendsection (pkgctx, 'fn_Transfer');
   RETURN l_return_code;
EXCEPTION
WHEN errnums.E_BIZ_RULE_INVALID
   THEN
      FOR I IN (
           SELECT ERRDESC,EN_ERRDESC FROM deferror
           WHERE ERRNUM= p_err_code
      ) LOOP
           p_err_param := i.errdesc;
      END LOOP;
      p_xmlmsg := txpks_msg.fn_mt_obj2xml(l_objmsg);
      plog.setendsection (pkgctx, 'fn_Transfer');
      ROLLBACK;
      RETURN errnums.C_BIZ_RULE_INVALID;
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      p_err_param := 'SYSTEM_ERROR';
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      p_xmlmsg := txpks_msg.fn_mt_obj2xml(l_objmsg);
      plog.setendsection (pkgctx, 'fn_Transfer');
      RETURN errnums.C_SYSTEM_ERROR;
END fn_Transfer;

FUNCTION fn_Add(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Add');
-- Check befor add
   IF txpks_#pa_pacmmaster.fn_CheckBeforeAdd(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- Auto add
   IF txpks_maintain.fn_ProcessAdd(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- After Add
   IF txpks_#pa_pacmmaster.fn_ProcessAfterAdd(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
--ghi log
   IF txpks_maintain.fn_MaintainLog(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   plog.setendsection (pkgctx, 'fn_Add');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Add');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Add;

FUNCTION fn_Edit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Edit');
-- Check befor edit
   IF txpks_#pa_pacmmaster.fn_CheckBeforeEdit(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- Auto Edit
   IF txpks_maintain.fn_ProcessEdit(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- After Edit
   IF txpks_#pa_pacmmaster.fn_ProcessAfterEdit(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   --ghi log
   IF txpks_maintain.fn_MaintainLog(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   plog.setendsection (pkgctx, 'fn_Edit');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Edit');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Edit;

FUNCTION fn_Delete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Delete');
-- Check befor Delete
   IF txpks_#pa_pacmmaster.fn_CheckBeforeDelete(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- Auto Delete
   IF txpks_maintain.fn_ProcessDelete(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- After Delete
   IF txpks_#pa_pacmmaster.fn_ProcessAfterDelete(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   --ghi log
   IF txpks_maintain.fn_MaintainLog(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   plog.setendsection (pkgctx, 'fn_Delete');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Delete');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Delete;

FUNCTION fn_Adhoc(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Adhoc');

   plog.setendsection (pkgctx, 'fn_Adhoc');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Adhoc');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Adhoc;

FUNCTION fn_Approve(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Approve');

   IF txpks_maintain.fn_Approve(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;

   IF txpks_#pa_pacmmaster.fn_ProcessAfterApprove(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;

   plog.setendsection (pkgctx, 'fn_Approve');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Approve');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Approve;

FUNCTION fn_Reject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.error (pkgctx, 'fn_Reject test');

   IF txpks_maintain.fn_Reject(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;

   plog.setendsection (pkgctx, 'fn_Reject');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Reject');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Reject;


FUNCTION fn_CheckBeforeAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
   plog.setbeginsection (pkgctx, 'fn_CheckBeforeAdd');
   /*SELECT COUNT(*) INTO l_count FROM painvest iv\*, pension s*\ WHERE --iv.pensionid = s.autoid
          --AND iv.pensionid = p_objmsg.OBJFIELDS('PENSIONID').VALUE
           iv.fundcodeid = p_objmsg.OBJFIELDS('FUNDCODEID').VALUE;

    if l_count > 0 then
        p_err_code := '-910011';
        plog.setendsection (pkgctx, 'fn_CheckBeforeAdd');
        RETURN errnums.C_BIZ_RULE_INVALID;
    end if;*/

    plog.setendsection (pkgctx, 'fn_CheckBeforeAdd');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_CheckBeforeAdd');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_CheckBeforeAdd;

FUNCTION fn_ProcessAfterAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_ProcessAfterAdd');

    plog.setendsection (pkgctx, 'fn_ProcessAfterAdd');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessAfterAdd');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessAfterAdd;

FUNCTION fn_CheckBeforeEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
    l_fldname varchar2(100);
    l_fldval varchar2(4000);
    l_fldtype varchar2(100);
    l_fldoldval varchar2(4000);
BEGIN
    plog.setbeginsection (pkgctx, 'fn_CheckBeforeEdit');

     /*SELECT COUNT(*) INTO l_count FROM painvest iv\*, pension s*\ WHERE --iv.pensionid = s.autoid
          --AND iv.pensionid = p_objmsg.OBJFIELDS('PENSIONID').VALUE
           iv.fundcodeid = p_objmsg.OBJFIELDS('FUNDCODEID').VALUE;

    if l_count > 0 then
        p_err_code := '-910011';
        plog.setendsection (pkgctx, 'fn_CheckBeforeAdd');
        RETURN errnums.C_BIZ_RULE_INVALID;
    end if;*/

   /*l_fldname := p_objmsg.OBJFIELDS.FIRST;
   WHILE (l_fldname IS NOT NULL)
   LOOP
       l_fldval := p_objmsg.OBJFIELDS(l_fldname).value;
       l_fldtype := p_objmsg.OBJFIELDS(l_fldname).fldtype;
       l_fldoldval := p_objmsg.OBJFIELDS(l_fldname).oldval;
       IF l_fldname = 'SYMBOL' THEN
       IF  (nvl(l_fldoldval,'#$*') <> nvl(l_fldval,'#$*')) THEN
          SELECT COUNT(*) INTO l_count FROM FUND WHERE UPPER(SYMBOL) = UPPER(nvl(l_fldval,'#$*'));
          if l_count > 0 then
             p_err_code := '-111177';
             plog.setendsection (pkgctx, 'fn_CheckBeforeAdd');
             RETURN errnums.C_BIZ_RULE_INVALID;
           end if;
       END IF;
       END IF;
       l_fldname := p_objmsg.OBJFIELDS.NEXT (l_fldname);
   END LOOP;*/
    plog.setendsection (pkgctx, 'fn_CheckBeforeEdit');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_CheckBeforeEdit');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_CheckBeforeEdit;

FUNCTION fn_ProcessAfterEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_ProcessAfterEdit');

    plog.setendsection (pkgctx, 'fn_ProcessAfterEdit');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessAfterEdit');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessAfterEdit;

FUNCTION fn_CheckBeforeDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
    l_count_taipo NUMBER;
    l_count_funddtl NUMBER;
    l_count_feetype NUMBER;
    l_count_fmembers NUMBER;
    l_count_fund_member NUMBER;
    v_strParentClause varchar2(100);
    v_strRecord_Key varchar2(100);
    v_strRecord_Value varchar2(100);
    v_codeid varchar2(100);
BEGIN
    plog.setbeginsection (pkgctx, 'fn_CheckBeforeDelete');
    plog.setendsection (pkgctx, 'fn_CheckBeforeDelete');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_CheckBeforeDelete');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_CheckBeforeDelete;

FUNCTION fn_ProcessAfterDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
    v_strRecord_Key varchar2(100);
    v_strParentClause varchar2(100);
    v_strRecord_Value varchar2(100);
BEGIN
    plog.setbeginsection (pkgctx, 'fn_ProcessAfterDelete');

    plog.setendsection (pkgctx, 'fn_ProcessAfterDelete');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessAfterDelete');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessAfterDelete;

FUNCTION fn_CheckBeforeApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_CheckBeforeApprove');

    plog.setendsection (pkgctx, 'fn_CheckBeforeApprove');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_CheckBeforeApprove');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_CheckBeforeApprove;

FUNCTION fn_ProcessAfterApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
    l_refobjid  varchar2(12);
    l_actionflag varchar2(400);
    l_childvalue varchar2(400);
    l_childkey varchar2(400);
    l_chiltable varchar2(400);
    l_strcurryear varchar2(20);
BEGIN
    plog.setbeginsection (pkgctx, 'fn_ProcessAfterApprove');

    plog.setendsection (pkgctx, 'fn_ProcessAfterApprove');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessAfterApprove');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessAfterApprove;

FUNCTION fn_CheckBeforeReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_CheckBeforeReject');

    plog.setendsection (pkgctx, 'fn_CheckBeforeReject');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_CheckBeforeReject');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_CheckBeforeReject;

FUNCTION fn_ProcessAfterReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_ProcessAfterReject');

    plog.setendsection (pkgctx, 'fn_ProcessAfterReject');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessAfterReject');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessAfterReject;

BEGIN
      FOR i IN (SELECT *
                FROM tlogdebug)
      LOOP
         logrow.loglevel    := i.loglevel;
         logrow.log4table   := i.log4table;
         logrow.log4alert   := i.log4alert;
         logrow.log4trace   := i.log4trace;
      END LOOP;
      pkgctx    :=
         plog.init ('txpks_#sa.funddtl',
                    plevel => NVL(logrow.loglevel,30),
                    plogtable => (NVL(logrow.log4table,'N') = 'Y'),
                    palert => (NVL(logrow.log4alert,'N') = 'Y'),
                    ptrace => (NVL(logrow.log4trace,'N') = 'Y')
            );
END txpks_#pa_pacmmaster;
/

DROP PACKAGE txpks_#pa_pacmtype
/

CREATE OR REPLACE 
PACKAGE txpks_#pa_pacmtype 
/** ----------------------------------------------------------------------------------------------------
 dung cho form maintenance
 ----------------------------------------------------------------------------------------------------*/
IS

FUNCTION fn_Transfer(p_xmlmsg in out varchar2,p_err_code in out varchar2,p_err_param out varchar2)
RETURN NUMBER;
FUNCTION fn_Add(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Edit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Delete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Adhoc(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Approve(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Reject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;

--rieng
FUNCTION fn_CheckBeforeAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;

END;
/

CREATE OR REPLACE 
PACKAGE BODY txpks_#pa_pacmtype 
IS
   pkgctx   plog.log_ctx;
   logrow   tlogdebug%ROWTYPE;

FUNCTION fn_Transfer(p_xmlmsg in out varchar2,p_err_code in out varchar2,p_err_param out varchar2)
RETURN NUMBER
IS
   l_return_code VARCHAR2(30) := systemnums.C_SUCCESS;
   l_objmsg tx.obj_rectype;
   l_count NUMBER(3);
   l_msgtype VARCHAR2(10);
   l_objname VARCHAR2(100);
   l_actionflag varchar2(100);
   l_currdate varchar2(10);
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Transfer');
   plog.debug(pkgctx, 'fn_Transfer');
   --get object
   l_objmsg:= txpks_msg.fn_mt_xml2obj(p_xmlmsg);
   l_msgtype:= l_objmsg.MSGTYPE;
   l_objname:= l_objmsg.OBJNAME;
   l_actionflag:= l_objmsg.ACTIONFLAG;
   --Kiem tra msgtype de phan luong xu ly
   IF l_actionflag ='ADD' THEN
        IF fn_Add(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;
   ELSIF l_actionflag ='EDIT' THEN
        IF fn_Edit(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;

   ELSIF l_actionflag ='DELETE' THEN
        IF fn_Delete(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;
   ELSIF l_actionflag ='ADHOC' THEN
        IF fn_Adhoc(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;
   ELSIF l_actionflag ='APPROVE' THEN
        IF fn_Approve(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;
   ELSIF l_actionflag ='REJECT' THEN
        IF fn_Reject(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;
   END IF;

   plog.debug(pkgctx, 'fn_Transfer');
   plog.setendsection (pkgctx, 'fn_Transfer');
   RETURN l_return_code;
EXCEPTION
WHEN errnums.E_BIZ_RULE_INVALID
   THEN
      FOR I IN (
           SELECT ERRDESC,EN_ERRDESC FROM deferror
           WHERE ERRNUM= p_err_code
      ) LOOP
           p_err_param := i.errdesc;
      END LOOP;
      p_xmlmsg := txpks_msg.fn_mt_obj2xml(l_objmsg);
      plog.setendsection (pkgctx, 'fn_Transfer');
      ROLLBACK;
      RETURN errnums.C_BIZ_RULE_INVALID;
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      p_err_param := 'SYSTEM_ERROR';
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      p_xmlmsg := txpks_msg.fn_mt_obj2xml(l_objmsg);
      plog.setendsection (pkgctx, 'fn_Transfer');
      RETURN errnums.C_SYSTEM_ERROR;
END fn_Transfer;

FUNCTION fn_Add(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Add');
-- Check befor add
   IF txpks_#pa_pacmtype.fn_CheckBeforeAdd(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- Auto add
   IF txpks_maintain.fn_ProcessAdd(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- After Add
   IF txpks_#pa_pacmtype.fn_ProcessAfterAdd(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
--ghi log
   IF txpks_maintain.fn_MaintainLog(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   plog.setendsection (pkgctx, 'fn_Add');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Add');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Add;

FUNCTION fn_Edit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Edit');
-- Check befor edit
   IF txpks_#pa_pacmtype.fn_CheckBeforeEdit(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- Auto Edit
   IF txpks_maintain.fn_ProcessEdit(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- After Edit
   IF txpks_#pa_pacmtype.fn_ProcessAfterEdit(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   --ghi log
   IF txpks_maintain.fn_MaintainLog(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   plog.setendsection (pkgctx, 'fn_Edit');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Edit');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Edit;

FUNCTION fn_Delete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Delete');
-- Check befor Delete
   IF txpks_#pa_pacmtype.fn_CheckBeforeDelete(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- Auto Delete
   IF txpks_maintain.fn_ProcessDelete(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- After Delete
   IF txpks_#pa_pacmtype.fn_ProcessAfterDelete(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   --ghi log
   IF txpks_maintain.fn_MaintainLog(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   plog.setendsection (pkgctx, 'fn_Delete');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Delete');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Delete;

FUNCTION fn_Adhoc(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Adhoc');

   plog.setendsection (pkgctx, 'fn_Adhoc');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Adhoc');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Adhoc;

FUNCTION fn_Approve(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Approve');

   IF txpks_maintain.fn_Approve(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;

   IF txpks_#pa_pacmtype.fn_ProcessAfterApprove(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;

   plog.setendsection (pkgctx, 'fn_Approve');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Approve');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Approve;

FUNCTION fn_Reject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.error (pkgctx, 'fn_Reject test');

   IF txpks_maintain.fn_Reject(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;

   plog.setendsection (pkgctx, 'fn_Reject');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Reject');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Reject;


FUNCTION fn_CheckBeforeAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
   plog.setbeginsection (pkgctx, 'fn_CheckBeforeAdd');
  /* SELECT COUNT(*) INTO l_count FROM painvest iv\*, pension s*\ WHERE --iv.pensionid = s.autoid
          --AND iv.pensionid = p_objmsg.OBJFIELDS('PENSIONID').VALUE
           iv.fundcodeid = p_objmsg.OBJFIELDS('FUNDCODEID').VALUE;

    if l_count > 0 then
        p_err_code := '-910011';
        plog.setendsection (pkgctx, 'fn_CheckBeforeAdd');
        RETURN errnums.C_BIZ_RULE_INVALID;
    end if;*/

    plog.setendsection (pkgctx, 'fn_CheckBeforeAdd');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_CheckBeforeAdd');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_CheckBeforeAdd;

FUNCTION fn_ProcessAfterAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_ProcessAfterAdd');

    plog.setendsection (pkgctx, 'fn_ProcessAfterAdd');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessAfterAdd');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessAfterAdd;

FUNCTION fn_CheckBeforeEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
    l_fldname varchar2(100);
    l_fldval varchar2(4000);
    l_fldtype varchar2(100);
    l_fldoldval varchar2(4000);
BEGIN
    plog.setbeginsection (pkgctx, 'fn_CheckBeforeEdit');

     /*SELECT COUNT(*) INTO l_count FROM painvest iv\*, pension s*\ WHERE --iv.pensionid = s.autoid
          --AND iv.pensionid = p_objmsg.OBJFIELDS('PENSIONID').VALUE
           iv.fundcodeid = p_objmsg.OBJFIELDS('FUNDCODEID').VALUE;

    if l_count > 0 then
        p_err_code := '-910011';
        plog.setendsection (pkgctx, 'fn_CheckBeforeAdd');
        RETURN errnums.C_BIZ_RULE_INVALID;
    end if;*/

   /*l_fldname := p_objmsg.OBJFIELDS.FIRST;
   WHILE (l_fldname IS NOT NULL)
   LOOP
       l_fldval := p_objmsg.OBJFIELDS(l_fldname).value;
       l_fldtype := p_objmsg.OBJFIELDS(l_fldname).fldtype;
       l_fldoldval := p_objmsg.OBJFIELDS(l_fldname).oldval;
       IF l_fldname = 'SYMBOL' THEN
       IF  (nvl(l_fldoldval,'#$*') <> nvl(l_fldval,'#$*')) THEN
          SELECT COUNT(*) INTO l_count FROM FUND WHERE UPPER(SYMBOL) = UPPER(nvl(l_fldval,'#$*'));
          if l_count > 0 then
             p_err_code := '-111177';
             plog.setendsection (pkgctx, 'fn_CheckBeforeAdd');
             RETURN errnums.C_BIZ_RULE_INVALID;
           end if;
       END IF;
       END IF;
       l_fldname := p_objmsg.OBJFIELDS.NEXT (l_fldname);
   END LOOP;*/
    plog.setendsection (pkgctx, 'fn_CheckBeforeEdit');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_CheckBeforeEdit');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_CheckBeforeEdit;

FUNCTION fn_ProcessAfterEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_ProcessAfterEdit');

    plog.setendsection (pkgctx, 'fn_ProcessAfterEdit');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessAfterEdit');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessAfterEdit;

FUNCTION fn_CheckBeforeDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
    l_count_taipo NUMBER;
    l_count_funddtl NUMBER;
    l_count_feetype NUMBER;
    l_count_fmembers NUMBER;
    l_count_fund_member NUMBER;
    v_strParentClause varchar2(100);
    v_strRecord_Key varchar2(100);
    v_strRecord_Value varchar2(100);
    v_codeid varchar2(100);
BEGIN
    plog.setbeginsection (pkgctx, 'fn_CheckBeforeDelete');
    plog.setendsection (pkgctx, 'fn_CheckBeforeDelete');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_CheckBeforeDelete');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_CheckBeforeDelete;

FUNCTION fn_ProcessAfterDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
    v_strRecord_Key varchar2(100);
    v_strParentClause varchar2(100);
    v_strRecord_Value varchar2(100);
BEGIN
    plog.setbeginsection (pkgctx, 'fn_ProcessAfterDelete');

    plog.setendsection (pkgctx, 'fn_ProcessAfterDelete');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessAfterDelete');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessAfterDelete;

FUNCTION fn_CheckBeforeApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_CheckBeforeApprove');

    plog.setendsection (pkgctx, 'fn_CheckBeforeApprove');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_CheckBeforeApprove');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_CheckBeforeApprove;

FUNCTION fn_ProcessAfterApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
    l_refobjid  varchar2(12);
    l_actionflag varchar2(400);
    l_childvalue varchar2(400);
    l_childkey varchar2(400);
    l_chiltable varchar2(400);
    l_strcurryear varchar2(20);
BEGIN
    plog.setbeginsection (pkgctx, 'fn_ProcessAfterApprove');

    plog.setendsection (pkgctx, 'fn_ProcessAfterApprove');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessAfterApprove');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessAfterApprove;

FUNCTION fn_CheckBeforeReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_CheckBeforeReject');

    plog.setendsection (pkgctx, 'fn_CheckBeforeReject');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_CheckBeforeReject');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_CheckBeforeReject;

FUNCTION fn_ProcessAfterReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_ProcessAfterReject');

    plog.setendsection (pkgctx, 'fn_ProcessAfterReject');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessAfterReject');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessAfterReject;

BEGIN
      FOR i IN (SELECT *
                FROM tlogdebug)
      LOOP
         logrow.loglevel    := i.loglevel;
         logrow.log4table   := i.log4table;
         logrow.log4alert   := i.log4alert;
         logrow.log4trace   := i.log4trace;
      END LOOP;
      pkgctx    :=
         plog.init ('txpks_#sa.funddtl',
                    plevel => NVL(logrow.loglevel,30),
                    plogtable => (NVL(logrow.log4table,'N') = 'Y'),
                    palert => (NVL(logrow.log4alert,'N') = 'Y'),
                    ptrace => (NVL(logrow.log4trace,'N') = 'Y')
            );
END txpks_#pa_pacmtype;
/

DROP PACKAGE txpks_#pa_paeertermofcontr
/

CREATE OR REPLACE 
PACKAGE txpks_#pa_paeertermofcontr 
/** ----------------------------------------------------------------------------------------------------
 dung cho form maintenance
 ----------------------------------------------------------------------------------------------------*/
IS

FUNCTION fn_Transfer(p_xmlmsg in out varchar2,p_err_code in out varchar2,p_err_param out varchar2)
RETURN NUMBER;
FUNCTION fn_Add(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Edit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Delete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Adhoc(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Approve(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Reject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;

--rieng
FUNCTION fn_CheckBeforeAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;

END;
/

DROP PACKAGE txpks_#pa_paeertype
/

CREATE OR REPLACE 
PACKAGE txpks_#pa_paeertype 
/** ----------------------------------------------------------------------------------------------------
 dung cho form maintenance
 ----------------------------------------------------------------------------------------------------*/
IS

FUNCTION fn_Transfer(p_xmlmsg in out varchar2,p_err_code in out varchar2,p_err_param out varchar2)
RETURN NUMBER;
FUNCTION fn_Add(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Edit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Delete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Adhoc(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Approve(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Reject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;

--rieng
FUNCTION fn_CheckBeforeAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;

END;
/

DROP PACKAGE txpks_#pa_paeervesting
/

CREATE OR REPLACE 
PACKAGE txpks_#pa_paeervesting 
/** ----------------------------------------------------------------------------------------------------
 dung cho form maintenance
 ----------------------------------------------------------------------------------------------------*/
IS

FUNCTION fn_Transfer(p_xmlmsg in out varchar2,p_err_code in out varchar2,p_err_param out varchar2)
RETURN NUMBER;
FUNCTION fn_Add(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Edit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Delete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Adhoc(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Approve(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Reject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;

--rieng
FUNCTION fn_CheckBeforeAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;

END;
/

DROP PACKAGE txpks_#pa_paemployer
/

CREATE OR REPLACE 
PACKAGE txpks_#pa_paemployer 
/** ----------------------------------------------------------------------------------------------------
 dung cho form maintenance
 ----------------------------------------------------------------------------------------------------*/
IS

FUNCTION fn_Transfer(p_xmlmsg in out varchar2,p_err_code in out varchar2,p_err_param out varchar2)
RETURN NUMBER;
FUNCTION fn_Add(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Edit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Delete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Adhoc(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Approve(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Reject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;

--rieng
FUNCTION fn_CheckBeforeAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;

END;
/

DROP PACKAGE txpks_#pa_pafeecmd
/

CREATE OR REPLACE 
PACKAGE txpks_#pa_pafeecmd 
/** ----------------------------------------------------------------------------------------------------
 dung cho form maintenance
 ----------------------------------------------------------------------------------------------------*/
IS

FUNCTION fn_Transfer(p_xmlmsg in out varchar2,p_err_code in out varchar2,p_err_param out varchar2)
RETURN NUMBER;
FUNCTION fn_Add(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Edit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Delete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Adhoc(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Approve(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Reject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;

--rieng
FUNCTION fn_CheckBeforeAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;

END;
/

CREATE OR REPLACE 
PACKAGE BODY txpks_#pa_pafeecmd 
IS
   pkgctx   plog.log_ctx;
   logrow   tlogdebug%ROWTYPE;

FUNCTION fn_Transfer(p_xmlmsg in out varchar2,p_err_code in out varchar2,p_err_param out varchar2)
RETURN NUMBER
IS
   l_return_code VARCHAR2(30) := systemnums.C_SUCCESS;
   l_objmsg tx.obj_rectype;
   l_count NUMBER(3);
   l_msgtype VARCHAR2(10);
   l_objname VARCHAR2(100);
   l_actionflag varchar2(100);
   l_currdate varchar2(10);
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Transfer');
   plog.debug(pkgctx, 'fn_Transfer');
   --get object
   l_objmsg:= txpks_msg.fn_mt_xml2obj(p_xmlmsg);
   l_msgtype:= l_objmsg.MSGTYPE;
   l_objname:= l_objmsg.OBJNAME;
   l_actionflag:= l_objmsg.ACTIONFLAG;
   --Kiem tra msgtype de phan luong xu ly
   IF l_actionflag ='ADD' THEN
        IF fn_Add(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;
   ELSIF l_actionflag ='EDIT' THEN
        IF fn_Edit(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;

   ELSIF l_actionflag ='DELETE' THEN
        IF fn_Delete(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;
   ELSIF l_actionflag ='ADHOC' THEN
        IF fn_Adhoc(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;
   ELSIF l_actionflag ='APPROVE' THEN
        IF fn_Approve(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;
   ELSIF l_actionflag ='REJECT' THEN
        IF fn_Reject(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;
   END IF;

   plog.debug(pkgctx, 'fn_Transfer');
   plog.setendsection (pkgctx, 'fn_Transfer');
   RETURN l_return_code;
EXCEPTION
WHEN errnums.E_BIZ_RULE_INVALID
   THEN
      FOR I IN (
           SELECT ERRDESC,EN_ERRDESC FROM deferror
           WHERE ERRNUM= p_err_code
      ) LOOP
           p_err_param := i.errdesc;
      END LOOP;
      p_xmlmsg := txpks_msg.fn_mt_obj2xml(l_objmsg);
      plog.setendsection (pkgctx, 'fn_Transfer');
      ROLLBACK;
      RETURN errnums.C_BIZ_RULE_INVALID;
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      p_err_param := 'SYSTEM_ERROR';
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      p_xmlmsg := txpks_msg.fn_mt_obj2xml(l_objmsg);
      plog.setendsection (pkgctx, 'fn_Transfer');
      RETURN errnums.C_SYSTEM_ERROR;
END fn_Transfer;

FUNCTION fn_Add(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Add');
-- Check befor add
   IF txpks_#PA_PAFEECMD.fn_CheckBeforeAdd(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- Auto add
   IF txpks_maintain.fn_ProcessAdd(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- After Add
   IF txpks_#PA_PAFEECMD.fn_ProcessAfterAdd(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
--ghi log
   IF txpks_maintain.fn_MaintainLog(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   plog.setendsection (pkgctx, 'fn_Add');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Add');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Add;

FUNCTION fn_Edit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Edit');
-- Check befor edit
   IF txpks_#PA_PAFEECMD.fn_CheckBeforeEdit(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- Auto Edit
   IF txpks_maintain.fn_ProcessEdit(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- After Edit
   IF txpks_#PA_PAFEECMD.fn_ProcessAfterEdit(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   --ghi log
   IF txpks_maintain.fn_MaintainLog(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   plog.setendsection (pkgctx, 'fn_Edit');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Edit');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Edit;

FUNCTION fn_Delete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Delete');
-- Check befor Delete
   IF txpks_#PA_PAFEECMD.fn_CheckBeforeDelete(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- Auto Delete
   IF txpks_maintain.fn_ProcessDelete(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- After Delete
   IF txpks_#PA_PAFEECMD.fn_ProcessAfterDelete(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   --ghi log
   IF txpks_maintain.fn_MaintainLog(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   plog.setendsection (pkgctx, 'fn_Delete');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Delete');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Delete;

FUNCTION fn_Adhoc(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Adhoc');

   plog.setendsection (pkgctx, 'fn_Adhoc');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Adhoc');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Adhoc;

FUNCTION fn_Approve(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Approve');

  IF txpks_maintain.fn_Approve(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;

   plog.setendsection (pkgctx, 'fn_Approve');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Approve');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Approve;

FUNCTION fn_Reject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.error (pkgctx, 'fn_Reject test');

    IF txpks_maintain.fn_Reject(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;

   plog.setendsection (pkgctx, 'fn_Reject');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Reject');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Reject;


FUNCTION fn_CheckBeforeAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS

BEGIN
   IF (p_objmsg.OBJFIELDS('RATE').value <= 0 )
      THEN --FEERATEAMC  FEERATEDXX FEECALC -200051
         p_err_code := '-111158';
         plog.setendsection (pkgctx, 'fn_CheckBeforeAdd');
         RETURN errnums.C_BIZ_RULE_INVALID;
    END IF;
    IF (to_date(p_objmsg.OBJFIELDS('FROMDATE').value,'dd/MM/rrrr') >  to_date(p_objmsg.OBJFIELDS('TODATE').value,'dd/MM/rrrr'))
      THEN --FEERATEAMC  FEERATEDXX FEECALC
         p_err_code := '-111122';
         plog.setendsection (pkgctx, 'fn_CheckBeforeAdd');
         RETURN errnums.C_BIZ_RULE_INVALID;
    END IF;
    IF (p_objmsg.OBJFIELDS('CODEID').value = '000000')
      THEN --FEERATEAMC  FEERATEDXX FEECALC -200051
         p_err_code := '-200051';
         plog.setendsection (pkgctx, 'fn_CheckBeforeAdd');
         RETURN errnums.C_BIZ_RULE_INVALID;
    END IF;
    IF (p_objmsg.OBJFIELDS('DBCODE').value = '000000')
      THEN --FEERATEAMC  FEERATEDXX FEECALC -200051
         p_err_code := '-910055'; -- chua chon dlht
         plog.setendsection (pkgctx, 'fn_CheckBeforeAdd');
         RETURN errnums.C_BIZ_RULE_INVALID;
    END IF;
    plog.setendsection (pkgctx, 'fn_CheckBeforeAdd');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_CheckBeforeAdd');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_CheckBeforeAdd;

FUNCTION fn_ProcessAfterAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_ProcessAfterAdd');

    plog.setendsection (pkgctx, 'fn_ProcessAfterAdd');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessAfterAdd');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessAfterAdd;

FUNCTION fn_CheckBeforeEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
    IF (p_objmsg.OBJFIELDS('RATE').value <= 0 )
      THEN --FEERATEAMC  FEERATEDXX FEECALC -200051
         p_err_code := '-111158';
         plog.setendsection (pkgctx, 'fn_CheckBeforeAdd');
         RETURN errnums.C_BIZ_RULE_INVALID;
    END IF;
    IF (to_date(p_objmsg.OBJFIELDS('FROMDATE').value,'dd/MM/rrrr') >  to_date(p_objmsg.OBJFIELDS('TODATE').value,'dd/MM/rrrr'))
      THEN --FEERATEAMC  FEERATEDXX FEECALC
         p_err_code := '-111122';
         plog.setendsection (pkgctx, 'fn_CheckBeforeAdd');
         RETURN errnums.C_BIZ_RULE_INVALID;
    END IF;
    IF (p_objmsg.OBJFIELDS('CODEID').value = '000000')
      THEN --FEERATEAMC  FEERATEDXX FEECALC -200051
         p_err_code := '-200051';
         plog.setendsection (pkgctx, 'fn_CheckBeforeAdd');
         RETURN errnums.C_BIZ_RULE_INVALID;
    END IF;
    IF (p_objmsg.OBJFIELDS('DBCODE').value = '000000')
      THEN --FEERATEAMC  FEERATEDXX FEECALC -200051
         p_err_code := '-910055'; -- chua chon dlht
         plog.setendsection (pkgctx, 'fn_CheckBeforeAdd');
         RETURN errnums.C_BIZ_RULE_INVALID;
    END IF;
    plog.setbeginsection (pkgctx, 'fn_CheckBeforeEdit');
    plog.setendsection (pkgctx, 'fn_CheckBeforeEdit');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_CheckBeforeEdit');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_CheckBeforeEdit;

FUNCTION fn_ProcessAfterEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_ProcessAfterEdit');

    plog.setendsection (pkgctx, 'fn_ProcessAfterEdit');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessAfterEdit');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessAfterEdit;

FUNCTION fn_CheckBeforeDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS

BEGIN
    plog.setbeginsection (pkgctx, 'fn_CheckBeforeDelete');

    plog.setendsection (pkgctx, 'fn_CheckBeforeDelete');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_CheckBeforeDelete');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_CheckBeforeDelete;

FUNCTION fn_ProcessAfterDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_ProcessAfterDelete');

    plog.setendsection (pkgctx, 'fn_ProcessAfterDelete');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessAfterDelete');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessAfterDelete;

FUNCTION fn_CheckBeforeApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_CheckBeforeApprove');

    plog.setendsection (pkgctx, 'fn_CheckBeforeApprove');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_CheckBeforeApprove');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_CheckBeforeApprove;

FUNCTION fn_ProcessAfterApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_ProcessAfterApprove');

    plog.setendsection (pkgctx, 'fn_ProcessAfterApprove');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessAfterApprove');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessAfterApprove;

FUNCTION fn_CheckBeforeReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_CheckBeforeReject');

    plog.setendsection (pkgctx, 'fn_CheckBeforeReject');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_CheckBeforeReject');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_CheckBeforeReject;

FUNCTION fn_ProcessAfterReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_ProcessAfterReject');

    plog.setendsection (pkgctx, 'fn_ProcessAfterReject');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessAfterReject');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessAfterReject;

BEGIN
      FOR i IN (SELECT *
                FROM tlogdebug)
      LOOP
         logrow.loglevel    := i.loglevel;
         logrow.log4table   := i.log4table;
         logrow.log4alert   := i.log4alert;
         logrow.log4trace   := i.log4trace;
      END LOOP;
      pkgctx    :=
         plog.init ('txpks_#sa.funddtl',
                    plevel => NVL(logrow.loglevel,30),
                    plogtable => (NVL(logrow.log4table,'N') = 'Y'),
                    palert => (NVL(logrow.log4alert,'N') = 'Y'),
                    ptrace => (NVL(logrow.log4trace,'N') = 'Y')
            );
END txpks_#PA_PAFEECMD;
/

DROP PACKAGE txpks_#pa_pafeemaster
/

CREATE OR REPLACE 
PACKAGE txpks_#pa_pafeemaster 
/** ----------------------------------------------------------------------------------------------------
 dung cho form maintenance
 ----------------------------------------------------------------------------------------------------*/
IS

FUNCTION fn_Transfer(p_xmlmsg in out varchar2,p_err_code in out varchar2,p_err_param out varchar2)
RETURN NUMBER;
FUNCTION fn_Add(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Edit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Delete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Adhoc(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Approve(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Reject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;

--rieng
FUNCTION fn_CheckBeforeAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;

END;
/

CREATE OR REPLACE 
PACKAGE BODY txpks_#pa_pafeemaster 
IS
   pkgctx   plog.log_ctx;
   logrow   tlogdebug%ROWTYPE;

FUNCTION fn_Transfer(p_xmlmsg in out varchar2,p_err_code in out varchar2,p_err_param out varchar2)
RETURN NUMBER
IS
   l_return_code VARCHAR2(30) := systemnums.C_SUCCESS;
   l_objmsg tx.obj_rectype;
   l_count NUMBER(3);
   l_msgtype VARCHAR2(10);
   l_objname VARCHAR2(100);
   l_actionflag varchar2(100);
   l_currdate varchar2(10);
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Transfer');
   plog.debug(pkgctx, 'fn_Transfer');
   --get object
   l_objmsg:= txpks_msg.fn_mt_xml2obj(p_xmlmsg);
   l_msgtype:= l_objmsg.MSGTYPE;
   l_objname:= l_objmsg.OBJNAME;
   l_actionflag:= l_objmsg.ACTIONFLAG;
   --Kiem tra msgtype de phan luong xu ly
   IF l_actionflag ='ADD' THEN
        IF fn_Add(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;
   ELSIF l_actionflag ='EDIT' THEN
        IF fn_Edit(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;

   ELSIF l_actionflag ='DELETE' THEN
        IF fn_Delete(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;
   ELSIF l_actionflag ='ADHOC' THEN
        IF fn_Adhoc(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;
   ELSIF l_actionflag ='APPROVE' THEN
        IF fn_Approve(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;
   ELSIF l_actionflag ='REJECT' THEN
        IF fn_Reject(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;
   END IF;

   plog.debug(pkgctx, 'fn_Transfer');
   plog.setendsection (pkgctx, 'fn_Transfer');
   RETURN l_return_code;
EXCEPTION
WHEN errnums.E_BIZ_RULE_INVALID
   THEN
      FOR I IN (
           SELECT ERRDESC,EN_ERRDESC FROM deferror
           WHERE ERRNUM= p_err_code
      ) LOOP
           p_err_param := i.errdesc;
      END LOOP;
      p_xmlmsg := txpks_msg.fn_mt_obj2xml(l_objmsg);
      plog.setendsection (pkgctx, 'fn_Transfer');
      ROLLBACK;
      RETURN errnums.C_BIZ_RULE_INVALID;
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      p_err_param := 'SYSTEM_ERROR';
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      p_xmlmsg := txpks_msg.fn_mt_obj2xml(l_objmsg);
      plog.setendsection (pkgctx, 'fn_Transfer');
      RETURN errnums.C_SYSTEM_ERROR;
END fn_Transfer;

FUNCTION fn_Add(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Add');
-- Check befor add
   IF txpks_#pa_pafeemaster.fn_CheckBeforeAdd(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- Auto add
   IF txpks_maintain.fn_ProcessAdd(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- After Add
   IF txpks_#pa_pafeemaster.fn_ProcessAfterAdd(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
--ghi log
   IF txpks_maintain.fn_MaintainLog(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   plog.setendsection (pkgctx, 'fn_Add');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Add');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Add;

FUNCTION fn_Edit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Edit');
-- Check befor edit
   IF txpks_#pa_pafeemaster.fn_CheckBeforeEdit(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- Auto Edit
   IF txpks_maintain.fn_ProcessEdit(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- After Edit
   IF txpks_#pa_pafeemaster.fn_ProcessAfterEdit(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   --ghi log
   IF txpks_maintain.fn_MaintainLog(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   plog.setendsection (pkgctx, 'fn_Edit');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Edit');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Edit;

FUNCTION fn_Delete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Delete');
-- Check befor Delete
   IF txpks_#pa_pafeemaster.fn_CheckBeforeDelete(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- Auto Delete
   IF txpks_maintain.fn_ProcessDelete(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- After Delete
   IF txpks_#pa_pafeemaster.fn_ProcessAfterDelete(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   --ghi log
   IF txpks_maintain.fn_MaintainLog(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   plog.setendsection (pkgctx, 'fn_Delete');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Delete');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Delete;

FUNCTION fn_Adhoc(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Adhoc');

   plog.setendsection (pkgctx, 'fn_Adhoc');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Adhoc');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Adhoc;

FUNCTION fn_Approve(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Approve');

   IF txpks_maintain.fn_Approve(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;

   IF txpks_#pa_pafeemaster.fn_ProcessAfterApprove(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;

   plog.setendsection (pkgctx, 'fn_Approve');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Approve');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Approve;

FUNCTION fn_Reject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.error (pkgctx, 'fn_Reject test');

   IF txpks_maintain.fn_Reject(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;

   plog.setendsection (pkgctx, 'fn_Reject');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Reject');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Reject;


FUNCTION fn_CheckBeforeAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
   plog.setbeginsection (pkgctx, 'fn_CheckBeforeAdd');
    plog.setendsection (pkgctx, 'fn_CheckBeforeAdd');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_CheckBeforeAdd');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_CheckBeforeAdd;

FUNCTION fn_ProcessAfterAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_ProcessAfterAdd');

    plog.setendsection (pkgctx, 'fn_ProcessAfterAdd');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessAfterAdd');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessAfterAdd;

FUNCTION fn_CheckBeforeEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
    l_fldname varchar2(100);
    l_fldval varchar2(4000);
    l_fldtype varchar2(100);
    l_fldoldval varchar2(4000);
BEGIN
    plog.setbeginsection (pkgctx, 'fn_CheckBeforeEdit');

   /*l_fldname := p_objmsg.OBJFIELDS.FIRST;
   WHILE (l_fldname IS NOT NULL)
   LOOP
       l_fldval := p_objmsg.OBJFIELDS(l_fldname).value;
       l_fldtype := p_objmsg.OBJFIELDS(l_fldname).fldtype;
       l_fldoldval := p_objmsg.OBJFIELDS(l_fldname).oldval;
       IF l_fldname = 'SYMBOL' THEN
       IF  (nvl(l_fldoldval,'#$*') <> nvl(l_fldval,'#$*')) THEN
          SELECT COUNT(*) INTO l_count FROM FUND WHERE UPPER(SYMBOL) = UPPER(nvl(l_fldval,'#$*'));
          if l_count > 0 then
             p_err_code := '-111177';
             plog.setendsection (pkgctx, 'fn_CheckBeforeAdd');
             RETURN errnums.C_BIZ_RULE_INVALID;
           end if;
       END IF;
       END IF;
       l_fldname := p_objmsg.OBJFIELDS.NEXT (l_fldname);
   END LOOP;*/
    plog.setendsection (pkgctx, 'fn_CheckBeforeEdit');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_CheckBeforeEdit');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_CheckBeforeEdit;

FUNCTION fn_ProcessAfterEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_ProcessAfterEdit');

    plog.setendsection (pkgctx, 'fn_ProcessAfterEdit');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessAfterEdit');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessAfterEdit;

FUNCTION fn_CheckBeforeDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
    l_count_taipo NUMBER;
    l_count_funddtl NUMBER;
    l_count_feetype NUMBER;
    l_count_fmembers NUMBER;
    l_count_fund_member NUMBER;
    v_strParentClause varchar2(100);
    v_strRecord_Key varchar2(100);
    v_strRecord_Value varchar2(100);
    v_codeid varchar2(100);
BEGIN
    plog.setbeginsection (pkgctx, 'fn_CheckBeforeDelete');
    plog.setendsection (pkgctx, 'fn_CheckBeforeDelete');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_CheckBeforeDelete');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_CheckBeforeDelete;

FUNCTION fn_ProcessAfterDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
    v_strRecord_Key varchar2(100);
    v_strParentClause varchar2(100);
    v_strRecord_Value varchar2(100);
BEGIN
    plog.setbeginsection (pkgctx, 'fn_ProcessAfterDelete');

    plog.setendsection (pkgctx, 'fn_ProcessAfterDelete');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessAfterDelete');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessAfterDelete;

FUNCTION fn_CheckBeforeApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_CheckBeforeApprove');

    plog.setendsection (pkgctx, 'fn_CheckBeforeApprove');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_CheckBeforeApprove');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_CheckBeforeApprove;

FUNCTION fn_ProcessAfterApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
    l_refobjid  varchar2(12);
    l_actionflag varchar2(400);
    l_childvalue varchar2(400);
    l_childkey varchar2(400);
    l_chiltable varchar2(400);
    l_strcurryear varchar2(20);
BEGIN
    plog.setbeginsection (pkgctx, 'fn_ProcessAfterApprove');

    plog.setendsection (pkgctx, 'fn_ProcessAfterApprove');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessAfterApprove');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessAfterApprove;

FUNCTION fn_CheckBeforeReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_CheckBeforeReject');

    plog.setendsection (pkgctx, 'fn_CheckBeforeReject');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_CheckBeforeReject');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_CheckBeforeReject;

FUNCTION fn_ProcessAfterReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_ProcessAfterReject');

    plog.setendsection (pkgctx, 'fn_ProcessAfterReject');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessAfterReject');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessAfterReject;

BEGIN
      FOR i IN (SELECT *
                FROM tlogdebug)
      LOOP
         logrow.loglevel    := i.loglevel;
         logrow.log4table   := i.log4table;
         logrow.log4alert   := i.log4alert;
         logrow.log4trace   := i.log4trace;
      END LOOP;
      pkgctx    :=
         plog.init ('txpks_#sa.funddtl',
                    plevel => NVL(logrow.loglevel,30),
                    plogtable => (NVL(logrow.log4table,'N') = 'Y'),
                    palert => (NVL(logrow.log4alert,'N') = 'Y'),
                    ptrace => (NVL(logrow.log4trace,'N') = 'Y')
            );
END txpks_#pa_pafeemaster;
/

DROP PACKAGE txpks_#pa_pafeeservice
/

CREATE OR REPLACE 
PACKAGE txpks_#pa_pafeeservice 
/** ----------------------------------------------------------------------------------------------------
 dung cho form maintenance
 ----------------------------------------------------------------------------------------------------*/
IS

FUNCTION fn_Transfer(p_xmlmsg in out varchar2,p_err_code in out varchar2,p_err_param out varchar2)
RETURN NUMBER;
FUNCTION fn_Add(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Edit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Delete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Adhoc(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Approve(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Reject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;

--rieng
FUNCTION fn_CheckBeforeAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;

END;
/

CREATE OR REPLACE 
PACKAGE BODY txpks_#pa_pafeeservice 
IS
   pkgctx   plog.log_ctx;
   logrow   tlogdebug%ROWTYPE;

FUNCTION fn_Transfer(p_xmlmsg in out varchar2,p_err_code in out varchar2,p_err_param out varchar2)
RETURN NUMBER
IS
   l_return_code VARCHAR2(30) := systemnums.C_SUCCESS;
   l_objmsg tx.obj_rectype;
   l_count NUMBER(3);
   l_msgtype VARCHAR2(10);
   l_objname VARCHAR2(100);
   l_actionflag varchar2(100);
   l_currdate varchar2(10);
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Transfer');
   plog.debug(pkgctx, 'fn_Transfer');
   --get object
   l_objmsg:= txpks_msg.fn_mt_xml2obj(p_xmlmsg);
   l_msgtype:= l_objmsg.MSGTYPE;
   l_objname:= l_objmsg.OBJNAME;
   l_actionflag:= l_objmsg.ACTIONFLAG;
   --Kiem tra msgtype de phan luong xu ly
   IF l_actionflag ='ADD' THEN
        IF fn_Add(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;
   ELSIF l_actionflag ='EDIT' THEN
        IF fn_Edit(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;

   ELSIF l_actionflag ='DELETE' THEN
        IF fn_Delete(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;
   ELSIF l_actionflag ='ADHOC' THEN
        IF fn_Adhoc(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;
   ELSIF l_actionflag ='APPROVE' THEN
        IF fn_Approve(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;
   ELSIF l_actionflag ='REJECT' THEN
        IF fn_Reject(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;
   END IF;

   plog.debug(pkgctx, 'fn_Transfer');
   plog.setendsection (pkgctx, 'fn_Transfer');
   RETURN l_return_code;
EXCEPTION
WHEN errnums.E_BIZ_RULE_INVALID
   THEN
      FOR I IN (
           SELECT ERRDESC,EN_ERRDESC FROM deferror
           WHERE ERRNUM= p_err_code
      ) LOOP
           p_err_param := i.errdesc;
      END LOOP;
      p_xmlmsg := txpks_msg.fn_mt_obj2xml(l_objmsg);
      plog.setendsection (pkgctx, 'fn_Transfer');
      ROLLBACK;
      RETURN errnums.C_BIZ_RULE_INVALID;
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      p_err_param := 'SYSTEM_ERROR';
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      p_xmlmsg := txpks_msg.fn_mt_obj2xml(l_objmsg);
      plog.setendsection (pkgctx, 'fn_Transfer');
      RETURN errnums.C_SYSTEM_ERROR;
END fn_Transfer;

FUNCTION fn_Add(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Add');
-- Check befor add
   IF txpks_#PA_PAFEESERVICE.fn_CheckBeforeAdd(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- Auto add
   IF txpks_maintain.fn_ProcessAdd(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- After Add
   IF txpks_#PA_PAFEESERVICE.fn_ProcessAfterAdd(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
--ghi log
   IF txpks_maintain.fn_MaintainLog(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   plog.setendsection (pkgctx, 'fn_Add');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Add');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Add;

FUNCTION fn_Edit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Edit');
-- Check befor edit
   IF txpks_#PA_PAFEESERVICE.fn_CheckBeforeEdit(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- Auto Edit
   IF txpks_maintain.fn_ProcessEdit(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- After Edit
   IF txpks_#PA_PAFEESERVICE.fn_ProcessAfterEdit(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   --ghi log
   IF txpks_maintain.fn_MaintainLog(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   plog.setendsection (pkgctx, 'fn_Edit');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Edit');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Edit;

FUNCTION fn_Delete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Delete');
-- Check befor Delete
   IF txpks_#PA_PAFEESERVICE.fn_CheckBeforeDelete(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- Auto Delete
   IF txpks_maintain.fn_ProcessDelete(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- After Delete
   IF txpks_#PA_PAFEESERVICE.fn_ProcessAfterDelete(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   --ghi log
   IF txpks_maintain.fn_MaintainLog(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   plog.setendsection (pkgctx, 'fn_Delete');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Delete');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Delete;

FUNCTION fn_Adhoc(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Adhoc');

   plog.setendsection (pkgctx, 'fn_Adhoc');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Adhoc');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Adhoc;

FUNCTION fn_Approve(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Approve');

  IF txpks_maintain.fn_Approve(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;

   plog.setendsection (pkgctx, 'fn_Approve');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Approve');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Approve;

FUNCTION fn_Reject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.error (pkgctx, 'fn_Reject test');

    IF txpks_maintain.fn_Reject(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;

   plog.setendsection (pkgctx, 'fn_Reject');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Reject');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Reject;


FUNCTION fn_CheckBeforeAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS

BEGIN
   IF (p_objmsg.OBJFIELDS('RATE').value <= 0 )
      THEN --FEERATEAMC  FEERATEDXX FEECALC -200051
         p_err_code := '-111158';
         plog.setendsection (pkgctx, 'fn_CheckBeforeAdd');
         RETURN errnums.C_BIZ_RULE_INVALID;
    END IF;
    IF (to_date(p_objmsg.OBJFIELDS('FROMDATE').value,'dd/MM/rrrr') >  to_date(p_objmsg.OBJFIELDS('TODATE').value,'dd/MM/rrrr'))
      THEN --FEERATEAMC  FEERATEDXX FEECALC
         p_err_code := '-111122';
         plog.setendsection (pkgctx, 'fn_CheckBeforeAdd');
         RETURN errnums.C_BIZ_RULE_INVALID;
    END IF;
    IF (p_objmsg.OBJFIELDS('CODEID').value = '000000')
      THEN --FEERATEAMC  FEERATEDXX FEECALC -200051
         p_err_code := '-200051';
         plog.setendsection (pkgctx, 'fn_CheckBeforeAdd');
         RETURN errnums.C_BIZ_RULE_INVALID;
    END IF;
    plog.setendsection (pkgctx, 'fn_CheckBeforeAdd');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_CheckBeforeAdd');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_CheckBeforeAdd;

FUNCTION fn_ProcessAfterAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_ProcessAfterAdd');

    plog.setendsection (pkgctx, 'fn_ProcessAfterAdd');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessAfterAdd');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessAfterAdd;

FUNCTION fn_CheckBeforeEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
    IF (p_objmsg.OBJFIELDS('RATE').value <= 0 )
      THEN --FEERATEAMC  FEERATEDXX FEECALC -200051
         p_err_code := '-111158';
         plog.setendsection (pkgctx, 'fn_CheckBeforeAdd');
         RETURN errnums.C_BIZ_RULE_INVALID;
    END IF;
    IF (to_date(p_objmsg.OBJFIELDS('FROMDATE').value,'dd/MM/rrrr') >  to_date(p_objmsg.OBJFIELDS('TODATE').value,'dd/MM/rrrr'))
      THEN --FEERATEAMC  FEERATEDXX FEECALC
         p_err_code := '-111122';
         plog.setendsection (pkgctx, 'fn_CheckBeforeAdd');
         RETURN errnums.C_BIZ_RULE_INVALID;
    END IF;
    IF (p_objmsg.OBJFIELDS('CODEID').value = '000000')
      THEN --FEERATEAMC  FEERATEDXX FEECALC -200051
         p_err_code := '-200051';
         plog.setendsection (pkgctx, 'fn_CheckBeforeAdd');
         RETURN errnums.C_BIZ_RULE_INVALID;
    END IF;
    plog.setbeginsection (pkgctx, 'fn_CheckBeforeEdit');
    plog.setendsection (pkgctx, 'fn_CheckBeforeEdit');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_CheckBeforeEdit');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_CheckBeforeEdit;

FUNCTION fn_ProcessAfterEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_ProcessAfterEdit');

    plog.setendsection (pkgctx, 'fn_ProcessAfterEdit');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessAfterEdit');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessAfterEdit;

FUNCTION fn_CheckBeforeDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS

BEGIN
    plog.setbeginsection (pkgctx, 'fn_CheckBeforeDelete');

    plog.setendsection (pkgctx, 'fn_CheckBeforeDelete');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_CheckBeforeDelete');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_CheckBeforeDelete;

FUNCTION fn_ProcessAfterDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_ProcessAfterDelete');

    plog.setendsection (pkgctx, 'fn_ProcessAfterDelete');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessAfterDelete');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessAfterDelete;

FUNCTION fn_CheckBeforeApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_CheckBeforeApprove');

    plog.setendsection (pkgctx, 'fn_CheckBeforeApprove');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_CheckBeforeApprove');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_CheckBeforeApprove;

FUNCTION fn_ProcessAfterApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_ProcessAfterApprove');

    plog.setendsection (pkgctx, 'fn_ProcessAfterApprove');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessAfterApprove');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessAfterApprove;

FUNCTION fn_CheckBeforeReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_CheckBeforeReject');

    plog.setendsection (pkgctx, 'fn_CheckBeforeReject');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_CheckBeforeReject');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_CheckBeforeReject;

FUNCTION fn_ProcessAfterReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_ProcessAfterReject');

    plog.setendsection (pkgctx, 'fn_ProcessAfterReject');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessAfterReject');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessAfterReject;

BEGIN
      FOR i IN (SELECT *
                FROM tlogdebug)
      LOOP
         logrow.loglevel    := i.loglevel;
         logrow.log4table   := i.log4table;
         logrow.log4alert   := i.log4alert;
         logrow.log4trace   := i.log4trace;
      END LOOP;
      pkgctx    :=
         plog.init ('txpks_#sa.funddtl',
                    plevel => NVL(logrow.loglevel,30),
                    plogtable => (NVL(logrow.log4table,'N') = 'Y'),
                    palert => (NVL(logrow.log4alert,'N') = 'Y'),
                    ptrace => (NVL(logrow.log4trace,'N') = 'Y')
            );
END txpks_#PA_PAFEESERVICE;
/

DROP PACKAGE txpks_#pa_pafeetier
/

CREATE OR REPLACE 
PACKAGE txpks_#pa_pafeetier 
/** ----------------------------------------------------------------------------------------------------
 dung cho form maintenance
 ----------------------------------------------------------------------------------------------------*/
IS

FUNCTION fn_Transfer(p_xmlmsg in out varchar2,p_err_code in out varchar2,p_err_param out varchar2)
RETURN NUMBER;
FUNCTION fn_Add(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Edit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Delete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Adhoc(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Approve(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Reject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;

--rieng
FUNCTION fn_CheckBeforeAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;

END;
/

DROP PACKAGE txpks_#pa_painvest
/

CREATE OR REPLACE 
PACKAGE txpks_#pa_painvest 
/** ----------------------------------------------------------------------------------------------------
 dung cho form maintenance
 ----------------------------------------------------------------------------------------------------*/
IS

FUNCTION fn_Transfer(p_xmlmsg in out varchar2,p_err_code in out varchar2,p_err_param out varchar2)
RETURN NUMBER;
FUNCTION fn_Add(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Edit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Delete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Adhoc(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Approve(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Reject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;

--rieng
FUNCTION fn_CheckBeforeAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;

END;
/

DROP PACKAGE txpks_#pa_patermofpaid
/

CREATE OR REPLACE 
PACKAGE txpks_#pa_patermofpaid 
/** ----------------------------------------------------------------------------------------------------
 dung cho form maintenance
 ----------------------------------------------------------------------------------------------------*/
IS

FUNCTION fn_Transfer(p_xmlmsg in out varchar2,p_err_code in out varchar2,p_err_param out varchar2)
RETURN NUMBER;
FUNCTION fn_Add(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Edit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Delete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Adhoc(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Approve(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Reject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;

--rieng
FUNCTION fn_CheckBeforeAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;

END;
/

DROP PACKAGE txpks_#pa_pavestingtype
/

CREATE OR REPLACE 
PACKAGE txpks_#pa_pavestingtype 
/** ----------------------------------------------------------------------------------------------------
 dung cho form maintenance
 ----------------------------------------------------------------------------------------------------*/
IS

FUNCTION fn_Transfer(p_xmlmsg in out varchar2,p_err_code in out varchar2,p_err_param out varchar2)
RETURN NUMBER;
FUNCTION fn_Add(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Edit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Delete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Adhoc(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Approve(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Reject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;

--rieng
FUNCTION fn_CheckBeforeAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;

END;
/

DROP PACKAGE txpks_#pa_pension
/

CREATE OR REPLACE 
PACKAGE txpks_#pa_pension 
/** ----------------------------------------------------------------------------------------------------
 dung cho form maintenance
 ----------------------------------------------------------------------------------------------------*/
IS

FUNCTION fn_Transfer(p_xmlmsg in out varchar2,p_err_code in out varchar2,p_err_param out varchar2)
RETURN NUMBER;
FUNCTION fn_Add(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Edit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Delete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Adhoc(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Approve(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Reject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;

--rieng
FUNCTION fn_CheckBeforeAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;

END;
/

DROP PACKAGE txpks_#sa_bank
/

CREATE OR REPLACE 
PACKAGE txpks_#sa_bank 
/** ----------------------------------------------------------------------------------------------------
 dung cho form maintenance
 ----------------------------------------------------------------------------------------------------*/
IS

FUNCTION fn_Transfer(p_xmlmsg in out varchar2,p_err_code in out varchar2,p_err_param out varchar2)
RETURN NUMBER;
FUNCTION fn_Add(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Edit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Delete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Adhoc(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Approve(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Reject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;

--rieng
FUNCTION fn_CheckBeforeAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;

END;
/

CREATE OR REPLACE 
PACKAGE BODY txpks_#sa_bank 
IS
   pkgctx   plog.log_ctx;
   logrow   tlogdebug%ROWTYPE;

FUNCTION fn_Transfer(p_xmlmsg in out varchar2,p_err_code in out varchar2,p_err_param out varchar2)
RETURN NUMBER
IS
   l_return_code VARCHAR2(30) := systemnums.C_SUCCESS;
   l_objmsg tx.obj_rectype;
   l_count NUMBER(3);
   l_msgtype VARCHAR2(10);
   l_objname VARCHAR2(100);
   l_actionflag varchar2(100);
   l_currdate varchar2(10);
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Transfer');
   plog.debug(pkgctx, 'fn_Transfer');
   --get object
   l_objmsg:= txpks_msg.fn_mt_xml2obj(p_xmlmsg);
   l_msgtype:= l_objmsg.MSGTYPE;
   l_objname:= l_objmsg.OBJNAME;
   l_actionflag:= l_objmsg.ACTIONFLAG;
   --Kiem tra msgtype de phan luong xu ly
   IF l_actionflag ='ADD' THEN
        IF fn_Add(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;
   ELSIF l_actionflag ='EDIT' THEN
        IF fn_Edit(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;

   ELSIF l_actionflag ='DELETE' THEN
        IF fn_Delete(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;
   ELSIF l_actionflag ='ADHOC' THEN
        IF fn_Adhoc(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;
   ELSIF l_actionflag ='APPROVE' THEN
        IF fn_Approve(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;
   ELSIF l_actionflag ='REJECT' THEN
        IF fn_Reject(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;
   END IF;

   plog.debug(pkgctx, 'fn_Transfer');
   plog.setendsection (pkgctx, 'fn_Transfer');
   RETURN l_return_code;
EXCEPTION
WHEN errnums.E_BIZ_RULE_INVALID
   THEN
      FOR I IN (
           SELECT ERRDESC,EN_ERRDESC FROM deferror
           WHERE ERRNUM= p_err_code
      ) LOOP
           p_err_param := i.errdesc;
      END LOOP;
      p_xmlmsg := txpks_msg.fn_mt_obj2xml(l_objmsg);
      plog.setendsection (pkgctx, 'fn_Transfer');
      ROLLBACK;
      RETURN errnums.C_BIZ_RULE_INVALID;
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      p_err_param := 'SYSTEM_ERROR';
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      p_xmlmsg := txpks_msg.fn_mt_obj2xml(l_objmsg);
      plog.setendsection (pkgctx, 'fn_Transfer');
      RETURN errnums.C_SYSTEM_ERROR;
END fn_Transfer;

FUNCTION fn_Add(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Add');
-- Check befor add
   IF txpks_#sa_bank.fn_CheckBeforeAdd(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- Auto add
   IF txpks_maintain.fn_ProcessAdd(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- After Add
   IF txpks_#sa_bank.fn_ProcessAfterAdd(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
--ghi log
   IF txpks_maintain.fn_MaintainLog(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   plog.setendsection (pkgctx, 'fn_Add');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Add');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Add;

FUNCTION fn_Edit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Edit');
-- Check befor edit
   IF txpks_#sa_bank.fn_CheckBeforeEdit(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- Auto Edit
   IF txpks_maintain.fn_ProcessEdit(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- After Edit
   IF txpks_#sa_bank.fn_ProcessAfterEdit(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   --ghi log
   IF txpks_maintain.fn_MaintainLog(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   plog.setendsection (pkgctx, 'fn_Edit');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Edit');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Edit;

FUNCTION fn_Delete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Delete');
-- Check befor Delete
   IF txpks_#sa_bank.fn_CheckBeforeDelete(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- Auto Delete
   IF txpks_maintain.fn_ProcessDelete(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- After Delete
   IF txpks_#sa_bank.fn_ProcessAfterDelete(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   --ghi log
   IF txpks_maintain.fn_MaintainLog(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   plog.setendsection (pkgctx, 'fn_Delete');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Delete');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Delete;

FUNCTION fn_Adhoc(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Adhoc');

   plog.setendsection (pkgctx, 'fn_Adhoc');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Adhoc');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Adhoc;

FUNCTION fn_Approve(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Approve');

  IF txpks_maintain.fn_Approve(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;

   plog.setendsection (pkgctx, 'fn_Approve');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Approve');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Approve;

FUNCTION fn_Reject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.error (pkgctx, 'fn_Reject test');

    IF txpks_maintain.fn_Reject(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;

   plog.setendsection (pkgctx, 'fn_Reject');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Reject');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Reject;


FUNCTION fn_CheckBeforeAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS     
    l_count number;
    V_COUNT NUMBER;
BEGIN
   plog.setbeginsection (pkgctx, 'fn_CheckBeforeAdd');
   select COUNT(*) INTO V_COUNT from BANK B WHERE upper(B.BANKCODE) = upper(p_objmsg.OBJFIELDS('BANKCODE').value);
   IF V_COUNT > 0 THEN
      p_err_code := '-100090';
       plog.setendsection (pkgctx, 'fn_txPreAppCheck');
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   
    plog.setendsection (pkgctx, 'fn_CheckBeforeAdd');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_CheckBeforeAdd');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_CheckBeforeAdd;

FUNCTION fn_ProcessAfterAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_ProcessAfterAdd');

    plog.setendsection (pkgctx, 'fn_ProcessAfterAdd');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessAfterAdd');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessAfterAdd;

FUNCTION fn_CheckBeforeEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_CheckBeforeEdit');

    plog.setendsection (pkgctx, 'fn_CheckBeforeEdit');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_CheckBeforeEdit');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_CheckBeforeEdit;

FUNCTION fn_ProcessAfterEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_ProcessAfterEdit');

    plog.setendsection (pkgctx, 'fn_ProcessAfterEdit');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessAfterEdit');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessAfterEdit;

FUNCTION fn_CheckBeforeDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
    l_count_taipo NUMBER;
    l_count_funddtl NUMBER;
    l_count_fmembers NUMBER;
    l_count_fund_member NUMBER;
    v_strParentClause varchar2(100);
    v_strRecord_Key varchar2(100);
    v_strRecord_Value varchar2(100);
    v_codeid varchar2(100);
BEGIN
    plog.setbeginsection (pkgctx, 'fn_CheckBeforeDelete');
   v_strParentClause := p_objmsg.CLAUSE;
       IF  length(v_strParentClause) <> 0 THEN
        v_strRecord_Key := Trim(substr(v_strParentClause,1, InStr(v_strParentClause, '=')-1));
        v_strRecord_Value := Trim(substr(v_strParentClause,InStr(v_strParentClause, '=') +1));
        v_strRecord_Value := REPLACE(v_strRecord_Value,'''','');
       end if;

 select count(*) into l_count_taipo from TAIPO TA WHERE TA.STATUS <> 'D' and TA.CODEID = v_strRecord_Value ;
 select count(*) into l_count_funddtl from FUNDDTL DTL WHERE DTL.STATUS <> 'D' and DTL.CODEID = v_strRecord_Value ;
 select count(*) into l_count_fmembers from FMEMBERS FM WHERE FM.STATUS <> 'D' and FM.CODEID = v_strRecord_Value ;
 select count(*) into l_count_fund_member from FUND_MEMBER FME WHERE FME.STATUS <> 'D' and FME.CODEID = v_strRecord_Value ;
    IF l_count_taipo > 0 OR l_count_funddtl >0 OR l_count_fmembers >0 OR l_count_fund_member >0  THEN
       p_err_code := '-100100';
       plog.setendsection (pkgctx, 'fn_txPreAppCheck');
       RETURN errnums.C_BIZ_RULE_INVALID;
    END IF;
    plog.setendsection (pkgctx, 'fn_CheckBeforeDelete');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_CheckBeforeDelete');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_CheckBeforeDelete;

FUNCTION fn_ProcessAfterDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_ProcessAfterDelete');

    plog.setendsection (pkgctx, 'fn_ProcessAfterDelete');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessAfterDelete');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessAfterDelete;

FUNCTION fn_CheckBeforeApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_CheckBeforeApprove');

    plog.setendsection (pkgctx, 'fn_CheckBeforeApprove');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_CheckBeforeApprove');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_CheckBeforeApprove;

FUNCTION fn_ProcessAfterApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_ProcessAfterApprove');

    plog.setendsection (pkgctx, 'fn_ProcessAfterApprove');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessAfterApprove');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessAfterApprove;

FUNCTION fn_CheckBeforeReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_CheckBeforeReject');

    plog.setendsection (pkgctx, 'fn_CheckBeforeReject');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_CheckBeforeReject');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_CheckBeforeReject;

FUNCTION fn_ProcessAfterReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_ProcessAfterReject');

    plog.setendsection (pkgctx, 'fn_ProcessAfterReject');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessAfterReject');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessAfterReject;

BEGIN
      FOR i IN (SELECT *
                FROM tlogdebug)
      LOOP
         logrow.loglevel    := i.loglevel;
         logrow.log4table   := i.log4table;
         logrow.log4alert   := i.log4alert;
         logrow.log4trace   := i.log4trace;
      END LOOP;
      pkgctx    :=
         plog.init ('txpks_#sa.funddtl',
                    plevel => NVL(logrow.loglevel,30),
                    plogtable => (NVL(logrow.log4table,'N') = 'Y'),
                    palert => (NVL(logrow.log4alert,'N') = 'Y'),
                    ptrace => (NVL(logrow.log4trace,'N') = 'Y')
            );
END txpks_#sa_bank;
/

DROP PACKAGE txpks_#sa_cfmastapply
/

CREATE OR REPLACE 
PACKAGE txpks_#sa_cfmastapply 
/** ----------------------------------------------------------------------------------------------------
 dung cho form maintenance
 ----------------------------------------------------------------------------------------------------*/
IS

FUNCTION fn_Transfer(p_xmlmsg in out varchar2,p_err_code in out varchar2,p_err_param out varchar2)
RETURN NUMBER;
FUNCTION fn_Add(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Edit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Delete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Adhoc(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Approve(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Reject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;

--rieng
FUNCTION fn_CheckBeforeAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;

END;
/

DROP PACKAGE txpks_#sa_feeacm
/

CREATE OR REPLACE 
PACKAGE txpks_#sa_feeacm 
/** ----------------------------------------------------------------------------------------------------
 dung cho form maintenance
 ----------------------------------------------------------------------------------------------------*/
IS

FUNCTION fn_Transfer(p_xmlmsg in out varchar2,p_err_code in out varchar2,p_err_param out varchar2)
RETURN NUMBER;
FUNCTION fn_Add(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Edit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Delete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Adhoc(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Approve(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Reject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;

--rieng
FUNCTION fn_CheckBeforeAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;

END;
/

DROP PACKAGE txpks_#sa_feeapply
/

CREATE OR REPLACE 
PACKAGE txpks_#sa_feeapply 
/** ----------------------------------------------------------------------------------------------------
 dung cho form maintenance
 ----------------------------------------------------------------------------------------------------*/
IS

FUNCTION fn_Transfer(p_xmlmsg in out varchar2,p_err_code in out varchar2,p_err_param out varchar2)
RETURN NUMBER;
FUNCTION fn_Add(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Edit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Delete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Adhoc(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Approve(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Reject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;

--rieng
FUNCTION fn_CheckBeforeAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;

END;
/

DROP PACKAGE txpks_#sa_feeapplycfd
/

CREATE OR REPLACE 
PACKAGE txpks_#sa_feeapplycfd 
/** ----------------------------------------------------------------------------------------------------
 dung cho form maintenance
 ----------------------------------------------------------------------------------------------------*/
IS

FUNCTION fn_Transfer(p_xmlmsg in out varchar2,p_err_code in out varchar2,p_err_param out varchar2)
RETURN NUMBER;
FUNCTION fn_Add(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Edit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Delete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Adhoc(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Approve(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Reject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;

--rieng
FUNCTION fn_CheckBeforeAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2) RETURN NUMBER;
END;
/

DROP PACKAGE txpks_#sa_feeapplysip
/

CREATE OR REPLACE 
PACKAGE txpks_#sa_feeapplysip 
/** ----------------------------------------------------------------------------------------------------
 dung cho form maintenance
 ----------------------------------------------------------------------------------------------------*/
IS

FUNCTION fn_Transfer(p_xmlmsg in out varchar2,p_err_code in out varchar2,p_err_param out varchar2)
RETURN NUMBER;
FUNCTION fn_Add(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Edit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Delete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Adhoc(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Approve(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Reject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;

--rieng
FUNCTION fn_CheckBeforeAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;

END;
/

DROP PACKAGE txpks_#sa_feebonus
/

CREATE OR REPLACE 
PACKAGE txpks_#sa_feebonus 
/** ----------------------------------------------------------------------------------------------------
 dung cho form maintenance
 ----------------------------------------------------------------------------------------------------*/
IS

FUNCTION fn_Transfer(p_xmlmsg in out varchar2,p_err_code in out varchar2,p_err_param out varchar2)
RETURN NUMBER;
FUNCTION fn_Add(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Edit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Delete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Adhoc(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Approve(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Reject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;

--rieng
FUNCTION fn_CheckBeforeAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;

END;
/

DROP PACKAGE txpks_#sa_feecfd
/

CREATE OR REPLACE 
PACKAGE txpks_#sa_feecfd 
/** ----------------------------------------------------------------------------------------------------
 dung cho form maintenance
 ----------------------------------------------------------------------------------------------------*/
IS

FUNCTION fn_Transfer(p_xmlmsg in out varchar2,p_err_code in out varchar2,p_err_param out varchar2)
RETURN NUMBER;
FUNCTION fn_Add(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Edit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Delete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Adhoc(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Approve(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Reject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;

--rieng
FUNCTION fn_CheckBeforeAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;

END;
/

DROP PACKAGE txpks_#sa_feecmd
/

CREATE OR REPLACE 
PACKAGE txpks_#sa_feecmd 
/** ----------------------------------------------------------------------------------------------------
 dung cho form maintenance
 ----------------------------------------------------------------------------------------------------*/
IS

FUNCTION fn_Transfer(p_xmlmsg in out varchar2,p_err_code in out varchar2,p_err_param out varchar2)
RETURN NUMBER;
FUNCTION fn_Add(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Edit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Delete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Adhoc(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Approve(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Reject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;

--rieng
FUNCTION fn_CheckBeforeAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;

END;
/

CREATE OR REPLACE 
PACKAGE BODY txpks_#sa_feecmd 
IS
   pkgctx   plog.log_ctx;
   logrow   tlogdebug%ROWTYPE;

FUNCTION fn_Transfer(p_xmlmsg in out varchar2,p_err_code in out varchar2,p_err_param out varchar2)
RETURN NUMBER
IS
   l_return_code VARCHAR2(30) := systemnums.C_SUCCESS;
   l_objmsg tx.obj_rectype;
   l_count NUMBER(3);
   l_msgtype VARCHAR2(10);
   l_objname VARCHAR2(100);
   l_actionflag varchar2(100);
   l_currdate varchar2(10);
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Transfer');
   plog.debug(pkgctx, 'fn_Transfer');
   --get object
   l_objmsg:= txpks_msg.fn_mt_xml2obj(p_xmlmsg);
   l_msgtype:= l_objmsg.MSGTYPE;
   l_objname:= l_objmsg.OBJNAME;
   l_actionflag:= l_objmsg.ACTIONFLAG;
   --Kiem tra msgtype de phan luong xu ly
   IF l_actionflag ='ADD' THEN
        IF fn_Add(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;
   ELSIF l_actionflag ='EDIT' THEN
        IF fn_Edit(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;

   ELSIF l_actionflag ='DELETE' THEN
        IF fn_Delete(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;
   ELSIF l_actionflag ='ADHOC' THEN
        IF fn_Adhoc(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;
   ELSIF l_actionflag ='APPROVE' THEN
        IF fn_Approve(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;
   ELSIF l_actionflag ='REJECT' THEN
        IF fn_Reject(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;
   END IF;

   plog.debug(pkgctx, 'fn_Transfer');
   plog.setendsection (pkgctx, 'fn_Transfer');
   RETURN l_return_code;
EXCEPTION
WHEN errnums.E_BIZ_RULE_INVALID
   THEN
      FOR I IN (
           SELECT ERRDESC,EN_ERRDESC FROM deferror
           WHERE ERRNUM= p_err_code
      ) LOOP
           p_err_param := i.errdesc;
      END LOOP;
      p_xmlmsg := txpks_msg.fn_mt_obj2xml(l_objmsg);
      plog.setendsection (pkgctx, 'fn_Transfer');
      ROLLBACK;
      RETURN errnums.C_BIZ_RULE_INVALID;
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      p_err_param := 'SYSTEM_ERROR';
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      p_xmlmsg := txpks_msg.fn_mt_obj2xml(l_objmsg);
      plog.setendsection (pkgctx, 'fn_Transfer');
      RETURN errnums.C_SYSTEM_ERROR;
END fn_Transfer;

FUNCTION fn_Add(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Add');
-- Check befor add
   IF txpks_#sa_FEECMD.fn_CheckBeforeAdd(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- Auto add
   IF txpks_maintain.fn_ProcessAdd(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
      RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- After Add
   IF txpks_#sa_FEECMD.fn_ProcessAfterAdd(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
--ghi log
   IF txpks_maintain.fn_MaintainLog(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
      RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   plog.setendsection (pkgctx, 'fn_Add');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Add');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Add;

FUNCTION fn_Edit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Edit');
-- Check befor edit
   IF txpks_#sa_FEECMD.fn_CheckBeforeEdit(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- Auto Edit
   IF txpks_maintain.fn_ProcessEdit(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- After Edit
   IF txpks_#sa_FEECMD.fn_ProcessAfterEdit(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   --ghi log
  IF txpks_maintain.fn_MaintainLog(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
   RETURN errnums.C_BIZ_RULE_INVALID;
 END IF;
   plog.setendsection (pkgctx, 'fn_Edit');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Edit');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Edit;

FUNCTION fn_Delete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Delete');
-- Check befor Delete
   IF txpks_#sa_FEECMD.fn_CheckBeforeDelete(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- Auto Delete
   IF txpks_maintain.fn_ProcessDelete(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- After Delete
   IF txpks_#sa_FEECMD.fn_ProcessAfterDelete(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   --ghi log
   IF txpks_maintain.fn_MaintainLog(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   plog.setendsection (pkgctx, 'fn_Delete');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Delete');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Delete;

FUNCTION fn_Adhoc(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Adhoc');

   plog.setendsection (pkgctx, 'fn_Adhoc');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Adhoc');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Adhoc;

FUNCTION fn_Approve(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Approve');

   -- Check befor Approve
   IF txpks_#sa_FEECMD.fn_checkbeforereject(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
     RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   --Auto Approve
  IF txpks_maintain.fn_Approve(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   --
   IF txpks_#sa_FEECMD.fn_ProcessAfterApprove(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   plog.setendsection (pkgctx, 'fn_Approve');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Approve');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Approve;

FUNCTION fn_Reject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Reject');

       IF txpks_maintain.fn_Reject(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;

   plog.setendsection (pkgctx, 'fn_Reject');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Reject');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Reject;


FUNCTION fn_CheckBeforeAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
   plog.setbeginsection (pkgctx, 'fn_CheckBeforeAdd');

   /*IF p_objmsg.OBJFIELDS('TERMCONT').value <= 0 THEN
        p_err_code := '-111135';
        plog.setendsection (pkgctx, 'fn_CheckBeforeAdd');
        RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
    IF p_objmsg.OBJFIELDS('TERMDISCONT').value <= 0 THEN
        p_err_code := '-111136';
        plog.setendsection (pkgctx, 'fn_CheckBeforeAdd');
        RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
    IF p_objmsg.OBJFIELDS('TOTALTERM').value <= 0 THEN
        p_err_code := '-111137';
        plog.setendsection (pkgctx, 'fn_CheckBeforeAdd');
        RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;*/
  /*  select count(1) into l_count
     from members m where m.mbcodevsd = p_objmsg.OBJFIELDS('MBCODEVSD').value ;
     IF l_count >0  THEN
        p_err_code := '-111168';
        plog.setendsection (pkgctx, 'fn_CheckBeforeAdd');
        RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   IF p_objmsg.OBJFIELDS('AUTHCAPITAL').value <=0  THEN
        p_err_code := '-111169';
        plog.setendsection (pkgctx, 'fn_CheckBeforeAdd');
        RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;*/

    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_CheckBeforeAdd');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_CheckBeforeAdd;

FUNCTION fn_ProcessAfterAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_ProcessAfterAdd');

    plog.setendsection (pkgctx, 'fn_ProcessAfterAdd');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessAfterAdd');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessAfterAdd;

FUNCTION fn_CheckBeforeEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_CheckBeforeEdit');
     /*select count(1) into l_count
     from members m where m.mbcodevsd = p_objmsg.OBJFIELDS('MBCODEVSD').value ;
     IF l_count >=2  THEN
        p_err_code := '-111168';
        plog.setendsection (pkgctx, 'fn_CheckBeforeAdd');
        RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   IF p_objmsg.OBJFIELDS('AUTHCAPITAL').value <=0  THEN
        p_err_code := '-111169';
        plog.setendsection (pkgctx, 'fn_CheckBeforeAdd');
        RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;*/

    plog.setendsection (pkgctx, 'fn_CheckBeforeEdit');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_CheckBeforeEdit');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_CheckBeforeEdit;

FUNCTION fn_ProcessAfterEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_ProcessAfterEdit');

    plog.setendsection (pkgctx, 'fn_ProcessAfterEdit');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessAfterEdit');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessAfterEdit;

FUNCTION fn_CheckBeforeDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
    v_dcid varchar2(30);
    v_strRecord_Key varchar2(30);
    v_strRecord_Value varchar2(30);

BEGIN
    plog.setbeginsection (pkgctx, 'fn_CheckBeforeDelete');
     v_dcid := trim(substr(p_objmsg.CLAUSE,10,30));



      /*IF  length(p_objmsg.CLAUSE) <> 0 THEN
        v_strRecord_Key := Trim(substr(p_objmsg.CLAUSE,1, InStr(p_objmsg.CLAUSE, '=')-1));
        v_strRecord_Value := Trim(substr(p_objmsg.CLAUSE,InStr(p_objmsg.CLAUSE, '=') +1));
        v_strRecord_Value := REPLACE(v_strRecord_Value,'''','');
       end if;
     -- check neu to chuc da dc gan vao quy thi khong cho xoa
 SELECT COUNT(*) INTO L_COUNT
    FROM MEMBERS M, FMEMBERS FM
    WHERE FM.MBID = M.AUTOID
    and m.autoid = v_strRecord_Value;
    IF l_count  >  0 THEN
        p_err_code := '-111186';
        plog.setendsection (pkgctx, 'fn_CheckBeforeAdd');
        RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;*/

    /*SELECT COUNT(1) into  l_count FROM roles r  where r.Mbid = v_strRecord_Value;
    PLOG.error(PKGCTX,'binh'||v_strRecord_Value);

     IF l_count  >  0 THEN
        p_err_code := '-100123';
        plog.setendsection (pkgctx, 'fn_CheckBeforeAdd');
        RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;*/
    plog.setendsection (pkgctx, 'fn_CheckBeforeDelete');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_CheckBeforeDelete');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_CheckBeforeDelete;

FUNCTION fn_ProcessAfterDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
    v_strRecord_Key varchar2(30);
    v_strRecord_Value varchar2(30);
BEGIN
    plog.setbeginsection (pkgctx, 'fn_ProcessAfterDelete');
     /* IF  length(p_objmsg.CLAUSE) <> 0 THEN
        v_strRecord_Key := Trim(substr(p_objmsg.CLAUSE,1, InStr(p_objmsg.CLAUSE, '=')-1));
        v_strRecord_Value := Trim(substr(p_objmsg.CLAUSE,InStr(p_objmsg.CLAUSE, '=') +1));
        v_strRecord_Value := REPLACE(v_strRecord_Value,'''','');
      end if;

     DELETE FROM ROLES R WHERE R.MBID = v_strRecord_Value;*/
    plog.setendsection (pkgctx, 'fn_ProcessAfterDelete');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessAfterDelete');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessAfterDelete;

FUNCTION fn_CheckBeforeApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_CheckBeforeApprove');

    plog.setendsection (pkgctx, 'fn_CheckBeforeApprove');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_CheckBeforeApprove');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_CheckBeforeApprove;

FUNCTION fn_ProcessAfterApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
    l_fldval varchar2(4000);
    l_fldtype  varchar2(4000);
    l_fldname  varchar2(4000);
    l_updatetmp varchar2(4000);
    l_upd        varchar2(4000);
    l_actionflag varchar2(400);
    l_childvalue varchar2(400);
    l_childkey varchar2(400);
    l_chiltable varchar2(400);
    l_modulcode varchar2(12);
    l_refobjid  varchar2(12);
BEGIN
    plog.setbeginsection (pkgctx, 'fn_ProcessAfterApprove');
    l_refobjid  :=  p_objmsg.CLAUSE;
    /*FOR REC IN ( SELECT * FROM objlog WHERE AUTOID = l_refobjid OR PAUTOID =l_refobjid)
    LOOP
        l_refobjid:= REC.AUTOID;
        --Lay tham so duyet
        SELECT actionflag,childvalue,childkey,chiltable
        INTO l_actionflag,l_childvalue,l_childkey,l_chiltable FROM objlog WHERE AUTOID = l_refobjid;

         IF l_actionflag ='DELETE' THEN
           DELETE FROM ROLES R WHERE R.MBID = l_childvalue;
         END IF;
    END LOOP;*/
    plog.setendsection (pkgctx, 'fn_ProcessAfterApprove');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessAfterApprove');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessAfterApprove;

FUNCTION fn_CheckBeforeReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_CheckBeforeReject');

    plog.setendsection (pkgctx, 'fn_CheckBeforeReject');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_CheckBeforeReject');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_CheckBeforeReject;

FUNCTION fn_ProcessAfterReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_ProcessAfterReject');

    plog.setendsection (pkgctx, 'fn_ProcessAfterReject');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessAfterReject');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessAfterReject;

BEGIN
      FOR i IN (SELECT *
                FROM tlogdebug)
      LOOP
         logrow.loglevel    := i.loglevel;
         logrow.log4table   := i.log4table;
         logrow.log4alert   := i.log4alert;
         logrow.log4trace   := i.log4trace;
      END LOOP;
      pkgctx    :=
         plog.init ('txpks_#cf.cfauth',
                    plevel => NVL(logrow.loglevel,30),
                    plogtable => (NVL(logrow.log4table,'N') = 'Y'),
                    palert => (NVL(logrow.log4alert,'N') = 'Y'),
                    ptrace => (NVL(logrow.log4trace,'N') = 'Y')
            );
END txpks_#sa_FEECMD;
/

DROP PACKAGE txpks_#sa_feemaster
/

CREATE OR REPLACE 
PACKAGE txpks_#sa_feemaster 
/** ----------------------------------------------------------------------------------------------------
 dung cho form maintenance
 ----------------------------------------------------------------------------------------------------*/
IS

FUNCTION fn_Transfer(p_xmlmsg in out varchar2,p_err_code in out varchar2,p_err_param out varchar2)
RETURN NUMBER;
FUNCTION fn_Add(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Edit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Delete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Adhoc(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Approve(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Reject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;

--rieng
FUNCTION fn_CheckBeforeAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;

END;
/

DROP PACKAGE txpks_#sa_feetier
/

CREATE OR REPLACE 
PACKAGE txpks_#sa_feetier 
/** ----------------------------------------------------------------------------------------------------
 dung cho form maintenance
 ----------------------------------------------------------------------------------------------------*/
IS

FUNCTION fn_Transfer(p_xmlmsg in out varchar2,p_err_code in out varchar2,p_err_param out varchar2)
RETURN NUMBER;
FUNCTION fn_Add(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Edit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Delete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Adhoc(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Approve(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Reject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;

--rieng
FUNCTION fn_CheckBeforeAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;

END;
/

CREATE OR REPLACE 
PACKAGE BODY txpks_#sa_feetier 
IS
   pkgctx   plog.log_ctx;
   logrow   tlogdebug%ROWTYPE;

FUNCTION fn_Transfer(p_xmlmsg in out varchar2,p_err_code in out varchar2,p_err_param out varchar2)
RETURN NUMBER
IS
   l_return_code VARCHAR2(30) := systemnums.C_SUCCESS;
   l_objmsg tx.obj_rectype;
   l_count NUMBER(3);
   l_msgtype VARCHAR2(10);
   l_objname VARCHAR2(100);
   l_actionflag varchar2(100);
   l_currdate varchar2(10);
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Transfer');
   plog.debug(pkgctx, 'fn_Transfer');
   --get object
   l_objmsg:= txpks_msg.fn_mt_xml2obj(p_xmlmsg);
   l_msgtype:= l_objmsg.MSGTYPE;
   l_objname:= l_objmsg.OBJNAME;
   l_actionflag:= l_objmsg.ACTIONFLAG;
   --Kiem tra msgtype de phan luong xu ly
   IF l_actionflag ='ADD' THEN
        IF fn_Add(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;
   ELSIF l_actionflag ='EDIT' THEN
        IF fn_Edit(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;

   ELSIF l_actionflag ='DELETE' THEN
        IF fn_Delete(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;
   ELSIF l_actionflag ='ADHOC' THEN
        IF fn_Adhoc(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;
   ELSIF l_actionflag ='APPROVE' THEN
        IF fn_Approve(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;
   ELSIF l_actionflag ='REJECT' THEN
        IF fn_Reject(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;
   END IF;

   plog.debug(pkgctx, 'fn_Transfer');
   plog.setendsection (pkgctx, 'fn_Transfer');
   RETURN l_return_code;
EXCEPTION
WHEN errnums.E_BIZ_RULE_INVALID
   THEN
      FOR I IN (
           SELECT ERRDESC,EN_ERRDESC FROM deferror
           WHERE ERRNUM= p_err_code
      ) LOOP
           p_err_param := i.errdesc;
      END LOOP;
      p_xmlmsg := txpks_msg.fn_mt_obj2xml(l_objmsg);
      plog.setendsection (pkgctx, 'fn_Transfer');
      ROLLBACK;
      RETURN errnums.C_BIZ_RULE_INVALID;
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      p_err_param := 'SYSTEM_ERROR';
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      p_xmlmsg := txpks_msg.fn_mt_obj2xml(l_objmsg);
      plog.setendsection (pkgctx, 'fn_Transfer');
      RETURN errnums.C_SYSTEM_ERROR;
END fn_Transfer;

FUNCTION fn_Add(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Add');
-- Check befor add
   IF txpks_#sa_feetier.fn_CheckBeforeAdd(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- Auto add
   IF txpks_maintain.fn_ProcessAdd(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- After Add
   IF txpks_#sa_feetier.fn_ProcessAfterAdd(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
--ghi log
   IF txpks_maintain.fn_MaintainLog(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   plog.setendsection (pkgctx, 'fn_Add');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Add');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Add;

FUNCTION fn_Edit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Edit');
-- Check befor edit
   IF txpks_#sa_feetier.fn_CheckBeforeEdit(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- Auto Edit
   IF txpks_maintain.fn_ProcessEdit(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- After Edit
   IF txpks_#sa_feetier.fn_ProcessAfterEdit(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   --ghi log
   IF txpks_maintain.fn_MaintainLog(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   plog.setendsection (pkgctx, 'fn_Edit');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Edit');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Edit;

FUNCTION fn_Delete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Delete');
-- Check befor Delete
   IF txpks_#sa_feetier.fn_CheckBeforeDelete(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- Auto Delete
   IF txpks_maintain.fn_ProcessDelete(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- After Delete
   IF txpks_#sa_feetier.fn_ProcessAfterDelete(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   --ghi log
   IF txpks_maintain.fn_MaintainLog(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   plog.setendsection (pkgctx, 'fn_Delete');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Delete');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Delete;

FUNCTION fn_Adhoc(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Adhoc');

   plog.setendsection (pkgctx, 'fn_Adhoc');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Adhoc');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Adhoc;

FUNCTION fn_Approve(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Approve');

    IF txpks_maintain.fn_Approve(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;

   plog.setendsection (pkgctx, 'fn_Approve');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Approve');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Approve;

FUNCTION fn_Reject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Reject');

   IF txpks_maintain.fn_Reject(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;

   plog.setendsection (pkgctx, 'fn_Reject');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Reject');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Reject;


FUNCTION fn_CheckBeforeAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
    l_toamt number;
BEGIN
   plog.setbeginsection (pkgctx, 'fn_CheckBeforeAdd');
  /* IF p_objmsg.OBJFIELDS('FEETYPE').value = 'R' THEN
      SELECT NVL(MAX(FT.TOAMT),0) into l_toamt FROM FEETIER FT  WHERE FT.FEEID =  p_objmsg.OBJFIELDS('FEEID').value AND FT.FEETYPE = 'R' ;
   ELSE
       SELECT NVL(MAX(FT.TOAMT),0) into l_toamt FROM FEETIER FT  WHERE FT.FEEID =  p_objmsg.OBJFIELDS('FEEID').value AND FT.FEETYPE = 'E' ;
   END IF;
   if p_objmsg.OBJFIELDS('FRAMT').value < l_toamt then
        p_err_code := '-111182';
        plog.setendsection (pkgctx, 'fn_CheckBeforeAdd');
        RETURN errnums.C_BIZ_RULE_INVALID;
   end if;*/

     select  count(1) into l_count from feemaster  d where d.id  = p_objmsg.OBJFIELDS('FEEID').value AND d.status = 'R';
  IF l_count > 0  then
    p_err_code := '-111175';
        plog.setendsection (pkgctx, 'fn_CheckBeforeAdd');
        RETURN errnums.C_BIZ_RULE_INVALID;
 end if;

    plog.setendsection (pkgctx, 'fn_CheckBeforeAdd');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_CheckBeforeAdd');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_CheckBeforeAdd;

FUNCTION fn_ProcessAfterAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_ProcessAfterAdd');

    plog.setendsection (pkgctx, 'fn_ProcessAfterAdd');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessAfterAdd');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessAfterAdd;

FUNCTION fn_CheckBeforeEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_CheckBeforeEdit');

    plog.setendsection (pkgctx, 'fn_CheckBeforeEdit');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_CheckBeforeEdit');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_CheckBeforeEdit;

FUNCTION fn_ProcessAfterEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_ProcessAfterEdit');

    plog.setendsection (pkgctx, 'fn_ProcessAfterEdit');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessAfterEdit');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessAfterEdit;

FUNCTION fn_CheckBeforeDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_CheckBeforeDelete');

    plog.setendsection (pkgctx, 'fn_CheckBeforeDelete');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_CheckBeforeDelete');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_CheckBeforeDelete;

FUNCTION fn_ProcessAfterDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_ProcessAfterDelete');

    plog.setendsection (pkgctx, 'fn_ProcessAfterDelete');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessAfterDelete');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessAfterDelete;

FUNCTION fn_CheckBeforeApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_CheckBeforeApprove');

    plog.setendsection (pkgctx, 'fn_CheckBeforeApprove');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_CheckBeforeApprove');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_CheckBeforeApprove;

FUNCTION fn_ProcessAfterApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_ProcessAfterApprove');

    plog.setendsection (pkgctx, 'fn_ProcessAfterApprove');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessAfterApprove');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessAfterApprove;

FUNCTION fn_CheckBeforeReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_CheckBeforeReject');

    plog.setendsection (pkgctx, 'fn_CheckBeforeReject');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_CheckBeforeReject');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_CheckBeforeReject;

FUNCTION fn_ProcessAfterReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_ProcessAfterReject');

    plog.setendsection (pkgctx, 'fn_ProcessAfterReject');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessAfterReject');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessAfterReject;

BEGIN
      FOR i IN (SELECT *
                FROM tlogdebug)
      LOOP
         logrow.loglevel    := i.loglevel;
         logrow.log4table   := i.log4table;
         logrow.log4alert   := i.log4alert;
         logrow.log4trace   := i.log4trace;
      END LOOP;
      pkgctx    :=
         plog.init ('txpks_#sa_feetier',
                    plevel => NVL(logrow.loglevel,30),
                    plogtable => (NVL(logrow.log4table,'N') = 'Y'),
                    palert => (NVL(logrow.log4alert,'N') = 'Y'),
                    ptrace => (NVL(logrow.log4trace,'N') = 'Y')
            );
END txpks_#sa_feetier;
/

DROP PACKAGE txpks_#sa_feetype
/

CREATE OR REPLACE 
PACKAGE txpks_#sa_feetype 
/** ----------------------------------------------------------------------------------------------------
 dung cho form maintenance
 ----------------------------------------------------------------------------------------------------*/
IS

FUNCTION fn_Transfer(p_xmlmsg in out tx.obj_rectype,p_err_code in out varchar2,p_err_param out varchar2)
RETURN NUMBER;
FUNCTION fn_Add(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Edit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Delete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Adhoc(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Approve(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Reject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;

--rieng
FUNCTION fn_CheckBeforeAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;

END;
/

CREATE OR REPLACE 
PACKAGE BODY txpks_#sa_feetype 
IS
   pkgctx   plog.log_ctx;
   logrow   tlogdebug%ROWTYPE;

FUNCTION fn_Transfer(p_xmlmsg in out tx.obj_rectype,p_err_code in out varchar2,p_err_param out varchar2)
RETURN NUMBER
IS
   l_return_code VARCHAR2(30) := systemnums.C_SUCCESS;
   l_objmsg tx.obj_rectype;
   l_count NUMBER(3);
   l_msgtype VARCHAR2(10);
   l_objname VARCHAR2(100);
   l_actionflag varchar2(100);
   l_currdate varchar2(10);

   l_txnum     varchar2(50);
   l_txdate    date;
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Transfer');
   plog.debug(pkgctx, 'fn_Transfer');
   --get object

   l_objmsg:= p_xmlmsg;--txpks_msg.fn_mt_xml2obj(p_xmlmsg);
   l_msgtype:= l_objmsg.MSGTYPE;
   l_objname:= l_objmsg.OBJNAME;
   l_actionflag:= l_objmsg.ACTIONFLAG;

   --Kiem tra msgtype de phan luong xu ly
   IF l_actionflag ='ADD' THEN
        IF fn_Add(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;
   ELSIF l_actionflag ='EDIT' THEN
        IF fn_Edit(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;

   ELSIF l_actionflag ='DELETE' THEN
        IF fn_Delete(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;
   ELSIF l_actionflag ='ADHOC' THEN
        IF fn_Adhoc(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;
   ELSIF l_actionflag ='APPROVE' THEN
        IF fn_Approve(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;
   ELSIF l_actionflag ='REJECT' THEN
        IF fn_Reject(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;
   END IF;

   if l_actionflag IN ('ADD','EDIT','DELETE','APPROVE_OBJLOG','REJECT_OBJLOG','APPROVE','REJECT') then
        select txdate, txnum into l_txdate,l_txnum
        from objlog where autoid = l_objmsg.objlogID;

        txpks_notify.prc_system_logevent('OBJLOG', 'TRANS',
                            'ALL' || '~#~' ||
                            l_txnum || '~#~' ||
                            to_char(l_txdate, 'DD/MM/YYYY')
                            ,'R','INSERT/UPDATE OBJLOG');
   end if;

   plog.debug(pkgctx, 'fn_Transfer');
   plog.setendsection (pkgctx, 'fn_Transfer');
   RETURN l_return_code;
EXCEPTION
WHEN errnums.E_BIZ_RULE_INVALID
   THEN
      FOR I IN (
           SELECT ERRDESC,EN_ERRDESC FROM deferror
           WHERE ERRNUM= p_err_code
      ) LOOP
           p_err_param := i.errdesc;
      END LOOP;
      p_xmlmsg := l_objmsg;--txpks_msg.fn_mt_obj2xml(l_objmsg);
      plog.setendsection (pkgctx, 'fn_Transfer');
      ROLLBACK;
      RETURN errnums.C_BIZ_RULE_INVALID;
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      p_err_param := 'SYSTEM_ERROR';
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      p_xmlmsg := l_objmsg;--txpks_msg.fn_mt_obj2xml(l_objmsg);
      plog.setendsection (pkgctx, 'fn_Transfer');
      RETURN errnums.C_SYSTEM_ERROR;
END fn_Transfer;

FUNCTION fn_Add(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Add');
-- Check befor add
   IF txpks_#sa_feetype.fn_CheckBeforeAdd(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- Auto add
   IF txpks_maintain.fn_ProcessAdd(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- After Add
   IF txpks_#sa_feetype.fn_ProcessAfterAdd(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
--ghi log
   IF txpks_maintain.fn_MaintainLog(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   plog.setendsection (pkgctx, 'fn_Add');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Add');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Add;

FUNCTION fn_Edit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Edit');
-- Check befor edit
   IF txpks_#sa_feetype.fn_CheckBeforeEdit(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- Auto Edit
   IF txpks_maintain.fn_ProcessEdit(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- After Edit
   IF txpks_#sa_feetype.fn_ProcessAfterEdit(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   --ghi log
   IF txpks_maintain.fn_MaintainLog(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   plog.setendsection (pkgctx, 'fn_Edit');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Edit');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Edit;

FUNCTION fn_Delete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Delete');
-- Check befor Delete
   IF txpks_#sa_feetype.fn_CheckBeforeDelete(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- Auto Delete
   IF txpks_maintain.fn_ProcessDelete(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- After Delete
   IF txpks_#sa_feetype.fn_ProcessAfterDelete(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   --ghi log
   IF txpks_maintain.fn_MaintainLog(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   plog.setendsection (pkgctx, 'fn_Delete');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Delete');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Delete;

FUNCTION fn_Adhoc(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Adhoc');

   plog.setendsection (pkgctx, 'fn_Adhoc');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Adhoc');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Adhoc;

FUNCTION fn_Approve(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
l_refobjid  varchar2(12);
l_count number;
l_childvalue varchar2(100);
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Approve');
   --GHI NHAN VAO BANG PREV VA TANG VER TRUOC KHI DUYET SUA
  /* l_refobjid  :=  p_objmsg.CLAUSE;
   plog.error (pkgctx, 'l_refobjid: ' || l_refobjid);
   SELECT OL.CHILDVALUE INTO l_childvalue FROM OBJLOG OL WHERE OL.AUTOID = l_refobjid;
   SELECT COUNT(*) into l_count FROM MAINTAIN_LOG LOG WHERE LOG.REFOBJID = l_refobjid AND LOG.COLUMN_NAME = 'ISAPPLY' and log.action_flag = 'EDIT';
   IF l_count > 0 then
      GET_VER_FEE (l_childvalue);
   END IF;
   */
   IF txpks_maintain.fn_Approve(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;

   plog.setendsection (pkgctx, 'fn_Approve');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Approve');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Approve;

FUNCTION fn_Reject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Reject');

       IF txpks_maintain.fn_Reject(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;

   plog.setendsection (pkgctx, 'fn_Reject');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Reject');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Reject;


FUNCTION fn_CheckBeforeAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
   plog.setbeginsection (pkgctx, 'fn_CheckBeforeAdd');
  /* --Kiem tra cmnd khong duoc trung
   SELECT COUNT(ID) INTO l_count FROM feetype WHERE id = p_objmsg.OBJFIELDS('ID').value;

   IF l_count >0 THEN
        p_err_code := '-200001';
        plog.setendsection (pkgctx, 'fn_CheckBeforeAdd');
        RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;*/
       -- khong cho them moi o trang thai cho duyet dong
 /*select  count(1) into l_count from FUND d where d.codeid= p_objmsg.OBJFIELDS('CODEID').value AND d.status = 'R';
  IF l_count > 0  then
    p_err_code := '-111175';
        plog.setendsection (pkgctx, 'fn_CheckBeforeAdd');
        RETURN errnums.C_BIZ_RULE_INVALID;
 end if;*/

    plog.setendsection (pkgctx, 'fn_CheckBeforeAdd');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_CheckBeforeAdd');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_CheckBeforeAdd;

FUNCTION fn_ProcessAfterAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_ProcessAfterAdd');

    plog.setendsection (pkgctx, 'fn_ProcessAfterAdd');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessAfterAdd');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessAfterAdd;

FUNCTION fn_CheckBeforeEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_CheckBeforeEdit');

    plog.setendsection (pkgctx, 'fn_CheckBeforeEdit');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_CheckBeforeEdit');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_CheckBeforeEdit;

FUNCTION fn_ProcessAfterEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_ProcessAfterEdit');

    plog.setendsection (pkgctx, 'fn_ProcessAfterEdit');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessAfterEdit');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessAfterEdit;

FUNCTION fn_CheckBeforeDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
    v_strRecord_Key varchar2(30);
    v_strRecord_Value varchar2(30);
BEGIN
    plog.setbeginsection (pkgctx, 'fn_CheckBeforeDelete');

      IF  length(p_objmsg.CLAUSE) <> 0 THEN
        v_strRecord_Key := Trim(substr(p_objmsg.CLAUSE,1, InStr(p_objmsg.CLAUSE, '=')-1));
        v_strRecord_Value := Trim(substr(p_objmsg.CLAUSE,InStr(p_objmsg.CLAUSE, '=') +1));
        v_strRecord_Value := REPLACE(v_strRecord_Value,'''','');
       end if;
    SELECT COUNT(1) into  l_count FROM feeapply  r  where r.feeid = v_strRecord_Value;
   -- PLOG.error(PKGCTX,'binh'||v_strRecord_Value);

     IF l_count  >  0 THEN
        p_err_code := '-100123';
        plog.setendsection (pkgctx, 'fn_CheckBeforeAdd');
        RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
    plog.setendsection (pkgctx, 'fn_CheckBeforeDelete');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_CheckBeforeDelete');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_CheckBeforeDelete;

FUNCTION fn_ProcessAfterDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_ProcessAfterDelete');

    plog.setendsection (pkgctx, 'fn_ProcessAfterDelete');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessAfterDelete');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessAfterDelete;

FUNCTION fn_CheckBeforeApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_CheckBeforeApprove');

    plog.setendsection (pkgctx, 'fn_CheckBeforeApprove');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_CheckBeforeApprove');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_CheckBeforeApprove;

FUNCTION fn_ProcessAfterApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_ProcessAfterApprove');

    plog.setendsection (pkgctx, 'fn_ProcessAfterApprove');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessAfterApprove');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessAfterApprove;

FUNCTION fn_CheckBeforeReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_CheckBeforeReject');

    plog.setendsection (pkgctx, 'fn_CheckBeforeReject');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_CheckBeforeReject');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_CheckBeforeReject;

FUNCTION fn_ProcessAfterReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
    l_refobjid varchar2(1000);
    l_actionflag varchar2(100);
    l_childvalue varchar2(100);
    l_childkey varchar2(100);
    l_chiltable varchar2(100);
BEGIN
    plog.setbeginsection (pkgctx, 'fn_ProcessAfterReject');
  /*  l_refobjid := p_objmsg.CLAUSE;
    plog.error(pkgctx,'l_refobjid:'||l_refobjid);
    SELECT actionflag,childvalue,childkey,chiltable
    INTO l_actionflag,l_childvalue,l_childkey,l_chiltable FROM objlog WHERE AUTOID = l_refobjid;

    plog.error(pkgctx,'l_actionflag:'||l_actionflag);

    IF l_actionflag ='ADD' THEN
        DELETE FROM FEEAPPLY WHERE FEEID =  l_childvalue AND status ='P' ;
    end if;*/
    plog.setendsection (pkgctx, 'fn_ProcessAfterReject');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessAfterReject');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessAfterReject;

BEGIN
      FOR i IN (SELECT *
                FROM tlogdebug)
      LOOP
         logrow.loglevel    := i.loglevel;
         logrow.log4table   := i.log4table;
         logrow.log4alert   := i.log4alert;
         logrow.log4trace   := i.log4trace;
      END LOOP;
      pkgctx    :=
         plog.init ('txpks_#sa_feetype',
                    plevel => NVL(logrow.loglevel,30),
                    plogtable => (NVL(logrow.log4table,'N') = 'Y'),
                    palert => (NVL(logrow.log4alert,'N') = 'Y'),
                    ptrace => (NVL(logrow.log4trace,'N') = 'Y')
            );
END txpks_#sa_feetype;
/

DROP PACKAGE txpks_#sa_fmacctno
/

CREATE OR REPLACE 
PACKAGE txpks_#sa_fmacctno 
/** ----------------------------------------------------------------------------------------------------
 dung cho form maintenance
 ----------------------------------------------------------------------------------------------------*/
IS

FUNCTION fn_Transfer(p_xmlmsg in out varchar2,p_err_code in out varchar2,p_err_param out varchar2)
RETURN NUMBER;
FUNCTION fn_Add(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Edit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Delete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Adhoc(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Approve(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Reject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;

--rieng
FUNCTION fn_CheckBeforeAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;

END;
/

DROP PACKAGE txpks_#sa_fmembers
/

CREATE OR REPLACE 
PACKAGE txpks_#sa_fmembers 
/** ----------------------------------------------------------------------------------------------------
 dung cho form maintenance
 ----------------------------------------------------------------------------------------------------*/
IS

FUNCTION fn_Transfer(p_xmlmsg in out varchar2,p_err_code in out varchar2,p_err_param out varchar2)
RETURN NUMBER;
FUNCTION fn_Add(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Edit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Delete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Adhoc(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Approve(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Reject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;

--rieng
FUNCTION fn_CheckBeforeAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;

END;
/

DROP PACKAGE txpks_#sa_fund
/

CREATE OR REPLACE 
PACKAGE txpks_#sa_fund 
/** ----------------------------------------------------------------------------------------------------
 dung cho form maintenance
 ----------------------------------------------------------------------------------------------------*/
IS

FUNCTION fn_Transfer(p_xmlmsg in out varchar2,p_err_code in out varchar2,p_err_param out varchar2)
RETURN NUMBER;
FUNCTION fn_Add(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Edit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Delete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Adhoc(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Approve(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Reject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;

--rieng
FUNCTION fn_CheckBeforeAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;

END;
/

DROP PACKAGE txpks_#sa_fund_member
/

CREATE OR REPLACE 
PACKAGE txpks_#sa_fund_member 
/** ----------------------------------------------------------------------------------------------------
 dung cho form maintenance
 ----------------------------------------------------------------------------------------------------*/
IS

FUNCTION fn_Transfer(p_xmlmsg in out varchar2,p_err_code in out varchar2,p_err_param out varchar2)
RETURN NUMBER;
FUNCTION fn_Add(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Edit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Delete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Adhoc(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Approve(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Reject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;

--rieng
FUNCTION fn_CheckBeforeAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;

END;
/

CREATE OR REPLACE 
PACKAGE BODY txpks_#sa_fund_member 
IS
   pkgctx   plog.log_ctx;
   logrow   tlogdebug%ROWTYPE;

FUNCTION fn_Transfer(p_xmlmsg in out varchar2,p_err_code in out varchar2,p_err_param out varchar2)
RETURN NUMBER
IS
   l_return_code VARCHAR2(30) := systemnums.C_SUCCESS;
   l_objmsg tx.obj_rectype;
   l_count NUMBER(3);
   l_msgtype VARCHAR2(10);
   l_objname VARCHAR2(100);
   l_actionflag varchar2(100);
   l_currdate varchar2(10);
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Transfer');
   plog.debug(pkgctx, 'fn_Transfer');
   --get object
   l_objmsg:= txpks_msg.fn_mt_xml2obj(p_xmlmsg);
   l_msgtype:= l_objmsg.MSGTYPE;
   l_objname:= l_objmsg.OBJNAME;
   l_actionflag:= l_objmsg.ACTIONFLAG;
   --Kiem tra msgtype de phan luong xu ly
   IF l_actionflag ='ADD' THEN
        IF fn_Add(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;
   ELSIF l_actionflag ='EDIT' THEN
        IF fn_Edit(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;

   ELSIF l_actionflag ='DELETE' THEN
        IF fn_Delete(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;
   ELSIF l_actionflag ='ADHOC' THEN
        IF fn_Adhoc(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;
   ELSIF l_actionflag ='APPROVE' THEN
        IF fn_Approve(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;
   ELSIF l_actionflag ='REJECT' THEN
        IF fn_Reject(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;
   END IF;

   plog.debug(pkgctx, 'fn_Transfer');
   plog.setendsection (pkgctx, 'fn_Transfer');
   RETURN l_return_code;
EXCEPTION
WHEN errnums.E_BIZ_RULE_INVALID
   THEN
      FOR I IN (
           SELECT ERRDESC,EN_ERRDESC FROM deferror
           WHERE ERRNUM= p_err_code
      ) LOOP
           p_err_param := i.errdesc;
      END LOOP;
      p_xmlmsg := txpks_msg.fn_mt_obj2xml(l_objmsg);
      plog.setendsection (pkgctx, 'fn_Transfer');
      ROLLBACK;
      RETURN errnums.C_BIZ_RULE_INVALID;
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      p_err_param := 'SYSTEM_ERROR';
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      p_xmlmsg := txpks_msg.fn_mt_obj2xml(l_objmsg);
      plog.setendsection (pkgctx, 'fn_Transfer');
      RETURN errnums.C_SYSTEM_ERROR;
END fn_Transfer;

FUNCTION fn_Add(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Add');
-- Check befor add
   IF txpks_#sa_fund_member.fn_CheckBeforeAdd(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- Auto add
   IF txpks_maintain.fn_ProcessAdd(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- After Add
   IF txpks_#sa_fund_member.fn_ProcessAfterAdd(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
--ghi log
   IF txpks_maintain.fn_MaintainLog(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   plog.setendsection (pkgctx, 'fn_Add');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Add');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Add;

FUNCTION fn_Edit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Edit');
-- Check befor edit
   IF txpks_#sa_fund_member.fn_CheckBeforeEdit(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- Auto Edit
   IF txpks_maintain.fn_ProcessEdit(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- After Edit
   IF txpks_#sa_fund_member.fn_ProcessAfterEdit(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   --ghi log
   IF txpks_maintain.fn_MaintainLog(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   plog.setendsection (pkgctx, 'fn_Edit');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Edit');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Edit;

FUNCTION fn_Delete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Delete');
-- Check befor Delete
   IF txpks_#sa_fund_member.fn_CheckBeforeDelete(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- Auto Delete
   IF txpks_maintain.fn_ProcessDelete(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- After Delete
   IF txpks_#sa_fund_member.fn_ProcessAfterDelete(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   --ghi log
   IF txpks_maintain.fn_MaintainLog(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   plog.setendsection (pkgctx, 'fn_Delete');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Delete');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Delete;

FUNCTION fn_Adhoc(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Adhoc');

   plog.setendsection (pkgctx, 'fn_Adhoc');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Adhoc');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Adhoc;

FUNCTION fn_Approve(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Approve');
   IF txpks_maintain.fn_Approve(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   plog.setendsection (pkgctx, 'fn_Approve');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Approve');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Approve;

FUNCTION fn_Reject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Reject');

       IF txpks_maintain.fn_Reject(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;

   plog.setendsection (pkgctx, 'fn_Reject');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Reject');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Reject;


FUNCTION fn_CheckBeforeAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
   plog.setbeginsection (pkgctx, 'fn_CheckBeforeAdd');
         -- khong cho them moi o trang thai cho duyet dong
 select  count(1) into l_count from fund d where d.symbol = p_objmsg.OBJFIELDS('SYMBOL').value AND d.status = 'R';
  IF l_count > 0  then
    p_err_code := '-111175';
        plog.setendsection (pkgctx, 'fn_CheckBeforeAdd');
        RETURN errnums.C_BIZ_RULE_INVALID;
 end if; 
    plog.setendsection (pkgctx, 'fn_CheckBeforeAdd');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_CheckBeforeAdd');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_CheckBeforeAdd;

FUNCTION fn_ProcessAfterAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_ProcessAfterAdd');

    plog.setendsection (pkgctx, 'fn_ProcessAfterAdd');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessAfterAdd');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessAfterAdd;

FUNCTION fn_CheckBeforeEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_CheckBeforeEdit');

    plog.setendsection (pkgctx, 'fn_CheckBeforeEdit');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_CheckBeforeEdit');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_CheckBeforeEdit;

FUNCTION fn_ProcessAfterEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_ProcessAfterEdit');

    plog.setendsection (pkgctx, 'fn_ProcessAfterEdit');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessAfterEdit');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessAfterEdit;

FUNCTION fn_CheckBeforeDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_CheckBeforeDelete');

    plog.setendsection (pkgctx, 'fn_CheckBeforeDelete');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_CheckBeforeDelete');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_CheckBeforeDelete;

FUNCTION fn_ProcessAfterDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_ProcessAfterDelete');

    plog.setendsection (pkgctx, 'fn_ProcessAfterDelete');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessAfterDelete');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessAfterDelete;

FUNCTION fn_CheckBeforeApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_CheckBeforeApprove');

    plog.setendsection (pkgctx, 'fn_CheckBeforeApprove');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_CheckBeforeApprove');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_CheckBeforeApprove;

FUNCTION fn_ProcessAfterApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_ProcessAfterApprove');

    plog.setendsection (pkgctx, 'fn_ProcessAfterApprove');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessAfterApprove');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessAfterApprove;

FUNCTION fn_CheckBeforeReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_CheckBeforeReject');

    plog.setendsection (pkgctx, 'fn_CheckBeforeReject');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_CheckBeforeReject');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_CheckBeforeReject;

FUNCTION fn_ProcessAfterReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_ProcessAfterReject');

    plog.setendsection (pkgctx, 'fn_ProcessAfterReject');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessAfterReject');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessAfterReject;

BEGIN
      FOR i IN (SELECT *
                FROM tlogdebug)
      LOOP
         logrow.loglevel    := i.loglevel;
         logrow.log4table   := i.log4table;
         logrow.log4alert   := i.log4alert;
         logrow.log4trace   := i.log4trace;
      END LOOP;
      pkgctx    :=
         plog.init ('txpks_#sa.fund_member',
                    plevel => NVL(logrow.loglevel,30),
                    plogtable => (NVL(logrow.log4table,'N') = 'Y'),
                    palert => (NVL(logrow.log4alert,'N') = 'Y'),
                    ptrace => (NVL(logrow.log4trace,'N') = 'Y')
            );
END txpks_#sa_fund_member;
/

DROP PACKAGE txpks_#sa_funddtl
/

CREATE OR REPLACE 
PACKAGE txpks_#sa_funddtl 
/** ----------------------------------------------------------------------------------------------------
 dung cho form maintenance
 ----------------------------------------------------------------------------------------------------*/
IS

FUNCTION fn_Transfer(p_xmlmsg in out varchar2,p_err_code in out varchar2,p_err_param out varchar2)
RETURN NUMBER;
FUNCTION fn_Add(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Edit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Delete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Adhoc(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Approve(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Reject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;

--rieng
FUNCTION fn_CheckBeforeAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;

END;
/

CREATE OR REPLACE 
PACKAGE BODY txpks_#sa_funddtl 
IS
   pkgctx   plog.log_ctx;
   logrow   tlogdebug%ROWTYPE;

FUNCTION fn_Transfer(p_xmlmsg in out varchar2,p_err_code in out varchar2,p_err_param out varchar2)
RETURN NUMBER
IS
   l_return_code VARCHAR2(30) := systemnums.C_SUCCESS;
   l_objmsg tx.obj_rectype;
   l_count NUMBER(3);
   l_msgtype VARCHAR2(10);
   l_objname VARCHAR2(100);
   l_actionflag varchar2(100);
   l_currdate varchar2(10);
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Transfer');
   plog.debug(pkgctx, 'fn_Transfer');
   --get object
   l_objmsg:= txpks_msg.fn_mt_xml2obj(p_xmlmsg);
   l_msgtype:= l_objmsg.MSGTYPE;
   l_objname:= l_objmsg.OBJNAME;
   l_actionflag:= l_objmsg.ACTIONFLAG;
   --Kiem tra msgtype de phan luong xu ly
   IF l_actionflag ='ADD' THEN
        IF fn_Add(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;
   ELSIF l_actionflag ='EDIT' THEN
        IF fn_Edit(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;

   ELSIF l_actionflag ='DELETE' THEN
        IF fn_Delete(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;
   ELSIF l_actionflag ='ADHOC' THEN
        IF fn_Adhoc(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;
   ELSIF l_actionflag ='APPROVE' THEN
        IF fn_Approve(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;
   ELSIF l_actionflag ='REJECT' THEN
        IF fn_Reject(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;
   END IF;

   plog.debug(pkgctx, 'fn_Transfer');
   plog.setendsection (pkgctx, 'fn_Transfer');
   RETURN l_return_code;
EXCEPTION
WHEN errnums.E_BIZ_RULE_INVALID
   THEN
      FOR I IN (
           SELECT ERRDESC,EN_ERRDESC FROM deferror
           WHERE ERRNUM= p_err_code
      ) LOOP
           p_err_param := i.errdesc;
      END LOOP;
      p_xmlmsg := txpks_msg.fn_mt_obj2xml(l_objmsg);
      plog.setendsection (pkgctx, 'fn_Transfer');
      ROLLBACK;
      RETURN errnums.C_BIZ_RULE_INVALID;
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      p_err_param := 'SYSTEM_ERROR';
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      p_xmlmsg := txpks_msg.fn_mt_obj2xml(l_objmsg);
      plog.setendsection (pkgctx, 'fn_Transfer');
      RETURN errnums.C_SYSTEM_ERROR;
END fn_Transfer;

FUNCTION fn_Add(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Add');
-- Check befor add
   PLOG.error(PKGCTX, 'binhvt');
   IF txpks_#sa_funddtl.fn_CheckBeforeAdd(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- Auto add
   IF txpks_maintain.fn_ProcessAdd(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- After Add
   IF txpks_#sa_funddtl.fn_ProcessAfterAdd(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
--ghi log
   
   IF txpks_maintain.fn_MaintainLog(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   plog.setendsection (pkgctx, 'fn_Add');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Add');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Add;

FUNCTION fn_Edit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Edit');
-- Check befor edit
   IF txpks_#sa_funddtl.fn_CheckBeforeEdit(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- Auto Edit
   IF txpks_maintain.fn_ProcessEdit(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- After Edit
   IF txpks_#sa_funddtl.fn_ProcessAfterEdit(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   --ghi log
   IF txpks_maintain.fn_MaintainLog(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   plog.setendsection (pkgctx, 'fn_Edit');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Edit');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Edit;

FUNCTION fn_Delete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Delete');
-- Check befor Delete
   IF txpks_#sa_funddtl.fn_CheckBeforeDelete(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- Auto Delete
   IF txpks_maintain.fn_ProcessDelete(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- After Delete
   IF txpks_#sa_funddtl.fn_ProcessAfterDelete(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   --ghi log
   IF txpks_maintain.fn_MaintainLog(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   plog.setendsection (pkgctx, 'fn_Delete');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Delete');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Delete;

FUNCTION fn_Adhoc(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Adhoc');

   plog.setendsection (pkgctx, 'fn_Adhoc');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Adhoc');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Adhoc;

FUNCTION fn_Approve(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Approve');
   IF txpks_maintain.fn_Approve(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   plog.setendsection (pkgctx, 'fn_Approve');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Approve');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Approve;

FUNCTION fn_Reject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Reject');

       IF txpks_maintain.fn_Reject(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;

   plog.setendsection (pkgctx, 'fn_Reject');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Reject');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Reject;


FUNCTION fn_CheckBeforeAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
   plog.setbeginsection (pkgctx, 'fn_CheckBeforeAdd');
   --
   -- check thong tin tham so chi cho them moi 1 lan
select COUNT(*) INTO l_count from funddtl dtl where dtl.codeid = p_objmsg.OBJFIELDS('CODEID').value;  
  IF l_count > 0 then 
    p_err_code := '-111180';
    plog.setendsection (pkgctx, 'fn_CheckBeforeAdd');
    RETURN errnums.C_BIZ_RULE_INVALID;
 end if;  
   
     SELECT COUNT(1) INTO l_count FROM funddtl WHERE upper(codeid) = upper(p_objmsg.OBJFIELDS('CODEID').value);
   IF l_count >0 THEN
        p_err_code := '-111170';
        plog.setendsection (pkgctx, 'fn_CheckBeforeAdd');
        RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   if p_objmsg.OBJFIELDS('EXECDAY').value < p_objmsg.OBJFIELDS('CLSORDDAY').value then
      p_err_code := '-111172';
        plog.setendsection (pkgctx, 'fn_CheckBeforeAdd');
        RETURN errnums.C_BIZ_RULE_INVALID;
   end if;
   if p_objmsg.OBJFIELDS('MATCHDAY').value < p_objmsg.OBJFIELDS('CLSORDDAY').value then
      p_err_code := '-111175';
        plog.setendsection (pkgctx, 'fn_CheckBeforeAdd');
        RETURN errnums.C_BIZ_RULE_INVALID;
   end if;
   /*if p_objmsg.OBJFIELDS('CLSORDDAY').value IS NULL 
     OR p_objmsg.OBJFIELDS('MATCHDAY').value IS NULL
     OR p_objmsg.OBJFIELDS('RBANKDAY').value IS NULL
     OR p_objmsg.OBJFIELDS('EXECDAY').value IS NULL
     OR p_objmsg.OBJFIELDS('EXECMONNEYD').value IS NULL
      then
        p_err_code := '-111175';
        plog.setendsection (pkgctx, 'fn_CheckBeforeAdd');
        RETURN errnums.C_BIZ_RULE_INVALID;
   end if;*/

    -- khong cho them moi o trang thai cho duyet dong
 select  count(1) into l_count from fund d where d.symbol = p_objmsg.OBJFIELDS('SYMBOL').value AND d.status = 'R';
  IF l_count > 0  then
    p_err_code := '-111175';
        plog.setendsection (pkgctx, 'fn_CheckBeforeAdd');
        RETURN errnums.C_BIZ_RULE_INVALID;
 end if; 
    plog.setendsection (pkgctx, 'fn_CheckBeforeAdd');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_CheckBeforeAdd');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_CheckBeforeAdd;

FUNCTION fn_ProcessAfterAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_ProcessAfterAdd');

    plog.setendsection (pkgctx, 'fn_ProcessAfterAdd');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessAfterAdd');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessAfterAdd;

FUNCTION fn_CheckBeforeEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_CheckBeforeEdit');
    if p_objmsg.OBJFIELDS('EXECDAY').value < p_objmsg.OBJFIELDS('CLSORDDAY').value then
      p_err_code := '-111172';
        plog.setendsection (pkgctx, 'fn_CheckBeforeAdd');
        RETURN errnums.C_BIZ_RULE_INVALID;
   end if;
    plog.setendsection (pkgctx, 'fn_CheckBeforeEdit');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_CheckBeforeEdit');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_CheckBeforeEdit;

FUNCTION fn_ProcessAfterEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_ProcessAfterEdit');

    plog.setendsection (pkgctx, 'fn_ProcessAfterEdit');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessAfterEdit');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessAfterEdit;

FUNCTION fn_CheckBeforeDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
    v_strParentClause varchar2(100);
    v_strRecord_Key varchar2(100);
    v_strRecord_Value varchar2(100);
    v_codeid varchar2(100);
BEGIN
    plog.setbeginsection (pkgctx, 'fn_CheckBeforeDelete');

    v_strParentClause := p_objmsg.CLAUSE;
       IF  length(v_strParentClause) <> 0 THEN
        v_strRecord_Key := Trim(substr(v_strParentClause,1, InStr(v_strParentClause, '=')-1));
        v_strRecord_Value := Trim(substr(v_strParentClause,InStr(v_strParentClause, '=') +1));
        v_strRecord_Value := REPLACE(v_strRecord_Value,'''','');
       end if;

 select count(*) into l_count from tradingcycle TC WHERE TC.STATUS <> 'D' and TC.codeid = v_strRecord_Value ;
    IF l_count > 0 THEN
       p_err_code := '-100100';
       plog.setendsection (pkgctx, 'fn_txPreAppCheck');
       RETURN errnums.C_BIZ_RULE_INVALID;
    END IF;
    plog.setendsection (pkgctx, 'fn_CheckBeforeDelete');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_CheckBeforeDelete');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_CheckBeforeDelete;

FUNCTION fn_ProcessAfterDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_ProcessAfterDelete');

    plog.setendsection (pkgctx, 'fn_ProcessAfterDelete');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessAfterDelete');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessAfterDelete;

FUNCTION fn_CheckBeforeApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_CheckBeforeApprove');

    plog.setendsection (pkgctx, 'fn_CheckBeforeApprove');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_CheckBeforeApprove');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_CheckBeforeApprove;

FUNCTION fn_ProcessAfterApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_ProcessAfterApprove');

    plog.setendsection (pkgctx, 'fn_ProcessAfterApprove');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessAfterApprove');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessAfterApprove;

FUNCTION fn_CheckBeforeReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_CheckBeforeReject');

    plog.setendsection (pkgctx, 'fn_CheckBeforeReject');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_CheckBeforeReject');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_CheckBeforeReject;

FUNCTION fn_ProcessAfterReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_ProcessAfterReject');

    plog.setendsection (pkgctx, 'fn_ProcessAfterReject');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessAfterReject');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessAfterReject;

BEGIN
      FOR i IN (SELECT *
                FROM tlogdebug)
      LOOP
         logrow.loglevel    := i.loglevel;
         logrow.log4table   := i.log4table;
         logrow.log4alert   := i.log4alert;
         logrow.log4trace   := i.log4trace;
      END LOOP;
      pkgctx    :=
         plog.init ('txpks_#sa.funddtl',
                    plevel => NVL(logrow.loglevel,30),
                    plogtable => (NVL(logrow.log4table,'N') = 'Y'),
                    palert => (NVL(logrow.log4alert,'N') = 'Y'),
                    ptrace => (NVL(logrow.log4trace,'N') = 'Y')
            );
END txpks_#sa_funddtl;
/

DROP PACKAGE txpks_#sa_fundperson
/

CREATE OR REPLACE 
PACKAGE txpks_#sa_fundperson 
/** ----------------------------------------------------------------------------------------------------
 dung cho form maintenance
 ----------------------------------------------------------------------------------------------------*/
IS

FUNCTION fn_Transfer(p_xmlmsg in out varchar2,p_err_code in out varchar2,p_err_param out varchar2)
RETURN NUMBER;
FUNCTION fn_Add(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Edit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Delete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Adhoc(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Approve(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Reject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;

--rieng
FUNCTION fn_CheckBeforeAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;

END;
/

CREATE OR REPLACE 
PACKAGE BODY txpks_#sa_fundperson 
IS
   pkgctx   plog.log_ctx;
   logrow   tlogdebug%ROWTYPE;

FUNCTION fn_Transfer(p_xmlmsg in out varchar2,p_err_code in out varchar2,p_err_param out varchar2)
RETURN NUMBER
IS
   l_return_code VARCHAR2(30) := systemnums.C_SUCCESS;
   l_objmsg tx.obj_rectype;
   l_count NUMBER(3);
   l_msgtype VARCHAR2(10);
   l_objname VARCHAR2(100);
   l_actionflag varchar2(100);
   l_currdate varchar2(10);
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Transfer');
   plog.debug(pkgctx, 'fn_Transfer');
   --get object
   l_objmsg:= txpks_msg.fn_mt_xml2obj(p_xmlmsg);
   l_msgtype:= l_objmsg.MSGTYPE;
   l_objname:= l_objmsg.OBJNAME;
   l_actionflag:= l_objmsg.ACTIONFLAG;
   --Kiem tra msgtype de phan luong xu ly
   IF l_actionflag ='ADD' THEN
        IF fn_Add(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;
   ELSIF l_actionflag ='EDIT' THEN
        IF fn_Edit(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;

   ELSIF l_actionflag ='DELETE' THEN
        IF fn_Delete(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;
   ELSIF l_actionflag ='ADHOC' THEN
        IF fn_Adhoc(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;
   ELSIF l_actionflag ='APPROVE' THEN
        IF fn_Approve(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;
   ELSIF l_actionflag ='REJECT' THEN
        IF fn_Reject(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;
   END IF;

   plog.debug(pkgctx, 'fn_Transfer');
   plog.setendsection (pkgctx, 'fn_Transfer');
   RETURN l_return_code;
EXCEPTION
WHEN errnums.E_BIZ_RULE_INVALID
   THEN
      FOR I IN (
           SELECT ERRDESC,EN_ERRDESC FROM deferror
           WHERE ERRNUM= p_err_code
      ) LOOP
           p_err_param := i.errdesc;
      END LOOP;
      p_xmlmsg := txpks_msg.fn_mt_obj2xml(l_objmsg);
      plog.setendsection (pkgctx, 'fn_Transfer');
      ROLLBACK;
      RETURN errnums.C_BIZ_RULE_INVALID;
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      p_err_param := 'SYSTEM_ERROR';
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      p_xmlmsg := txpks_msg.fn_mt_obj2xml(l_objmsg);
      plog.setendsection (pkgctx, 'fn_Transfer');
      RETURN errnums.C_SYSTEM_ERROR;
END fn_Transfer;

FUNCTION fn_Add(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Add');
-- Check befor add
   IF txpks_#sa_fundperson.fn_CheckBeforeAdd(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- Auto add
   IF txpks_maintain.fn_ProcessAdd(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- After Add
   IF txpks_#sa_fundperson.fn_ProcessAfterAdd(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
--ghi log
   IF txpks_maintain.fn_MaintainLog(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   plog.setendsection (pkgctx, 'fn_Add');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Add');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Add;

FUNCTION fn_Edit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Edit');
-- Check befor edit
   IF txpks_#sa_fundperson.fn_CheckBeforeEdit(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- Auto Edit
   IF txpks_maintain.fn_ProcessEdit(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- After Edit
   IF txpks_#sa_fundperson.fn_ProcessAfterEdit(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   --ghi log
   IF txpks_maintain.fn_MaintainLog(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   plog.setendsection (pkgctx, 'fn_Edit');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Edit');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Edit;

FUNCTION fn_Delete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Delete');
-- Check befor Delete
   IF txpks_#sa_fundperson.fn_CheckBeforeDelete(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- Auto Delete
   IF txpks_maintain.fn_ProcessDelete(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- After Delete
   IF txpks_#sa_fundperson.fn_ProcessAfterDelete(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   --ghi log
   IF txpks_maintain.fn_MaintainLog(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   plog.setendsection (pkgctx, 'fn_Delete');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Delete');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Delete;

FUNCTION fn_Adhoc(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Adhoc');

   plog.setendsection (pkgctx, 'fn_Adhoc');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Adhoc');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Adhoc;

FUNCTION fn_Approve(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Approve');
   IF txpks_maintain.fn_Approve(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   plog.setendsection (pkgctx, 'fn_Approve');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Approve');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Approve;

FUNCTION fn_Reject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Reject');

       IF txpks_maintain.fn_Reject(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;

   plog.setendsection (pkgctx, 'fn_Reject');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Reject');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Reject;


FUNCTION fn_CheckBeforeAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
   plog.setbeginsection (pkgctx, 'fn_CheckBeforeAdd');
         -- khong cho them moi o trang thai cho duyet dong
 /*select  count(1) into l_count from fund d where d.symbol = p_objmsg.OBJFIELDS('SYMBOL').value AND d.status = 'R';
  IF l_count > 0  then
    p_err_code := '-111175';
        plog.setendsection (pkgctx, 'fn_CheckBeforeAdd');
        RETURN errnums.C_BIZ_RULE_INVALID;
 end if;*/
    plog.setendsection (pkgctx, 'fn_CheckBeforeAdd');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_CheckBeforeAdd');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_CheckBeforeAdd;

FUNCTION fn_ProcessAfterAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_ProcessAfterAdd');

    plog.setendsection (pkgctx, 'fn_ProcessAfterAdd');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessAfterAdd');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessAfterAdd;

FUNCTION fn_CheckBeforeEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_CheckBeforeEdit');

    plog.setendsection (pkgctx, 'fn_CheckBeforeEdit');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_CheckBeforeEdit');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_CheckBeforeEdit;

FUNCTION fn_ProcessAfterEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_ProcessAfterEdit');

    plog.setendsection (pkgctx, 'fn_ProcessAfterEdit');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessAfterEdit');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessAfterEdit;

FUNCTION fn_CheckBeforeDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_CheckBeforeDelete');

    plog.setendsection (pkgctx, 'fn_CheckBeforeDelete');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_CheckBeforeDelete');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_CheckBeforeDelete;

FUNCTION fn_ProcessAfterDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_ProcessAfterDelete');

    plog.setendsection (pkgctx, 'fn_ProcessAfterDelete');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessAfterDelete');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessAfterDelete;

FUNCTION fn_CheckBeforeApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_CheckBeforeApprove');

    plog.setendsection (pkgctx, 'fn_CheckBeforeApprove');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_CheckBeforeApprove');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_CheckBeforeApprove;

FUNCTION fn_ProcessAfterApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_ProcessAfterApprove');

    plog.setendsection (pkgctx, 'fn_ProcessAfterApprove');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessAfterApprove');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessAfterApprove;

FUNCTION fn_CheckBeforeReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_CheckBeforeReject');

    plog.setendsection (pkgctx, 'fn_CheckBeforeReject');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_CheckBeforeReject');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_CheckBeforeReject;

FUNCTION fn_ProcessAfterReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_ProcessAfterReject');

    plog.setendsection (pkgctx, 'fn_ProcessAfterReject');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessAfterReject');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessAfterReject;

BEGIN
      FOR i IN (SELECT *
                FROM tlogdebug)
      LOOP
         logrow.loglevel    := i.loglevel;
         logrow.log4table   := i.log4table;
         logrow.log4alert   := i.log4alert;
         logrow.log4trace   := i.log4trace;
      END LOOP;
      pkgctx    :=
         plog.init ('txpks_#sa.fund_member',
                    plevel => NVL(logrow.loglevel,30),
                    plogtable => (NVL(logrow.log4table,'N') = 'Y'),
                    palert => (NVL(logrow.log4alert,'N') = 'Y'),
                    ptrace => (NVL(logrow.log4trace,'N') = 'Y')
            );
END txpks_#sa_fundperson;
/

DROP PACKAGE txpks_#sa_iodrules
/

CREATE OR REPLACE 
PACKAGE txpks_#sa_iodrules 
/** ----------------------------------------------------------------------------------------------------
 dung cho form maintenance
 ----------------------------------------------------------------------------------------------------*/
IS

FUNCTION fn_Transfer(p_xmlmsg in out varchar2,p_err_code in out varchar2,p_err_param out varchar2)
RETURN NUMBER;
FUNCTION fn_Add(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Edit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Delete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Adhoc(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Approve(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Reject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;

--rieng
FUNCTION fn_CheckBeforeAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;

END;
/

CREATE OR REPLACE 
PACKAGE BODY txpks_#sa_iodrules 
IS
   pkgctx   plog.log_ctx;
   logrow   tlogdebug%ROWTYPE;

FUNCTION fn_Transfer(p_xmlmsg in out varchar2,p_err_code in out varchar2,p_err_param out varchar2)
RETURN NUMBER
IS
   l_return_code VARCHAR2(30) := systemnums.C_SUCCESS;
   l_objmsg tx.obj_rectype;
   l_count NUMBER(3);
   l_msgtype VARCHAR2(10);
   l_objname VARCHAR2(100);
   l_actionflag varchar2(100);
   l_currdate varchar2(10);
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Transfer');
   plog.debug(pkgctx, 'fn_Transfer');
   --get object
   l_objmsg:= txpks_msg.fn_mt_xml2obj(p_xmlmsg);
   l_msgtype:= l_objmsg.MSGTYPE;
   l_objname:= l_objmsg.OBJNAME;
   l_actionflag:= l_objmsg.ACTIONFLAG;
   --Kiem tra msgtype de phan luong xu ly
   IF l_actionflag ='ADD' THEN
        IF fn_Add(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;
   ELSIF l_actionflag ='EDIT' THEN
        IF fn_Edit(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;

   ELSIF l_actionflag ='DELETE' THEN
        IF fn_Delete(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;
   ELSIF l_actionflag ='ADHOC' THEN
        IF fn_Adhoc(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;
   ELSIF l_actionflag ='APPROVE' THEN
        IF fn_Approve(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;
   ELSIF l_actionflag ='REJECT' THEN
        IF fn_Reject(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;
   END IF;

   plog.debug(pkgctx, 'fn_Transfer');
   plog.setendsection (pkgctx, 'fn_Transfer');
   RETURN l_return_code;
EXCEPTION
WHEN errnums.E_BIZ_RULE_INVALID
   THEN
      FOR I IN (
           SELECT ERRDESC,EN_ERRDESC FROM deferror
           WHERE ERRNUM= p_err_code
      ) LOOP
           p_err_param := i.errdesc;
      END LOOP;
      p_xmlmsg := txpks_msg.fn_mt_obj2xml(l_objmsg);
      plog.setendsection (pkgctx, 'fn_Transfer');
      ROLLBACK;
      RETURN errnums.C_BIZ_RULE_INVALID;
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      p_err_param := 'SYSTEM_ERROR';
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      p_xmlmsg := txpks_msg.fn_mt_obj2xml(l_objmsg);
      plog.setendsection (pkgctx, 'fn_Transfer');
      RETURN errnums.C_SYSTEM_ERROR;
END fn_Transfer;

FUNCTION fn_Add(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Add');
/*-- Check befor add
   IF txpks_#sa_iodrules.fn_CheckBeforeAdd(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- Auto add
   IF txpks_maintain.fn_ProcessAdd(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- After Add
   IF txpks_#sa_iodrules.fn_ProcessAfterAdd(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;*/
   --plog.ERROR (pkgctx, 'VAO DAY CHUA');
   UPDATE funddtl dtl
   SET dtl.ordermatchns = p_objmsg.OBJFIELDS('ORDERMATCHNS').value
   WHERE dtl.codeid = p_objmsg.OBJFIELDS('CODEID').value;
    plog.ERROR (pkgctx,'CODEID: '||  p_objmsg.OBJFIELDS('CODEID').value || 'OD:' ||p_objmsg.OBJFIELDS('ORDERMATCHNS').value);
--ghi log
   IF txpks_maintain.fn_MaintainLog(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   plog.setendsection (pkgctx, 'fn_Add');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Add');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Add;

FUNCTION fn_Edit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Edit');
/*-- Check befor edit
   IF txpks_#sa_iodrules.fn_CheckBeforeEdit(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- Auto Edit
   IF txpks_maintain.fn_ProcessEdit(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- After Edit
   IF txpks_#sa_iodrules.fn_ProcessAfterEdit(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;*/

   UPDATE funddtl dtl
   SET dtl.ordermatchns = p_objmsg.OBJFIELDS('ORDERMATCHNS').value
   WHERE dtl.codeid = p_objmsg.OBJFIELDS('CODEID').value;
   --ghi log
   IF txpks_maintain.fn_MaintainLog(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   plog.setendsection (pkgctx, 'fn_Edit');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Edit');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Edit;

FUNCTION fn_Delete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Delete');
/*-- Check befor Delete
   IF txpks_#sa_iodrules.fn_CheckBeforeDelete(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- Auto Delete
   IF txpks_maintain.fn_ProcessDelete(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- After Delete
   IF txpks_#sa_iodrules.fn_ProcessAfterDelete(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;*/

    --plog.ERROR (pkgctx,'CODEID: '||  p_objmsg.OBJFIELDS('CODEID').value || 'OD:' ||p_objmsg.OBJFIELDS('ORDERMATCHNS').value);
   --ghi log
   IF txpks_maintain.fn_MaintainLog(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   plog.setendsection (pkgctx, 'fn_Delete');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Delete');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Delete;

FUNCTION fn_Adhoc(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Adhoc');

   plog.setendsection (pkgctx, 'fn_Adhoc');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Adhoc');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Adhoc;

FUNCTION fn_Approve(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Approve');
     IF txpks_maintain.fn_Approve(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   plog.setendsection (pkgctx, 'fn_Approve');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Approve');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Approve;

FUNCTION fn_Reject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Reject');

       IF txpks_maintain.fn_Reject(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;

   plog.setendsection (pkgctx, 'fn_Reject');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Reject');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Reject;


FUNCTION fn_CheckBeforeAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
   plog.setbeginsection (pkgctx, 'fn_CheckBeforeAdd');

    plog.setendsection (pkgctx, 'fn_CheckBeforeAdd');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_CheckBeforeAdd');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_CheckBeforeAdd;

FUNCTION fn_ProcessAfterAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_ProcessAfterAdd');

    plog.setendsection (pkgctx, 'fn_ProcessAfterAdd');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessAfterAdd');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessAfterAdd;

FUNCTION fn_CheckBeforeEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_CheckBeforeEdit');

    plog.setendsection (pkgctx, 'fn_CheckBeforeEdit');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_CheckBeforeEdit');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_CheckBeforeEdit;

FUNCTION fn_ProcessAfterEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_ProcessAfterEdit');

    plog.setendsection (pkgctx, 'fn_ProcessAfterEdit');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessAfterEdit');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessAfterEdit;

FUNCTION fn_CheckBeforeDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_CheckBeforeDelete');

    plog.setendsection (pkgctx, 'fn_CheckBeforeDelete');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_CheckBeforeDelete');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_CheckBeforeDelete;

FUNCTION fn_ProcessAfterDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_ProcessAfterDelete');
   UPDATE funddtl dtl
   SET dtl.ordermatchns =''
   WHERE dtl.codeid = p_objmsg.OBJFIELDS('CODEID').value;
    plog.setendsection (pkgctx, 'fn_ProcessAfterDelete');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessAfterDelete');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessAfterDelete;

FUNCTION fn_CheckBeforeApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_CheckBeforeApprove');

    plog.setendsection (pkgctx, 'fn_CheckBeforeApprove');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_CheckBeforeApprove');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_CheckBeforeApprove;

FUNCTION fn_ProcessAfterApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_ProcessAfterApprove');

    plog.setendsection (pkgctx, 'fn_ProcessAfterApprove');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessAfterApprove');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessAfterApprove;

FUNCTION fn_CheckBeforeReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_CheckBeforeReject');

    plog.setendsection (pkgctx, 'fn_CheckBeforeReject');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_CheckBeforeReject');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_CheckBeforeReject;

FUNCTION fn_ProcessAfterReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_ProcessAfterReject');

    plog.setendsection (pkgctx, 'fn_ProcessAfterReject');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessAfterReject');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessAfterReject;

BEGIN
      FOR i IN (SELECT *
                FROM tlogdebug)
      LOOP
         logrow.loglevel    := i.loglevel;
         logrow.log4table   := i.log4table;
         logrow.log4alert   := i.log4alert;
         logrow.log4trace   := i.log4trace;
      END LOOP;
      pkgctx    :=
         plog.init ('txpks_#sa.iodrules',
                    plevel => NVL(logrow.loglevel,30),
                    plogtable => (NVL(logrow.log4table,'N') = 'Y'),
                    palert => (NVL(logrow.log4alert,'N') = 'Y'),
                    ptrace => (NVL(logrow.log4trace,'N') = 'Y')
            );
END txpks_#sa_iodrules;
/

DROP PACKAGE txpks_#sa_members
/

CREATE OR REPLACE 
PACKAGE txpks_#sa_members 
/** ----------------------------------------------------------------------------------------------------
 dung cho form maintenance
 ----------------------------------------------------------------------------------------------------*/
IS

FUNCTION fn_Transfer(p_xmlmsg in out varchar2,p_err_code in out varchar2,p_err_param out varchar2)
RETURN NUMBER;
FUNCTION fn_Add(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Edit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Delete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Adhoc(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Approve(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Reject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;

--rieng
FUNCTION fn_CheckBeforeAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;

END;
/

DROP PACKAGE txpks_#sa_roles
/

CREATE OR REPLACE 
PACKAGE txpks_#sa_roles 
/** ----------------------------------------------------------------------------------------------------
 dung cho form maintenance
 ----------------------------------------------------------------------------------------------------*/
IS

FUNCTION fn_Transfer(p_xmlmsg in out varchar2,p_err_code in out varchar2,p_err_param out varchar2)
RETURN NUMBER;
FUNCTION fn_Add(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Edit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Delete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Adhoc(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Approve(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Reject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;

--rieng
FUNCTION fn_CheckBeforeAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;

END;
/

DROP PACKAGE txpks_#sa_rptauto
/

CREATE OR REPLACE 
PACKAGE txpks_#sa_rptauto 
/** ----------------------------------------------------------------------------------------------------
 dung cho form maintenance
 ----------------------------------------------------------------------------------------------------*/
IS

FUNCTION fn_Transfer(p_xmlmsg in out varchar2,p_err_code in out varchar2,p_err_param out varchar2)
RETURN NUMBER;
FUNCTION fn_Add(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Edit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Delete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Adhoc(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Approve(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Reject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;

--rieng
FUNCTION fn_CheckBeforeAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;

END;
/

CREATE OR REPLACE 
PACKAGE BODY txpks_#sa_rptauto 
IS
   pkgctx   plog.log_ctx;
   logrow   tlogdebug%ROWTYPE;

FUNCTION fn_Transfer(p_xmlmsg in out varchar2,p_err_code in out varchar2,p_err_param out varchar2)
RETURN NUMBER
IS
   l_return_code VARCHAR2(30) := systemnums.C_SUCCESS;
   l_objmsg tx.obj_rectype;
   l_count NUMBER(3);
   l_msgtype VARCHAR2(10);
   l_objname VARCHAR2(100);
   l_actionflag varchar2(100);
   l_currdate varchar2(10);
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Transfer');
   plog.debug(pkgctx, 'fn_Transfer');
   --get object
   plog.error(pkgctx,'p_xmlmsg: ' || p_xmlmsg);
   l_objmsg:= txpks_msg.fn_mt_xml2obj(p_xmlmsg);
   l_msgtype:= l_objmsg.MSGTYPE;
   l_objname:= l_objmsg.OBJNAME;
   l_actionflag:= l_objmsg.ACTIONFLAG;
   --Kiem tra msgtype de phan luong xu ly
   IF l_actionflag ='ADD' THEN
        IF fn_Add(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;
   ELSIF l_actionflag ='EDIT' THEN
        IF fn_Edit(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;

   ELSIF l_actionflag ='DELETE' THEN
        IF fn_Delete(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;
   ELSIF l_actionflag ='ADHOC' THEN
        IF fn_Adhoc(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;
   ELSIF l_actionflag ='APPROVE' THEN
        IF fn_Approve(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;
   ELSIF l_actionflag ='REJECT' THEN
        IF fn_Reject(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;
   END IF;

   plog.debug(pkgctx, 'fn_Transfer');
   plog.setendsection (pkgctx, 'fn_Transfer');
   RETURN l_return_code;
EXCEPTION
WHEN errnums.E_BIZ_RULE_INVALID
   THEN
      FOR I IN (
           SELECT ERRDESC,EN_ERRDESC FROM deferror
           WHERE ERRNUM= p_err_code
      ) LOOP
           p_err_param := i.errdesc;
      END LOOP;
      p_xmlmsg := txpks_msg.fn_mt_obj2xml(l_objmsg);
      plog.setendsection (pkgctx, 'fn_Transfer');
      ROLLBACK;
      RETURN errnums.C_BIZ_RULE_INVALID;
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      p_err_param := 'SYSTEM_ERROR';
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      p_xmlmsg := txpks_msg.fn_mt_obj2xml(l_objmsg);
      plog.setendsection (pkgctx, 'fn_Transfer');
      RETURN errnums.C_SYSTEM_ERROR;
END fn_Transfer;

FUNCTION fn_Add(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Add');
-- Check befor add
   IF txpks_#sa_rptauto.fn_CheckBeforeAdd(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- Auto add
   IF txpks_maintain.fn_ProcessAdd(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- After Add
   IF txpks_#sa_rptauto.fn_ProcessAfterAdd(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
--ghi log
   IF txpks_maintain.fn_MaintainLog(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   plog.setendsection (pkgctx, 'fn_Add');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Add');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Add;

FUNCTION fn_Edit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Edit');
-- Check befor edit
   IF txpks_#sa_rptauto.fn_CheckBeforeEdit(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- Auto Edit
   IF txpks_maintain.fn_ProcessEdit(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- After Edit
   IF txpks_#sa_rptauto.fn_ProcessAfterEdit(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   --ghi log
   IF txpks_maintain.fn_MaintainLog(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   plog.setendsection (pkgctx, 'fn_Edit');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Edit');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Edit;

FUNCTION fn_Delete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Delete');
-- Check befor Delete
   IF txpks_#sa_rptauto.fn_CheckBeforeDelete(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- Auto Delete
   IF txpks_maintain.fn_ProcessDelete(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- After Delete
   IF txpks_#sa_rptauto.fn_ProcessAfterDelete(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   --ghi log
   IF txpks_maintain.fn_MaintainLog(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   plog.setendsection (pkgctx, 'fn_Delete');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Delete');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Delete;

FUNCTION fn_Adhoc(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Adhoc');

   plog.setendsection (pkgctx, 'fn_Adhoc');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Adhoc');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Adhoc;

FUNCTION fn_Approve(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Approve');

   IF txpks_maintain.fn_Approve(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;

   IF txpks_#sa_rptauto.fn_ProcessAfterApprove(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;

   plog.setendsection (pkgctx, 'fn_Approve');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Approve');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Approve;

FUNCTION fn_Reject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.error (pkgctx, 'fn_Reject test');

   IF txpks_maintain.fn_Reject(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;

   plog.setendsection (pkgctx, 'fn_Reject');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Reject');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Reject;


FUNCTION fn_CheckBeforeAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
   plog.setbeginsection (pkgctx, 'fn_CheckBeforeAdd');
   /*SELECT COUNT(*) INTO l_count FROM FUND WHERE UPPER(SYMBOL) = UPPER(p_objmsg.OBJFIELDS('SYMBOL').VALUE);
     if l_count > 0 then
        p_err_code := '-111177';
        plog.setendsection (pkgctx, 'fn_CheckBeforeAdd');
        RETURN errnums.C_BIZ_RULE_INVALID;
     end if;*/
    plog.setendsection (pkgctx, 'fn_CheckBeforeAdd');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_CheckBeforeAdd');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_CheckBeforeAdd;

FUNCTION fn_ProcessAfterAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_ProcessAfterAdd');

    plog.setendsection (pkgctx, 'fn_ProcessAfterAdd');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessAfterAdd');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessAfterAdd;

FUNCTION fn_CheckBeforeEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
    l_fldname varchar2(100);
    l_fldval varchar2(4000);
    l_fldtype varchar2(100);
    l_fldoldval varchar2(4000);
BEGIN
    plog.setbeginsection (pkgctx, 'fn_CheckBeforeEdit');
/*
   l_fldname := p_objmsg.OBJFIELDS.FIRST;
   WHILE (l_fldname IS NOT NULL)
   LOOP
       l_fldval := p_objmsg.OBJFIELDS(l_fldname).value;
       l_fldtype := p_objmsg.OBJFIELDS(l_fldname).fldtype;
       l_fldoldval := p_objmsg.OBJFIELDS(l_fldname).oldval;
       IF l_fldname = 'SYMBOL' THEN
       IF  (nvl(l_fldoldval,'#$*') <> nvl(l_fldval,'#$*')) THEN
          SELECT COUNT(*) INTO l_count FROM FUND WHERE UPPER(SYMBOL) = UPPER(nvl(l_fldval,'#$*'));
          if l_count > 0 then
             p_err_code := '-111177';
             plog.setendsection (pkgctx, 'fn_CheckBeforeAdd');
             RETURN errnums.C_BIZ_RULE_INVALID;
           end if;
       END IF;
       END IF;
       l_fldname := p_objmsg.OBJFIELDS.NEXT (l_fldname);
   END LOOP;*/
    plog.setendsection (pkgctx, 'fn_CheckBeforeEdit');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_CheckBeforeEdit');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_CheckBeforeEdit;

FUNCTION fn_ProcessAfterEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_ProcessAfterEdit');

    plog.setendsection (pkgctx, 'fn_ProcessAfterEdit');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessAfterEdit');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessAfterEdit;

FUNCTION fn_CheckBeforeDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
    l_count_taipo NUMBER;
    l_count_funddtl NUMBER;
    l_count_feetype NUMBER;
    l_count_fmembers NUMBER;
    l_count_fund_member NUMBER;
    v_strParentClause varchar2(100);
    v_strRecord_Key varchar2(100);
    v_strRecord_Value varchar2(100);
    v_codeid varchar2(100);
BEGIN
    plog.setbeginsection (pkgctx, 'fn_CheckBeforeDelete');
   /*v_strParentClause := p_objmsg.CLAUSE;
       IF  length(v_strParentClause) <> 0 THEN
        v_strRecord_Key := Trim(substr(v_strParentClause,1, InStr(v_strParentClause, '=')-1));
        v_strRecord_Value := Trim(substr(v_strParentClause,InStr(v_strParentClause, '=') +1));
        v_strRecord_Value := REPLACE(v_strRecord_Value,'''','');
       end if;

   select count(*) INTO l_count from FUND F WHERE F.CODEID = v_strRecord_Value AND F.STATUS IN ('A','J');
   if l_count > 0 then
        p_err_code := '-111183';
        plog.setendsection (pkgctx, 'fn_CheckBeforeAdd');
        RETURN errnums.C_BIZ_RULE_INVALID;
     end if;
 select count(*) into l_count_taipo from TAIPO TA WHERE TA.STATUS <> 'D' and TA.CODEID = v_strRecord_Value ;
 select count(*) into l_count_funddtl from FUNDDTL DTL WHERE DTL.STATUS <> 'D' and DTL.CODEID = v_strRecord_Value ;
 select count(*) into l_count_fmembers from FMEMBERS FM WHERE FM.STATUS <> 'D' and FM.CODEID = v_strRecord_Value ;
 select count(*) into l_count_feetype from feetype ft WHERE ft.STATUS <> 'D' and ft.CODEID = v_strRecord_Value ;

 select count(*) into l_count_fund_member from FUND_MEMBER FME WHERE FME.STATUS <> 'D' and FME.CODEID = v_strRecord_Value ;
    IF l_count_taipo > 0 OR l_count_funddtl >0 OR l_count_fmembers >0 OR l_count_fund_member >0  or l_count_feetype > 0 THEN
       p_err_code := '-100100';
       plog.setendsection (pkgctx, 'fn_txPreAppCheck');
       RETURN errnums.C_BIZ_RULE_INVALID;
    END IF;*/
    plog.setendsection (pkgctx, 'fn_CheckBeforeDelete');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_CheckBeforeDelete');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_CheckBeforeDelete;

FUNCTION fn_ProcessAfterDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
    v_strRecord_Key varchar2(100);
    v_strParentClause varchar2(100);
    v_strRecord_Value varchar2(100);
BEGIN
    plog.setbeginsection (pkgctx, 'fn_ProcessAfterDelete');

    plog.setendsection (pkgctx, 'fn_ProcessAfterDelete');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessAfterDelete');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessAfterDelete;

FUNCTION fn_CheckBeforeApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_CheckBeforeApprove');

    plog.setendsection (pkgctx, 'fn_CheckBeforeApprove');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_CheckBeforeApprove');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_CheckBeforeApprove;

FUNCTION fn_ProcessAfterApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
    l_refobjid  varchar2(12);
    l_actionflag varchar2(400);
    l_childvalue varchar2(400);
    l_childkey varchar2(400);
    l_chiltable varchar2(400);
    l_strcurryear varchar2(20);
BEGIN
    plog.setbeginsection (pkgctx, 'fn_ProcessAfterApprove');
    /*--Sinh bang lich
    l_refobjid  :=  p_objmsg.CLAUSE;
    SELECT substr(varvalue,7) INTO l_strcurryear FROM sysvar WHERE varname ='CURRDATE';

    SELECT actionflag,childvalue,childkey,chiltable
    INTO l_actionflag,l_childvalue,l_childkey,l_chiltable FROM objlog WHERE AUTOID = l_refobjid;
    plog.error(pkgctx,'FUND_CLDR: l_actionflag:' ||l_actionflag||'l_childvalue:'||l_childvalue||'l_refobjid:'||l_refobjid);

    IF l_actionflag ='ADD' THEN
        SELECT COUNT(*) INTO l_count FROM sbcldr WHERE cldrtype = l_childvalue;
        IF l_count =0 THEN
            INSERT INTO SBCLDR (Autoid,SBDATE,SBBUSDAY,SBBOW,SBBOM,SBBOQ,SBBOY,SBEOW,SBEOM,SBEOQ,SBEOY,HOLIDAY,CLDRTYPE)
            SELECT seq_SBCLDR.NEXTVAL, SBDATE,SBBUSDAY,SBBOW,SBBOM,SBBOQ,SBBOY,SBEOW,SBEOM,SBEOQ,SBEOY,HOLIDAY,l_childvalue CLDRTYPE
            FROM sbcldr WHERE CLDRTYPE = '000' AND SBDATE >= to_date(concat('01-Jan-',l_strcurryear),'dd/mm/yyyy');
        END IF;
    END IF;
*/
    plog.setendsection (pkgctx, 'fn_ProcessAfterApprove');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessAfterApprove');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessAfterApprove;

FUNCTION fn_CheckBeforeReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_CheckBeforeReject');

    plog.setendsection (pkgctx, 'fn_CheckBeforeReject');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_CheckBeforeReject');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_CheckBeforeReject;

FUNCTION fn_ProcessAfterReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_ProcessAfterReject');

    plog.setendsection (pkgctx, 'fn_ProcessAfterReject');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessAfterReject');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessAfterReject;

BEGIN
      FOR i IN (SELECT *
                FROM tlogdebug)
      LOOP
         logrow.loglevel    := i.loglevel;
         logrow.log4table   := i.log4table;
         logrow.log4alert   := i.log4alert;
         logrow.log4trace   := i.log4trace;
      END LOOP;
      pkgctx    :=
         plog.init ('txpks_#sa.funddtl',
                    plevel => NVL(logrow.loglevel,30),
                    plogtable => (NVL(logrow.log4table,'N') = 'Y'),
                    palert => (NVL(logrow.log4alert,'N') = 'Y'),
                    ptrace => (NVL(logrow.log4trace,'N') = 'Y')
            );
END txpks_#sa_rptauto;
/

DROP PACKAGE txpks_#sa_taipo
/

CREATE OR REPLACE 
PACKAGE txpks_#sa_taipo 
/** ----------------------------------------------------------------------------------------------------
 dung cho form maintenance
 ----------------------------------------------------------------------------------------------------*/
IS

FUNCTION fn_Transfer(p_xmlmsg in out varchar2,p_err_code in out varchar2,p_err_param out varchar2)
RETURN NUMBER;
FUNCTION fn_Add(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Edit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Delete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Adhoc(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Approve(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Reject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;

--rieng
FUNCTION fn_CheckBeforeAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;

END;
/

CREATE OR REPLACE 
PACKAGE BODY txpks_#sa_taipo 
IS
   pkgctx   plog.log_ctx;
   logrow   tlogdebug%ROWTYPE;

FUNCTION fn_Transfer(p_xmlmsg in out varchar2,p_err_code in out varchar2,p_err_param out varchar2)
RETURN NUMBER
IS
   l_return_code VARCHAR2(30) := systemnums.C_SUCCESS;
   l_objmsg tx.obj_rectype;
   l_count NUMBER(3);
   l_msgtype VARCHAR2(10);
   l_objname VARCHAR2(100);
   l_actionflag varchar2(100);
   l_currdate varchar2(10);
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Transfer');
   plog.debug(pkgctx, 'fn_Transfer');
   --get object
   l_objmsg:= txpks_msg.fn_mt_xml2obj(p_xmlmsg);
   l_msgtype:= l_objmsg.MSGTYPE;
   l_objname:= l_objmsg.OBJNAME;
   l_actionflag:= l_objmsg.ACTIONFLAG;
   --Kiem tra msgtype de phan luong xu ly
   IF l_actionflag ='ADD' THEN
        IF fn_Add(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;
   ELSIF l_actionflag ='EDIT' THEN
        IF fn_Edit(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;

   ELSIF l_actionflag ='DELETE' THEN
        IF fn_Delete(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;
   ELSIF l_actionflag ='ADHOC' THEN
        IF fn_Adhoc(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;
   ELSIF l_actionflag ='APPROVE' THEN
        IF fn_Approve(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;
   ELSIF l_actionflag ='REJECT' THEN
        IF fn_Reject(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;
   END IF;

   plog.debug(pkgctx, 'fn_Transfer');
   plog.setendsection (pkgctx, 'fn_Transfer');
   RETURN l_return_code;
EXCEPTION
WHEN errnums.E_BIZ_RULE_INVALID
   THEN
      FOR I IN (
           SELECT ERRDESC,EN_ERRDESC FROM deferror
           WHERE ERRNUM= p_err_code
      ) LOOP
           p_err_param := i.errdesc;
      END LOOP;
      p_xmlmsg := txpks_msg.fn_mt_obj2xml(l_objmsg);
      plog.setendsection (pkgctx, 'fn_Transfer');
      ROLLBACK;
      RETURN errnums.C_BIZ_RULE_INVALID;
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      p_err_param := 'SYSTEM_ERROR';
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      p_xmlmsg := txpks_msg.fn_mt_obj2xml(l_objmsg);
      plog.setendsection (pkgctx, 'fn_Transfer');
      RETURN errnums.C_SYSTEM_ERROR;
END fn_Transfer;

FUNCTION fn_Add(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Add');
-- Check befor add
   IF txpks_#sa_taipo.fn_CheckBeforeAdd(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- Auto add
   IF txpks_maintain.fn_ProcessAdd(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- After Add
   IF txpks_#sa_taipo.fn_ProcessAfterAdd(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
--ghi log
   IF txpks_maintain.fn_MaintainLog(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   plog.setendsection (pkgctx, 'fn_Add');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Add');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Add;

FUNCTION fn_Edit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Edit');
-- Check befor edit
   IF txpks_#sa_taipo.fn_CheckBeforeEdit(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- Auto Edit
   IF txpks_maintain.fn_ProcessEdit(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- After Edit
   IF txpks_#sa_taipo.fn_ProcessAfterEdit(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   --ghi log
   IF txpks_maintain.fn_MaintainLog(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   plog.setendsection (pkgctx, 'fn_Edit');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Edit');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Edit;

FUNCTION fn_Delete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Delete');
-- Check befor Delete
   IF txpks_#sa_taipo.fn_CheckBeforeDelete(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- Auto Delete
   IF txpks_maintain.fn_ProcessDelete(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- After Delete
   IF txpks_#sa_taipo.fn_ProcessAfterDelete(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   --ghi log
   IF txpks_maintain.fn_MaintainLog(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   plog.setendsection (pkgctx, 'fn_Delete');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Delete');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Delete;

FUNCTION fn_Adhoc(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Adhoc');

   plog.setendsection (pkgctx, 'fn_Adhoc');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Adhoc');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Adhoc;

FUNCTION fn_Approve(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Approve');

   -- Check befor Approve
   IF txpks_#sa_taipo.fn_checkbeforereject(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
     RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   --Auto Approve
   IF txpks_maintain.fn_Approve(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   --
   IF txpks_#sa_taipo.fn_ProcessAfterApprove(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;


   plog.setendsection (pkgctx, 'fn_Approve');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Approve');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Approve;

FUNCTION fn_Reject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Reject');

       IF txpks_maintain.fn_Reject(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;

   plog.setendsection (pkgctx, 'fn_Reject');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Reject');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Reject;


FUNCTION fn_CheckBeforeAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
   plog.setbeginsection (pkgctx, 'fn_CheckBeforeAdd');
-- check thong tin IPO chi cho them moi 1 lan
select COUNT(*) INTO l_count from taipo ta where ta.codeid = p_objmsg.OBJFIELDS('CODEID').value AND TA.IPOSTATUS NOT IN ('C','E');
 IF l_count > 0 then
    p_err_code := '-111179';
    plog.setendsection (pkgctx, 'fn_CheckBeforeAdd');
    RETURN errnums.C_BIZ_RULE_INVALID;
 end if;

 IF to_date(p_objmsg.OBJFIELDS('TODATE').value,'DD/MM/RRRR') < TO_DATE(p_objmsg.OBJFIELDS('FRDATE').value,'DD/MM/RRRR') then
    p_err_code := '-111173';
        plog.setendsection (pkgctx, 'fn_CheckBeforeAdd');
        RETURN errnums.C_BIZ_RULE_INVALID;
 end if;
  /*IF TO_DATE(p_objmsg.OBJFIELDS('EXECDATE').value,'DD/MM/RRRR') < TO_DATE(p_objmsg.OBJFIELDS('TODATE').value,'DD/MM/RRRR') then
    p_err_code := '-111174';
        plog.setendsection (pkgctx, 'fn_CheckBeforeAdd');
        RETURN errnums.C_BIZ_RULE_INVALID;
 end if;*/
 -- khong cho them moi o trang thai cho duyet dong
 select  count(1) into l_count from fund d where d.symbol = p_objmsg.OBJFIELDS('SYMBOL').value AND d.status = 'R';
  IF l_count > 0  then
    p_err_code := '-111175';
        plog.setendsection (pkgctx, 'fn_CheckBeforeAdd');
        RETURN errnums.C_BIZ_RULE_INVALID;
 end if;
    plog.setendsection (pkgctx, 'fn_CheckBeforeAdd');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_CheckBeforeAdd');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_CheckBeforeAdd;

FUNCTION fn_ProcessAfterAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
    p_errcode varchar2(10);
    p_errmsg varchar2(100);
BEGIN
    plog.setbeginsection (pkgctx, 'fn_ProcessAfterAdd');

    plog.setendsection (pkgctx, 'fn_ProcessAfterAdd');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessAfterAdd');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessAfterAdd;

FUNCTION fn_CheckBeforeEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_CheckBeforeEdit');
    --kiem tra neu phien IPO da co lenh vao thi khong cho phep sua
    select count(*) INTO l_count from (select * from srmast union all select * from srmasthist) sr
    where sr.srtype = 'IP' AND SR.CODEID = p_objmsg.OBJFIELDS('CODEID').value and status not in ('9') and EXECTYPE NOT IN ('CS','CR');
    plog.error (pkgctx, 'l_count: '||l_count || 'CODEID: '||p_objmsg.OBJFIELDS('CODEID').value );

    if l_count > 0 then
        p_err_code := '-111129';
        plog.setendsection (pkgctx, 'fn_CheckBeforeAdd');
        RETURN errnums.C_BIZ_RULE_INVALID;
    end if;
/*
    IF to_date(p_objmsg.OBJFIELDS('TODATE').value,'DD/MM/RRRR') < TO_DATE(p_objmsg.OBJFIELDS('FRDATE').value,'DD/MM/RRRR') then
        p_err_code := '-111173';
        plog.setendsection (pkgctx, 'fn_CheckBeforeAdd');
        RETURN errnums.C_BIZ_RULE_INVALID;
    end if;
    IF TO_DATE(p_objmsg.OBJFIELDS('EXECDATE').value,'DD/MM/RRRR') < TO_DATE(p_objmsg.OBJFIELDS('TODATE').value,'DD/MM/RRRR') then
        p_err_code := '-111174';
        plog.setendsection (pkgctx, 'fn_CheckBeforeAdd');
        RETURN errnums.C_BIZ_RULE_INVALID;
    end if;*/
    plog.setendsection (pkgctx, 'fn_CheckBeforeEdit');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_CheckBeforeEdit');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_CheckBeforeEdit;

FUNCTION fn_ProcessAfterEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
     p_errcode varchar2(10);
    p_errmsg varchar2(100);
BEGIN
    plog.setbeginsection (pkgctx, 'fn_ProcessAfterEdit');
--txpks_auto.pr_genIPOSession(p_objmsg.OBJFIELDS('CODEID').value ,p_errcode ,p_errmsg );
    plog.setendsection (pkgctx, 'fn_ProcessAfterEdit');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessAfterEdit');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessAfterEdit;

FUNCTION fn_CheckBeforeDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
    v_strParentClause varchar2(100);
    v_strRecord_Key varchar2(100);
    v_strRecord_Value varchar2(100);
    v_codeid varchar2(100);
BEGIN
    plog.setbeginsection (pkgctx, 'fn_CheckBeforeDelete');
     plog.ERROR (pkgctx, 'CODEID:' ||p_objmsg.CLAUSE);
     v_strParentClause := p_objmsg.CLAUSE;
       IF  length(v_strParentClause) <> 0 THEN
        v_strRecord_Key := Trim(substr(v_strParentClause,1, InStr(v_strParentClause, '=')-1));
        v_strRecord_Value := Trim(substr(v_strParentClause,InStr(v_strParentClause, '=') +1));
        v_strRecord_Value := REPLACE(v_strRecord_Value,'''','');
       end if;
       select codeid into v_codeid from taipo where ipoid = v_strRecord_Value;
    -- khong cho phep xoa IPO khi da thuc hien khop lenh va phan bo
    /*SELECT COUNT(*) INTO l_count from (select * from tradingsession union all select * from tradingsessionhist) T
    where T.TRADINGTYPE = 'IPO' AND T.TRADINGSTATUS IN ('M','E') AND T.CODEID = v_codeid;*/
    select count(*) INTO l_count from TAIPO TA WHERE TA.CODEID = v_codeid AND TA.STATUS NOT IN ('P','E');
    IF l_count > 0 THEN
       p_err_code := '-100101';
       plog.setendsection (pkgctx, 'fn_txPreAppCheck');
       RETURN errnums.C_BIZ_RULE_INVALID;
    END IF;

    --chua xoa thong tin lien quan thi khong cho xoa IPO
    select count(*) into l_count from taipomembers TM WHERE TM.STATUS <> 'D' and tm.codeid = v_codeid ;
    IF l_count > 0 THEN
       p_err_code := '-100100';
       plog.setendsection (pkgctx, 'fn_txPreAppCheck');
       RETURN errnums.C_BIZ_RULE_INVALID;
    END IF;

    plog.setendsection (pkgctx, 'fn_CheckBeforeDelete');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_CheckBeforeDelete');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_CheckBeforeDelete;

FUNCTION fn_ProcessAfterDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_ProcessAfterDelete');

    plog.setendsection (pkgctx, 'fn_ProcessAfterDelete');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessAfterDelete');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessAfterDelete;

FUNCTION fn_CheckBeforeApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_CheckBeforeApprove');

    plog.setendsection (pkgctx, 'fn_CheckBeforeApprove');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_CheckBeforeApprove');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_CheckBeforeApprove;

FUNCTION fn_ProcessAfterApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
      l_count number;
    l_strSQL varchar2(4000);
l_fldval varchar2(4000);
l_fldtype  varchar2(4000);
l_fldname  varchar2(4000);
l_updatetmp varchar2(4000);
l_upd        varchar2(4000);
l_actionflag varchar2(400);
l_childvalue varchar2(400);
l_childkey varchar2(400);
l_chiltable varchar2(400);
l_modulcode varchar2(12);
l_refobjid  varchar2(12);
l_codeid varchar2(50);
p_errcode varchar(10);
p_errmsg varchar2(200);
BEGIN
    plog.setbeginsection (pkgctx, 'fn_ProcessAfterApprove');

    l_refobjid  :=  p_objmsg.CLAUSE;
     plog.error(pkgctx,'VAO approve: p_objmsg: ' || l_refobjid);

    --Lay tham so duyet
    SELECT actionflag,childvalue,childkey,chiltable
    INTO l_actionflag,l_childvalue,l_childkey,l_chiltable FROM objlog WHERE AUTOID = l_refobjid;
    IF l_actionflag = 'ADD' THEN
      select ta.codeid into l_codeid from taipo ta where ta.ipoid = l_childvalue;
      txpks_auto.pr_genIPOSession(l_codeid ,p_errcode ,p_errmsg );
    END IF;
    plog.setendsection (pkgctx, 'fn_ProcessAfterApprove');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessAfterApprove');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessAfterApprove;

FUNCTION fn_CheckBeforeReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_CheckBeforeReject');

    plog.setendsection (pkgctx, 'fn_CheckBeforeReject');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_CheckBeforeReject');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_CheckBeforeReject;

FUNCTION fn_ProcessAfterReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_ProcessAfterReject');

    plog.setendsection (pkgctx, 'fn_ProcessAfterReject');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessAfterReject');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessAfterReject;

BEGIN
      FOR i IN (SELECT *
                FROM tlogdebug)
      LOOP
         logrow.loglevel    := i.loglevel;
         logrow.log4table   := i.log4table;
         logrow.log4alert   := i.log4alert;
         logrow.log4trace   := i.log4trace;
      END LOOP;
      pkgctx    :=
         plog.init ('txpks_#sa.taipo',
                    plevel => NVL(logrow.loglevel,30),
                    plogtable => (NVL(logrow.log4table,'N') = 'Y'),
                    palert => (NVL(logrow.log4alert,'N') = 'Y'),
                    ptrace => (NVL(logrow.log4trace,'N') = 'Y')
            );
END txpks_#sa_taipo;
/

DROP PACKAGE txpks_#sa_taipomembers
/

CREATE OR REPLACE 
PACKAGE txpks_#sa_taipomembers 
/** ----------------------------------------------------------------------------------------------------
 dung cho form maintenance
 ----------------------------------------------------------------------------------------------------*/
IS

FUNCTION fn_Transfer(p_xmlmsg in out varchar2,p_err_code in out varchar2,p_err_param out varchar2)
RETURN NUMBER;
FUNCTION fn_Add(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Edit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Delete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Adhoc(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Approve(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Reject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;

--rieng
FUNCTION fn_CheckBeforeAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;

END;
/

CREATE OR REPLACE 
PACKAGE BODY txpks_#sa_taipomembers 
IS
   pkgctx   plog.log_ctx;
   logrow   tlogdebug%ROWTYPE;

FUNCTION fn_Transfer(p_xmlmsg in out varchar2,p_err_code in out varchar2,p_err_param out varchar2)
RETURN NUMBER
IS
   l_return_code VARCHAR2(30) := systemnums.C_SUCCESS;
   l_objmsg tx.obj_rectype;
   l_count NUMBER(3);
   l_msgtype VARCHAR2(10);
   l_objname VARCHAR2(100);
   l_actionflag varchar2(100);
   l_currdate varchar2(10);
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Transfer');
   plog.debug(pkgctx, 'fn_Transfer');
   --get object
   l_objmsg:= txpks_msg.fn_mt_xml2obj(p_xmlmsg);
   l_msgtype:= l_objmsg.MSGTYPE;
   l_objname:= l_objmsg.OBJNAME;
   l_actionflag:= l_objmsg.ACTIONFLAG;
   --Kiem tra msgtype de phan luong xu ly
   IF l_actionflag ='ADD' THEN
        IF fn_Add(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;
   ELSIF l_actionflag ='EDIT' THEN
        IF fn_Edit(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;

   ELSIF l_actionflag ='DELETE' THEN
        IF fn_Delete(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;
   ELSIF l_actionflag ='ADHOC' THEN
        IF fn_Adhoc(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;
   ELSIF l_actionflag ='APPROVE' THEN
        IF fn_Approve(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;
   ELSIF l_actionflag ='REJECT' THEN
        IF fn_Reject(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;
   END IF;

   plog.debug(pkgctx, 'fn_Transfer');
   plog.setendsection (pkgctx, 'fn_Transfer');
   RETURN l_return_code;
EXCEPTION
WHEN errnums.E_BIZ_RULE_INVALID
   THEN
      FOR I IN (
           SELECT ERRDESC,EN_ERRDESC FROM deferror
           WHERE ERRNUM= p_err_code
      ) LOOP
           p_err_param := i.errdesc;
      END LOOP;
      p_xmlmsg := txpks_msg.fn_mt_obj2xml(l_objmsg);
      plog.setendsection (pkgctx, 'fn_Transfer');
      ROLLBACK;
      RETURN errnums.C_BIZ_RULE_INVALID;
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      p_err_param := 'SYSTEM_ERROR';
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      p_xmlmsg := txpks_msg.fn_mt_obj2xml(l_objmsg);
      plog.setendsection (pkgctx, 'fn_Transfer');
      RETURN errnums.C_SYSTEM_ERROR;
END fn_Transfer;

FUNCTION fn_Add(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Add');
-- Check befor add
   IF txpks_#sa_taipomembers.fn_CheckBeforeAdd(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- Auto add
   IF txpks_maintain.fn_ProcessAdd(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- After Add
   IF txpks_#sa_taipomembers.fn_ProcessAfterAdd(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
--ghi log
   IF txpks_maintain.fn_MaintainLog(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   plog.setendsection (pkgctx, 'fn_Add');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Add');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Add;

FUNCTION fn_Edit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Edit');
-- Check befor edit
   IF txpks_#sa_taipomembers.fn_CheckBeforeEdit(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- Auto Edit
   IF txpks_maintain.fn_ProcessEdit(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- After Edit
   IF txpks_#sa_taipomembers.fn_ProcessAfterEdit(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   --ghi log
   IF txpks_maintain.fn_MaintainLog(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   plog.setendsection (pkgctx, 'fn_Edit');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Edit');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Edit;

FUNCTION fn_Delete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Delete');
-- Check befor Delete
   IF txpks_#sa_taipomembers.fn_CheckBeforeDelete(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- Auto Delete
   IF txpks_maintain.fn_ProcessDelete(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- After Delete
   IF txpks_#sa_taipomembers.fn_ProcessAfterDelete(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   --ghi log
   IF txpks_maintain.fn_MaintainLog(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   plog.setendsection (pkgctx, 'fn_Delete');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Delete');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Delete;

FUNCTION fn_Adhoc(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Adhoc');

   plog.setendsection (pkgctx, 'fn_Adhoc');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Adhoc');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Adhoc;

FUNCTION fn_Approve(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Approve');
    IF txpks_maintain.fn_Approve(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   plog.setendsection (pkgctx, 'fn_Approve');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Approve');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Approve;

FUNCTION fn_Reject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Reject');

       IF txpks_maintain.fn_Reject(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;

   plog.setendsection (pkgctx, 'fn_Reject');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Reject');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Reject;


FUNCTION fn_CheckBeforeAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
   plog.setbeginsection (pkgctx, 'fn_CheckBeforeAdd');
          -- khong cho them moi o trang thai cho duyet dong
 select  count(1) into l_count from Taipo d where d.SYMBOL = p_objmsg.OBJFIELDS('SYMBOL').value AND d.status = 'R';
  IF l_count > 0  then
    p_err_code := '-111175';
        plog.setendsection (pkgctx, 'fn_CheckBeforeAdd');
        RETURN errnums.C_BIZ_RULE_INVALID;
 end if; 
    plog.setendsection (pkgctx, 'fn_CheckBeforeAdd');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_CheckBeforeAdd');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_CheckBeforeAdd;

FUNCTION fn_ProcessAfterAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_ProcessAfterAdd');

    plog.setendsection (pkgctx, 'fn_ProcessAfterAdd');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessAfterAdd');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessAfterAdd;

FUNCTION fn_CheckBeforeEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_CheckBeforeEdit');

    plog.setendsection (pkgctx, 'fn_CheckBeforeEdit');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_CheckBeforeEdit');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_CheckBeforeEdit;

FUNCTION fn_ProcessAfterEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_ProcessAfterEdit');

    plog.setendsection (pkgctx, 'fn_ProcessAfterEdit');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessAfterEdit');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessAfterEdit;

FUNCTION fn_CheckBeforeDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_CheckBeforeDelete');

    plog.setendsection (pkgctx, 'fn_CheckBeforeDelete');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_CheckBeforeDelete');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_CheckBeforeDelete;

FUNCTION fn_ProcessAfterDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_ProcessAfterDelete');

    plog.setendsection (pkgctx, 'fn_ProcessAfterDelete');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessAfterDelete');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessAfterDelete;

FUNCTION fn_CheckBeforeApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_CheckBeforeApprove');

    plog.setendsection (pkgctx, 'fn_CheckBeforeApprove');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_CheckBeforeApprove');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_CheckBeforeApprove;

FUNCTION fn_ProcessAfterApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_ProcessAfterApprove');

    plog.setendsection (pkgctx, 'fn_ProcessAfterApprove');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessAfterApprove');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessAfterApprove;

FUNCTION fn_CheckBeforeReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_CheckBeforeReject');

    plog.setendsection (pkgctx, 'fn_CheckBeforeReject');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_CheckBeforeReject');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_CheckBeforeReject;

FUNCTION fn_ProcessAfterReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_ProcessAfterReject');

    plog.setendsection (pkgctx, 'fn_ProcessAfterReject');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessAfterReject');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessAfterReject;

BEGIN
      FOR i IN (SELECT *
                FROM tlogdebug)
      LOOP
         logrow.loglevel    := i.loglevel;
         logrow.log4table   := i.log4table;
         logrow.log4alert   := i.log4alert;
         logrow.log4trace   := i.log4trace;
      END LOOP;
      pkgctx    :=
         plog.init ('txpks_#sa.taipomembers',
                    plevel => NVL(logrow.loglevel,30),
                    plogtable => (NVL(logrow.log4table,'N') = 'Y'),
                    palert => (NVL(logrow.log4alert,'N') = 'Y'),
                    ptrace => (NVL(logrow.log4trace,'N') = 'Y')
            );
END txpks_#sa_taipomembers;
/

DROP PACKAGE txpks_#sa_tasipdef
/

CREATE OR REPLACE 
PACKAGE txpks_#sa_tasipdef 
/** ----------------------------------------------------------------------------------------------------
 dung cho form maintenance
 ----------------------------------------------------------------------------------------------------*/
IS

FUNCTION fn_Transfer(p_xmlmsg in out varchar2,p_err_code in out varchar2,p_err_param out varchar2)
RETURN NUMBER;
FUNCTION fn_Add(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Edit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Delete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Adhoc(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Approve(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Reject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;

--rieng
FUNCTION fn_CheckBeforeAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;

END;
/

DROP PACKAGE txpks_#sa_tasiperr
/

CREATE OR REPLACE 
PACKAGE txpks_#sa_tasiperr 
/** ----------------------------------------------------------------------------------------------------
 dung cho form maintenance
 ----------------------------------------------------------------------------------------------------*/
IS

FUNCTION fn_Transfer(p_xmlmsg in out varchar2,p_err_code in out varchar2,p_err_param out varchar2)
RETURN NUMBER;
FUNCTION fn_Add(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Edit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Delete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Adhoc(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Approve(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Reject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;

--rieng
FUNCTION fn_CheckBeforeAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;

END;
/

CREATE OR REPLACE 
PACKAGE BODY txpks_#sa_tasiperr 
IS
   pkgctx   plog.log_ctx;
   logrow   tlogdebug%ROWTYPE;

FUNCTION fn_Transfer(p_xmlmsg in out varchar2,p_err_code in out varchar2,p_err_param out varchar2)
RETURN NUMBER
IS
   l_return_code VARCHAR2(30) := systemnums.C_SUCCESS;
   l_objmsg tx.obj_rectype;
   l_count NUMBER(3);
   l_msgtype VARCHAR2(10);
   l_objname VARCHAR2(100);
   l_actionflag varchar2(100);
   l_currdate varchar2(10);
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Transfer');
   plog.debug(pkgctx, 'fn_Transfer');
   --get object
   l_objmsg:= txpks_msg.fn_mt_xml2obj(p_xmlmsg);
   l_msgtype:= l_objmsg.MSGTYPE;
   l_objname:= l_objmsg.OBJNAME;
   l_actionflag:= l_objmsg.ACTIONFLAG;
   --Kiem tra msgtype de phan luong xu ly
   IF l_actionflag ='ADD' THEN
        IF fn_Add(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;
   ELSIF l_actionflag ='EDIT' THEN
        IF fn_Edit(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;

   ELSIF l_actionflag ='DELETE' THEN
        IF fn_Delete(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;
   ELSIF l_actionflag ='ADHOC' THEN
        IF fn_Adhoc(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;
   ELSIF l_actionflag ='APPROVE' THEN
        IF fn_Approve(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;
   ELSIF l_actionflag ='REJECT' THEN
        IF fn_Reject(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;
   END IF;

   plog.debug(pkgctx, 'fn_Transfer');
   plog.setendsection (pkgctx, 'fn_Transfer');
   RETURN l_return_code;
EXCEPTION
WHEN errnums.E_BIZ_RULE_INVALID
   THEN
      FOR I IN (
           SELECT ERRDESC,EN_ERRDESC FROM deferror
           WHERE ERRNUM= p_err_code
      ) LOOP
           p_err_param := i.errdesc;
      END LOOP;
      p_xmlmsg := txpks_msg.fn_mt_obj2xml(l_objmsg);
      plog.setendsection (pkgctx, 'fn_Transfer');
      ROLLBACK;
      RETURN errnums.C_BIZ_RULE_INVALID;
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      p_err_param := 'SYSTEM_ERROR';
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      p_xmlmsg := txpks_msg.fn_mt_obj2xml(l_objmsg);
      plog.setendsection (pkgctx, 'fn_Transfer');
      RETURN errnums.C_SYSTEM_ERROR;
END fn_Transfer;

FUNCTION fn_Add(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Add');
-- Check befor add
   IF txpks_#SA_TASIPERR.fn_CheckBeforeAdd(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- Auto add
   IF txpks_maintain.fn_ProcessAdd(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
      RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- After Add
   IF txpks_#SA_TASIPERR.fn_ProcessAfterAdd(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
--ghi log
   IF txpks_maintain.fn_MaintainLog(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
      RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   plog.setendsection (pkgctx, 'fn_Add');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Add');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Add;

FUNCTION fn_Edit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Edit');
-- Check befor edit
   IF txpks_#SA_TASIPERR.fn_CheckBeforeEdit(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- Auto Edit
   IF txpks_maintain.fn_ProcessEdit(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- After Edit
   IF txpks_#SA_TASIPERR.fn_ProcessAfterEdit(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   --ghi log
   IF txpks_maintain.fn_MaintainLog(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   plog.setendsection (pkgctx, 'fn_Edit');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Edit');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Edit;

FUNCTION fn_Delete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Delete');
-- Check befor Delete
   IF txpks_#SA_TASIPERR.fn_CheckBeforeDelete(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- Auto Delete
   IF txpks_maintain.fn_ProcessDelete(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- After Delete
   IF txpks_#SA_TASIPERR.fn_ProcessAfterDelete(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   --ghi log
   IF txpks_maintain.fn_MaintainLog(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
   plog.setendsection (pkgctx, 'fn_Delete');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Delete');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Delete;

FUNCTION fn_Adhoc(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Adhoc');

   plog.setendsection (pkgctx, 'fn_Adhoc');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Adhoc');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Adhoc;

FUNCTION fn_Approve(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Approve');

     IF txpks_maintain.fn_Approve(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;

   plog.setendsection (pkgctx, 'fn_Approve');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Approve');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Approve;

FUNCTION fn_Reject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Reject');

       IF txpks_maintain.fn_Reject(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;

   plog.setendsection (pkgctx, 'fn_Reject');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Reject');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Reject;


FUNCTION fn_CheckBeforeAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
   plog.setbeginsection (pkgctx, 'fn_CheckBeforeAdd');

   /*IF p_objmsg.OBJFIELDS('TERMCONT').value <= 0 THEN
        p_err_code := '-111135';
        plog.setendsection (pkgctx, 'fn_CheckBeforeAdd');
        RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
    IF p_objmsg.OBJFIELDS('TERMDISCONT').value <= 0 THEN
        p_err_code := '-111136';
        plog.setendsection (pkgctx, 'fn_CheckBeforeAdd');
        RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
    IF p_objmsg.OBJFIELDS('TOTALTERM').value <= 0 THEN
        p_err_code := '-111137';
        plog.setendsection (pkgctx, 'fn_CheckBeforeAdd');
        RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;*/
   -- check trang thai cho duyet dong thi khong cho lam 
    select  count(1) into l_count from tradingcycle   d,tasiperr ta 
    where d.autoid = ta.refautoid
    and ta.refautoid  =  p_objmsg.OBJFIELDS('REFAUTOID').value AND d.status = 'R';
  IF l_count > 0  then
    p_err_code := '-111175';
        plog.setendsection (pkgctx, 'fn_CheckBeforeAdd');
        RETURN errnums.C_BIZ_RULE_INVALID;
 end if; 

    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_CheckBeforeAdd');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_CheckBeforeAdd;

FUNCTION fn_ProcessAfterAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_ProcessAfterAdd');

    plog.setendsection (pkgctx, 'fn_ProcessAfterAdd');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessAfterAdd');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessAfterAdd;

FUNCTION fn_CheckBeforeEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_CheckBeforeEdit');

    plog.setendsection (pkgctx, 'fn_CheckBeforeEdit');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_CheckBeforeEdit');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_CheckBeforeEdit;

FUNCTION fn_ProcessAfterEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_ProcessAfterEdit');

    plog.setendsection (pkgctx, 'fn_ProcessAfterEdit');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessAfterEdit');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessAfterEdit;

FUNCTION fn_CheckBeforeDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_CheckBeforeDelete');

    plog.setendsection (pkgctx, 'fn_CheckBeforeDelete');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_CheckBeforeDelete');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_CheckBeforeDelete;

FUNCTION fn_ProcessAfterDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_ProcessAfterDelete');

    plog.setendsection (pkgctx, 'fn_ProcessAfterDelete');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessAfterDelete');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessAfterDelete;

FUNCTION fn_CheckBeforeApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_CheckBeforeApprove');

    plog.setendsection (pkgctx, 'fn_CheckBeforeApprove');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_CheckBeforeApprove');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_CheckBeforeApprove;

FUNCTION fn_ProcessAfterApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_ProcessAfterApprove');

    plog.setendsection (pkgctx, 'fn_ProcessAfterApprove');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessAfterApprove');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessAfterApprove;

FUNCTION fn_CheckBeforeReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_CheckBeforeReject');

    plog.setendsection (pkgctx, 'fn_CheckBeforeReject');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_CheckBeforeReject');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_CheckBeforeReject;

FUNCTION fn_ProcessAfterReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_ProcessAfterReject');

    plog.setendsection (pkgctx, 'fn_ProcessAfterReject');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessAfterReject');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessAfterReject;

BEGIN
      FOR i IN (SELECT *
                FROM tlogdebug)
      LOOP
         logrow.loglevel    := i.loglevel;
         logrow.log4table   := i.log4table;
         logrow.log4alert   := i.log4alert;
         logrow.log4trace   := i.log4trace;
      END LOOP;
      pkgctx    :=
         plog.init ('txpks_#cf.cfauth',
                    plevel => NVL(logrow.loglevel,30),
                    plogtable => (NVL(logrow.log4table,'N') = 'Y'),
                    palert => (NVL(logrow.log4alert,'N') = 'Y'),
                    ptrace => (NVL(logrow.log4trace,'N') = 'Y')
            );
END txpks_#SA_TASIPERR;
/

DROP PACKAGE txpks_#sa_taxrate
/

CREATE OR REPLACE 
PACKAGE txpks_#sa_taxrate 
/** ----------------------------------------------------------------------------------------------------
 dung cho form maintenance
 ----------------------------------------------------------------------------------------------------*/
IS

FUNCTION fn_Transfer(p_xmlmsg in out varchar2,p_err_code in out varchar2,p_err_param out varchar2)
RETURN NUMBER;
FUNCTION fn_Add(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Edit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Delete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Adhoc(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Approve(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Reject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;

--rieng
FUNCTION fn_CheckBeforeAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;

END;
/

DROP PACKAGE txpks_#sa_tradingcycle
/

CREATE OR REPLACE 
PACKAGE txpks_#sa_tradingcycle 
/** ----------------------------------------------------------------------------------------------------
 dung cho form maintenance
 ----------------------------------------------------------------------------------------------------*/
IS

FUNCTION fn_Transfer(p_xmlmsg in out varchar2,p_err_code in out varchar2,p_err_param out varchar2)
RETURN NUMBER;
FUNCTION fn_Add(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Edit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Delete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Adhoc(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Approve(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Reject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;

--rieng
FUNCTION fn_CheckBeforeAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;

END;
/

DROP PACKAGE txpks_#xxxxex
/

CREATE OR REPLACE 
PACKAGE txpks_#xxxxex
/**----------------------------------------------------------------------------------------------------
 ** Package: TXPKS_#XXXXEX
 ** and is copyrighted by FSS.
 **
 **    All rights reserved.  No part of this work may be reproduced, stored in a retrieval system,
 **    adopted or transmitted in any form or by any means, electronic, mechanical, photographic,
 **    graphic, optic recording or otherwise, translated in any language or computer language,
 **    without the prior written permission of Financial Software Solutions. JSC.
 **
 **  MODIFICATION HISTORY
 **  Person      Date           Comments
 **  System      18/05/2021     Created
 **  
 ** (c) 2008 by Financial Software Solutions. JSC.
 ** ----------------------------------------------------------------------------------------------------*/
IS
FUNCTION fn_txPreAppCheck(p_txmsg in tx.msg_rectype,p_err_code out varchar2)
RETURN NUMBER;
FUNCTION fn_txAftAppCheck(p_txmsg in tx.msg_rectype,p_err_code out varchar2)
RETURN NUMBER;
FUNCTION fn_txPreAppUpdate(p_txmsg in tx.msg_rectype,p_err_code out varchar2)
RETURN NUMBER;
FUNCTION fn_txAftAppUpdate(p_txmsg in tx.msg_rectype,p_err_code out varchar2)
RETURN NUMBER;
END;
/

CREATE OR REPLACE 
PACKAGE BODY txpks_#xxxxex
IS
   pkgctx   plog.log_ctx;
   logrow   tlogdebug%ROWTYPE;

FUNCTION fn_txPreAppCheck(p_txmsg in tx.msg_rectype,p_err_code out varchar2)
RETURN NUMBER
IS

BEGIN
   plog.setbeginsection (pkgctx, 'fn_txPreAppCheck');
   --plog.debug(pkgctx,'BEGIN OF fn_txPreAppCheck');
   /***************************************************************************************************
    * PUT YOUR SPECIFIC RULE HERE, FOR EXAMPLE:
    * IF NOT <<YOUR BIZ CONDITION>> THEN
    *    p_err_code := '<<ERRNUM>>'; -- Pre-defined in DEFERROR table
    *    plog.setendsection (pkgctx, 'fn_txPreAppCheck');
    *    RETURN errnums.C_BIZ_RULE_INVALID;
    * END IF;
    ***************************************************************************************************/
    --plog.debug (pkgctx, '<<END OF fn_txPreAppCheck');
    plog.setendsection (pkgctx, 'fn_txPreAppCheck');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_txPreAppCheck');
      RAISE errnums.E_SYSTEM_ERROR;
END fn_txPreAppCheck;

FUNCTION fn_txAftAppCheck(p_txmsg in tx.msg_rectype,p_err_code out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_txAftAppCheck');
   --plog.debug (pkgctx, '<<BEGIN OF fn_txAftAppCheck>>');
   /***************************************************************************************************
    * PUT YOUR SPECIFIC RULE HERE, FOR EXAMPLE:
    * IF NOT <<YOUR BIZ CONDITION>> THEN
    *    p_err_code := '<<ERRNUM>>'; -- Pre-defined in DEFERROR table
    *    plog.setendsection (pkgctx, 'fn_txAftAppCheck');
    *    RETURN errnums.C_BIZ_RULE_INVALID;
    * END IF;
    ***************************************************************************************************/
   --plog.debug (pkgctx, '<<END OF fn_txAftAppCheck>>');
   plog.setendsection (pkgctx, 'fn_txAftAppCheck');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_txAftAppCheck');
      RAISE errnums.E_SYSTEM_ERROR;
END fn_txAftAppCheck;

FUNCTION fn_txPreAppUpdate(p_txmsg in tx.msg_rectype,p_err_code out varchar2)
RETURN NUMBER
IS
BEGIN
    plog.setbeginsection (pkgctx, 'fn_txPreAppUpdate');
    --plog.debug (pkgctx, '<<BEGIN OF fn_txPreAppUpdate');
   /***************************************************************************************************
    ** PUT YOUR SPECIFIC PROCESS HERE. . DO NOT COMMIT/ROLLBACK HERE, THE SYSTEM WILL DO IT
    ***************************************************************************************************/
    --plog.debug (pkgctx, '<<END OF fn_txPreAppUpdate');
    plog.setendsection (pkgctx, 'fn_txPreAppUpdate');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
       plog.setendsection (pkgctx, 'fn_txPreAppUpdate');
      RAISE errnums.E_SYSTEM_ERROR;
END fn_txPreAppUpdate;

FUNCTION fn_txAftAppUpdate(p_txmsg in tx.msg_rectype,p_err_code out varchar2)
RETURN NUMBER
IS
BEGIN
    plog.setbeginsection (pkgctx, 'fn_txAftAppUpdate');
    --plog.debug (pkgctx, '<<BEGIN OF fn_txAftAppUpdate');
   /***************************************************************************************************
    ** PUT YOUR SPECIFIC AFTER PROCESS HERE. DO NOT COMMIT/ROLLBACK HERE, THE SYSTEM WILL DO IT
    ***************************************************************************************************/
    --plog.debug (pkgctx, '<<END OF fn_txAftAppUpdate');
    plog.setendsection (pkgctx, 'fn_txAftAppUpdate');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
       plog.setendsection (pkgctx, 'fn_txAftAppUpdate');
      RAISE errnums.E_SYSTEM_ERROR;
END fn_txAftAppUpdate;

BEGIN
      FOR i IN (SELECT *
                FROM tlogdebug)
      LOOP
         logrow.loglevel    := i.loglevel;
         logrow.log4table   := i.log4table;
         logrow.log4alert   := i.log4alert;
         logrow.log4trace   := i.log4trace;
      END LOOP;
      pkgctx    :=
         plog.init ('TXPKS_#XXXXEX',
                    plevel => NVL(logrow.loglevel,30),
                    plogtable => (NVL(logrow.log4table,'N') = 'Y'),
                    palert => (NVL(logrow.log4alert,'N') = 'Y'),
                    ptrace => (NVL(logrow.log4trace,'N') = 'Y')
            );
END TXPKS_#XXXXEX;
/

DROP PACKAGE txpks_auto
/

CREATE OR REPLACE 
PACKAGE txpks_auto IS
procedure pr_updateprocessstatus;
PROCEDURE pr_utradingsessionstatus;
procedure pr_placeorder(p_functionname in varchar2,
                        p_username in varchar2,
                        p_acctno in varchar2,
                        p_afacctno in varchar2,
                        p_exectype in varchar2,
                        p_symbol in varchar2,
                        p_quantity in number,
                        p_quoteprice in number,
                        p_pricetype in varchar2,
                        p_timetype in varchar2,
                        p_book in varchar2,
                        p_via in varchar2,
                        p_dealid in varchar2,
                        p_direct in varchar2,
                        p_effdate in varchar2,
                        p_expdate in varchar2,
                        p_tlid  in  varchar2,
                        p_quoteqtty in number,
                        p_limitprice in number,
                        p_err_code out varchar2,
                        p_err_message out varchar2,
                        p_reforderid in varchar2 default '',
                        p_blorderid   in varchar2 default '',
                        p_note        in varchar2 default ''
                        );
procedure pr_count_term_close_sip (P_CODEID IN VARCHAR2, p_sessionno IN VARCHAR2);
procedure PR_REVERT_EXEC(p_sessionno in varchar2,P_EXECTYPE VARCHAR2);
procedure pr_odsettlementtransfermoney (p_sessionno in varchar2,
                      p_codeid IN VARCHAR2,
                      p_custodycd    IN VARCHAR2 DEFAULT NULL ,
                      p_orderid     IN VARCHAR2 DEFAULT NULL ,
                      p_err_code out varchar2,
                      p_err_message out VARCHAR2
                        ) ;
PROCEDURE pr_odsettlementreceivemoney(p_sessionno in varchar2,
                      p_codeid IN VARCHAR2,
                      p_custodycd    IN VARCHAR2 DEFAULT NULL ,
                      p_orderid     IN VARCHAR2 DEFAULT NULL ,
                      p_err_code out varchar2,
                      p_err_message out VARCHAR2
                        ) ;

procedure pr_odsettlementtransfersec (p_sessionno in varchar2,
                      p_codeid IN VARCHAR2,
                      p_custodycd    IN VARCHAR2 DEFAULT NULL ,
                      p_orderid     IN VARCHAR2 DEFAULT NULL ,
                      p_err_code out varchar2,
                      p_err_message out VARCHAR2
                        ) ;
PROCEDURE pr_odsettlementreceivesec(p_sessionno in varchar2,
                      p_codeid IN VARCHAR2,
                       p_custodycd    IN VARCHAR2 DEFAULT NULL ,
                      p_orderid     IN VARCHAR2 DEFAULT NULL ,
                      p_err_code out varchar2,
                      p_err_message out VARCHAR2
                        ) ;
PROCEDURE PRC_GENFLEX_SIPSW;
procedure pr_taquotebuysell;

procedure pr_srexcec (p_sessionno in varchar2,
                      p_codeid IN VARCHAR2,
                      p_exectype  IN VARCHAR2,
                      p_custodycd    IN VARCHAR2 DEFAULT NULL ,
                      p_orderid     IN VARCHAR2 DEFAULT NULL ,
                      P_istryexe  IN VARCHAR2 DEFAULT 'N' ,
                      p_err_code out varchar2,
                      p_err_message out VARCHAR2
                        );

/*procedure pr_srfeecalculate (p_codeid in varchar2,
                   p_exectype  in varchar2,
                   p_err_code out varchar2,
                   p_err_message out varchar2
                        );*/
 procedure pr_srrelieve(  P_SESSIONNO IN VARCHAR2,
                         P_ERR_CODE OUT varchar2,
                         P_ERR_MSG OUT VARCHAR2);
 procedure pr_srfeecalculate   (p_sessionno in varchar2,
                      p_codeid IN VARCHAR2,
                      p_exectype  IN VARCHAR2,
                      p_custodycd    IN VARCHAR2 DEFAULT NULL ,
                      p_orderid     IN VARCHAR2 DEFAULT NULL ,
                      P_istryexe  IN VARCHAR2 DEFAULT 'N' ,
                      p_err_code out VARCHAR2 ,
                      p_err_message out VARCHAR2
                   );
procedure pr_gensrsip(p_tradingid in varchar2,
                      p_spid in varchar2,
                      p_err_code out varchar2,
                      p_err_message out VARCHAR2
                        );
procedure pr_taswitch(p_tradingid in varchar2 );
procedure pr_srsellagain(p_tradingid in VARCHAR2 );

PROCEDURE pr_SRCLS (p_sessionno in varchar2,
                    p_err_code out varchar2,
                    p_err_message out VARCHAR2);

PROCEDURE  pr_genIPOSession(p_codeid in varchar2,
                           p_err_code out varchar2,
                           p_err_message out VARCHAR2
                        );
/* procedure pr_excecute(p_sessionno in varchar2,
                      p_codeid IN VARCHAR2,
                      p_exectype  IN VARCHAR2,
                      p_err_code out varchar2,
                      p_err_message out VARCHAR2
                        ) ;*/
procedure pr_excecute(p_sessionno  varchar2,
                      p_codeid varchar2,
                      p_exectype VARCHAR2,
                      P_istryexe  IN VARCHAR2 DEFAULT 'N'
                      /*,
                      p_err_code out varchar2,
                      p_err_message out VARCHAR2*/ );
procedure pr_revertexcec (p_sessionno in varchar2,
                          --p_err_code out varchar2,
                          --p_err_message out VARCHAR2,
                          P_TXNUM VARCHAR2 DEFAULT NULL,
                          P_TXDATE DATE DEFAULT NULL
                        );
procedure pr_excereceive( p_sessionno  varchar2,
                          p_codeid varchar2,
                          p_exectype VARCHAR2
                      ) ;
procedure pr_count_termjoin_sip ;

-- type = SM
procedure pr_excecbank_SM(p_err_code    out varchar2,
                          p_err_message out VARCHAR2) ;
-- type = RM
procedure pr_excecbank_RM(p_sessionno  in varchar2,
                          p_err_code    out varchar2,
                          p_err_message out VARCHAR2) ;
-- type = XM tien thua
procedure pr_excecbank_XM(p_sessionno   in varchar2,
                          p_codeid      in varchar2,
                          p_err_code    out varchar2,
                          p_err_message out VARCHAR2) ;
PROCEDURE pr_revert_status_taquote(p_codeid in varchar2);
procedure pr_auto_8006(p_camastid   in varchar2,
                          p_qtty         in number,
                          p_autoid        in number,
                          p_acctno         in varchar2,
                          p_err_code    out varchar2,
                          p_err_message out VARCHAR2) ;
procedure pr_update_feecfd (p_sessionno in VARCHAR2,
                            P_exectype  in VARCHAR2,
                            P_istryexe  in VARCHAR2,
                            p_orderid   IN VARCHAR2 DEFAULT NULL
                        );
procedure pr_clsorder( p_sessionno  IN  varchar2  );

procedure pr_auto_3002(p_trandid   in varchar2,
                          p_amt    in number,
                          p_txdate in varchar2,
                          p_acctno in varchar2,
                          p_desc   in varchar2,
                          p_err_code    out varchar2,
                          p_err_message out VARCHAR2) ;

END;
/

DROP PACKAGE txpks_batch
/

CREATE OR REPLACE 
PACKAGE txpks_batch
 /*----------------------------------------------------------------------------------------------------
     ** Module   : COMMODITY SYSTEM
     ** and is copyrighted by FSS.
     **
     **    All rights reserved.  No part of this work may be reproduced, stored in a retrieval system,
     **    adopted or transmitted in any form or by any means, electronic, mechanical, photographic,
     **    graphic, optic recording or otherwise, translated in any language or computer language,
     **    without the prior written permission of Financial Software Solutions. JSC.
     **

     **  MODIFICATION HISTORY
     **  Person      Date           Comments
     **  Fsser      09-JUNE-2009   dbms_output.put_line(''); Created
     ** (c) 2008 by Financial Software Solutions. JSC.
     ----------------------------------------------------------------------------------------------------*/
 IS

  procedure prc_run_batcheod(p_batchdate varchar2, p_tlid varchar2, p_role varchar2, p_language varchar2, pv_objname varchar2, p_err_code in out varchar2, p_err_param in out varchar2)

   ;

END;
/

CREATE OR REPLACE 
PACKAGE BODY txpks_batch IS
pkgctx plog.log_ctx;
logrow tlogdebug%ROWTYPE;




procedure pr_sabackupdata(p_err_code in OUT varchar2)
as


/**----------------------------------------------------------------------------------------------------
 **  FUNCTION: pr_sabackupdata: Backup d? li?u cu?i ng�y
 **  Person         Date            Comments
 **  ThaiTQ         23/12/2020      Created
 ** (c) 2020 by Financial Software Solutions. JSC.
 ** ----------------------------------------------------------------------------------------------------*/

    v_nextdate date;
    v_currdate date;


    l_return    varchar2(500);
BEGIN
    plog.setBeginSection(pkgctx, 'pr_sabackupdata');
    v_currdate:= getcurrdate();
    v_nextdate:= to_date(getnextdate(to_char(v_currdate,fn_systemnums('systemnums.C_DATE_FORMAT'))), fn_systemnums('systemnums.C_DATE_FORMAT'));


    p_err_code  := fn_systemnums('systemnums.C_SUCCESS');



    plog.debug(pkgctx, 'Begin Backup SETRAN_GEN');
    INSERT INTO setran_gen(  AUTOID, CUSTODYCD, CUSTID, TXNUM, TXDATE, ACCTNO, TXCD, NAMT, CAMT, REF,
    DELTD, ACCTREF, TLTXCD, BUSDATE, TXDESC, TXTIME, BRID, TLID, OFFID, CHID,
    AFACCTNO, SYMBOL, TXTYPE, FIELD, CODEID, TLLOG_AUTOID, TRDESC, VERMATCHING,feeamt,taxamt )
    select tr.autoid, cf.custodycd, cf.custid, tr.txnum, tr.txdate, tr.acctno, tr.txcd, tr.namt, tr.camt, tr.ref, tr.deltd, tr.acctref,
        tl.tltxcd, nvl(tr.bkdate, tl.busdate) busdate,
        txdesc,
        tl.txtime, tl.brid, tl.tlid, tl.offid, tl.chid,
        se.afacctno, f.symbol,  ap.txtype, ap.field, f.codeid, tl.autoid tllog_autoid,
        trdesc, tr.vermatching, tr.feeamt,tr.taxamt
    from setran tr, tllog tl, fund f, semast se, cfmast cf, apptx ap
    where tr.txdate = tl.txdate and tr.txnum = tl.txnum
        and tr.acctno = se.acctno
        and f.codeid = se.codeid
        and se.custodycd = cf.custodycd
        and tr.txcd = ap.txcd and ap.apptype = 'SE' and ap.txtype in ('D','C')
        and tr.namt <> 0 and tr.deltd <> 'Y';
    plog.debug(pkgctx, 'End Backup SETRAN_GEN');

    insert into setrana select * from setran;
    delete from setran;

    --COMMIT;

    -- objlog
    plog.debug(pkgctx, 'Begin Backup OBJLOG');
    insert into objloghist select * from  objlog where txstatus in ('1','5','8','2','9') or deltd = 'Y';
    delete from objlog where txstatus in ('1','5','8','2','9') or deltd = 'Y';
    plog.debug(pkgctx, 'End Backup OBJLOG');
    --COMMIT;

    plog.debug(pkgctx, 'Begin Backup TLLOG,TLLOGFLD');
    -- tllog,tllogfld
    insert into tllogall select TL.* from tllog tl where tl.txstatus in ('1','5','8','2','9') or deltd = 'Y';
    insert into tllogall select TL.* from tllog tl where trim(tl.batchname) = 'BATCH';
    insert into tllogfldall  select fld.* from tllog tl ,tllogfld fld
    where tl.txnum = fld.txnum and tl.txdate = fld.txdate and (tl.txstatus in ('1','5','8','2','9') or tl.deltd = 'Y');
    insert into tllogfldall  select fld.* from tllog tl ,tllogfld fld
    where tl.txnum = fld.txnum and tl.txdate = fld.txdate and trim(tl.batchname) = 'BATCH';

    delete from tllogfld fld where txnum||txdate  in (select txnum||txdate from tllog tl where  tl.txstatus in ('1','5','8','2','9') or tl.deltd = 'Y');
    delete from tllogfld fld where txnum||txdate  in (select txnum||txdate from tllog tl where  trim(tl.batchname) = 'BATCH');
    delete from tllog where txstatus in ('1','5','8','2','9') or deltd = 'Y';
    delete from tllog where trim(batchname) = 'BATCH';


    plog.debug(pkgctx, 'End Backup TLLOG,TLLOGFLD');
    --COMMIT;





    plog.debug(pkgctx, 'End Backup SRMAST');
    --COMMIT;

    --emaillog
    plog.debug(pkgctx, 'Begin Backup emaillog');
    insert into emailloghist select * from emaillog where status not in ('A','N');
    delete from emaillog where status not in ('A','N');
    plog.debug(pkgctx, 'End Backup emaillog');

    --Backup rptlogs
    plog.debug(pkgctx, 'Begin Backup rptlogs');
    insert into rptlogshist select * from rptlogs where v_currdate - txdate > 15;
    delete from rptlogs where v_currdate - txdate > 15;
    plog.debug(pkgctx, 'End Backup rptlogs');


   --advertise
   update advertise
   set status = 'R'
   where status = 'A' and expdate <= getcurrdate();

    -- OXCASCHD
    /*v_logsbody        := plog.info(v_logsctx, 'Begin Backup OXCASCHD');
    insert into OXCASCHDhist
        select * from  OXCASCHD
        where camastid in (select autoid from oxcamast o where o.status in ('R','C','D')) or deltd = 'Y';
    delete from OXCASCHD
        where camastid in (select autoid from oxcamast o where o.status in ('R','C','D')) or deltd = 'Y';
    plog.debug(pkgctx, 'End Backup OXCASCHD');

    -- oxcamast
    plog.debug(pkgctx, 'Begin Backup oxcamast');
    insert into oxcamasthist
        select * from  oxcamast
        where status in ('R','C','D') or deltd = 'Y';
    delete from oxcamast
        where status in ('R','C','D') or deltd = 'Y';
    plog.debug(pkgctx, 'End Backup oxcamast');*/


   -- oxpost
    plog.debug(pkgctx, 'Begin Backup oxpost');
    insert into oxposthist
        select * from  oxpost
        where status in ('R', 'C');
    delete from oxpost
        where status in ('R', 'C');
    plog.debug(pkgctx, 'End Backup oxpost');

-- oxquote
    plog.debug(pkgctx, 'Begin Backup oxquote');
    insert into oxquotehist
        select * from  oxquote
        where status in ('R');
    delete from oxquote
        where status in ('R');
    plog.debug(pkgctx, 'End Backup oxquote');

-- oxsubscribe
    plog.debug(pkgctx, 'Begin Backup oxsubscribe');
    insert into oxsubscribehist
        select * from  oxsubscribe
        where status in ('R');
    delete from oxsubscribe
        where status in ('R');
    plog.debug(pkgctx, 'End Backup oxsubscribe');


    -- oxmastlegmap
    plog.debug(pkgctx, 'Begin Backup oxmastlegmap');
    insert into oxmastlegmaphist
        select * from  oxmastlegmap
        where status in ('R')
        or deltd = 'Y';
    delete from oxmastlegmap
        where status in ('R')
        or deltd = 'Y';
    plog.debug(pkgctx, 'End Backup oxmastlegmap');

    -- OXMASTLEG
    /*plog.debug(pkgctx, 'Begin Backup OXMASTLEG');
    insert into OXMASTLEGhist
        select * from  OXMASTLEG
        where status in ('R')
        or deltd = 'Y';
    delete from OXMASTLEG
        where status in ('R')
        or deltd = 'Y';
    plog.debug(pkgctx, 'End Backup OXMASTLEG');   */


    -- oxmast
    plog.debug(pkgctx, 'Begin Backup oxmast');
    insert into oxmasthist
        select *
        from oxmast
        where status in ('R')
        or deltd = 'Y';
    delete from oxmast
        where status in ('R')
        or deltd = 'Y';
    plog.debug(pkgctx, 'End Backup oxmast');






plog.setEndSection(pkgctx, 'pr_sabackupdata');
  exception
    when others then
      ROLLBACK;
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error(pkgctx,'Err: ' || sqlerrm || ' Trace: ' || dbms_utility.format_error_backtrace );
      plog.setEndSection(pkgctx, 'pr_sabackupdata');
  end pr_sabackupdata;


procedure pr_sabackupdata2(p_err_code in out varchar2)

as

/**----------------------------------------------------------------------------------------------------
 **  FUNCTION: pr_sabackupdata2: Backup d? li?u cu?i ng�y t? b?ng TBLBACKUP
 **  Person         Date            Comments
 **  DieuNDA       28/07/2018       Created
 ** (c) 2018 by Financial Software Solutions. JSC.
 ** ----------------------------------------------------------------------------------------------------*/

    v_nextdate date;
    v_currdate date;

    V_STRSQL        varchar2(500);
    V_STRFRTABLE varchar2(100);
    V_STRTOTABLE varchar2(100);

    l_return varchar2(500);
BEGIN

    plog.setbeginsection(pkgctx, 'pr_sabackupdata2');
    p_err_code  := systemnums.C_SUCCESS;

   --Xoa cac bang khong phai bang giao dich, can backup
    FOR rec IN (SELECT FRTABLE, TOTABLE FROM TBLBACKUP WHERE TYPBK = 'N') loop
        V_STRFRTABLE := REC.FRTABLE;
        V_STRTOTABLE := REC.TOTABLE;
        --Sao luu __HIST
        V_STRSQL := 'INSERT INTO ' || V_STRTOTABLE || ' SELECT * FROM ' ||
                  V_STRFRTABLE;
        plog.debug(pkgctx,  V_STRSQL);
        EXECUTE immediate V_STRSQL;

        V_STRSQL := 'TRUNCATE TABLE ' || V_STRFRTABLE;
        plog.debug(pkgctx,  V_STRSQL);
        EXECUTE immediate V_STRSQL;
    END LOOP;

    --Xoa cac bang khong phai bang giao dich, khong backup
    FOR rec IN (SELECT FRTABLE, TOTABLE FROM TBLBACKUP WHERE TYPBK = 'D') loop
        V_STRFRTABLE := REC.FRTABLE;
        V_STRTOTABLE := REC.TOTABLE;

        V_STRSQL := 'TRUNCATE TABLE ' || V_STRFRTABLE;
        plog.debug(pkgctx,  V_STRSQL);
        EXECUTE immediate V_STRSQL;
    END LOOP;

    -- Backup R39 da thanh cong
    insert into tblr39_log select * from tblr39 where impstatus in ('C', 'R', 'E') or deltd = 'Y';
    delete from tblr39 where status in ('C', 'R', 'E') or deltd = 'Y';
    -- Back update nh?ng log d� ho�n t?t
    insert into reconcile_r39_log select * from reconcile_r39 where status in ('A', 'R','E') or deltd = 'Y';
    delete from reconcile_r39 where status in ('A', 'R', 'E') or deltd = 'Y';

    -- Backup R53 da thanh cong
    insert into tblr53_log select * from tblr53 where impstatus in ('C', 'R', 'E') or deltd = 'Y';
    delete from tblr53 where impstatus in ('C', 'R', 'E') or deltd = 'Y';
    insert into reconcile_r53_log select * from reconcile_r53 where status in ('A', 'R', 'E') or deltd = 'Y';
    delete from reconcile_r53 where status in ('A', 'E', 'R') or deltd = 'Y';

    -- Backup R62 da thanh cong
    insert into tblr62_log select * from tblr62 where impstatus in ('C', 'R', 'E') or deltd = 'Y';
    delete from tblr62 where impstatus in ('C', 'R', 'E') or deltd = 'Y';
    insert into reconcile_r62_log select * from reconcile_r62 where status in ('A', 'R', 'E') or deltd = 'Y';
    delete from reconcile_r62 where status in ('A', 'R', 'E') or deltd = 'Y';

    -- Backup import lenh & khach hang da thanh cong.
    insert into tblod5001_log select * from tblod5001 where nvl(status, 'A') <> 'P' or nvl(deltd, 'Y') = 'Y';
    delete from tblod5001 where nvl(status, 'A') <> 'P' or nvl(deltd, 'Y') = 'Y';

    insert into tblcf2004_log select * from tblcf2004 where nvl(status, 'A') <> 'P' or nvl(deltd, 'Y') = 'Y';
    delete from tblcf2004 where nvl(status, 'A') <> 'P' or nvl(deltd, 'Y') = 'Y';

    --Kiem tra tao sequence moi
    FOR REC IN (SELECT FRTABLE, TOTABLE FROM TBLBACKUP WHERE TYPBK = 'S') loop
        V_STRFRTABLE := REC.FRTABLE;

        V_STRSQL := 'ALTER SEQUENCE '||V_STRFRTABLE||' RESTART WITH 1 ' ;
        plog.debug(pkgctx,  V_STRSQL);
        --EXECUTE immediate V_STRSQL;
        reset_seq(V_STRFRTABLE);
    END LOOP;

    --SELECT prc_update_payment_hist(getcurrdate()) into p_err_code from dual;




plog.setEndSection(pkgctx, 'pr_sabackupdata2');
  exception
    when others then
      ROLLBACK;
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error(pkgctx,'Err: ' || sqlerrm || ' Trace: ' || dbms_utility.format_error_backtrace );
      plog.setEndSection(pkgctx, 'pr_sabackupdata2');
  end pr_sabackupdata2;


  procedure pr_sabeforebatch(p_err_code in out varchar2)

as

/**----------------------------------------------------------------------------------------------------
 **  FUNCTION: pr_sabeforebatch: Backup d? li?u cu?i ng�y t? b?ng TBLBACKUP
 **  Person         Date            Comments
 **  ThaiTQ         23/12/2020       Created
 ** (c) 2020 by Financial Software Solutions. JSC.
 ** ----------------------------------------------------------------------------------------------------*/

    v_nextdate date;
    v_currdate date;

    l_AUTOCLOSE char(1);

    p_err_param  varchar2(100);
    l_currdate date;
    l_payment_c number;
BEGIN

    plog.setbeginsection(pkgctx, 'pr_sabeforebatch');
    p_err_code  := systemnums.C_SUCCESS;
    l_currdate := getcurrdate();

    -- T? ch?i c�c giao d?ch 8825, 8815, 8814, 8812, 8816, 8818, 0404 dang ch? duy?t
    for rec in (select * from tllog where txstatus = '4' and tltxcd in ('8825', '8815', '8814', '8812', '8816', '8818', '0404'))
    loop

        fopks_process.prc_txprocess('REJECT', rec.txnum, to_char(rec.txdate, 'dd/mm/yyyy'), rec.tlid, 'AMC','vie', rec.tlid,p_err_code,p_err_param);

    end loop;

    select varvalue
    into l_AUTOCLOSE
    from sysvar
    where varname = 'AUTOCLOSE';

    /*if l_AUTOCLOSE = 'Y' then

        p_err_code := prc_batch_auto_closensellback();

    end if;

    p_err_code := prc_promotion_automatic();*/

    select to_number(varvalue) into l_payment_c
    from sysvar
    where varname = 'PAYMENT_C';

    -- delete oxmast
   for rec in (select distinct orderid
                from oxmast
                where status = 'A'
                    and nvl(istransfer, 'N') <> 'Y'
                    and txdate + l_payment_c <= fn_getnextbusinessdate (l_currdate, 1)
                order by orderid)
   loop

        fopks_negt.prc_patriotx_8972(rec.orderid, 'ADD','000001','AMC','vie','NEGT_INSR',p_err_code,p_err_param);

        if p_err_code <> '0' then
            return;
        end if;

   end loop;

   -- delete oxquote
   for rec in (select autoid
                from oxquote
                where status = 'N'
                    and txdate + l_payment_c <= fn_getnextbusinessdate (l_currdate, 1)
                order by autoid)
   loop

        fopks_negt.prc_patriotx_8976(rec.autoid, 'ADD','000001','AMC','vie','NEGT_INSR',p_err_code,p_err_param);

        if p_err_code <> '0' then
            return;
        end if;

   end loop;

    -- delete oxpost
    for rec in (select o.autoid from oxpost o
                    left join product p
                        on o.productid = p.shortname
                where o.status = 'A'
                    and (   o.expdate <= l_currdate
                            or (case when o.category = 'T' then nvl(p.lastdate, l_currdate) else l_currdate + 1 end) <= l_currdate
                        )
                )
   loop
        fopks_negt.prc_patriotx_8941(rec.autoid, 'ADD','000001','AMC','vie','NEGT_INSR',p_err_code,p_err_param);

        if p_err_code <> '0' then
            return;
        end if;
   end loop;

    UPDATE SYSVAR
    SET VARVALUE= fn_systemnums('systemnums.C_OPERATION_INACTIVE')
    WHERE GRNAME='SYSTEM' AND VARNAME='HOSTATUS'  ;




plog.setEndSection(pkgctx, 'pr_sabeforebatch');
  exception
    when others then
      ROLLBACK;
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error(pkgctx,'Err: ' || sqlerrm || ' Trace: ' || dbms_utility.format_error_backtrace );
      plog.setEndSection(pkgctx, 'pr_sabeforebatch');
  end pr_sabeforebatch;


  PROCEDURE PR_BATCH_NOTIFY (p_error_code OUT VARCHAR2)
IS
   v_currdate date;
BEGIN
    plog.setbeginsection (pkgctx, 'PR_BATCH_NOTIFY');
    v_currdate := getcurrdate();

    p_error_code  := systemnums.C_SUCCESS;

   --Load lai thong tin tai khoan
    txpks_notify.prc_system_logevent('CFMAST', 'ACCOUNTS', 'ALL'|| '~#~' ||'ALL'|| '~#~' ||'ALL', 'R','Batch refesh CFMAST');

   --Load lai thong tin tai khoan
    txpks_notify.prc_system_logevent('TLLOG', 'TRANS', 'ALL~#~ALL~#~'||to_char(v_currdate,fn_systemnums('systemnums.C_DATE_FORMAT')), 'R','Batch refesh TLLOG');

    plog.setendsection (pkgctx, 'PR_BATCH_NOTIFY');
EXCEPTION
    WHEN OTHERS THEN
        p_error_code := errnums.c_system_error;
        plog.error(pkgctx, sqlerrm);
        plog.setendsection (pkgctx, 'PR_BATCH_NOTIFY');
END PR_BATCH_NOTIFY;

  procedure pr_saafterbatch(p_err_code in out varchar2)

as

/**----------------------------------------------------------------------------------------------------
 **  FUNCTION: pr_saafterbatch: Backup d? li?u cu?i ng�y t? b?ng TBLBACKUP
 **  Person         Date            Comments
 **  ThaiTQ         23/12/2020       Created
 ** (c) 2020 by Financial Software Solutions. JSC.
 ** ----------------------------------------------------------------------------------------------------*/

    v_nextdate date;
    v_currdate date;

    l_AUTOCLOSE char(1);

    p_err_param  varchar2(100);
BEGIN

    plog.setbeginsection(pkgctx, 'pr_saafterbatch');
    p_err_code  := systemnums.C_SUCCESS;

    UPDATE SYSVAR
    SET VARVALUE= fn_systemnums('systemnums.C_OPERATION_ACTIVE')
    WHERE GRNAME='SYSTEM' AND VARNAME='HOSTATUS'  ;

    PR_BATCH_NOTIFY(p_err_code);


plog.setEndSection(pkgctx, 'pr_saafterbatch');
  exception
    when others then
      ROLLBACK;
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error(pkgctx,'Err: ' || sqlerrm || ' Trace: ' || dbms_utility.format_error_backtrace );
      plog.setEndSection(pkgctx, 'pr_saafterbatch');
  end pr_saafterbatch;




procedure prc_process_auto_batch_eod(p_err_code in out varchar2)
as
/**----------------------------------------------------------------------------------------------------
 ** FUNCTION: prc_process_auto_batch_eod: T? d?ng d�ng phi�n GD.
 **  MODIFICATION HISTORY
 **  Person      Date           Comments
 **  ThaiTQ      23/12/2020     Created
 ** (c) 2020 by Financial Software Solutions. JSC.
 ** ----------------------------------------------------------------------------------------------------*/

    l_currdate          date;

    l_holiday           number;
BEGIN

    plog.setbeginsection(pkgctx, 'prc_process_auto_batch_eod');
    p_err_code  := systemnums.C_SUCCESS;
    select count(1) into l_holiday
    from sbcldr
    where holiday = 'Y'
    and to_char(CURRENT_TIMESTAMP, 'DD/MM/YYYY') = to_char(sbdate, 'DD/MM/YYYY');

    if l_holiday = 0 then

    for rec in (select * from sbbatchctl where status = 'Y' order by bchsqn)
    loop
        if rec.bchmdl ='SABKDT' then
            pr_sabackupdata(p_err_code);
            if p_err_code <> fn_systemnums('systemnums.C_SUCCESS') then
                plog.error(pkgctx, 'prc_process_auto_batch_eod error in batch ' ||  rec.bchmdl);
                plog.setEndSection(pkgctx, 'prc_process_auto_batch_eod');
                return;
            end if;
        elsif rec.bchmdl ='SABKDT2' then
            pr_sabackupdata2(p_err_code);
            if p_err_code <> fn_systemnums('systemnums.C_SUCCESS') then
                plog.error(pkgctx, 'prc_process_auto_batch_eod error in batch ' ||  rec.bchmdl);
                plog.setEndSection(pkgctx, 'prc_process_auto_batch_eod');
                return;
            end if;
        elsif rec.bchmdl ='SABFB' then
            pr_sabeforebatch(p_err_code);
            if p_err_code <> fn_systemnums('systemnums.C_SUCCESS') then
                plog.error(pkgctx, 'prc_process_auto_batch_eod error in batch ' ||  rec.bchmdl);
                plog.setEndSection(pkgctx, 'prc_process_auto_batch_eod');
                return;
            end if;
        elsif rec.bchmdl ='SAAFB' then
            pr_saafterbatch(p_err_code);
            if p_err_code <> fn_systemnums('systemnums.C_SUCCESS') then
                plog.error(pkgctx, 'prc_process_auto_batch_eod error in batch ' ||  rec.bchmdl);
                plog.setEndSection(pkgctx, 'prc_process_auto_batch_eod');
                return;
            end if;
        /*elsif rec.bchmdl ='SAAFINDAYPROCESS' then
            pr_saafterindayprocess(p_err_code);
            if p_err_code <> fn_systemnums('systemnums.C_SUCCESS') then
                plog.error(pkgctx, 'prc_process_auto_batch_eod error in batch ' ||  rec.bchmdl);
                plog.setEndSection(pkgctx, 'prc_process_auto_batch_eod');
                return;
            end if;
        elsif rec.bchmdl ='SACWD' then
            pr_sachangeworkingdate(p_err_code);
            if p_err_code <> fn_systemnums('systemnums.C_SUCCESS') then
                plog.error(pkgctx, 'prc_process_auto_batch_eod error in batch ' ||  rec.bchmdl);
                plog.setEndSection(pkgctx, 'prc_process_auto_batch_eod');
                return;
            end if;
        elsif rec.bchmdl ='SAGNWK' then
            pr_sageneralworking(p_err_code);
            if p_err_code <> fn_systemnums('systemnums.C_SUCCESS') then
                plog.error(pkgctx, 'prc_process_auto_batch_eod error in batch ' ||  rec.bchmdl);
                plog.setEndSection(pkgctx, 'prc_process_auto_batch_eod');
                return;
            end if;
        elsif rec.bchmdl = 'OLSYN' then
            pr_saonlinesyndata(p_err_code);
            if p_err_code <> fn_systemnums('systemnums.C_SUCCESS') then
                plog.error(pkgctx, 'prc_process_auto_batch_eod error in batch ' ||  rec.bchmdl);
                plog.setEndSection(pkgctx, 'prc_process_auto_batch_eod');
                return;
            end if;
        elsif rec.bchmdl = 'SABEGINBATCH' then
            pr_sabeginbatch(p_err_code);
            if p_err_code <> fn_systemnums('systemnums.C_SUCCESS') then
                plog.error(pkgctx, 'prc_process_auto_batch_eod error in batch ' ||  rec.bchmdl);
                plog.setEndSection(pkgctx, 'prc_process_auto_batch_eod');
                return;
            end if;
        elsif rec.bchmdl = 'MANAGERFEE' then
            pr_managerfee(p_err_code);
            if p_err_code <> fn_systemnums('systemnums.C_SUCCESS') then
                plog.error(pkgctx, 'prc_process_auto_batch_eod error in batch ' ||  rec.bchmdl);
                plog.setEndSection(pkgctx, 'prc_process_auto_batch_eod');
                return;
            end if;
        elsif rec.bchmdl = 'SALESTS' then
            pr_salestatus(p_err_code);
            if p_err_code <> fn_systemnums('systemnums.C_SUCCESS') then
                plog.error(pkgctx, 'prc_process_auto_batch_eod error in batch ' ||  rec.bchmdl);
                plog.setEndSection(pkgctx, 'prc_process_auto_batch_eod');
                return;
            end if;
        elsif rec.bchmdl = 'ORDERSTS' then
            pr_updateorderstatus(p_err_code);
            if p_err_code <> fn_systemnums('systemnums.C_SUCCESS') then
                plog.error(pkgctx, 'prc_process_auto_batch_eod error in batch ' ||  rec.bchmdl);
                plog.setEndSection(pkgctx, 'prc_process_auto_batch_eod');
                return;
            end if;
        elsif rec.bchmdl = 'OTPEXP' then
            pr_clearotpdata(p_err_code);
            if p_err_code <> fn_systemnums('systemnums.C_SUCCESS') then
                plog.error(pkgctx, 'prc_process_auto_batch_eod error in batch ' ||  rec.bchmdl);
                plog.setEndSection(pkgctx, 'prc_process_auto_batch_eod');
                return;
            end if;
        elsif rec.bchmdl = 'AUTOSENDEMAILBOD' then
            pr_autosendemail_bod(p_err_code);
            if p_err_code <> fn_systemnums('systemnums.C_SUCCESS') then
                plog.error(pkgctx, 'prc_process_auto_batch_eod error in batch ' ||  rec.bchmdl);
                plog.setEndSection(pkgctx, 'prc_process_auto_batch_eod');
                return;
            end if;
        elsif rec.bchmdl = 'AUTOCREATEREPORT' then
            pr_create_reports(p_err_code);
            if p_err_code <> fn_systemnums('systemnums.C_SUCCESS') then
                plog.error(pkgctx, 'prc_process_auto_batch_eod error in batch ' ||  rec.bchmdl);
                plog.setEndSection(pkgctx, 'prc_process_auto_batch_eod');
                return;
            end if;
        elsif rec.bchmdl = 'AUTOSENDEMAILEOD' then
            pr_autosendemail(p_err_code);
            if p_err_code <> fn_systemnums('systemnums.C_SUCCESS') then
                plog.error(pkgctx, 'prc_process_auto_batch_eod error in batch ' ||  rec.bchmdl);
                plog.setEndSection(pkgctx, 'prc_process_auto_batch_eod');
                return;
            end if;
        elsif rec.bchmdl = 'AUTOSENDREPORT' then
            txpks_batch_sendreports('ALL');
            if p_err_code <> fn_systemnums('systemnums.C_SUCCESS') then
                plog.error(pkgctx, 'prc_process_auto_batch_eod error in batch ' ||  rec.bchmdl);
                plog.setEndSection(pkgctx, 'prc_process_auto_batch_eod');
                return;
            end if;
        elsif rec.bchmdl = 'NOTIFYAUTO' then
            pr_Notify(p_err_code);
            if p_err_code <> fn_systemnums('systemnums.C_SUCCESS') then
                plog.error(pkgctx, 'prc_process_auto_batch_eod error in batch ' ||  rec.bchmdl);
                plog.setEndSection(pkgctx, 'prc_process_auto_batch_eod');
                return;
            end if;
        elsif rec.bchmdl = 'TRADINGSESSIONSCHD' then
            pr_tradingsessionschedule(p_err_code);
            if p_err_code <> fn_systemnums('systemnums.C_SUCCESS') then
                plog.error(pkgctx, 'prc_process_auto_batch_eod error in batch ' ||  rec.bchmdl);
                plog.setEndSection(pkgctx, 'prc_process_auto_batch_eod');
                return;
            end if;
        elsif rec.bchmdl = 'ASSIGNCFTYPE' then
            pr_cfmast_clean(p_err_code);
            if p_err_code <> fn_systemnums('systemnums.C_SUCCESS') then
                plog.error(pkgctx, 'prc_process_auto_batch_eod error in batch ' ||  rec.bchmdl);
                plog.setEndSection(pkgctx, 'prc_process_auto_batch_eod');
                return;
            end if;
        elsif rec.bchmdl = 'SALECALCULATOR' then
            pr_calsaletrading(p_err_code);
            if p_err_code <> fn_systemnums('systemnums.C_SUCCESS') then
                plog.error(pkgctx, 'prc_process_auto_batch_eod error in batch ' ||  rec.bchmdl);
                plog.setEndSection(pkgctx, 'prc_process_auto_batch_eod');
                return;
            end if;*/
        end if;
      end loop;

     end if;

   plog.setEndSection(pkgctx, 'prc_process_auto_batch_eod');
  exception
    when others then
      ROLLBACK;
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error(pkgctx,'Err: ' || sqlerrm || ' Trace: ' || dbms_utility.format_error_backtrace );
      plog.setEndSection(pkgctx, 'prc_process_auto_batch_eod');
  end prc_process_auto_batch_eod;

procedure prc_run_batcheod(p_batchdate varchar2, p_tlid varchar2, p_role varchar2, p_language varchar2, pv_objname varchar2, p_err_code in out varchar2, p_err_param in out varchar2)


as
/**----------------------------------------------------------------------------------------------------
 ** FUNCTION: prc_run_batcheod: Goi GD 8964_T?o d?t quy?n coupon-free
 ** and is copyrighted by FSS.
 **
 **    All rights reserved.  No part of this work may be reproduced, stored in a retrieval system,
 **    adopted or transmitted in any form or by any means, electronic, mechanical, photographic,
 **    graphic, optic recording or otherwise, translated in any language or computer language,
 **    without the prior written permission of Financial Software Solutions. JSC.
 **
 **  MODIFICATION HISTORY
 **  Person      Date           Comments
 **  SYSTEM      10/08/2020     Created
 **
 ** (c) 2020 by Financial Software Solutions. JSC.
 ** ----------------------------------------------------------------------------------------------------*/

        l_return            varchar2(500);
BEGIN
        plog.setBeginSection(pkgctx, 'prc_run_batcheod');
        plog.debug(pkgctx, 'prc_run_batcheod(): '
                ||', p_batchdate = ' || p_batchdate
                ||', p_tlid = ' || p_tlid
                ||', p_role = ' || p_role
                ||', p_language = ' || p_language
                ||', pv_objname = ' || pv_objname);

        p_err_code  := fn_systemnums('systemnums.C_SUCCESS');
        p_err_param := 'SUCCESS';

        prc_process_auto_batch_eod(p_err_code);
        If p_err_code <> fn_systemnums('systemnums.C_SUCCESS') then
            p_err_param := fn_get_errmsg(p_err_code,p_language);
            plog.error(pkgctx, 'run prc_run_batcheod got error ' ||p_err_code||':'||p_err_param);
            plog.setEndSection(pkgctx, 'prc_run_batcheod');
            RETURN;
        END IF;

        update sysvar set varvalue =  to_char(to_date(p_batchdate, 'DD/MM/YYYY') - 1, 'DD/MM/YYYY') where varname='PREVDATE' and grname='SYSTEM';
        update sysvar set varvalue =  p_batchdate where varname='CURRDATE' and grname='SYSTEM';
        update sysvar set varvalue =  to_char(to_date(p_batchdate, 'DD/MM/YYYY') + 1, 'DD/MM/YYYY') where varname='NEXTDATE' and grname='SYSTEM';

        SELECT prc_update_payment_hist(to_date(p_batchdate, 'DD/MM/YYYY')) into p_err_code from dual;

  plog.setEndSection(pkgctx, 'prc_run_batcheod');
  exception
    when others then
      ROLLBACK;
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error(pkgctx,'Err: ' || sqlerrm || ' Trace: ' || dbms_utility.format_error_backtrace );
      plog.setEndSection(pkgctx, 'prc_run_batcheod');
  end prc_run_batcheod;

BEGIN
  FOR i IN (SELECT * FROM tlogdebug) LOOP
    logrow.loglevel  := i.loglevel;
    logrow.log4table := i.log4table;
    logrow.log4alert := i.log4alert;
    logrow.log4trace := i.log4trace;
  END LOOP;

  pkgctx := plog.init('TXPKS_BATCH',
                      plevel => logrow.loglevel,
                      plogtable => (logrow.log4table = 'Y'),
                      palert => (logrow.log4alert = 'Y'),
                      ptrace => (logrow.log4trace = 'Y'));
END TXPKS_BATCH;
/

DROP PACKAGE txpks_check
/

CREATE OR REPLACE 
PACKAGE txpks_check 
IS

TYPE afmastcheck_rectype IS RECORD (
      ACCTNO          afmast.acctno%TYPE,
      CUSTID          afmast.CUSTID%TYPE,
      CUSTODYCD       afmast.custodycd%TYPE,
      SID             afmast.sid%TYPE,
      STATUS          afmast.STATUS%TYPE,
      PSTATUS         afmast.PSTATUS%TYPE,
      LASTCHANGE      afmast.LASTCHANGE%TYPE

   );

TYPE afmastcheck_arrtype IS TABLE OF afmastcheck_rectype
      INDEX BY PLS_INTEGER;


TYPE semastcheck_rectype IS RECORD (
      acctno            semast.acctno%TYPE,
      afacctno          semast.afacctno%TYPE,
      custodycd         semast.custodycd%TYPE,
      sid               semast.sid%TYPE,
      codeid            semast.codeid%TYPE,
      symbol            semast.symbol%TYPE,
      trade             semast.trade%TYPE,
      tradesip          semast.tradesip%TYPE,
      tradeepr          semast.tradeepr%TYPE,
      tradeepe          semast.tradeepe%TYPE,
      careceiving       semast.careceiving%TYPE,
      costprice         semast.costprice%TYPE,
      receiving         semast.receiving%TYPE,
      blocked           semast.blocked%TYPE,
      netting           semast.netting%TYPE,
      status            semast.status%TYPE,
      pl                semast.pl%TYPE,
      pstatus           semast.pstatus%TYPE,
      lastchange        semast.lastchange%TYPE,
      sending           semast.sending%TYPE,
      sendingsip        semast.sendingsip%TYPE
   );

TYPE semastcheck_arrtype IS TABLE OF semastcheck_rectype
      INDEX BY PLS_INTEGER;


TYPE sedtlcheck_rectype IS RECORD (
      id                sedtl.id%TYPE,
      account           sedtl.afacctno%TYPE,
      custodycd         sedtl.custodycd%TYPE,
      sid               sedtl.sid%TYPE,
      codeid            sedtl.codeid%TYPE,
      symbol            sedtl.symbol%TYPE,
      nors              sedtl.nors%TYPE,
      orderid           sedtl.orderid%TYPE,
      sipid             sedtl.sipid%TYPE,
      paid              sedtl.paid%TYPE,
      swid              sedtl.swid%TYPE,
      trade             sedtl.trade%TYPE,
      tradeepr          sedtl.tradeepr%TYPE,
      tradeepe          sedtl.tradeepe%TYPE,
      orgtrade          sedtl.orgtrade%TYPE,
      price             sedtl.price%TYPE,
      txdate            sedtl.txdate%TYPE,
      txnum             sedtl.txnum%TYPE,
      cleardate         sedtl.cleardate%TYPE,
      netting           sedtl.netting%TYPE,
      receiving         sedtl.receiving%TYPE,
      status            sedtl.status%TYPE,
      pstatus           sedtl.pstatus%TYPE,
      lastchange        sedtl.lastchange%TYPE,
      sending           sedtl.sending%TYPE
   );

TYPE sedtlcheck_arrtype IS TABLE OF sedtlcheck_rectype
      INDEX BY PLS_INTEGER;


TYPE pamastcheck_rectype IS RECORD (
      ACCTNO          pamast.acctno%TYPE,
      STATUS          pamast.STATUS%TYPE,
      LASTCHANGE      pamast.LASTCHANGE%TYPE

   );

TYPE pamastcheck_arrtype IS TABLE OF pamastcheck_rectype
      INDEX BY PLS_INTEGER;


  FUNCTION fn_aftxmapcheck (
        pv_acctno   IN   VARCHAR2,
        pv_tblname     IN   VARCHAR2,
        pv_acfld       IN varchar2,
        pv_tltxcd in varchar2
     )
        RETURN VARCHAR2;

  FUNCTION fn_semastcheck (
      pv_condvalue   IN   VARCHAR2,
      pv_tblname     IN   VARCHAR2,
      pv_fldkey      IN   VARCHAR2
   )
      RETURN semastcheck_arrtype;
  FUNCTION fn_txCheckTranAllow (
      pv_tlid IN VARCHAR2,
      pv_last_dstatus IN VARCHAR2,
      pv_tltxcd IN VARCHAR2,
      pv_updatemode IN VARCHAR2,
      p_err_code IN OUT VARCHAR2
  ) RETURN NUMBER;
     FUNCTION fn_afmastcheck (
      pv_condvalue   IN   VARCHAR2,
      pv_tblname     IN   VARCHAR2,
      pv_fldkey      IN   VARCHAR2
   )
      RETURN afmastcheck_arrtype  ;
   FUNCTION fn_TxCheckTransAllow (l_txmsg IN tx.msg_rectype) RETURN NUMBER;
   FUNCTION fn_TxTransAllow_by_tlid(pv_tlid IN VARCHAR2, pv_tltxcd IN VARCHAR2, pv_last_dstatus IN VARCHAR2)
   RETURN VARCHAR2;
END;
/

CREATE OR REPLACE 
PACKAGE BODY txpks_check 
IS
   pkgctx   plog.log_ctx;
   logrow   tlogdebug%ROWTYPE;

FUNCTION fn_aftxmapcheck (
      pv_acctno   IN   VARCHAR2,
      pv_tblname     IN   VARCHAR2,
      pv_acfld       IN varchar2,
      pv_tltxcd in varchar2
   )
      RETURN VARCHAR2
   IS
     l_result boolean;
     l_afacctno varchar2(10);
     l_currdate date;
     l_count number(5);
     l_actype VARCHAR2(4);
     l_ChgTypeAllow VARCHAR2(1);
   BEGIN

      l_result:=true;
      l_afacctno:='';
      l_currdate := getcurrdate;

      if pv_tblname='AFMAST' then
          l_afacctno:=   pv_acctno;
      elsif pv_tblname='CIMAST' then
          l_afacctno:=   pv_acctno;
      end if;

      l_count := 0;
      if l_actype is not null THEN
         BEGIN
           SELECT COUNT(1) INTO l_count FROM aftxmap WHERE actype = l_actype AND upper(afacctno) = 'ALL';
           EXCEPTION
                  WHEN OTHERS THEN
                       l_count := 0;
         END;
      END IF;

      IF l_count <> 0 THEN
         -- Chan theo loai hinh.
         l_count := 0;
         select count(1) into l_count from aftxmap where actype = l_actype and tltxcd = pv_tltxcd
            and effdate<=l_currdate and expdate>l_currdate;
            l_result:= case when l_count>0 then false else true end;
      end if;
      if l_result then
          IF l_afacctno is not null THEN
                -- Chan theo tieu khoan.
                l_count := 0;
                select count(1) into l_count from aftxmap where afacctno = l_afacctno and tltxcd = pv_tltxcd
                and effdate<=l_currdate and expdate>l_currdate;
                l_result:= case when l_count>0 then false else true end;
          END IF;
      end if;
      if l_result then
        select ChgTypeAllow into l_ChgTypeAllow from tltx where tltxcd = pv_tltxcd;
        /*if l_ChgTypeAllow = 'N' then
            select COUNT(1) INTO l_count FROM afmast WHERE acctno = l_afacctno and CHGACTYPE = 'Y' and status = 'P';
            l_result:= case when l_count>0 then false else true end;
        end if;*/

      end if;
      RETURN case when l_result then 'TRUE' else 'FALSE' end;
   exception when others then
        plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
        return 'TRUE';
   END fn_aftxmapcheck;
FUNCTION fn_TxTransAllow_by_tlid(pv_tlid IN VARCHAR2, pv_tltxcd IN VARCHAR2, pv_last_dstatus IN VARCHAR2)
   RETURN VARCHAR2
IS
l_return VARCHAR2(1);
l_TLTXALLOW varchar2(20);
l_WORKFOLLOW varchar2(20);
l_TLAUTH varchar2(20);
l_TLAUTH_GROUP varchar2(20);
l_count NUMBER;

BEGIN
    l_return :='N';
  --Get TXWORKFOLLOW
    SELECT FN_GETTLTXWORKFOLLOW(pv_tltxcd) INTO l_WORKFOLLOW FROM DUAL;
    --Get TLAUTH
    SELECT count(STRAUTH) INTO l_count FROM cmdauth  WHERE cmdtype='T'
        AND authtype = 'U' AND AUTHID = pv_tlid AND cmdcode = pv_tltxcd;
    IF l_count >0 THEN
        SELECT STRAUTH INTO l_TLAUTH FROM cmdauth  WHERE cmdtype='T'
        AND authtype = 'U' AND AUTHID = pv_tlid AND cmdcode = pv_tltxcd;
    ELSE
        l_TLAUTH :='NNNNNNNN';
    END IF;
    --Check quyen user
    l_TLTXALLOW := fn_GetTLTXDStatus(l_TLAUTH,pv_last_dstatus);
    IF l_TLTXALLOW ='Y' THEN
       l_return := 'Y';
       RETURN l_return;
    END IF;
    --check quyen group
    FOR rec IN (SELECT M.GRPID FROM TLGRPUSERS M, TLGROUPS A
        WHERE M.GRPID = A.GRPID AND M.TLID = pv_tlid AND A.ACTIVE = 'Y')
    LOOP
        SELECT count(STRAUTH) INTO l_count FROM cmdauth  WHERE cmdtype='T'
        AND authtype = 'G' AND AUTHID = rec.GRPID AND cmdcode = pv_tltxcd;
        IF l_count >0 THEN
            SELECT STRAUTH INTO l_TLAUTH_GROUP FROM cmdauth  WHERE cmdtype='T'
            AND authtype = 'G' AND AUTHID = rec.GRPID AND cmdcode = pv_tltxcd;
            --check
            l_TLTXALLOW := fn_GetTLTXDStatus(l_TLAUTH_GROUP,pv_last_dstatus);
            IF l_TLTXALLOW ='Y' THEN
                l_return := 'Y';
                RETURN l_return;
            END IF;
        END IF;
    END LOOP;

    --Quyen coppy
    /*SELECT count(*) INTO l_count FROM tlcoppyright WHERE TLID = pv_tlid AND
        STATUS='A' AND FRDATE <=GETCURRDATE AND TODATE >= GETCURRDATE;
    IF l_count > 0 THEN
        FOR rec IN (SELECT coppytlid FROM tlcoppyright WHERE TLID = pv_tlid AND
            STATUS='A' AND FRDATE <=GETCURRDATE AND TODATE >= GETCURRDATE)
        LOOP
            --Get TLAUTH
            SELECT count(STRAUTH) INTO l_count FROM cmdauth  WHERE cmdtype='T'
                AND authtype = 'U' AND AUTHID = rec.coppytlid AND cmdcode = pv_tltxcd;
            IF l_count >0 THEN
                SELECT STRAUTH INTO l_TLAUTH FROM cmdauth  WHERE cmdtype='T'
                AND authtype = 'U' AND AUTHID = rec.coppytlid AND cmdcode = pv_tltxcd;
            ELSE
                l_TLAUTH :='NNNNNNNN';
            END IF;
            --Check quyen user
            l_TLTXALLOW := fn_GetTLTXDStatus(l_TLAUTH,pv_last_dstatus);
            IF l_TLTXALLOW ='Y' THEN
               l_return := 'Y';
               RETURN l_return;
            END IF;
            --check quyen group
            FOR rec2 IN (SELECT M.GRPID FROM TLGRPUSERS M, TLGROUPS A
                WHERE M.GRPID = A.GRPID AND M.TLID = rec.coppytlid AND A.ACTIVE = 'Y')
            LOOP
                SELECT count(STRAUTH) INTO l_count FROM cmdauth  WHERE cmdtype='T'
                AND authtype = 'G' AND AUTHID = rec2.GRPID AND cmdcode = pv_tltxcd;
                IF l_count >0 THEN
                    SELECT STRAUTH INTO l_TLAUTH_GROUP FROM cmdauth  WHERE cmdtype='T'
                    AND authtype = 'G' AND AUTHID = rec2.GRPID AND cmdcode = pv_tltxcd;
                    --check
                    l_TLTXALLOW := fn_GetTLTXDStatus(l_TLAUTH_GROUP,pv_last_dstatus);
                    IF l_TLTXALLOW ='Y' THEN
                        l_return := 'Y';
                        RETURN l_return;
                    END IF;
                END IF;
            END LOOP;
        END LOOP;
    END IF;
    */
    RETURN l_return;

EXCEPTION WHEN OTHERS THEN
    RETURN 'N';
END;

  FUNCTION fn_txCheckTranAllow (
      pv_tlid IN VARCHAR2,
      pv_last_dstatus IN VARCHAR2,
      pv_tltxcd IN VARCHAR2,
      pv_updatemode IN VARCHAR2,
      p_err_code IN OUT VARCHAR2
  ) RETURN NUMBER
  IS
  l_count NUMBER;
  l_WORKFOLLOW varchar2(20);
  l_TLAUTH varchar2(20);
  l_TLAUTH_GROUP varchar2(20);
  l_TLTXALLOW varchar2(1); --Y/N
  BEGIN
    p_err_code := systemnums.C_SUCCESS;
    IF pv_tlid = systemnums.C_ADMIN_ID THEN
         p_err_code := systemnums.C_SUCCESS;
         RETURN p_err_code;
    END IF;
    --Get TXWORKFOLLOW
    SELECT FN_GETTLTXWORKFOLLOW(pv_tltxcd) INTO l_WORKFOLLOW FROM DUAL;
    --Get TLAUTH
    SELECT count(STRAUTH) INTO l_count FROM cmdauth  WHERE cmdtype='T'
        AND authtype = 'U' AND AUTHID = pv_tlid AND cmdcode = pv_tltxcd;
    IF l_count >0 THEN
        SELECT STRAUTH INTO l_TLAUTH FROM cmdauth  WHERE cmdtype='T'
        AND authtype = 'U' AND AUTHID = pv_tlid AND cmdcode = pv_tltxcd;
    ELSE
        l_TLAUTH :='NNNNNNNN';
    END IF;
    --check quyen cho user
    plog.error (pkgctx,'l_TLAUTH:'||l_TLAUTH || 'pv_last_dstatus:'||pv_last_dstatus);

    IF pv_updatemode ='C' THEN
        --tao moi, hoac xoa giao dich
        l_TLTXALLOW := fn_GetTLTXDStatus(l_TLAUTH,pv_last_dstatus);
        IF l_TLTXALLOW ='Y' THEN
            p_err_code := systemnums.C_SUCCESS;
            RETURN p_err_code;
        END IF;
    ELSIF  pv_updatemode ='A' THEN
        l_TLTXALLOW := fn_GetTLTXDStatus(l_TLAUTH,pv_last_dstatus);
        IF l_TLTXALLOW ='Y' THEN
            p_err_code := systemnums.C_SUCCESS;
            RETURN p_err_code;
        END IF;
    END IF;
    --plog.error (pkgctx,'l_TLTXALLOW:'||l_TLTXALLOW );
    --Check quyenf group
    FOR rec IN (SELECT M.GRPID FROM TLGRPUSERS M, TLGROUPS A
        WHERE M.GRPID = A.GRPID AND M.TLID = pv_tlid AND A.ACTIVE = 'Y')
    LOOP
        SELECT count(STRAUTH) INTO l_count FROM cmdauth  WHERE cmdtype='T'
        AND authtype = 'G' AND AUTHID = rec.GRPID AND cmdcode = pv_tltxcd;
        IF l_count >0 THEN
            SELECT STRAUTH INTO l_TLAUTH_GROUP FROM cmdauth  WHERE cmdtype='T'
            AND authtype = 'G' AND AUTHID = rec.GRPID AND cmdcode = pv_tltxcd;
            --check
            l_TLTXALLOW := fn_GetTLTXDStatus(l_TLAUTH_GROUP,pv_last_dstatus);
            IF l_TLTXALLOW ='Y' THEN
                p_err_code := systemnums.C_SUCCESS;
                RETURN p_err_code;
            END IF;
        END IF;
    END LOOP;



    p_err_code := errnums.E_TRANS_NOT_ALLOW;
    RETURN p_err_code;

  EXCEPTION WHEN OTHERS THEN
        plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
        return errnums.C_SYSTEM_ERROR;
  END;

  /*FUNCTION fn_TxCheckTransAllow (l_txmsg IN tx.msg_rectype
  ) RETURN NUMBER
  IS
    l_count NUMBER;
    l_WORKFOLLOW varchar2(20);
    l_TLAUTH varchar2(20);
    l_TLAUTH_GROUP varchar2(20);
    l_TLTXALLOW varchar2(1); --Y/N
    pv_tlid varchar2(20);
    pv_tltxcd varchar2(20);
    pv_last_dstatus varchar2(20);
    pv_updatemode varchar2(20);
    pv_deltd varchar2(10);
    p_err_code NUMBER;
  BEGIN
    p_err_code := systemnums.C_SUCCESS;
    --get xml data
    pv_tlid := nvl(l_txmsg.offid,l_txmsg.tlid);
    pv_tltxcd := l_txmsg.tltxcd;
    pv_last_dstatus := l_txmsg.last_dstatus;
    pv_updatemode := l_txmsg.updatemode;
    pv_deltd := l_txmsg.deltd;
    IF pv_tlid = systemnums.C_ADMIN_ID or l_txmsg.cmdobjname = fn_systemnums('systemnums.C_SYSTEM_AUTH') THEN
         p_err_code := systemnums.C_SUCCESS;
         RETURN p_err_code;
    END IF;
    if  pv_tlid = fn_systemnums('systemnums.C_ONLINE_USERID') and pv_updatemode = 'C' then
        select count(*) into l_count
        from focmdmenu
        where objname = l_txmsg.cmdobjname and is4customer = 'Y';

        if l_count > 0 then
            p_err_code := systemnums.C_SUCCESS;
            RETURN p_err_code;
        end if;

        select count(*) into l_count
        from tltx
        where tltxcd = pv_tltxcd and foallow = 'Y';

        if l_count > 0 then
            p_err_code := systemnums.C_SUCCESS;
            RETURN p_err_code;
        end if;

    end if;
    IF pv_updatemode ='C' THEN
        --tao moi
        l_TLTXALLOW := txpks_check.fn_TxTransAllow_by_tlid(pv_tlid,pv_tltxcd,pv_last_dstatus);
        IF l_TLTXALLOW ='Y' THEN
            p_err_code := systemnums.C_SUCCESS;
            RETURN p_err_code;
        END IF;
    ELSIF pv_updatemode ='Z' THEN
    --Huy chi cho user tao huy (refuse)
        --1. Neu la user tao thi cho refuse
        IF pv_tlid = l_txmsg.tlid  THEN
            p_err_code := systemnums.C_SUCCESS;
            RETURN p_err_code;
        END IF;
    ELSIF pv_updatemode ='R' THEN
        --tu choi: chi cho user tao huy (refuse)
        IF l_txmsg.lvel<=1 THEN
            --Tu choi, huy thi check quyen duyet hoac chinh giao dich do user lam thi se duoc huy
            --2.Check quyen duyet, huy
            l_TLTXALLOW := txpks_check.fn_TxTransAllow_by_tlid(pv_tlid,pv_tltxcd,pv_last_dstatus);
            IF l_TLTXALLOW ='Y' THEN
                p_err_code := systemnums.C_SUCCESS;
                RETURN p_err_code;
            END IF;
        ELSE
        --Check quyen duyet
            l_TLTXALLOW := txpks_check.fn_TxTransAllow_by_tlid(pv_tlid,pv_tltxcd,pv_last_dstatus);
            IF l_TLTXALLOW ='Y' THEN
                p_err_code := systemnums.C_SUCCESS;
                RETURN p_err_code;
            END IF;
        END IF;
    ELSIF  pv_updatemode ='A' THEN
        l_TLTXALLOW := txpks_check.fn_TxTransAllow_by_tlid(pv_tlid,pv_tltxcd,pv_last_dstatus);
        IF l_TLTXALLOW ='Y' THEN
           p_err_code := systemnums.C_SUCCESS;
           RETURN p_err_code;
        END IF;
    END IF;

    p_err_code := errnums.E_TRANS_NOT_ALLOW;
    RETURN p_err_code;

  EXCEPTION WHEN OTHERS THEN
        plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
        return errnums.C_SYSTEM_ERROR;
  END;*/

   FUNCTION fn_TxCheckTransAllow (l_txmsg IN tx.msg_rectype
  ) RETURN NUMBER
  IS
    text_var1       varchar2(32000);
    l_count         INTEGER;

    l_isINQUIRY     varchar2(2);
    l_isADD         varchar2(2);
    l_isEDIT        varchar2(2);
    l_isDELETE      varchar2(2);
    l_isAPPROVE     varchar2(2);
    l_cmdid         varchar2(20);
    l_is4customer   varchar2(2);
    l_tltxcd_list   varchar2(1000);
    l_action        varchar2(100);

    p_err_code      NUMBER;

    pv_tlid         varchar2(100);
    pv_cmdtype      varchar2(100);
    pv_cmdobjname   varchar2(100);
    pv_action       varchar2(100);

    pv_tltxcd       varchar2(20);
  BEGIN
    plog.setbeginsection(pkgctx, 'fn_TxCheckTransAllow');
    pv_tlid := nvl(l_txmsg.offid,l_txmsg.tlid);
    pv_action := l_txmsg.updatemode;
    pv_cmdobjname := l_txmsg.CmdObjname;
    pv_cmdtype := 'T';
    pv_tltxcd := l_txmsg.tltxcd;
    plog.debug(pkgctx, '{"pv_tltxcd":"' || pv_tltxcd || ', "pv_tlid":"' || nvl(pv_tlid,'') || '", "pv_cmdtype":"' || nvl(pv_cmdtype,'') || '", "pv_cmdobjname":"' || nvl(pv_cmdobjname,'') || '", "pv_action":"' || nvl(pv_action,'') || '"}');

    p_err_code := fn_systemnums('systemnums.C_SUCCESS');


    if pv_tlid in (fn_systemnums('systemnums.C_ADMIN_ID') , fn_systemnums('systemnums.C_SYSTEM_USERID'))
            or pv_cmdobjname = fn_systemnums('systemnums.C_SYSTEM_AUTH') then
        p_err_code := fn_systemnums('systemnums.C_SUCCESS');
        plog.error(pkgctx, '{"p_err_code":"' || p_err_code || '","pv_tlid:"'||pv_tlid||'"}');
        plog.setendsection(pkgctx, 'fn_TxCheckTransAllow');
        RETURN p_err_code;


    else

        -- 08/09/2018 TruongLD Add, d�i v?i tru?ng h?p view --> user ph?i c� quy?n truy c?p m?t ch?c nang n�o d� c?a h? th?ng.
        if upper(pv_action) = 'VIEW' then
            select COUNT(*) into l_count
            from cmdauth ath, tlgrpusers tl
            where ath.authid = tl.grpid and tl.active = 'Y' and (tl.tlid = pv_tlid or pv_tlid = fn_systemnums('systemnums.C_ONLINE_USERID'));
            if l_count = 0 then
                p_err_code := fn_systemnums('errnums.E_TRANS_NOT_ALLOW');
                plog.error(pkgctx, '{"p_err_code":"' || p_err_code || '","User khong co quyen"}');
                plog.setendsection(pkgctx, 'fn_TxCheckTransAllow');
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
            plog.error(pkgctx, '{"p_err_code":"' || p_err_code || '","Chuc nang khong co trong he thong"}');
            plog.setendsection(pkgctx, 'fn_TxCheckTransAllow');
            RETURN p_err_code;
        end if;

        --select cmdid, is4customer, tltxcd into l_cmdid, l_is4customer, l_tltxcd_list from focmdmenu where objname = pv_cmdobjname;
        --Neu la User Online thi co quyen thuc hien cac chuc nang tren online
        if  pv_tlid = fn_systemnums('systemnums.C_ONLINE_USERID') /*and upper(pv_action) = 'C'*/ then
            select count(*) into l_count from focmdmenu
            where objname = pv_cmdobjname and is4customer = 'Y';

            if l_count > 0 then
                select count(*) into l_count
                from tltx
                where tltxcd = pv_tltxcd and foallow = 'Y';

                if l_count > 0 then
                    p_err_code := fn_systemnums('systemnums.C_SUCCESS');
                    plog.error(pkgctx, '{"p_err_code":"' || p_err_code || '","pv_tlid:"'||pv_tlid||'"}');
                    plog.setendsection(pkgctx, 'fn_TxCheckTransAllow');
                    RETURN p_err_code;
                end if;
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
            elsif l_action = 'ADD' and l_isAPPROVE = 'Y' and pv_cmdobjname = 'APPROVEACCT' then
                l_count := l_count + 1;
            end if;

        end loop;

        if nvl(l_count,0) = 0 then
            p_err_code := fn_systemnums('errnums.E_TRANS_NOT_ALLOW');
            plog.error(pkgctx, '{"p_err_code":"' || p_err_code || '","User khong co quyen thuc hien chuc nang"}');
            plog.setendsection(pkgctx, 'fn_TxCheckTransAllow');
            RETURN p_err_code;
        end if;

    end if;

    plog.setendsection (pkgctx, 'fn_TxCheckTransAllow');
    RETURN p_err_code;

  EXCEPTION WHEN OTHERS THEN
        plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
        plog.setendsection (pkgctx, 'fn_TxCheckTransAllow');
        return errnums.C_SYSTEM_ERROR;
  END fn_TxCheckTransAllow;

   FUNCTION fn_afmastcheck (
      pv_condvalue   IN   VARCHAR2,
      pv_tblname     IN   VARCHAR2,
      pv_fldkey      IN   VARCHAR2
   )
      RETURN afmastcheck_arrtype
   IS
      l_afmastcheck_rectype   afmastcheck_rectype;
      l_afmastcheck_arrtype   afmastcheck_arrtype;
      l_i                     NUMBER (10);
      pv_refcursor            pkg_report.ref_cursor;
      l_txdate                DATE;
      l_custodycd             afmast.custodycd%TYPE;
      l_sid                   afmast.sid%TYPE;
      l_symbol                fund.symbol%type;
      l_count                NUMBER(5);
    BEGIN

 plog.error (pkgctx, 'pv_condvalue'||pv_condvalue);
  plog.error (pkgctx, 'pv_tblname'||pv_tblname);
   plog.error (pkgctx, 'pv_fldkey'||pv_fldkey);
                                                            -- Proc
        SELECT TO_DATE (varvalue, 'DD/MM/YYYY')
        INTO l_txdate
        FROM sysvar
        WHERE grname = 'SYSTEM' AND varname = 'CURRDATE';


            OPEN pv_refcursor FOR
                SELECT ACCTNO,CUSTID,CUSTODYCD,SID,STATUS,PSTATUS,LASTCHANGE
                FROM afmast
                WHERE acctno = pv_condvalue;

                l_i := 0;

            LOOP
                FETCH pv_refcursor
                INTO l_afmastcheck_rectype;
                EXIT WHEN pv_refcursor%NOTFOUND;
                l_afmastcheck_arrtype (l_i) := l_afmastcheck_rectype;
                l_i := l_i + 1;
            END LOOP;



        RETURN l_afmastcheck_arrtype;
    EXCEPTION
      WHEN OTHERS
      THEN
        if pv_refcursor%ISOPEN THEN
            CLOSE pv_refcursor;
         END IF;
         RETURN l_afmastcheck_arrtype;
    END fn_afmastcheck;

   FUNCTION fn_semastcheck (
      pv_condvalue   IN   VARCHAR2,
      pv_tblname     IN   VARCHAR2,
      pv_fldkey      IN   VARCHAR2
   )
      RETURN semastcheck_arrtype
   IS
      l_semastcheck_rectype   semastcheck_rectype;
      l_semastcheck_arrtype   semastcheck_arrtype;
      l_i                     NUMBER (20);
      pv_refcursor            pkg_report.ref_cursor;
      l_txdate                DATE;
      l_custodycd             semast.custodycd%TYPE;
      l_sid                   semast.sid%TYPE;
      l_symbol                fund.symbol%type;
      l_count                NUMBER(5);
    BEGIN


                                                            -- Proc
        SELECT TO_DATE (varvalue, 'DD/MM/YYYY')
        INTO l_txdate
        FROM sysvar
        WHERE grname = 'SYSTEM' AND varname = 'CURRDATE';

        SELECT COUNT(*) INTO L_COUNT FROM SEMAST WHERE ACCTNO = pv_condvalue;
        L_COUNT := NVL(L_COUNT,0);


        IF L_COUNT > 0 THEN
            OPEN pv_refcursor FOR
                SELECT acctno,afacctno,custodycd,sid,codeid,symbol,trade,tradeepr,
                tradeepe,careceiving,costprice,receiving,blocked,netting,status,pl,pstatus,lastchange,tradesip,
                coalesce(sending,0) sending, coalesce(sendingsip,0) sendingsip
                FROM semast
                WHERE acctno = pv_condvalue;

                l_i := 0;

            LOOP
                FETCH pv_refcursor
                INTO l_semastcheck_rectype;
                EXIT WHEN pv_refcursor%NOTFOUND;
                l_semastcheck_arrtype (l_i) := l_semastcheck_rectype;
                l_i := l_i + 1;
            END LOOP;

        else
            --Securities account does not exits
            --Automatic open sub securities account
            SELECT af.custodycd, af.sid
            INTO l_custodycd, l_sid
            FROM afmast af
            WHERE af.acctno = SUBSTR(pv_condvalue,1,10);


            SELECT symbol
            INTO l_symbol
            FROM fund
            WHERE codeid = SUBSTR(pv_condvalue,11,6);





            INSERT INTO semast (acctno,afacctno,custodycd,sid,codeid,symbol,
                                trade,tradesip,tradeepr,tradeepe,careceiving,costprice,receiving,sending,sendingsip,
                                blocked,netting,status,pl,pstatus,lastchange)
            VALUES(pv_condvalue,SUBSTR(pv_condvalue,1,10),l_custodycd,l_sid,SUBSTR(pv_condvalue,11,6),l_symbol,
                   0,0,0,0,0,0,0,0,0,
                   0,0,'A',0,NULL,SYSTIMESTAMP);

           /* RETURNING acctno,
                     afacctno,
                     custodycd,
                     sid,
                     codeid,
                     symbol,
                     trade,
                     tradesip,
                     tradeepr,
                     tradeepe,
                     careceiving,
                     costprice,
                     receiving,
                     blocked,
                     netting,
                     status,
                     pl,
                     pstatus,
                     lastchange,
                     sending
                INTO l_semastcheck_arrtype (0).acctno,
                     l_semastcheck_arrtype (0).afacctno,
                     l_semastcheck_arrtype (0).custodycd,
                     l_semastcheck_arrtype (0).sid,
                     l_semastcheck_arrtype (0).codeid,
                     l_semastcheck_arrtype (0).symbol,
                     l_semastcheck_arrtype (0).trade,
                     l_semastcheck_arrtype (0).tradesip,
                     l_semastcheck_arrtype (0).tradeepr,
                     l_semastcheck_arrtype (0).tradeepe,
                     l_semastcheck_arrtype (0).careceiving,
                     l_semastcheck_arrtype (0).costprice,
                     l_semastcheck_arrtype (0).receiving,
                     l_semastcheck_arrtype (0).blocked,
                     l_semastcheck_arrtype (0).netting,
                     l_semastcheck_arrtype (0).status,
                     l_semastcheck_arrtype (0).pl,
                     l_semastcheck_arrtype (0).pstatus,
                     l_semastcheck_arrtype (0).lastchange,
                     l_semastcheck_arrtype (0).sending
                     ;*/
         OPEN pv_refcursor FOR
             SELECT acctno,afacctno,custodycd,sid,codeid,symbol,trade,tradeepr,
                tradeepe,careceiving,costprice,receiving,blocked,netting,status,pl,pstatus,lastchange,tradesip,
                coalesce(sending,0) sending, coalesce(sendingsip,0) sendingsip
            FROM semast
            WHERE acctno = pv_condvalue;

            l_i := 0;

        LOOP
                FETCH pv_refcursor
                INTO l_semastcheck_rectype;
                EXIT WHEN pv_refcursor%NOTFOUND;
                l_semastcheck_arrtype (l_i) := l_semastcheck_rectype;
                l_i := l_i + 1;
            END LOOP;
        END IF;
        CLOSE pv_refcursor;
        RETURN l_semastcheck_arrtype;
    EXCEPTION
      WHEN OTHERS
      THEN
        if pv_refcursor%ISOPEN THEN
            CLOSE pv_refcursor;
         END IF;
         RETURN l_semastcheck_arrtype;
    END fn_semastcheck;


    FUNCTION fn_sedtlcheck (
      pv_condvalue   IN   VARCHAR2,
      pv_tblname     IN   VARCHAR2,
      pv_fldkey      IN   VARCHAR2
   )
      RETURN sedtlcheck_arrtype
   IS
      l_sedtlcheck_rectype   sedtlcheck_rectype;
      l_sedtlcheck_arrtype   sedtlcheck_arrtype;
      l_i                     NUMBER (10);
      pv_refcursor            pkg_report.ref_cursor;
      l_txdate                DATE;

    BEGIN                                                               -- Proc
        SELECT TO_DATE (varvalue, 'DD/MM/YYYY')
        INTO l_txdate
        FROM sysvar
        WHERE grname = 'SYSTEM' AND varname = 'CURRDATE';


        OPEN pv_refcursor FOR
            SELECT id,afacctno,custodycd,sid,codeid,symbol,nors,orderid,
                    sipid,paid,swid,trade,tradeepr,tradeepe,orgtrade,price,
                    txdate,txnum,cleardate,netting,receiving,status,pstatus,lastchange,sending
            FROM sedtl
            WHERE id = pv_condvalue;

            l_i := 0;

        LOOP
            FETCH pv_refcursor
            INTO l_sedtlcheck_rectype;
            EXIT WHEN pv_refcursor%NOTFOUND;
            l_sedtlcheck_arrtype (l_i) := l_sedtlcheck_rectype;
            l_i := l_i + 1;
        END LOOP;

        RETURN l_sedtlcheck_arrtype;
    EXCEPTION
      WHEN OTHERS
      THEN
        if pv_refcursor%ISOPEN THEN
            CLOSE pv_refcursor;
         END IF;
         RETURN l_sedtlcheck_arrtype;
    END fn_sedtlcheck;
BEGIN
   FOR i IN (SELECT *
               FROM tlogdebug)
   LOOP
      logrow.loglevel := i.loglevel;
      logrow.log4table := i.log4table;
      logrow.log4alert := i.log4alert;
      logrow.log4trace := i.log4trace;
   END LOOP;

   pkgctx :=
      plog.init ('TXPKS_CHECK',
                 plevel         => NVL (logrow.loglevel, 30),
                 plogtable      => (NVL (logrow.log4table, 'N') = 'Y'),
                 palert         => (NVL (logrow.log4alert, 'N') = 'Y'),
                 ptrace         => (NVL (logrow.log4trace, 'N') = 'Y')
                );
END txpks_check;
/

DROP PACKAGE txpks_getorder
/

CREATE OR REPLACE 
PACKAGE txpks_getorder is

  PROCEDURE get_ordersip(pv_ref_cursor IN OUT PKG_REPORT.ref_cursor,
                             pv_cusd   IN VARCHAR2,
                             pv_dlpp    IN VARCHAR2,
                             pv_qcc      IN VARCHAR2,
                             pv_sip      IN VARCHAR2
                             ) ;

PROCEDURE get_ordersipsub(pv_ref_cursor IN OUT PKG_REPORT.ref_cursor,
                             pv_ordercode   IN VARCHAR2
                            
                             ) ;
PROCEDURE get_orderswitch(pv_ref_cursor IN OUT PKG_REPORT.ref_cursor,
                             pv_cusd   IN VARCHAR2,
                             pv_dlpp    IN VARCHAR2,
                             pv_qcc      IN VARCHAR2
                             );
PROCEDURE get_orderswitchsub(pv_ref_cursor IN OUT PKG_REPORT.ref_cursor,
                             pv_ordercode   IN VARCHAR2);
end TXPKS_GETORDER;
/

CREATE OR REPLACE 
PACKAGE BODY txpks_getorder is

  PROCEDURE get_ordersip(pv_ref_cursor IN OUT PKG_REPORT.ref_cursor,
                             pv_cusd   IN VARCHAR2,
                             pv_dlpp    IN VARCHAR2,
                             pv_qcc      IN VARCHAR2,
                             pv_sip      IN VARCHAR2
                             ) IS
   
  BEGIN
  open pv_ref_cursor for  Select r.rolecode -- M? ?LPP
    ,r.rolename -- Ten ?LPP
    ,sip.spname -- ten 
    ,cf.custodycd --SHTKGD
    ,sr.symbol -- ma ccq
    ,sr.sipid ORDERCODE -- so hieu lenh goi sip
    ,sip.frdate -- tu ngay
    ,sip.todate -- den ngay
    ,a1.cdcontent statussip -- trang thai goi sip
 from srmast sr, cfmast cf, tasip sip,roles r,allcode a1
 where 
  cf.custodycd = sr.custodycd
 and sr.SIPID = sip.spid
 and r.Dbcode = cf.dbcode
 and a1.cdname = 'STATUSSIP'
 AND SR.SRTYPE = 'SP'
 and a1.cdval = sip.status
 and (r.mbid = pv_dlpp or pv_dlpp = 'ALL')
 and cf.custodycd like '%'||pv_cusd||'%'
 and sr.symbol like '%'||pv_qcc||'%'
 and (sip.spcode =  pv_sip or pv_sip = 'ALL')
 group by 
 r.rolecode,
 r.rolename -- Ten ?LPP
    ,sip.spname -- ten 
    ,cf.custodycd --SHTKGD
    ,sr.symbol -- ma ccq
    ,sr.sipid  -- so hieu lenh goi sip
    ,sip.frdate -- tu ngay
    ,sip.todate -- den ngay
    ,a1.cdcontent;  -- trang thai goi sip
  EXCEPTION
    WHEN OTHERS THEN
     -- plog.setEndSection(pkgctx, 'getCompareCOLLAT');
      RETURN;
  END;
  
   PROCEDURE get_ordersipsub(pv_ref_cursor IN OUT PKG_REPORT.ref_cursor,
                             pv_ordercode   IN VARCHAR2
                            
                             ) IS
    
  BEGIN
  open pv_ref_cursor for  Select
    sr.txdate -- ngay dat lenh
      ,sr.exectype --loai lenh
      ,sr.orderid -- so hieu lenh
      ,(case when sr.exectype = 'NS' 
      then sr.ORDERAMT else 0 end) ORDERAMTBUY -- gia tri mua
         , (case when sr.exectype = 'NS' 
      then sr.MATCHAMT else 0 end) MATCHAMTBUY -- gia tri mua khop    
        ,(case when sr.exectype = 'NS' 
      then sr.MATCHQTTY else 0 end) MATCHQTTYBUY -- so luong khop mua
        ,(case when sr.exectype = 'NR' 
      then sr.ORDERQTTY else 0 end) QTTYSELL -- so luong dat ban
        ,(case when sr.exectype = 'NR' 
      then sr.MATCHQTTY else 0 end) MATCHQTTYSELL -- so luong khop ban     
        ,(case when sr.exectype = 'NR' 
      then sr.MATCHAMT-sr.FEEAMT else 0 end) TOTALMATCHAMTSELL -- gia tri ban nhan 
        ,(case when sr.exectype = 'CS' 
      then sr.CANCELAMT else 0 end) CANCELAMTBUY -- gia tri mua huy     
        ,(case when sr.exectype = 'AS' 
      then sr.ADJUSTAMT else 0 end) ADJUSTAMTBUY -- gia tri mua sua  
         ,(case when sr.exectype = 'NS' 
      then sr.ORDERAMT-sr.MATCHAMT else 0 end) REMAINBUY -- gia tri mua con lai  
        ,(case when sr.exectype = 'CR' 
      then sr.CANCELQTTY else 0 end) CANCELQTTYSELL -- So luong ban huy
          ,(case when sr.exectype = 'AR' 
      then sr.ADJUSTQTTY else 0 end) ADJUSTQTTYSELL -- So luong ban sua   
        ,(case when sr.exectype = 'R' 
      then sr.ORDERQTTY-sr.MATCHQTTY else 0 end) REMAINSELL -- So luong ban con lai lenh ban     
     , sr.LASTCHANGE      -- gio cap nhat cuoi cung cua lenh    
     ,sr.username -- nguoi dat lenh
     ,a1.cdcontent  status -- trang thai lenh con
         
 from srmast sr, cfmast cf, tasip sip,roles r, allcode a1 
 where 
  cf.custodycd = sr.custodycd
 and sr.SIPID = sip.spid
 and a1.cdname = 'ORSTATUS'
 and a1.cdval = sr.status
 and  sr.sipid = pv_ordercode
 and r.Dbcode = cf.dbcode;
  EXCEPTION
    WHEN OTHERS THEN
     -- plog.setEndSection(pkgctx, 'getCompareCOLLAT');
      RETURN;
  END;
  
  
  PROCEDURE get_orderswitch(pv_ref_cursor IN OUT PKG_REPORT.ref_cursor,
                             pv_cusd   IN VARCHAR2,
                             pv_dlpp    IN VARCHAR2,
                             pv_qcc      IN VARCHAR2
                             ) IS
   
  BEGIN
  open pv_ref_cursor for  Select r.rolecode -- M? DLPP
    ,r.rolename -- Ten DLPP
    ,a1.cdcontent srtype --Lo?i l?nh (hien thi lenh hoan doi
    ,cf.custodycd  SHTKGDG  --SHTKGD GOC
    ,(case when sr.exectype = 'NR' 
      then sr.Symbol else ' ' end) SymbolSELLG -- ma qcc ban goc
         ,(case when sr.exectype = 'NR' 
      then w.qtty else 0 end) QTTYSELLG -- so luong dat ban goc
         ,(case when sr.exectype = 'NS' 
      then sr.Symbol else ' ' end) SymbolBUYG -- ma qcc mua goc
        ,W.TXDATE txdatew -- ngay dat lenh goc
        ,a3.cdcontent STATUSW -- trang thai lenh goc
        ,w.swid ordercode
 from srmast sr, cfmast cf, taswitch w,roles r, allcode a1,allcode a3
 where 
  cf.custodycd = sr.custodycd
 and sr.swid = w.swid
 and r.dbcode = cf.dbcode
 and a1.cdname = 'SRTYPE'
 and a1.cdval = 'SW'
 and a1.cdval = sr.srtype
 and CF.DBCODE = r.Dbcode
 and a3.cdname = 'STATUSSIP' 
 and a3.cdval = w.status
 and (r.mbid = pv_dlpp or pv_dlpp = 'ALL')
 and cf.custodycd like '%'||pv_cusd||'%'
 and sr.symbol like '%'||pv_qcc||'%';
 
  EXCEPTION
    WHEN OTHERS THEN
     -- plog.setEndSection(pkgctx, 'getCompareCOLLAT');
      RETURN;
  END;
  
  
   PROCEDURE get_orderswitchsub(pv_ref_cursor IN OUT PKG_REPORT.ref_cursor,
                             pv_ordercode   IN VARCHAR2
                            
                             ) IS
    
  BEGIN
  open pv_ref_cursor for  Select 
        sr.txdate -- ngay dat lenh con
        ,A4.CDCONTENT  exectype -- mua hay ban
        ,cf.custodycd SHTKGD -- --SHTKGD con
        ,w.swid -- ma lenh hoan doi goc
          ,(case when sr.exectype = 'NS' 
      then sr.Orderid else ' ' end) orderidbuy -- ma lenh mua hoan doi con
         ,(case when sr.exectype = 'NR' 
      then sr.Symbol else ' ' end) SymbolSELLC -- ma qcc ban lenh co
         ,(case when sr.exectype = 'NR' 
      then sr.ORDERQTTY else 0 end) QTTYSELLC -- so luong dat ban lenh con 
         ,(case when sr.exectype = 'NR' 
      then sr.MATCHQTTY else 0 end) MATCHQTTYSELL -- so luong khop ban 
         ,(case when sr.exectype = 'NR' 
      then sr.MATCHAMT-sr.FEEAMT else 0 end) TOTALMATCHAMTSELL -- gia tri ban nhan 
         ,(case when sr.exectype = 'NS'   
      then sr.Symbol else ' ' end) SymbolBUY -- ma qcc mua goc L
     ,(case when sr.exectype = 'S'  then sr.ORDERAMT else 0 end) ORDERAMTBUY -- gia tri mua 
          ,(case when sr.exectype = 'NS' 
      then sr.MATCHQTTY else 0 end) MATCHQTTYBUY -- so luong khop mua
        ,(CASE when sr.MATCHQTTY <> 0 then sr.matchamt/sr.matchqtty else 0 end) price -- nav = gia khop
        ,sr.username -- nguoi dat lenh
         ,(case when sr.exectype = 'CS' 
      then sr.CANCELAMT else 0 end) CANCELAMTBUY -- gia tri mua huy     
        ,(case when sr.exectype = 'AS' 
      then sr.ADJUSTAMT else 0 end) ADJUSTAMTBUY -- gia tri mua sua  
         ,(case when sr.exectype = 'NS' 
      then sr.ORDERAMT-sr.MATCHAMT else 0 end) REMAINBUY -- gia tri mua con lai  
        ,(case when sr.exectype = 'CR' 
      then sr.CANCELQTTY else 0 end) CANCELQTTYSELL -- So luong ban huy
          ,(case when sr.exectype = 'AR' 
      then sr.ADJUSTQTTY else 0 end) ADJUSTQTTYSELL -- So luong ban sua   
        ,(case when sr.exectype = 'NR' 
      then sr.ORDERQTTY-sr.MATCHQTTY else 0 end) REMAINSELL -- So luong ban con lai le
     ,a3.cdcontent status -- trang thai lenh con   
     ,r.contactperson  DLPP -- dai ly phan phoi     
 from srmast sr, cfmast cf, taswitch w,roles r, allcode a1, allcode a3 ,allcode a4
 where 
  cf.custodycd = sr.custodycd
 and sr.swid = w.swid
 and r.DBcode = cf.DBcode
 and a1.cdname = 'SRTYPE'
 and a1.cdval = 'SW'
 and a1.cdval = sr.srtype
 and  sr.swid = pv_ordercode
 and a3.cdname = 'ORSTATUS'
 and a3.cdval = sr.status
 and a4.cdval = sr.exectype
 and a4.cdname = 'EXECTYPE';
 EXCEPTION
    WHEN OTHERS THEN
     -- plog.setEndSection(pkgctx, 'getCompareCOLLAT');
      RETURN;
  END;
  
  
  
end TXPKS_GETORDER;
/

DROP PACKAGE txpks_maintain
/

CREATE OR REPLACE 
PACKAGE txpks_maintain 
/**----------------------------------------------------------------------------------------------------
 Code chung cho cac form maintain
 ** ----------------------------------------------------------------------------------------------------*/
IS
FUNCTION fn_ProcessAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_MaintainLog(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Approve(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2) 
RETURN NUMBER;
FUNCTION fn_Reject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_GetIDValue(p_tablename IN VARCHAR2)
RETURN NUMBER;
FUNCTION fn_getvalFromSQL(p_strSQL IN VARCHAR2,p_fldname IN VARCHAR2)
RETURN VARCHAR2;
END;
/

CREATE OR REPLACE 
PACKAGE BODY txpks_maintain
IS
   pkgctx   plog.log_ctx;
   logrow   tlogdebug%ROWTYPE;

FUNCTION fn_getvalFromSQL(p_strSQL IN VARCHAR2,p_fldname IN VARCHAR2) RETURN VARCHAR2
IS
l_return varchar2(1000);
l_count NUMBER;
l_refcursor pkg_report.ref_cursor;
v_desc_tab dbms_sql.desc_tab;
v_cursor_number NUMBER;
v_columns NUMBER;
v_number_value NUMBER;
v_varchar_value VARCHAR(200);
v_date_value DATE;
l_fldname varchar2(100);
BEGIN
    l_return :='';
    OPEN l_refcursor FOR p_strSQL;
    v_cursor_number := dbms_sql.to_cursor_number(l_refcursor);
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
        FOR i IN 1 .. v_desc_tab.COUNT LOOP
              l_fldname :=  v_desc_tab(i).col_name;
              IF l_fldname = p_fldname THEN
                  IF v_desc_tab(i).col_type = dbms_types.typecode_number THEN
                       dbms_sql.column_value(v_cursor_number, i, v_number_value);
                       l_return := to_char(v_number_value);
                  ELSIF  v_desc_tab(i).col_type = dbms_types.typecode_varchar
                    OR  v_desc_tab(i).col_type = dbms_types.typecode_char
                    THEN
                       dbms_sql.column_value(v_cursor_number, i, v_varchar_value);
                       l_return := v_varchar_value;
                  ELSIF v_desc_tab(i).col_type = dbms_types.typecode_date THEN
                       dbms_sql.column_value(v_cursor_number, i, v_date_value);
                       l_return:=to_char(v_date_value,'DD/MM/RRRR');
                  END IF;
                  RETURN l_return;
              END IF;
        END LOOP;
    END LOOP;
    RETURN l_return;
EXCEPTION WHEN OTHERS THEN
    RETURN '';
END;

FUNCTION fn_GetIDValue(p_tablename IN VARCHAR2) RETURN NUMBER
IS
l_count NUMBER;
l_return NUMBER;
l_strSQL varchar2(2000);
l_refcursor pkg_report.ref_cursor;
BEGIN
    --Kiem tra Sequence da ton tai chua
    l_strSQL := 'select count(*) cn from user_objects where object_name =''SEQ_'|| p_tablename ||'''';
    OPEN l_refcursor FOR l_strSQL;
    LOOP
        FETCH l_refcursor INTO l_count;
        EXIT WHEN l_refcursor%NOTFOUND;
    END LOOP;
    CLOSE l_refcursor;

    IF l_count =0 THEN
        l_strSQL := 'CREATE SEQUENCE SEQ_'||  p_tablename;
        EXECUTE IMMEDIATE l_strSQL;
    END IF;

    l_strSQL := 'Select SEQ_'|| p_tablename ||'.NEXTVAL ID from DUAL';
    OPEN l_refcursor FOR l_strSQL;
    LOOP
        FETCH l_refcursor INTO l_return;
        EXIT WHEN l_refcursor%NOTFOUND;
    END LOOP;
    CLOSE l_refcursor;

    RETURN l_return;
END;


FUNCTION fn_ProcessAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
l_count NUMBER;
l_strSQL varchar2(6000);
l_tablename VARCHAR2(100);
l_fldname varchar2(100);
l_fldval varchar2(4000);
l_fldtype varchar2(100);
l_updatetmp varchar2(4000);
l_upd varchar2(4000);
l_clause varchar2(1000);
l_autoid varchar2(20);
l_decID NUMBER;
l_strSQLMEMO varchar2(4000);
l_strListOfFields varchar2(4000);
l_strListOfValues varchar2(4000);
v_strSQL varchar2(4000);
l_ADDATAPPR varchar2(1);
l_childkey varchar2(200);
l_parenttable varchar2(500);
l_parentkey varchar2(500);
l_parentvalue varchar2(500);
l_objlogID  number;
l_mbcode varchar2(100);
BEGIN
   plog.setbeginsection (pkgctx, 'fn_ProcessAdd');
   -- Code gen tu dong cau insert
   l_tablename := SUBSTR(p_objmsg.OBJNAME,4);
   l_clause := p_objmsg.CLAUSE;
   l_autoid := p_objmsg.AUTOID;
   l_objlogID := p_objmsg.objlogID;

   select childkey, parenttable, parentkey, parentvalue into l_childkey, l_parenttable, l_parentkey, l_parentvalue from objlog where autoid=l_objlogID;

   IF l_autoid ='Y' THEN
        l_decID := fn_GetIDValue(l_tablename);
        if (l_childkey = 'AUTOID' Or l_childkey = 'ID') then
            update objlog
            set childvalue = l_decID,
                parentvalue = (case when parenttable = chiltable and parentkey = childkey then to_char(l_decID) else parentvalue end),
                txdesc = txdesc || (case when parenttable = chiltable and parentkey = childkey then l_decID else null end)
            where autoid=l_objlogID and childkey = l_childkey;

            update maintain_log
            set child_record_value = l_decID,
                record_value = (case when table_name = child_table_name and record_key = child_record_key then to_char(l_decID) else record_value end)
            where refobjid = l_objlogID and child_record_key = l_childkey;

            update maintain_log
            set child_record_value = child_record_value
            where refobjid = l_objlogID and child_record_key = l_childkey and child_record_key = l_childkey;

            l_clause := l_childkey||' = '''||l_decID||'''';
            plog.debug (pkgctx, 'l_clause = ' || l_clause);
        end if;
   END IF;
   --build SQL




   l_fldname := p_objmsg.OBJFIELDS.FIRST;
   WHILE (l_fldname IS NOT NULL)
   LOOP
       l_fldval := p_objmsg.OBJFIELDS(l_fldname).value;
       l_fldtype := p_objmsg.OBJFIELDS(l_fldname).fldtype;


       IF  (l_fldname = 'AUTOID' Or l_fldname = 'ID') THEN
            IF l_autoid ='Y' THEN
                l_fldval :=l_decID;
            ELSE
                l_fldval := p_objmsg.OBJFIELDS(l_fldname).value;
            END IF;
       ELSE
            l_fldval := p_objmsg.OBJFIELDS(l_fldname).value;
       END IF;

       IF l_fldval IS NOT NULL  THEN
            IF l_strListOfFields IS NULL OR length(l_strListOfFields)=0 THEN
                l_strListOfFields := '(' || l_fldname;
                IF l_fldtype ='C' THEN
                    l_strListOfValues := '(''' || Replace(l_fldval,'''', '') || '''';
                ELSIF l_fldtype ='N' THEN
                    l_strListOfValues := '(' || Replace(l_fldval,',', '') ;
                ELSIF l_fldtype ='D' THEN
                    l_strListOfValues := '(to_date(''' ||l_fldval|| ''',''dd/mm/rrrr'')';
                ELSE
                    l_strListOfValues := '(' || l_fldval;
                END IF;
            ELSE
                l_strListOfFields := l_strListOfFields || ',' || l_fldname;
                IF l_fldtype ='C' THEN
                    l_strListOfValues := l_strListOfValues || ',''' || Replace(l_fldval,'''', '') || '''';
                ELSIF l_fldtype ='N' THEN
                    l_strListOfValues := l_strListOfValues|| ',' || Replace(l_fldval,',', '') ;
                ELSIF l_fldtype ='D' THEN
                    l_strListOfValues := l_strListOfValues|| ',to_date(''' ||l_fldval|| ''',''dd/mm/rrrr'')';
                ELSE
                    l_strListOfValues := l_strListOfValues || ',' || l_fldval;
                END IF;
            END IF;
       END IF;
       l_fldname := p_objmsg.OBJFIELDS.NEXT (l_fldname);
   END LOOP;
   l_strSQL := 'insert into '|| l_tablename  || l_strListOfFields || ') VALUES ' || l_strListOfValues || ')';
   l_strSQLMEMO := 'insert into '|| l_tablename ||  'MEMO' || l_strListOfFields || ') VALUES ' || l_strListOfValues || ')';
   plog.error (pkgctx, 'l_strSQL:' || l_strSQL);
   plog.error (pkgctx, 'l_strSQLMEMO:' || l_strSQLMEMO);
   --Check memo
   v_strSQL := 'SELECT ADDATAPPR FROM APPRVRQD WHERE OBJNAME = '''|| l_tablename ||'''';
   --l_ADDATAPPR := nvl(txpks_maintain.fn_getvalFromSQL(v_strSQL,'ADDATAPPR'),'N');
   v_strSQL := 'SELECT ADDATAPPR FROM APPRVRQD WHERE OBJNAME = '''|| l_tablename ||'''';
   --l_ADDATAPPR := nvl(txpks_maintain_fn_getvalfromsql(v_strSQL,'ADDATAPPR'),'N');
   EXECUTE immediate v_strSQL INTO l_ADDATAPPR;
   IF nvl(l_ADDATAPPR,'N') ='N' THEN
        EXECUTE immediate l_strSQL;

        l_strSQL := 'UPDATE '|| l_tablename || ' set status =''A'' , '||
                    'PSTATUS = PSTATUS || STATUS, lastchange = CURRENT_TIMESTAMP WHERE '|| l_clause;
        plog.error (pkgctx, 'l_strSQL auto approve:' || l_strSQL);
        EXECUTE immediate l_strSQL;

        --Cap nhat trang thai objlog la hoan tat
        UPDATE objlog
        SET  txstatus ='1',
            OFFID = p_objmsg.TLID,
            OFFTIME = TO_CHAR( CURRENT_TIMESTAMP,'HH24:MI:SS')
        WHERE AUTOID = p_objmsg.objlogid;

        --Cap nhat trang thai hoan thanh Maintain_log
        UPDATE MAINTAIN_LOG
        SET APPROVE_ID = p_objmsg.TLID,
            APPROVE_DT = getcurrdate(),
            APPROVE_TIME = TO_CHAR( CURRENT_TIMESTAMP,'HH24:MI:SS'),
            LAST_CHANGE = CURRENT_TIMESTAMP
        WHERE REFOBJID = p_objmsg.objlogid;

        --Exception
        IF l_tablename = 'PAYMENT_HIST' THEN
            l_strSQL := 'update ' || l_tablename || ' set payment_status = ''P'' where ' || l_clause;
            plog.error (pkgctx, 'l_strSQL auto approve:' || l_strSQL);
            EXECUTE immediate l_strSQL;
        END IF;

   ELSE
        EXECUTE immediate l_strSQLMEMO;
        EXECUTE immediate l_strSQL;

       l_strSQL := 'UPDATE '||l_tablename|| ' SET STATUS = ''P'' WHERE '||l_clause;
        EXECUTE immediate l_strSQL;
   END IF;

   --Exception
   --QUannnnnnnn
  -- if l_tablename = 'ISSUERS'
    --  then
     --   l_strSQL := 'update ' || l_tablename || ' set issuerid = lpad(autoid, 10, ''0'') where ' || l_clause;
     --   plog.error (pkgctx, 'l_strSQL ISSUERS:' || l_strSQL);
     --   EXECUTE immediate l_strSQL;
   -- end if;
   /* if l_tablename = 'MEMBERS'
      then
     select LPAD(nvl((MAX(to_number(MBCODE)) + 1),'1'),6,'0') into l_mbcode from members;
        l_strSQL := 'update ' || l_tablename || ' set mbcode = '||l_mbcode||' where ' || l_clause;
        plog.error (pkgctx, 'l_strSQL ISSUERS:' || l_strSQL);
        EXECUTE immediate l_strSQL;
    end if;*/

   plog.setendsection (pkgctx, 'fn_ProcessAdd');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessAdd');
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessAdd;

FUNCTION fn_Approve(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
l_count NUMBER;
l_strSQL varchar2(4000);
l_fldval varchar2(4000);
l_fldtype  varchar2(4000);
l_fldname  varchar2(4000);
l_updatetmp varchar2(4000);
l_upd        varchar2(4000);
l_actionflag varchar2(400);
l_childvalue varchar2(400);
l_childkey varchar2(400);
l_chiltable varchar2(400);
l_modulcode varchar2(12);
l_refobjid  varchar2(3200);
l_tlid varchar(20);

v_strRecord_Key varchar2(200);
v_strRecord_Value varchar2(200);
BEGIN

 --l_refobjid  :=  p_objmsg.CLAUSE;
 v_strRecord_Key := trim(substr(p_objmsg.CLAUSE,1, INSTR(p_objmsg.CLAUSE, '=')-1));
 v_strRecord_Value := trim(substr(p_objmsg.CLAUSE,INSTR(p_objmsg.CLAUSE, '=') +1));
 v_strRecord_Value := REPLACE(v_strRecord_Value,'''','');

 l_tlid := p_objmsg.TLID;
 l_refobjid  :=  p_objmsg.CLAUSE;
 plog.error (pkgctx, 'fn_Approve new '||l_refobjid);
--Duyet danh sach OBJlog
--FOR REC IN ( SELECT * FROM objlog WHERE (parentkey = v_strRecord_Key AND parentvalue =v_strRecord_Value) AND (TXSTATUS = '4' or txstatus = '7') /*AND PAUTOID IS NULL*/ order by AUTOID)
FOR REC IN ( SELECT * FROM objlog WHERE (AUTOID = l_refobjid OR PAUTOID =l_refobjid) AND (TXSTATUS = '4' or txstatus = '7') order by autoid)
LOOP
    l_strSQL:='';
    p_objmsg.CLAUSE := REC.AUTOID;
    l_refobjid:= REC.AUTOID;

    --Lay tham so duyet
    SELECT actionflag,childvalue,childkey,chiltable
    INTO l_actionflag,l_childvalue,l_childkey,l_chiltable FROM objlog WHERE AUTOID = l_refobjid;

    -- Check khi them moi chua duyet thi khong cho duyet sua
    IF l_actionflag ='EDIT' THEN
        SELECT COUNT (*) INTO l_count  FROM objlog
        WHERE actionflag ='ADD' AND childvalue = l_childvalue AND  childkey = l_childkey
        AND  chiltable = l_chiltable AND TXSTATUS ='4' AND DELTD ='N';
        IF l_count>0 THEN
            p_err_code := '-100024';
            plog.setendsection (pkgctx, 'fn_txPreAppCheck');
            RETURN errnums.C_BIZ_RULE_INVALID;
        END IF;
    END IF;
    --Xu ly duyet
    IF l_actionflag ='ADD' THEN
        l_strSQL := 'UPDATE '|| L_chiltable || ' set status =''A'' , '||
                    'PSTATUS = PSTATUS || STATUS  WHERE STATUS =''P'' AND '||
                    l_childkey || '=  ''' || l_childvalue ||'''' ;
    ELSIF l_actionflag ='EDIT' THEN
        l_strSQL := 'update '|| l_chiltable ||' set status=''A'' , PSTATUS = PSTATUS || STATUS, ';
        l_updatetmp:='';
        l_upd:='';
        FOR REC IN  ( SELECT * FROM maintain_log WHERE refobjid= l_refobjid )
        LOOP

            l_fldval  := rec.to_value ;
            l_fldtype := rec.column_type;
            l_fldname := rec.column_name;
            if l_fldname = 'FLT' then
              IF l_fldval IS NOT NULL THEN
              l_fldval := replace(l_fldval,'''','''''');
              END IF;
             END IF;
            IF l_fldtype ='C' THEN
                l_updatetmp := l_fldname || ' = ''' || l_fldval ||'''';
            ELSIF l_fldtype ='N' THEN
                l_updatetmp := l_fldname || ' = ''' || REPLACE(l_fldval,',','')||'''';
            ELSIF l_fldtype ='D' THEN
                l_updatetmp := l_fldname || ' = to_date(''' || l_fldval ||''',''dd/mm/rrrr'')';
            ELSE
                l_updatetmp := l_fldname || ' = ''' || l_fldval ||'''';
            END IF;

            IF l_upd IS NULL OR LENGTH(l_upd) = 0 THEN
                l_upd :=l_updatetmp;
            ELSE
                l_upd := l_upd || ',' ||l_updatetmp;
            END IF;
        END LOOP;
        -- neu ko sua thong tin gi ma van bam chap nhan thi khong chay cau lenh sql
        IF l_upd <> '' OR l_upd IS NOT NULL OR LENGTH(l_upd) <> 0 THEN
            l_strSQL := l_strSQL || l_upd || ' where 0=0 and ' ||  l_childkey || '=  ''' || l_childvalue ||'''' ;
        END IF;

    ELSIF l_actionflag ='DELETE' THEN
        l_strSQL := 'DELETE FROM  '|| L_chiltable || ' WHERE STATUS =''R'' AND '||
                    l_childkey || '=  ''' || l_childvalue ||'''' ;
    END IF;
    --Thuc hien cap nhat du lieu khi duyet
    plog.error (pkgctx, 'l_strSQL:' || l_strSQL );
    EXECUTE IMMEDIATE l_strSQL;


    --Cap nhat trang thai objlog la hoan tat, offid,offtime
    UPDATE objlog SET  txstatus ='1', offid = l_tlid, offtime = TO_CHAR( SYSTIMESTAMP,'HH24:MI:SS')  WHERE AUTOID = l_refobjid;
    --Cap nhat trang thai hoan thanh Maintain_log
    UPDATE MAINTAIN_LOG
    SET APPROVE_ID = p_objmsg.TLID,
        APPROVE_DT = GETCURRDATE(),
        APPROVE_TIME = TO_CHAR( CURRENT_TIMESTAMP,'HH24:MI:SS'),
        LAST_CHANGE = CURRENT_TIMESTAMP
    WHERE REFOBJID = l_refobjid;
END LOOP;
   plog.setendsection (pkgctx, 'fn_Approve');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Approve');
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Approve;

FUNCTION fn_Reject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
l_count NUMBER;
l_strSQL varchar2(4000);
l_fldval varchar2(4000);
l_fldtype  varchar2(4000);
l_fldname  varchar2(4000);
l_updatetmp varchar2(4000);
l_upd        varchar2(4000);
l_actionflag varchar2(400);
l_childvalue varchar2(400);
l_childkey varchar2(400);
l_chiltable varchar2(400);
l_modulcode varchar2(12);
l_refobjid  varchar2(12);
l_txstatus varchar2(10);
l_tlid varchar2(20);
BEGIN
 l_refobjid  :=  p_objmsg.CLAUSE;
 l_tlid :=  p_objmsg.TLID;
 plog.error (pkgctx, 'fn_Reject new '||l_refobjid);
FOR REC IN ( SELECT * FROM objlog WHERE (AUTOID = l_refobjid OR PAUTOID =l_refobjid) AND (TXSTATUS ='4' or txstatus = '7') )
LOOP
    l_strSQL:='';
    l_refobjid:= REC.AUTOID;
    SELECT actionflag,childvalue,childkey,chiltable, TXSTATUS
    INTO l_actionflag,l_childvalue,l_childkey,L_chiltable,l_txstatus FROM objlog WHERE AUTOID = l_refobjid;
    -- plog.error (pkgctx, 'l_childkey'||l_childkey || 'l_childvalue: ' ||l_childvalue);



     -- Check khi them moi chua duyet thi khong cho reject sua
    IF l_actionflag ='EDIT' THEN
        SELECT COUNT (*) INTO l_count  FROM objlog
        WHERE actionflag ='ADD' AND childvalue = l_childvalue AND  childkey = l_childkey
        AND  chiltable = l_chiltable AND TXSTATUS ='4' AND DELTD ='N';
        IF l_count>0 THEN
            p_err_code := '-100024';
            plog.setendsection (pkgctx, 'fn_txPreAppCheck');
            RETURN errnums.C_BIZ_RULE_INVALID;
        END IF;
    END IF;
 --        Xu ly delete
    IF l_actionflag ='ADD' THEN
        IF (upper(L_chiltable) = 'COMBOPRODUCT') then
            DELETE FROM PRODUCTIER WHERE ID = l_childvalue;
        END IF;
    END IF;
    -- xu ly xoa promotiondtl
    IF l_actionflag ='ADD' THEN
        IF (upper(L_chiltable) = 'PROMOTION') then
            DELETE FROM PROMOTIONDTL WHERE ID = l_childvalue;
        END IF;
    END IF;
 --Xu ly Reject
    IF l_actionflag ='ADD' THEN
         l_strSQL := 'DELETE FROM '|| L_chiltable ||'   WHERE STATUS =''P'' AND '||
                     l_childkey || '=  ''' || l_childvalue ||'''' ;
                   --  plog.error (pkgctx, 'l_strSQL: '||l_strSQL);
    ELSIF l_actionflag ='EDIT' THEN
         l_strSQL := 'UPDATE '|| L_chiltable || ' set status =substr(replace(pstatus , ''J'', ''''), length(replace(pstatus , ''J'', '''') ), 1) , '||
                     'PSTATUS = PSTATUS || STATUS  WHERE STATUS =''J'' AND '||
                     l_childkey || '=  ''' || l_childvalue ||'''' ;
    ELSIF l_actionflag ='DELETE' THEN
         l_strSQL := 'UPDATE '|| L_chiltable || ' set status = substr(pstatus,length(pstatus) ,1 ) , '||
                     'PSTATUS = PSTATUS || STATUS  WHERE STATUS =''R'' AND '||
                     l_childkey || '=  ''' || l_childvalue ||'''' ;
    END IF;
    --Thuc hien
    EXECUTE IMMEDIATE l_strSQL;

/*    -- case rieng TH REJECT tradingcycle thi xoa them tradingcycle
   IF L_chiltable = 'TRADINGCYCLE' THEN
     IF l_actionflag ='ADD' THEN
         l_strSQL := 'DELETE FROM TRADINGCYCLEDTL WHERE REFAUTOID' || '=  ''' || l_childvalue ||'''';
     end if;
   END IF;
   EXECUTE IMMEDIATE l_strSQL;*/
    --Cap nhat trang thai objlog la tu choi
    UPDATE objlog SET  txstatus ='5' ,offid = l_tlid, offtime = TO_CHAR( SYSTIMESTAMP,'HH24:MI:SS') WHERE AUTOID = l_refobjid;
END LOOP;
 plog.setendsection (pkgctx, 'fn_Reject');
 RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Reject');
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Reject;

FUNCTION fn_MaintainLog(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count NUMBER;
    l_count_pending NUMBER;
    l_strSQL varchar2(4000);
    l_tablename VARCHAR2(100);
    l_fldname varchar2(100);
    l_fldval varchar2(4000);
    l_fldtype varchar2(100);
    l_updatetmp varchar2(4000);
    l_upd varchar2(4000);
    l_fldoldval varchar2(4000);
    l_clause varchar2(1000);
    l_currdate DATE;
    v_strSQL CLOB;
    l_rqdString varchar2(1000);
    v_strParentObjName varchar2(100);
    v_strParentClause varchar2(100);
    v_strChildClause varchar2(100);
    v_strChildObjName varchar2(100);
    v_strRecord_Key varchar2(1000);
    v_strRecord_Value varchar2(1000);
    v_strChild_Record_Key varchar2(1000);
    v_strChild_Record_Value varchar2(1000);
    l_modNum varchar2(200);
    v_logSQL CLOB;
    l_actionflag varchar2(20);
    l_tlid varchar2(10);
    l_refobjid number ;
    L_brid varchar2(10);
    l_ipaddress varchar2(20);
    l_WSNAME varchar2(100);
    l_OBJNAME varchar2(20);
    l_txnum   varchar2(12);
    l_modulcode varchar2(12);
    l_des  varchar2(1000);
    l_ISEDIT NUMBER;
    l_childtable  varchar2(1000);
    l_pautoid NUMBER; -- neu truoc do key goc da co su kien thi khong sinh objlog
    l_objtitle  varchar2(1000);
    l_actionflagname varchar2(1000);
    v_strRecord_Value_des varchar2(1000); -- gia tri hien thi
    l_objtitle_child varchar2(1000); -- gia tri hien thi
    l_fldval_flt varchar2(1000); --lay rieng cho gia tri filter vao feeapply
    l_fldoldval_flt varchar2(1000);
    l_refcursor pkg_report.ref_cursor;
    l_FunctionName varchar2(100);
    l_codeid_4objlog VARCHAR2(20);
    v_count NUMBER;
    v_check BOOLEAN;

    l_CFCUSTODYCD   varchar2(500);
    l_cffullname   varchar2(500);
    l_CCYUSAGE      varchar2(50);
    l_updatefld     varchar2(3);

    v_logSQLdel       CLOB;
    l_status        char(1);
    str1    clob;
    str2    clob;
BEGIN
   plog.setbeginsection (pkgctx, 'fn_MaintainLog');
   --gi maintenance log
   l_childtable:=SUBSTR(p_objmsg.CHILDTABLE,4);
   v_strChildClause:=p_objmsg.CLAUSE;
   l_tablename := SUBSTR(p_objmsg.OBJNAME,4);
   v_strParentObjName:= SUBSTR(p_objmsg.PARENTOBJNAME ,4);

   v_strParentObjName := SUBSTR(p_objmsg.PARENTOBJNAME,4);
   v_strParentClause :=p_objmsg.PARENTCLAUSE;
   l_actionflag:= p_objmsg.ACTIONFLAG;
   l_tlid :=p_objmsg.TLID;
   L_brid := p_objmsg.MBID;
   l_ipaddress:= p_objmsg.IPADDRESS;
   l_WSNAME:= p_objmsg.WSNAME;
   l_objname := p_objmsg.OBJNAME;
   l_currdate:= getcurrdate;
   l_txnum := L_brid|| LPAD( seq_txnum.NEXTVAL,6,'0');
   l_modulcode:=SUBSTR(p_objmsg.OBJNAME,1,2);
   l_ISEDIT := 0;
   l_codeid_4objlog :='';
   --function nane dung cho addhoc va duyet maintain ( link den pckname lu trong objlog)
   l_FunctionName := p_objmsg.FUNCTIONNAME;
  --Lay tham so
  IF v_strParentObjName  IS NULL OR LENGTH(v_strParentObjName) = 0   THEN
  v_strParentObjName:= l_tablename;
   v_strChildObjName:= nvl(l_childtable, l_tablename);
  ELSE
  v_strChildObjName:= nvl(l_childtable, l_tablename);
  END IF;

   IF v_strParentClause  IS NULL OR LENGTH(v_strParentClause) = 0   THEN
        v_strParentClause := v_strChildClause;
   END IF;
    plog.error (pkgctx, 'v_strParentClause: '|| v_strParentClause);
   IF  length(v_strParentClause) <> 0 THEN
        v_strRecord_Key := Trim(substr(v_strParentClause,1, InStr(v_strParentClause, '=')-1));
        v_strRecord_Value := Trim(substr(v_strParentClause,InStr(v_strParentClause, '=') +1));
        v_strRecord_Value := REPLACE(v_strRecord_Value,'''','');
   ELSE
        v_strRecord_Key := '';
        v_strRecord_Value := '';
   END IF;

   IF  length(v_strChildClause) <> 0 THEN
        v_strChild_Record_Key := Trim(substr(v_strChildClause,1, InStr(v_strChildClause, '=')-1));
        v_strChild_Record_Value := Trim(substr(v_strChildClause, InStr(v_strChildClause, '=') +1));
        v_strChild_Record_Value:=REPLACE(v_strChild_Record_Value,'''','');
   ELSE
        v_strChild_Record_Key := '';
        v_strChild_Record_Value := '';
   END IF;

   --Lay key val cua bang cha
   BEGIN
       SELECT max(autoid) INTO L_pautoid FROM objlog
       WHERE parentvalue = v_strRecord_Value AND  parentkey = v_strRecord_Key
       AND PARENTTABLE =v_strParentObjName AND   actionflag =  l_actionflag
       AND txstatus ='4'AND deltd <>'Y' AND PAUTOID IS NULL   ;
   EXCEPTION WHEN OTHERS THEN
       L_pautoid:='';
   END;

   l_refobjid:= seq_tllog.NEXTVAL;


   SELECT objtitle INTO l_objtitle  FROM objmaster WHERE substr( objname,4) = v_strParentObjName;
   SELECT objtitle INTO l_objtitle_child  FROM objmaster WHERE substr( objname,4) = v_strChildObjName;
   SELECT cdcontent INTO l_actionflagname  FROM allcode WHERE cdname ='ACTIONFLAG' AND CDVAL = l_actionflag;

BEGIN
    --Xu ly dac biet
    --#20191031 ThaiTQ add
    IF v_strRecord_Key ='SYMBOL' THEN
        l_CCYUSAGE := v_strRecord_Value;
    end if;

    /*IF v_strParentObjName ='ASSETDTL' THEN
        select symbol into l_CCYUSAGE
        from assetdtl
        where autoid = v_strRecord_Value;
    end if;*/

    if v_strRecord_Key ='AFACCTNO' and v_strParentObjName in ('SBSEDEFACCT') then
        SELECT a.custodycd, a.fullname INTO l_CFCUSTODYCD, l_cffullname
        FROM cfmast a, afmast f
        WHERE f.acctno = v_strRecord_Value
        and a.custodycd = f.custodycd;
    end if;
    IF v_strRecord_Key ='CODEID' and v_strParentObjName in ('FUND') THEN
        l_CCYUSAGE := v_strRecord_Value;
    elsif v_strRecord_Key ='CUSTID' and v_strParentObjName in ('CFMAST') THEN
        SELECT count (*) INTO l_count FROM cfmast WHERE custid =v_strRecord_Value;
            IF l_count > 0 THEN
              SELECT custodycd, fullname INTO l_CFCUSTODYCD, l_cffullname  FROM cfmast WHERE custid =v_strRecord_Value;

            END IF;

    --END IF;
    /*ELSIF v_strChildObjName  = 'FEEMASTER'  THEN
        SELECT FD.SYMBOL INTO  v_strRecord_Value_des FROM FEETYPE FT, FUND FD WHERE FT.ID = v_strRecord_Value
                       AND FT.CODEID = FD.CODEID;*/
    ELSIF  v_strChildObjName  = 'MEMBERS'  THEN
         v_strRecord_Value_des:='';
       -- SELECT M.MBCODEVSD INTO  v_strRecord_Value_des FROM MEMBERS M WHERE AUTOID = v_strChild_Record_Value;
    ELSIF  v_strChildObjName  = 'ROLES'  THEN
       /* SELECT M.MBCODEVSD ||' . '|| (SELECT a.cdcontent FROM ROLES R, ALLCODE A
        WHERE R.rolecode = A.CDVAL
        AND A.CDNAME ='ROLECODE' AND r.autoid =  v_strChild_Record_Value ) INTO  v_strRecord_Value_des
        FROM MEMBERS M WHERE AUTOID = v_strRecord_Value;*/
          v_strRecord_Value_des:='';

    elsif v_strChildObjName = 'TRADINGCYCLE' THEN
      SELECT FD.SYMBOL INTO  v_strRecord_Value_des FROM TRADINGCYCLE TC, FUND FD
      WHERE TC.CODEID = FD.CODEID
      AND TC.AUTOID = v_strRecord_Value;
    ELSE
        v_strRecord_Value_des:=v_strRecord_Value;
    END IF;

/*EXCEPTION
WHEN OTHERS
   THEN

   v_strRecord_Value_des:='';*/

   END ;




    --Build dien giai
   l_des :=l_actionflagname ||' ' || l_objtitle ||' . ' ||l_objtitle_child /*||fn_get_fullname_obj(v_strChild_Record_Key,  l_modulcode ||'.'||v_strChildObjName)*/
    ||' : ' ||v_strRecord_Value_des;

   l_currdate:=getcurrdate;
   v_strSQL := 'SELECT RQDSTRING FROM APPRVRQD WHERE OBJNAME = '''||l_tablename ||'''';
   l_rqdString :=txpks_maintain.fn_getvalFromSQL(v_strSQL,'RQDSTRING');

   v_strSQL := 'SELECT NVL(MAX(MOD_NUM),0) MODNUM FROM MAINTAIN_LOG WHERE TABLE_NAME = '''
   || v_strParentObjName ||''' AND RECORD_KEY = ''' || v_strRecord_Key
   ||''' AND RECORD_VALUE = ''' || v_strRecord_Value ||'''';

   l_modNum :=nvl(txpks_maintain.fn_getvalFromSQL(v_strSQL,'MODNUM'),'0');

   v_logSQL := 'BEGIN null; ';
   IF l_actionflag <>'DELETE' THEN
       l_fldname := p_objmsg.OBJFIELDS.FIRST;
       WHILE (l_fldname IS NOT NULL)
       LOOP
           l_fldval := p_objmsg.OBJFIELDS(l_fldname).value;
           l_fldtype := p_objmsg.OBJFIELDS(l_fldname).fldtype;
           l_fldoldval := p_objmsg.OBJFIELDS(l_fldname).oldval;

           IF upper(l_fldname) = 'SYMBOL' THEN
                l_CCYUSAGE := l_fldval;
                update objlog
                set CCYUSAGE = l_fldval
                where autoid = L_pautoid;
            end if;

           IF upper(l_fldname) = 'GRPID' AND v_strParentObjName = 'TLGROUPS' THEN
                v_strChild_Record_Value := l_fldval;
            end if;

            IF upper(l_fldname) = 'ACCTNO' and v_strParentObjName = 'LIMITS' THEN
                SELECT d.CUSTODYCD, d.FULLNAME
                INTO l_CFCUSTODYCD,l_cffullname
                FROM AFMAST c
                JOIN CFMAST d ON c.CUSTODYCD = d.CUSTODYCD
                WHERE c.ACCTNO = l_fldval;
            end if;
            IF upper(l_fldname) = 'AFACCTNO' and v_strParentObjName = 'PRODUCT' THEN
                SELECT d.CUSTODYCD, d.FULLNAME
                INTO l_CFCUSTODYCD,l_cffullname
                FROM AFMAST c
                JOIN CFMAST d ON c.CUSTODYCD = d.CUSTODYCD
                WHERE c.ACCTNO = l_fldval;
            end if;
       IF l_actionflag ='EDIT' THEN
            v_check := TRUE;
            --CHECK NEU LA SUA FUNDDTL MA LA QUY HUu tri
            /*SELECT COUNT(*) INTO v_count FROM fund WHERE codeid = v_strChild_Record_Value AND ftype = 'P';
            IF v_count > 0 THEN
                IF l_fldname IN ('ALLOCATEORD','AUTOODD','AUTOSELL','CHKSUPBANK','GENSWDAY','MAXAMT','MINAMT','SELLMAXQTTY','SELLMINQTTY','SWMAXQTTY','SWMINQTTY') then
                    v_check := FALSE;
                END IF;
            END IF;*/
         iF v_check then
               IF l_fldname = 'FLT' THEN
                IF l_fldval is not null THEN
                  l_fldoldval := replace(l_fldoldval,'''','''''');
                 END IF;
                END IF;

            IF  (case when l_fldtype = 'N' then to_char(to_number(nvl(l_fldoldval, '-1'))) else nvl(l_fldoldval,'#$*') end
                    <> case when l_fldtype = 'N' then to_char(to_number(nvl(l_fldval, '-1'))) else nvl(l_fldval,'#$*') end) THEN
            l_ISEDIT:= l_ISEDIT+1;
                v_logSQL := v_logSQL || ' INSERT INTO MAINTAIN_LOG(AUTOID,TABLE_NAME, RECORD_KEY,'
                            ||' RECORD_VALUE, MAKER_ID, MAKER_DT, APPROVE_RQD, COLUMN_NAME,'
                            ||' FROM_VALUE, TO_VALUE, MOD_NUM, ACTION_FLAG, CHILD_TABLE_NAME,'
                            ||' CHILD_RECORD_KEY, CHILD_RECORD_VALUE, MAKER_TIME,REFOBJID,COLUMN_TYPE) VALUES';
                v_logSQL := v_logSQL || ' (SEQ_MAINTAIN_LOG.NEXTVAL,'''|| v_strParentObjName || ''','''
                            || v_strRecord_Key || ''','''|| v_strRecord_Value || ''','''
                            || l_tlid || ''','''|| l_currdate ||''', ''Y';
                v_logSQL := v_logSQL || ''',''' || l_fldname || ''',''' || nvl(l_fldoldval,'')
                            || ''',''' || nvl(l_fldval,'') || ''',' ||to_char( to_number(l_modNum) + 1) || ', ''EDIT'','''
                            || nvl(v_strChildObjName,'') ||''', ''' || nvl(v_strChild_Record_Key,'')
                            || ''', ''' || nvl(v_strChild_Record_Value,'')  || ''','''|| TO_CHAR( SYSTIMESTAMP,'HH24:MI:SS')||''','|| l_refobjid ||','''|| l_fldtype ||''');';
            END IF;
         END IF;
       ELSIF l_actionflag ='ADD' THEN

                v_logSQL := v_logSQL || ' INSERT INTO MAINTAIN_LOG(AUTOID,TABLE_NAME, RECORD_KEY,'
                            ||' RECORD_VALUE, MAKER_ID, MAKER_DT, APPROVE_RQD, COLUMN_NAME,'
                            ||' FROM_VALUE, TO_VALUE, MOD_NUM, ACTION_FLAG, CHILD_TABLE_NAME,'
                            ||' CHILD_RECORD_KEY, CHILD_RECORD_VALUE, MAKER_TIME,REFOBJID,COLUMN_TYPE) VALUES';
                v_logSQL := v_logSQL || ' (SEQ_MAINTAIN_LOG.NEXTVAL,'''|| v_strParentObjName || ''','''
                            || v_strRecord_Key || ''','''|| v_strRecord_Value || ''','''
                            || l_tlid || ''','''|| l_currdate ||''', ''Y';
                v_logSQL := v_logSQL || ''',''' || l_fldname || ''',''' ||''
                            || ''',''' ||to_char( l_fldval) || ''',' || TO_CHAR( to_number(l_modNum) + 1) || ', ''ADD'','''
                            || v_strChildObjName ||''', ''' || v_strChild_Record_Key
                            || ''', ''' || v_strChild_Record_Value || ''','''|| TO_CHAR( SYSTIMESTAMP,'HH24:MI:SS')||''','|| l_refobjid ||','''|| l_fldtype ||''');';


       END IF;
       l_fldname := p_objmsg.OBJFIELDS.NEXT (l_fldname);
      END LOOP;
   ELSE --DELETE
            IF   v_strParentObjName = 'PRODUCT' THEN
                SELECT d.CUSTODYCD, d.FULLNAME
                INTO l_CFCUSTODYCD,l_cffullname
                FROM AFMAST c
                JOIN CFMAST d ON c.CUSTODYCD = d.CUSTODYCD
                WHERE c.ACCTNO IN (SELECT afacctno FROM PRODUCT WHERE AUTOID=v_strRecord_Value);
                SELECT SYMBOL INTO l_CCYUSAGE FROM PRODUCT WHERE AUTOID=v_strRecord_Value;
            end if;
            IF   v_strParentObjName = 'LIMITS' THEN
                SELECT d.CUSTODYCD, d.FULLNAME
                INTO l_CFCUSTODYCD,l_cffullname
                FROM AFMAST c
                JOIN CFMAST d ON c.CUSTODYCD = d.CUSTODYCD
                WHERE c.ACCTNO IN (SELECT ACCTNO FROM LIMITS l WHERE AUTOID = v_strRecord_Value);
                SELECT SYMBOL INTO l_CCYUSAGE  FROM LIMITS WHERE AUTOID = v_strRecord_Value;
            end if;
             IF   v_strParentObjName = 'OXINTRCURVE' THEN

                SELECT SYMBOL INTO l_CCYUSAGE FROM OXINTRCURVE WHERE AUTOID=v_strRecord_Value;
            end if;

       v_logSQL := v_logSQL || ' INSERT INTO MAINTAIN_LOG(AUTOID,TABLE_NAME, RECORD_KEY,'
                            ||' RECORD_VALUE, MAKER_ID, MAKER_DT, APPROVE_RQD, COLUMN_NAME,'
                            ||' FROM_VALUE, TO_VALUE, MOD_NUM, ACTION_FLAG, CHILD_TABLE_NAME,'
                            ||' CHILD_RECORD_KEY, CHILD_RECORD_VALUE, MAKER_TIME,REFOBJID,COLUMN_TYPE) VALUES';
                v_logSQL := v_logSQL || ' (SEQ_MAINTAIN_LOG.NEXTVAL,'''|| v_strParentObjName || ''','''
                            || v_strRecord_Key || ''','''|| v_strRecord_Value || ''','''
                            || l_tlid || ''','''|| l_currdate ||''', ''Y';
                v_logSQL := v_logSQL || ''',''' || v_strRecord_Key || ''',''' ||v_strRecord_Value
                            || ''','''',' ||to_char( to_number(l_modNum) + 1) || ', ''DELETE'','''
                            || nvl(v_strChildObjName,'') ||''', ''' || nvl(v_strChild_Record_Key,'')
                            || ''', ''' || nvl(v_strChild_Record_Value,'')  || ''','''|| TO_CHAR( SYSTIMESTAMP,'HH24:MI:SS')||''','|| l_refobjid ||','''|| l_fldtype ||''');';

       EXECUTE IMMEDIATE 'select count(*) FROM ' || v_strChildObjName || ' WHERE ' || v_strChildClause into l_count;


       EXECUTE IMMEDIATE 'select status FROM ' || v_strChildObjName || ' WHERE ' || v_strChildClause into l_status;
       if   v_strParentObjName <> 'CFMAST' THEN
       FOR rec in (select * from fldmaster
                    where UPPER(substr(objname, 4)) = UPPER(v_strParentObjName)
                    and visible = 'Y' and nvl(l_status, 'P') <> 'P'
                    and upper(fldname) <> upper(nvl(v_strChild_Record_Key, '#'))
                    order by odrnum)
       LOOP
            v_logSQLdel := v_logSQLdel || ' INSERT INTO MAINTAIN_LOG(AUTOID,TABLE_NAME, RECORD_KEY,'
                            ||' RECORD_VALUE, MAKER_ID, MAKER_DT, APPROVE_RQD, COLUMN_NAME,'
                            ||' FROM_VALUE, TO_VALUE, MOD_NUM, ACTION_FLAG, CHILD_TABLE_NAME,'
                            ||' CHILD_RECORD_KEY, CHILD_RECORD_VALUE, MAKER_TIME,REFOBJID,COLUMN_TYPE) ';
                v_logSQLdel := v_logSQLdel
                            || ' SELECT SEQ_MAINTAIN_LOG.NEXTVAL,'''
                            || v_strParentObjName || ''','''
                            || v_strRecord_Key || ''','''
                            || v_strRecord_Value || ''','''
                            || l_tlid || ''','''
                            || l_currdate ||''',''Y'
                            || ''','
                            || '''' || rec.fldname || ''''
                            || ','
                            || case when rec.datatype = 'D' then 'to_char(' || rec.fldname || ', ''DD/MM/YYYY'')' else '' || rec.fldname || '' end
                            || ','''','
                            ||to_char( to_number(l_modNum) + 1) || ',''DELETE'','''
                            || nvl(v_strChildObjName,'') ||''','''
                            || nvl(v_strChild_Record_Key,'') || ''','''
                            || nvl(v_strChild_Record_Value,'')  || ''','''
                            || TO_CHAR( SYSTIMESTAMP,'HH24:MI:SS')||''','
                            || to_char(nvl(l_refobjid , 1)) ||','''
                            || rec.datatype ||''' FROM '
                            || v_strParentObjName || ' WHERE '
                            || v_strChildClause || '; ';

            plog.debug (pkgctx, 'pong:' || v_logSQLdel);
       END LOOP;
       end if;
       v_logSQL := v_logSQL || v_logSQLdel;
   END IF;


   --Thuc hien
   v_logSQL := v_logSQL || ' END;';
    plog.error (pkgctx, 'v_logSQL:' || v_logSQL);
   EXECUTE IMMEDIATE v_logSQL;



  l_strSQL :=  'SELECT  COUNT (*)  FROM '||v_strChildObjName|| ' Where 0=0 and '||    v_strChild_Record_Key || ' = '|| '''' || v_strChild_Record_Value || '''' || ' AND status =''R''';

  plog.error (pkgctx, 'v_logSQL1:' || l_strSQL);


  BEGIN
      OPEN l_refcursor FOR l_strSQL;
        LOOP
            FETCH l_refcursor INTO l_count;
            EXIT WHEN l_refcursor%NOTFOUND;
        END LOOP;
        CLOSE l_refcursor;

  EXCEPTION
WHEN OTHERS
   THEN
   l_count:=0;
END ;


   SELECT COUNT (*) INTO l_count_pending  FROM objlog WHERE TXSTATUS ='4' AND  PARENTTABLE =v_strParentObjName
   AND  parentvalue = v_strRecord_Value AND  parentkey = v_strRecord_Key;

         plog.error (pkgctx, 'v_strParentObjName'||v_strParentObjName);
         plog.error (pkgctx, 'v_strRecord_Value'||v_strRecord_Value);
         plog.error (pkgctx, 'v_strRecord_Key'||v_strRecord_Key);
         plog.error (pkgctx, 'l_count_pending'||l_count_pending);
         plog.error (pkgctx, 'l_actionflag'||l_actionflag);
         plog.error (pkgctx, 'l_FunctionName'||l_FunctionName );

         if (l_actionflag = 'DELETE' and v_strParentObjName= 'PAYMENT_HIST') then
            select symbol into l_CCYUSAGE from PAYMENT_HIST where autoid = v_strRecord_Value ;
         end if;
  -- IF  (l_actionflag  = 'EDIT' AND l_ISEDIT >0  and l_count_pending >1) OR (l_actionflag  <> 'EDIT' AND  l_count_pending >1) THEN
  /*IF  (l_actionflag  = 'EDIT' AND l_ISEDIT >0  and l_count_pending >=1) OR (l_actionflag  <> 'EDIT' AND  l_count_pending >=1) THEN
  p_err_code := '-100997';
   plog.setendsection (pkgctx, 'fn_txPreAppCheck');
   RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;*/

   --Cap nhat du lieu vao Objlog
   IF ((l_actionflag  = 'EDIT' AND l_ISEDIT >0 ) OR l_actionflag  <> 'EDIT')    THEN
        INSERT INTO objlog(AUTOID,TXNUM,TXDATE,TXTIME,BRID,TLID,OFFID,OVRRQS,CHID,CHKID,TLTXCD,IBT,BRID2,TLID2,CCYUSAGE,OFF_LINE,DELTD,BRDATE,BUSDATE,TXDESC,IPADDRESS,WSNAME,TXSTATUS,MSGSTS,OVRSTS,BATCHNAME,MSGAMT,MSGACCT,CHKTIME,OFFTIME,CAREBYGRP,REFTXNUM,NAMENV,CFCUSTODYCD,CFFULLNAME,PTXSTATUS,LVEL,DSTATUS,LAST_LVEL,LAST_DSTATUS
        ,CHILDKEY,CHILDVALUE,CHILTABLE,PARENTKEY,PARENTVALUE,PARENTTABLE,MODULCODE,ACTIONFLAG,PAUTOID,cmdobjname)
        VALUES (l_refobjid,l_txnum,l_currdate ,TO_CHAR( CURRENT_TIMESTAMP,fn_systemnums('systemnums.c_time_format')), L_brid ,l_tlid,NULL,NULL,NULL,NULL, CASE WHEN l_actionflag='ADD' THEN '9999'WHEN l_actionflag='EDIT'THEN '9998'WHEN l_actionflag='DELETE'THEN '9997' END ,NULL,NULL,NULL,l_CCYUSAGE,'N','N',l_currdate,l_currdate,l_des,l_ipaddress,l_WSNAME,'4','0','0','DAY',0,v_strChild_Record_Value,TO_CHAR( CURRENT_TIMESTAMP,fn_systemnums('systemnums.c_time_format')),NULL,NULL,NULL,NULL,l_CFCUSTODYCD,l_cffullname,NULL,2,'C2',1,'C1'
        ,v_strChild_Record_Key,v_strChild_Record_Value,v_strChildObjName,v_strRecord_Key,v_strRecord_Value,v_strParentObjName,l_modulcode,l_actionflag,L_PAUTOID,p_objmsg.CMDOBJNAME);

       p_objmsg.txnum := l_txnum;
       p_objmsg.txdate := l_currdate;
       p_objmsg.objlogid := l_refobjid;
   END IF;

   --cac doan check duyet add sau
   plog.setendsection (pkgctx, 'fn_MaintainLog');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_MaintainLog');
      RAISE errnums.E_SYSTEM_ERROR;
END fn_MaintainLog;

FUNCTION fn_ProcessEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
l_count NUMBER;
l_strSQL varchar2(4000);
l_tablename VARCHAR2(100);
l_fldname varchar2(100);
l_fldval varchar2(4000);
l_fldtype varchar2(100);
l_updatetmp varchar2(4000);
l_upd varchar2(4000);
l_fldoldval varchar2(4000);
l_clause varchar2(1000);
l_refcursor pkg_report.ref_cursor;
pv_refcursor pkg_report.ref_cursor;
l_countp NUMBER;
l_counts NUMBER;
v_check BOOLEAN;
v_count NUMBER;

l_currdate date;
l_updatefld varchar2(3);
l_ADDATAPPR varchar2(1);
l_status varchar2(30);

l_err_param varchar2(1000);
l_objlog               objlog%rowtype;
l_objmsg               tx.obj_rectype;
BEGIN
   plog.setbeginsection (pkgctx, 'fn_ProcessEdit');
   /*l_tablename :=nvl( SUBSTR(p_objmsg.CHILDTABLE,4), SUBSTR(p_objmsg.OBJNAME,4));
   l_clause := p_objmsg.CLAUSE;
   l_count:=0;
   l_countp:=0;

   l_strSQL :=  'SELECT  COUNT (*)  FROM '||l_tablename|| ' Where 0=0 and '|| l_clause || ' AND status  IN (''P'',''R'') ';

  BEGIN
      OPEN l_refcursor FOR l_strSQL;
        LOOP
            FETCH l_refcursor INTO l_countp;
            EXIT WHEN l_refcursor%NOTFOUND;
        END LOOP;
        CLOSE l_refcursor;

  EXCEPTION
WHEN OTHERS
   THEN
   l_countp:=0;
END ;

IF l_count=1 THEN
   p_err_code := '-100026';
   plog.setendsection (pkgctx, 'fn_txPreAppCheck');
   RETURN errnums.C_BIZ_RULE_INVALID;
END IF;


   l_fldname := p_objmsg.OBJFIELDS.FIRST;
   WHILE (l_fldname IS NOT NULL)
   LOOP
    v_check := TRUE;
            --CHECK NEU LA SUA FUNDDTL MA LA QUY HUu tri
        l_strSQL :=  'SELECT  COUNT(*)  FROM FUND Where 0=0 and '|| l_clause || ' AND FTYPE = ''P'' ';

          BEGIN
              OPEN l_refcursor FOR l_strSQL;
                LOOP
                    FETCH l_refcursor INTO v_count;
                    EXIT WHEN l_refcursor%NOTFOUND;
                END LOOP;
                CLOSE l_refcursor;
          EXCEPTION
          WHEN OTHERS
           THEN
           v_count:=0;
          END ;

          IF v_count > 0 THEN
                IF l_fldname IN ('ALLOCATEORD','AUTOODD','AUTOSELL','CHKSUPBANK','GENSWDAY','MAXAMT','MINAMT','SELLMAXQTTY','SELLMINQTTY','SWMAXQTTY','SWMINQTTY') then
                    v_check := FALSE;
                END IF;
          END IF;
   IF v_check then
       l_fldval := p_objmsg.OBJFIELDS(l_fldname).value;
       l_fldtype := p_objmsg.OBJFIELDS(l_fldname).fldtype;
       l_fldoldval := p_objmsg.OBJFIELDS(l_fldname).oldval;
        PLOG.error(PKGCTX, 'NAMNT TEST3'||l_tablename);
       IF l_fldname = 'FLT' AND l_tablename = 'FEEAPPLY' THEN
          l_fldoldval := replace(l_fldoldval,'''','''''');
       END IF;
       IF  (nvl(l_fldoldval,'#$*') <> nvl(l_fldval,'#$*')) THEN
          l_count:=l_count+1;
       END IF;
    END IF;
       l_fldname := p_objmsg.OBJFIELDS.NEXT (l_fldname);
   END LOOP;
   -- neu ko sua thong tin gi ma van bam chap nhan thi khong chay cau lenh sql
   IF l_count>0 THEN

   IF l_countp=1 THEN
   p_err_code := '-100026';
   plog.setendsection (pkgctx, 'fn_txPreAppCheck');
   RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;

   l_strSQL := 'update '|| l_tablename ||' set STATUS = ''J'', PSTATUS =PSTATUS|| STATUS  WHERE 0=0 AND ' || l_clause ;
     EXECUTE IMMEDIATE l_strSQL;
   END IF;*/

   l_tablename := SUBSTR(p_objmsg.OBJNAME,4);
   l_clause := p_objmsg.CLAUSE;
   if l_clause like 'AUTOID =%' then
        l_clause := replace(l_clause,'AUTOID =','AUTOID =');
   elsif l_clause like 'ID =%' then
        l_clause := replace(l_clause,'ID =','ID =');
   end if;
   l_count:=0;
   l_currdate := GETCURRDATE();

   l_strSQL :=  'SELECT  COUNT (*)  FROM '||l_tablename|| ' Where 0=0 and '|| l_clause || ' AND status  IN (''R'') ';

  BEGIN
      OPEN l_refcursor FOR l_strSQL;
        LOOP
            FETCH l_refcursor INTO l_countp;
            EXIT WHEN l_refcursor%NOTFOUND;
        END LOOP;
        CLOSE l_refcursor;

  EXCEPTION
WHEN OTHERS
   THEN
   l_countp:=0;
END ;

IF l_countp>0 THEN
   p_err_code := '-100026';
   plog.setendsection (pkgctx, 'fn_ProcessEdit');
   RETURN errnums.C_BIZ_RULE_INVALID;
END IF;

   l_strSQL := 'SELECT ADDATAPPR FROM APPRVRQD WHERE OBJNAME = '''|| l_tablename ||'''';
   EXECUTE IMMEDIATE l_strSQL INTO l_ADDATAPPR;

   l_fldname := p_objmsg.OBJFIELDS.FIRST;
   WHILE (l_fldname IS NOT NULL)
   LOOP
    v_check := TRUE;
   IF v_check then
       l_fldval := p_objmsg.OBJFIELDS(l_fldname).value;
       l_fldtype := p_objmsg.OBJFIELDS(l_fldname).fldtype;
       l_fldoldval := p_objmsg.OBJFIELDS(l_fldname).oldval;
       l_updatefld := nvl(p_objmsg.OBJFIELDS(l_fldname).updatefld,'Y');

       IF length(l_fldname) > 0 and l_updatefld <> 'N' THEN
            IF l_fldname = 'FLT' AND l_tablename = 'FEEAPPLY' THEN
              l_fldoldval := replace(l_fldoldval,'''','''''');
           END IF;
           IF (l_fldtype = 'N' and TO_NUMBER(nvl(l_fldoldval,'-999999999999999999999')) <> TO_NUMBER(nvl(l_fldval,'-999999999999999999999'))) or (l_fldtype  <> 'N' and nvl(l_fldoldval,'#$*') <> nvl(l_fldval,'#$*')) THEN
                    IF l_fldtype ='C' THEN
                        l_updatetmp := l_fldname || ' = ''' || nvl(Replace(l_fldval,'''', ''''''),'') ||'''';
                    ELSIF l_fldtype ='N' THEN
                        if l_fldval is not null then
                            l_updatetmp := l_fldname || ' = ' || REPLACE(l_fldval,',','');
                            else
                            l_updatetmp := l_fldname || ' = ''''';
                        end if;
                    ELSIF l_fldtype ='D' THEN
                        if length(l_fldval) >0 then
                            l_updatetmp := l_fldname || ' = to_date(''' || l_fldval ||''',''DD/MM/YYYY'')';
                        else
                            l_updatetmp := l_fldname||' = null';
                        end if;
                    ELSE
                        l_updatetmp := l_fldname || ' = ''' || nvl(l_fldval,'') ||'''';
                    END IF;

                    IF l_upd IS NULL OR LENGTH(l_upd) = 0 THEN
                        l_upd :=l_updatetmp;
                    ELSE
                        l_upd := l_upd || ',' ||l_updatetmp;
                    END IF;
               l_count:=l_count+1;
           END IF;
        END IF;
    END IF;
       l_fldname := p_objmsg.OBJFIELDS.NEXT (l_fldname);
   END LOOP;


   -- neu ko sua thong tin gi ma van bam chap nhan thi khong chay cau lenh sql
   IF l_count>0 THEN
        l_strSQL := 'SELECT COUNT(*) FROM (SELECT case when status = ''A'' or pstatus like ''%A%'' then ''A'' end status FROM '|| l_tablename ||' where ' || l_clause||')';
       --plog.debug(pkgctx, 'l_strSQL = ' || l_strSQL);
       EXECUTE immediate l_strSQL INTO l_counts;
       l_strSQL := 'SELECT case when status = ''A'' or pstatus like ''%A%'' then ''A'' end status FROM '|| l_tablename ||' where ' || l_clause;
       --plog.debug(pkgctx, 'l_strSQL = ' || l_strSQL);
       if l_counts > 0 then
        EXECUTE immediate l_strSQL INTO l_status;
       else
        l_status := null;
       end if;
        IF nvl(l_ADDATAPPR,'N') ='N' or (nvl(l_status, '$') <> 'A' /*and l_tablename <> 'ASSETDTL'*/) THEN
            l_strSQL := 'UPDATE '||l_tablename|| ' SET ' || l_upd || ' WHERE 0 = 0 AND ' || l_clause;
            plog.debug(pkgctx, 'l_strSQL UPDATE = ' || l_strSQL);
            EXECUTE immediate l_strSQL;



            --Cap nhat trang thai hoan thanh Maintain_log
            UPDATE MAINTAIN_LOG
            SET APPROVE_ID = p_objmsg.TLID,
                APPROVE_DT = l_currdate,
                APPROVE_TIME = TO_CHAR( CURRENT_TIMESTAMP,'HH24:MI:SS'),
                LAST_CHANGE = CURRENT_TIMESTAMP
            WHERE REFOBJID = p_objmsg.objlogid;
            l_strSQL:= ' insert into maintain_log
            select
                seq_maintain_log.nextval autoid,
                a.table_name,
                a.record_key,
                a.record_value,
                a.child_table_name,
                a.child_record_key,
                a.child_record_value,
                a.action_flag,
                a.mod_num,
                a.column_name,
                a.from_value,
                a.to_value,
                a.maker_id,
                a.maker_dt,
                a.maker_time,
                a.approve_rqd,
                a.approve_id,
                a.approve_dt,
                a.approve_time,
                a.last_change,
                a.deltd,
                b.autoid refobjid,
                a.column_type,
                a.updatefld
            from maintain_log a
            inner join
                (select autoid from objlog
                WHERE (chiltable, childkey, childvalue) = (select chiltable, childkey, childvalue from objlog where autoid = p_objmsg.objlogid)
                and actionflag =''ADD'' and TXSTATUS =''4'' AND DELTD =''N'') b
                on 1=1
             where refobjid = '||p_objmsg.objlogid;
            plog.debug(pkgctx, 'l_strSQL UPDATE = ' || l_strSQL);
            insert into maintain_log
            select
                seq_maintain_log.nextval autoid,
                a.table_name,
                a.record_key,
                a.record_value,
                a.child_table_name,
                a.child_record_key,
                a.child_record_value,
                a.action_flag,
                a.mod_num,
                a.column_name,
                a.from_value,
                a.to_value,
                a.maker_id,
                a.maker_dt,
                a.maker_time,
                a.approve_rqd,
                a.approve_id,
                a.approve_dt,
                a.approve_time,
                a.last_change,
                a.deltd,
                b.autoid refobjid,
                a.column_type,
                a.updatefld
            from maintain_log a
            inner join
                (select autoid from objlog
                WHERE (chiltable, childkey, childvalue) = (select chiltable, childkey, childvalue from objlog where autoid = p_objmsg.objlogid)
                and actionflag ='ADD' and TXSTATUS ='4' AND DELTD ='N') b
                on 1=1
             where refobjid = p_objmsg.objlogid;

             /*select count(1) into v_count from objlog
               where txnum=p_objmsg.txnum and txdate = p_objmsg.txdate;

               OPEN pv_refcursor FOR
               select * from objlog
               where txnum=p_objmsg.txnum and txdate = p_objmsg.txdate;
               LOOP
                   FETCH pv_refcursor
                   INTO l_objlog;
                   EXIT WHEN pv_refcursor%NOTFOUND;

                   if l_objlog.deltd='Y' then
                       p_err_code:= errnums.C_SA_CANNOT_DELETETRANSACTION;
                       l_err_param  := fn_get_errmsg(p_err_code);
                       RETURN p_err_code;
                   end if;
                   plog.error(pkgctx,'fn_ProcessEdit ' || p_objmsg.txnum);
                   l_objmsg.txdate := p_objmsg.txdate;
                   l_objmsg.txnum := p_objmsg.txnum;
                   l_objmsg.TLID := p_objmsg.TLID;
                   l_objmsg.CMDOBJNAME := l_objlog.CMDOBJNAME;
                   l_objmsg.ACTIONFLAG := 'APPROVE_OBJLOG';
                   l_objmsg.language := fn_systemnums('systemnums.vn_lang');
                   l_objmsg.OBJNAME := upper(l_objlog.MODULCODE||'.'||l_objlog.CHILTABLE);
                   l_objmsg.CHILDTABLE := upper(l_objlog.MODULCODE||'.'||l_objlog.CHILTABLE);
                   l_objmsg.AUTOID := upper('N');
                   l_objmsg.CLAUSE := l_objlog.autoid;
                   l_objmsg.objlogID := l_objlog.autoid;
                   select mbid into l_objmsg.MBID from tlprofiles where tlid = p_objmsg.TLID;
                   l_objmsg.parentobjname := upper(l_objlog.MODULCODE||'.'||l_objlog.PARENTTABLE);
                   l_objmsg.parentclause := upper(l_objlog.PARENTKEY ||' = '''||l_objlog.PARENTVALUE||'''');

                    --Tu dong duyet
                    IF txpks_obj.fn_transfer(l_objmsg, p_err_code, l_err_param) <> fn_systemnums('systemnums.C_SUCCESS') THEN
                         plog.error(pkgctx,'fn_ProcessEdit.fn_transfer.Error: p_err_code=' ||p_err_code || ', p_err_param=' || l_err_param);
                         plog.setendsection (pkgctx, 'fn_ProcessEdit');
                         return p_err_code;
                    END IF;

                END LOOP;*/

                --Cap nhat trang thai objlog la hoan tat
                UPDATE objlog
                SET  txstatus ='1',
                    OFFID = p_objmsg.TLID,
                    OFFTIME = TO_CHAR( CURRENT_TIMESTAMP,'HH24:MI:SS'),
                    deltd = case when nvl(l_status, '$') <> 'A' then 'Y' else 'N' end
                WHERE AUTOID = p_objmsg.objlogid;

            ELSE
            l_strSQL := 'update '|| l_tablename ||' set PSTATUS = nvl(PSTATUS,'''') || STATUS, STATUS = case when nvl(PSTATUS, ''P'') like ''%A%'' OR STATUS = ''A'' THEN ''J'' else ''P'' end, LASTCHANGE = CURRENT_TIMESTAMP  WHERE 0=0 AND ' || l_clause;
            plog.error(pkgctx, 'txpks_maintain_fn_processedit.l_strSQL='||l_strSQL);
            EXECUTE immediate l_strSQL;

            --Cap nhat du lieu vao bang memo
            l_count := 0;
            l_strSQL := 'select count(*)  from '|| l_tablename ||'memo where 0=0 and '|| l_clause;
            EXECUTE immediate l_strSQL into l_count;

            if nvl(l_count,0) = 0 then
                l_strSQL := 'insert into '|| l_tablename ||'memo select * from '|| l_tablename ||' where 0=0 and '|| l_clause;
                plog.debug(pkgctx,'LOG====>:l_strSQL ' || l_strSQL);
                plog.error(pkgctx, 'txpks_maintain_fn_processedit.l_strSQL='||l_strSQL);
                EXECUTE immediate l_strSQL;
            end if;
            --perform plog.error('l_tablename='||l_tablename||'memo, l_upd='||nvl(l_upd,'')||', l_clause='||l_clause);
            IF l_upd <> '' OR l_upd IS NOT NULL OR LENGTH(l_upd) <> 0 THEN
                l_strSQL := 'UPDATE '||l_tablename|| 'memo SET ' || l_upd || ' WHERE 0 = 0 AND ' || l_clause;
                plog.error(pkgctx, 'txpks_maintain_fn_processedit.l_strSQL='||l_strSQL);
                EXECUTE immediate l_strSQL;
            END IF;


        END IF;

   END IF;

   plog.setendsection (pkgctx, 'fn_ProcessEdit');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessEdit');
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessEdit;

FUNCTION fn_ProcessDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
l_count NUMBER;
l_strSQL varchar2(30000);
l_strSQL2 varchar2(30000);
l_tablename VARCHAR2(100);
l_clause varchar2(1000);
l_clause2 varchar2(1000);
l_refcursor pkg_report.ref_cursor;
v_strRecord_Value varchar2(1000);
 v_strRecord_Key varchar2(1000);

l_ADDATAPPR varchar2(1);
l_status    varchar2(200);
l_currdate  date;
l_txnum     varchar2(50);
l_txdate        date;
BEGIN
   plog.setbeginsection (pkgctx, 'fn_ProcessDelete');
   /*l_tablename :=nvl( SUBSTR(p_objmsg.CHILDTABLE,4), SUBSTR(p_objmsg.OBJNAME,4));
  -- l_tablename := SUBSTR(p_objmsg.OBJNAME,4);
   l_clause := p_objmsg.CLAUSE;
    PLOG.error(PKGCTX, 'BINHVT22'||l_clause);
--check neu cho duyet sua khong cho xoa

 IF  length(l_clause) <> 0 THEN
        v_strRecord_Key := Trim(substr(l_clause,1, InStr(l_clause, '=')-1));
        v_strRecord_Value := Trim(substr(l_clause,InStr(l_clause, '=') +1));
        v_strRecord_Value := REPLACE(v_strRecord_Value,'''','');
 ELSE
        v_strRecord_Key := '';
        v_strRecord_Value := '';
 END IF;
  l_strSQL :=  'SELECT  COUNT (*)  FROM '||l_tablename|| ' Where 0=0 and '||  v_strRecord_Key || ' = '|| '''' || v_strRecord_Value || '''' || ' AND status =''J''';

  BEGIN
      OPEN l_refcursor FOR l_strSQL;
        LOOP
            FETCH l_refcursor INTO l_count;
            EXIT WHEN l_refcursor%NOTFOUND;
        END LOOP;
        CLOSE l_refcursor;

  EXCEPTION
WHEN OTHERS
   THEN
   l_count:=0;
END ;

IF l_count=1 THEN
   p_err_code := '-100025';
   plog.setendsection (pkgctx, 'fn_txPreAppCheck');
   RETURN errnums.C_BIZ_RULE_INVALID;
END IF;




  l_strSQL :=  'SELECT  COUNT (*)  FROM '||l_tablename|| ' Where 0=0 and '||  v_strRecord_Key || ' = '|| '''' || v_strRecord_Value || '''' || ' AND status =''P''';

  BEGIN
      OPEN l_refcursor FOR l_strSQL;
        LOOP
            FETCH l_refcursor INTO l_count;
            EXIT WHEN l_refcursor%NOTFOUND;
        END LOOP;
        CLOSE l_refcursor;

  EXCEPTION
WHEN OTHERS
   THEN
   l_count:=0;
END ;

     plog.error (pkgctx, 'l_count:' || l_count || 'l_tablename: ' || l_tablename || 'l_clause' ||l_clause);

 IF l_count=1 THEN
    l_strSQL := 'Delete '|| l_tablename ||' WHERE status =''P'' and  ' ||  v_strRecord_Key || ' = '|| '''' || v_strRecord_Value || '''' ;
     plog.error (pkgctx, 'l_strSQL2:' || l_strSQL);
     EXECUTE IMMEDIATE l_strSQL;

    --v_strRecord_Value := Trim(substr(l_clause,InStr(l_clause, '=') +1));
    PLOG.error(PKGCTX, 'NAMNT camast'||v_strRecord_Value);
   l_strSQL := 'Delete  OBJLOG  WHERE txstatus =''4'' AND chiltable ='''||l_tablename ||''' and actionflag =''ADD'' AND childvalue   = '|| '''' || v_strRecord_Value || '''';
   plog.error (pkgctx, 'l_strSQL3:' || v_strRecord_Value || l_strSQL);
    EXECUTE IMMEDIATE l_strSQL;

  ELSE
   l_strSQL := 'update '|| l_tablename ||' set STATUS = ''R'', PSTATUS =PSTATUS|| STATUS  WHERE 0=0 AND ' ||   v_strRecord_Key || ' = '|| '''' || v_strRecord_Value || '''' ;
   plog.error (pkgctx, 'l_strSQL4:' || l_strSQL);
    EXECUTE IMMEDIATE l_strSQL;
END IF;*/
   l_tablename := SUBSTR(p_objmsg.OBJNAME,4);
   l_clause := p_objmsg.CLAUSE;
   if l_clause like 'AUTOID =%' then
        l_clause := replace(l_clause,'AUTOID =','AUTOID =');
   elsif l_clause like 'ID =%' then
        l_clause := replace(l_clause,'ID =','ID =');
   end if;
   l_currdate := GETCURRDATE();
 l_strSQL :=  'SELECT  COUNT (*)  FROM '||l_tablename|| ' Where 0=0 and '||  l_clause || ' AND status in(''J'')';

  BEGIN
      OPEN l_refcursor FOR l_strSQL;
        LOOP
            FETCH l_refcursor INTO l_count;
            EXIT WHEN l_refcursor%NOTFOUND;
        END LOOP;
        CLOSE l_refcursor;

  EXCEPTION
WHEN OTHERS
   THEN
   l_count:=0;
END ;

IF l_count=1 THEN
   p_err_code := '-100025';
   plog.setendsection (pkgctx, 'fn_ProcessDelete');
   RETURN errnums.C_BIZ_RULE_INVALID;
END IF;

   l_strSQL :=  'SELECT  COUNT (*)  FROM '||l_tablename|| ' Where 0=0 and '||  l_clause || ' AND status in(''R'')';

  BEGIN
      OPEN l_refcursor FOR l_strSQL;
        LOOP
            FETCH l_refcursor INTO l_count;
            EXIT WHEN l_refcursor%NOTFOUND;
        END LOOP;
        CLOSE l_refcursor;

  EXCEPTION
WHEN OTHERS
   THEN
   l_count:=0;
END ;

IF l_count=1 THEN
   p_err_code := '-100027';
   plog.setendsection (pkgctx, 'fn_ProcessDelete');
   RETURN errnums.C_BIZ_RULE_INVALID;
END IF;

   l_strSQL := 'SELECT delatappr FROM APPRVRQD WHERE OBJNAME = '''|| l_tablename ||'''';
   EXECUTE IMMEDIATE l_strSQL INTO l_ADDATAPPR;

   l_strSQL := 'SELECT case when status = ''A'' or pstatus like ''%A%'' then ''A'' end status FROM '|| l_tablename ||' where ' || l_clause;
   EXECUTE IMMEDIATE l_strSQL INTO l_status;

   IF nvl(l_ADDATAPPR,'N') ='N' or nvl(l_status, '#') <> 'A' THEN
        l_strSQL := 'DELETE FROM ' || l_tablename || ' WHERE 0 = 0 AND ' || l_clause;
        IF l_tablename = 'PRODUCT' THEN
            DELETE FROM PRODUCTSELLDTL p2 WHERE id = replace(substr(l_clause, 10), '''');
            DELETE FROM PRODUCTBUYDTL p2 WHERE id = replace(substr(l_clause, 10), '''');
            plog.debug(pkgctx, 'pong: '||replace(substr(l_clause, 10), ''''));
        END IF;
        IF l_tablename = 'OXINTRCURVE' THEN
            DELETE FROM curve_selldtl p2 WHERE id = replace(substr(l_clause, 10), '''');
            DELETE FROM curve_buydtl p2 WHERE id = replace(substr(l_clause, 10), '''');
            plog.debug(pkgctx, 'pong: '||replace(substr(l_clause, 10), ''''));
        END IF;
        EXECUTE IMMEDIATE l_strSQL;

        --Cap nhat trang thai objlog la hoan tat
        UPDATE objlog
        SET  txstatus ='1',
            OFFID = p_objmsg.TLID,
            OFFTIME = TO_CHAR( CURRENT_TIMESTAMP,'HH24:MI:SS')
        WHERE AUTOID = p_objmsg.objlogid;

        --Cap nhat trang thai hoan thanh Maintain_log
        UPDATE MAINTAIN_LOG
        SET APPROVE_ID = p_objmsg.TLID,
            APPROVE_DT = l_currdate,
            APPROVE_TIME = TO_CHAR( CURRENT_TIMESTAMP,'HH24:MI:SS'),
            LAST_CHANGE = CURRENT_TIMESTAMP
        WHERE REFOBJID = p_objmsg.objlogid;

        select count(*) into l_count from objlog
        WHERE (chiltable, childkey, childvalue) in (select chiltable, childkey, childvalue from objlog where autoid = p_objmsg.objlogid)
        and actionflag ='ADD' and TXSTATUS ='4' AND DELTD ='N';

        if l_count > 0 then
             select txnum, txdate into l_txnum, l_txdate
            from objlog
            WHERE (chiltable, childkey, childvalue) in (select chiltable, childkey, childvalue from objlog where autoid = p_objmsg.objlogid)
            and actionflag ='ADD' and TXSTATUS ='4' AND DELTD ='N';
        else
            l_txnum := null;
            l_txdate := null;
        end if;


        UPDATE objlog
        SET  txstatus ='5',
            OFFID = p_objmsg.TLID,
            OFFTIME = TO_CHAR( CURRENT_TIMESTAMP,'HH24:MI:SS')
        WHERE (chiltable, childkey, childvalue) = (select chiltable, childkey, childvalue from objlog where autoid = p_objmsg.objlogid)
        and actionflag ='ADD' and TXSTATUS ='4' AND DELTD ='N';



        txpks_notify.prc_system_logevent('OBJLOG', 'TRANS',
                            'ALL' || '~#~' ||
                            l_txnum || '~#~' ||
                            to_char(l_txdate, 'DD/MM/YYYY')
                            ,'R','UPDATE OBJLOG');
   ELSE
        l_strSQL := 'UPDATE '|| l_tablename ||' SET STATUS = ''R'', PSTATUS = nvl(PSTATUS,'''') || STATUS  WHERE 0=0 AND ' || l_clause;

        EXECUTE IMMEDIATE l_strSQL;
   END IF;

--27/01/2021 - han them
-- exception
   if l_tablename = 'TLPROFILES'
      then
        l_strSQL := 'delete from ' || 'TLGRPUSERS' || ' where ' || l_clause;
        plog.error (pkgctx, 'l_strSQL ISSUERS:' || l_strSQL);
        EXECUTE immediate l_strSQL;
    end if;


    if l_tablename = 'TLGROUPS'
      then
        l_strSQL := 'delete from ' || 'TLGRPUSERS' || ' where ' || l_clause;
        plog.error (pkgctx, 'l_strSQL TLGRPUSERS:' || l_strSQL);
        EXECUTE immediate l_strSQL;
         l_clause := replace(l_clause,'GRPID =','AUTHID =');
         l_strSQL := 'delete from ' || 'CMDAUTH' || ' where ' || l_clause;
        plog.error (pkgctx, 'l_strSQL CMDAUTH:' || l_strSQL);
        EXECUTE immediate l_strSQL;
    end if;
-- end

   plog.setendsection (pkgctx, 'fn_ProcessDelete');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessDelete');
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessDelete;

BEGIN
      FOR i IN (SELECT *
                FROM tlogdebug)
      LOOP
         logrow.loglevel    := i.loglevel;
         logrow.log4table   := i.log4table;
         logrow.log4alert   := i.log4alert;
         logrow.log4trace   := i.log4trace;
      END LOOP;
      pkgctx    :=
         plog.init ('txpks_maintain',
                    plevel => NVL(logrow.loglevel,30),
                    plogtable => (NVL(logrow.log4table,'N') = 'Y'),
                    palert => (NVL(logrow.log4alert,'N') = 'Y'),
                    ptrace => (NVL(logrow.log4trace,'N') = 'Y')
            );
END txpks_maintain;
/

DROP PACKAGE txpks_msg
/

CREATE OR REPLACE 
PACKAGE txpks_msg 
is
 /*----------------------------------------------------------------------------------------------------
     ** Module   : COMMODITY SYSTEM
     ** and is copyrighted by FSS.
     **
     **    All rights reserved.  No part of this work may be reproduced, stored in a retrieval system,
     **    adopted or transmitted in any form or by any means, electronic, mechanical, photographic,
     **    graphic, optic recording or otherwise, translated in any language or computer language,
     **    without the prior written permission of Financial Software Solutions. JSC.
     **
     **  MODIFICATION HISTORY
     **  Person      Date           Comments
     **  TienPQ      09-JUNE-2009    Created
     ** (c) 2009 by Financial Software Solutions. JSC.
     ----------------------------------------------------------------------------------------------------*/

    FUNCTION fn_obj2xml(p_txmsg tx.msg_rectype)
    RETURN VARCHAR2;

    FUNCTION fn_xml2obj(p_xmlmsg    VARCHAR2)
    RETURN tx.msg_rectype;

    FUNCTION fn_mt_obj2xml(p_txmsg tx.obj_rectype) return varchar2;

    FUNCTION fn_mt_xml2obj(p_xmlmsg    VARCHAR2) return tx.obj_rectype;

    FUNCTION fn_build_objxmldata(p_txmsg IN tx.obj_rectype, pv_refcursor  IN  pkg_report.ref_cursor) RETURN VARCHAR2;
END;
/

CREATE OR REPLACE 
PACKAGE BODY txpks_msg IS
  pkgctx plog.log_ctx;
  logrow tlogdebug%ROWTYPE;

FUNCTION fn_build_objxmldata(
    p_txmsg IN  tx.obj_rectype,
    pv_refcursor   IN  pkg_report.ref_cursor
    ) RETURN VARCHAR2
IS
--  Build objxmldata from ref cursor
-- ---------   ------  -------------------------------------------
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
    l_fldname varchar2(100);
    l_fldval varchar2(1000);
    l_fldtype varchar2(100);
BEGIN
    plog.setbeginsection(pkgctx, 'fn_build_objxmldata');
    --1. Add header msg
    l_parser              := xmlparser.newparser;
    xmlparser.parsebuffer (l_parser, '<ObjectMessage/>');
    l_doc            := xmlparser.getdocument (l_parser);
    docnode        := xmldom.makenode (l_doc);
    l_element := xmldom.getdocumentelement(l_doc);
    xmldom.setattribute (l_element, 'TXDATE', p_txmsg.TXDATE);
    xmldom.setattribute (l_element, 'TXNUM', p_txmsg.TXNUM);
    xmldom.setattribute (l_element, 'TXTIME', p_txmsg.TXTIME);
    xmldom.setattribute (l_element, 'TLID', p_txmsg.TLID);
    xmldom.setattribute (l_element, 'MBID', p_txmsg.MBID);
    xmldom.setattribute (l_element, 'LOCAL', p_txmsg.LOCAL);
    xmldom.setattribute (l_element, 'MSGTYPE', p_txmsg.MSGTYPE);
    xmldom.setattribute (l_element, 'OBJNAME', p_txmsg.OBJNAME);
    xmldom.setattribute (l_element, 'ACTIONFLAG', p_txmsg.ACTIONFLAG);
    xmldom.setattribute (l_element, 'CMDINQUIRY', p_txmsg.CMDINQUIRY);
    xmldom.setattribute (l_element, 'CLAUSE', p_txmsg.CLAUSE);
    xmldom.setattribute (l_element, 'FUNCTIONNAME', p_txmsg.FUNCTIONNAME);
    xmldom.setattribute (l_element, 'AUTOID', p_txmsg.AUTOID);
    xmldom.setattribute (l_element, 'REFERENCE', p_txmsg.REFERENCE);
    xmldom.setattribute (l_element, 'RESERVER', p_txmsg.RESERVER);
    xmldom.setattribute (l_element, 'IPADDRESS', p_txmsg.IPADDRESS);
    xmldom.setattribute (l_element, 'CMDTYPE', p_txmsg.CMDTYPE);
    xmldom.setattribute (l_element, 'PARENTOBJNAME', p_txmsg.PARENTOBJNAME);
    xmldom.setattribute (l_element, 'PARENTCLAUSE', p_txmsg.PARENTCLAUSE);
    xmldom.setattribute (l_element, 'SESSIONID', p_txmsg.SESSIONID);
    xmldom.setattribute (l_element, 'REQUESTID', p_txmsg.REQUESTID);
    headernode   := xmldom.appendchild (docnode, xmldom.makenode (l_element));
    --2. Add objdata from cursor
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
        l_element             := xmldom.createelement (l_doc, 'ObjData');
        childnode    := xmldom.appendchild (headernode, xmldom.makenode (l_element));
        FOR i IN 1 .. v_desc_tab.COUNT LOOP
              l_fldname :=  v_desc_tab(i).col_name;
              IF v_desc_tab(i).col_type = dbms_types.typecode_number THEN
              --Number
                    dbms_sql.column_value(v_cursor_number, i, v_number_value);
                    plog.error (pkgctx, 'v_number_value:'||i ||':' ||v_number_value);
                    l_fldval :=to_char(v_number_value);
                    l_fldtype :='System.Decimal';
              END IF;
              IF v_desc_tab(i).col_type = dbms_types.typecode_varchar
                OR  v_desc_tab(i).col_type = dbms_types.typecode_char
                THEN
              --Varchar, char
                    dbms_sql.column_value(v_cursor_number, i, v_varchar_value);
                     plog.error (pkgctx, 'v_varchar_value:'||i ||':' ||v_varchar_value);
                    l_fldval := v_varchar_value;
                    l_fldtype :='System.String';
              END IF;
              IF v_desc_tab(i).col_type = dbms_types.typecode_date
                THEN
              --Date
                    dbms_sql.column_value(v_cursor_number, i, v_date_value);
                     plog.error (pkgctx, 'v_date_value:'||i ||':' ||to_char(v_date_value,'DD/MM/RRRR'));
                    l_fldval := to_char(v_date_value,'DD/MM/RRRR');
                    l_fldtype :='System.DateTime';
              END IF;
              l_element := xmldom.createelement (l_doc, 'Entry');
              xmldom.setattribute (l_element, 'fldname', l_fldname);
              xmldom.setattribute (l_element, 'fldtype', l_fldtype);
              xmldom.setattribute (l_element, 'oldval', '');

              entrynode   := xmldom.appendchild (childnode, xmldom.makenode(l_element));
              textnode := xmldom.createTextNode(l_doc, l_fldval);
              entrynode := xmldom.appendChild(entrynode, xmldom.makeNode(textnode));
        END LOOP;
    END LOOP;
    dbms_sql.close_cursor(v_cursor_number);
    xmldom.writetobuffer (l_doc, temp1);

    plog.setendsection(pkgctx, 'fn_build_objxmldata');
    return temp1;

EXCEPTION WHEN OTHERS THEN
    plog.error(pkgctx,SQLERRM);
    plog.error (pkgctx, 'Loi tai dong: ' || dbms_utility.format_error_backtrace);
    plog.setendsection(pkgctx, 'fn_build_objxmldata');
    RAISE errnums.E_SYSTEM_ERROR;

END;

  FUNCTION fn_xml2obj(p_xmlmsg    VARCHAR2) RETURN tx.msg_rectype IS
    l_parser   xmlparser.parser;
    l_doc      xmldom.domdocument;
    l_nodeList xmldom.domnodelist;
    l_node     xmldom.domnode;

    l_fldname fldmaster.fldname%TYPE;
    l_txmsg   tx.msg_rectype;
  BEGIN
    plog.setbeginsection (pkgctx, 'fn_xml2obj');

    --plog.debug(pkgctx,'msg length: ' || length(p_xmlmsg));
    l_parser := xmlparser.newparser();
    --plog.debug(pkgctx,'1');
    xmlparser.parseclob(l_parser, p_xmlmsg);
    --plog.debug(pkgctx,'2');
    l_doc := xmlparser.getdocument(l_parser);
    --plog.debug(pkgctx,'3');
    xmlparser.freeparser(l_parser);

    --plog.debug(pkgctx,'Prepare to parse Message Header');
    l_nodeList := xslprocessor.selectnodes(xmldom.makenode(l_doc),
                                           '/TransactMessage');
    --<<Begin of header transformation>>
    FOR i IN 0 .. xmldom.getlength(l_nodeList) - 1 LOOP
      --plog.debug(pkgctx,'parse header i: ' || i);
      l_node         := xmldom.item(l_nodeList, i);
      l_txmsg.msgtype  := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                'MSGTYPE'));
      l_txmsg.txnum  := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                'TXNUM'));
      l_txmsg.txdate := TO_DATE(xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                        'TXDATE')),
                                systemnums.c_date_format);

      l_txmsg.txtime := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                'TXTIME'));

      l_txmsg.brid := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                              'MBID'));

      l_txmsg.tlid := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                              'TLID'));

      l_txmsg.offid := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                               'OFFID'));
      --plog.debug(pkgctx,'get ovrrqs from xml: ' ||xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                --'OVRRQD')));
      l_txmsg.ovrrqd := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                'OVRRQD'));

      l_txmsg.chid := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                              'CHID'));

      l_txmsg.chkid := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                               'CHKID'));

      l_txmsg.txaction := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                  'MSGTYPE'));

      --l_txmsg.txaction := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),'ACTIONFLAG'));

      l_txmsg.tltxcd := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                'TLTXCD'));

      l_txmsg.ibt := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                             'IBT'));

      l_txmsg.brid2 := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                               'BRID2'));

      l_txmsg.tlid2 := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                               'TLID2'));

      l_txmsg.ccyusage := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                  'CCYUSAGE'));

      l_txmsg.off_line := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                  'OFFLINE'));

      l_txmsg.deltd := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                               'DELTD'));

      l_txmsg.brdate := TO_DATE(xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                        'BRDATE')),
                                systemnums.c_date_format);

      l_txmsg.busdate := TO_DATE(xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                         'BUSDATE')),
                                 systemnums.c_date_format);

      l_txmsg.txdesc := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                'TXDESC'));

      l_txmsg.ipaddress := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                   'IPADDRESS'));

      l_txmsg.wsname := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                'WSNAME'));

      l_txmsg.txstatus := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                  'STATUS'));

      l_txmsg.msgsts := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                'MSGSTS'));

      l_txmsg.ovrsts := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                'OVRSTS'));

      l_txmsg.batchname := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                   'BATCHNAME'));

      --plog.debug(pkgctx, 'msgamt: ' || xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                --'MSGAMT')));
      l_txmsg.msgamt := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                'MSGAMT'));

      --plog.debug(pkgctx, 'msgacct: ' || xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                --'msgacct')));
      l_txmsg.msgacct := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                 'MSGACCT'));

      l_txmsg.msgamt := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                'FEEAMT'));

      l_txmsg.msgacct := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                 'VATAMT'));

      l_txmsg.chktime := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                 'VOUCHER'));

      l_txmsg.chktime := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                 'CHKTIME'));

      l_txmsg.offtime := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                 'OFFTIME'));
      -- tx control

      l_txmsg.txtype := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                'TXTYPE'));

      l_txmsg.nosubmit := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                  'NOSUBMIT'));

      l_txmsg.pretran := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                 'PRETRAN'));

      l_txmsg.late := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                 'LATE'));
      l_txmsg.local := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                 'LOCAL'));
      l_txmsg.glgp := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                 'GLGP'));
      l_txmsg.careby := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                 'CAREBY'));
      l_txmsg.warning := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                 'WARNING'));
      l_txmsg.sessionid := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                 'SESSIONID'));
      l_txmsg.updatemode := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                 'UPDATEMODE'));
      l_txmsg.LAST_LVEL := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                 'LAST_LVEL'));
      l_txmsg.LAST_DSTATUS := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                 'LAST_DSTATUS'));
      l_txmsg.LVEL := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                 'LVEL'));
      l_txmsg.DSTATUS := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                 'DSTATUS'));
      l_txmsg.cmdobjname := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                 'CMDOBJNAME'));
      /*plog.debug(pkgctx,'Header:' || CHR(10) || 'txnum: ' ||
                           l_txmsg.txnum || CHR(10) || 'txaction: ' ||
                           l_txmsg.txaction || CHR(10) || 'txstatus: ' ||
                           l_txmsg.txstatus || CHR(10) || 'pretran: ' ||
                           l_txmsg.pretran
                           );*/
    END LOOP;
    --<<End of header transformation>>

    --<<Begin of fields transformation>>
    --plog.debug(pkgctx,'Prepare to parse Message Fields');
    l_nodeList := xslprocessor.selectnodes(xmldom.makenode(l_doc),
                                           '/TransactMessage/fields/entry');

    FOR i IN 0 .. xmldom.getlength(l_nodeList) - 1 LOOP
      --plog.debug(pkgctx,'parse fields: ' || i);
      l_node := xmldom.item(l_nodeList, i);
      l_fldname := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                           'fldname'));
      l_txmsg.txfields(l_fldname).type := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                                  'fldtype'));
      l_txmsg.txfields(l_fldname).defname := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                                     'defname'));
      l_txmsg.txfields(l_fldname).value := xmldom.getnodevalue(xmldom.getfirstchild(l_node));
      /*plog.debug(pkgctx,'l_fldname(' || l_fldname || '): ' ||
                           l_txmsg.txfields(l_fldname).value);*/

    END LOOP;

    --plog.debug(pkgctx,'Prepare to parse printinfo');
    l_nodeList := xslprocessor.selectnodes(xmldom.makenode(l_doc),
                                           '/TransactMessage/printinfo/entry');

    FOR i IN 0 .. xmldom.getlength(l_nodeList) - 1 LOOP
      --plog.debug(pkgctx,'parse PrinInfo: ' || i);
      l_node := xmldom.item(l_nodeList, i);
      l_fldname := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                           'fldname'));
      l_txmsg.txPrintInfo(l_fldname).custname := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                                         'custname'));
      l_txmsg.txPrintInfo(l_fldname).address := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                                        'address'));
      l_txmsg.txPrintInfo(l_fldname).license := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                                        'license'));
      l_txmsg.txPrintInfo(l_fldname).custody := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                                        'custody'));
      l_txmsg.txPrintInfo(l_fldname).bankac := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                                       'bankac'));
      l_txmsg.txPrintInfo(l_fldname).bankname := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                                       'bankname'));
      l_txmsg.txPrintInfo(l_fldname).bankque := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                                       'bankque'));
      l_txmsg.txPrintInfo(l_fldname).holdamt := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                                       'holdamt'));
      l_txmsg.txPrintInfo(l_fldname).value := xmldom.getnodevalue(xmldom.getfirstchild(l_node));
      /*plog.debug(pkgctx,'printinfo(' || l_fldname || '): ' ||
                           l_txmsg.txPrintInfo(l_fldname).value);*/

    END LOOP;

    --plog.debug(pkgctx,'Prepare to parse Feemap');
    l_nodeList := xslprocessor.selectnodes(xmldom.makenode(l_doc),
                                           '/TransactMessage/feemap/entry');

    FOR i IN 0 .. xmldom.getlength(l_nodeList) - 1 LOOP
      --plog.debug(pkgctx,'parse feemap: ' || i);
      l_node := xmldom.item(l_nodeList, i);
      l_txmsg.txInfo(l_fldname)(txnums.C_FEETRAN_FEECD) := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                                                   'feecd'));
      l_txmsg.txInfo(l_fldname)(txnums.C_FEETRAN_GLACCTNO) := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                                                      'glacctno'));
      l_txmsg.txInfo(l_fldname)(txnums.C_FEETRAN_FEEAMT) := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                                                    'feeamt'));
      l_txmsg.txInfo(l_fldname)(txnums.C_FEETRAN_VATAMT) := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                                                    'vatamt'));
      l_txmsg.txInfo(l_fldname)(txnums.C_FEETRAN_TXAMT) := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                                                   'txamt'));
      l_txmsg.txInfo(l_fldname)(txnums.C_FEETRAN_FEERATE) := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                                                     'feerate'));
      l_txmsg.txInfo(l_fldname)(txnums.C_FEETRAN_VATRATE) := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                                                     'vatrate'));
    END LOOP;

    --plog.debug(pkgctx,'Prepare to parse vatvoucher');
    l_nodeList := xslprocessor.selectnodes(xmldom.makenode(l_doc),
                                           '/TransactMessage/vatvoucher/entry');

    FOR i IN 0 .. xmldom.getlength(l_nodeList) - 1 LOOP
      --plog.debug(pkgctx,'parse vatvoucher: ' || i);
      l_node := xmldom.item(l_nodeList, i);
      l_txmsg.txInfo(l_fldname)(txnums.C_VATTRAN_VOUCHERNO) := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                                                       'voucherno'));
      l_txmsg.txInfo(l_fldname)(txnums.C_VATTRAN_VOUCHERTYPE) := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                                                         'vouchertype'));
      l_txmsg.txInfo(l_fldname)(txnums.C_VATTRAN_SERIALNO) := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                                                      'serieno'));
      l_txmsg.txInfo(l_fldname)(txnums.C_VATTRAN_VOUCHERDATE) := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                                                         'voucherdate'));
      l_txmsg.txInfo(l_fldname)(txnums.C_VATTRAN_CUSTID) := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                                                    'custid'));
      l_txmsg.txInfo(l_fldname)(txnums.C_VATTRAN_TAXCODE) := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                                                     'taxcode'));
      l_txmsg.txInfo(l_fldname)(txnums.C_VATTRAN_CUSTNAME) := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                                                      'custname'));
      l_txmsg.txInfo(l_fldname)(txnums.C_VATTRAN_ADDRESS) := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                                                     'address'));
      l_txmsg.txInfo(l_fldname)(txnums.C_VATTRAN_CONTENTS) := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                                                      'contents'));
      l_txmsg.txInfo(l_fldname)(txnums.C_VATTRAN_QTTY) := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                                                  'qtty'));
      l_txmsg.txInfo(l_fldname)(txnums.C_VATTRAN_PRICE) := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                                                   'price'));
      l_txmsg.txInfo(l_fldname)(txnums.C_VATTRAN_AMT) := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                                                 'amt'));
      l_txmsg.txInfo(l_fldname)(txnums.C_VATTRAN_VATRATE) := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                                                     'vatrate'));
      l_txmsg.txInfo(l_fldname)(txnums.C_VATTRAN_VATAMT) := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                                                    'vatamt'));
      l_txmsg.txInfo(l_fldname)(txnums.C_VATTRAN_DESCRIPTION) := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                                                         'description'));

    END LOOP;

    --plog.debug(pkgctx,'Prepare to parse exception');
    l_nodeList := xslprocessor.selectnodes(xmldom.makenode(l_doc),
                                           '/TransactMessage/errorexception/entry');

    FOR i IN 0 .. xmldom.getlength(l_nodeList) - 1 LOOP
      --plog.debug(pkgctx,'parse txException: ' || i);
      l_node := xmldom.item(l_nodeList, i);
      l_fldname := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                           'fldname'));
      l_txmsg.txException(l_fldname).type:= xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                                         'fldtype'));
      l_txmsg.txException(l_fldname).oldval := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                                        'oldval'));
      l_txmsg.txException(l_fldname).value := xmldom.getnodevalue(xmldom.getfirstchild(l_node));
      /*plog.debug(pkgctx,'Exception(' || l_fldname || '): ' ||
                           l_txmsg.txException(l_fldname).value);*/

    END LOOP;

    --plog.debug(pkgctx,'Prepare to parse warning exception');
    l_nodeList := xslprocessor.selectnodes(xmldom.makenode(l_doc),
                                           '/TransactMessage/warningexception/entry');

    FOR i IN 0 .. xmldom.getlength(l_nodeList) - 1 LOOP
      --plog.debug(pkgctx,'parse txWarningException: ' || i);
      l_node := xmldom.item(l_nodeList, i);
      l_fldname := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                           'errnum'));
      l_txmsg.txWarningException(l_fldname).errlev:= xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                                         'errlev'));
      l_txmsg.txWarningException(l_fldname).value := xmldom.getnodevalue(xmldom.getfirstchild(l_node));
      /*plog.debug(pkgctx,'WarningException(' || l_fldname || '): ' ||
                           l_txmsg.txWarningException(l_fldname).value);*/

    END LOOP;

    --plog.debug(pkgctx,'Free resources associated');

    -- Free any resources associated with the document now it
    -- is no longer needed.
    DBMS_XMLDOM.freedocument(l_doc);
    -- Only used if variant is CLOB
    -- dbms_lob.freetemporary(p_xmlmsg);
    plog.setendsection(pkgctx, 'fn_xml2obj');
    RETURN l_txmsg;
  EXCEPTION
    WHEN OTHERS THEN
      --dbms_lob.freetemporary(p_xmlmsg);
      DBMS_XMLPARSER.freeparser(l_parser);
      DBMS_XMLDOM.freedocument(l_doc);
      plog.error(pkgctx, SQLERRM);
      plog.error (pkgctx, 'Loi tai dong: ' || dbms_utility.format_error_backtrace);
      plog.setendsection(pkgctx, 'fn_xml2obj');
      RAISE errnums.E_SYSTEM_ERROR;
  END fn_xml2obj;

  FUNCTION fn_obj2xml(p_txmsg tx.msg_rectype)
  RETURN VARCHAR2
  IS
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

   l_index varchar2(30); -- this must be match with arrtype index
   temp1          VARCHAR2 (32000);
   temp2          VARCHAR2 (2500);
BEGIN
   plog.setbeginsection(pkgctx, 'fn_obj2xml');

   l_parser              := xmlparser.newparser;
   xmlparser.parsebuffer (l_parser, '<TransactMessage/>');
   l_doc            := xmlparser.getdocument (l_parser);
   --xmldom.setversion (l_doc, '1.0');
   docnode        := xmldom.makenode (l_doc);

   --<< BEGIN OF CREATING MESSAGE HEADER>>
   l_element := xmldom.getdocumentelement(l_doc);
   xmldom.setattribute (l_element, 'MSGTYPE', p_txmsg.msgtype);
   xmldom.setattribute (l_element, 'TXNUM', p_txmsg.txnum);
   xmldom.setattribute (l_element, 'TXDATE', TO_CHAR(p_txmsg.txdate,systemnums.C_DATE_FORMAT));
   xmldom.setattribute (l_element, 'TXTIME', p_txmsg.txtime);
   xmldom.setattribute (l_element, 'MBID', p_txmsg.brid);
   xmldom.setattribute (l_element, 'TLID', p_txmsg.tlid);
   xmldom.setattribute (l_element, 'OFFID', p_txmsg.offid);
   xmldom.setattribute (l_element, 'OVRRQD', p_txmsg.ovrrqd);
   xmldom.setattribute (l_element, 'CHID', p_txmsg.chid);
   xmldom.setattribute (l_element, 'CHKID', p_txmsg.chkid);
   --xmldom.setattribute (l_element, 'ACTIONFLAG', p_txmsg.txaction);
   xmldom.setattribute (l_element, 'TLTXCD', p_txmsg.tltxcd);
   xmldom.setattribute (l_element, 'IBT', p_txmsg.ibt);
   xmldom.setattribute (l_element, 'BRID2', p_txmsg.brid2);
   xmldom.setattribute (l_element, 'TLID2', p_txmsg.tlid2);
   xmldom.setattribute (l_element, 'CCYUSAGE', p_txmsg.ccyusage);
   xmldom.setattribute (l_element, 'OFFLINE', p_txmsg.off_line);
   xmldom.setattribute (l_element, 'DELTD', p_txmsg.deltd);
   xmldom.setattribute (l_element, 'BRDATE', to_char(p_txmsg.brdate,systemnums.C_DATE_FORMAT));
   --xmldom.setattribute (l_element, 'PAGENO', p_txmsg.pageno);
   --xmldom.setattribute (l_element, 'TOTALPAGE', p_txmsg.totalpage);
   xmldom.setattribute (l_element, 'BUSDATE', to_char(p_txmsg.busdate,systemnums.C_DATE_FORMAT));
   xmldom.setattribute (l_element, 'TXDESC', p_txmsg.txdesc);
   xmldom.setattribute (l_element, 'IPADDRESS', p_txmsg.ipaddress);
   xmldom.setattribute (l_element, 'WSNAME', p_txmsg.wsname);
   xmldom.setattribute (l_element, 'STATUS', p_txmsg.txstatus);
   xmldom.setattribute (l_element, 'MSGSTS', p_txmsg.msgsts);
   xmldom.setattribute (l_element, 'OVRSTS', p_txmsg.ovrsts);
   xmldom.setattribute (l_element, 'BATCHNAME', p_txmsg.batchname);
   xmldom.setattribute (l_element, 'MSGAMT', p_txmsg.msgamt);
   xmldom.setattribute (l_element, 'MSGACCT', p_txmsg.msgacct);

   xmldom.setattribute (l_element, 'FEEAMT', p_txmsg.feeamt);
   xmldom.setattribute (l_element, 'VATAMT', p_txmsg.vatamt);
   xmldom.setattribute (l_element, 'VOUCHER', p_txmsg.voucher);

   xmldom.setattribute (l_element, 'CHKTIME', p_txmsg.chktime);
   xmldom.setattribute (l_element, 'OFFTIME', p_txmsg.offtime);
   xmldom.setattribute (l_element, 'TXTYPE', p_txmsg.txtype);
   xmldom.setattribute (l_element, 'NOSUBMIT', p_txmsg.nosubmit);
   xmldom.setattribute (l_element, 'PRETRAN', p_txmsg.pretran);

   --xmldom.setattribute (l_element, 'UPDATEMODE', p_txmsg.updatemode);
   xmldom.setattribute (l_element, 'LOCAL', p_txmsg.local);
   xmldom.setattribute (l_element, 'LATE', p_txmsg.late);
   --xmldom.setattribute (l_element, 'HOSTTIME', p_txmsg.HOSTTIME);
   --xmldom.setattribute (l_element, 'REFERENCE', p_txmsg.REFERENCE);
   xmldom.setattribute (l_element, 'GLGP', p_txmsg.glgp);
   xmldom.setattribute (l_element, 'CAREBY', p_txmsg.careby);
   xmldom.setattribute (l_element, 'WARNING', p_txmsg.WARNING);
   xmldom.setattribute (l_element, 'SESSIONID', p_txmsg.SESSIONID);
   xmldom.setattribute (l_element, 'UPDATEMODE', p_txmsg.UPDATEMODE);
   xmldom.setattribute (l_element, 'LAST_LVEL', p_txmsg.LAST_LVEL);
   xmldom.setattribute (l_element, 'LAST_DSTATUS', p_txmsg.LAST_DSTATUS);
   xmldom.setattribute (l_element, 'LVEL', p_txmsg.LVEL);
   xmldom.setattribute (l_element, 'DSTATUS', p_txmsg.DSTATUS);
   xmldom.setattribute (l_element, 'CMDOBJNAME', p_txmsg.cmdobjname);

   headernode   := xmldom.appendchild (docnode, xmldom.makenode (l_element));
   --<< END of creating Message Header>>

   l_element             := xmldom.createelement (l_doc, 'fields');
   childnode    := xmldom.appendchild (headernode, xmldom.makenode (l_element));
   -- Create Fields
   l_index := p_txmsg.txfields.FIRST;
   --plog.debug(pkgctx,'abt to populate fields,l_index: ' || l_index);
   WHILE (l_index IS NOT NULL)
   LOOP
       --plog.debug(pkgctx,'loop with l_index: ' || l_index || ':' || p_txmsg.txfields(l_index).defname);

       l_element := xmldom.createelement (l_doc, 'entry');

       xmldom.setattribute (l_element, 'fldname', l_index);
       xmldom.setattribute (l_element, 'fldtype', p_txmsg.txfields(l_index).type);
       xmldom.setattribute (l_element, 'defname', p_txmsg.txfields(l_index).defname);
       entrynode   := xmldom.appendchild (childnode, xmldom.makenode(l_element));

       textnode := xmldom.createTextNode(l_doc, p_txmsg.txfields(l_index).value);
       entrynode := xmldom.appendChild(entrynode, xmldom.makeNode(textnode));
       -- get the next field
       l_index := p_txmsg.txfields.NEXT (l_index);
   END LOOP;
   -- Populate printInfo
   l_element             := xmldom.createelement (l_doc, 'printinfo');
   childnode    := xmldom.appendchild (headernode, xmldom.makenode (l_element));

   l_index := p_txmsg.txPrintInfo.FIRST;
   --plog.debug(pkgctx,'prepare to populate printinfo, l_index: ' || l_index);
   WHILE (l_index IS NOT NULL)
   LOOP
       --plog.debug(pkgctx,'loop with l_index: ' || l_index);
       l_element             := xmldom.createelement (l_doc, 'entry');

       xmldom.setattribute (l_element, 'fldname', l_index);
       xmldom.setattribute (l_element, 'custname', p_txmsg.txPrintInfo(l_index).custname);
       xmldom.setattribute (l_element, 'address', p_txmsg.txPrintInfo(l_index).address);
       xmldom.setattribute (l_element, 'license', p_txmsg.txPrintInfo(l_index).license);
       xmldom.setattribute (l_element, 'custody', p_txmsg.txPrintInfo(l_index).custody);
       xmldom.setattribute (l_element, 'bankac', p_txmsg.txPrintInfo(l_index).bankac);
       xmldom.setattribute (l_element, 'bankname', p_txmsg.txPrintInfo(l_index).bankname);
       xmldom.setattribute (l_element, 'bankque', p_txmsg.txPrintInfo(l_index).bankque);
       xmldom.setattribute (l_element, 'holdamt', p_txmsg.txPrintInfo(l_index).holdamt);
       entrynode   := xmldom.appendchild (childnode, xmldom.makenode (l_element));

       textnode := xmldom.createTextNode(l_doc, p_txmsg.txPrintInfo(l_index).value);
       entrynode := xmldom.appendChild(entrynode, xmldom.makeNode(textnode));
       -- get the next field
       l_index := p_txmsg.txPrintInfo.NEXT (l_index);
   END LOOP;

   -- Populate printInfo
   l_element             := xmldom.createelement (l_doc, 'ErrorException');
   childnode    := xmldom.appendchild (headernode, xmldom.makenode (l_element));


   l_index := p_txmsg.txException.FIRST;
   --plog.debug(pkgctx,'prepare to populate ErrorException, l_index: ' || l_index);
   WHILE (l_index IS NOT NULL)
   LOOP
       --plog.debug(pkgctx,'loop with l_index: ' || l_index);
       l_element             := xmldom.createelement (l_doc, 'entry');

       xmldom.setattribute (l_element, 'fldname', l_index);
       xmldom.setattribute (l_element, 'type', p_txmsg.txException(l_index).type);
       xmldom.setattribute (l_element, 'oldval', p_txmsg.txException(l_index).oldval);
       entrynode   := xmldom.appendchild (childnode, xmldom.makenode (l_element));

       textnode := xmldom.createTextNode(l_doc, p_txmsg.txException(l_index).value);
       entrynode := xmldom.appendChild(entrynode, xmldom.makeNode(textnode));
       -- get the next field
       l_index := p_txmsg.txException.NEXT (l_index);
   END LOOP;

   -- warningmessage
   l_element             := xmldom.createelement (l_doc, 'WarningException');
   childnode    := xmldom.appendchild (headernode, xmldom.makenode (l_element));

   l_index := p_txmsg.txWarningException.FIRST;
   --plog.debug(pkgctx,'prepare to populate WarningException, l_index: ' || l_index);
   WHILE (l_index IS NOT NULL)
   LOOP
       --plog.debug(pkgctx,'loop with l_index: ' || l_index);
       l_element             := xmldom.createelement (l_doc, 'entry');

       xmldom.setattribute (l_element, 'errnum', l_index);
       xmldom.setattribute (l_element, 'errlev', p_txmsg.txWarningException(l_index).errlev);
       entrynode   := xmldom.appendchild (childnode, xmldom.makenode (l_element));

       textnode := xmldom.createTextNode(l_doc, p_txmsg.txWarningException(l_index).value);
       entrynode := xmldom.appendChild(entrynode, xmldom.makeNode(textnode));
       -- get the next field
       l_index := p_txmsg.txWarningException.NEXT (l_index);
   END LOOP;


   xmldom.writetobuffer (l_doc, temp1);
   --plog.debug(pkgctx,'got xml,length: ' || length(temp1));
   --plog.debug(pkgctx,'got xml: ' || SUBSTR (temp1, 1, 1500));
   --plog.debug(pkgctx,'got xml: ' || SUBSTR (temp1, 1501, 3000));
   plog.setendsection(pkgctx, 'fn_obj2xml');
   return temp1;
-- deal with exceptions
EXCEPTION
   WHEN others
   THEN
      plog.error(pkgctx,SQLERRM);
      plog.setendsection(pkgctx, 'fn_obj2xml');
      RAISE errnums.E_SYSTEM_ERROR;
END;
  --msg for maintenance form
  FUNCTION fn_mt_xml2obj(p_xmlmsg    VARCHAR2) RETURN tx.obj_rectype IS
    l_parser   xmlparser.parser;
    l_doc      xmldom.domdocument;
    l_nodeList xmldom.domnodelist;
    l_node     xmldom.domnode;

    l_fldname fldmaster.fldname%TYPE;
    l_txmsg   tx.obj_rectype;
  BEGIN
    plog.setbeginsection (pkgctx, 'fn_mt_xml2obj');

    plog.error(pkgctx,'msg fn_mt_xml2obj:' || p_xmlmsg);
    l_parser := xmlparser.newparser();
    plog.debug(pkgctx,'1');
    xmlparser.parseclob(l_parser, p_xmlmsg);
    plog.debug(pkgctx,'2');
    l_doc := xmlparser.getdocument(l_parser);
    plog.debug(pkgctx,'3');
    xmlparser.freeparser(l_parser);

    plog.debug(pkgctx,'Prepare to parse Message Header');
    l_nodeList := xslprocessor.selectnodes(xmldom.makenode(l_doc),
                                           '/ObjectMessage');
    --<<Begin of header transformation>>
    FOR i IN 0 .. xmldom.getlength(l_nodeList) - 1 LOOP
      plog.debug(pkgctx,'parse header i: ' || i);
      l_node         := xmldom.item(l_nodeList, i);
      l_txmsg.TXDATE  := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                'TXDATE'));
      l_txmsg.TXNUM  := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                'TXNUM'));
      l_txmsg.TXTIME := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                        'TXTIME'));
      l_txmsg.TLID := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                'TLID'));
      l_txmsg.MBID := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                              'MBID'));
      l_txmsg.LOCAL := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                              'LOCAL'));
      l_txmsg.MSGTYPE := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                               'MSGTYPE'));
      l_txmsg.OBJNAME := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                'OBJNAME'));
      l_txmsg.ACTIONFLAG := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                              'ACTIONFLAG'));
      l_txmsg.CMDINQUIRY := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                               'CMDINQUIRY'));
      l_txmsg.CLAUSE := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                  'CLAUSE'));
      l_txmsg.FUNCTIONNAME := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                'FUNCTIONNAME'));
      l_txmsg.AUTOID := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                             'AUTOID'));
      l_txmsg.REFERENCE := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                               'REFERENCE'));
      l_txmsg.RESERVER := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                               'RESERVER'));
      l_txmsg.IPADDRESS := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                  'IPADDRESS'));
      l_txmsg.CMDTYPE := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                  'CMDTYPE'));
      l_txmsg.PARENTOBJNAME := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                               'PARENTOBJNAME'));
      l_txmsg.PARENTCLAUSE := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                'PARENTCLAUSE'));
      l_txmsg.SESSIONID := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                   'SESSIONID'));
      l_txmsg.REQUESTID := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                'REQUESTID'));
      l_txmsg.CHILDTABLE := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                'CHILDTABLE'));
      l_txmsg.CMDOBJNAME := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                'CMDOBJNAME'));
      l_txmsg.LANGUAGE := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                'LANGUAGE'));
    END LOOP;
    --<<End of header transformation>>

    --<<Begin of fields transformation>>
    plog.debug(pkgctx,'Prepare to parse Message Fields');
    l_nodeList := xslprocessor.selectnodes(xmldom.makenode(l_doc),
                                           '/ObjectMessage/ObjData/Entry');

    FOR i IN 0 .. xmldom.getlength(l_nodeList) - 1 LOOP
      plog.debug(pkgctx,'parse fields: ' || i);
      l_node := xmldom.item(l_nodeList, i);
      l_fldname := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                           'fldname'));
      l_txmsg.OBJFIELDS(l_fldname).fldtype := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                                  'fldtype'));
      l_txmsg.OBJFIELDS(l_fldname).fldname := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                                     'fldname'));
      l_txmsg.OBJFIELDS(l_fldname).updatefld := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                                     'updatefld'));
      l_txmsg.OBJFIELDS(l_fldname).oldval := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                                     'oldval'));
      l_txmsg.OBJFIELDS(l_fldname).value := xmldom.getnodevalue(xmldom.getfirstchild(l_node));
      plog.debug(pkgctx,'l_fldname(' || l_fldname || '): ' ||
                           l_txmsg.OBJFIELDS(l_fldname).value);

    END LOOP;

    -- Free any resources associated with the document now it
    -- is no longer needed.
    DBMS_XMLDOM.freedocument(l_doc);
    -- Only used if variant is CLOB
    -- dbms_lob.freetemporary(p_xmlmsg);
    plog.setendsection(pkgctx, 'fn_mt_xml2obj');
    RETURN l_txmsg;
  EXCEPTION
    WHEN OTHERS THEN
      --dbms_lob.freetemporary(p_xmlmsg);
      DBMS_XMLPARSER.freeparser(l_parser);
      DBMS_XMLDOM.freedocument(l_doc);
      plog.error(pkgctx, SQLERRM);
      plog.error (pkgctx, 'Loi tai dong: ' || dbms_utility.format_error_backtrace);
      plog.setendsection(pkgctx, 'fn_mt_xml2obj');
      RAISE errnums.E_SYSTEM_ERROR;
  END;

  FUNCTION fn_mt_obj2xml(p_txmsg tx.obj_rectype)
  RETURN VARCHAR2
  IS
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

   l_index varchar2(30); -- this must be match with arrtype index
   temp1          VARCHAR2 (32000);
   temp2          VARCHAR2 (2500);
BEGIN
   plog.setbeginsection(pkgctx, 'fn_mt_obj2xml');

   l_parser              := xmlparser.newparser;
   xmlparser.parsebuffer (l_parser, '<ObjectMessage/>');
   l_doc            := xmlparser.getdocument (l_parser);
   --xmldom.setversion (l_doc, '1.0');
   docnode        := xmldom.makenode (l_doc);

   --<< BEGIN OF CREATING MESSAGE HEADER>>
   l_element := xmldom.getdocumentelement(l_doc);
   xmldom.setattribute (l_element, 'TXDATE', p_txmsg.TXDATE);
   xmldom.setattribute (l_element, 'TXNUM', p_txmsg.TXNUM);
   xmldom.setattribute (l_element, 'TXTIME', p_txmsg.TXTIME);
   xmldom.setattribute (l_element, 'TLID', p_txmsg.TLID);
   xmldom.setattribute (l_element, 'MBID', p_txmsg.MBID);
   xmldom.setattribute (l_element, 'LOCAL', p_txmsg.LOCAL);
   xmldom.setattribute (l_element, 'MSGTYPE', p_txmsg.MSGTYPE);
   xmldom.setattribute (l_element, 'OBJNAME', p_txmsg.OBJNAME);
   xmldom.setattribute (l_element, 'ACTIONFLAG', p_txmsg.ACTIONFLAG);
   xmldom.setattribute (l_element, 'CMDINQUIRY', p_txmsg.CMDINQUIRY);
   xmldom.setattribute (l_element, 'CLAUSE', p_txmsg.CLAUSE);
   xmldom.setattribute (l_element, 'FUNCTIONNAME', p_txmsg.FUNCTIONNAME);
   xmldom.setattribute (l_element, 'AUTOID', p_txmsg.AUTOID);
   xmldom.setattribute (l_element, 'REFERENCE', p_txmsg.REFERENCE);
   xmldom.setattribute (l_element, 'RESERVER', p_txmsg.RESERVER);
   xmldom.setattribute (l_element, 'IPADDRESS', p_txmsg.IPADDRESS);
   xmldom.setattribute (l_element, 'CMDTYPE', p_txmsg.CMDTYPE);
   xmldom.setattribute (l_element, 'PARENTOBJNAME', p_txmsg.PARENTOBJNAME);
   xmldom.setattribute (l_element, 'PARENTCLAUSE', p_txmsg.PARENTCLAUSE);
   xmldom.setattribute (l_element, 'SESSIONID', p_txmsg.SESSIONID);
   xmldom.setattribute (l_element, 'REQUESTID', p_txmsg.REQUESTID);
   xmldom.setattribute (l_element, 'CHILDTABLE', p_txmsg.CHILDTABLE);
   xmldom.setattribute (l_element, 'CMDOBJNAME', p_txmsg.CMDOBJNAME);
   xmldom.setattribute (l_element, 'LANGUAGE', p_txmsg.LANGUAGE);

   headernode   := xmldom.appendchild (docnode, xmldom.makenode (l_element));
   --<< END of creating Message Header>>

   l_element             := xmldom.createelement (l_doc, 'ObjData');
   childnode    := xmldom.appendchild (headernode, xmldom.makenode (l_element));
   -- Create Fields
   l_index := p_txmsg.OBJFIELDS.FIRST;
   plog.debug(pkgctx,'abt to populate fields,l_index: ' || l_index);
   WHILE (l_index IS NOT NULL)
   LOOP
       plog.debug(pkgctx,'loop with l_index: ' || l_index || ':' || p_txmsg.OBJFIELDS(l_index).fldname);

       l_element := xmldom.createelement (l_doc, 'entry');

       xmldom.setattribute (l_element, 'fldname', l_index);
       xmldom.setattribute (l_element, 'fldtype', p_txmsg.OBJFIELDS(l_index).fldtype);
       xmldom.setattribute (l_element, 'updatefld', p_txmsg.OBJFIELDS(l_index).updatefld);
       xmldom.setattribute (l_element, 'oldval', p_txmsg.OBJFIELDS(l_index).oldval);

       entrynode   := xmldom.appendchild (childnode, xmldom.makenode(l_element));
       textnode := xmldom.createTextNode(l_doc, p_txmsg.OBJFIELDS(l_index).value);
       entrynode := xmldom.appendChild(entrynode, xmldom.makeNode(textnode));
       -- get the next field
       l_index := p_txmsg.OBJFIELDS.NEXT (l_index);
   END LOOP;


   xmldom.writetobuffer (l_doc, temp1);
   plog.debug(pkgctx,'got xml,length: ' || length(temp1));
   plog.debug(pkgctx,'got xml: ' || SUBSTR (temp1, 1, 1500));
   plog.debug(pkgctx,'got xml: ' || SUBSTR (temp1, 1501, 3000));
   plog.setendsection(pkgctx, 'fn_mt_obj2xml');
   return temp1;
-- deal with exceptions
EXCEPTION
   WHEN others
   THEN
      plog.error(pkgctx,SQLERRM);
      plog.setendsection(pkgctx, 'fn_mt_obj2xml');
      RAISE errnums.E_SYSTEM_ERROR;
END;

BEGIN
  FOR i IN (SELECT * FROM tlogdebug) LOOP
    logrow.loglevel  := i.loglevel;
    logrow.log4table := i.log4table;
    logrow.log4alert := i.log4alert;
    logrow.log4trace := i.log4trace;
  END LOOP;

  pkgctx := plog.init('txpks_msg',
                      plevel => NVL(logrow.loglevel,30),
                      plogtable => (NVL(logrow.log4table,'Y') = 'Y'),
                      palert => (logrow.log4alert = 'Y'),
                      ptrace => (logrow.log4trace = 'Y'));
END txpks_msg;
/

DROP PACKAGE txpks_msg_stp
/

CREATE OR REPLACE 
PACKAGE txpks_msg_stp 
is
 /*----------------------------------------------------------------------------------------------------
     ** Module   : COMMODITY SYSTEM
     ** and is copyrighted by FSS.
     **
     **    All rights reserved.  No part of this work may be reproduced, stored in a retrieval system,
     **    adopted or transmitted in any form or by any means, electronic, mechanical, photographic,
     **    graphic, optic recording or otherwise, translated in any language or computer language,
     **    without the prior written permission of Financial Software Solutions. JSC.
     **
     **  MODIFICATION HISTORY
     **  Person      Date           Comments
     **  TienPQ      09-JUNE-2009    Created
     ** (c) 2009 by Financial Software Solutions. JSC.
     ----------------------------------------------------------------------------------------------------*/

    FUNCTION fn_obj2xml(p_txmsg tx.msg_rectype)
    RETURN VARCHAR2;

    FUNCTION fn_xml2obj(p_xmlmsg    VARCHAR2)
    RETURN tx.msg_rectype;

    FUNCTION fn_mt_obj2xml(p_txmsg tx.obj_rectype) return varchar2;

    FUNCTION fn_mt_xml2obj(p_xmlmsg    VARCHAR2) return tx.obj_rectype;

    FUNCTION fn_build_objxmldata(p_txmsg IN tx.obj_rectype, pv_refcursor  IN  pkg_report.ref_cursor) RETURN VARCHAR2;
END;
/

CREATE OR REPLACE 
PACKAGE BODY txpks_msg_stp IS
  pkgctx plog.log_ctx;
  logrow tlogdebug%ROWTYPE;

FUNCTION fn_build_objxmldata(
    p_txmsg IN  tx.obj_rectype,
    pv_refcursor   IN  pkg_report.ref_cursor
    ) RETURN VARCHAR2
IS
--  Build objxmldata from ref cursor
-- ---------   ------  -------------------------------------------
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
    l_fldname varchar2(100);
    l_fldval varchar2(1000);
    l_fldtype varchar2(100);
BEGIN
    plog.setbeginsection(pkgctx, 'fn_build_objxmldata');
    --1. Add header msg
    l_parser              := xmlparser.newparser;
    xmlparser.parsebuffer (l_parser, '<ObjectMessage/>');
    l_doc            := xmlparser.getdocument (l_parser);
    docnode        := xmldom.makenode (l_doc);
    l_element := xmldom.getdocumentelement(l_doc);
    xmldom.setattribute (l_element, 'txdate', p_txmsg.txdate);
    xmldom.setattribute (l_element, 'txnum', p_txmsg.txnum);
    xmldom.setattribute (l_element, 'txtime', p_txmsg.txtime);
    xmldom.setattribute (l_element, 'tlid', p_txmsg.tlid);
    xmldom.setattribute (l_element, 'mbid', p_txmsg.mbid);
    xmldom.setattribute (l_element, 'local', p_txmsg.local);
    xmldom.setattribute (l_element, 'msgtype', p_txmsg.msgtype);
    xmldom.setattribute (l_element, 'objname', p_txmsg.objname);
    xmldom.setattribute (l_element, 'actionflag', p_txmsg.actionflag);
    xmldom.setattribute (l_element, 'cmdinquiry', p_txmsg.cmdinquiry);
    xmldom.setattribute (l_element, 'clause', p_txmsg.clause);
    xmldom.setattribute (l_element, 'functionname', p_txmsg.functionname);
    xmldom.setattribute (l_element, 'autoid', p_txmsg.autoid);
    xmldom.setattribute (l_element, 'reference', p_txmsg.reference);
    xmldom.setattribute (l_element, 'reserver', p_txmsg.reserver);
    xmldom.setattribute (l_element, 'ipaddress', p_txmsg.ipaddress);
    xmldom.setattribute (l_element, 'cmdtype', p_txmsg.cmdtype);
    xmldom.setattribute (l_element, 'parentobjname', p_txmsg.parentobjname);
    xmldom.setattribute (l_element, 'parentclause', p_txmsg.parentclause);
    xmldom.setattribute (l_element, 'sessionid', p_txmsg.sessionid);
    xmldom.setattribute (l_element, 'requestid', p_txmsg.requestid);
    xmldom.setattribute (l_element, 'requestid', p_txmsg.requestid);
    xmldom.setattribute (l_element, 'requestid', p_txmsg.requestid);


    headernode   := xmldom.appendchild (docnode, xmldom.makenode (l_element));
    --2. Add objdata from cursor
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
        l_element             := xmldom.createelement (l_doc, 'ObjData');
        childnode    := xmldom.appendchild (headernode, xmldom.makenode (l_element));
        FOR i IN 1 .. v_desc_tab.COUNT LOOP
              l_fldname :=  v_desc_tab(i).col_name;
              IF v_desc_tab(i).col_type = dbms_types.typecode_number THEN
              --Number
                    dbms_sql.column_value(v_cursor_number, i, v_number_value);
                    plog.error (pkgctx, 'v_number_value:'||i ||':' ||v_number_value);
                    l_fldval :=to_char(v_number_value);
                    l_fldtype :='System.Decimal';
              END IF;
              IF v_desc_tab(i).col_type = dbms_types.typecode_varchar
                OR  v_desc_tab(i).col_type = dbms_types.typecode_char
                THEN
              --Varchar, char
                    dbms_sql.column_value(v_cursor_number, i, v_varchar_value);
                     plog.error (pkgctx, 'v_varchar_value:'||i ||':' ||v_varchar_value);
                    l_fldval := v_varchar_value;
                    l_fldtype :='System.String';
              END IF;
              IF v_desc_tab(i).col_type = dbms_types.typecode_date
                THEN
              --Date
                    dbms_sql.column_value(v_cursor_number, i, v_date_value);
                     plog.error (pkgctx, 'v_date_value:'||i ||':' ||to_char(v_date_value,'DD/MM/RRRR'));
                    l_fldval := to_char(v_date_value,'DD/MM/RRRR');
                    l_fldtype :='System.DateTime';
              END IF;
              l_element := xmldom.createelement (l_doc, 'Entry');
              xmldom.setattribute (l_element, 'fldname', l_fldname);
              xmldom.setattribute (l_element, 'fldtype', l_fldtype);
              xmldom.setattribute (l_element, 'oldval', '');

              entrynode   := xmldom.appendchild (childnode, xmldom.makenode(l_element));
              textnode := xmldom.createTextNode(l_doc, l_fldval);
              entrynode := xmldom.appendChild(entrynode, xmldom.makeNode(textnode));
        END LOOP;
    END LOOP;
    dbms_sql.close_cursor(v_cursor_number);
    xmldom.writetobuffer (l_doc, temp1);

    plog.setendsection(pkgctx, 'fn_build_objxmldata');
    return temp1;

EXCEPTION WHEN OTHERS THEN
    plog.error(pkgctx,SQLERRM);
    plog.error (pkgctx, 'Loi tai dong: ' || dbms_utility.format_error_backtrace);
    plog.setendsection(pkgctx, 'fn_build_objxmldata');
    RAISE errnums.E_SYSTEM_ERROR;

END;

  FUNCTION fn_xml2obj(p_xmlmsg    VARCHAR2) RETURN tx.msg_rectype IS
    l_parser   xmlparser.parser;
    l_doc      xmldom.domdocument;
    l_nodeList xmldom.domnodelist;
    l_node     xmldom.domnode;

    l_fldname fldmaster.fldname%TYPE;
    l_txmsg   tx.msg_rectype;
  BEGIN
    plog.setbeginsection (pkgctx, 'fn_xml2obj');

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
    --<<Begin of header transformation>>
    FOR i IN 0 .. xmldom.getlength(l_nodeList) - 1 LOOP
      plog.debug(pkgctx,'parse header i: ' || i);
      l_node         := xmldom.item(l_nodeList, i);
      l_txmsg.msgtype  := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                'msgtype'));

      l_txmsg.txnum  := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                'txnum'));
      l_txmsg.txdate := to_date(xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                        'txdate')),
                                systemnums.c_date_format);

      l_txmsg.txtime := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                'txtime'));

      l_txmsg.brid := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                              'mbid'));

      l_txmsg.tlid := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                              'tlid'));

      l_txmsg.offid := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                               'offid'));
      plog.debug(pkgctx,'get ovrrqs from xml: ' ||xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                'ovrrqd')));
      l_txmsg.ovrrqd := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                'ovrrqd'));

      l_txmsg.chid := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                              'chid'));

      l_txmsg.chkid := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                               'chkid'));

      l_txmsg.txaction := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                  'msgtype'));

      --l_txmsg.txaction := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),'actionflag'));

      l_txmsg.tltxcd := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                'tltxcd'));

      l_txmsg.ibt := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                             'ibt'));

      l_txmsg.brid2 := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                               'brid2'));

      l_txmsg.tlid2 := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                               'tlid2'));

      l_txmsg.ccyusage := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                  'ccyusage'));

      l_txmsg.off_line := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                  'offline'));

      l_txmsg.deltd := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                               'deltd'));

      l_txmsg.brdate := to_date(xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                        'brdate')),
                                systemnums.c_date_format);

      l_txmsg.busdate := to_date(xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                         'busdate')),
                                 systemnums.c_date_format);

      l_txmsg.txdesc := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                'txdesc'));

      l_txmsg.ipaddress := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                   'ipaddress'));

      l_txmsg.wsname := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                'wsname'));

      l_txmsg.txstatus := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                  'status'));

      l_txmsg.msgsts := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                'msgsts'));

      l_txmsg.ovrsts := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                'ovrsts'));

      l_txmsg.batchname := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                   'batchname'));

      plog.debug(pkgctx, 'msgamt: ' || xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                'msgamt')));
      l_txmsg.msgamt := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                'msgamt'));

      plog.debug(pkgctx, 'msgacct: ' || xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                'msgacct')));
      l_txmsg.msgacct := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                 'msgacct'));

      l_txmsg.msgamt := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                'feeamt'));

      l_txmsg.msgacct := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                 'vatamt'));

      l_txmsg.chktime := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                 'voucher'));

      l_txmsg.chktime := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                 'chktime'));

      l_txmsg.offtime := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                 'offtime'));
      -- tx control

      l_txmsg.txtype := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                'txtype'));

      l_txmsg.nosubmit := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                  'nosubmit'));

      l_txmsg.pretran := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                 'pretran'));

      l_txmsg.late := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                 'late'));
      l_txmsg.local := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                 'local'));
      l_txmsg.glgp := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                 'glgp'));
      l_txmsg.careby := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                 'careby'));
      l_txmsg.warning := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                 'warning'));
      l_txmsg.sessionid := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                 'sessionid'));
      l_txmsg.updatemode := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                 'updatemode'));
      l_txmsg.last_lvel := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                 'last_lvel'));
      l_txmsg.last_dstatus := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                 'last_dstatus'));
      l_txmsg.lvel := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                 'lvel'));
      l_txmsg.dstatus := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                 'dstatus'));

      l_txmsg.reftxnum := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                 'reftxnum'));
      l_txmsg.fmbid := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                 'fmbid'));
      l_txmsg.tmbid := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                 'tmbid'));
      plog.debug(pkgctx,'Header:' || CHR(10) || 'txnum: ' ||
                           l_txmsg.txnum || CHR(10) || 'txaction: ' ||
                           l_txmsg.txaction || CHR(10) || 'txstatus: ' ||
                           l_txmsg.txstatus || CHR(10) || 'pretran: ' ||
                           l_txmsg.pretran
                           );
    END LOOP;
    --<<End of header transformation>>

    --<<Begin of fields transformation>>
    plog.debug(pkgctx,'Prepare to parse Message Fields');
    l_nodeList := xslprocessor.selectnodes(xmldom.makenode(l_doc),
                                           '/TransactMessage/fields/entry');

    FOR i IN 0 .. xmldom.getlength(l_nodeList) - 1 LOOP
      plog.debug(pkgctx,'parse fields: ' || i);
      l_node := xmldom.item(l_nodeList, i);
      l_fldname := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                           'fldname'));
      dbms_output.put_line(' l_fldname: '||l_fldname);
      dbms_output.put_line('abc: '||xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                                  'fldtype')));
      l_txmsg.txfields(l_fldname).type := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                                  'fldtype'));
      dbms_output.put_line(' type: '||l_txmsg.txfields(l_fldname).type);
      l_txmsg.txfields(l_fldname).defname := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                                     'defname'));
      l_txmsg.txfields(l_fldname).value := xmldom.getnodevalue(xmldom.getfirstchild(l_node));
      plog.debug(pkgctx,'l_fldname(' || l_fldname || '): ' ||
                           l_txmsg.txfields(l_fldname).value);

    END LOOP;

    plog.debug(pkgctx,'Prepare to parse printinfo');
    l_nodeList := xslprocessor.selectnodes(xmldom.makenode(l_doc),
                                           '/TransactMessage/printinfo/entry');

    FOR i IN 0 .. xmldom.getlength(l_nodeList) - 1 LOOP
      plog.debug(pkgctx,'parse PrinInfo: ' || i);
      l_node := xmldom.item(l_nodeList, i);
      l_fldname := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                           'fldname'));

      l_txmsg.txPrintInfo(l_fldname).custname := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                                         'custname'));
      l_txmsg.txPrintInfo(l_fldname).address := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                                        'address'));
      l_txmsg.txPrintInfo(l_fldname).license := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                                        'license'));
      l_txmsg.txPrintInfo(l_fldname).custody := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                                        'custody'));
      l_txmsg.txPrintInfo(l_fldname).bankac := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                                       'bankac'));
      l_txmsg.txPrintInfo(l_fldname).bankname := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                                       'bankname'));
      l_txmsg.txPrintInfo(l_fldname).bankque := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                                       'bankque'));
      l_txmsg.txPrintInfo(l_fldname).holdamt := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                                       'holdamt'));
      l_txmsg.txPrintInfo(l_fldname).value := xmldom.getnodevalue(xmldom.getfirstchild(l_node));
      plog.debug(pkgctx,'printinfo(' || l_fldname || '): ' ||
                           l_txmsg.txPrintInfo(l_fldname).value);

    END LOOP;

    plog.debug(pkgctx,'Prepare to parse Feemap');
    l_nodeList := xslprocessor.selectnodes(xmldom.makenode(l_doc),
                                           '/TransactMessage/feemap/entry');

    FOR i IN 0 .. xmldom.getlength(l_nodeList) - 1 LOOP
      plog.debug(pkgctx,'parse feemap: ' || i);
      l_node := xmldom.item(l_nodeList, i);
      l_txmsg.txInfo(l_fldname)(txnums.C_FEETRAN_FEECD) := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                                                   'feecd'));
      l_txmsg.txInfo(l_fldname)(txnums.C_FEETRAN_GLACCTNO) := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                                                      'glacctno'));
      l_txmsg.txInfo(l_fldname)(txnums.C_FEETRAN_FEEAMT) := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                                                    'feeamt'));
      l_txmsg.txInfo(l_fldname)(txnums.C_FEETRAN_VATAMT) := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                                                    'vatamt'));
      l_txmsg.txInfo(l_fldname)(txnums.C_FEETRAN_TXAMT) := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                                                   'txamt'));
      l_txmsg.txInfo(l_fldname)(txnums.C_FEETRAN_FEERATE) := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                                                     'feerate'));
      l_txmsg.txInfo(l_fldname)(txnums.C_FEETRAN_VATRATE) := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                                                     'vatrate'));
    END LOOP;

    plog.debug(pkgctx,'Prepare to parse vatvoucher');
    l_nodeList := xslprocessor.selectnodes(xmldom.makenode(l_doc),
                                           '/TransactMessage/vatvoucher/entry');

    FOR i IN 0 .. xmldom.getlength(l_nodeList) - 1 LOOP
      plog.debug(pkgctx,'parse vatvoucher: ' || i);
      l_node := xmldom.item(l_nodeList, i);
      l_txmsg.txInfo(l_fldname)(txnums.C_VATTRAN_VOUCHERNO) := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                                                       'voucherno'));
      l_txmsg.txInfo(l_fldname)(txnums.C_VATTRAN_VOUCHERTYPE) := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                                                         'vouchertype'));
      l_txmsg.txInfo(l_fldname)(txnums.C_VATTRAN_SERIALNO) := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                                                      'serieno'));
      l_txmsg.txInfo(l_fldname)(txnums.C_VATTRAN_VOUCHERDATE) := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                                                         'voucherdate'));
      l_txmsg.txInfo(l_fldname)(txnums.C_VATTRAN_CUSTID) := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                                                    'custid'));
      l_txmsg.txInfo(l_fldname)(txnums.C_VATTRAN_TAXCODE) := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                                                     'taxcode'));
      l_txmsg.txInfo(l_fldname)(txnums.C_VATTRAN_CUSTNAME) := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                                                      'custname'));
      l_txmsg.txInfo(l_fldname)(txnums.C_VATTRAN_ADDRESS) := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                                                     'address'));
      l_txmsg.txInfo(l_fldname)(txnums.C_VATTRAN_CONTENTS) := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                                                      'contents'));
      l_txmsg.txInfo(l_fldname)(txnums.C_VATTRAN_QTTY) := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                                                  'qtty'));
      l_txmsg.txInfo(l_fldname)(txnums.C_VATTRAN_PRICE) := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                                                   'price'));
      l_txmsg.txInfo(l_fldname)(txnums.C_VATTRAN_AMT) := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                                                 'amt'));
      l_txmsg.txInfo(l_fldname)(txnums.C_VATTRAN_VATRATE) := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                                                     'vatrate'));
      l_txmsg.txInfo(l_fldname)(txnums.C_VATTRAN_VATAMT) := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                                                    'vatamt'));
      l_txmsg.txInfo(l_fldname)(txnums.C_VATTRAN_DESCRIPTION) := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                                                         'description'));

    END LOOP;

    plog.debug(pkgctx,'Prepare to parse exception');
    l_nodeList := xslprocessor.selectnodes(xmldom.makenode(l_doc),
                                           '/TransactMessage/errorexception/entry');

    FOR i IN 0 .. xmldom.getlength(l_nodeList) - 1 LOOP
      plog.debug(pkgctx,'parse txException: ' || i);
      l_node := xmldom.item(l_nodeList, i);
      l_fldname := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                           'fldname'));
      l_txmsg.txException(l_fldname).type:= xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                                         'fldtype'));
      l_txmsg.txException(l_fldname).oldval := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                                        'oldval'));
      l_txmsg.txException(l_fldname).value := xmldom.getnodevalue(xmldom.getfirstchild(l_node));
      plog.debug(pkgctx,'Exception(' || l_fldname || '): ' ||
                           l_txmsg.txException(l_fldname).value);

    END LOOP;

    plog.debug(pkgctx,'Prepare to parse warning exception');
    l_nodeList := xslprocessor.selectnodes(xmldom.makenode(l_doc),
                                           '/TransactMessage/warningexception/entry');

    FOR i IN 0 .. xmldom.getlength(l_nodeList) - 1 LOOP
      plog.debug(pkgctx,'parse txWarningException: ' || i);
      l_node := xmldom.item(l_nodeList, i);
      l_fldname := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                           'errnum'));
      l_txmsg.txWarningException(l_fldname).errlev:= xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                                         'errlev'));
      l_txmsg.txWarningException(l_fldname).value := xmldom.getnodevalue(xmldom.getfirstchild(l_node));
      plog.debug(pkgctx,'WarningException(' || l_fldname || '): ' ||
                           l_txmsg.txWarningException(l_fldname).value);

    END LOOP;

    plog.debug(pkgctx,'Free resources associated');

    -- Free any resources associated with the document now it
    -- is no longer needed.
    DBMS_XMLDOM.freedocument(l_doc);
    -- Only used if variant is CLOB
    -- dbms_lob.freetemporary(p_xmlmsg);
    plog.setendsection(pkgctx, 'fn_xml2obj');
    RETURN l_txmsg;
  EXCEPTION
    WHEN OTHERS THEN
      --dbms_lob.freetemporary(p_xmlmsg);
      DBMS_XMLPARSER.freeparser(l_parser);
      DBMS_XMLDOM.freedocument(l_doc);
      plog.error(pkgctx, SQLERRM);
      plog.error (pkgctx, 'Loi tai dong: ' || dbms_utility.format_error_backtrace);
      plog.setendsection(pkgctx, 'fn_xml2obj');
      RAISE errnums.E_SYSTEM_ERROR;
  END fn_xml2obj;

  FUNCTION fn_obj2xml(p_txmsg tx.msg_rectype)
  RETURN VARCHAR2
  IS
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

   l_index varchar2(30); -- this must be match with arrtype index
   temp1          VARCHAR2 (32000);
   temp2          VARCHAR2 (2500);
BEGIN
   plog.setbeginsection(pkgctx, 'fn_obj2xml');

   l_parser              := xmlparser.newparser;
   xmlparser.parsebuffer (l_parser, '<TransactMessage/>');
   l_doc            := xmlparser.getdocument (l_parser);
   --xmldom.setversion (l_doc, '1.0');
   docnode        := xmldom.makenode (l_doc);

   --<< BEGIN OF CREATING MESSAGE HEADER>>
   l_element := xmldom.getdocumentelement(l_doc);
   xmldom.setattribute (l_element, 'msgtype', p_txmsg.msgtype);
   xmldom.setattribute (l_element, 'txnum', p_txmsg.txnum);
   xmldom.setattribute (l_element, 'reftxnum', p_txmsg.reftxnum);
   xmldom.setattribute (l_element, 'txdate', to_char(p_txmsg.txdate,systemnums.c_date_format));
   xmldom.setattribute (l_element, 'txtime', p_txmsg.txtime);
   xmldom.setattribute (l_element, 'mbid', p_txmsg.brid);
   xmldom.setattribute (l_element, 'tlid', p_txmsg.tlid);
   xmldom.setattribute (l_element, 'offid', p_txmsg.offid);
   xmldom.setattribute (l_element, 'ovrrqd', p_txmsg.ovrrqd);
   xmldom.setattribute (l_element, 'chid', p_txmsg.chid);
   xmldom.setattribute (l_element, 'chkid', p_txmsg.chkid);
   --xmldom.setattribute (l_element, 'actionflag', p_txmsg.txaction);
   xmldom.setattribute (l_element, 'tltxcd', p_txmsg.tltxcd);
   xmldom.setattribute (l_element, 'ibt', p_txmsg.ibt);
   xmldom.setattribute (l_element, 'brid2', p_txmsg.brid2);
   xmldom.setattribute (l_element, 'tlid2', p_txmsg.tlid2);
   xmldom.setattribute (l_element, 'ccyusage', p_txmsg.ccyusage);
   xmldom.setattribute (l_element, 'offline', p_txmsg.off_line);
   xmldom.setattribute (l_element, 'deltd', p_txmsg.deltd);
   xmldom.setattribute (l_element, 'brdate', to_char(p_txmsg.brdate,systemnums.c_date_format));
   --xmldom.setattribute (l_element, 'pageno', p_txmsg.pageno);
   --xmldom.setattribute (l_element, 'totalpage', p_txmsg.totalpage);
   xmldom.setattribute (l_element, 'busdate', to_char(p_txmsg.busdate,systemnums.c_date_format));
   xmldom.setattribute (l_element, 'txdesc', p_txmsg.txdesc);
   xmldom.setattribute (l_element, 'ipaddress', p_txmsg.ipaddress);
   xmldom.setattribute (l_element, 'wsname', p_txmsg.wsname);
   xmldom.setattribute (l_element, 'status', p_txmsg.txstatus);
   xmldom.setattribute (l_element, 'msgsts', p_txmsg.msgsts);
   xmldom.setattribute (l_element, 'ovrsts', p_txmsg.ovrsts);
   xmldom.setattribute (l_element, 'batchname', p_txmsg.batchname);
   xmldom.setattribute (l_element, 'msgamt', p_txmsg.msgamt);
   xmldom.setattribute (l_element, 'msgacct', p_txmsg.msgacct);

   xmldom.setattribute (l_element, 'feeamt', p_txmsg.feeamt);
   xmldom.setattribute (l_element, 'vatamt', p_txmsg.vatamt);
   xmldom.setattribute (l_element, 'voucher', p_txmsg.voucher);

   xmldom.setattribute (l_element, 'chktime', p_txmsg.chktime);
   xmldom.setattribute (l_element, 'offtime', p_txmsg.offtime);
   xmldom.setattribute (l_element, 'txtype', p_txmsg.txtype);
   xmldom.setattribute (l_element, 'nosubmit', p_txmsg.nosubmit);
   xmldom.setattribute (l_element, 'pretran', p_txmsg.pretran);

   --xmldom.setattribute (l_element, 'updatemode', p_txmsg.updatemode);
   xmldom.setattribute (l_element, 'local', p_txmsg.local);
   xmldom.setattribute (l_element, 'late', p_txmsg.late);
   --xmldom.setattribute (l_element, 'hosttime', p_txmsg.hosttime);
   --xmldom.setattribute (l_element, 'reference', p_txmsg.reference);
   xmldom.setattribute (l_element, 'glgp', p_txmsg.glgp);
   xmldom.setattribute (l_element, 'careby', p_txmsg.careby);
   xmldom.setattribute (l_element, 'warning', p_txmsg.warning);
   xmldom.setattribute (l_element, 'sessionid', p_txmsg.sessionid);
   xmldom.setattribute (l_element, 'updatemode', p_txmsg.updatemode);
   xmldom.setattribute (l_element, 'last_lvel', p_txmsg.last_lvel);
   xmldom.setattribute (l_element, 'last_dstatus', p_txmsg.last_dstatus);
   xmldom.setattribute (l_element, 'lvel', p_txmsg.lvel);
   xmldom.setattribute (l_element, 'dstatus', p_txmsg.dstatus);
   xmldom.setattribute (l_element, 'fmbid', p_txmsg.fmbid);
   xmldom.setattribute (l_element, 'tmbid', p_txmsg.tmbid);
   xmldom.setattribute (l_element, 'direction', p_txmsg.direction);
   xmldom.setattribute (l_element, 'errorcode', p_txmsg.errorcode);
   xmldom.setattribute (l_element, 'errordes', p_txmsg.errordes);
   xmldom.setattribute (l_element, 'status', p_txmsg.status);
   headernode   := xmldom.appendchild (docnode, xmldom.makenode (l_element));
   --<< END of creating Message Header>>

   l_element             := xmldom.createelement (l_doc, 'fields');
   childnode    := xmldom.appendchild (headernode, xmldom.makenode (l_element));
   -- Create Fields
   l_index := p_txmsg.txfields.FIRST;
   plog.debug(pkgctx,'abt to populate fields,l_index: ' || l_index);
   WHILE (l_index IS NOT NULL)
   LOOP
       plog.debug(pkgctx,'loop with l_index: ' || l_index || ':' || p_txmsg.txfields(l_index).defname);

       l_element := xmldom.createelement (l_doc, 'entry');

       xmldom.setattribute (l_element, 'fldname', l_index);
       xmldom.setattribute (l_element, 'fldtype', p_txmsg.txfields(l_index).type);
       xmldom.setattribute (l_element, 'defname', p_txmsg.txfields(l_index).defname);
       entrynode   := xmldom.appendchild (childnode, xmldom.makenode(l_element));

       textnode := xmldom.createTextNode(l_doc, p_txmsg.txfields(l_index).value);
       entrynode := xmldom.appendChild(entrynode, xmldom.makeNode(textnode));
       -- get the next field
       l_index := p_txmsg.txfields.NEXT (l_index);
   END LOOP;
   -- Populate printInfo
   l_element             := xmldom.createelement (l_doc, 'printinfo');
   childnode    := xmldom.appendchild (headernode, xmldom.makenode (l_element));

   l_index := p_txmsg.txPrintInfo.FIRST;
   plog.debug(pkgctx,'prepare to populate printinfo, l_index: ' || l_index);
   WHILE (l_index IS NOT NULL)
   LOOP
       plog.debug(pkgctx,'loop with l_index: ' || l_index);
       l_element             := xmldom.createelement (l_doc, 'entry');

       xmldom.setattribute (l_element, 'fldname', l_index);
       xmldom.setattribute (l_element, 'custname', p_txmsg.txPrintInfo(l_index).custname);
       xmldom.setattribute (l_element, 'address', p_txmsg.txPrintInfo(l_index).address);
       xmldom.setattribute (l_element, 'license', p_txmsg.txPrintInfo(l_index).license);
       xmldom.setattribute (l_element, 'custody', p_txmsg.txPrintInfo(l_index).custody);
       xmldom.setattribute (l_element, 'bankac', p_txmsg.txPrintInfo(l_index).bankac);
       xmldom.setattribute (l_element, 'bankname', p_txmsg.txPrintInfo(l_index).bankname);
       xmldom.setattribute (l_element, 'bankque', p_txmsg.txPrintInfo(l_index).bankque);
       xmldom.setattribute (l_element, 'holdamt', p_txmsg.txPrintInfo(l_index).holdamt);
       entrynode   := xmldom.appendchild (childnode, xmldom.makenode (l_element));

       textnode := xmldom.createTextNode(l_doc, p_txmsg.txPrintInfo(l_index).value);
       entrynode := xmldom.appendChild(entrynode, xmldom.makeNode(textnode));
       -- get the next field
       l_index := p_txmsg.txPrintInfo.NEXT (l_index);
   END LOOP;

   -- Populate printInfo
   l_element             := xmldom.createelement (l_doc, 'ErrorException');
   childnode    := xmldom.appendchild (headernode, xmldom.makenode (l_element));


   l_index := p_txmsg.txException.FIRST;
   plog.debug(pkgctx,'prepare to populate ErrorException, l_index: ' || l_index);
   WHILE (l_index IS NOT NULL)
   LOOP
       plog.debug(pkgctx,'loop with l_index: ' || l_index);
       l_element             := xmldom.createelement (l_doc, 'entry');

       xmldom.setattribute (l_element, 'fldname', l_index);
       xmldom.setattribute (l_element, 'type', p_txmsg.txException(l_index).type);
       xmldom.setattribute (l_element, 'oldval', p_txmsg.txException(l_index).oldval);
       entrynode   := xmldom.appendchild (childnode, xmldom.makenode (l_element));

       textnode := xmldom.createTextNode(l_doc, p_txmsg.txException(l_index).value);
       entrynode := xmldom.appendChild(entrynode, xmldom.makeNode(textnode));
       -- get the next field
       l_index := p_txmsg.txException.NEXT (l_index);
   END LOOP;

   -- warningmessage
   l_element             := xmldom.createelement (l_doc, 'WarningException');
   childnode    := xmldom.appendchild (headernode, xmldom.makenode (l_element));

   l_index := p_txmsg.txWarningException.FIRST;
   plog.debug(pkgctx,'prepare to populate WarningException, l_index: ' || l_index);
   WHILE (l_index IS NOT NULL)
   LOOP
       plog.debug(pkgctx,'loop with l_index: ' || l_index);
       l_element             := xmldom.createelement (l_doc, 'entry');

       xmldom.setattribute (l_element, 'errnum', l_index);
       xmldom.setattribute (l_element, 'errlev', p_txmsg.txWarningException(l_index).errlev);
       entrynode   := xmldom.appendchild (childnode, xmldom.makenode (l_element));

       textnode := xmldom.createTextNode(l_doc, p_txmsg.txWarningException(l_index).value);
       entrynode := xmldom.appendChild(entrynode, xmldom.makeNode(textnode));
       -- get the next field
       l_index := p_txmsg.txWarningException.NEXT (l_index);
   END LOOP;


   xmldom.writetobuffer (l_doc, temp1);
   plog.debug(pkgctx,'got xml,length: ' || length(temp1));
   plog.debug(pkgctx,'got xml: ' || SUBSTR (temp1, 1, 1500));
   plog.debug(pkgctx,'got xml: ' || SUBSTR (temp1, 1501, 3000));
   plog.setendsection(pkgctx, 'fn_obj2xml');
   return temp1;
-- deal with exceptions
EXCEPTION
   WHEN others
   THEN
      plog.error(pkgctx,SQLERRM);
      plog.setendsection(pkgctx, 'fn_obj2xml');
      RAISE errnums.E_SYSTEM_ERROR;
END;
  --msg for maintenance form
  FUNCTION fn_mt_xml2obj(p_xmlmsg    VARCHAR2) RETURN tx.obj_rectype IS
    l_parser   xmlparser.parser;
    l_doc      xmldom.domdocument;
    l_nodeList xmldom.domnodelist;
    l_node     xmldom.domnode;

    l_fldname fldmaster.fldname%TYPE;
    l_txmsg   tx.obj_rectype;
  BEGIN
    plog.setbeginsection (pkgctx, 'fn_mt_xml2obj');

    plog.error(pkgctx,'msg fn_mt_xml2obj:' || p_xmlmsg);
    l_parser := xmlparser.newparser();
    plog.debug(pkgctx,'1');
    xmlparser.parseclob(l_parser, p_xmlmsg);
    plog.debug(pkgctx,'2');
    l_doc := xmlparser.getdocument(l_parser);
    plog.debug(pkgctx,'3');
    xmlparser.freeparser(l_parser);

    plog.debug(pkgctx,'Prepare to parse Message Header');
    l_nodeList := xslprocessor.selectnodes(xmldom.makenode(l_doc),
                                           '/ObjectMessage');
    --<<Begin of header transformation>>
    FOR i IN 0 .. xmldom.getlength(l_nodeList) - 1 LOOP
      plog.debug(pkgctx,'parse header i: ' || i);
      l_node         := xmldom.item(l_nodeList, i);
      l_txmsg.TXDATE  := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                'TXDATE'));
      l_txmsg.TXNUM  := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                'TXNUM'));
      l_txmsg.TXTIME := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                        'TXTIME'));
      l_txmsg.TLID := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                'TLID'));
      l_txmsg.MBID := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                              'MBID'));
      l_txmsg.LOCAL := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                              'LOCAL'));
      l_txmsg.MSGTYPE := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                               'MSGTYPE'));
      l_txmsg.OBJNAME := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                'OBJNAME'));
      l_txmsg.ACTIONFLAG := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                              'ACTIONFLAG'));
      l_txmsg.CMDINQUIRY := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                               'CMDINQUIRY'));
      l_txmsg.CLAUSE := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                  'CLAUSE'));
      l_txmsg.FUNCTIONNAME := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                'FUNCTIONNAME'));
      l_txmsg.AUTOID := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                             'AUTOID'));
      l_txmsg.REFERENCE := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                               'REFERENCE'));
      l_txmsg.RESERVER := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                               'RESERVER'));
      l_txmsg.IPADDRESS := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                  'IPADDRESS'));
      l_txmsg.CMDTYPE := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                  'CMDTYPE'));
      l_txmsg.PARENTOBJNAME := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                               'PARENTOBJNAME'));
      l_txmsg.PARENTCLAUSE := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                'PARENTCLAUSE'));
      l_txmsg.SESSIONID := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                   'SESSIONID'));
      l_txmsg.REQUESTID := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                'REQUESTID'));
      l_txmsg.CHILDTABLE := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                'CHILDTABLE'));
    END LOOP;
    --<<End of header transformation>>

    --<<Begin of fields transformation>>
    plog.debug(pkgctx,'Prepare to parse Message Fields');
    l_nodeList := xslprocessor.selectnodes(xmldom.makenode(l_doc),
                                           '/ObjectMessage/ObjData/Entry');

    FOR i IN 0 .. xmldom.getlength(l_nodeList) - 1 LOOP
      plog.debug(pkgctx,'parse fields: ' || i);
      l_node := xmldom.item(l_nodeList, i);
      l_fldname := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                           'fldname'));
      l_txmsg.OBJFIELDS(l_fldname).fldtype := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                                  'fldtype'));
      l_txmsg.OBJFIELDS(l_fldname).fldname := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                                     'fldname'));
      l_txmsg.OBJFIELDS(l_fldname).oldval := xmldom.getvalue(xmldom.getattributenode(xmldom.makeelement(l_node),
                                                                                     'oldval'));
      l_txmsg.OBJFIELDS(l_fldname).value := xmldom.getnodevalue(xmldom.getfirstchild(l_node));
      plog.debug(pkgctx,'l_fldname(' || l_fldname || '): ' ||
                           l_txmsg.OBJFIELDS(l_fldname).value);

    END LOOP;

    -- Free any resources associated with the document now it
    -- is no longer needed.
    DBMS_XMLDOM.freedocument(l_doc);
    -- Only used if variant is CLOB
    -- dbms_lob.freetemporary(p_xmlmsg);
    plog.setendsection(pkgctx, 'fn_mt_xml2obj');
    RETURN l_txmsg;
  EXCEPTION
    WHEN OTHERS THEN
      --dbms_lob.freetemporary(p_xmlmsg);
      DBMS_XMLPARSER.freeparser(l_parser);
      DBMS_XMLDOM.freedocument(l_doc);
      plog.error(pkgctx, SQLERRM);
      plog.error (pkgctx, 'Loi tai dong: ' || dbms_utility.format_error_backtrace);
      plog.setendsection(pkgctx, 'fn_mt_xml2obj');
      RAISE errnums.E_SYSTEM_ERROR;
  END;

  FUNCTION fn_mt_obj2xml(p_txmsg tx.obj_rectype)
  RETURN VARCHAR2
  IS
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

   l_index varchar2(30); -- this must be match with arrtype index
   temp1          VARCHAR2 (32000);
   temp2          VARCHAR2 (2500);
BEGIN
   plog.setbeginsection(pkgctx, 'fn_mt_obj2xml');

   l_parser              := xmlparser.newparser;
   xmlparser.parsebuffer (l_parser, '<ObjectMessage/>');
   l_doc            := xmlparser.getdocument (l_parser);
   --xmldom.setversion (l_doc, '1.0');
   docnode        := xmldom.makenode (l_doc);

   --<< BEGIN OF CREATING MESSAGE HEADER>>
   l_element := xmldom.getdocumentelement(l_doc);
   xmldom.setattribute (l_element, 'TXDATE', p_txmsg.TXDATE);
   xmldom.setattribute (l_element, 'TXNUM', p_txmsg.TXNUM);
   xmldom.setattribute (l_element, 'TXTIME', p_txmsg.TXTIME);
   xmldom.setattribute (l_element, 'TLID', p_txmsg.TLID);
   xmldom.setattribute (l_element, 'MBID', p_txmsg.MBID);
   xmldom.setattribute (l_element, 'LOCAL', p_txmsg.LOCAL);
   xmldom.setattribute (l_element, 'MSGTYPE', p_txmsg.MSGTYPE);
   xmldom.setattribute (l_element, 'OBJNAME', p_txmsg.OBJNAME);
   xmldom.setattribute (l_element, 'ACTIONFLAG', p_txmsg.ACTIONFLAG);
   xmldom.setattribute (l_element, 'CMDINQUIRY', p_txmsg.CMDINQUIRY);
   xmldom.setattribute (l_element, 'CLAUSE', p_txmsg.CLAUSE);
   xmldom.setattribute (l_element, 'FUNCTIONNAME', p_txmsg.FUNCTIONNAME);
   xmldom.setattribute (l_element, 'AUTOID', p_txmsg.AUTOID);
   xmldom.setattribute (l_element, 'REFERENCE', p_txmsg.REFERENCE);
   xmldom.setattribute (l_element, 'RESERVER', p_txmsg.RESERVER);
   xmldom.setattribute (l_element, 'IPADDRESS', p_txmsg.IPADDRESS);
   xmldom.setattribute (l_element, 'CMDTYPE', p_txmsg.CMDTYPE);
   xmldom.setattribute (l_element, 'PARENTOBJNAME', p_txmsg.PARENTOBJNAME);
   xmldom.setattribute (l_element, 'PARENTCLAUSE', p_txmsg.PARENTCLAUSE);
   xmldom.setattribute (l_element, 'SESSIONID', p_txmsg.SESSIONID);
   xmldom.setattribute (l_element, 'REQUESTID', p_txmsg.REQUESTID);
   xmldom.setattribute (l_element, 'CHILDTABLE', p_txmsg.CHILDTABLE);

   headernode   := xmldom.appendchild (docnode, xmldom.makenode (l_element));
   --<< END of creating Message Header>>

   l_element             := xmldom.createelement (l_doc, 'ObjData');
   childnode    := xmldom.appendchild (headernode, xmldom.makenode (l_element));
   -- Create Fields
   l_index := p_txmsg.OBJFIELDS.FIRST;
   plog.debug(pkgctx,'abt to populate fields,l_index: ' || l_index);
   WHILE (l_index IS NOT NULL)
   LOOP
       plog.debug(pkgctx,'loop with l_index: ' || l_index || ':' || p_txmsg.OBJFIELDS(l_index).fldname);

       l_element := xmldom.createelement (l_doc, 'entry');

       xmldom.setattribute (l_element, 'fldname', l_index);
       xmldom.setattribute (l_element, 'fldtype', p_txmsg.OBJFIELDS(l_index).fldtype);
       xmldom.setattribute (l_element, 'oldval', p_txmsg.OBJFIELDS(l_index).oldval);

       entrynode   := xmldom.appendchild (childnode, xmldom.makenode(l_element));
       textnode := xmldom.createTextNode(l_doc, p_txmsg.OBJFIELDS(l_index).value);
       entrynode := xmldom.appendChild(entrynode, xmldom.makeNode(textnode));
       -- get the next field
       l_index := p_txmsg.OBJFIELDS.NEXT (l_index);
   END LOOP;


   xmldom.writetobuffer (l_doc, temp1);
   plog.debug(pkgctx,'got xml,length: ' || length(temp1));
   plog.debug(pkgctx,'got xml: ' || SUBSTR (temp1, 1, 1500));
   plog.debug(pkgctx,'got xml: ' || SUBSTR (temp1, 1501, 3000));
   plog.setendsection(pkgctx, 'fn_mt_obj2xml');
   return temp1;
-- deal with exceptions
EXCEPTION
   WHEN others
   THEN
      plog.error(pkgctx,SQLERRM);
      plog.setendsection(pkgctx, 'fn_mt_obj2xml');
      RAISE errnums.E_SYSTEM_ERROR;
END;

BEGIN
  FOR i IN (SELECT * FROM tlogdebug) LOOP
    logrow.loglevel  := i.loglevel;
    logrow.log4table := i.log4table;
    logrow.log4alert := i.log4alert;
    logrow.log4trace := i.log4trace;
  END LOOP;

  pkgctx := plog.init('txpks_msg',
                      plevel => NVL(logrow.loglevel,30),
                      plogtable => (NVL(logrow.log4table,'Y') = 'Y'),
                      palert => (logrow.log4alert = 'Y'),
                      ptrace => (logrow.log4trace = 'Y'));
END txpks_msg_stp;
/

DROP PACKAGE txpks_notify
/

CREATE OR REPLACE 
PACKAGE txpks_notify 
/** ----------------------------------------------------------------------------------------------------
 ** Module: NOTIFY
 ** Description: Function for Event Push notification
 ** and is copyrighted by FSS.
 **
 **    All rights reserved.  No part of this work may be reproduced, stored in a retrieval system,
 **    adopted or transmitted in any form or by any means, electronic, mechanical, photographic,
 **    graphic, optic recording or otherwise, translated in any language or computer language,
 **    without the prior written permission of Financial Software Solutions. JSC.
 **
 **  MODIFICATION HISTORY
 **  DuongLH      17/02/2016           Created
 **  System      05/10/2011     Created
 ** (c) 2016 by Financial Software Solutions. JSC.
 ----------------------------------------------------------------------------------------------------*/
IS
PROCEDURE pr_encodereftostringarray_db(
    pv_refcursor   IN            pkg_report.ref_cursor,
    maxrow         IN            NUMBER,
    maxpage        IN            NUMBER,
    vreturnarray      OUT        simplestringarraytype);
PROCEDURE PR_FLEX2FO_ENQUEUE (PV_REFCURSOR IN pkg_report.ref_cursor,
queue_name IN VARCHAR2,
enq_msgid IN OUT RAW);
PROCEDURE pr_InvokeEnqueueTest;

PROCEDURE PR_NOTIFYEVENT2FO(
    pv_refcursor   IN            pkg_report.ref_cursor,
    queue_name IN VARCHAR2 default 'PUSH2FO');

procedure prc_system_logevent(p_objname varchar2, p_objkey varchar2, p_objvalue varchar2, p_actions varchar2, p_note varchar2);

  PROCEDURE PR_BATCH_NOTIFY (p_error_code OUT VARCHAR2);

  procedure prc_system_jsonnotify(p_autoid number) ;

  function prc_system_process_sendemail(p_autoid integer)
   RETURN varchar2;

  TYPE str_array IS TABLE OF VARCHAR2(4000) INDEX BY BINARY_INTEGER;

  FUNCTION Split(p_in_string VARCHAR2, p_delim VARCHAR2) RETURN str_array;

  PROCEDURE sp_set_message_queue(f_content IN VARCHAR, f_queue IN VARCHAR, autocommit IN VARCHAR2 DEFAULT 'Y') ;

END;
/

CREATE OR REPLACE 
PACKAGE BODY txpks_notify
IS
   pkgctx   plog.log_ctx;
   logrow   tlogdebug%ROWTYPE;
   ownerschema VARCHAR2(100);
 PROCEDURE pr_encodereftostringarray_db(
    pv_refcursor   IN            pkg_report.ref_cursor,
    maxrow         IN            NUMBER,
    maxpage        IN            NUMBER,
    vreturnarray      OUT        simplestringarraytype)
IS
--  GEN FIX MESSAGE FROM REF CURSOR
-- ---------   ------  -------------------------------------------
    v_cursor_number NUMBER;
    v_columns NUMBER;
    v_desc_tab dbms_sql.desc_tab;
    v_refcursor pkg_report.ref_cursor;
    v_number_value NUMBER;
    v_varchar_value VARCHAR(200);
    v_date_value DATE;
    l_str_val VARCHAR2(4000);
    l_spliter CHAR(1):=CHR(1);
    l_prefix VARCHAR2(10):= '8=FIX..';
    l_str_header VARCHAR2(4000);
    l_arr_msg simplestringarraytype := simplestringarraytype(1);
BEGIN
    plog.setbeginsection (pkgctx, 'pr_encodereftostringarray_db');
    --plog.debug(pkgctx, 'abt to encode refcursor maxrow, maxpage: ' || maxrow||','||maxpage);

    --Call procedure to open cursor
    v_refcursor := pv_refcursor;
    --Convert cursor to DBMS_SQL CURSOR
    v_cursor_number := dbms_sql.to_cursor_number(v_refcursor);
    --Get information on the columns
    dbms_sql.describe_columns(v_cursor_number, v_columns, v_desc_tab);
    --Loop through all the columns, find columname position and TYPE
--Get columns
    l_str_header := l_prefix|| l_spliter;
    FOR i IN 1 .. v_desc_tab.COUNT LOOP
            IF v_desc_tab(i).col_type = dbms_types.typecode_number THEN
            --Number
            l_str_header :=  l_str_header  || v_desc_tab(i).col_name|| l_spliter ;
                dbms_sql.define_column(v_cursor_number, i, v_number_value);
            ELSIF v_desc_tab(i).col_type = dbms_types.typecode_varchar
                OR  v_desc_tab(i).col_type = dbms_types.typecode_char THEN
            --Varchar, char
                l_str_header :=  l_str_header  || v_desc_tab(i).col_name|| l_spliter ;
                dbms_sql.define_column(v_cursor_number, i, v_varchar_value,200);
            ELSIF v_desc_tab(i).col_type = dbms_types.typecode_date THEN
            --Date,
               l_str_header :=  l_str_header  || v_desc_tab(i).col_name|| l_spliter ;
               dbms_sql.define_column(v_cursor_number, i, v_date_value);
            END IF;
    END LOOP;
--Get values
    WHILE dbms_sql.fetch_rows(v_cursor_number) > 0 LOOP
        l_str_val := l_prefix|| l_spliter;
     FOR i IN 1 .. v_desc_tab.COUNT LOOP
          IF v_desc_tab(i).col_type = dbms_types.typecode_number THEN
          --Number
                dbms_sql.column_value(v_cursor_number, i, v_number_value);
                l_str_val :=l_str_val|| nvl(v_number_value,0) || l_spliter;
          END IF;
          IF v_desc_tab(i).col_type = dbms_types.typecode_varchar
            OR  v_desc_tab(i).col_type = dbms_types.typecode_char
            THEN
          --Varchar, char
                dbms_sql.column_value(v_cursor_number, i, v_varchar_value);
                l_str_val :=l_str_val|| nvl(v_varchar_value,'null') || l_spliter;
          END IF;
          IF v_desc_tab(i).col_type = dbms_types.typecode_date
            THEN
          --Date
                dbms_sql.column_value(v_cursor_number, i, v_date_value);
                l_str_val :=l_str_val|| to_char(v_date_value,'yyyymmdd-hh:mm:ss') || l_spliter;
          END IF;
    END LOOP;
    l_str_header:=l_str_header||l_str_val;
    END LOOP;
    l_arr_msg(1):= l_str_header;
    vreturnarray := l_arr_msg;
    dbms_sql.close_cursor(v_cursor_number);
    plog.setendsection (pkgctx, 'pr_encodereftostringarray_db');
EXCEPTION WHEN OTHERS THEN
    l_arr_msg(1):= '';
    vreturnarray := l_arr_msg;
    plog.error (pkgctx, '[maxrow:' || maxrow || '],[maxpage:' || maxpage || ']' || SQLERRM);
    plog.error (pkgctx, '[Format_error_backtrace] ' || dbms_utility.format_error_backtrace); --Log trace
    plog.setendsection (pkgctx, 'pr_encodereftostringarray_db');
END pr_encodereftostringarray_db;

PROCEDURE PR_FLEX2FO_ENQUEUE (PV_REFCURSOR IN pkg_report.ref_cursor,
queue_name IN VARCHAR2,
enq_msgid IN OUT RAW)
IS
   tmp_text_message   SYS.AQ$_JMS_TEXT_MESSAGE;
   eopt               DBMS_AQ.enqueue_options_t;
   mprop              DBMS_AQ.message_properties_t;
   tmp_encode_text    VARCHAR2 (32767);
   l_array_msg SimpleStringArrayType := SimpleStringArrayType();
BEGIN
    plog.setbeginsection (pkgctx, 'PR_FLEX2FO_ENQUEUE');
    --plog.debug(pkgctx, 'abt to PR_FLEX2FO_ENQUEUE refcursor queue_name, enq_msgid: ' || queue_name||','||enq_msgid);
    pr_encodereftostringarray_db(PV_REFCURSOR => PV_REFCURSOR,
                              vReturnArray => l_array_msg,
                              maxRow       => 5,
                              maxPage      => 255);

    for i in 1 .. l_array_msg.COUNT
    loop
      tmp_encode_text := l_array_msg(i);
      if LENGTH(tmp_encode_text) > 1 then
        tmp_text_message := SYS.AQ$_JMS_TEXT_MESSAGE.construct;
        tmp_text_message.set_text(tmp_encode_text);
        DBMS_AQ.ENQUEUE(queue_name         => ownerschema ||
                                              '.' || queue_name,
                        enqueue_options    => eopt,
                        message_properties => mprop,
                        payload            => tmp_text_message,
                        msgid              => enq_msgid);


      end if;
      --DBMS_OUTPUT.PUT_LINE('PL/SQL element ' || i || ' obtains the value "' || vArray(i) || '".');
    end loop;
    --COMMIT;
    plog.setendsection (pkgctx, 'PR_FLEX2FO_ENQUEUE');
EXCEPTION WHEN OTHERS THEN
    plog.error (pkgctx, '[queue_name:' || queue_name || '],[enq_msgid:' || enq_msgid || ']' || SQLERRM);
    plog.error (pkgctx, '[Format_error_backtrace] ' || dbms_utility.format_error_backtrace); --Log trace
    plog.setendsection (pkgctx, 'PR_FLEX2FO_ENQUEUE');
END PR_FLEX2FO_ENQUEUE;

PROCEDURE pr_InvokeEnqueueTest
IS
    rs VARCHAR2(4000);
    pv_ref pkg_report.ref_cursor;
    enq_msgid RAW(16);
begin
    plog.setbeginsection (pkgctx, 'pr_InvokeEnqueueTest');
    --plog.debug(pkgctx, 'abt to pr_InvokeEnqueueTest refcursor');
    OPEN pv_ref for SELECT * from afmast where rownum <=3;
    PR_FLEX2FO_ENQUEUE(PV_REFCURSOR=>pv_ref, ENQ_MSGID=>enq_msgid, queue_name=>'PUSH2FO');
    --plog.debug(pkgctx, 'ID:'||enq_msgid);
    close pv_ref;
    commit;
    plog.setendsection (pkgctx, 'pr_InvokeEnqueueTest');
EXCEPTION WHEN OTHERS THEN
    plog.error (pkgctx, SQLERRM);
    plog.error (pkgctx, '[Format_error_backtrace] ' || dbms_utility.format_error_backtrace); --Log trace
    plog.setendsection (pkgctx, 'pr_InvokeEnqueueTest');
end pr_InvokeEnqueueTest;

PROCEDURE PR_NOTIFYEVENT2FO(
    pv_refcursor   IN            pkg_report.ref_cursor,
    queue_name IN VARCHAR2 default 'PUSH2FO')
IS
    enq_msgid RAW(16);
BEGIN
    plog.setbeginsection (pkgctx, 'PR_NOTIFYEVENT2FO');
    --plog.debug(pkgctx, 'abt to PR_NOTIFYEVENT refcursor');
    PR_FLEX2FO_ENQUEUE(PV_REFCURSOR=>pv_refcursor, ENQ_MSGID=>enq_msgid, queue_name=> queue_name);
    --plog.debug(pkgctx, 'ENQUEUE ID:'||enq_msgid);
    plog.setendsection (pkgctx, 'PR_NOTIFYEVENT2FO');
EXCEPTION WHEN OTHERS THEN
    plog.error (pkgctx, SQLERRM);
    plog.error (pkgctx, '[Format_error_backtrace] ' || dbms_utility.format_error_backtrace); --Log trace
    plog.setendsection (pkgctx, 'PR_NOTIFYEVENT2FO');
END PR_NOTIFYEVENT2FO;



procedure prc_system_notifyevent2fo(p_autoid number)
as
/**----------------------------------------------------------------------------------------------------
 **  FUNCTION: prc_system_notifyevent2fo: X? l� G?i t�n hi?u d?ng b? FO cho serviceMIX
 **  Person         Date            Comments
 **  ThaiTQ         2020/11/30      Created
 ** (c) 2020 by Financial Software Solutions. JSC.
 ** ----------------------------------------------------------------------------------------------------*/
    -- declare log context
    pkgctx   plog.log_ctx;
    logrow   tlogdebug%ROWTYPE;


    l_result        varchar2(20);
    l_count         number;
    payload         pkg_report.ref_cursor;
BEGIN
    plog.setbeginsection(pkgctx, 'prc_system_notifyevent2fo');
    l_result    := fn_systemnums('systemnums.C_SYSTEM_ERROR');

    for rec in
    (
        SELECT autoid, objname, objkey, objvalue, msgtype, status, note, lastchange
        FROM event_log
        where autoid = p_autoid and status ='P'
    )loop
        if rec.status ='P' then
            OPEN payload for
            SELECT rec.msgtype "msgtype",  rec.objkey "datatype", rec.objvalue "refid"
            from dual;

            PR_NOTIFYEVENT2FO(PV_REFCURSOR=>payload, queue_name=>'PUSH2FO');
            COMMIT;

            update event_log set status='A'
            where objname= rec.objname
                and objkey= rec.objkey
                and objvalue= rec.objvalue;
        end if;
    end loop;

    l_result := fn_systemnums('systemnums.C_SUCCESS');

    plog.setendsection(pkgctx, 'prc_system_notifyevent2fo');
    commit;
  exception
    when others then
      plog.error(pkgctx, sqlerrm);
      plog.setendsection(pkgctx, 'prc_system_notifyevent2fo');
end;

procedure prc_system_logevent(p_objname varchar2, p_objkey varchar2, p_objvalue varchar2, p_actions varchar2, p_note varchar2)
as
/**----------------------------------------------------------------------------------------------------
 **  FUNCTION: prc_system_logevent: X? l� t?o log t�n hi?u d? g?i cho serviceMIX
 **  Person         Date            Comments
 **  ThaiTQ         2020/11/30      Created
 ** (c) 2020 by Financial Software Solutions. JSC.
 ** ----------------------------------------------------------------------------------------------------*/

    v_logsctx       varchar2(500);
    v_logsbody      varchar2(500);
    v_exception     varchar2(500);
    l_result        varchar2(20);
    l_count         number;
    l_autoid        integer;
    payload         varchar2(500);
    l_autoNotify    varchar2(50);
BEGIN
    plog.setbeginsection(pkgctx, 'prc_system_notifyevent2fo');
    l_result    := fn_systemnums('systemnums.C_SUCCESS');

    select varvalue into l_autoNotify from sysvar where varname = 'AUTONOTIFY';
    if nvl(l_autoNotify,'N') = 'Y' then
        l_autoid := event_log_autoid_seq.nextval;

        INSERT INTO event_log(autoid,objname, objkey, objvalue, msgtype, status, note, lastchange)
        VALUES(l_autoid, p_objname, p_objkey, p_objvalue, p_actions, 'P', p_note,  CURRENT_TIMESTAMP);

        prc_system_notifyevent2fo(l_autoid);

    end if;
    plog.setendsection(pkgctx, 'prc_system_notifyevent2fo');
    commit;
  exception
    when others then
      plog.error(pkgctx, sqlerrm);
      plog.setendsection(pkgctx, 'prc_system_notifyevent2fo');
end;



function prc_system_process_sendemail(p_autoid integer)
 RETURN varchar2
as
    my_result varchar2(32000);
    payload varchar2(32000);
    genattachments varchar2(32000);
    v_strHTML   varchar2(32000);
    v_logsctx           varchar2(32000);
    v_logsbody          varchar2(32000);
    v_exception         varchar2(32000);
    l_result        varchar2(20);
    l_count         number;
    --rec             record;
    recdata         tx.rectype_emaillog;
    v_strDatasource varchar2(32000);
    v_strcontent    varchar2(32000);
    v_cursor        pkg_report.ref_cursor;
    v_attachments   varchar2(32000);
    v_fremail       varchar2(32000);
    l_subject       varchar2(32000);
BEGIN
    plog.setbeginsection(pkgctx, 'prc_system_process_sendemail');

    Begin
        select varvalue into v_fremail
        from sysvar where varname ='FROMEMAIL' and sysvar.grname='SYSTEM';
    exception
        when others then
            v_fremail := '"' || fn_systemnums('sysvar.brname') || '" <' || fn_systemnums('sysvar.info_email') || '>';
    End;


    Begin
        SELECT json_object    ('aid'        VALUE aid,
                               'afilename'          VALUE afilename,
                               'acontent'     VALUE acontent,
                               'aencoding'        VALUE aencoding,
                               'acontenttype' VALUE acontenttype,
                               'aprotocol' VALUE aprotocol,
                               'apath' VALUE apath,
                               'refid' VALUE to_char(refid)
                                               FORMAT JSON)
        into my_result
        from  mail_attach where refid = p_autoid;
    exception
        when others then
            select '[]' into my_result from dual;
    End;


    l_result    := '0';

    For rec in
    (
        select e.autoid, e.email, e.templateid, e.datasource, e.status, e.createtime, e.senttime,
                e.msgbody,  e.custodycd, e.refaccount, t.subject, t.subject_en,  t.msgtype,
                t.msgdatatype, t.msgcontent, t.msgcontenttype, t.msgattachcard
        from emaillog e, templates t
        where e.templateid = t.code
              and e.autoid = p_autoid
    )loop

        v_strDatasource := rec.datasource;

        v_strcontent    := rec.msgcontent;

        v_strcontent := REPLACE(v_strcontent, lower('[ecardlink]'), nvl(rec.msgattachcard,''));

        l_subject       := rec.subject||'/'||' '||rec.subject_en;

        for rec2 in (
            select * from sysvar
            where varname in ('HEADOFFICE','HEADOFFICE_EN','HEADADDRESS', 'HEADADDRESS_EN','LOGO_URL',
                'HEADPHONE','HEADFAX','HEADWEB','HEADEMAIL','HEADHOSTLINE', 'ETRADEWEB')
        ) loop
            v_strcontent := REPLACE(v_strcontent, '['||nvl(lower(rec2.varname),'')||']', nvl(rec2.varvalue,''));
            v_strcontent := REPLACE(v_strcontent, '['||nvl(upper(rec2.varname),'')||']', nvl(rec2.varvalue,''));
        end loop;


       open v_cursor for v_strDatasource;
       LOOP
          FETCH v_cursor INTO recdata;
          EXIT WHEN v_cursor%NOTFOUND;

            v_strcontent := REPLACE(v_strcontent, '['||nvl(recdata.varname,'')||']', nvl(recdata.varvalue,''));
            l_subject := REPLACE(l_subject, '['||nvl(recdata.varname,'')||']', nvl(recdata.varvalue,''));

            if rec.templateid = '320E' and nvl(recdata.varname,'')='p_shortcontent' then
                l_subject := nvl(recdata.varvalue,l_subject);
            end if;
       END LOOP;

        --update emaillog set msgbody = v_strcontent where autoid = p_autoid;

        SELECT json_object('from'        VALUE v_fremail,
                       'to'          VALUE rec.Email,
                       'subject'     VALUE l_subject,
                       'body'        VALUE v_strcontent,
                       'contentType' VALUE rec.msgcontenttype,
                       'attachments' VALUE my_result,
                       'charset' VALUE 'utf-8'
                                       FORMAT JSON)
        into payload from dual;

        --plog.debug(pkgctx, 'payload = ' || payload);
    End Loop;

    plog.setendsection(pkgctx, 'prc_system_process_sendemail');
    RETURN payload;
  exception
    when others then
      plog.error(pkgctx, sqlerrm);
      plog.setendsection(pkgctx, 'prc_system_process_sendemail');
      return null;
end prc_system_process_sendemail;

PROCEDURE PR_BATCH_NOTIFY (p_error_code OUT VARCHAR2)
IS
   v_currdate date;
BEGIN
    plog.setbeginsection (pkgctx, 'PR_BATCH_NOTIFY');
    v_currdate := getcurrdate();

    p_error_code  := systemnums.C_SUCCESS;

   --Load lai thong tin tai khoan
    txpks_notify.prc_system_logevent('CFMAST', 'ACCOUNTS', 'ALL'|| '~#~' ||'ALL'|| '~#~' ||'ALL', 'R','Batch refesh CFMAST');

   --Load lai thong tin tai khoan
    txpks_notify.prc_system_logevent('TLLOG', 'TRANS', 'ALL~#~ALL~#~'||to_char(v_currdate,fn_systemnums('systemnums.C_DATE_FORMAT')), 'R','Batch refesh TLLOG');

    --load thong tin oxpost
    txpks_notify.prc_system_logevent('OXPOST', 'OXPOSTS', 'ALL~#~ALL~#~ALL', 'R','Batch refesh OXPOST');

    --load thong tin oxmast
    txpks_notify.prc_system_logevent('OXMAST', 'OXMASTS', 'ALL~#~ALL~#~ALL', 'R','Batch refesh OXMAST');

    plog.setendsection (pkgctx, 'PR_BATCH_NOTIFY');
EXCEPTION
    WHEN OTHERS THEN
        p_error_code := errnums.c_system_error;
        plog.error(pkgctx, sqlerrm);
        plog.setendsection (pkgctx, 'PR_BATCH_NOTIFY');
END PR_BATCH_NOTIFY;

procedure prc_system_jsonnotify(p_autoid number)
as
/**----------------------------------------------------------------------------------------------------
 **  FUNCTION: prc_system_jsonnotify: X? l� G?i t�n hi?u g?i Email/SMS cho serviceMIX
 **  Person         Date            Comments
 **  ThaiTQ         2020/12/03      Created
 ** (c) 2018 by Financial Software Solutions. JSC.
 ** ----------------------------------------------------------------------------------------------------*/

    l_result        varchar2(20);
    l_count         number;
    payload         pkg_report.ref_cursor;
    l_datasource    varchar2(32000);
    l_emailsmsmod   varchar2(1);
    l_content       varchar2(32000);
BEGIN
    plog.setbeginsection(pkgctx, 'prc_system_jsonnotify');
    l_result    := fn_systemnums('systemnums.C_SUCCESS');

    select varvalue into l_emailsmsmod  from sysvar
        where grname ='SYSTEM' and varname='EMAILSMSMOD';

    l_emailsmsmod :=nvl(l_emailsmsmod,'N');

    if l_emailsmsmod <>'Y' then
        update emaillog
            set status= 'R', feedbackmsg = 'System disable email/sms'
        where autoid = p_autoid;
    else
        For rec in
        (
            select e.autoid, e.email, e.templateid, e.datasource, e.status, e.createtime, e.senttime,
                    e.msgbody,  e.custodycd, e.refaccount, t.subject, t.subject_en,  t.msgtype,
                    t.msgdatatype, t.msgcontent, t.msgcontenttype, t.type
            from emaillog e, templates t
            where e.templateid = t.code
                  and e.autoid = p_autoid
                  and e.status ='A'
                  and t.type in ('E'/*, 'S'*/)

        )Loop

        if rec.type = 'S' then

            l_datasource := rec.datasource;
            update emaillog set msgbody = l_datasource where autoid = rec.autoid;

            if length(rec.email) >=10 and rec.email like '0%' then
                /*OPEN payload for
                SELECT 'S' "msgtype",
                       'sms' "datatype",
                       rec.autoid "refid",
                       l_datasource "text",
                       fn_systemnums('sysvar.brname') "brandname",
                       rec.email "to",
                       'update emaillog set status = ''E'' where autoid='||rec.autoid || ' ' "updateerror",
                       'update emaillog set status = ''S'', senttime = current_timestamp where autoid='||rec.autoid || ' ' "updatesuccess"
                from dual;

                PR_NOTIFYEVENT2FO(PV_REFCURSOR=>payload, queue_name=>'TXAQS_RPTFLEX2FO');*/

                l_content := '{"msgtype":"'||'S'||'", ' ||
                '"datatype":"'||'sms'||'", ' ||
                '"refid":"'||rec.autoid||'", ' ||
                '"text":"'||l_datasource||'", ' ||
                '"brandname":"'||fn_systemnums('sysvar.brname')||'", ' ||
                '"to":"'||rec.email||'", ' ||
                '"updateerror":"'||'update emaillog set status = ''E'' where autoid='||rec.autoid || ' '||'", ' ||
                '"updatesuccess":"'||'update emaillog set status = ''S'', senttime = current_timestamp where autoid='||rec.autoid || ' '||'"}'
                ;

                sp_set_message_queue(f_content=>l_content,f_queue=>'TXAQS_RPTFLEX2FO',autocommit=>'N');

                update emaillog
                    set status='N', feedbackmsg ='Sent to Queue'
                where autoid = rec.autoid;

            else
                update emaillog
                    set status='R', feedbackmsg ='Invalid phone number'
                where autoid = rec.autoid;

            end if;
            else
                -- Check n?u d?a ch? email kh�ng d�ng --> reject lu�n kh�ng g?i v�o serviceMIX
                if not REGEXP_LIKE (rec.email, '^[A-Za-z]+[A-Za-z0-9.]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$') then
                    update emaillog
                        set status='R', feedbackmsg = 'Invalid Email'
                    where autoid = rec.autoid;
                else
                    /*OPEN payload for
                    SELECT rec.msgtype "msgtype",
                           rec.msgdatatype "datatype",
                           rec.autoid "refid",
                           'SELECT txpks_notify.prc_system_process_sendemail(' || p_autoid || ') "email" from dual' "func",
                           'update emaillog set status = ''E'' where autoid='||rec.autoid || ' ' "updateerror",
                           'update emaillog set status = ''S'', senttime = current_timestamp where autoid='||rec.autoid || ' ' "updatesuccess"
                    from dual;

                    PR_NOTIFYEVENT2FO(PV_REFCURSOR=>payload, queue_name=>'TXAQS_RPTFLEX2FO');*/

                    l_content := '{"msgtype":"'||rec.msgtype||'", ' ||
                    '"datatype":"'||rec.msgdatatype||'", ' ||
                    '"refid":"'||rec.autoid||'", ' ||
                    '"func":"'||'SELECT txpks_notify.prc_system_process_sendemail(' || p_autoid || ') email from dual'||'", ' ||
                    '"updateerror":"'||'update emaillog set status = ''E'' where autoid='||rec.autoid || ' '||'", ' ||
                    '"updatesuccess":"'||'update emaillog set status = ''S'', datasource = replace(datasource, otp, ''******''), msgbody = replace(msgbody, otp, ''******''), otp = ''******'', senttime = current_timestamp where autoid='||rec.autoid || ' '||'"}'
                    ;

                    sp_set_message_queue(f_content=>l_content,f_queue=>'TXAQS_RPTFLEX2FO',autocommit=>'N');

                    update emaillog
                        set status='N', feedbackmsg ='Sent to Queue'
                    where autoid = rec.autoid;
                end if;
            end if;


            INSERT INTO notify_log(objvalue, keyvalue, note, lastchanger)
            VALUES(rec.email, rec.autoid, rec.datasource, CURRENT_TIMESTAMP);



        End Loop;
    end if;


    plog.setendsection(pkgctx, 'prc_system_jsonnotify');
  exception
    when others then
      plog.error(pkgctx, sqlerrm);
      plog.setendsection(pkgctx, 'prc_system_jsonnotify');
end prc_system_jsonnotify;

FUNCTION Split (p_in_string VARCHAR2, p_delim VARCHAR2) RETURN str_array
   IS
    i       number :=0;
    pos     number :=0;
    lv_str  varchar2(4000) := p_in_string;
    strings str_array;
BEGIN
   strings(1) := p_in_string;
   -- determine first chuck of string
   pos := instr(lv_str,p_delim,1,1);
   -- while there are chunks left, loop
   WHILE ( pos != 0) LOOP
      -- increment counter
      i := i + 1;
      -- create array element for chuck of string
      strings(i) := substr(lv_str,1,pos-1);
      -- remove chunk from string
      lv_str := substr(lv_str,pos+1,length(lv_str));
      -- determine next chunk
      pos := instr(lv_str,p_delim,1,1);
      -- no last chunk, add to array
      IF pos = 0 THEN
         strings(i+1) := lv_str;
      END IF;
   END LOOP;
   -- return array
   RETURN strings;
END Split;

PROCEDURE sp_set_message_queue(f_content IN VARCHAR, f_queue IN VARCHAR, autocommit IN VARCHAR2 DEFAULT 'Y') AS
        r_enqueue_options    DBMS_AQ.ENQUEUE_OPTIONS_T;
        r_message_properties DBMS_AQ.MESSAGE_PROPERTIES_T;
        v_message_handle     RAW(16);
        o_payload            SYS.AQ$_JMS_TEXT_MESSAGE;
    BEGIN
        o_payload := SYS.AQ$_JMS_TEXT_MESSAGE.CONSTRUCT;
        o_payload.SET_TEXT(f_content);

        DBMS_AQ.ENQUEUE(
                queue_name         => f_queue,
                enqueue_options    => r_enqueue_options,
                message_properties => r_message_properties,
                payload            => o_payload,
                msgid              => v_message_handle
            );
        IF autocommit = 'Y' THEN
        COMMIT;
        END IF;

    END sp_set_message_queue;

--Init the plog component
BEGIN
      FOR i IN (SELECT *
                FROM tlogdebug)
      LOOP
         logrow.loglevel    := i.loglevel;
         logrow.log4table   := i.log4table;
         logrow.log4alert   := i.log4alert;
         logrow.log4trace   := i.log4trace;
      END LOOP;
      pkgctx    :=
         plog.init ('txpks_NOTIFY',
                    plevel => NVL(logrow.loglevel,30),
                    plogtable => (NVL(logrow.log4table,'N') = 'Y'),
                    palert => (NVL(logrow.log4alert,'N') = 'Y'),
                    ptrace => (NVL(logrow.log4trace,'N') = 'Y')
            );
      select sys_context('USERENV', 'CURRENT_SCHEMA') INTO ownerschema from dual;
END txpks_NOTIFY;
/

DROP PACKAGE txpks_obj
/

CREATE OR REPLACE 
PACKAGE txpks_obj 
/** ----------------------------------------------------------------------------------------------------
 dung cho form maintenance
 ----------------------------------------------------------------------------------------------------*/
IS

FUNCTION fn_Transfer(p_xmlmsg in out tx.obj_rectype,p_err_code in out varchar2,p_err_param out varchar2)
RETURN NUMBER;
FUNCTION fn_Add(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Edit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Delete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Adhoc(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Approve(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_Reject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;

--rieng
FUNCTION fn_CheckBeforeAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_CheckBeforeReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;
FUNCTION fn_ProcessAfterReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER;

  FUNCTION fn_ProcessBeforeApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
  RETURN NUMBER;

END;
/

CREATE OR REPLACE 
PACKAGE BODY txpks_obj
IS
   pkgctx   plog.log_ctx;
   logrow   tlogdebug%ROWTYPE;

FUNCTION fn_Transfer(p_xmlmsg in out tx.obj_rectype,p_err_code in out varchar2,p_err_param out varchar2)
RETURN NUMBER
IS
   l_return_code VARCHAR2(30) := systemnums.C_SUCCESS;
   l_objmsg tx.obj_rectype;
   l_count NUMBER(3);
   l_msgtype VARCHAR2(10);
   l_objname VARCHAR2(100);
   l_actionflag varchar2(100);
   l_currdate varchar2(10);

   l_txnum     varchar2(50);
   l_txdate    date;

   l_CmdObjname varchar2(100);
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Transfer');
   plog.debug(pkgctx, 'fn_Transfer');
   --get object

   l_objmsg:= p_xmlmsg;--txpks_msg.fn_mt_xml2obj(p_xmlmsg);
   l_msgtype:= l_objmsg.MSGTYPE;
   l_objname:= l_objmsg.OBJNAME;
   l_actionflag:= l_objmsg.ACTIONFLAG;
   l_CmdObjname := l_objmsg.CMDOBJNAME;

   --Check quy?n
   plog.debug('fn_Transfer.fn_checkfunctionallow:'
                           || ', TLID:' || l_objmsg.TLID
                           || ', cmdtype:' || 'M'
                           || ', l_CmdObjname:' || l_CmdObjname
                           || ', l_actionflag:' || l_actionflag
                          );
   p_err_code := fn_checkfunctionallow(l_objmsg.TLID, 'M', l_CmdObjname, l_actionflag);
   IF p_err_code <> fn_systemnums('systemnums.C_SUCCESS') THEN
        plog.error('fn_obj_transfer.fn_checkfunctionallow:p_err_code:'||p_err_code
                           || ', TLID:' || l_objmsg.TLID
                           || ', cmdtype:' || 'M'
                           || ', l_CmdObjname:' || l_CmdObjname
                           || ', l_actionflag:' || l_actionflag
                          );
        p_err_param := FN_GET_ERRMSG(p_err_code);
        return p_err_code;
   End if;


   --ghi log
   IF l_actionflag IN ('ADD','EDIT','DELETE') THEN
       IF txpks_maintain.fn_MaintainLog(l_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
           RETURN errnums.C_BIZ_RULE_INVALID;
       END IF;
   END IF;

   --Kiem tra msgtype de phan luong xu ly
   IF l_actionflag ='ADD' THEN
        IF fn_Add(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;
   ELSIF l_actionflag ='EDIT' THEN
        IF fn_Edit(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;

   ELSIF l_actionflag ='DELETE' THEN
        IF fn_Delete(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;
   ELSIF l_actionflag ='ADHOC' THEN
        IF fn_Adhoc(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;
   ELSIF l_actionflag IN ('APPROVE', 'APPROVE_OBJLOG') THEN
        IF fn_Approve(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;
   ELSIF l_actionflag IN ('REJECT', 'REJECT_OBJLOG') THEN
        IF fn_Reject(l_objmsg, p_err_code) <> systemnums.C_SUCCESS THEN
            RAISE errnums.E_BIZ_RULE_INVALID;
        END IF;
   END IF;


   if l_actionflag IN ('ADD','EDIT','DELETE','APPROVE_OBJLOG','REJECT_OBJLOG','APPROVE','REJECT') then

        select count(*) into l_count
        from objlog where autoid = l_objmsg.objlogID;
        if l_count > 0 then
             select txdate, txnum into l_txdate,l_txnum
            from objlog where autoid = l_objmsg.objlogID;
        else
            l_txdate := null;
            l_txnum := null;
        end if;


        txpks_notify.prc_system_logevent('OBJLOG', 'TRANS',
                            'ALL' || '~#~' ||
                            l_txnum || '~#~' ||
                            to_char(l_txdate, 'DD/MM/YYYY')
                            ,'R','INSERT/UPDATE OBJLOG');
   end if;


   plog.setendsection (pkgctx, 'fn_Transfer');
   RETURN l_return_code;
EXCEPTION
WHEN errnums.E_BIZ_RULE_INVALID
   THEN
      FOR I IN (
           SELECT ERRDESC,EN_ERRDESC FROM deferror
           WHERE ERRNUM= p_err_code
      ) LOOP
           p_err_param := i.errdesc;
      END LOOP;
      p_xmlmsg := l_objmsg;--txpks_msg.fn_mt_obj2xml(l_objmsg);
      plog.setendsection (pkgctx, 'fn_Transfer');
      ROLLBACK;
      RETURN errnums.C_BIZ_RULE_INVALID;
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      p_err_param := 'SYSTEM_ERROR';
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      p_xmlmsg := l_objmsg;--txpks_msg.fn_mt_obj2xml(l_objmsg);
      plog.setendsection (pkgctx, 'fn_Transfer');
      RETURN errnums.C_SYSTEM_ERROR;
END fn_Transfer;

FUNCTION fn_Add(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Add');
-- Check befor add
   IF fn_CheckBeforeAdd(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- Auto add
   IF txpks_maintain.fn_ProcessAdd(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- After Add
   IF fn_ProcessAfterAdd(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;

   plog.setendsection (pkgctx, 'fn_Add');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Add');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Add;

FUNCTION fn_Edit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Edit');
-- Check befor edit
   IF fn_CheckBeforeEdit(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- Auto Edit
   IF txpks_maintain.fn_ProcessEdit(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- After Edit
   IF fn_ProcessAfterEdit(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;

   plog.setendsection (pkgctx, 'fn_Edit');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Edit');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Edit;

FUNCTION fn_Delete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Delete');
-- Check befor Delete
   IF fn_CheckBeforeDelete(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- Auto Delete
   IF txpks_maintain.fn_ProcessDelete(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;
-- After Delete
   IF fn_ProcessAfterDelete(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;

   plog.setendsection (pkgctx, 'fn_Delete');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Delete');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Delete;

FUNCTION fn_Adhoc(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Adhoc');

   plog.setendsection (pkgctx, 'fn_Adhoc');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Adhoc');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Adhoc;

FUNCTION fn_Approve(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
l_refobjid  varchar2(12);
l_count number;
l_childvalue varchar2(100);
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Approve');
   --GHI NHAN VAO BANG PREV VA TANG VER TRUOC KHI DUYET SUA
  /* l_refobjid  :=  p_objmsg.CLAUSE;
   plog.error (pkgctx, 'l_refobjid: ' || l_refobjid);
   SELECT OL.CHILDVALUE INTO l_childvalue FROM OBJLOG OL WHERE OL.AUTOID = l_refobjid;
   SELECT COUNT(*) into l_count FROM MAINTAIN_LOG LOG WHERE LOG.REFOBJID = l_refobjid AND LOG.COLUMN_NAME = 'ISAPPLY' and log.action_flag = 'EDIT';
   IF l_count > 0 then
      GET_VER_FEE (l_childvalue);
   END IF;
   */
   IF fn_ProcessBeforeApprove(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;

   IF txpks_maintain.fn_Approve(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;

   IF fn_ProcessAfterApprove(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;

   plog.setendsection (pkgctx, 'fn_Approve');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Approve');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Approve;

FUNCTION fn_Reject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
BEGIN
   plog.setbeginsection (pkgctx, 'fn_Reject');

   IF txpks_maintain.fn_Reject(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;

   IF fn_ProcessAfterReject(p_objmsg,p_err_code) <> systemnums.C_SUCCESS THEN
       RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;


   plog.setendsection (pkgctx, 'fn_Reject');
   RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_Reject');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_Reject;


FUNCTION fn_CheckBeforeAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
   plog.setbeginsection (pkgctx, 'fn_CheckBeforeAdd');
  /* --Kiem tra cmnd khong duoc trung
   SELECT COUNT(ID) INTO l_count FROM feetype WHERE id = p_objmsg.OBJFIELDS('ID').value;

   IF l_count >0 THEN
        p_err_code := '-200001';
        plog.setendsection (pkgctx, 'fn_CheckBeforeAdd');
        RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;*/
       -- khong cho them moi o trang thai cho duyet dong
 /*select  count(1) into l_count from FUND d where d.codeid= p_objmsg.OBJFIELDS('CODEID').value AND d.status = 'R';
  IF l_count > 0  then
    p_err_code := '-111175';
        plog.setendsection (pkgctx, 'fn_CheckBeforeAdd');
        RETURN errnums.C_BIZ_RULE_INVALID;
 end if;*/

    plog.setendsection (pkgctx, 'fn_CheckBeforeAdd');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_CheckBeforeAdd');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_CheckBeforeAdd;

FUNCTION fn_ProcessAfterAdd(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS

    l_refobjid      varchar2(400);
    l_tlid          varchar(20);
    l_txdate        date;
    l_txnum         varchar2(100);
    l_count         number;
    l_actionflag    varchar2(400);
    l_childvalue    varchar2(400);
    l_childkey      varchar2(400);
    l_chiltable     varchar2(400);
BEGIN

    l_txdate    := p_objmsg.txdate;
    l_refobjid  :=  p_objmsg.CLAUSE;
    l_tlid := p_objmsg.TLID;
    l_txnum   := p_objmsg.txnum;
    plog.setbeginsection (pkgctx, 'fn_ProcessAfterAdd');


   /*  FOR REC IN ( SELECT * FROM objlog WHERE (AUTOID = l_refobjid OR PAUTOID =l_refobjid) AND (TXSTATUS = '1' or txstatus = '7' OR TXSTATUS = '4'))
    LOOP
        SELECT actionflag,childvalue,childkey,chiltable
        INTO l_actionflag,l_childvalue,l_childkey,l_chiltable FROM objlog WHERE AUTOID = l_refobjid;
        IF l_actionflag in ('ADD' ) THEN
            if REC.chiltable = 'SA.ISSUERS' then
                update issuers s
                SET ISSUERID = lpad(autoid,10,'0')
                where autoid = rec.childvalue;

                update issuersmemo
                SET ISSUERID = lpad(autoid,10,'0')
                where autoid = rec.childvalue;
            end if;
        end if;
    END LOOP;*/
    plog.setendsection (pkgctx, 'fn_ProcessAfterAdd');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessAfterAdd');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessAfterAdd;

FUNCTION fn_CheckBeforeEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_CheckBeforeEdit');

    plog.setendsection (pkgctx, 'fn_CheckBeforeEdit');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_CheckBeforeEdit');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_CheckBeforeEdit;

FUNCTION fn_ProcessAfterEdit(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_ProcessAfterEdit');

    plog.setendsection (pkgctx, 'fn_ProcessAfterEdit');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessAfterEdit');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessAfterEdit;

FUNCTION fn_CheckBeforeDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
    v_strRecord_Key varchar2(30);
    v_strRecord_Value varchar2(30);
BEGIN
    plog.setbeginsection (pkgctx, 'fn_CheckBeforeDelete');



      IF  length(p_objmsg.CLAUSE) <> 0 THEN
        v_strRecord_Key := Trim(substr(p_objmsg.CLAUSE,1, InStr(p_objmsg.CLAUSE, '=')-1));
        v_strRecord_Value := Trim(substr(p_objmsg.CLAUSE,InStr(p_objmsg.CLAUSE, '=') +1));
        v_strRecord_Value := REPLACE(v_strRecord_Value,'''','');
       end if;
    SELECT COUNT(1) into  l_count FROM feeapply  r  where r.feeid = v_strRecord_Value;
   -- PLOG.error(PKGCTX,'binh'||v_strRecord_Value);

     IF l_count  >  0 THEN
        p_err_code := '-100123';
        plog.setendsection (pkgctx, 'fn_CheckBeforeAdd');
        RETURN errnums.C_BIZ_RULE_INVALID;
   END IF;


    plog.setendsection (pkgctx, 'fn_CheckBeforeDelete');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_CheckBeforeDelete');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_CheckBeforeDelete;

FUNCTION fn_ProcessAfterDelete(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
    l_refobjid varchar2(1000);
    l_actionflag varchar2(100);
    l_childvalue varchar2(100);
    l_childkey varchar2(100);
    l_chiltable varchar2(100);
BEGIN
    plog.setbeginsection (pkgctx, 'fn_ProcessAfterDelete');
    l_refobjid := Trim(substr(p_objmsg.CLAUSE,InStr(p_objmsg.CLAUSE, '=') +1));
    l_refobjid:= REPLACE(l_refobjid,'''');
    -- insert into draff_phong values (  p_objmsg.OBJNAME ) ;
    /*SELECT actionflag,childvalue,childkey,chiltable
    INTO l_actionflag,l_childvalue,l_childkey,l_chiltable FROM objlog WHERE  AUTOID = l_refobjid;
    */
    IF p_objmsg.OBJNAME = 'SA.ASSETDTL' THEN
        DELETE FROM buyoption WHERE ID =  l_refobjid  ;
        DELETE FROM selloption WHERE ID =  l_refobjid  ;
    END IF;

    plog.setendsection (pkgctx, 'fn_ProcessAfterDelete');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessAfterDelete');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessAfterDelete;

FUNCTION fn_CheckBeforeApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_CheckBeforeApprove');

    plog.setendsection (pkgctx, 'fn_CheckBeforeApprove');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_CheckBeforeApprove');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_CheckBeforeApprove;

FUNCTION fn_ProcessBeforeApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
    l_refobjid  varchar2(12);
    l_tlid varchar(20);
    l_actionflag varchar2(400);
    l_childvalue varchar2(400);
    l_childkey varchar2(400);
    l_chiltable varchar2(400);
    l_txdate        date;
    l_txnum        varchar2(100);
    s_refafacctno varchar2(400);
    s_symbol varchar2(400);
    l_count1        number;
    l_count2        number;
    l_productierold varchar(2000);
    l_productiernew varchar(2000);
    l_qcmua varchar2(2000);
    l_qcban varchar2(2000);
    l_rerole varchar2(2000);
    l_saleid varchar2(2000);
    l_actype varchar2(2000);
    l_isdefault varchar2(2000);
    l_objfeevalue varchar2(2000);
    l_feeid varchar2(2000);
    l_id  varchar2(2000);
    l_sbsedefacct varchar2(2000);
    l_product varchar2(2000);
     l_autoid        number;
     l_parvalue      number;
     l_intrate       number;
     l_base          number;
     l_date_pay      date;
     l_date_pay_min  date;
     l_effdate       date;
     l_expdate       date;
     l_days          number;
     l_day_pay_cur   number;
     l_symbol_pay_cur varchar(2000);
     l_date_pay_cur  date;
     l_day_after_date number;
     l_rp_date       number;
     l_valuedt       date;
     l_symbol        varchar(100);
     l_refafacctno   varchar(100);
     l_ruletype     varchar2(200);
     l_protype      varchar2(200);
     l_feetierdata  varchar2(4000);
     l_list_oxpost varchar2(4000);
     l_autoid2 number;
     l_limitval2 number;
     l_currdate TIMESTAMP;
     l_autoidi varchar(100);
     l_udfcodei VARCHAR(100);
     l_udfvaluei number;
     l_procode varchar2(500);
BEGIN
    l_txdate    := p_objmsg.txdate;
    l_refobjid  :=  p_objmsg.CLAUSE;
    l_tlid := p_objmsg.TLID;
    l_txnum   := p_objmsg.txnum;
    select CURRENT_TIMESTAMP into l_currdate from dual;
    plog.setbeginsection (pkgctx, 'fn_ProcessBeforeApprove');
    FOR REC IN ( SELECT * FROM objlog WHERE (AUTOID = l_refobjid OR PAUTOID =l_refobjid) AND (TXSTATUS = '1' or txstatus = '7' OR TXSTATUS = '4'))
    LOOP
        SELECT actionflag,childvalue,childkey,chiltable
        INTO l_actionflag,l_childvalue,l_childkey,l_chiltable FROM objlog WHERE AUTOID = l_refobjid;

     if (l_actionflag = 'DELETE') then
          /*
                select refafacctno, symbol into s_refafacctno, s_symbol from sbsedefacct s where autoid = l_childvalue;
                delete from product p where afacctno = s_refafacctno and symbol = s_symbol;
            */

            if rec.chiltable = 'SALE_RETYPE' then

            select count(*) into l_count from sale_roles sr where sr.retypeid =l_childvalue ;
               if l_count >0 then
                p_err_code := '-4000441';
                    --p_err_param := fn_get_errmsg(p_err_code,pv_language);
                    return p_err_code;
                end if;
              insert into sale_retype_log (autoid,logid,actype,typename,rerole,effdate,expdate,description,isdefault,lastchange,txnum,txdate,action_type)
              select seq_sale_retype_log.NEXTVAL,s.autoid,s.actype,s.typename,s.rerole,s.effdate,s.expdate,s.DESCRIPTION,s.isdefault, l_currdate,l_txnum,l_txdate,'D'
              from sale_retype s
              where s.autoid=l_childvalue --and (s.status like 'A' or s.pstatus like ='%A%')
              ;
            end if;
             if rec.chiltable ='PRODUCT' then
              SELECT count(1) INTO l_count FROM OXMAST o3 WHERE o3.PRODUCTID = l_childvalue and o3.status <> 'R';
                   IF (l_count<>0) THEN
                        p_err_code := '-120025';
                        --p_err_param := fn_get_errmsg(p_err_code,pv_language);
                        return p_err_code;

                   else
                    for rec in (select * from product where autoid = l_childvalue)
                    loop
                        select count(*) into l_count1 from productmemo where autoid = rec.autoid;
                        if l_count = 0 then
                        insert into productmemo (autoid, shortname, afacctno, symbol) values (rec.autoid, rec.shortname, rec.afacctno, rec.symbol);
                        end if;
                    end loop;
                end if;
            end if;
            if rec.chiltable ='REINVEST_RATE' then
                delete from reinvest_rate_dtl where id = l_childvalue;
            end if;


            IF rec.chiltable = 'INTSCHD' THEN
                for rec1 in (select rownum periodno, autoid from (select autoid from intschd where symbol = (select symbol from intschd where autoid = l_childvalue) and autoid <> l_childvalue
                 order by fromdate asc))
                        loop
                            update intschd set periodno = rec1.periodno where autoid = rec1.autoid;
                        end loop;
             end if;
             IF REC.chiltable = 'SALE_ROLES' THEN
             INSERT INTO SHBCBD.SALE_ROLES_LOG
            (AUTOID, LOGID, RETYPE, RETYPEID, SALEID, BRID,EFFDATE,EXPDATE,REROLE, LASTCHANGE, TXNUM, TXDATE, ACTION_TYPE)
            select seq_SALE_ROLES_LOG.NEXTVAL,s.autoid,s.retype,s.retypeid,s.saleid,s.brid,s.effdate,s.expdate,s.rerole,l_currdate, l_txnum,l_txdate,'D' from sale_roles s
            where s.autoid = rec.childvalue;
            end if;
             IF REC.chiltable = 'COMMISSION' THEN
             INSERT INTO SHBCBD.COMMISSION_LOG
            (ID, FEECODE, FEENAME, CALCMETHOD, RULETYPE, FEERATE,  LASTCHANGE, FEETIERDATA, NOTE, SYMBOL, PRODUCT, SBSEDEFACCT, TXNUM, TXDATE,logid,action_type)
            select seq_commission_log.NEXTVAL,c.feecode,c.feename,c.calcmethod,c.ruletype,c.feerate,l_currdate,c.feetierdata,c.note,c.symbol,c.product,c.sbsedefacct, l_txnum,l_txdate,c.id,'D' from commission c
            where c.id = rec.childvalue;

        select c.ruletype into l_ruletype from commission c where c.id = rec.childvalue;
            if l_ruletype = 'T' then
                INSERT INTO SHBCBD.COMMISSION_DTL_LOG
                (id,commissionid,framt,toamt,feerate)
                select seq_commission_dtl_log.nextval,cd.id,c.FRAMT,c.TOAMT,c.FEERATE from commission_dtl c join commission_log cd on  cd.logid =rec.childvalue and cd.txnum=l_txnum and cd.txdate=l_txdate
                where c.commissionid = rec.childvalue;
            end if;
                delete from commission_dtlmemo where commissionid = l_childvalue;

             end if;
             IF REC.chiltable = 'COMPROGRAM' THEN
             INSERT INTO SHBCBD.COMPROGRAM_LOG
            (ID, PROCODE, PRONAME, EFFDATE,EXPDATE,PROTYPE,PROCONDITION, RULETYPE, FEERATE,  LASTCHANGE, FEETIERDATA, NOTE, TXNUM, TXDATE,logid,action_type)
            select seq_comprogram_log.NEXTVAL,c.PROCODE,c.PRONAME,c.EFFDATE,c.EXPDATE,c.PROTYPE,c.PROCONDITION,c.ruletype,c.feerate,l_currdate,c.feetierdata,c.note, l_txnum,l_txdate,c.id,'D' from comprogram c
            where c.id = rec.childvalue;

        select c.ruletype,c.protype into l_ruletype,l_protype from COMPROGRAM c where c.id = rec.childvalue;
            if l_ruletype = 'T' then
                INSERT INTO SHBCBD.COMPROGRAM_DTL_LOG
                (id,proid,framt,toamt,feerate)
                select seq_comprogram_dtl_log.nextval,cd.id,c.FRAMT,c.TOAMT,c.FEERATE from comprogram_dtl c join comprogram_log cd on  cd.logid =rec.childvalue and cd.txnum=l_txnum and cd.txdate=l_txdate
                where c.proid = rec.childvalue;
            end if;
             if l_protype <> 'C' then
                INSERT INTO SHBCBD.COMPROGRAM_COND_LOG
                (id,proid,condvalue)
                select seq_comprogram_cond_log.nextval,cd.id,c.condvalue from comprogram_cond c join comprogram_log cd on  cd.logid =rec.childvalue and cd.txnum=l_txnum and cd.txdate=l_txdate
                where c.proid = rec.childvalue;
            end if;
                delete from comprogram_dtlmemo where proid = l_childvalue;
                delete from comprogram_condmemo where proid = l_childvalue;

             end if;
            IF REC.chiltable = 'SBSEDEFACCT' THEN
            plog.debug(pkgctx, 'pong: '||l_childvalue);
               for rec in ( SELECT * FROM sbsedefacct s WHERE s.AUTOID = to_number(l_childvalue))
               loop
                        select count(*) into l_count from investment i where i.acctno= rec.refafacctno and i.symbol = rec.symbol;
                        if l_count > 0 then
                            p_err_code:= '-120000';
                            return p_err_code;
                       else
                        DELETE FROM productselldtl ps WHERE ps.ID in (select p.autoid from product p where p.symbol = rec.symbol and p.afacctno = rec.refafacctno);
                        DELETE FROM productbuydtl ps WHERE ps.ID in (select p.autoid from product p where p.symbol = rec.symbol and p.afacctno = rec.refafacctno);
                        DELETE FROM PRODUCT P WHERE P.SYMBOL = rec.symbol AND P.AFACCTNO = rec.refafacctno;
                       end if;

           end loop;
            END IF;
          /*if REC.chiltable = 'PRODUCT' then
                delete from producthist p where p.id = l_childvalue;
          end if;*/

         if REC.chiltable = 'PAYMENT_HIST' then
          ------Cap nhat lai sau khi xoa
            select days ,INTDATE,symbol into l_day_pay_cur,l_date_pay_cur,l_symbol_pay_cur from PAYMENT_HIST where autoid = l_childvalue;
                select count(*)into l_count
            FROM
                (SELECT * FROM PAYMENT_HIST ph
                WHERE SYMBOL = l_symbol_pay_cur AND INTDATE > l_date_pay_cur and STATUS != 'P'
                ORDER BY INTDATE ASC) x
            WHERE ROWNUM <= 1
            ;


        if l_count > 0 then






            --lay ban ghi date lon hon
            SELECT x.autoid,x.parvalue,x.intrate,x.INTBASEDDOFY,x.INTDATE,x.days
                   into l_autoid,l_parvalue,l_intrate,l_base,l_date_pay,l_day_after_date
            FROM
                (SELECT * FROM PAYMENT_HIST ph
                WHERE SYMBOL = l_symbol_pay_cur AND INTDATE > l_date_pay_cur and STATUS != 'P'
                ORDER BY INTDATE ASC) x
            WHERE ROWNUM <= 1
            ;
            l_days := (l_day_after_date + l_day_pay_cur);
            plog.debug(pkgctx,'prc_mt_payment_hist.ACTION: DELETE');
            plog.debug(pkgctx,'prc_mt_payment_hist.l_date_delete: '||l_symbol_pay_cur);
            plog.debug(pkgctx,'prc_mt_payment_hist.l_autoid_1: '||l_autoid);
            plog.debug(pkgctx,'prc_mt_payment_hist.l_parvalue_1: '||l_parvalue);
            plog.debug(pkgctx,'prc_mt_payment_hist.l_intrate_1: '||l_intrate);
            plog.debug(pkgctx,'prc_mt_payment_hist.l_base_1: '||l_base);
            plog.debug(pkgctx,'prc_mt_payment_hist.l_date_pay_1: '||l_date_pay);
            plog.debug(pkgctx,'prc_mt_payment_hist.l_days_1: '||l_days);

           update payment_hist
                    set amount = ROUND(l_intrate * l_parvalue/100*l_days/l_base, 0), days = l_days
                    where autoid = l_autoid;

        end if;



          end if;
        if REC.chiltable = 'ASSETDTL' then
        --XOA THONG TIN TAI SAN
        delete from intschd where symbol in (select symbol from assetdtl where autoid = l_childvalue);
        delete from payment_schd where symbol in (select symbol from assetdtl where autoid = l_childvalue);

         delete from asset_putoption_temp
            where symbol in  (select symbol from assetdtlmemo where autoid = l_childvalue);
            delete from payment_hist
                where symbol in (select symbol from assetdtl where autoid = l_childvalue);

            delete from payment_detail_hist
                where symbol in (select symbol from assetdtl where autoid = l_childvalue);
        end if;
      if REC.chiltable = 'ISSUERS' then
        select count(*) into l_count
        from assetdtl a inner join issuers i on i.issuerid = a.issuerid
        where i.autoid = rec.childvalue;
            if l_count > 0 then
                   p_err_code := '-50012';
                   return errnums.C_BIZ_RULE_INVALID;
            end if;
      end if;
     end if;


if rec.chiltable = 'LIMITS' then
  IF l_actionflag in ('EDIT') THEN

    for rec1 in ( SELECT * FROM limits s WHERE s.AUTOID = l_childvalue)
        loop
            insert into limits_hist (autoid,LIMITVAL,id,ACTION,effdate,LASTCHANGE,LIMIT_TYPE,ACCTNO,EXPDATE,STATUS,PSTATUS,CALC_TYPE,SYMBOL,METHOD,PRODUCT)
            values(seq_limits_hist.NEXTVAL,rec1.limitval,rec1.autoid,'E',rec1.effdate,LOCALTIMESTAMP,rec1.LIMIT_TYPE,rec1.ACCTNO,rec1.EXPDATE,rec1.STATUS,rec1.PSTATUS,rec1.CALC_TYPE,rec1.SYMBOL,rec1.METHOD,rec1.PRODUCT);
        end loop;

    /*select limitval,autoid into l_limitval2 , l_autoid2  from limits where autoid = l_childvalue;
    if (l_limitval2 is not null) then
        insert into limits_hist (autoid,LIMITVAL,id,ACTION,effdate,LASTCHANGE)
        values(seq_limits_hist.NEXTVAL,l_limitval2,l_autoid2,'E',getcurrdate(),LOCALTIMESTAMP);
    end if;*/

  end if;
  IF l_actionflag in ('DELETE') THEN


        /*select autoid into  l_autoid2  from limits where autoid = l_childvalue;

        insert into limits_hist (autoid,id,ACTION,effdate,LASTCHANGE)
        values(seq_limits_hist.NEXTVAL,l_autoid2,'D',getcurrdate(),LOCALTIMESTAMP);*/
        for rec1 in ( SELECT * FROM limits s WHERE s.AUTOID = l_childvalue)
        loop

            insert into limits_hist (autoid,LIMITVAL,id,ACTION,effdate,LASTCHANGE,LIMIT_TYPE,ACCTNO,EXPDATE,STATUS,PSTATUS,CALC_TYPE,SYMBOL,METHOD,PRODUCT)
            values(seq_limits_hist.NEXTVAL,rec1.limitval,rec1.autoid,'D',rec1.effdate,LOCALTIMESTAMP,rec1.LIMIT_TYPE,rec1.ACCTNO,rec1.EXPDATE,rec1.STATUS,rec1.PSTATUS,rec1.CALC_TYPE,rec1.SYMBOL,rec1.METHOD,rec1.PRODUCT);
        end loop;


  end if;
end if;

iF rec.chiltable = 'REINVEST_RATE' then
  IF l_actionflag in ('EDIT', 'ADD') THEN
    for rec in (select * from reinvest_rate where autoid = l_childvalue)
        loop
        delete from reinvest_rate_dtl where id = rec.autoid;
        if rec.reinvest_rate_dtl is not null then
            insert_reinvest_rate_dtl(rec.reinvest_rate_dtl,rec.autoid,p_err_code);
        end if;
        end loop;
    end if;
end if;

      IF l_actionflag in ('ADD' ) THEN
      if rec.chiltable = 'SALE_ROLES' THEN
        SELECT saleid,rerole,effdate, expdate into l_saleid,l_rerole,l_effdate,l_expdate FROM SALE_ROLES WHERE AUTOID = l_childvalue;
          select count(1) into l_count from  sale_roles sr where saleid = l_saleid
                and sr.rerole = l_rerole

                and l_effdate >= sr.effdate
                and l_expdate <= sr.expdate
                and sr.autoid <> l_childvalue;
            if l_count > 0 then
               p_err_code := '-100080';
               return p_err_code ;
            end if;
        end if;
        if rec.chiltable = 'SALE_RETYPE' THEN
        select actype into l_actype from sale_retype where autoid = l_childvalue;
        select count(*) into l_count from ( select * from  sale_retype sr where sr.status='A' or sr.pstatus like '%A%') sr
         where sr.actype = l_actype
         and sr.autoid <> l_childvalue;
            if l_count > 0 then
               p_err_code := '-4000350';
               return p_err_code ;
            end if;
        end if;

        IF REC.chiltable = 'LIMITS' THEN
        --update limits set effdate = getcurrdate()  where autoid = rec.childvalue;
        update limits set effdate = TO_TIMESTAMP(to_char(GETCURRDATE(),'DD-MM-YYYY')||' '|| to_char(CURRENT_TIMESTAMP, 'HH24:MI:SS'),'DD-MM-YYYY HH24:MI:SS')
          where autoid = rec.childvalue;
            /*INSERT INTO producthist
            (AUTOID,id, effdate, expdate, rate00, rate01, rate02, rate03, rate04, rate05, rate06, rate07, rate08, rate09, rate10, rate11, rate12, rate13, rate14, rate15, rate16, t_rate00, t_rate01, t_rate02, t_rate03, t_rate04, t_rate05, t_rate06, t_rate07, t_rate08, t_rate09, t_rate10, t_rate11, t_rate12, t_rate13, t_rate14, t_rate15, t_rate16)
            select seq_producthist.nextval,p.autoid, getcurrdate(), to_date('31/12/2099', 'dd/mm/yyyy'),
            p.rate00, p.rate01, p.rate02, p.rate03, p.rate04, p.rate05, p.rate06, p.rate07, p.rate08, p.rate09, p.rate10, p.rate11, p.rate12, p.rate13, p.rate14, p.rate15, p.rate16, p.t_rate00, p.t_rate01, p.t_rate02, p.t_rate03, p.t_rate04, p.t_rate05, p.t_rate06, p.t_rate07, p.t_rate08, p.t_rate09, p.t_rate10, p.t_rate11, p.t_rate12, p.t_rate13, p.t_rate14, p.t_rate15, p.t_rate16
            from product p
            where p.autoid = rec.childvalue;*/
        END IF;

      end if;



      IF l_actionflag in ('EDIT' ) THEN

       IF REC.chiltable = 'LIMITS' THEN
       update limits set effdate = TO_TIMESTAMP(to_char(GETCURRDATE(),'DD-MM-YYYY')||' '|| to_char(CURRENT_TIMESTAMP, 'HH24:MI:SS'),'DD-MM-YYYY HH24:MI:SS')
       where autoid = rec.childvalue;
       END IF;


    if REC.chiltable = 'COMPROGRAM' then
    select procode,effdate,expdate,protype into l_procode,l_effdate,l_expdate,l_protype from comprogrammemo where id = l_childvalue;
        select count(*) into l_count from comprogram c where c.procode = l_procode and c.id <> l_childvalue;
        if l_count > 0 then
            p_err_code := '-131188';
            return p_err_code;
        end if;

         select count(*)into l_count from comprogram c
        where c.protype ='C'
        and l_protype like '%C%'
        and( (c.effdate <= l_effdate and  l_expdate <= c.expdate)
        or (c.effdate >= l_effdate and   l_expdate >= c.expdate)
        or (c.effdate >= l_effdate and c.effdate <  l_expdate)
        or (c.expdate > l_effdate and c.expdate <=  l_expdate)
        )
        and c.id <> l_childvalue;
        if l_count >0 then
         p_err_code := '-910568';
            return p_err_code;
        end if;




    end if;

       if rec.chiltable = 'SALE_ROLES' THEN
        SELECT saleid,rerole,effdate, expdate into l_saleid,l_rerole,l_effdate,l_expdate FROM SALE_ROLESMEMO WHERE AUTOID = l_childvalue;
          select count(1) into l_count from  sale_roles sr where saleid = l_saleid
                and sr.rerole = l_rerole
                and l_effdate >= sr.effdate
                and l_expdate <= sr.expdate
                and sr.autoid<> l_childvalue;
            if l_count > 0 then
               p_err_code := '-100080';
               return p_err_code ;
            end if;
            INSERT INTO SHBCBD.SALE_ROLES_LOG
            (AUTOID, LOGID, RETYPE, RETYPEID, SALEID, BRID,EFFDATE,EXPDATE,REROLE, LASTCHANGE, TXNUM, TXDATE, ACTION_TYPE)
            select seq_SALE_ROLES_LOG.NEXTVAL,s.autoid,s.retype,s.retypeid,s.saleid,s.brid,s.effdate,s.expdate,s.rerole,l_currdate, l_txnum,l_txdate,'U' from sale_roles s
            where s.autoid = rec.childvalue;
        end if;
        if rec.chiltable = 'SALE_RETYPE' THEN
        SELECT actype,rerole,effdate, expdate,isdefault into l_actype,l_rerole,l_effdate,l_expdate,l_isdefault FROM SALE_RETYPEMEMO WHERE AUTOID = l_childvalue;
        select count(*) into l_count
        from sale_retype sr
        where sr.actype = l_actype
        and sr.autoid <> l_childvalue;
        if l_count > 0 then
               p_err_code := '-4000350';
                return p_err_code;
            end if;

            select count(*) into l_count
       from sale_retype sr
       where sr.actype <> l_actype
       and sr.rerole = l_rerole
       and l_isdefault = 'Y'
       and sr.isdefault = l_isdefault
       and sr.autoid <> l_childvalue
       --and sr.status = 'A' or sr.pstatus like 'A'
       and sr.effdate <= l_effdate
       and sr.expdate >=  l_expdate;
        if l_count > 0 then
               p_err_code := '-4000352';
                return p_err_code;
            end if;
        SELECT count(*) INTO l_count from
            (SELECT * FROM FEEAPPLY f where f.OBJFEEVALUE = l_childvalue)a
            where
             frdate<l_effdate
            OR todate< l_effdate
            OR frdate>l_expdate
            OR todate> l_expdate;
            if l_count > 0 then
               p_err_code := '-910566';
               return p_err_code ;
            end if;

         insert into sale_retype_log (autoid,logid,actype,typename,rerole,effdate,expdate,description,isdefault,lastchange,txnum,txdate,action_type)
              select seq_sale_retype_log.NEXTVAL,s.autoid,s.actype,s.typename,s.rerole,s.effdate,s.expdate,s.DESCRIPTION,s.isdefault, l_currdate,l_txnum,l_txdate,'U'
              from sale_retype s
              where s.autoid=l_childvalue --and (s.status = 'A'or s.pstatus like ='%A%')
              ;
        end if;

        if REC.chiltable = 'COMMISSION' then
        INSERT INTO SHBCBD.COMMISSION_LOG
(ID, FEECODE, FEENAME, CALCMETHOD, RULETYPE, FEERATE,  LASTCHANGE, FEETIERDATA, NOTE, SYMBOL, PRODUCT, SBSEDEFACCT, TXNUM, TXDATE,logid,action_type)
            select seq_commission_log.NEXTVAL,c.feecode,c.feename,c.calcmethod,c.ruletype,c.feerate,l_currdate,c.feetierdata,c.note,c.symbol,c.product,c.sbsedefacct, l_txnum,l_txdate,c.id,'U' from commission c
            where c.id = rec.childvalue;

        select c.ruletype into l_ruletype from commission c where c.id = rec.childvalue;
            if l_ruletype = 'T' then
                INSERT INTO SHBCBD.COMMISSION_DTL_LOG
                (id,commissionid,framt,toamt,feerate)
                select seq_commission_dtl_log.nextval,cd.id,c.FRAMT,c.TOAMT,c.FEERATE from commission_dtl c join commission_log cd on  cd.logid =rec.childvalue and cd.txnum=l_txnum and cd.txdate=l_txdate
                where c.commissionid = rec.childvalue;
            end if;
        end if;
           IF REC.chiltable = 'COMPROGRAM' THEN
             INSERT INTO SHBCBD.COMPROGRAM_LOG
            (ID, PROCODE, PRONAME, EFFDATE,EXPDATE,PROTYPE,PROCONDITION, RULETYPE, FEERATE,  LASTCHANGE, FEETIERDATA, NOTE, TXNUM, TXDATE,logid,action_type)
            select seq_comprogram_log.NEXTVAL,c.PROCODE,c.PRONAME,c.EFFDATE,c.EXPDATE,c.PROTYPE,c.PROCONDITION,c.ruletype,c.feerate,l_currdate,c.feetierdata,c.note, l_txnum,l_txdate,c.id,'U' from comprogram c
            where c.id = rec.childvalue;

        select c.ruletype,c.protype into l_ruletype,l_protype from COMPROGRAM c where c.id = rec.childvalue;
            if l_ruletype = 'T' then
                INSERT INTO SHBCBD.COMPROGRAM_DTL_LOG
                (id,proid,framt,toamt,feerate)
                select seq_comprogram_dtl_log.nextval,cd.id,c.FRAMT,c.TOAMT,c.FEERATE from comprogram_dtl c join comprogram_log cd on  cd.logid =rec.childvalue and cd.txnum=l_txnum and cd.txdate=l_txdate
                where c.proid = rec.childvalue;
            end if;
             if l_protype <> 'C' then
                INSERT INTO SHBCBD.COMPROGRAM_COND_LOG
                (id,proid,condvalue)
                select seq_comprogram_cond_log.nextval,cd.id,c.condvalue from comprogram_cond c join comprogram_log cd on  cd.logid =rec.childvalue and cd.txnum=l_txnum and cd.txdate=l_txdate
                where c.proid = rec.childvalue;
            end if;
                delete from comprogram_dtlmemo where proid = l_childvalue;
                delete from comprogram_condmemo where proid = l_childvalue;

             end if;
      if REC.chiltable = 'COMBOPRODUCT' then
        select count(1) into l_count1 from comboproduct where id = rec.childvalue ;
        select count(1) into l_count2 from comboproductmemo where id = rec.childvalue ;
        if(l_count1 = l_count2 and l_count1 = 1) then
            select productier into l_productierold from comboproduct where id = rec.childvalue ;
            select productier into l_productiernew from comboproductmemo where id = rec.childvalue ;
            if(l_productierold <> l_productiernew) then
            delete from SHBCBD.PRODUCTIER where id = rec.childvalue ;
                 FOR
            record IN (
            SELECT REGEXP_REPLACE(TRIM (fil.char_value), '\(|\)', '') fil_cond
            FROM (
            SELECT fn_pivot_string (
            REGEXP_REPLACE (l_productiernew,
            '~\$~', '|'))
            filter_row
            FROM DUAL
            ),
            table (filter_row) fil
            )

            LOOP
                --insert into ahihi values (record.FIL_COND);

              INSERT
              INTO
              SHBCBD.PRODUCTIER (AUTOID, PRODUCTID, DISCOUNT, SYMBOL, STATUS, PSTATUS, LASTCHANGE, ID)
            SELECT
              seq_PRODUCTIER.nextval,
              b.productid,b.discount,b.symbol,
              NULL,
              NULL,
              NULL,
              rec.childvalue
            FROM
              (SELECT
              *
            FROM
              (WITH tmp AS (
              SELECT
                REGEXP_REPLACE (TRIM (fil.char_value), '\(|\)', '') VALUE, fil.rid
              FROM
                (
                SELECT
                  fn_pivot_string ( REGEXP_REPLACE (record.FIL_COND, '~\#~', '|')) filter_row
                FROM
                  DUAL), TABLE (filter_row) fil)
              SELECT
                symbol.VALUE symbol , productid.VALUE productid , discount.VALUE discount
              FROM
                (
                SELECT
                  VALUE
                FROM
                  tmp
                WHERE
                  rid = 1) symbol
              INNER JOIN (
                SELECT
                  VALUE
                FROM
                  tmp
                WHERE
                  rid = 2) productid ON
                1 = 1
              INNER JOIN (
                SELECT
                  VALUE
                FROM
                  tmp
                WHERE
                  rid = 3) discount ON
                1 = 1 ))b;

            END LOOP;
            end if;
        end if;
      end if;
      end if;

      if REC.chiltable = 'PAYMENT_HIST' then
          --insert log payment_hist
          IF l_actionflag in ('ADD') THEN
            INSERT INTO PAYMENT_HIST_LOG  SELECT ph.AUTOID,ph.SYMBOL ,ph.AMOUNT ,ph.RATIO ,ph.VALUEDT
            ,l_actionflag ,ph.DESCRIPTION ,LOCALTIMESTAMP LASTCHANGE  ,ph.REFID ,ph.PAYTYPE,ph.PARVALUE ,ph.INTRATE ,ph.DAYS ,ph.INTBASEDDOFY
            ,ph.PAYMENT_STATUS ,ph.INTDATE ,ph.REPORTDT ,getcurrdate() CHANGEDATE,ph.pstatus
            FROM PAYMENT_HIST ph WHERE AUTOID = rec.childvalue;
          end if;

          IF l_actionflag in ('DELETE','EDIT') THEN
            select count(*) into l_count from PAYMENT_HIST where autoid = rec.childvalue and STATUS != 'P';

            if l_count > 0 then

            INSERT INTO PAYMENT_HIST_LOG  SELECT ph.AUTOID,ph.SYMBOL ,ph.AMOUNT ,ph.RATIO ,ph.VALUEDT
            ,l_actionflag ,ph.DESCRIPTION ,LOCALTIMESTAMP LASTCHANGE  ,ph.REFID ,ph.PAYTYPE,ph.PARVALUE ,ph.INTRATE ,ph.DAYS ,ph.INTBASEDDOFY
            ,ph.PAYMENT_STATUS ,ph.INTDATE ,ph.REPORTDT ,getcurrdate() CHANGEDATE,ph.pstatus
            FROM PAYMENT_HIST ph WHERE AUTOID = rec.childvalue;
            end if;
          end if;

      end if;

      -- xu ly voi thang asssetdtl
      IF l_actionflag in ('EDIT', 'ADD') THEN
    if rec.chiltable = 'FEEAPPLY' THEN
        select f.id,f.feeid,f.objfeevalue,f.frdate,f.todate into l_id,l_feeid, l_objfeevalue,l_effdate,l_expdate from feeapplymemo f where f.id = l_childvalue;
         select c.sbsedefacct, c.product,c.symbol into l_sbsedefacct,l_product,l_symbol from commission c where to_char(c.id) = to_char(l_feeid);
         SELECT count(*) into l_count1 FROM feeapply f left join commission c on f.feeid = c.id
            where
            (
            (f.frdate > l_effdate and f.frdate < l_expdate)
            or (f.todate > l_effdate and f.todate < l_expdate)
            or (f.frdate <= l_effdate and f.todate >= l_expdate)
            or (f.frdate >= l_effdate and f.todate <= l_expdate)
            or (f.frdate <= l_effdate and f.todate >= l_expdate)
            )
            and l_id <> f.id
            and f.OBJFEEVALUE LIKE l_objfeevalue
            and (
            (f.feeid like l_feeid)
            or (c.sbsedefacct like l_sbsedefacct and c.symbol like l_symbol and c.product like l_product))
            ;
        if l_count1 > 0 then
               p_err_code := '-50119';
               return p_err_code ;
            end if;
        SELECT count(*) INTO l_count from

            (SELECT * FROM sale_retype SR where sr.autoid = l_objfeevalue) a
            where
             effdate>l_effdate
            OR expdate< l_effdate
            OR effdate>l_expdate
            OR expdate< l_expdate;
            if l_count > 0 then
               p_err_code := '-910566';
               return p_err_code ;
            end if;
        end if;

    if REC.chiltable = 'ASSETDTL' then
        select symbol into l_symbol from assetdtl where autoid = rec.childvalue ;
        select count(1) into l_count from assetdtl where symbol = l_symbol and status = 'A';
        if l_count > 0 then
            p_err_code := '-811101';
            plog.setendsection (pkgctx, 'fn_CheckBeforeAdd');
            RETURN errnums.C_BIZ_RULE_INVALID;
        end if;
        select count(1) into l_count1 from assetdtl where autoid = rec.childvalue ;
        select count(1) into l_count2 from assetdtlmemo where autoid = rec.childvalue ;
        if(l_count1 = l_count2 and l_count1 = 1) then
            select qcmua into l_qcmua from assetdtlmemo where autoid = rec.childvalue ;
            select qcban into l_qcban from assetdtlmemo where autoid = rec.childvalue ;
           -- if(l_productierold <> l_productiernew) then

                 /*FOR
            record IN (
            SELECT REGEXP_REPLACE(TRIM (fil.char_value), '\(|\)', '') fil_cond
            FROM (
            SELECT fn_pivot_string (
            REGEXP_REPLACE (l_qcmua,
            '~\$~', '|'))
            filter_row
            FROM DUAL
            ),
            table (filter_row) fil
            )

            LOOP
                --insert into ahihi values (record.FIL_COND);

              INSERT
              INTO
              BUYOPTION (AUTOID, ID, CALLOPTION, FIXEDDATEBUY, CALLDATE,BUYALL, STATUS, PSTATUS, LASTCHANGE)
            SELECT
              seq_buyoption.nextval,
              rec.childvalue,b.CALLOPTION,b.FIXEDDATEBUY,
              b.CALLDATE, b.BUYALL,
              NULL,
              NULL,
              NULL
            FROM
              (SELECT
              *
            FROM
              (WITH tmp AS (
              SELECT
                REGEXP_REPLACE (TRIM (fil.char_value), '\(|\)', '') VALUE, fil.rid
              FROM
                (
                SELECT
                  fn_pivot_string ( REGEXP_REPLACE (record.FIL_COND, '~\#~', '|')) filter_row
                FROM
                  DUAL), TABLE (filter_row) fil)
              SELECT
                CALLOPTION.VALUE CALLOPTION , FIXEDDATEBUY.VALUE FIXEDDATEBUY , CALLDATE.VALUE CALLDATE, BUYALL.value BUYALL
              FROM
                (
                SELECT
                  VALUE
                FROM
                  tmp
                WHERE
                  rid = 1) CALLOPTION
              INNER JOIN (
                SELECT
                  VALUE
                FROM
                  tmp
                WHERE
                  rid = 2) FIXEDDATEBUY ON
                1 = 1
              INNER JOIN (
                SELECT
                  to_date(VALUE, 'dd/mm/yyyy') VALUE
                FROM
                  tmp
                WHERE
                  rid = 3) CALLDATE ON
                1 = 1
              INNER JOIN (
                SELECT
                  VALUE
                FROM
                  tmp
                WHERE
                  rid = 4) BUYALL ON
                1 = 1 ))b;

            END LOOP;*/
            -- ----
            /*FOR
            record IN (
            SELECT REGEXP_REPLACE(TRIM (fil.char_value), '\(|\)', '') fil_cond
            FROM (
            SELECT fn_pivot_string (
            REGEXP_REPLACE (l_qcban,
            '~\$~', '|'))
            filter_row
            FROM DUAL
            ),
            table (filter_row) fil
            )

            LOOP
                --insert into ahihi values (record.FIL_COND);

              INSERT
              INTO
              SELLOPTION (AUTOID, ID, PUTOPTION, FIXEDDATESELL, PUTDATE,STATUS, PSTATUS, LASTCHANGE)
            SELECT
              seq_selloption.nextval,
              rec.childvalue,b.PUTOPTION,b.FIXEDDATESELL,
              b.PUTDATE,
              NULL,
              NULL,
              NULL
            FROM
              (SELECT
              *
            FROM
              (WITH tmp AS (
              SELECT
                REGEXP_REPLACE (TRIM (fil.char_value), '\(|\)', '') VALUE, fil.rid
              FROM
                (
                SELECT
                  fn_pivot_string ( REGEXP_REPLACE (record.FIL_COND, '~\#~', '|')) filter_row
                FROM
                  DUAL), TABLE (filter_row) fil)
              SELECT
                PUTOPTION.VALUE PUTOPTION , FIXEDDATESELL.VALUE FIXEDDATESELL , PUTDATE.VALUE PUTDATE
              FROM
                (
                SELECT
                  VALUE
                FROM
                  tmp
                WHERE
                  rid = 1) PUTOPTION
              INNER JOIN (
                SELECT
                  VALUE
                FROM
                  tmp
                WHERE
                  rid = 2) FIXEDDATESELL ON
                1 = 1
              INNER JOIN (
                SELECT
                  to_date(VALUE, 'dd/mm/yyyy') value
                FROM
                  tmp
                WHERE
                  rid = 3) PUTDATE ON
                1 = 1 ))b;

            END LOOP;*/
            -- ----
            end if;
       -- end if;
      end if;
      end if;

 END LOOP;
    plog.setendsection (pkgctx, 'fn_ProcessBeforeApprove');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessBeforeApprove');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessBeforeApprove;

FUNCTION fn_ProcessAfterApprove(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
    l_count1 number;
    l_count2 number;
    l_count3 number;
    l_refobjid  varchar2(12);
    l_tlid varchar(20);
    l_actionflag varchar2(400);
    l_childvalue varchar2(400);
    l_childkey varchar2(400);
    l_chiltable varchar2(400);
    g_symbol varchar2(400);
    s_refafacctno varchar2(400);
    s_symbol varchar2(400);
    p_tlidgt varchar2(400);
    l_custodycd varchar2(400);
    l_txdate        date;
    v_refactno varchar2(400);
    l_saleid varchar2(400);
    l_refid         integer;
    l_symbol        varchar2(100);
    l_intrcurvetp   varchar2(100);
    l_refafacctno   varchar2(100);
    l_ipodiscrate   NUMBER;
    l_calpvmethod varchar2(100);
    l_firtdate         date;
    l_lastdate          date;
    l_finish        NUMBER;
    l_start         NUMBER;
    l_autoid         NUMBER;
    l_InputCount     NUMBER;
    l_txnum        varchar2(100);
    l_productier      varchar2(400);
    l_return   varchar2(400);
    l_productierold  varchar2(400);
    l_productiernew  varchar2(400);
     l_parvalue      number;
     l_intrate       number;
     l_base          number;
     l_date_pay      date;
     l_date_pay_min  date;
     l_days          number;
     l_day_pay_cur   number;
     l_symbol_pay_cur varchar(2000);
     l_date_pay_cur  date;
     l_day_after_date number;
     l_rp_date       number;
     l_valuedt       date;
     l_status        varchar2(2);
     l_pstatus        varchar2(200);
     l_date_compare  date;
     l_ruletype     varchar2(200);
     l_feetierdata  varchar2(4000);
     l_protype     varchar2(200);
     l_procondition  varchar2(4000);
     l_selldtl varchar2(4000);
     l_buydtl varchar2(4000);
     l_coupondtl varchar2(4000);
     l_id number;
     l_valuedate     DATE;
     l_reviewdate NUMBER;
     l_symbol1 varchar2(4000);
     l_list_oxpost varchar2(4000);
     l_amount number;
     l_autoid2 number;
     l_limitval2 number;
     l_autoidi varchar(100);
     l_udfcodei VARCHAR(100);
     l_udfvaluei number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_ProcessAfterApprove');
    l_txdate    := p_objmsg.txdate;
    l_refobjid  :=  p_objmsg.CLAUSE;
    l_tlid := p_objmsg.TLID;
    l_txnum   := p_objmsg.txnum;
    plog.error (pkgctx, 'fn_Approve new '||l_refobjid);

    FOR REC IN ( SELECT * FROM objlog WHERE (AUTOID = l_refobjid OR PAUTOID =l_refobjid) AND (TXSTATUS = '1' or txstatus = '7' OR TXSTATUS = '4'))
LOOP
    l_refobjid:= REC.AUTOID;
    SELECT actionflag,childvalue,childkey,chiltable
    INTO l_actionflag,l_childvalue,l_childkey,l_chiltable FROM objlog WHERE AUTOID = l_refobjid;
   --INSERT INTO DRAFF_PHONG VALUES ('1111111han,'||l_childvalue ) ;
if rec.chiltable ='SBSEDEFACCT' then

    if l_actionflag in ('ADD','EDIT') then
            for rec in (select * from sbsedefacct s where s.autoid = l_childvalue)
            loop
                for rec1 in (select * from product p where p.symbol= rec.symbol and p.afacctno = rec.refafacctno)
                    loop
                    update product p set p.firstdate = rec.firtdate, p.lastdate = rec.lastdate, p.lastclosedate = rec.lastbuydate where p.autoid = rec1.autoid;
                    end loop;
                select count(*) into l_count from oxpost o where  o.symbol = rec.symbol and o.afacctno = rec.refafacctno and o.status ='A';
            if l_count > 0 then
            select listagg(o.ORDERID , '~') within group ( order by o.ORDERID ) into l_list_oxpost
            from oxpost o where  o.symbol = rec.symbol and o.afacctno = rec.refafacctno and o.status ='A' ;

                            txpks_notify.prc_system_logevent('SBSEDEFACCT', 'OXPOSTS',  'ALL'|| '~#~' ||'ALL'|| '~#~' ||l_list_oxpost, 'R','INSERT/UPDATE PRODUCT');

                end if;
            end loop;
    end if;
end if;

if REC.chiltable = 'PRODUCT' then
  IF l_actionflag in ('DELETE') THEN

    for rec in (select * from productmemo where autoid = l_childvalue)
        loop

        --if rec.effdate <= getcurrdate() and rec.expdate > getcurrdate() then
        select count(*) into l_count from oxpost o where o.productid = rec.shortname and o.symbol = rec.symbol and o.afacctno = rec.afacctno and o.status ='A';
        if l_count > 0 then
        select listagg(o.ORDERID , '~') within group ( order by o.ORDERID ) into l_list_oxpost
        from oxpost o where o.productid = rec.shortname and o.symbol = rec.symbol and o.afacctno = rec.afacctno and o.status ='A';


               txpks_notify.prc_system_logevent('PRODUCT', 'OXPOSTS',  'ALL'|| '~#~' ||'ALL'|| '~#~' ||l_list_oxpost, 'R','INSERT/UPDATE PRODUCT');


            end if;
    end loop;
     DELETE FROM PRODUCTSELLDTL WHERE id = l_childvalue;
     DELETE FROM PRODUCTBUYDTL WHERE id = l_childvalue;
     DELETE FROM PRODUCTCOUPONDTL WHERE id = l_childvalue;
end if;
    IF l_actionflag in ('ADD') THEN
        update product set codeid = fn_get_autoid_assetdtl((select symbol from product where autoid =  rec.childvalue)) where autoid = rec.childvalue;
      END IF;
    IF l_actionflag in ('ADD','EDIT') THEN

        for rec in (select * from product where autoid = l_childvalue)
            loop

            --if rec.effdate <= getcurrdate() and rec.expdate > getcurrdate() then
            select count(*) into l_count from oxpost o where o.productid = rec.shortname and o.symbol = rec.symbol and o.afacctno = rec.afacctno and o.status ='A';
            if l_count > 0 then
            select listagg(o.ORDERID , '~') within group ( order by o.ORDERID ) into l_list_oxpost
            from oxpost o where o.productid = rec.shortname and o.symbol = rec.symbol and o.afacctno = rec.afacctno and o.status ='A';


                            txpks_notify.prc_system_logevent('PRODUCT', 'OXPOSTS',  'ALL'|| '~#~' ||'ALL'|| '~#~' ||l_list_oxpost, 'R','INSERT/UPDATE PRODUCT');


                end if;
        end loop;

        SELECT count(*) INTO l_count FROM product p where p.autoid=l_childvalue;
            IF l_count > 0 THEN
                 select p.autoid ,p.selldtl, p.buydtl, p.coupondtl,p.calpvmethod  into l_id, l_selldtl, l_buydtl, l_coupondtl,l_calpvmethod from product p where p.autoid=l_childvalue;
            END IF;
             DELETE FROM PRODUCTSELLDTL WHERE id = l_childvalue;
             DELETE FROM PRODUCTBUYDTL WHERE id = l_childvalue;
             DELETE FROM PRODUCTCOUPONDTL WHERE id = l_childvalue;
         if l_calpvmethod='L' then
             insert_productselldtl(l_selldtl,l_id,p_err_code);
             insert_productbuydtl(l_buydtl,l_id,p_err_code);
         end if;
          if l_calpvmethod='C' then
             insert_productcoupondtl(l_coupondtl,l_id,p_err_code);
         end if;




  end if;
end if;
IF rec.chiltable ='RATEREFERENCE' then
    IF l_actionflag in ('EDIT', 'ADD') THEN
    for rec in (select * from ratereference where autoid = l_childvalue)
    loop
        for rec1 in (select * from assetdtl a where a.intratefltcd = 'Y' )
        loop
            for rec2 in (select * from intschd i where i.symbol= rec1.symbol and i.periodno >= rec1.kydieuchinh and i.fromdate >= rec.datevali
            and i.status='A')
            loop
            update intschd i set i.intrate= rec.rate + rec1.bien_do where i.autoid = rec2.autoid;
            end loop;
        end loop;
    end loop;
    END IF;
END IF;
IF rec.chiltable ='PAYMENT_SCHD' then
  IF l_actionflag in ('EDIT', 'ADD') THEN
        for rec in (select ps.autoid, i.fromdate, i2.todate, a.parvalue, ps.SYMBOL, ps.FROMPERIOD , ps.TOPERIOD, ps.RATIO from PAYMENT_SCHD ps
          left join assetdtl a on a.symbol = ps.symbol
         LEFT JOIN INTSCHD i ON i.SYMBOL = ps.SYMBOL AND ps.FROMPERIOD = i.PERIODNO
          LEFT JOIN INTSCHD i2 ON i2.SYMBOL = ps.SYMBOL AND ps.FROMPERIOD = i2.PERIODNO
          where ps.autoid = l_childvalue)
            loop
             update payment_schd set
                parvalue = rec.parvalue,
                days= rec.todate - rec.fromdate
                where autoid = rec.autoid;
              SELECT count(*) INTO l_count FROM INTSCHD i2 WHERE i2.SYMBOL = rec.symbol AND rec.FROMPERIOD <= i2.PERIODNO  AND rec.TOPERIOD >= i2.PERIODNO;
               IF l_count > 0 then
                 SELECT  ROUND(SUM(i2.amount) * rec.ratio / 100, 0) INTO l_amount FROM INTSCHD i2 WHERE i2.SYMBOL = rec.symbol AND rec.FROMPERIOD <= i2.PERIODNO  AND rec.TOPERIOD >= i2.PERIODNO;
                     update payment_schd set
                        AMOUNT = l_amount
                        where autoid = rec.autoid;
              END IF;
           end loop;

     END IF;
 END IF;
 IF rec.chiltable ='INTSCHD' then
         IF l_actionflag in ('EDIT', 'ADD') THEN
         for rec in (select i.autoid,i.symbol, i.fromdate, i.todate,i.intrate, a2.CDCONTENT intbaseddofy , a.parvalue from intschd i
          left join assetdtl a on a.symbol = i.symbol
          LEFT JOIN ALLCODE a2 ON a2.CDVAL = a.INTBASEDDOFY AND a2.CDTYPE ='SA' AND a2.CDNAME ='INTBASEDDOFY'
          where i.autoid = l_childvalue)
            loop
            --update intsch
             update intschd set
                parvalue = rec.parvalue,
                intbaseddofy = rec.intbaseddofy,
                days= rec.todate - rec.fromdate,
                amount= round((rec.parvalue*(rec.intrate/100)/rec.intbaseddofy)* (rec.todate-rec.fromdate),0 )
                where autoid = rec.autoid;
                --update stt ky tinh lai
                for rec1 in (select rownum periodno, autoid from (select  autoid from intschd where symbol = rec.symbol order by fromdate asc))
                    loop
                        update intschd set periodno = rec1.periodno where autoid = rec1.autoid;
                    end loop;
            end loop;

        end if;
         /*IF l_actionflag in ('DELETE') THEN
            for rec1 in (select rownum periodno, autoid from (select autoid from intschd where symbol = (select symbol from intschd where autoid = l_childvalue)
             order by fromdate asc))
                    loop
                        update intschd set periodno = rec1.periodno where autoid = rec1.autoid;
                    end loop;
         end if;*/
     end if;




       ---cap nhat lich thanh toan sau do
          if REC.chiltable = 'PAYMENT_HIST' then

          IF l_actionflag IN ('ADD','EDIT') THEN

    select days ,INTDATE,VALUEDT,symbol into l_day_pay_cur,l_date_pay_cur,l_valuedate,l_symbol_pay_cur from PAYMENT_HIST where autoid = l_childvalue;


    select count(*)into l_count
    FROM
        (SELECT * FROM PAYMENT_HIST ph
        WHERE SYMBOL = l_symbol_pay_cur AND INTDATE > l_date_pay_cur and STATUS != 'P'
        ORDER BY INTDATE ASC) x
    WHERE ROWNUM <= 1
    ;

    if l_count > 0 then

        --lay ban ghi date lon hon
        SELECT x.autoid,x.parvalue,x.intrate,x.INTBASEDDOFY,x.intdate
               into l_autoid,l_parvalue,l_intrate,l_base,l_date_pay
        FROM
            (SELECT * FROM PAYMENT_HIST ph
            WHERE SYMBOL = l_symbol_pay_cur AND INTDATE > l_date_pay_cur and STATUS != 'P'
            ORDER BY INTDATE ASC) x
        WHERE ROWNUM <= 1
        ;
        l_days := (l_date_pay - l_date_pay_cur);

       update payment_hist
                set amount = ROUND(l_intrate * l_parvalue/100*l_days/l_base, 0), days = l_days
                where autoid = l_autoid;

    end if;


    --update lai amount ban ghi vua them


    select count(*) into l_count
          FROM
        (SELECT * FROM PAYMENT_HIST ph
        WHERE SYMBOL = l_symbol_pay_cur AND INTDATE < l_date_pay_cur and STATUS != 'P'
        ORDER BY INTDATE desc) x
    WHERE ROWNUM <= 1
    ;

    SELECT BALANCEREPORTDATE into l_rp_date FROM ASSETDTL a WHERE SYMBOL = l_symbol_pay_cur ;


        IF l_actionflag IN ('EDIT') THEN
            SELECT x.autoid,a.PARVALUE,x.intrate,ad.CDCONTENT,x.intdate,x.valuedt
           into l_autoid,l_parvalue,l_intrate,l_base,l_date_pay,l_valuedt
             FROM payment_hist x
            JOIN ASSETDTL a ON x.SYMBOL  = a.SYMBOL
            JOIN ALLCODE ad ON ad.CDNAME = 'INTBASEDDOFY' AND ad.CDVAL = a.INTBASEDDOFY
            where x.autoid = l_childvalue ;
        else
            plog.debug(pkgctx,'.LOG.AUTOID: '||l_childvalue);
            SELECT x.autoid,a.PARVALUE,x.intrate,ad.CDCONTENT,x.intdate,x.valuedt
           into l_autoid,l_parvalue,l_intrate,l_base,l_date_pay,l_valuedt
             FROM payment_hist x
            JOIN ASSETDTL a ON x.SYMBOL  = a.SYMBOL
            JOIN ALLCODE ad ON ad.CDNAME = 'INTBASEDDOFY' AND ad.CDVAL = a.INTBASEDDOFY
            WHERE x.autoid = l_childvalue ;
            --INTDATE = l_date_pay_cur and   x.symbol = l_symbol_pay_cur AND x.VALUEDT = l_valuedate;

        end if;



    if l_count > 0 then

        SELECT x.INTDATE
               into l_date_pay_min
        FROM
            (SELECT * FROM PAYMENT_HIST ph
            WHERE SYMBOL = l_symbol_pay_cur AND INTDATE < l_date_pay_cur and STATUS != 'P'
            ORDER BY INTDATE desc) x
        WHERE ROWNUM <= 1
        ;

        l_days := ( l_date_pay - l_date_pay_min );
        /*
        --dong lich sau dong lich dau tien

        SELECT count(*) into l_count  FROM  (SELECT * FROM PAYMENT_HIST ph
        WHERE SYMBOL = l_symbol_pay_cur ORDER BY VALUEDT ASC) WHERE ROWNUM = 1;


            if l_count > 0 then
                SELECT VALUEDT into l_date_compare  FROM  (SELECT * FROM PAYMENT_HIST ph
                WHERE SYMBOL = l_symbol_pay_cur ORDER BY VALUEDT ASC) WHERE ROWNUM = 1;
                if l_date_compare > l_date_pay_cur then
                    l_days := l_days + 1;
                end if;



            end if;
        */
    else
        SELECT OPNDATE into l_date_pay_min  FROM ASSETDTL a WHERE SYMBOL = l_symbol_pay_cur;
        l_days := ( l_date_pay - l_date_pay_min ) ;
    end if;




    update payment_hist
            set amount = ROUND(l_intrate * l_parvalue/100*l_days/l_base, 0), days = l_days,
            INTBASEDDOFY = l_base,
            PARVALUE = l_parvalue,
            reportdt = fn_get_date_payment(to_char(l_date_pay,'dd/mm/yyyy'),l_rp_date)
            where autoid = l_autoid;

     end if;

    --Dong bo chao ban neu tai san ton tai chao ban
      SELECT COUNT(*) INTO l_count FROM OXPOST o WHERE SYMBOL = l_symbol_pay_cur;
      IF l_count > 0 THEN
        txpks_notify.prc_system_logevent('PAYMENT_HIST', 'OXPOSTS', 'ALL' || '~#~' || 'ALL' || '~#~' || 'ALL', 'R', 'INSERT/UPDATE OXPOST');
      END IF;

    /*$txpks_notify.prc_system_logevent('', 'OXMASTS',
                'ALL' || '~#~' ||
                'ALL' || '~#~' ||
                'ALL', 'R','INSERT/UPDATE OXMAST');*/
      txpks_notify.prc_system_logevent('', 'SEREQCLOSE',
                'ALL' || '~#~' ||
                'ALL' || '~#~' ||
                'ALL', 'R','INSERT/UPDATE OXMAST');

    end if;



    if l_actionflag in ('ADD', 'EDIT') then

       /* if REC.chiltable = 'ISSUERS' then
            SELECT a.autoid, a.udfcode, a.udfvalue INTO l_autoidi, l_udfcodei,l_udfvaluei FROM issuers a WHERE a.AUTOID = l_childvalue;
            INSERT INTO issuers_udf (AUTOID, ISSUERID,UDFFIELD, UDFVALUE )
               VALUES
              (seq_issuers_udf.NEXTVAL, l_autoidi, l_udfcodei,l_udfvaluei );
             --insert into draff_phong values (l_udfcodei);


        end if;*/


        if REC.chiltable = 'ASSETDTL' then
           -- fopks_asset.prc_create_payment_hist
            fopks_quan_dev.prc_create_intschd1
                   (p_autoid=>l_childvalue,
                     p_err_code=>p_err_code);
            --fopks_quan_dev.prc_create_payment_schd
              --     (p_autoid=>l_childvalue,
               --      p_err_code=>p_err_code);

            if p_err_code <> systemnums.C_SUCCESS then
                  plog.setendsection (pkgctx, 'fn_ProcessAfterApprove');
                  ROLLBACK;
                  RAISE errnums.E_SYSTEM_ERROR;
            end if;
            select a.status, a.pstatus into l_status, l_pstatus from assetdtl a where a.autoid = l_childvalue;
            update buyoption set status = l_status, pstatus = l_pstatus where id = l_childvalue;
            update selloption set status = l_status, pstatus = l_pstatus where id = l_childvalue;

            --Quan cap nhat reviewdt
            If l_reviewdate =0 then

                SELECT a.reviewdate, a.SYMBOL INTO l_reviewdate, l_symbol1 FROM ASSETDTL a WHERE a.AUTOID = l_childvalue;
                UPDATE PAYMENT_HIST SET REVIEWDT = (VALUEDT + l_reviewdate) WHERE SYMBOL = l_symbol1;

            else
                UPDATE PAYMENT_HIST SET REVIEWDT = NULL WHERE SYMBOL = l_symbol1;
            end if;
            --
        end if;
        --han them feetype

        if REC.chiltable='FEETYPE' then
        select f.ruletype, f.FEETIERDATA into l_ruletype, l_feetierdata from feetype f where f.id=l_childvalue;
         if l_ruletype = 'F' then
        -- xoa feetier cu
        delete from feetier where feeid=l_childvalue;
        end if;
        if l_ruletype = 'T' then
        -- xoa feetier cu
        delete from feetier where feeid=l_childvalue;

             FOR
        record IN (
        SELECT REGEXP_REPLACE(TRIM (fil.char_value), '\(|\)', '') fil_cond
        FROM (
        SELECT fn_pivot_string (
        REGEXP_REPLACE (l_feetierdata,
        '~\$~', '|'))
        filter_row
        FROM DUAL
        ),
        table (filter_row) fil
        )

        LOOP
                --insert into ahihi values (record.FIL_COND);

              INSERT
              INTO
              SHBCBD.feetier ( ID, FEEID, FRAMT, TOAMT, FEEAMT, FEERATE,STATUS, LASTCHANGE)
            SELECT
              seq_FEETIER.nextval,
              l_childvalue,
              b.framt,
              b.toamt,
              null ,
              b.fee ,
              null,
              NULL
            FROM
              (SELECT
              *
            FROM
              (WITH tmp AS (
              SELECT
                REGEXP_REPLACE (TRIM (fil.char_value), '\(|\)', '') VALUE, fil.rid
              FROM
                (
                SELECT
                  fn_pivot_string ( REGEXP_REPLACE (record.FIL_COND, '~\#~', '|')) filter_row
                FROM
                  DUAL), TABLE (filter_row) fil)
              SELECT
                framt.VALUE framt , toamt.VALUE toamt , fee.VALUE fee
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
              INNER JOIN (
                SELECT
                  VALUE
                FROM
                  tmp
                WHERE
                  rid = 3) fee ON
                1 = 1 ))b;

      END LOOP;
        end if;

txpks_notify.prc_system_logevent('FEETYPE', 'OXMASTS',  'ALL'|| '~#~' ||'ALL'|| '~#~' ||'ALL', 'R','INSERT/UPDATE OXMAST');
        end if;
        --cuong them phi hoa hong
        if REC.chiltable='COMMISSION' then
        select f.ruletype, f.feetierdata into l_ruletype, l_feetierdata from commission f where f.id=l_childvalue;
         if l_ruletype = 'F' then
        -- xoa commission cu
        delete from commission_dtl where commissionid=l_childvalue;
        end if;
        if l_ruletype = 'T' then
        -- xoa commission cu
        delete from commission_dtl where commissionid=l_childvalue;

             FOR
        record IN (
        SELECT REGEXP_REPLACE(TRIM (fil.char_value), '\(|\)', '') fil_cond
        FROM (
        SELECT fn_pivot_string (
        REGEXP_REPLACE (l_feetierdata,
        '~\$~', '|'))
        filter_row
        FROM DUAL
        ),
        table (filter_row) fil
        )

        LOOP
                --insert into ahihi values (record.FIL_COND);

              INSERT
              INTO
              SHBCBD.commission_dtl ( ID, COMMISSIONID, FRAMT, TOAMT, FEERATE,STATUS, LASTCHANGE)
            SELECT
              seq_commission_dtl.nextval,
              l_childvalue,
              b.framt,
              b.toamt,
              b.fee ,
              null,
              NULL
            FROM
              (SELECT
              *
            FROM
              (WITH tmp AS (
              SELECT
                REGEXP_REPLACE (TRIM (fil.char_value), '\(|\)', '') VALUE, fil.rid
              FROM
                (
                SELECT
                  fn_pivot_string ( REGEXP_REPLACE (record.FIL_COND, '~\#~', '|')) filter_row
                FROM
                  DUAL), TABLE (filter_row) fil)
              SELECT
                framt.VALUE framt , toamt.VALUE toamt , fee.VALUE fee
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
              INNER JOIN (
                SELECT
                  VALUE
                FROM
                  tmp
                WHERE
                  rid = 3) fee ON
                1 = 1 ))b;

      END LOOP;
     --DELETE FROM COMMISSION_DTLMEMO WHERE to_char(COMMISSIONID) = to_char(l_childvalue);
        end if;


        end if;
 --cuong them chuong trinh thuong
        if REC.chiltable='COMPROGRAM' then
        select f.ruletype, f.feetierdata,f.protype,f.procondition into l_ruletype, l_feetierdata,l_protype,l_procondition from comprogram f where f.id=l_childvalue;
         if l_ruletype = 'F' then
        -- xoa commission cu
        delete from comprogram_dtl where proid=l_childvalue;
        end if;
        if l_ruletype = 'T' then
        -- xoa commission cu
        delete from comprogram_dtl where proid=l_childvalue;

             FOR
        record IN (
        SELECT REGEXP_REPLACE(TRIM (fil.char_value), '\(|\)', '') fil_cond
        FROM (
        SELECT fn_pivot_string (
        REGEXP_REPLACE (l_feetierdata,
        '~\$~', '|'))
        filter_row
        FROM DUAL
        ),
        table (filter_row) fil
        )

        LOOP
                --insert into ahihi values (record.FIL_COND);

              INSERT
              INTO
              SHBCBD.comprogram_dtl ( ID, PROID, FRAMT, TOAMT, FEERATE)
            SELECT
              seq_comprogram_dtl.nextval,
              l_childvalue,
              b.framt,
              b.toamt,
              b.fee
            FROM
              (SELECT
              *
            FROM
              (WITH tmp AS (
              SELECT
                REGEXP_REPLACE (TRIM (fil.char_value), '\(|\)', '') VALUE, fil.rid
              FROM
                (
                SELECT
                  fn_pivot_string ( REGEXP_REPLACE (record.FIL_COND, '~\#~', '|')) filter_row
                FROM
                  DUAL), TABLE (filter_row) fil)
              SELECT
                framt.VALUE framt , toamt.VALUE toamt , fee.VALUE fee
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
              INNER JOIN (
                SELECT
                  VALUE
                FROM
                  tmp
                WHERE
                  rid = 3) fee ON
                1 = 1 ))b;

      END LOOP;
     --DELETE FROM COMMISSION_DTLMEMO WHERE to_char(COMMISSIONID) = to_char(l_childvalue);
        end if;


        --dieu kien thuong
           if l_protype = 'C' then
        -- xoa commission cu
        delete from comprogram_cond where proid=l_childvalue;
        end if;
        if l_protype <> 'C' then
        -- xoa commission cu
        delete from comprogram_cond where proid=l_childvalue;

             FOR
        record IN (
        SELECT REGEXP_REPLACE(TRIM (fil.char_value), '\(|\)', '') fil_cond
        FROM (
        SELECT fn_pivot_string (
        REGEXP_REPLACE (l_procondition,
        '~\$~', '|'))
        filter_row
        FROM DUAL
        ),
        table (filter_row) fil
        )

        LOOP
                --insert into ahihi values (record.FIL_COND);

              INSERT
              INTO
              SHBCBD.comprogram_cond ( ID, PROID, condvalue)
            SELECT
              seq_comprogram_cond.nextval,
              l_childvalue,
              b.condvalue
            FROM
              (SELECT
              *
            FROM
              (WITH tmp AS (
              SELECT
                REGEXP_REPLACE (TRIM (fil.char_value), '\(|\)', '') VALUE, fil.rid
              FROM
                (
                SELECT
                  fn_pivot_string ( REGEXP_REPLACE (record.FIL_COND, '~\#~', '|')) filter_row
                FROM
                  DUAL), TABLE (filter_row) fil)
              SELECT
                condvalue.VALUE condvalue
              FROM
                (
                SELECT
                  VALUE
                FROM
                  tmp
                WHERE
                  rid = 1) condvalue
              ))b;

      END LOOP;
      end if;

        end if;

  -- han them duong cong lai suat
   if REC.chiltable='OXINTRCURVE' THEN
        SELECT count(*) INTO l_count FROM OXINTRCURVE  p where p.autoid=l_childvalue;
            IF l_count > 0 THEN
                 select p.autoid ,p.selldtl, p.buydtl  into l_id, l_selldtl, l_buydtl from OXINTRCURVE p where p.autoid=l_childvalue;
            END IF;

         DELETE FROM curve_selldtl WHERE id = l_childvalue;
         DELETE FROM curve_buydtl WHERE id = l_childvalue;
        FOR record
                IN (SELECT REGEXP_REPLACE (TRIM (fil.char_value),
                                           '\(|\)',
                                           '')
                               fil_cond
                      FROM (SELECT fn_pivot_string (
                                       REGEXP_REPLACE (l_selldtl, '~\$~', '|'))
                                       filter_row
                              FROM DUAL),
                           TABLE (filter_row) fil)
            LOOP
                INSERT INTO CURVE_SELLDTL (autoid,
                                                    id,
                                                    termcd,
                                                    "FROM",
                                                    "TO",
                                                    "TYPE",
                                                    AMPLITUDE,
                                                    rate,

                                                    action,
                                                    STATUS)
                    SELECT SEQ_SELLDTL.NEXTVAL,
                           l_id,
                           b.TERMCD,
                           b."FROM",
                           B."TO",
                            b."TYPE",
                            b.AMPLITUDE,
                           to_number(B.RATE),

                           'ADD',
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
            FOR record
                IN (SELECT REGEXP_REPLACE (TRIM (fil.char_value),
                                           '\(|\)',
                                           '')
                               fil_cond
                      FROM (SELECT fn_pivot_string (
                                       REGEXP_REPLACE (l_buydtl, '~\$~', '|'))
                                       filter_row
                              FROM DUAL),
                           TABLE (filter_row) fil)
            LOOP
                INSERT INTO curve_buydtl (autoid,
                                                    id,
                                                    termcd,
                                                    "FROM",
                                                    "TO",
                                                    "TYPE",
                                                    rate,
                                                    feebuy,
                                                    AMPLITUDE,
                                                    CALRATE_METHOD,
                                                    ACTION,
                                                    STATUS)
                    SELECT SEQ_BUYDTL.NEXTVAL,
                           l_id,
                           b.TERMCD,
                           b."FROM",
                           B."TO",
                           b."TYPE",
                           to_number(B.RATE),
                           to_number(B.FEEBUY),
                           to_number(B.AMPLITUDE),
                            b.CALRATE_METHOD,
                           'ADD',
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
                                            (select value CALRATE_METHOD from tmp t where t.rid = 7) t7,
                                            (select value FEEBUY from tmp t where t.rid = 8) t8
                                        )  ) ) b;
            END LOOP;


      end if;

       end if;
        -- han them product

    if l_actionflag in ('ADD') THEN
      /*IF REC.chiltable = 'SA.ISSUERS' THEN
        update issuers s
        set s.issuerid = lpad(s.autoid,10,'0')
        where s.autoid = rec.childvalue;
      END IF;*/

       --Ghi log paymenthist




      IF REC.chiltable = 'CFMAST' THEN
        SELECT count(1) INTO l_count from cfmast cf where custid = l_childvalue and mobilegt is not null and mobilegt <> '' ;
        if(l_count > 0) THEN
            select nvl(tlidgt, '' ) ,nvl(custodycd, '')  into p_tlidgt ,l_custodycd  from cfmast cf where custid = l_childvalue and mobilegt is not null and mobilegt <> '' ;
            select count(1)  into l_count
            from sale_retype srt
            , sale_roles sr
            where sr.saleid =  p_tlidgt  and sr.effdate<=l_txdate
                        and srt.rerole = 'RD'
                        and sr.retype = srt.autoid
                        and sr.expdate >= l_txdate  and sr.status ='A';
            if(l_count > 0) THEN
                select sr.saleid into v_refactno
                    from sale_retype srt
                    , sale_roles sr
                    where sr.saleid =  p_tlidgt  and sr.effdate<=l_txdate
                            and srt.rerole = 'RD'
                            and sr.retype = srt.autoid
                            and sr.expdate >= l_txdate  and sr.status ='A';

                    insert into sale_customers (txdate, txnum, reftype, refacctno, saleid, frdate, todate, deltd, saleacctno,status)
                    select l_txdate ,
                                l_txnum,
                                'ACC',
                                l_custodycd,
                                p_tlidgt,
                                l_txdate ,
                                l_txdate + 99*360,
                                'N',
                                v_refactno,'A'  FROM dual;

            END IF;
            select nvl(saleid, '' ), custodycd  into l_saleid ,l_custodycd from cfmast where custid = l_childvalue ;
            if( l_saleid <>  '') then
                v_refactno :=   l_saleid;
                insert into sale_customers (txdate, txnum, reftype, refacctno, saleid, frdate, todate, deltd, saleacctno,status)
                        select l_txdate ,
                                    l_txnum,
                                    'ACC',
                                    l_custodycd,
                                    left_(l_saleid,6 ),
                                    l_txdate ,
                                    l_txdate + 99*360,
                                    'N',
                                    v_refactno,'A'  FROM dual;
            END IF;

          END IF;
      end if;

      IF REC.chiltable = 'SBSEDEFACCT' THEN
           --INSERT INTO DRAFF_PHONG VALUES ('1111111han1,'||l_childvalue ) ;
        SELECT count(1) INTO l_count FROM SBSEDEFACCT WHERE autoid = rec.childvalue;
        IF (l_count <> 0) THEN
         --INSERT INTO DRAFF_PHONG VALUES ('1111111han2,'||l_childvalue ) ;
            select tl.refid,tl.symbol,nvl(tl.intrcurvetp, '' ),tl.refafacctno, tl.ipodiscrate , tl.calpv_method,nvl( tl.firtdate , to_date('0001-01-01 00:00:00', 'yyyy-mm-dd hh24:mi:ss ' )),nvl(  tl.lastdate , to_date('2100-01-01 00:00:00', 'yyyy-mm-dd hh24:mi:ss ' ))
                    into l_refid, l_symbol,l_intrcurvetp,l_refafacctno, l_ipodiscrate, l_calpvmethod, l_firtdate, l_lastdate
                    from SBSEDEFACCT tl
                    where autoid = rec.childvalue;
            /* if l_symbol = 'All-T?t c?' then
                insert into sbsedefacct
                (autoid,codeid,refid,category,refafacctno,crbankacct,drbankacct,bankcd,bidasksprd,ipodiscrate,symbol,description, status, lastchange, intrcurvetp, pstatus , calpv_method, citybank, firtdate, lastdate)values
                (select seq_sbsedefacct.nextval,a.autoid,null,sb.category,sb.refafacctno,sb.crbankacct,sb.drbankacct,sb.bankcd,
                    sb.bidasksprd,sb.ipodiscrate,a.symbol,sb.description,'A',sb.lastchange,sb.intrcurvetp,sb.pstatus,sb.calpv_method,sb.citybank,sb.firtdate,sb.lastdate
                    from sbsedefacct sb,assetdtl a
                    where sb.symbol = 'All-T?t c?'
                    and sb.autoid = rec.childvalue
                    and a.status = 'A'
                    and not exists (select 1 from sbsedefacct sb1 where sb1.symbol = a.symbol and sb1.refafacctno = sb.refafacctno and sb1.status <> 'R')
                    )
              end if;
              -- insert vao trong product count() == 1

              IF (l_intrcurvetp IS NOT NULL) THEN
               --INSERT INTO DRAFF_PHONG VALUES ('1111111han3,'||l_childvalue ) ;
                FOR ox in (
                    SELECT ox.autoid,
                           NULL refid,
                           a.autoid codeid,
                           ox.shortname,
                           l_intrcurvetp intrcurvetp,
                           ox.termval,
                           ox.termcd,
                           l_refafacctno refafacctno,
                           GREATEST (l_firtdate, ox.effdate) effdate,
                           LEAST (l_lastdate, ox.expdate) expdate,
                           ox.status,
                           ox.description,
                           l_symbol symbol,
                           ox.pstatus,
                           ox.lastchange,
                           ox.tattoan,
                           ox.calpv_method calpvmethod,
                           l_firtdate firtdate,
                           l_lastdate lastdate,
                           ox.selldtl,
                           ox.buydtl,
                           ox.discountrate ,
                           ox.discountrate2,

                           ox.feebuyrate,
                           ox.intbaseddofy
                      FROM     oxintrcurve ox
                           INNER JOIN
                                 assetdtl a
                           ON a.symbol = l_symbol
                           LEFT JOIN
                               assetdtl b
                           ON NVL (ox.symbol, b.symbol) = b.symbol
                              AND NVL (ox.typesymbol, b.sectype) = b.sectype
                     WHERE     1=1
                           AND ox.shortname IN (SELECT shortname
                                                  FROM (SELECT a.shortname, COUNT (1)
                                                          FROM oxintrcurve a
                                                          INNER JOIN assetdtl b ON b.symbol = l_symbol
                                                          WHERE a.status = 'A'
                                                          and a.effdate<= getcurrdate()
                                                          and a.expdate >= getcurrdate()
                                                          and NVL(a.symbol,l_symbol) = l_symbol
                                                          and NVL(a.typesymbol, b.sectype) = b.sectype
                                                        GROUP BY a.shortname
                                                        HAVING COUNT (1) = 1))
                           AND b.symbol LIKE l_symbol
                           AND GREATEST (l_firtdate, ox.effdate) <=
                                   LEAST (l_lastdate, ox.expdate)
                           AND ox.status = 'A'
                           and ox.effdate<= getcurrdate()
                           and ox.expdate >= getcurrdate()
                           )
                 loop
                 --INSERT INTO DRAFF_PHONG VALUES ('1111111han4,'||l_childvalue ) ;
                        l_autoid := seq_product.NEXTVAL;
                        l_id := ox.autoid;
                        INSERT INTO product (autoid,
                                             codeid,
                                             shortname,
                                             intrcurvetp,
                                             afacctno,
                                             termval,
                                             termcd,
                                             effdate,
                                             expdate,
                                             status,
                                             description,
                                             symbol,
                                             pstatus,
                                             lastchange,
                                             discountrate,
                                             discountrate2,
                                             feebuyrate,
                                             earlywithdraw,
                                             firstdate,
                                             lastdate,
                                             calpvmethod,
                                             lastclosedate,
                                             selldtl,
                                             buydtl,
                                             intbaseddofy)
                            SELECT l_autoid,
                                   ox.codeid,
                                   ox.shortname,
                                   ox.intrcurvetp,
                                   ox.refafacctno,
                                   ox.termval,
                                   ox.termcd,
                                   ox.effdate,
                                   ox.expdate,
                                   ox.status,
                                   ox.description,
                                   ox.symbol,
                                   ox.pstatus,
                                   ox.lastchange,
                                   ox.discountrate discountrate,
                                   ox.discountrate2 discountrate2,
                                   ox.feebuyrate feebuyrate,
                                   ox.tattoan earlywithdraw,
                                   ox.firtdate,
                                   ox.lastdate,
                                   ox.calpvmethod calpvmethod,
                                   NULL lastclosedate,
                                   ox.selldtl,
                                   ox.buydtl ,
                                   ox.intbaseddofy
                              FROM DUAL;

                        INSERT INTO productselldtl (autoid,
                                                    id,
                                                    termcd,
                                                    "FROM",
                                                    "TO",
                                                    "TYPE",
                                                    rate,
                                                    amplitude,
                                                    --calrate_method,
                                                    status,
                                                    pstatus)
                            SELECT seq_selldtl.NEXTVAL,
                                   l_autoid,
                                   c.termcd,
                                   c."FROM",
                                   c."TO",
                                   c."TYPE",
                                   c.rate,
                                   c.amplitude,
                                   --c.calrate_method,
                                   'A' status,
                                   NULL pstatus
                              FROM curve_selldtl c
                             WHERE c.id = l_id;

                        INSERT INTO productbuydtl (autoid,
                                                   id,
                                                   termcd,
                                                   "FROM",
                                                   "TO",
                                                   "TYPE",
                                                   rate,
                                                   amplitude,
                                                   calrate_method,
                                                   feebuy,
                                                   status,
                                                   pstatus)
                            SELECT seq_buydtl.NEXTVAL,
                                   l_autoid,
                                   c.termcd,
                                   c."FROM",
                                   c."TO",
                                   c."TYPE",
                                   c.rate,
                                   c.amplitude,
                                   c.calrate_method,
                                   c.feebuy,
                                   'A' status,
                                   NULL pstatus
                              FROM curve_buydtl c
                             WHERE c.id = l_id;
                end loop;


                    -- insert vao trong product count() > 1
                    FOR ox in (
                        SELECT ox.autoid,
                               NULL refid,
                               a.autoid codeid,
                               ox.shortname,
                               l_intrcurvetp intrcurvetp,
                               ox.termval,
                               ox.termcd,
                               l_refafacctno refafacctno,
                               GREATEST (l_firtdate, ox.effdate) effdate,
                               LEAST (l_lastdate, ox.expdate) expdate,
                               ox.status,
                               ox.description,
                               l_symbol symbol,
                               ox.pstatus,
                               ox.lastchange,
                               ox.tattoan,
                               ox.calpv_method calpvmethod,
                               l_firtdate firtdate,
                               l_lastdate lastdate,
                               ox.selldtl,
                               ox.buydtl,
                               ox.discountrate ,
                               ox.discountrate2,
                               ox.feebuyrate,
                               ox.intbaseddofy
                        FROM (SELECT MAX (c.stt) stt_max, c.shortname
                              FROM     (SELECT CASE
                                                   WHEN a.symbol IS NOT NULL THEN 3
                                                   WHEN a.typesymbol IS NOT NULL THEN 2
                                                   ELSE 1
                                               END
                                                   stt,
                                               a.shortname,
                                               NVL (a.symbol, l_symbol) symbol,
                                               a.typesymbol,
                                               a.autoid,
                                               a.status
                                          FROM oxintrcurve a
                                         WHERE a.shortname IN (SELECT shortname
                                                                 FROM (SELECT a.shortname, COUNT (1)
                                                                         FROM oxintrcurve a
                                                                         INNER JOIN assetdtl b ON b.symbol = l_symbol
                                                                        WHERE a.status = 'A'
                                                                        and a.effdate<= getcurrdate()
                                                                        and a.expdate >= getcurrdate()
                                                                        and NVL(a.symbol,l_symbol) = l_symbol
                                                                        and NVL(a.typesymbol, b.sectype) = b.sectype
                                                                       GROUP BY a.shortname
                                                                       HAVING COUNT (1) > 1))) c
                                   INNER JOIN
                                       assetdtl b
                                   ON b.symbol = l_symbol
                             WHERE     c.status = 'A'
                                   AND NVL (c.symbol, l_symbol) = l_symbol
                                   AND NVL (c.typesymbol, b.sectype) = b.sectype
                            GROUP BY c.shortname) p
                        INNER JOIN (SELECT CASE
                                           WHEN a.symbol IS NOT NULL THEN 3
                                           WHEN a.typesymbol IS NOT NULL THEN 2
                                           ELSE 1
                                       END
                                           stt,
                                       a.*
                                  FROM oxintrcurve a
                                  Where status = 'A') ox
                        ON p.stt_max = ox.stt AND p.shortname = ox.shortname
                        INNER JOIN assetdtl a
                        ON a.symbol = l_symbol
                        WHERE 1=1
                           -- AND ox.symbol = l_symbol
                        AND GREATEST(l_firtdate, ox.effdate) <=  LEAST(l_lastdate, ox.expdate)
                         and ox.effdate<= getcurrdate()
                           and ox.expdate >= getcurrdate()
                        )
                    LOOP
                  --  INSERT INTO DRAFF_PHONG VALUES ('1111111han5,'||l_childvalue ) ;
                        l_autoid := seq_product.NEXTVAL;
                        l_id := ox.autoid;
                         INSERT INTO product (autoid,
                                             codeid,
                                             shortname,
                                             intrcurvetp,
                                             afacctno,
                                             termval,
                                             termcd,
                                             effdate,
                                             expdate,
                                             status,
                                             description,
                                             symbol,
                                             pstatus,
                                             lastchange,
                                             discountrate,
                                             discountrate2,
                                             feebuyrate ,
                                             earlywithdraw,
                                             firstdate,
                                             lastdate,
                                             calpvmethod,
                                             lastclosedate,
                                             selldtl,
                                             buydtl,
                                             intbaseddofy)
                            SELECT l_autoid,
                                   ox.codeid,
                                   ox.shortname,
                                   ox.intrcurvetp,
                                   ox.refafacctno,
                                   ox.termval,
                                   ox.termcd,
                                   ox.effdate,
                                   ox.expdate,
                                   ox.status,
                                   ox.description,
                                   ox.symbol,
                                   ox.pstatus,
                                   ox.lastchange,
                                   ox.discountrate discountrate,
                                   ox.discountrate2 discountrate2,
                                   ox.feebuyrate feebuyrate,
                                   ox.tattoan earlywithdraw,
                                   ox.firtdate,
                                   ox.lastdate,
                                   ox.calpvmethod calpvmethod,
                                   NULL lastclosedate,
                                   ox.selldtl,
                                   ox.buydtl,
                                   ox.intbaseddofy
                              FROM DUAL;

                        INSERT INTO productselldtl (autoid,
                                                    id,
                                                    termcd,
                                                    "FROM",
                                                    "TO",
                                                    "TYPE",
                                                    rate,
                                                    amplitude,
                                                    --calrate_method,
                                                    status,
                                                    pstatus)
                            SELECT seq_selldtl.NEXTVAL,
                                   l_autoid,
                                   c.termcd,
                                   c."FROM",
                                   c."TO",
                                   c."TYPE",
                                   c.rate,
                                   c.amplitude,
                                   --c.calrate_method,
                                   'A' status,
                                   NULL pstatus
                              FROM curve_selldtl c
                             WHERE c.id = l_id;

                        INSERT INTO productbuydtl (autoid,
                                                   id,
                                                   termcd,
                                                   "FROM",
                                                   "TO",
                                                   "TYPE",
                                                   rate,
                                                   amplitude,
                                                   calrate_method,
                                                   feebuy,
                                                   status,
                                                   pstatus)
                            SELECT seq_buydtl.NEXTVAL,
                                   l_autoid,
                                   c.termcd,
                                   c."FROM",
                                   c."TO",
                                   c."TYPE",
                                   c.rate,
                                   c.amplitude,
                                   c.calrate_method,
                                   c.feebuy,
                                   'A' status,
                                   NULL pstatus
                              FROM curve_buydtl c
                             WHERE c.id = l_id;
                    END LOOP;
              END IF;
        END IF;
      */
      END IF;
end if;
      if REC.chiltable = 'ASSETDTL' then
        -- insert b?ng fund
        --INSERT INTO DRAFF_PHONG VALUES ('1111111,'||l_childvalue ) ;
        insert into fund(codeid, symbol, name_en, ftype, status, pstatus, lastchange, name_vn)
        select autoid, symbol, fullname_en, 'O', status, pstatus, lastchange, fullname_vn
        from assetdtl
        where autoid = l_childvalue;

        select symbol into g_symbol from assetdtl where autoid  = l_childvalue;
        select count(*) into l_count1 from oxintrcurve where symbol = g_symbol and status ='A';
          select count(*) into l_count2 from oxintrcurve ox join assetdtl a on ox.typesymbol = a.sectype
          where a.symbol = g_symbol and nvl(ox.symbol,'') = '';
          select count(*) into l_count3 from oxintrcurve ox
          where nvl(ox.typesymbol,'') = ''
          and nvl(ox.symbol,'') = '';

       /* insert into sbsedefacct
        select seq_sbsedefacct.nextval, a.autoid, null, sb.category, sb.refafacctno, sb.crbankacct,
        sb.drbankacct, sb.bankcd, sb.bidasksprd, sb.ipodiscrate,
        g_symbol symbol, sb.description, sb.status, sb.lastchange, sb.intrcurvetp, sb.pstatus, sb.calpv_method, sb.citybank ,sb.firtdate, sb.lastdate
        from sbsedefacct sb,assetdtl a
        Where sb.symbol = 'All-T?t c?' and sb.status = 'A' and a.symbol = g_symbol;*/

        /*if(l_count2>0) then

                insert into product (AUTOID,REFID,CODEID,SHORTNAME,INTRCURVETP,TERMCD, AFACCTNO,
                    RATE00,RATE01,RATE02,RATE03,RATE04,RATE05,RATE06,
                    RATE07,RATE08,RATE09,RATE10,RATE11,RATE12,RATE13,RATE14,RATE15,RATE16,
                    EFFDATE,EXPDATE,STATUS,DESCRIPTION,TERMVAL,INTRATE,prolimitbal,prostdate,
                    protodate,proprice,produeamt,proytc,symbol,pstatus,lastchange, discountrate, discountrate2,
                    earlywithdraw, calpvmethod, firstdate , lastdate )
                select seq_product.NEXTVAL, null, a.autoid, ox.SHORTNAME, sb.intrcurvetp, ox.TERMCD, sb.refafacctno,
                    ox.RATE00,ox.RATE01,ox.RATE02,ox.RATE03,ox.RATE04,ox.RATE05,ox.RATE06,
                    ox.RATE07,ox.RATE08,ox.RATE09,ox.RATE10,ox.RATE11,ox.RATE12,ox.RATE13,ox.RATE14,ox.RATE15,ox.RATE16,
                    ox.EFFDATE,ox.EXPDATE,ox.STATUS,ox.DESCRIPTION,ox.TERMVAL,ox.INTRATE,ox.prolimitbal,ox.prostdate,
                    ox.protodate,ox.proprice,ox.produeamt,ox.proytc,g_symbol,ox.pstatus,ox.lastchange, sb.ipodiscrate, sb.ipodiscrate,
                    ox.tattoan, ox.calpv_method , a.opndate , a.duedate - 1
                    from  oxintrcurve ox, assetdtl a,sbsedefacct sb
                    where a.symbol = g_symbol and ox.status = 'A'
                    and sb.symbol = 'All-T?t c?' and sb.status = 'A' and ox.typesymbol = a.sectype
                    and sb.intrcurvetp = 'TMP'
                    --and a.status = 'A'
                    and not exists (select 1 from Product where symbol =a.symbol and termval =  ox.TERMVAL and afacctno = sb.refafacctno)
                    and ox.effdate <= to_date(fn_getcurrdate(), 'DD/MM/YYYY') and ox.expdate > to_date(fn_getcurrdate(), 'DD/MM/YYYY');


         end if;
         if(l_count3 >0 and l_count2 =0) then
                insert into product (AUTOID,REFID,CODEID,SHORTNAME,INTRCURVETP,TERMCD, AFACCTNO,
                    RATE00,RATE01,RATE02,RATE03,RATE04,RATE05,RATE06,
                    RATE07,RATE08,RATE09,RATE10,RATE11,RATE12,RATE13,RATE14,RATE15,RATE16,
                    EFFDATE,EXPDATE,STATUS,DESCRIPTION,TERMVAL,INTRATE,prolimitbal,prostdate,
                    protodate,proprice,produeamt,proytc,symbol,pstatus,lastchange, discountrate, discountrate2,
                    earlywithdraw, calpvmethod, firstdate , lastdate )
                select seq_product.NEXTVAL, null, a.autoid, ox.SHORTNAME, sb.intrcurvetp, ox.TERMCD, sb.refafacctno,
                    ox.RATE00,ox.RATE01,ox.RATE02,ox.RATE03,ox.RATE04,ox.RATE05,ox.RATE06,
                    ox.RATE07,ox.RATE08,ox.RATE09,ox.RATE10,ox.RATE11,ox.RATE12,ox.RATE13,ox.RATE14,ox.RATE15,ox.RATE16,
                    ox.EFFDATE,ox.EXPDATE,ox.STATUS,ox.DESCRIPTION,ox.TERMVAL,ox.INTRATE,ox.prolimitbal,ox.prostdate,
                    ox.protodate,ox.proprice,ox.produeamt,ox.proytc,g_symbol,ox.pstatus,ox.lastchange, sb.ipodiscrate, sb.ipodiscrate,
                    ox.tattoan , ox.calpv_method , a.opndate , a.duedate - 1
                    from oxintrcurve ox, assetdtl a, sbsedefacct sb
                    where nvl(ox.typesymbol,'') = ''
                    and nvl(ox.symbol,'') = ''
                    and ox.status = 'A'
                    and sb.symbol = 'All-T?t c?' and sb.status = 'A'
                    and sb.intrcurvetp = 'TMP'
                    --and a.status = 'A'
                    and a.symbol = g_symbol
                    and not exists (select 1 from Product where symbol =a.symbol and termval =  ox.TERMVAL and afacctno = sb.refafacctno)
                    and ox.effdate <= to_date(fn_getcurrdate(), 'DD/MM/YYYY') and ox.expdate > to_date(fn_getcurrdate(), 'DD/MM/YYYY');
         end if;*/
        txpks_notify.prc_system_logevent('FUNDDTL', 'FUND', l_childvalue, 'R',l_actionflag||'FUND');
      end if;

      IF REC.chiltable = 'PAYMENT_HIST' THEN
        update PAYMENT_HIST p
        set payment_status = 'P'
        where p.autoid = rec.childvalue;
      END IF;

    end if;
    /*IF l_actionflag in ('EDIT' ) THEN

      if REC.chiltable = 'PRODUCT' THEN
        select count(1) into l_count
            from product p inner join productmemo m on p.autoid = m.autoid
            where p.autoid = rec.childvalue
            and (p.rate00 <> m.rate00
            or  p.rate01 <>  m.rate01
            or  p.rate02 <>  m.rate02
            or  p.rate03 <>  m.rate03
            or  p.rate04 <>  m.rate04
            or  p.rate05 <>  m.rate05
            or  p.rate06 <>  m.rate06
            or  p.rate07 <>  m.rate07
            or  p.rate08 <>  m.rate08
            or  p.rate09 <>  m.rate09
            or  p.rate10 <>  m.rate10
            or  p.rate11 <>  m.rate11
            or  p.rate12 <>  m.rate12
            or  p.rate13 <>  m.rate13
            or  p.rate14 <>  m.rate14
            or  p.rate15 <>  m.rate15
            or  p.rate16 <>  m.rate16
            or  p.t_rate00 <>  m.t_rate00
            or  p.t_rate01 <>  m.t_rate01
            or  p.t_rate02 <>  m.t_rate02
            or  p.t_rate03 <>  m.t_rate03
            or  p.t_rate04 <>  m.t_rate04
            or  p.t_rate05 <>  m.t_rate05
            or  p.t_rate06 <>  m.t_rate06
            or  p.t_rate07 <>  m.t_rate07
            or  p.t_rate08 <>  m.t_rate08
            or  p.t_rate09 <>  m.t_rate09
            or  p.t_rate10 <>  m.t_rate10
            or  p.t_rate11 <>  m.t_rate11
            or  p.t_rate12 <>  m.t_rate12
            or  p.t_rate13 <>  m.t_rate13
            or  p.t_rate14 <>  m.t_rate14
            or  p.t_rate15 <>  m.t_rate15
            or  p.t_rate16 <>  m.t_rate16);
        IF l_count > 0 THEN
            --lay ra autoid ban ghi can cap nhat
                    select p.autoid into l_autoid
                    from producthist p
                    where p.id = rec.childvalue
                    AND rownum <=1
                    order by autoid desc
                     ;
            -- cap nhat lai ngay het hieu luc ban ghi cu
                    update producthist
                    set expdate = getcurrdate()
                    where autoid = l_autoid;
            -- insert ban ghi moi
                    INSERT INTO producthist
                    (id, effdate, expdate, rate00, rate01, rate02, rate03, rate04, rate05, rate06, rate07, rate08, rate09, rate10, rate11, rate12, rate13, rate14, rate15, rate16, t_rate00, t_rate01, t_rate02, t_rate03, t_rate04, t_rate05, t_rate06, t_rate07, t_rate08, t_rate09, t_rate10, t_rate11, t_rate12, t_rate13, t_rate14, t_rate15, t_rate16)
                    select p.autoid, getcurrdate(), to_date('31/12/2099', 'dd/mm/yyyy'),
                    p.rate00, p.rate01, p.rate02, p.rate03, p.rate04, p.rate05, p.rate06, p.rate07, p.rate08, p.rate09, p.rate10, p.rate11, p.rate12, p.rate13, p.rate14, p.rate15, p.rate16, p.t_rate00, p.t_rate01, p.t_rate02, p.t_rate03, p.t_rate04, p.t_rate05, p.t_rate06, p.t_rate07, p.t_rate08, p.t_rate09, p.t_rate10, p.t_rate11, p.t_rate12, p.t_rate13, p.t_rate14, p.t_rate15, p.t_rate16
                    from productmemo p
                    where p.autoid = rec.childvalue;
        END IF;
      END IF;
    END IF;*/
    if l_actionflag in ('DELETE') then
      if REC.chiltable = 'ASSETDTL' then
     -- insert into draff_phong(ten)values(l_childvalue);
      --select symbol into l_symbol from assetdtl where autoid = TO_NUMBER(l_childvalue) ;
       --insert into draff_phong(ten)values(l_symbol);
      -- insert into draff_phong(ten)values(select symbol from assetdtl where autoid = l_childvalue);
        delete from asset_putoption_temp
            where symbol in  (select symbol from assetdtlmemo where autoid = l_childvalue);
        delete from payment_hist
            where symbol in (select symbol from assetdtl where autoid = l_childvalue);

        delete from payment_detail_hist
            where symbol in (select symbol from assetdtl where autoid = l_childvalue);

        delete from fund
            where codeid  = l_childvalue;
        delete from selloption
            where id  = l_childvalue;
        delete from buyoption
            where id  = l_childvalue;
        txpks_notify.prc_system_logevent('FUNDDTL', 'FUND', l_childvalue, 'R',l_actionflag||'FUND');
      end if;

      IF REC.chiltable = 'OXINTRCURVE' THEN
            DELETE FROM CURVE_SELLDTL WHERE ID = l_childvalue;
            DELETE FROM CURVE_BUYDTL WHERE ID = l_childvalue;
      END IF;

      if REC.chiltable = 'CFMAST' and REC.childkey = 'CUSTID' THEN
        delete from userlogin where username in (select custodycd from cfmast cf where custid = l_childvalue);

        delete from afmast where custid = l_childvalue;

        update aftemplates
        set deletedate= CURRENT_TIMESTAMP, last_change = CURRENT_TIMESTAMP
        where custid = l_childvalue;
        insert into aftemplates_hist select * from aftemplates where custid = l_childvalue;
        delete from aftemplates where custid = l_childvalue;

        update cfmastvip
        set isused = 'N'
        where custodycd = (select custodycd from cfmast where custid = l_childvalue);
      end if;

      if REC.chiltable = 'COMBOPRODUCT' then
        delete from productier where id = l_childvalue;
      END IF;

      IF REC.chiltable = 'PROMOTION' THEN
        delete from promotiondtl where id = l_childvalue;
      END IF;

      if REC.chiltable = 'FEETYPE' and REC.childkey = 'ID' THEN
            delete from feetier where feeid= l_childvalue;
      end if;
      if REC.chiltable = 'COMMISSION' and REC.childkey = 'ID' THEN
            delete from commission_dtl where commissionid= l_childvalue;
      end if;
      if REC.chiltable = 'COMPROGRAM' and REC.childkey = 'ID' THEN
            delete from comprogram_dtl where proid= l_childvalue;
      end if;
      if REC.chiltable = 'SALE_RETYPE' THEN
            delete from feeapply f where f.objfeevalue= l_childvalue;
      end if;

    end if;
    if REC.chiltable = 'PRODUCT' then
    for rec in (select * from product where autoid = l_childvalue)
        loop

        --if rec.effdate <= getcurrdate() and rec.expdate > getcurrdate() then
        select count(*) into l_count from oxpost o where o.productid = rec.shortname and o.symbol = rec.symbol and o.afacctno = rec.afacctno and o.status ='A';
        if l_count > 0 then
        select listagg(o.ORDERID , '~') within group ( order by o.ORDERID ) into l_list_oxpost
        from oxpost o where o.productid = rec.shortname and o.symbol = rec.symbol and o.afacctno = rec.afacctno and o.status ='A';


                        txpks_notify.prc_system_logevent('PRODUCT', 'OXPOSTS',  'ALL'|| '~#~' ||'ALL'|| '~#~' ||l_list_oxpost, 'R','INSERT/UPDATE PRODUCT');


            end if;
    end loop;
     end if;
     /*if REC.chiltable = 'ISSUERS' then
      txpks_notify.prc_system_logevent('ISSUERS', 'ISSUERS',  'ALL'|| '~#~' ||'ALL'|| '~#~' ||'ALL', 'R','INSERT/UPDATE ISSUERS');
     end if;

      if REC.chiltable = 'OXINTRCURVE' then
      txpks_notify.prc_system_logevent('OXINTRCURVE', 'OXINTRCURVES',  'ALL'|| '~#~' ||'ALL'|| '~#~' ||'ALL', 'R','INSERT/UPDATE OXINTRCURVE');
     end if;*/
END LOOP;


    plog.setendsection (pkgctx, 'fn_ProcessAfterApprove');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessAfterApprove');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessAfterApprove;

FUNCTION fn_CheckBeforeReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
BEGIN
    plog.setbeginsection (pkgctx, 'fn_CheckBeforeReject');

    plog.setendsection (pkgctx, 'fn_CheckBeforeReject');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_CheckBeforeReject');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_CheckBeforeReject;

FUNCTION fn_ProcessAfterReject(p_objmsg in out tx.obj_rectype,p_err_code in out varchar2)
RETURN NUMBER
IS
    l_count number;
    l_refobjid varchar2(1000);
    l_actionflag varchar2(100);
    l_childvalue varchar2(100);
    l_childkey varchar2(100);
    l_chiltable varchar2(100);
BEGIN
    plog.setbeginsection (pkgctx, 'fn_ProcessAfterReject');
   l_refobjid := p_objmsg.CLAUSE;
    plog.error(pkgctx,'l_refobjid:'||l_refobjid);
    SELECT actionflag,childvalue,childkey,chiltable
    INTO l_actionflag,l_childvalue,l_childkey,l_chiltable FROM objlog WHERE AUTOID = l_refobjid;

    plog.error(pkgctx,'l_actionflag:'||l_actionflag);

    IF l_actionflag ='ADD' THEN
        IF l_chiltable = 'FEETYPE' THEN
            DELETE FROM feetier WHERE FEEID =  l_childvalue  ;
        END IF;
        IF l_chiltable = 'COMMISSION' THEN
            DELETE FROM commission_dtl WHERE commissionid =  l_childvalue  ;
        END IF;
        IF l_chiltable = 'COMPROGRAM' THEN
            DELETE FROM comprogram_dtl WHERE proid =  l_childvalue  ;
        END IF;
        IF l_chiltable = 'PRODUCT' THEN
            DELETE FROM PRODUCTSELLDTL WHERE ID =  l_childvalue  ;
            DELETE FROM PRODUCTBUYDTL WHERE ID =  l_childvalue  ;
             DELETE FROM PRODUCTCOUPONDTL WHERE ID =  l_childvalue  ;
        END IF;
        IF l_chiltable = 'OXINTRCURVE' THEN
            DELETE FROM curve_selldtl WHERE ID =  l_childvalue  ;
            DELETE FROM curve_buydtl WHERE ID =  l_childvalue  ;
        END IF;
        IF l_chiltable = 'ASSETDTL' THEN
            DELETE FROM buyoption WHERE ID =  l_childvalue  ;
            DELETE FROM selloption WHERE ID =  l_childvalue  ;
        END IF;
    END IF;
    IF l_actionflag ='EDIT' THEN
        IF l_chiltable = 'ASSETDTL' THEN
            select count(1) into l_count from assetdtl where autoid = l_childvalue and (status = 'A' or pstatus like '%A%') ;
            if l_count = 0 then
                 DELETE FROM buyoption WHERE ID =  l_childvalue  ;
                DELETE FROM selloption WHERE ID =  l_childvalue  ;
            end if;

        end if;
    end if;
    IF l_chiltable ='INTSCHD' then
         IF l_actionflag in ('ADD') THEN
         for rec in (select i.autoid,i.symbol from intschdmemo i
          where i.autoid = l_childvalue)
            loop
                --update stt ky tinh lai
                for rec1 in (select rownum periodno, autoid from (select  autoid from intschd where symbol = rec.symbol order by fromdate asc))
                    loop
                        update intschd set periodno = rec1.periodno where autoid = rec1.autoid;
                    end loop;
            end loop;

        end if;
         /*IF l_actionflag in ('DELETE') THEN
            for rec1 in (select rownum periodno, autoid from (select autoid from intschd where symbol = (select symbol from intschd where autoid = l_childvalue)
             order by fromdate asc))
                    loop
                        update intschd set periodno = rec1.periodno where autoid = rec1.autoid;
                    end loop;
         end if;*/
     end if;

     /*if l_chiltable = 'ISSUERS' then
      txpks_notify.prc_system_logevent('ISSUERS', 'ISSUERS',  'ALL'|| '~#~' ||'ALL'|| '~#~' ||'ALL', 'R','INSERT/UPDATE ISSUERS');
     end if;
      if l_chiltable = 'PRODUCT' then
      txpks_notify.prc_system_logevent('PRODUCT', 'PRODUCTS',  'ALL'|| '~#~' ||'ALL'|| '~#~' ||'ALL', 'R','INSERT/UPDATE PRODUCT');
     end if;
      if l_chiltable = 'OXINTRCURVE' then
      txpks_notify.prc_system_logevent('OXINTRCURVE', 'OXINTRCURVES',  'ALL'|| '~#~' ||'ALL'|| '~#~' ||'ALL', 'R','INSERT/UPDATE OXINTRCURVE');
     end if;*/
    plog.setendsection (pkgctx, 'fn_ProcessAfterReject');
    RETURN systemnums.C_SUCCESS;
EXCEPTION
WHEN OTHERS
   THEN
      p_err_code := errnums.C_SYSTEM_ERROR;
      plog.error (pkgctx, SQLERRM || dbms_utility.format_error_backtrace);
      plog.setendsection (pkgctx, 'fn_ProcessAfterReject');
      ROLLBACK;
      RAISE errnums.E_SYSTEM_ERROR;
END fn_ProcessAfterReject;

BEGIN
      FOR i IN (SELECT *
                FROM tlogdebug)
      LOOP
         logrow.loglevel    := i.loglevel;
         logrow.log4table   := i.log4table;
         logrow.log4alert   := i.log4alert;
         logrow.log4trace   := i.log4trace;
      END LOOP;
      pkgctx    :=
         plog.init ('txpks_obj',
                    plevel => NVL(logrow.loglevel,30),
                    plogtable => (NVL(logrow.log4table,'N') = 'Y'),
                    palert => (NVL(logrow.log4alert,'N') = 'Y'),
                    ptrace => (NVL(logrow.log4trace,'N') = 'Y')
            );
END txpks_obj;
/

DROP PACKAGE txpks_paauto
/

CREATE OR REPLACE 
PACKAGE txpks_paauto IS



PROCEDURE PR_CALL_CREATE_PASCHDDEPO(p_txdate in varchar2, p_txnum in VARCHAR2, p_busdate in varchar2,
p_sessionno  in varchar2, p_contrcd in VARCHAR2,
p_employerid in VARCHAR2, p_pensionacctno in VARCHAR2);

PROCEDURE PR_CALL_PAMATCH(p_txdate in varchar2, p_txnum in VARCHAR2, p_busdate in varchar2,
p_sessionno  in varchar2, p_contrcd in VARCHAR2,
p_employerid in VARCHAR2, p_pensionacctno in VARCHAR2);

PROCEDURE PR_CALL_SETTLE_PASCHDDEPO(p_txdate in varchar2, p_txnum in VARCHAR2, p_busdate in varchar2,
p_sessionno  in varchar2, p_contrcd in VARCHAR2,
p_employerid in VARCHAR2, p_pensionacctno in VARCHAR2,
p_istryexe IN VARCHAR2 DEFAULT 'N');

PROCEDURE PR_CALCULATE_FEE(p_pensionid in varchar2, p_sessionno in VARCHAR2, p_fundcodeid in VARCHAR2);
PROCEDURE PR_SRCLS (p_sessionno in VARCHAR2);
procedure pr_auto_9154(p_camastid   in varchar2,
                          p_eerqtty         in number,
                          p_eeyqtty         in number,
                          p_autoid        in number,
                          p_acctno         in varchar2,
                          p_err_code    out varchar2,
                          p_err_message out VARCHAR2) ;
procedure pr_auto_9147(p_pamastdealid   in varchar2,
                          p_eerqtty         in number,
                          p_eeyqtty         in number,
                          p_codeid        in varchar2,
                          p_acctno         in varchar2,
                          p_tlid          in varchar2,
                          p_err_code    out varchar2,
                          p_err_message out VARCHAR2) ;
--PACRADVICETX
PROCEDURE pr_PACRADVICETX ;
PROCEDURE PR_CALL_REVERT_PAMATCH(p_sessionno in VARCHAR2);
PROCEDURE pr_UpPaprocessstatus;
END txpks_paauto;
/

DROP PACKAGE txpks_temp_auto
/

CREATE OR REPLACE 
PACKAGE txpks_temp_auto 
IS

procedure pr_updateprocessstatus;
procedure pr_placeorder(p_functionname in varchar2,
                        p_username in varchar2,
                        p_acctno in varchar2,
                        p_afacctno in varchar2,
                        p_exectype in varchar2,
                        p_symbol in varchar2,
                        p_quantity in number,
                        p_quoteprice in number,
                        p_pricetype in varchar2,
                        p_timetype in varchar2,
                        p_book in varchar2,
                        p_via in varchar2,
                        p_dealid in varchar2,
                        p_direct in varchar2,
                        p_effdate in varchar2,
                        p_expdate in varchar2,
                        p_tlid  in  varchar2,
                        p_quoteqtty in number,
                        p_limitprice in number,
                        p_err_code out varchar2,
                        p_err_message out varchar2,
                        p_reforderid in varchar2 default '',
                        p_blorderid   in varchar2 default '',
                        p_note        in varchar2 default ''
                        );
procedure pr_genschdctl(p_codeid in varchar2,
                        p_err_code out varchar2,
                        p_err_message out varchar2
                        );
function fn_caltradingcycle
    (p_txdate         in  date ,
     p_codeid         in  char,
     p_type           in char,
     P_SPCODE         IN CHAR
    ) return date; -- tinh toan ra ngay tradingdate cua phien tiep theo
procedure pr_odsettlementtransfermoney (p_sessionno in varchar2,
                      p_codeid IN VARCHAR2,
                      p_err_code out varchar2,
                      p_err_message out VARCHAR2
                        ) ;
procedure pr_odsettlementreceivemoney(p_bchmdl   varchar,
                                         p_err_code out varchar2,
                                         p_fromrow  number,
                                         p_torow    number,
                                         p_lastrun  out varchar2);

procedure pr_odsettlementtransfersec (p_sessionno in varchar2,
                      p_codeid IN VARCHAR2,
                      p_err_code out varchar2,
                      p_err_message out VARCHAR2
                        ) ;
procedure pr_taquotebuysell;

procedure pr_srexcec (p_sessionno in varchar2,
                      p_codeid IN VARCHAR2,
                      p_exectype  IN VARCHAR2,
                      p_err_code out varchar2,
                      p_err_message out VARCHAR2
                        );

procedure pr_srfeecalculate (p_codeid in varchar2,
                   p_exectype  in varchar2,
                   p_err_code out varchar2,
                   p_err_message out varchar2
                        );
procedure pr_gentasip(p_tradingid in varchar2,
                      p_err_code out varchar2,
                      p_err_message out VARCHAR2
                        );
procedure taswitch(p_tradingid in varchar2,
                      p_err_code out varchar2,
                      p_err_message out VARCHAR2
                        );

PROCEDURE pr_SRCLS (p_sessionno in varchar2,
                    p_err_code out varchar2,
                    p_err_message out VARCHAR2);

PROCEDURE  pr_genIPOSession(p_codeid in varchar2,
                           p_err_code out varchar2,
                           p_err_message out VARCHAR2
                        );
 procedure pr_excecute(p_sessionno in varchar2,
                      p_codeid IN VARCHAR2,
                      p_exectype  IN VARCHAR2,
                      p_err_code out varchar2,
                      p_err_message out VARCHAR2
                        ) ;

END;
/

DROP PACKAGE txpks_txlog
/

CREATE OR REPLACE 
PACKAGE txpks_txlog 
 /*----------------------------------------------------------------------------------------------------
     ** Module   : COMMODITY SYSTEM
     ** and is copyrighted by FSS.
     **
     **    All rights reserved.  No part of this work may be reproduced, stored in a retrieval system,
     **    adopted or transmitted in any form or by any means, electronic, mechanical, photographic,
     **    graphic, optic recording or otherwise, translated in any language or computer language,
     **    without the prior written permission of Financial Software Solutions. JSC.
     **
     **  MODIFICATION HISTORY
     **  Person      Date           Comments
     **  TienPQ      09-JUNE-2009    Created
     ** (c) 2008 by Financial Software Solutions. JSC.
     ----------------------------------------------------------------------------------------------------*/
 IS




    PROCEDURE pr_update_status(txmsg IN OUT tx.msg_rectype);

    PROCEDURE pr_txdellog(p_txmsg     IN tx.msg_rectype,
                          p_err_code  OUT varchar2);

    PROCEDURE pr_log_workflow(txmsg IN tx.msg_rectype);

END;
/

CREATE OR REPLACE 
PACKAGE BODY txpks_txlog IS
  pkgctx plog.log_ctx;
  logrow tlogdebug%ROWTYPE;

  PROCEDURE pr_update_status(txmsg IN OUT tx.msg_rectype) IS
  BEGIN

      UPDATE tllog
       SET txstatus = txmsg.txstatus,
           ovrrqs   = txmsg.ovrrqd,
           offid    = txmsg.offid,
           --chkid    = txmsg.chkid,
           chid     = txmsg.chid,
           /*chktime  = DECODE(txmsg.chkid,
                             NULL,
                             TO_CHAR(SYSDATE, systemnums.C_TIME_FORMAT),
                             txmsg.chkid),
           offtime  = DECODE(txmsg.chkid,
                             NULL,
                             TO_CHAR(SYSDATE, systemnums.C_TIME_FORMAT),
                             Decode(txmsg.offtime, NUll, TO_CHAR(SYSDATE, systemnums.C_TIME_FORMAT), txmsg.offtime)),*/
           last_lvel=txmsg.last_lvel,
           last_dstatus= txmsg.last_dstatus,
           lvel = txmsg.lvel,
           dstatus= txmsg.dstatus,
           --pdstatus = pdstatus||txmsg.dstatus,
           txdesc = (CASE WHEN txmsg.updatemode ='R' THEN  txmsg.TXDESC ELSE txdesc END )
     WHERE txnum = txmsg.txnum
       AND txdate = TO_DATE(txmsg.txdate, systemnums.C_DATE_FORMAT);

     --Ghi log nguoi thuc hien theo workflow
     pr_log_workflow(txmsg);
  END pr_update_status;



  PROCEDURE pr_log_workflow(txmsg IN tx.msg_rectype) IS
  BEGIN
     --Ghi log nguoi thuc hien theo workflow
     INSERT INTO tllogwf(autoid, txnum, txdate,busdate, txtime, lvel, dstatus, tlid,txdesc,ipaddress,wsname,dsaction,lastchange,apprdate)
       VALUES(
       seq_tllog.NEXTVAL,
       txmsg.txnum,
       TO_DATE(txmsg.txdate, systemnums.C_DATE_FORMAT),
       TO_DATE(txmsg.busdate, systemnums.C_DATE_FORMAT),
       DECODE(txmsg.chkid,
                             NULL,
                             TO_CHAR(SYSDATE, systemnums.C_TIME_FORMAT),
                             Decode(txmsg.offtime, NUll, TO_CHAR(SYSDATE, systemnums.C_TIME_FORMAT), txmsg.offtime)),
       txmsg.last_lvel,
       txmsg.last_dstatus,
       nvl(txmsg.offid,txmsg.tlid), --Lay theo thong tin nguoi duyet
       txmsg.aprdesc,
       txmsg.ipaddress,
       txmsg.wsname,
       txmsg.updatemode,
       SYSTIMESTAMP,
       getcurrdate);

       txpks_notify.prc_system_logevent('TLLOG', 'TRANS', 'ALL~#~' || txmsg.txnum || '~#~' ||
                                to_char(txmsg.txdate, 'DD/MM/YYYY'), 'R','INSERT/UPDATE TLLOG');
  END pr_log_workflow;

  PROCEDURE pr_txdellog(p_txmsg     IN tx.msg_rectype,
                        p_err_code  OUT varchar2) IS
    l_exists VARCHAR2(15);
  BEGIN
    plog.setendsection(pkgctx, 'pr_txdellog');
    UPDATE tllog
       SET deltd = 'Y'
     WHERE txnum = p_txmsg.txnum
       AND txdate = TO_DATE(p_txmsg.txdate, systemnums.C_DATE_FORMAT) RETURNING
     deltd INTO l_exists;

    IF NVL(l_exists, '$$') = '$$' THEN
      p_err_code  := '-100100';
      RAISE errnums.E_HOST_VOUCHER_NOT_FOUND;
    END IF;

    plog.setendsection(pkgctx, 'pr_txdellog');
  END pr_txdellog;



BEGIN
  FOR i IN (SELECT * FROM tlogdebug) LOOP
    logrow.loglevel  := i.loglevel;
    logrow.log4table := i.log4table;
    logrow.log4alert := i.log4alert;
    logrow.log4trace := i.log4trace;
  END LOOP;

  pkgctx := plog.init('txpks_txlog',
                      plevel => logrow.loglevel,
                      plogtable => (logrow.log4table = 'Y'),
                      palert => (logrow.log4alert = 'Y'),
                      ptrace => (logrow.log4trace = 'Y'));
END txpks_txlog;
/

DROP PACKAGE txstatusnums
/

CREATE OR REPLACE 
PACKAGE txstatusnums IS
      c_txlogged              CONSTANT CHAR (1) := 0;
      c_txcompleted           CONSTANT CHAR (1) := 1;
      c_txerroroccured        CONSTANT CHAR (1) := 2;
      c_txcashier             CONSTANT CHAR (1) := 3;
      c_txpending             CONSTANT CHAR (1) := 4;
      c_txrejected            CONSTANT CHAR (1) := 5;
      c_txmsgrequired         CONSTANT CHAR (1) := 6;
      c_txdeleting            CONSTANT CHAR (1) := 7;     --Pending to delete
      c_txrefuse              CONSTANT CHAR (1) := 8;
      c_txdeleted             CONSTANT CHAR (1) := 9;
      c_txremittance          CONSTANT CHAR (2) := 10;
END;
/

DROP PACKAGE utf8nums
/

CREATE OR REPLACE 
PACKAGE utf8nums 
    is
    -- Save with PL/SQL Developer and Run on PL/SQL Developer
    C_CONST_MONTH_VI CONSTANT VARCHAR2(20):= 'th�ng';
    C_CONST_DATE_VI CONSTANT VARCHAR2(20):= 'ng�y';
    C_CONST_YEAR_VI CONSTANT VARCHAR2(20):= 'nam';
    c_const_str_common CONSTANT VARCHAR2(50):= 'Th�ng tin chung';
    c_const_str_not_less_then CONSTANT VARCHAR2(50):= ' kh�ng du?c nh? hon ';
    c_const_str_less_then_or_equal CONSTANT VARCHAR2(60):= ' ph?i nh? hon ho?c b?ng ';
    c_const_custtype_custodycd_ic constant varchar2(30):= 'C� nh�n trong nu?c';
    c_const_custtype_custodycd_bc constant varchar2(30):= 'T? ch?c trong nu?c';
    c_const_custtype_custodycd_if constant varchar2(30):= 'C� nh�n nu?c ngo�i';
    c_const_custtype_custodycd_bf constant varchar2(30):= 'T? ch?c nu?c ngo�i';

    c_const_custodycd_type_c constant varchar2(30):= 'Trong nu?c';
    c_const_custodycd_type_f constant varchar2(30):= 'Nu?c ngo�i';
    c_const_custodycd_type_p constant varchar2(30):= 'T? doanh';
    c_const_feeacm_des constant varchar2(1000):= 'X�a th�ng tin ph� duy tr� t�i kho?n';
    c_const_idcode_duplicate constant varchar2(1000):= 'Tr�ng s? dang k� s? h?u, c� ti?p t?c giao d?ch ?';
    c_const_alert_pn constant varchar2(1000):= ' phi�n ng�y ';
    c_const_alert_sr0034 constant varchar2(1000):= 'X�c nh?n s? l?nh SR0034 c?a qu? ';
    c_const_alert_sr0039 constant varchar2(1000):= 'X�c nh?n s? l?nh SR0039 c?a qu? ';
    c_const_alert_pa0001 constant varchar2(1000):= 'X�c nh?n s? l?nh PA0001 c?a qu? ';
    c_const_alert_ci constant varchar2(1000):= 'Nh?p ti?n qu? ';
    c_const_alert_nav constant varchar2(1000):= 'Nh?p NAV qu? ';
    c_const_alert_buyamt constant varchar2(1000):= 'Nh?p h?n m?c mua l?i t?i da qu? ';
    c_const_alert_state4bank constant varchar2(1000):= 'X�c nh?n tr? l?i ti?n th?a qu? ';
    c_const_alert_vesting constant varchar2(1000):= ' giao d?ch Vesting chua x? l�';
    c_const_alert_vesting_P constant varchar2(1000):= 'C� ';
    c_const_pending_file_import CONSTANT VARCHAR2(1000) :='Ch? duy?t';
    c_const_p_Individual CONSTANT VARCHAR2(1000) :='C� nh�n';
    c_const_p_not_fount_eey_eer CONSTANT VARCHAR2(1000) :='Kh�ng x�c d?nh du?c doanh nghi?p ho?c c� nh�n';
    c_const_p_not_fount_eer_bank CONSTANT VARCHAR2(1000) :='Ngu?i lao d?ng v� t�i kho?n ng�n h�ng kh�ng c�ng d?i l�';
    c_const_p_not_fount_eey_bank CONSTANT VARCHAR2(1000) :='C� nh�n v� t�i kho?n ng�n h�ng kh�ng c�ng d?i l�';

    c_const_p_fund_tpa CONSTANT VARCHAR2(1000) :='Qu?n l� qu? huu tr�';
    c_const_pa0009_1_desc1 CONSTANT VARCHAR2(1000) :='Gi� tr? ph�: ';
    c_const_pa0009_1_desc2 CONSTANT VARCHAR2(1000) :='t?ng gi� tr?';
    c_const_pa0009_1_desc3 CONSTANT VARCHAR2(1000) :='Gi� tr? t? ';
    c_const_pa0009_1_desc4 CONSTANT VARCHAR2(1000) :=' �?n gi� tr? ';
    c_const_pa0009_1_desc5 CONSTANT VARCHAR2(1000) :=' T? l? ph�: ';
    c_const_pa0009_1_desc6 CONSTANT VARCHAR2(1000) :=' T? ';
    c_const_pa0009_1_desc7 CONSTANT VARCHAR2(1000) :=' �?n ';
    c_const_pa0009_1_desc8 CONSTANT VARCHAR2(1000) :=' T? l?: ';
    c_const_fa0001 CONSTANT VARCHAR2(1000) :='S? trang tru?c chuy?n sang';
    c_const_parvalue_es CONSTANT VARCHAR2(1000) :='10000';
    c_const_parvalue_db CONSTANT VARCHAR2(1000) :='100000';
    c_const_p_not_fount_fundcodeid CONSTANT VARCHAR2(1000) :='S? t�i kho?n ng�n h�ng v� l?nh mua ho�n d?i ph?i thu?c c�ng m?t qu?';
    c_const_ngung CONSTANT VARCHAR2(1000) :='Ng?ng';
    c_const_kich_hoat CONSTANT VARCHAR2(1000) :='K�ch ho?t';
    c_const_custtype_tc CONSTANT VARCHAR2(1000) :='T? ch?c';
    c_const_custtype_cn CONSTANT VARCHAR2(1000) :='C� nh�n';
    c_const_sex_f CONSTANT VARCHAR2(1000) :='N?';
    c_const_sex_m CONSTANT VARCHAR2(1000) :='Nam';
    c_const_sex_o CONSTANT VARCHAR2(1000) :='Kh�c';
END utf8nums;
/

DROP PACKAGE utils
/

CREATE OR REPLACE 
PACKAGE utils IS

  TYPE unicode IS TABLE OF VARCHAR2(50) INDEX BY BINARY_INTEGER;

  tab_unicode unicode;

  TYPE tcvn3 IS TABLE OF VARCHAR2(50) INDEX BY BINARY_INTEGER;

  tab_tcvn3 tcvn3;

  TYPE utf8 IS TABLE OF VARCHAR2(50) INDEX BY BINARY_INTEGER;

  tab_utf8 utf8;

  FUNCTION so_thanh_chu(p_a NUMBER) RETURN VARCHAR2;

  FUNCTION ext_to_number(p_a VARCHAR2) RETURN NUMBER;

  FUNCTION get_max(p_a NUMBER, p_b NUMBER) RETURN NUMBER;

  FUNCTION get_min(p_a NUMBER, p_b NUMBER) RETURN NUMBER;

  /*FUNCTION exception_error_message(p_error_code NUMBER, p_message VARCHAR2)
  RETURN VARCHAR2;*/
  FUNCTION fnc_convert_to_utf8(p_string VARCHAR2) RETURN VARCHAR2;

END utils;
/

CREATE OR REPLACE 
PACKAGE BODY utils IS

  FUNCTION so_thanh_chu(p_a NUMBER) RETURN VARCHAR2 IS
    v_char      VARCHAR2(50);
    v_str       VARCHAR2(50);
    v_start_pos NUMBER;
  BEGIN
    v_char      := to_char(round(p_a, 0));
    v_start_pos := length(v_char) -
                   (round(length(v_char) / 3 + 0.5, 0) - 1) * 3;
    v_str       := substr(v_char, 0, v_start_pos);
    LOOP
      EXIT WHEN substr(v_char, v_start_pos + 1, 3) IS NULL;
      v_str       := v_str || ',' || substr(v_char, v_start_pos + 1, 3);
      v_start_pos := v_start_pos + 3;
    END LOOP;
    IF substr(v_str, 1, 1) = ','
    THEN
      v_str := substr(v_str, 2);
    END IF;
    RETURN v_str;
  END;

  FUNCTION ext_to_number(p_a VARCHAR2) RETURN NUMBER IS
    v_number NUMBER;
  BEGIN
    BEGIN
      SELECT to_number(REPLACE(p_a, ',', '.')) INTO v_number FROM dual;
    EXCEPTION
      WHEN OTHERS THEN
        SELECT to_number(REPLACE(p_a, '.', ',')) INTO v_number FROM dual;
    END;
    RETURN v_number;
  END;

  FUNCTION get_max(p_a NUMBER, p_b NUMBER) RETURN NUMBER IS
    v_max NUMBER;
  BEGIN
    v_max := p_a;
    IF v_max < p_b
    THEN
      v_max := p_b;
    END IF;
    RETURN v_max;
  END;

  FUNCTION get_min(p_a NUMBER, p_b NUMBER) RETURN NUMBER IS
    v_min NUMBER;
  BEGIN
    v_min := p_a;
    IF v_min > p_b
    THEN
      v_min := p_b;
    END IF;
    RETURN v_min;
  END;

  /*FUNCTION exception_error_message(p_error_code NUMBER, p_message VARCHAR2)
    RETURN VARCHAR2 IS
    v_message VARCHAR2(100) := 'Co l?i trong h? th?ng giao d?ch ch?ng khoan';
  BEGIN
    BEGIN
      SELECT a.ERROR_CODE
        INTO v_message
        FROM error_definition a
       WHERE a.ERROR_CODE = p_error_code;
    EXCEPTION
      WHEN no_data_found THEN
        v_message := p_message;
    END;
    RETURN v_message;
  END;*/
  PROCEDURE prc_get_initial_unicode IS
  BEGIN
    tab_unicode(1) := ';;.224;';
    tab_unicode(2) := ';;.225;';
    tab_unicode(3) := ';;.7843;';
    tab_unicode(4) := ';;.227;';
    tab_unicode(5) := ';;.7841;';
    tab_unicode(6) := ';;.259;';
    tab_unicode(7) := ';;.7857;';
    tab_unicode(8) := ';;.7855;';
    tab_unicode(9) := ';;.7859;';
    tab_unicode(10) := ';;.7861;';
    tab_unicode(11) := ';;.7863;';
    tab_unicode(12) := ';;.226;';
    tab_unicode(13) := ';;.7847;';
    tab_unicode(14) := ';;.7845;';
    tab_unicode(15) := ';;.7849;';
    tab_unicode(16) := ';;.7851;';
    tab_unicode(17) := ';;.7853;';
    tab_unicode(18) := ';;.273;';
    tab_unicode(19) := ';;.232;';
    tab_unicode(20) := ';;.233;';
    tab_unicode(21) := ';;.7867;';
    tab_unicode(22) := ';;.7869;';
    tab_unicode(23) := ';;.7865;';
    tab_unicode(24) := ';;.234;';
    tab_unicode(25) := ';;.7873;';
    tab_unicode(26) := ';;.7871;';
    tab_unicode(27) := ';;.7875;';
    tab_unicode(28) := ';;.7877;';
    tab_unicode(29) := ';;.7879;';
    tab_unicode(30) := ';;.236;';
    tab_unicode(31) := ';;.237;';
    tab_unicode(32) := ';;.7881;';
    tab_unicode(33) := ';;.297;';
    tab_unicode(34) := ';;.7883;';
    tab_unicode(35) := ';;.242;';
    tab_unicode(36) := ';;.243;';
    tab_unicode(37) := ';;.7887;';
    tab_unicode(38) := ';;.245;';
    tab_unicode(39) := ';;.7885;';
    tab_unicode(40) := ';;.244;';
    tab_unicode(41) := ';;.7891;';
    tab_unicode(42) := ';;.7889;';
    tab_unicode(43) := ';;.7893;';
    tab_unicode(44) := ';;.7895;';
    tab_unicode(45) := ';;.7897;';
    tab_unicode(46) := ';;.417;';
    tab_unicode(47) := ';;.7901;';
    tab_unicode(48) := ';;.7899;';
    tab_unicode(49) := ';;.7903;';
    tab_unicode(50) := ';;.7905;';
    tab_unicode(51) := ';;.7907;';
    tab_unicode(52) := ';;.249;';
    tab_unicode(53) := ';;.250;';
    tab_unicode(54) := ';;.7911;';
    tab_unicode(55) := ';;.361;';
    tab_unicode(56) := ';;.7909;';
    tab_unicode(57) := ';;.432;';
    tab_unicode(58) := ';;.7915;';
    tab_unicode(59) := ';;.7913;';
    tab_unicode(60) := ';;.7917;';
    tab_unicode(61) := ';;.7919;';
    tab_unicode(62) := ';;.7921;';
    tab_unicode(63) := ';;.7923;';
    tab_unicode(64) := ';;.253;';
    tab_unicode(65) := ';;.7927;';
    tab_unicode(66) := ';;.7929;';
    tab_unicode(67) := ';;.7925;';
    tab_unicode(68) := ';;.258;';
    tab_unicode(69) := ';;.194;';
    tab_unicode(70) := ';;.272;';
    tab_unicode(71) := ';;.202;';
    tab_unicode(72) := ';;.212;';
    tab_unicode(73) := ';;.416;';
    tab_unicode(74) := ';;.431;';
    tab_unicode(75) := ';;.224;';
    tab_unicode(76) := ';;.225;';
    tab_unicode(77) := ';;.7843;';
    tab_unicode(78) := ';;.227;';
    tab_unicode(79) := ';;.7841;';
    tab_unicode(80) := ';;.7857;';
    tab_unicode(81) := ';;.7855;';
    tab_unicode(82) := ';;.7859;';
    tab_unicode(83) := ';;.7861;';
    tab_unicode(84) := ';;.7863;';
    tab_unicode(85) := ';;.7847;';
    tab_unicode(86) := ';;.7845;';
    tab_unicode(87) := ';;.7849;';
    tab_unicode(88) := ';;.7851;';
    tab_unicode(89) := ';;.7853;';
    tab_unicode(90) := ';;.232;';
    tab_unicode(91) := ';;.233;';
    tab_unicode(92) := ';;.7867;';
    tab_unicode(93) := ';;.7869;';
    tab_unicode(94) := ';;.7865;';
    tab_unicode(95) := ';;.7873;';
    tab_unicode(96) := ';;.7871;';
    tab_unicode(97) := ';;.7875;';
    tab_unicode(98) := ';;.7877;';
    tab_unicode(99) := ';;.7879;';
    tab_unicode(100) := ';;.236;';
    tab_unicode(101) := ';;.237;';
    tab_unicode(102) := ';;.7881;';
    tab_unicode(103) := ';;.297;';
    tab_unicode(104) := ';;.7883;';
    tab_unicode(105) := ';;.242;';
    tab_unicode(106) := ';;.243;';
    tab_unicode(107) := ';;.7887;';
    tab_unicode(108) := ';;.245;';
    tab_unicode(109) := ';;.7885;';
    tab_unicode(110) := ';;.7891;';
    tab_unicode(111) := ';;.7889;';
    tab_unicode(112) := ';;.7893;';
    tab_unicode(113) := ';;.7895;';
    tab_unicode(114) := ';;.7897;';
    tab_unicode(115) := ';;.7901;';
    tab_unicode(116) := ';;.7899;';
    tab_unicode(117) := ';;.7903;';
    tab_unicode(118) := ';;.7905;';
    tab_unicode(119) := ';;.7907;';
    tab_unicode(120) := ';;.249;';
    tab_unicode(121) := ';;.250;';
    tab_unicode(122) := ';;.7911;';
    tab_unicode(123) := ';;.361;';
    tab_unicode(124) := ';;.7909;';
    tab_unicode(125) := ';;.7915;';
    tab_unicode(126) := ';;.7913;';
    tab_unicode(127) := ';;.7917;';
    tab_unicode(128) := ';;.7919;';
    tab_unicode(129) := ';;.7921;';
    tab_unicode(130) := ';;.7923;';
    tab_unicode(131) := ';;.253;';
    tab_unicode(132) := ';;.7927;';
    tab_unicode(133) := ';;.7929;';
    tab_unicode(134) := ';;.7925;';
  END;

  PROCEDURE prc_get_utf8 IS
  BEGIN
    tab_utf8(1) := 'a';
    tab_utf8(2) := 'a';
    tab_utf8(3) := '?';
    tab_utf8(4) := '?';
    tab_utf8(5) := '?';
    tab_utf8(6) := 'a';
    tab_utf8(7) := '?';
    tab_utf8(8) := '?';
    tab_utf8(9) := '?';
    tab_utf8(10) := '?';
    tab_utf8(11) := '?';
    tab_utf8(12) := 'a';
    tab_utf8(13) := '?';
    tab_utf8(14) := '?';
    tab_utf8(15) := '?';
    tab_utf8(16) := '?';
    tab_utf8(17) := '?';
    tab_utf8(18) := 'd';
    tab_utf8(19) := 'e';
    tab_utf8(20) := 'e';
    tab_utf8(21) := '?';
    tab_utf8(22) := '?';
    tab_utf8(23) := '?';
    tab_utf8(24) := 'e';
    tab_utf8(25) := '?';
    tab_utf8(26) := '?';
    tab_utf8(27) := '?';
    tab_utf8(28) := '?';
    tab_utf8(29) := '?';
    tab_utf8(30) := 'i';
    tab_utf8(31) := 'i';
    tab_utf8(32) := '?';
    tab_utf8(33) := 'i';
    tab_utf8(34) := '?';
    tab_utf8(35) := 'o';
    tab_utf8(36) := 'o';
    tab_utf8(37) := '?';
    tab_utf8(38) := '?';
    tab_utf8(39) := '?';
    tab_utf8(40) := 'o';
    tab_utf8(41) := '?';
    tab_utf8(42) := '?';
    tab_utf8(43) := '?';
    tab_utf8(44) := '?';
    tab_utf8(45) := '?';
    tab_utf8(46) := 'o';
    tab_utf8(47) := '?';
    tab_utf8(48) := '?';
    tab_utf8(49) := '?';
    tab_utf8(50) := '?';
    tab_utf8(51) := '?';
    tab_utf8(52) := 'u';
    tab_utf8(53) := 'u';
    tab_utf8(54) := '?';
    tab_utf8(55) := 'u';
    tab_utf8(56) := '?';
    tab_utf8(57) := 'u';
    tab_utf8(58) := '?';
    tab_utf8(59) := '?';
    tab_utf8(60) := '?';
    tab_utf8(61) := '?';
    tab_utf8(62) := '?';
    tab_utf8(63) := '?';
    tab_utf8(64) := 'y';
    tab_utf8(65) := '?';
    tab_utf8(66) := '?';
    tab_utf8(67) := '?';
    tab_utf8(68) := 'A';
    tab_utf8(69) := 'A';
    tab_utf8(70) := '?';
    tab_utf8(71) := 'E';
    tab_utf8(72) := 'O';
    tab_utf8(73) := 'O';
    tab_utf8(74) := 'U';
    tab_utf8(75) := 'a';
    tab_utf8(76) := 'a';
    tab_utf8(77) := '?';
    tab_utf8(78) := '?';
    tab_utf8(79) := '?';
    tab_utf8(80) := '?';
    tab_utf8(81) := '?';
    tab_utf8(82) := '?';
    tab_utf8(83) := '?';
    tab_utf8(84) := '?';
    tab_utf8(85) := '?';
    tab_utf8(86) := '?';
    tab_utf8(87) := '?';
    tab_utf8(88) := '?';
    tab_utf8(89) := '?';
    tab_utf8(90) := 'e';
    tab_utf8(91) := 'e';
    tab_utf8(92) := '?';
    tab_utf8(93) := '?';
    tab_utf8(94) := '?';
    tab_utf8(95) := '?';
    tab_utf8(96) := '?';
    tab_utf8(97) := '?';
    tab_utf8(98) := '?';
    tab_utf8(99) := '?';
    tab_utf8(100) := 'i';
    tab_utf8(101) := 'i';
    tab_utf8(102) := '?';
    tab_utf8(103) := 'i';
    tab_utf8(104) := '?';
    tab_utf8(105) := 'o';
    tab_utf8(106) := 'o';
    tab_utf8(107) := '?';
    tab_utf8(108) := '?';
    tab_utf8(109) := '?';
    tab_utf8(110) := '?';
    tab_utf8(111) := '?';
    tab_utf8(112) := '?';
    tab_utf8(113) := '?';
    tab_utf8(114) := '?';
    tab_utf8(115) := '?';
    tab_utf8(116) := '?';
    tab_utf8(117) := '?';
    tab_utf8(118) := '?';
    tab_utf8(119) := '?';
    tab_utf8(120) := 'u';
    tab_utf8(121) := 'u';
    tab_utf8(122) := '?';
    tab_utf8(123) := 'u';
    tab_utf8(124) := '?';
    tab_utf8(125) := '?';
    tab_utf8(126) := '?';
    tab_utf8(127) := '?';
    tab_utf8(128) := '?';
    tab_utf8(129) := '?';
    tab_utf8(130) := '?';
    tab_utf8(131) := 'y';
    tab_utf8(132) := '?';
    tab_utf8(133) := '?';
    tab_utf8(134) := '?';
  END;

  FUNCTION fnc_convert_to_utf8(p_string VARCHAR2) RETURN VARCHAR2 IS
    v_string VARCHAR2(10000) := p_string;
  BEGIN
    prc_get_initial_unicode;
    prc_get_utf8;
    FOR i IN 1 .. tab_unicode.COUNT()
    LOOP
      v_string := REPLACE(v_string, tab_unicode(i), tab_utf8(i));
    END LOOP;
    RETURN v_string;
  END;

END utils;
/

