DROP TRIGGER trg_rptlogs_after_insert
/

CREATE OR REPLACE TRIGGER trg_rptlogs_after_insert
 AFTER
  INSERT
 ON rptlogs
REFERENCING NEW AS NEWVAL OLD AS OLDVAL
 FOR EACH ROW
declare
  pkgctx plog.log_ctx;
  logrow tlogdebug%rowtype;

   p_reportfilename    VARCHAR2(100);
   p_reportTemplate    VARCHAR2(100);
   p_FUNC              VARCHAR2(500);
   p_types             txpks_notify.str_array ;
   p_refrptfile         VARCHAR2(500);
   p_UpdateStatus      VARCHAR2(100);
   p_UpdateStatusErr   VARCHAR2(100);
   p_UpdateStatusNoData    VARCHAR2(100);
   p_RptTemplatePath       VARCHAR2(1000);
   p_RptType               VARCHAR2(100);
   p_RptReportPath         VARCHAR2(1000);
     v_issubrpt                VARCHAR2(100);
    --khai bao subreport
     v_strFunc VARCHAR2(3000);
     v_Total   number;
     my_result VARCHAR2(100);
     p_autoid VARCHAR2(100);
     p_rptid VARCHAR2(100);
     l_logo VARCHAR2(100);
   l_storedname VARCHAR(100);
   arr_storedname txpks_notify.str_array ;
   pv_ref pkg_report.ref_cursor;
   enq_msgid RAW(16);
   l_content VARCHAR2(4000);
   v_count NUMBER;
   v_procedure    VARCHAR2(200);
   l_param        VARCHAR2(1000);
   arr_param txpks_notify.str_array ;
begin
  for i in (select * from tlogdebug)
  loop
    logrow.loglevel  := i.loglevel;
    logrow.log4table := i.log4table;
    logrow.log4alert := i.log4alert;
    logrow.log4trace := i.log4trace;
  end loop;

  pkgctx := plog.init('trg_rptlogs_after_insert',
                      plevel            => nvl(logrow.loglevel, 30),
                      plogtable         => (nvl(logrow.log4table, 'N') = 'Y'),
                      palert            => (nvl(logrow.log4alert, 'N') = 'Y'),
                      ptrace            => (nvl(logrow.log4trace, 'N') = 'Y'));

  plog.setBeginSection(pkgctx, 'trg_rptlogs_after_insert');

  p_UpdateStatus:='UPDATE rptlogs SET status = ''A'', refrptfile = ''?'' WHERE autoid ='|| '''' || :newval.autoid || '''';
    p_UpdateStatusErr:= 'UPDATE rptlogs SET status = ''E'' WHERE autoid ='|| '''' || :newval.autoid || '''';
    p_UpdateStatusNoData:= 'UPDATE rptlogs SET status = ''F'' WHERE autoid ='|| '''' || :newval.autoid || '''';
    
  l_logo := '';
  --path l¿y report template
  p_RptTemplatePath := '';
  
 p_refrptfile := '';
  p_types := txpks_notify.Split(:newval.exptype,',');
  
  For i In p_types.First .. p_types.Last
  LOOP
    SELECT COUNT(*) INTO v_count FROM rptmaster WHERE rptid=:newval.rptid;
    IF  v_count > 0 THEN
        select rptid,rptid, subrpt
          into p_FUNC,p_reportTemplate, v_issubrpt
        from rptmaster where rptid=:newval.rptid;

        p_reportfilename:= p_reportTemplate|| '.' || TO_CHAR(SYSDATE, 'yyyymmdd') || '.' || :newval.autoid ||'.'||p_types(i);

        --Lay storedname
        Select r.storedname into l_storedname from rptmaster r where rptid=p_reportTemplate;

        --Lay tung storedname
        arr_storedname := txpks_notify.Split(l_storedname,'#');

        --Check template file
        if p_types(i) = 'PDF' then
          p_reportTemplate:=  p_RptTemplatePath ||p_reportTemplate||'.jrxml';
          p_RptType :='PDF';
        else
          p_reportTemplate:=  p_RptTemplatePath ||p_reportTemplate||p_types(i)||'.jrxml';
          p_RptType :=p_types(i);
        end IF;

        p_FUNC:=p_FUNC||'(?,'||:newval.rptparam||','''||:newval.tlid||''','''||:newval.tlname||''','''||:newval.lang|| ''');';
        p_autoid := :newval.autoid;
        p_rptid := :newval.rptid;
        v_strFunc := '';
        Begin
          For i In arr_storedname.First .. arr_storedname.Last
          LOOP

          v_strFunc := v_strFunc ||'{\"subcursorname\":\"ret'||i||'\",\"subreport\":\"'||p_reportTemplate||
                    '\",\"func\":\"call '|| arr_storedname(i) ||'(?,' || :newval.rptparam ||','''||:newval.tlid||''','''||:newval.tlname||''','''||:newval.lang|| ''')\"},';
          end LOOP;
        v_strFunc:= rtrim(v_strFunc,',');

        Exception
          when others then
            plog.error(pkgctx, sqlerrm);
            plog.error(pkgctx,SQLERRM || '--' || dbms_utility.format_error_backtrace);
            plog.setEndSection(pkgctx, 'trg_rptlogs_after_insert');
        end;
     ELSE
        SELECT r.fldvalue INTO v_procedure FROM rptlog_map r WHERE objname = :newval.rptid;
        
        arr_storedname := txpks_notify.Split(v_procedure,'#');
        p_reportfilename:= :newval.rptid|| '.' || TO_CHAR(SYSDATE, 'yyyymmdd') || '.' || :newval.autoid ||'.'||p_types(i);
        
        l_param := replace(:newval.rptparam,'''?''','?');
        arr_param := txpks_notify.Split(l_param,'#');
        
        --Check template file
        if p_types(i) = 'PDF' then
          p_reportTemplate:=  p_RptTemplatePath ||:newval.rptid||'.jrxml';
          p_RptType :='PDF';
        else
          p_reportTemplate:=  p_RptTemplatePath ||:newval.rptid||p_types(i)||'.jrxml';
          p_RptType :=p_types(i);
        end IF;

        p_FUNC:=p_FUNC||'(?,'||l_param||','''||:newval.tlid||''','''||:newval.tlname||''','''||:newval.lang|| ''');';
        p_autoid := :newval.autoid;
        p_rptid := :newval.rptid;
        v_strFunc := '';
        Begin
          For i In arr_storedname.First .. arr_storedname.Last
          LOOP
            

            v_strFunc := v_strFunc ||'{\"subcursorname\":\"ret'||i||'\",\"subreport\":\"'||p_RptTemplatePath|| :newval.rptid|| '.jrxml'||
                        '\",\"func\":\"call '|| arr_storedname(i) ||'(?,' || arr_param(i) ||','''||:newval.tlid||''','''||:newval.tlname||''','''||:newval.lang|| ''')\"},';
        end LOOP;
        v_strFunc:= rtrim(v_strFunc,',');

        Exception
          when others then
            plog.error(pkgctx, sqlerrm);
            plog.error(pkgctx,SQLERRM || '--' || dbms_utility.format_error_backtrace);
            plog.setEndSection(pkgctx, 'trg_rptlogs_after_insert');
        end;

     END IF;

p_refrptfile := p_refrptfile|| fn_systemnums('prefix_report') ||p_reportfilename;
        if :newval.passwordencrypt is not null or length(:newval.passwordencrypt) > 0 then
         l_content := '{"msgtype":"S", ' ||
                    '"datatype":"report", ' ||
                    '"refid":"'||:newval.autoid||'", ' ||
                    '"reportdesttype":"file", ' ||
                    '"reportfiletype":"'||p_RptType||'", ' ||
                    '"reportfilename":"'||p_reportfilename||'", ' ||
                    '"reporttemplate":"'||p_reportTemplate||'", ' ||
                    '"afterprocessfun":"'||p_UpdateStatus||'", ' ||
                    '"afterprocessfunerr":"'||p_UpdateStatusErr||'", ' ||
                    '"afterprocessfunnodata":"'||p_UpdateStatusNoData||'", ' ||
                    '"passwordencrypt":"'||:newval.passwordencrypt||'", ' ||
                    '"func":"'||p_FUNC||'", ' ||
                    '"subreports":"['||v_strFunc||']", ' ||
                    '"reportlogo":"'||coalesce(l_logo,'')||'}';
        txpks_notify.sp_set_message_queue(f_content=>l_content,f_queue=>'TXAQS_RPTFLEX2FO',autocommit=>'N');
        ELSE
      l_content := '{"msgtype":"S", ' ||
                    '"datatype":"report", ' ||
                    '"refid":"'||:newval.autoid||'", ' ||
                    '"reportdesttype":"file", ' ||
                    '"reportfiletype":"'||p_RptType||'", ' ||
                    '"reportfilename":"'||p_reportfilename||'", ' ||
                    '"reporttemplate":"'||p_reportTemplate||'", ' ||
                    '"afterprocessfun":"'||p_UpdateStatus||'", ' ||
                    '"afterprocessfunerr":"'||p_UpdateStatusErr||'", ' ||
                    '"afterprocessfunnodata":"'||p_UpdateStatusNoData||'", ' ||
                    '"func":"'||p_FUNC||'", ' ||
                    '"subreports":"['||v_strFunc||']", ' ||
                    '"reportlogo":"'||coalesce(l_logo,'')||'",'||
                   '"parameters":' || GET_REPORT_PARAMETERS(:newval.rptid,:newval.rptparam,:newval.tlid) ||
                    '}';
        txpks_notify.sp_set_message_queue(f_content=>l_content,f_queue=>'TXAQS_RPTFLEX2FO',autocommit=>'N');

        end IF;
    plog.error(pkgctx,'trg_rptlogs_after_insert l_content '||l_content);
  END LOOP;
 --:newval.refrptfile := p_refrptfile;
  plog.setEndSection(pkgctx, 'trg_rptlogs_after_insert');
EXCEPTION WHEN OTHERS THEN
plog.error(pkgctx,SQLERRM || '--' || dbms_utility.format_error_backtrace);
end;
/

