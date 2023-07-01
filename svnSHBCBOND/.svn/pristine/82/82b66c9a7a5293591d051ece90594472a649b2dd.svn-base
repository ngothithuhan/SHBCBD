DROP TABLE txaqs_rptflex2fo_queue_table
/

CREATE TABLE txaqs_rptflex2fo_queue_table
    (q_name                         VARCHAR2(128 BYTE),
    msgid                          RAW(16) ,
    corrid                         VARCHAR2(128 BYTE),
    priority                       NUMBER,
    state                          NUMBER,
    delay                          TIMESTAMP (6),
    expiration                     NUMBER,
    time_manager_info              TIMESTAMP (6),
    local_order_no                 NUMBER,
    chain_no                       NUMBER,
    cscn                           NUMBER,
    dscn                           NUMBER,
    enq_time                       TIMESTAMP (6),
    enq_uid                        VARCHAR2(128 BYTE),
    enq_tid                        VARCHAR2(30 BYTE),
    deq_time                       TIMESTAMP (6),
    deq_uid                        VARCHAR2(128 BYTE),
    deq_tid                        VARCHAR2(30 BYTE),
    retry_count                    NUMBER,
    exception_qschema              VARCHAR2(128 BYTE),
    exception_queue                VARCHAR2(128 BYTE),
    step_no                        NUMBER,
    recipient_key                  NUMBER,
    dequeue_msgid                  RAW(16),
    sender_name                    VARCHAR2(128 BYTE),
    sender_address                 VARCHAR2(1024 BYTE),
    sender_protocol                NUMBER,
    user_data                      SYS.AQ$_JMS_TEXT_MESSAGE,
    user_prop                      SYS.ANYDATA)
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  LOGGING
  MONITORING
/

CREATE INDEX aq$_txaqs_rptflex2fo_queue_table_t ON txaqs_rptflex2fo_queue_table
  (
    time_manager_info               ASC
  )
NOPARALLEL
LOGGING
/

CREATE INDEX aq$_txaqs_rptflex2fo_queue_table_i ON txaqs_rptflex2fo_queue_table
  (
    q_name                          ASC,
    state                           ASC,
    enq_time                        ASC,
    step_no                         ASC,
    chain_no                        ASC,
    local_order_no                  ASC
  )
NOPARALLEL
LOGGING
/


ALTER TABLE txaqs_rptflex2fo_queue_table
ADD PRIMARY KEY (msgid)
USING INDEX
/

DROP TABLE txauto
/

CREATE TABLE txauto
    (tltxcd                         CHAR(4 BYTE),
    fldmap                         VARCHAR2(4000 BYTE),
    cfreq                          FLOAT(32),
    cachesize                      FLOAT(32))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE txreqlog
/

CREATE TABLE txreqlog
    (autoid                         FLOAT(64),
    txdate                         DATE,
    txnum                          VARCHAR2(30 BYTE),
    busdate                        DATE,
    tltxcd                         VARCHAR2(30 BYTE),
    custodycd                      VARCHAR2(20 BYTE),
    acctno                         VARCHAR2(40 BYTE),
    codeid                         VARCHAR2(20 BYTE),
    amt                            BINARY_DOUBLE,
    tlid                           VARCHAR2(20 BYTE),
    txdesc                         VARCHAR2(4000 BYTE),
    deltd                          VARCHAR2(2 BYTE),
    status                         VARCHAR2(2 BYTE) DEFAULT 'P',
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6) DEFAULT to_date('0001-01-01 00:00:00', 'YYYY-MM-DD hh24:mi:ss'))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE txreqlog_hist
/

CREATE TABLE txreqlog_hist
    (autoid                         FLOAT(64),
    txdate                         DATE,
    txnum                          VARCHAR2(30 BYTE),
    busdate                        DATE,
    tltxcd                         VARCHAR2(30 BYTE),
    custodycd                      VARCHAR2(20 BYTE),
    acctno                         VARCHAR2(40 BYTE),
    codeid                         VARCHAR2(20 BYTE),
    amt                            BINARY_DOUBLE,
    tlid                           VARCHAR2(20 BYTE),
    txdesc                         VARCHAR2(4000 BYTE),
    deltd                          VARCHAR2(2 BYTE),
    status                         VARCHAR2(2 BYTE) DEFAULT 'P',
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6) DEFAULT to_date('0001-01-01 00:00:00', 'YYYY-MM-DD hh24:mi:ss'))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE txreqlogdtl
/

CREATE TABLE txreqlogdtl
    (autoid                         FLOAT(64),
    txdate                         DATE,
    txnum                          VARCHAR2(30 BYTE),
    fldcd                          VARCHAR2(3 BYTE),
    nvalue                         BINARY_DOUBLE,
    cvalue                         VARCHAR2(4000 BYTE),
    txdesc                         VARCHAR2(4000 BYTE))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE txreqlogdtl_hist
/

CREATE TABLE txreqlogdtl_hist
    (autoid                         FLOAT(64),
    txdate                         DATE,
    txnum                          VARCHAR2(30 BYTE),
    fldcd                          VARCHAR2(3 BYTE),
    nvalue                         BINARY_DOUBLE,
    cvalue                         VARCHAR2(4000 BYTE),
    txdesc                         VARCHAR2(4000 BYTE))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE udfdefine
/

CREATE TABLE udfdefine
    (udftype                        VARCHAR2(100 BYTE),
    fieldcode                      VARCHAR2(100 BYTE),
    fieldname                      VARCHAR2(500 BYTE),
    status                         VARCHAR2(10 BYTE),
    lastchange                     TIMESTAMP (6),
    pstatus                        VARCHAR2(4000 BYTE),
    id                             VARCHAR2(500 BYTE) NOT NULL)
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE udfdefinememo
/

CREATE TABLE udfdefinememo
    (udftype                        VARCHAR2(100 BYTE),
    fieldcode                      VARCHAR2(100 BYTE),
    fieldname                      VARCHAR2(500 BYTE),
    status                         VARCHAR2(10 BYTE),
    lastchange                     TIMESTAMP (6),
    pstatus                        VARCHAR2(4000 BYTE),
    id                             VARCHAR2(500 BYTE) NOT NULL)
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE userlogin
/

CREATE TABLE userlogin
    (username                       VARCHAR2(50 BYTE),
    handphone                      VARCHAR2(50 BYTE),
    loginpwd                       VARCHAR2(1000 BYTE),
    tradingpwd                     VARCHAR2(1000 BYTE),
    authtype                       CHAR(1 BYTE),
    status                         CHAR(1 BYTE),
    loginstatus                    CHAR(1 BYTE),
    lastchanged                    TIMESTAMP (6),
    numberofday                    NUMBER(*,0),
    lastlogin                      TIMESTAMP (6),
    isreset                        CHAR(1 BYTE),
    ismaster                       CHAR(1 BYTE),
    tokenid                        VARCHAR2(25 BYTE),
    custodycd                      VARCHAR2(20 BYTE),
    retry_count                    NUMBER)
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE userloginhist
/

CREATE TABLE userloginhist
    (username                       VARCHAR2(50 BYTE),
    handphone                      VARCHAR2(50 BYTE),
    loginpwd                       VARCHAR2(4000 BYTE),
    tradingpwd                     VARCHAR2(4000 BYTE),
    authtype                       CHAR(1 BYTE),
    status                         CHAR(1 BYTE),
    loginstatus                    CHAR(1 BYTE),
    lastchanged                    TIMESTAMP (6),
    numberofday                    FLOAT(32),
    lastlogin                      TIMESTAMP (6),
    isreset                        CHAR(1 BYTE),
    ismaster                       CHAR(1 BYTE),
    tokenid                        VARCHAR2(25 BYTE),
    custodycd                      VARCHAR2(20 BYTE),
    retry_count                    NUMBER)
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE v_acc
/

CREATE TABLE v_acc
    (acctno                         VARCHAR2(30 BYTE))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE v_count
/

CREATE TABLE v_count
    (position                       FLOAT(32))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE v_feerate
/

CREATE TABLE v_feerate
    (coalesce                       BINARY_DOUBLE)
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE v_ischkotp
/

CREATE TABLE v_ischkotp
    (isotpchk                       CHAR(1 BYTE))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE v_isotpchk
/

CREATE TABLE v_isotpchk
    (isotpchk                       CHAR(1 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE v_return
/

CREATE TABLE v_return
    (sum                            BINARY_DOUBLE)
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE v_rptfilename
/

CREATE TABLE v_rptfilename
    (refrptfile                     VARCHAR2(500 BYTE))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE v_rptpath
/

CREATE TABLE v_rptpath
    (varvalue                       VARCHAR2(300 BYTE))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE v_saleacctno
/

CREATE TABLE v_saleacctno
    (saleacctno                     VARCHAR2(100 BYTE))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE v_smstype
/

CREATE TABLE v_smstype
    ("?COLUMN?"                     VARCHAR2(4000 BYTE))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE v_sql
/

CREATE TABLE v_sql
    (searchcmdsql                   VARCHAR2(4000 BYTE))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE v_strcurrdate
/

CREATE TABLE v_strcurrdate
    (varvalue                       VARCHAR2(300 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE v_strdatasource
/

CREATE TABLE v_strdatasource
    (datasource                     VARCHAR2(4000 BYTE))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE v_sumaum
/

CREATE TABLE v_sumaum
    (round                          BINARY_DOUBLE)
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE v_tltxcd
/

CREATE TABLE v_tltxcd
    (tltxcd                         VARCHAR2(4 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE van_test
/

CREATE TABLE van_test
    (objname                        VARCHAR2(200 BYTE),
    value                          VARCHAR2(500 BYTE),
    autoid                         BINARY_DOUBLE)
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE van_test_product
/

CREATE TABLE van_test_product
    (autoid                         BINARY_DOUBLE,
    symbol                         VARCHAR2(20 BYTE),
    prodname                       VARCHAR2(4000 BYTE),
    quoteprice                     BINARY_DOUBLE,
    prodrate                       BINARY_DOUBLE,
    sellbackprice                  BINARY_DOUBLE,
    periodcoupon                   BINARY_DOUBLE,
    total                          BINARY_DOUBLE,
    ytm                            FLOAT(32),
    quoteacctno                    VARCHAR2(4000 BYTE),
    termval                        BINARY_DOUBLE,
    prdid                          BINARY_DOUBLE)
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE variable
/

CREATE TABLE variable
    (reforderid                     VARCHAR2(20 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE version
/

CREATE TABLE version
    (updatedate                     TIMESTAMP (6),
    reportversion                  VARCHAR2(100 BYTE),
    actualversion                  VARCHAR2(100 BYTE))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE viewlnk2tmp
/

CREATE TABLE viewlnk2tmp
    (tmpcode                        VARCHAR2(50 BYTE),
    searchcode                     VARCHAR2(100 BYTE),
    sender                         VARCHAR2(50 BYTE),
    fieldname                      VARCHAR2(20 BYTE),
    modcode                        VARCHAR2(20 BYTE),
    refview                        VARCHAR2(50 BYTE),
    reffldfilter                   VARCHAR2(50 BYTE),
    notes                          VARCHAR2(250 BYTE),
    searchcmdsql                   VARCHAR2(4000 BYTE))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE x
/

CREATE TABLE x
    (custodycd                      VARCHAR2(20 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE xaaa
/

CREATE TABLE xaaa
    ("?COLUMN?"                     VARCHAR2(4000 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE z_ivmast
/

CREATE TABLE z_ivmast
    (acctno                         VARCHAR2(40 BYTE),
    afacctno                       VARCHAR2(30 BYTE),
    custid                         VARCHAR2(30 BYTE),
    custodycd                      VARCHAR2(10 BYTE),
    sid                            VARCHAR2(20 BYTE),
    codeid                         VARCHAR2(10 BYTE),
    symbol                         VARCHAR2(100 BYTE),
    srtype                         VARCHAR2(4 BYTE),
    sipcode                        VARCHAR2(20 BYTE),
    balance                        BINARY_DOUBLE,
    receiving                      BINARY_DOUBLE,
    careceiving                    BINARY_DOUBLE,
    netting                        BINARY_DOUBLE,
    blocked                        BINARY_DOUBLE,
    status                         VARCHAR2(1 BYTE),
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE z_semast
/

CREATE TABLE z_semast
    (acctno                         VARCHAR2(40 BYTE),
    afacctno                       VARCHAR2(30 BYTE),
    custodycd                      VARCHAR2(10 BYTE),
    sid                            VARCHAR2(20 BYTE),
    codeid                         VARCHAR2(20 BYTE),
    symbol                         VARCHAR2(20 BYTE),
    trade                          BINARY_DOUBLE,
    tradeepr                       BINARY_DOUBLE,
    tradeepe                       BINARY_DOUBLE,
    careceiving                    BINARY_DOUBLE,
    costprice                      BINARY_DOUBLE,
    receiving                      BINARY_DOUBLE,
    blocked                        BINARY_DOUBLE,
    netting                        BINARY_DOUBLE,
    status                         VARCHAR2(1 BYTE),
    pl                             BINARY_DOUBLE,
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6),
    sending                        BINARY_DOUBLE,
    secured                        BINARY_DOUBLE,
    tradesip                       BINARY_DOUBLE,
    sendingsip                     BINARY_DOUBLE,
    blockedsip                     BINARY_DOUBLE,
    isallowodsip                   VARCHAR2(1 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE z_srmast
/

CREATE TABLE z_srmast
    (orderid                        VARCHAR2(20 BYTE),
    txdate                         DATE,
    txnum                          VARCHAR2(12 BYTE),
    custodycd                      VARCHAR2(10 BYTE),
    afacctno                       VARCHAR2(30 BYTE),
    sid                            VARCHAR2(20 BYTE),
    codeid                         VARCHAR2(10 BYTE),
    seacctno                       VARCHAR2(40 BYTE),
    symbol                         VARCHAR2(10 BYTE),
    reforderid                     VARCHAR2(20 BYTE),
    exectype                       VARCHAR2(2 BYTE),
    srtype                         VARCHAR2(10 BYTE),
    sipid                          VARCHAR2(20 BYTE),
    paid                           VARCHAR2(20 BYTE),
    swid                           VARCHAR2(20 BYTE),
    sedtlid                        BINARY_DOUBLE,
    orderamt                       BINARY_DOUBLE,
    orderqtty                      BINARY_DOUBLE,
    remainqtty                     BINARY_DOUBLE,
    cancelqtty                     BINARY_DOUBLE,
    adjustqtty                     BINARY_DOUBLE,
    matchamt                       BINARY_DOUBLE,
    matchqtty                      BINARY_DOUBLE,
    cancelamt                      BINARY_DOUBLE,
    adjustamt                      BINARY_DOUBLE,
    feeamt                         BINARY_DOUBLE,
    sessionno                      VARCHAR2(20 BYTE),
    status                         VARCHAR2(10 BYTE),
    pstatus                        VARCHAR2(4000 BYTE),
    deltd                          VARCHAR2(1 BYTE),
    username                       VARCHAR2(100 BYTE),
    tlid                           VARCHAR2(10 BYTE),
    feeid                          VARCHAR2(50 BYTE),
    verfee                         VARCHAR2(100 BYTE),
    vermatching                    VARCHAR2(10 BYTE),
    porderid                       VARCHAR2(20 BYTE),
    lastchange                     TIMESTAMP (6),
    nav                            BINARY_DOUBLE,
    swcodeid                       VARCHAR2(10 BYTE),
    refquoteid                     VARCHAR2(20 BYTE),
    taxamt                         BINARY_DOUBLE,
    feebasic                       BINARY_DOUBLE,
    penaltyfee                     BINARY_DOUBLE,
    vsdorderid                     VARCHAR2(50 BYTE),
    txtime                         VARCHAR2(200 BYTE),
    saleacctno                     VARCHAR2(30 BYTE),
    cistatus                       VARCHAR2(1 BYTE),
    tradingdate                    DATE,
    objname                        VARCHAR2(100 BYTE),
    odconfirm                      VARCHAR2(1 BYTE),
    refcustodycd                   VARCHAR2(10 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE z_taquote
/

CREATE TABLE z_taquote
    (quoteid                        VARCHAR2(20 BYTE),
    txdate                         DATE,
    txnum                          VARCHAR2(10 BYTE),
    afacctno                       VARCHAR2(30 BYTE),
    custodycd                      VARCHAR2(10 BYTE),
    sid                            VARCHAR2(20 BYTE),
    codeid                         VARCHAR2(100 BYTE),
    symbol                         VARCHAR2(100 BYTE),
    orgorderid                     VARCHAR2(20 BYTE),
    reforderid                     VARCHAR2(20 BYTE),
    exectype                       VARCHAR2(2 BYTE),
    srtype                         VARCHAR2(10 BYTE),
    sipid                          VARCHAR2(20 BYTE),
    paid                           VARCHAR2(20 BYTE),
    swid                           VARCHAR2(20 BYTE),
    swcodeid                       VARCHAR2(100 BYTE),
    sedtlid                        BINARY_DOUBLE,
    orderamt                       BINARY_DOUBLE,
    qtty                           BINARY_DOUBLE,
    cancelqtty                     BINARY_DOUBLE,
    cancelamt                      BINARY_DOUBLE,
    adjustqtty                     BINARY_DOUBLE,
    adjustamt                      BINARY_DOUBLE,
    matchamt                       BINARY_DOUBLE,
    matchqtty                      BINARY_DOUBLE,
    feeamt                         BINARY_DOUBLE,
    status                         VARCHAR2(2 BYTE),
    pstatus                        VARCHAR2(4000 BYTE),
    deltd                          VARCHAR2(1 BYTE),
    username                       VARCHAR2(100 BYTE),
    tlid                           VARCHAR2(10 BYTE),
    feeid                          VARCHAR2(50 BYTE),
    ver                            VARCHAR2(100 BYTE),
    lastchange                     TIMESTAMP (6),
    porderid                       VARCHAR2(20 BYTE),
    tradingtype                    VARCHAR2(10 BYTE),
    tradingid                      VARCHAR2(100 BYTE),
    dbcode                         VARCHAR2(100 BYTE),
    expdate                        DATE,
    errcode                        VARCHAR2(20 BYTE),
    haltdate                       DATE,
    halt                           VARCHAR2(1 BYTE),
    wsname                         VARCHAR2(50 BYTE),
    ipaddress                      VARCHAR2(50 BYTE),
    orstatus                       VARCHAR2(3 BYTE),
    objname                        VARCHAR2(100 BYTE),
    feedbackmsg                    VARCHAR2(4000 BYTE),
    txtime                         VARCHAR2(200 BYTE),
    saleacctno                     VARCHAR2(30 BYTE),
    tradingdate                    DATE,
    vsdorderid                     VARCHAR2(100 BYTE),
    refcustodycd                   VARCHAR2(255 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE z_tbl_expreqmt
/

CREATE TABLE z_tbl_expreqmt
    (cr_custodycd                   VARCHAR2(4000 BYTE),
    cr_accountid                   VARCHAR2(4000 BYTE),
    dr_custodycd                   VARCHAR2(4000 BYTE),
    dr_accountid                   VARCHAR2(4000 BYTE),
    amount                         BINARY_DOUBLE,
    orderid                        VARCHAR2(4000 BYTE),
    exectms                        TIMESTAMP (6))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE z_tbl_reqmtcfm
/

CREATE TABLE z_tbl_reqmtcfm
    (cr_custodycd                   VARCHAR2(4000 BYTE),
    cr_accountid                   VARCHAR2(4000 BYTE),
    dr_custodycd                   VARCHAR2(4000 BYTE),
    dr_accountid                   VARCHAR2(4000 BYTE),
    amount                         BINARY_DOUBLE,
    confirm_flag                   FLOAT(32),
    exectms                        TIMESTAMP (6))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE z_tmp_txndtl
/

CREATE TABLE z_tmp_txndtl
    (custodycd                      VARCHAR2(4000 BYTE),
    symbol                         VARCHAR2(4000 BYTE),
    buy_id                         VARCHAR2(4000 BYTE),
    sell_id                        VARCHAR2(4000 BYTE),
    buy_date                       TIMESTAMP (6),
    sell_date                      TIMESTAMP (6),
    hold_time                      FLOAT(32),
    buy_custodycd                  VARCHAR2(4000 BYTE),
    sell_custodycd                 VARCHAR2(4000 BYTE),
    buy_amt                        BINARY_DOUBLE,
    sell_amt                       BINARY_DOUBLE,
    pl_amt                         BINARY_DOUBLE,
    buy_qtty                       BINARY_DOUBLE,
    sell_qtty                      BINARY_DOUBLE,
    real_qtty                      BINARY_DOUBLE)
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/
