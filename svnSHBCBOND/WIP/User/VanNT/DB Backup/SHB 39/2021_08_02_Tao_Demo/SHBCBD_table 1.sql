DROP TABLE action_log
/

CREATE TABLE action_log
    (autoid                         NUMBER,
    userid                         VARCHAR2(50 BYTE),
    ip                             VARCHAR2(20 BYTE),
    cmdobjname                     VARCHAR2(50 BYTE),
    action                         VARCHAR2(10 BYTE),
    action_time                    TIMESTAMP (6),
    func_key                       VARCHAR2(50 BYTE),
    key_value                      VARCHAR2(50 BYTE),
    param_value                    VARCHAR2(4000 BYTE),
    err_code                       VARCHAR2(50 BYTE),
    err_param                      VARCHAR2(4000 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE advertise
/

CREATE TABLE advertise
    (autoid                         BINARY_DOUBLE NOT NULL,
    adid                           VARCHAR2(30 BYTE),
    txdate                         DATE,
    txtime                         VARCHAR2(30 BYTE),
    traderid                       VARCHAR2(20 BYTE),
    checkerid                      VARCHAR2(20 BYTE),
    afacctno                       VARCHAR2(30 BYTE),
    codeid                         VARCHAR2(30 BYTE),
    symbol                         VARCHAR2(30 BYTE),
    intrate                        BINARY_DOUBLE,
    effdate                        DATE,
    expdate                        DATE,
    amount                         BINARY_DOUBLE,
    execamt                        BINARY_DOUBLE,
    txnum                          VARCHAR2(30 BYTE),
    status                         VARCHAR2(1 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE afmast
/

CREATE TABLE afmast
    (acctno                         VARCHAR2(30 BYTE) NOT NULL,
    custid                         VARCHAR2(30 BYTE),
    custodycd                      VARCHAR2(10 BYTE),
    sid                            VARCHAR2(20 BYTE),
    status                         VARCHAR2(1 BYTE) DEFAULT 'P',
    pstatus                        VARCHAR2(255 BYTE),
    lastchange                     TIMESTAMP (6))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

ALTER TABLE afmast
ADD CONSTRAINT afmast_pkey PRIMARY KEY (acctno)
USING INDEX
/

DROP TABLE aftemplates
/

CREATE TABLE aftemplates
    (autoid                         BINARY_DOUBLE,
    custid                         VARCHAR2(20 BYTE),
    template_code                  VARCHAR2(10 BYTE),
    createdate                     TIMESTAMP (6) DEFAULT to_date('0001-01-01 00:00:00', 'YYYY-MM-DD hh24:mi:ss'),
    deletedate                     TIMESTAMP (6),
    last_change                    TIMESTAMP (6))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE aftemplates_hist
/

CREATE TABLE aftemplates_hist
    (autoid                         BINARY_DOUBLE,
    custid                         VARCHAR2(20 BYTE),
    template_code                  VARCHAR2(10 BYTE),
    createdate                     TIMESTAMP (6),
    deletedate                     TIMESTAMP (6),
    last_change                    TIMESTAMP (6))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE aftran
/

CREATE TABLE aftran
    (txnum                          VARCHAR2(60 BYTE),
    txdate                         DATE,
    acctno                         VARCHAR2(20 BYTE),
    txcd                           VARCHAR2(4 BYTE),
    namt                           FLOAT(64),
    camt                           VARCHAR2(50 BYTE),
    ref                            VARCHAR2(50 BYTE),
    deltd                          VARCHAR2(1 BYTE),
    autoid                         BINARY_DOUBLE,
    acctref                        VARCHAR2(20 BYTE),
    tltxcd                         VARCHAR2(4 BYTE),
    bkdate                         DATE,
    trdesc                         VARCHAR2(4000 BYTE))
  SEGMENT CREATION DEFERRED
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE aftrana
/

CREATE TABLE aftrana
    (txnum                          VARCHAR2(60 BYTE),
    txdate                         DATE,
    acctno                         VARCHAR2(20 BYTE),
    txcd                           VARCHAR2(4 BYTE),
    namt                           FLOAT(64),
    camt                           VARCHAR2(50 BYTE),
    ref                            VARCHAR2(50 BYTE),
    deltd                          VARCHAR2(1 BYTE),
    autoid                         BINARY_DOUBLE,
    acctref                        VARCHAR2(20 BYTE),
    tltxcd                         VARCHAR2(4 BYTE),
    bkdate                         DATE,
    trdesc                         VARCHAR2(4000 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE aftxmap
/

CREATE TABLE aftxmap
    (autoid                         BINARY_DOUBLE,
    afacctno                       VARCHAR2(20 BYTE),
    tltxcd                         VARCHAR2(4 BYTE),
    effdate                        DATE,
    expdate                        DATE,
    tlid                           VARCHAR2(50 BYTE),
    deltd                          VARCHAR2(1 BYTE),
    last_change                    TIMESTAMP (6),
    actype                         VARCHAR2(4 BYTE),
    status                         VARCHAR2(4 BYTE),
    pstatus                        VARCHAR2(4000 BYTE))
  SEGMENT CREATION DEFERRED
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE aftype
/

CREATE TABLE aftype
    (autoid                         NUMBER DEFAULT 0 NOT NULL,
    actype                         VARCHAR2(10 BYTE),
    cftype                         VARCHAR2(10 BYTE),
    typename                       VARCHAR2(500 BYTE),
    status                         VARCHAR2(1 BYTE),
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE aftype_bk
/

CREATE TABLE aftype_bk
    (autoid                         BINARY_DOUBLE NOT NULL,
    actype                         VARCHAR2(10 BYTE),
    cftype                         VARCHAR2(10 BYTE),
    typename                       VARCHAR2(500 BYTE),
    status                         VARCHAR2(1 BYTE),
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE aftypememo
/

CREATE TABLE aftypememo
    (autoid                         NUMBER DEFAULT 0 NOT NULL,
    actype                         VARCHAR2(22 BYTE),
    cftype                         VARCHAR2(10 BYTE),
    typename                       VARCHAR2(500 BYTE),
    status                         VARCHAR2(1 BYTE),
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE ahihi
/

CREATE TABLE ahihi
    (value                          VARCHAR2(255 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE alertcontent
/

CREATE TABLE alertcontent
    (autoid                         FLOAT(64),
    shortcontent                   VARCHAR2(4000 BYTE),
    maincontent                    VARCHAR2(4000 BYTE),
    createtime                     TIMESTAMP (6),
    alerttype                      VARCHAR2(10 BYTE),
    status                         VARCHAR2(10 BYTE),
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6),
    senddate                       DATE,
    maker                          VARCHAR2(50 BYTE),
    reader                         VARCHAR2(50 BYTE),
    maincontent_en                 VARCHAR2(200 BYTE),
    shortcontent_en                VARCHAR2(200 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE alertcontentmemo
/

CREATE TABLE alertcontentmemo
    (autoid                         FLOAT(64),
    shortcontent                   VARCHAR2(4000 BYTE),
    maincontent                    VARCHAR2(4000 BYTE),
    createtime                     TIMESTAMP (6),
    alerttype                      VARCHAR2(10 BYTE),
    status                         VARCHAR2(10 BYTE),
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6),
    senddate                       DATE)
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE alertdetail
/

CREATE TABLE alertdetail
    (autoid                         FLOAT(64),
    refautoid                      FLOAT(64),
    refid                          VARCHAR2(50 BYTE),
    isread                         CHAR(1 BYTE),
    lastchange                     TIMESTAMP (6),
    isdelete                       VARCHAR2(2 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE alerttemp
/

CREATE TABLE alerttemp
    (msg_type                       VARCHAR2(100 BYTE),
    msg_shortcontent               VARCHAR2(4000 BYTE),
    msg_maincontent                VARCHAR2(4000 BYTE),
    msg_shortcontent_en            VARCHAR2(4000 BYTE),
    msg_maincontent_en             VARCHAR2(4000 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE allcode
/

CREATE TABLE allcode
    (cdtype                         VARCHAR2(2 BYTE),
    cdname                         VARCHAR2(100 BYTE),
    cdval                          VARCHAR2(100 BYTE),
    cdcontent                      VARCHAR2(500 BYTE),
    lstodr                         FLOAT(64) DEFAULT 0,
    cduser                         VARCHAR2(1 BYTE),
    en_cdcontent                   VARCHAR2(500 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

CREATE INDEX allcode_idx01 ON allcode
  (
    cdval                           ASC,
    cdname                          ASC
  )
NOPARALLEL
NOLOGGING
/

CREATE INDEX allcode_cdtype_cdname_idx ON allcode
  (
    cdname                          ASC,
    cdtype                          ASC
  )
NOPARALLEL
NOLOGGING
/


DROP TABLE appchk
/

CREATE TABLE appchk
    (tltxcd                         VARCHAR2(4 BYTE),
    apptype                        VARCHAR2(2 BYTE),
    acfld                          VARCHAR2(10 BYTE),
    rulecd                         VARCHAR2(5 BYTE),
    amtexp                         VARCHAR2(100 BYTE),
    fldkey                         VARCHAR2(20 BYTE),
    deltdchk                       CHAR(1 BYTE),
    isrun                          VARCHAR2(50 BYTE),
    chklev                         FLOAT(64) DEFAULT 0,
    lvel                           FLOAT(64) DEFAULT 0)
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

CREATE INDEX appchk_tltx_idx ON appchk
  (
    tltxcd                          ASC
  )
NOPARALLEL
NOLOGGING
/

CREATE INDEX appchk_apptype_idx ON appchk
  (
    rulecd                          ASC,
    apptype                         ASC
  )
NOPARALLEL
NOLOGGING
/


DROP TABLE applogininfo
/

CREATE TABLE applogininfo
    (sessionid                      VARCHAR2(4000 BYTE),
    userid                         VARCHAR2(100 BYTE),
    ipaddress                      VARCHAR2(100 BYTE),
    macaddress                     VARCHAR2(100 BYTE),
    status                         VARCHAR2(1 BYTE),
    logintime                      TIMESTAMP (6),
    lastrequest                    TIMESTAMP (6))
  SEGMENT CREATION DEFERRED
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE appmap
/

CREATE TABLE appmap
    (tltxcd                         VARCHAR2(4 BYTE),
    apptype                        VARCHAR2(2 BYTE),
    apptxcd                        VARCHAR2(4 BYTE),
    acfld                          VARCHAR2(10 BYTE),
    amtexp                         VARCHAR2(100 BYTE),
    cond                           VARCHAR2(1 BYTE),
    acfldref                       VARCHAR2(10 BYTE),
    apptyperef                     VARCHAR2(2 BYTE),
    fldkey                         VARCHAR2(20 BYTE) DEFAULT 'ACCTNO',
    isrun                          VARCHAR2(50 BYTE),
    trdesc                         VARCHAR2(4000 BYTE),
    odrnum                         BINARY_DOUBLE DEFAULT 0,
    lvel                           FLOAT(64) DEFAULT 0,
    vermatching                    VARCHAR2(100 BYTE),
    sessionno                      VARCHAR2(20 BYTE),
    orderid                        VARCHAR2(20 BYTE),
    feeid                          VARCHAR2(100 BYTE))
  SEGMENT CREATION DEFERRED
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE appmodules
/

CREATE TABLE appmodules
    (txcode                         VARCHAR2(2 BYTE),
    modcode                        VARCHAR2(2 BYTE),
    modname                        VARCHAR2(50 BYTE),
    classname                      VARCHAR2(50 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE apprules
/

CREATE TABLE apprules
    (apptype                        VARCHAR2(2 BYTE) NOT NULL,
    rulecd                         VARCHAR2(50 BYTE) NOT NULL,
    tblname                        VARCHAR2(20 BYTE),
    field                          VARCHAR2(30 BYTE),
    operand                        VARCHAR2(2 BYTE),
    errnum                         FLOAT(64) DEFAULT 0,
    errmsg                         VARCHAR2(4000 BYTE),
    refid                          VARCHAR2(30 BYTE),
    fldrnd                         VARCHAR2(5 BYTE))
  SEGMENT CREATION DEFERRED
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE apprvexec
/

CREATE TABLE apprvexec
    (autoid                         FLOAT(64),
    table_name                     VARCHAR2(50 BYTE),
    record_key                     VARCHAR2(50 BYTE),
    child_table_name               VARCHAR2(50 BYTE),
    child_record_key               VARCHAR2(50 BYTE),
    action_flag                    VARCHAR2(20 BYTE),
    sqlcmd                         VARCHAR2(4000 BYTE),
    sqlcmdtype                     VARCHAR2(50 BYTE),
    status                         CHAR(1 BYTE) DEFAULT 'N',
    make_dt                        TIMESTAMP (6),
    maketime                       TIMESTAMP (6))
  SEGMENT CREATION DEFERRED
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE apprvrqd
/

CREATE TABLE apprvrqd
    (objname                        VARCHAR2(50 BYTE),
    rqdstring                      VARCHAR2(50 BYTE),
    makerid                        VARCHAR2(4 BYTE),
    makerdt                        TIMESTAMP (6),
    apprvid                        VARCHAR2(4 BYTE),
    apprvdt                        TIMESTAMP (6),
    modnum                         FLOAT(16) DEFAULT 0,
    addatappr                      CHAR(1 BYTE) DEFAULT 'N',
    editatappr                     CHAR(1 BYTE) DEFAULT 'N',
    delatappr                      CHAR(1 BYTE) DEFAULT 'N',
    addchildatappr                 CHAR(1 BYTE) DEFAULT 'N')
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE apptx
/

CREATE TABLE apptx
    (apptype                        VARCHAR2(2 BYTE),
    txcd                           VARCHAR2(4 BYTE),
    txupdate                       VARCHAR2(1 BYTE),
    txtype                         VARCHAR2(1 BYTE),
    field                          VARCHAR2(30 BYTE),
    fldtype                        VARCHAR2(1 BYTE),
    ofile                          VARCHAR2(30 BYTE),
    ofileact                       VARCHAR2(30 BYTE),
    ifile                          VARCHAR2(15 BYTE),
    intf                           VARCHAR2(1 BYTE),
    tblname                        VARCHAR2(20 BYTE),
    tranf                          VARCHAR2(20 BYTE),
    fldrnd                         VARCHAR2(5 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

CREATE INDEX apptx_txcd_idx ON apptx
  (
    txcd                            ASC
  )
NOPARALLEL
NOLOGGING
/

CREATE INDEX apptx_field_apptype_idx ON apptx
  (
    apptype                         ASC,
    field                           ASC
  )
NOPARALLEL
NOLOGGING
/

CREATE INDEX apptx_idx ON apptx
  (
    txcd                            ASC,
    apptype                         ASC
  )
NOPARALLEL
NOLOGGING
/


DROP TABLE areas
/

CREATE TABLE areas
    (areaid                         VARCHAR2(10 BYTE) NOT NULL,
    mbid                           VARCHAR2(10 BYTE),
    areaname                       VARCHAR2(250 BYTE),
    areaname_en                    VARCHAR2(250 BYTE),
    legalperson                    VARCHAR2(350 BYTE),
    phone                          VARCHAR2(50 BYTE),
    email                          VARCHAR2(350 BYTE),
    status                         VARCHAR2(1 BYTE) DEFAULT 'A',
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6) DEFAULT to_date('0001-01-01 00:00:00', 'YYYY-MM-DD hh24:mi:ss'),
    arearefid                      VARCHAR2(6 BYTE),
    fax                            VARCHAR2(50 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

ALTER TABLE areas
ADD CONSTRAINT areas_pkey PRIMARY KEY (areaid)
USING INDEX
/

DROP TABLE areascv
/

CREATE TABLE areascv
    (areaid                         VARCHAR2(6 BYTE) NOT NULL,
    areaname                       VARCHAR2(250 BYTE),
    mbcode                         VARCHAR2(10 BYTE))
  SEGMENT CREATION DEFERRED
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE asset_putoption
/

CREATE TABLE asset_putoption
    (codeid                         FLOAT(64),
    symbol                         VARCHAR2(20 BYTE),
    autoid                         FLOAT(64) DEFAULT 0,
    putdate                        DATE,
    putstrike                      BINARY_DOUBLE,
    status                         VARCHAR2(1 BYTE))
  SEGMENT CREATION DEFERRED
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE asset_putoption_temp
/

CREATE TABLE asset_putoption_temp
    (codeid                         FLOAT(64),
    symbol                         VARCHAR2(20 BYTE),
    autoid                         FLOAT(64) DEFAULT 0,
    putdate                        DATE,
    putstrike                      BINARY_DOUBLE,
    status                         VARCHAR2(1 BYTE))
  SEGMENT CREATION DEFERRED
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE assetdtl
/

CREATE TABLE assetdtl
    (autoid                         FLOAT(64),
    symbol                         VARCHAR2(15 BYTE),
    refinst                        VARCHAR2(15 BYTE),
    sectypeid                      VARCHAR2(5 BYTE),
    sectype                        VARCHAR2(100 BYTE),
    parvalue                       NUMBER(38,0),
    fullname_vn                    VARCHAR2(100 BYTE),
    fullname_en                    VARCHAR2(100 BYTE),
    settmodeid                     VARCHAR2(100 BYTE),
    settmode                       VARCHAR2(100 BYTE),
    bankacct                       VARCHAR2(100 BYTE),
    bankcd                         VARCHAR2(100 BYTE),
    ccpafacctno                    VARCHAR2(100 BYTE),
    spotmodeid                     VARCHAR2(100 BYTE),
    spotmode                       VARCHAR2(100 BYTE),
    assetbackedid                  VARCHAR2(100 BYTE),
    assetbacked                    VARCHAR2(100 BYTE),
    assetnotes                     VARCHAR2(100 BYTE),
    assetpricecdid                 VARCHAR2(100 BYTE),
    assetpricecd                   VARCHAR2(100 BYTE),
    assetpricefrq                  NUMBER(38,0),
    assetvalue                     NUMBER(38,0),
    refurl                         VARCHAR2(100 BYTE),
    issuedvol                      NUMBER(38,0),
    principalcd                    VARCHAR2(100 BYTE),
    putoption                      VARCHAR2(100 BYTE),
    calloption                     VARCHAR2(100 BYTE),
    trfoption                      VARCHAR2(100 BYTE),
    callnotes                      VARCHAR2(100 BYTE),
    intratefltcd                   VARCHAR2(100 BYTE),
    intratebaseddt                 DATE,
    intratefltfrqid                VARCHAR2(5 BYTE),
    intratefltfrq                  VARCHAR2(100 BYTE),
    intpaidfrq                     VARCHAR2(100 BYTE),
    intratefltnotes                VARCHAR2(100 BYTE),
    intbaseddofyid                 VARCHAR2(5 BYTE),
    intbaseddofy                   VARCHAR2(100 BYTE),
    flintrate                      NUMBER(10,5),
    intrate                        NUMBER(10,5),
    mrkprice                       NUMBER(38,0),
    mrkdate                        DATE,
    opndate                        DATE,
    duedate                        DATE,
    lstintdate                     DATE,
    prinpaid                       NUMBER(38,5),
    description                    VARCHAR2(100 BYTE),
    instypid                       VARCHAR2(15 BYTE),
    instyp                         VARCHAR2(500 BYTE),
    calldate                       VARCHAR2(500 BYTE),
    callstrike                     NUMBER(38,0),
    putdate                        VARCHAR2(500 BYTE),
    putstrike                      NUMBER(38,0),
    refprefix                      VARCHAR2(500 BYTE),
    refcustid                      VARCHAR2(500 BYTE),
    lastchange                     TIMESTAMP (6) DEFAULT NULL,
    status                         VARCHAR2(1 BYTE),
    pstatus                        VARCHAR2(100 BYTE),
    bookvalue                      NUMBER(38,0),
    citybank                       VARCHAR2(200 BYTE),
    intpaidday                     VARCHAR2(2 BYTE),
    intcalmethod                   VARCHAR2(1 BYTE),
    ceilintrate                    NUMBER(38,5),
    issuerid                       VARCHAR2(10 BYTE),
    fixeddatebuy                   VARCHAR2(1 BYTE) DEFAULT 'N',
    fixeddatesell                  VARCHAR2(1 BYTE) DEFAULT 'N',
    bien_do                        NUMBER(10,5) DEFAULT 0,
    buyall                         VARCHAR2(1 BYTE) DEFAULT 'N',
    tradeplace                     VARCHAR2(20 BYTE),
    qcmua                          VARCHAR2(4000 BYTE) DEFAULT '',
    qcban                          VARCHAR2(4000 BYTE) DEFAULT '',
    balancereportdate              NUMBER(*,0) DEFAULT 0,
    isgioihanndt                   VARCHAR2(50 BYTE) DEFAULT 'N',
    limittime                      NUMBER DEFAULT 0,
    numberinvestor                 NUMBER DEFAULT 0,
    kydieuchinh                    NUMBER DEFAULT 0,
    treasurysymbol                 VARCHAR2(50 BYTE),
    reviewdate                     NUMBER(22,0) DEFAULT 0,
    curinvestor                    NUMBER DEFAULT 0,
    depository                     VARCHAR2(100 BYTE),
    udf                            VARCHAR2(4000 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE assetdtl_udf
/

CREATE TABLE assetdtl_udf
    (autoid                         NUMBER DEFAULT 0,
    issuerid                       VARCHAR2(10 BYTE),
    udffield                       VARCHAR2(500 BYTE),
    udfvalue                       VARCHAR2(500 BYTE),
    udfname                        VARCHAR2(500 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE assetdtlmemo
/

CREATE TABLE assetdtlmemo
    (autoid                         FLOAT(64) NOT NULL,
    symbol                         VARCHAR2(15 BYTE),
    refinst                        VARCHAR2(15 BYTE),
    sectypeid                      VARCHAR2(5 BYTE),
    sectype                        VARCHAR2(100 BYTE),
    parvalue                       BINARY_DOUBLE,
    fullname_vn                    VARCHAR2(100 BYTE),
    fullname_en                    VARCHAR2(100 BYTE),
    settmodeid                     VARCHAR2(5 BYTE),
    settmode                       VARCHAR2(100 BYTE),
    bankacct                       VARCHAR2(100 BYTE),
    bankcd                         VARCHAR2(100 BYTE),
    ccpafacctno                    VARCHAR2(100 BYTE),
    spotmodeid                     VARCHAR2(5 BYTE),
    spotmode                       VARCHAR2(100 BYTE),
    assetbackedid                  VARCHAR2(100 BYTE),
    assetbacked                    VARCHAR2(100 BYTE),
    assetnotes                     VARCHAR2(100 BYTE),
    assetpricecdid                 VARCHAR2(5 BYTE),
    assetpricecd                   VARCHAR2(100 BYTE),
    assetpricefrq                  BINARY_DOUBLE,
    assetvalue                     BINARY_DOUBLE,
    refurl                         VARCHAR2(100 BYTE),
    issuedvol                      BINARY_DOUBLE,
    principalcd                    VARCHAR2(100 BYTE),
    putoption                      VARCHAR2(100 BYTE),
    calloption                     VARCHAR2(100 BYTE),
    trfoption                      VARCHAR2(100 BYTE),
    callnotes                      VARCHAR2(100 BYTE),
    intratefltcd                   VARCHAR2(100 BYTE),
    intratebaseddt                 DATE,
    intratefltfrqid                VARCHAR2(5 BYTE),
    intratefltfrq                  VARCHAR2(100 BYTE),
    intpaidfrq                     VARCHAR2(100 BYTE),
    intratefltnotes                VARCHAR2(100 BYTE),
    intbaseddofyid                 VARCHAR2(5 BYTE),
    intbaseddofy                   VARCHAR2(100 BYTE),
    flintrate                      BINARY_DOUBLE,
    intrate                        BINARY_DOUBLE,
    mrkprice                       BINARY_DOUBLE,
    mrkdate                        DATE,
    opndate                        DATE,
    duedate                        DATE,
    lstintdate                     DATE,
    prinpaid                       BINARY_DOUBLE,
    description                    VARCHAR2(100 BYTE),
    instypid                       VARCHAR2(15 BYTE),
    instyp                         VARCHAR2(500 BYTE),
    calldate                       VARCHAR2(500 BYTE),
    callstrike                     BINARY_DOUBLE,
    putdate                        VARCHAR2(500 BYTE),
    putstrike                      BINARY_DOUBLE,
    refprefix                      VARCHAR2(500 BYTE),
    refcustid                      VARCHAR2(500 BYTE),
    lastchange                     TIMESTAMP (6) DEFAULT to_date('0001-01-01 00:00:00', 'YYYY-MM-DD hh24:mi:ss'),
    status                         VARCHAR2(1 BYTE),
    pstatus                        VARCHAR2(100 BYTE),
    bookvalue                      BINARY_DOUBLE,
    citybank                       VARCHAR2(200 BYTE),
    intpaidday                     VARCHAR2(2 BYTE),
    intcalmethod                   VARCHAR2(1 BYTE),
    ceilintrate                    BINARY_DOUBLE,
    issuerid                       VARCHAR2(10 BYTE),
    fixeddatebuy                   VARCHAR2(1 BYTE) DEFAULT 'N',
    fixeddatesell                  VARCHAR2(1 BYTE) DEFAULT 'N',
    bien_do                        BINARY_DOUBLE DEFAULT 0,
    buyall                         VARCHAR2(1 BYTE) DEFAULT 'N',
    tradeplace                     VARCHAR2(20 BYTE),
    qcmua                          VARCHAR2(4000 BYTE) DEFAULT '',
    qcban                          VARCHAR2(4000 BYTE) DEFAULT '',
    balancereportdate              NUMBER(*,0) DEFAULT 0,
    isgioihanndt                   VARCHAR2(50 BYTE) DEFAULT 'N',
    limittime                      NUMBER DEFAULT 0,
    numberinvestor                 NUMBER DEFAULT 0,
    kydieuchinh                    NUMBER DEFAULT 0,
    treasurysymbol                 VARCHAR2(50 BYTE),
    reviewdate                     NUMBER(22,0) DEFAULT 0,
    depository                     VARCHAR2(100 BYTE),
    udf                            VARCHAR2(4000 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE attachments
/

CREATE TABLE attachments
    (autoid                         FLOAT(64) DEFAULT 0 NOT NULL,
    attachment_id                  VARCHAR2(10 BYTE),
    report_id                      VARCHAR2(10 BYTE))
  SEGMENT CREATION DEFERRED
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE bank
/

CREATE TABLE bank
    (bankcode                       VARCHAR2(100 BYTE) NOT NULL,
    bankname                       VARCHAR2(200 BYTE),
    bankname_en                    VARCHAR2(200 BYTE),
    bidcode                        VARCHAR2(200 BYTE),
    citadcode                      VARCHAR2(200 BYTE),
    licenseno                      VARCHAR2(50 BYTE),
    licensedate                    TIMESTAMP (6),
    address                        VARCHAR2(500 BYTE),
    faxno                          VARCHAR2(50 BYTE),
    status                         VARCHAR2(1 BYTE) DEFAULT 'P',
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6),
    note                           VARCHAR2(500 BYTE),
    fullname                       VARCHAR2(200 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

ALTER TABLE bank
ADD CONSTRAINT bank_pkey PRIMARY KEY (bankcode)
USING INDEX
/

DROP TABLE bank_temp
/

CREATE TABLE bank_temp
    (bankcode                       VARCHAR2(100 BYTE),
    fullname                       VARCHAR2(4000 BYTE))
  SEGMENT CREATION DEFERRED
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE bankmemo
/

CREATE TABLE bankmemo
    (bankcode                       VARCHAR2(100 BYTE),
    bankname                       VARCHAR2(200 BYTE),
    bankname_en                    VARCHAR2(200 BYTE),
    bidcode                        VARCHAR2(200 BYTE),
    citadcode                      VARCHAR2(200 BYTE),
    licenseno                      VARCHAR2(50 BYTE),
    licensedate                    TIMESTAMP (6),
    address                        VARCHAR2(500 BYTE),
    faxno                          VARCHAR2(50 BYTE),
    status                         VARCHAR2(1 BYTE),
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6),
    note                           VARCHAR2(500 BYTE),
    fullname                       VARCHAR2(200 BYTE))
  SEGMENT CREATION DEFERRED
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE bidcode
/

CREATE TABLE bidcode
    (bidcode                        VARCHAR2(100 BYTE),
    dbcode                         VARCHAR2(100 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE boughtdtl
/

CREATE TABLE boughtdtl
    (autoid                         NUMBER(38,0),
    acctno                         VARCHAR2(20 BYTE),
    symbol                         VARCHAR2(200 BYTE),
    tltxcd                         VARCHAR2(4 BYTE),
    price                          NUMBER(38,0) DEFAULT 0,
    parvalue                       NUMBER(38,0) DEFAULT 0,
    qtty                           NUMBER(38,0) DEFAULT 0,
    confirmno                      VARCHAR2(100 BYTE),
    trntype                        CHAR(1 BYTE),
    return_qtty                    NUMBER(38,0) DEFAULT 0,
    return_confirmno               VARCHAR2(100 BYTE),
    trndate                        TIMESTAMP (6),
    before_limit                   NUMBER(38,0) DEFAULT 0,
    remain_limit                   NUMBER(38,0) DEFAULT 0,
    return_limit                   NUMBER(38,0) DEFAULT 0,
    deltd                          CHAR(1 BYTE) DEFAULT 'N',
    product                        VARCHAR2(200 BYTE),
    return_limit_prd               NUMBER,
    before_limit_ass               NUMBER,
    remain_limit_ass               NUMBER,
    return_limit_ass               NUMBER,
    before_limit_prd               NUMBER,
    remain_limit_prd               NUMBER)
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE brgrp
/

CREATE TABLE brgrp
    (brid                           VARCHAR2(6 BYTE) NOT NULL,
    prbrid                         VARCHAR2(6 BYTE),
    mbid                           VARCHAR2(10 BYTE),
    areaid                         VARCHAR2(10 BYTE),
    brname                         VARCHAR2(250 BYTE),
    braddress                      VARCHAR2(250 BYTE),
    brdeputy                       VARCHAR2(250 BYTE),
    broffice                       VARCHAR2(250 BYTE),
    brtele                         VARCHAR2(250 BYTE),
    bremail                        VARCHAR2(250 BYTE),
    status                         VARCHAR2(1 BYTE) DEFAULT 'A',
    pstatus                        VARCHAR2(4000 BYTE),
    description                    VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6),
    brname_en                      VARCHAR2(250 BYTE),
    brtype                         VARCHAR2(10 BYTE),
    brfax                          VARCHAR2(250 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE brgrp_haha
/

CREATE TABLE brgrp_haha
    (brid                           VARCHAR2(6 BYTE),
    prbrid                         VARCHAR2(6 BYTE),
    mbid                           VARCHAR2(10 BYTE),
    areaid                         VARCHAR2(10 BYTE),
    brname                         VARCHAR2(250 BYTE),
    braddress                      VARCHAR2(250 BYTE),
    brdeputy                       VARCHAR2(250 BYTE),
    broffice                       VARCHAR2(250 BYTE),
    brtele                         VARCHAR2(250 BYTE),
    bremail                        VARCHAR2(250 BYTE),
    dcname                         VARCHAR2(250 BYTE),
    mapid                          VARCHAR2(500 BYTE),
    status                         VARCHAR2(1 BYTE),
    pstatus                        VARCHAR2(4000 BYTE),
    custodycdfrom                  VARCHAR2(50 BYTE),
    custodycdto                    VARCHAR2(50 BYTE),
    description                    VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6),
    vsdbrid                        VARCHAR2(20 BYTE))
  SEGMENT CREATION DEFERRED
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE brgrpcv
/

CREATE TABLE brgrpcv
    (brid                           VARCHAR2(20 BYTE) NOT NULL,
    brname                         VARCHAR2(250 BYTE),
    areaid                         VARCHAR2(20 BYTE),
    mbid                           VARCHAR2(20 BYTE),
    brdeputy                       VARCHAR2(250 BYTE),
    broffice                       VARCHAR2(250 BYTE),
    brtele                         VARCHAR2(250 BYTE),
    bremail                        VARCHAR2(250 BYTE),
    vsdbrid                        VARCHAR2(20 BYTE))
  SEGMENT CREATION DEFERRED
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE brgrpmemo
/

CREATE TABLE brgrpmemo
    (brid                           VARCHAR2(6 BYTE) NOT NULL,
    prbrid                         VARCHAR2(6 BYTE),
    mbid                           VARCHAR2(10 BYTE),
    areaid                         VARCHAR2(10 BYTE),
    brname                         VARCHAR2(250 BYTE),
    braddress                      VARCHAR2(250 BYTE),
    brdeputy                       VARCHAR2(250 BYTE),
    broffice                       VARCHAR2(250 BYTE),
    brtele                         VARCHAR2(250 BYTE),
    bremail                        VARCHAR2(250 BYTE),
    status                         VARCHAR2(1 BYTE),
    pstatus                        VARCHAR2(4000 BYTE),
    description                    VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6),
    brname_en                      VARCHAR2(250 BYTE),
    brtype                         VARCHAR2(10 BYTE))
  SEGMENT CREATION DEFERRED
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE brgrpparam
/

CREATE TABLE brgrpparam
    (autoid                         FLOAT(64) DEFAULT 0 NOT NULL,
    brid                           VARCHAR2(4 BYTE),
    paratype                       VARCHAR2(20 BYTE),
    paravalue                      VARCHAR2(20 BYTE),
    deltd                          VARCHAR2(1 BYTE),
    savetlid                       VARCHAR2(4 BYTE),
    savebrid                       VARCHAR2(4 BYTE),
    lastdate                       TIMESTAMP (6))
  SEGMENT CREATION DEFERRED
  NOPARALLEL
  NOLOGGING
  MONITORING
/

ALTER TABLE brgrpparam
ADD CONSTRAINT brgrpparam_pkey PRIMARY KEY (autoid)
USING INDEX
/

DROP TABLE buyoption
/

CREATE TABLE buyoption
    (autoid                         NUMBER(38,0),
    id                             NUMBER(38,0),
    calloption                     VARCHAR2(50 BYTE),
    fixeddatebuy                   VARCHAR2(50 BYTE),
    calldate                       DATE,
    buyall                         VARCHAR2(50 BYTE),
    status                         VARCHAR2(1 BYTE),
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6),
    action                         VARCHAR2(200 BYTE),
    percent                        NUMBER DEFAULT 0,
    calcmethod                     VARCHAR2(20 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE camast
/

CREATE TABLE camast
    (autoid                         FLOAT(64) NOT NULL,
    codeid                         VARCHAR2(10 BYTE),
    catype                         VARCHAR2(3 BYTE),
    reportdate                     TIMESTAMP (6),
    duedate                        TIMESTAMP (6),
    actiondate                     TIMESTAMP (6),
    exprice                        FLOAT(64),
    price                          FLOAT(64),
    exrate                         VARCHAR2(20 BYTE),
    rightoffrate                   VARCHAR2(20 BYTE),
    devidentrate                   VARCHAR2(20 BYTE),
    devidentshares                 VARCHAR2(20 BYTE),
    splitrate                      VARCHAR2(20 BYTE),
    interestrate                   VARCHAR2(20 BYTE),
    interestperiod                 FLOAT(64),
    status                         VARCHAR2(1 BYTE) DEFAULT 'A',
    camastid                       VARCHAR2(20 BYTE),
    description                    VARCHAR2(250 BYTE),
    excodeid                       VARCHAR2(6 BYTE),
    pstatus                        VARCHAR2(4000 BYTE),
    rate                           VARCHAR2(20 BYTE),
    deltd                          CHAR(1 BYTE),
    trflimit                       CHAR(1 BYTE),
    parvalue                       FLOAT(64),
    roundtype                      VARCHAR2(2 BYTE),
    optsymbol                      VARCHAR2(50 BYTE),
    optcodeid                      VARCHAR2(50 BYTE),
    tradedate                      TIMESTAMP (6),
    lastdate                       TIMESTAMP (6),
    retailshare                    VARCHAR2(1 BYTE),
    retaildate                     TIMESTAMP (6),
    frdateretail                   TIMESTAMP (6),
    todateretail                   TIMESTAMP (6),
    frtradeplace                   VARCHAR2(3 BYTE),
    totradeplace                   VARCHAR2(3 BYTE),
    transfertimes                  VARCHAR2(1 BYTE),
    frdatetransfer                 TIMESTAMP (6),
    todatetransfer                 TIMESTAMP (6),
    taskcd                         VARCHAR2(10 BYTE),
    tocodeid                       VARCHAR2(10 BYTE),
    pitrate                        FLOAT(64),
    pitratemethod                  VARCHAR2(2 BYTE),
    iswft                          VARCHAR2(1 BYTE),
    priceaccounting                FLOAT(64),
    caqtty                         BINARY_DOUBLE,
    begindate                      TIMESTAMP (6),
    purposedesc                    VARCHAR2(250 BYTE),
    devidentvalue                  BINARY_DOUBLE,
    advdesc                        VARCHAR2(250 BYTE),
    typerate                       CHAR(1 BYTE),
    ciroundtype                    FLOAT(64),
    pitratese                      FLOAT(64),
    inactiondate                   TIMESTAMP (6),
    makerid                        VARCHAR2(4 BYTE),
    apprvid                        VARCHAR2(4 BYTE),
    exerate                        FLOAT(16),
    canceldate                     TIMESTAMP (6),
    receivedate                    TIMESTAMP (6),
    cancelstatus                   VARCHAR2(1 BYTE),
    isincode                       VARCHAR2(20 BYTE),
    refcorpid                      VARCHAR2(50 BYTE),
    lastchange                     TIMESTAMP (6) DEFAULT to_date('0001-01-01 00:00:00', 'YYYY-MM-DD hh24:mi:ss'))
  SEGMENT CREATION DEFERRED
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE caschd
/

CREATE TABLE caschd
    (autoid                         FLOAT(64) NOT NULL,
    camastid                       FLOAT(64),
    balance                        FLOAT(64),
    qtty                           FLOAT(64),
    amt                            FLOAT(64),
    aqtty                          FLOAT(64),
    aamt                           FLOAT(64),
    status                         VARCHAR2(1 BYTE),
    afacctno                       VARCHAR2(30 BYTE),
    codeid                         CHAR(6 BYTE),
    excodeid                       CHAR(6 BYTE),
    deltd                          CHAR(1 BYTE),
    pstatus                        VARCHAR2(4000 BYTE),
    refcamastid                    FLOAT(64),
    retailshare                    VARCHAR2(1 BYTE),
    deposit                        VARCHAR2(1 BYTE),
    reqtty                         FLOAT(64),
    reaqtty                        FLOAT(64),
    retailbal                      FLOAT(64),
    pbalance                       FLOAT(64),
    pqtty                          FLOAT(64),
    paamt                          FLOAT(64),
    corebank                       VARCHAR2(1 BYTE),
    iscise                         VARCHAR2(2 BYTE),
    dfqtty                         BINARY_DOUBLE,
    isci                           VARCHAR2(2 BYTE),
    isse                           VARCHAR2(2 BYTE),
    isro                           CHAR(1 BYTE),
    tqtty                          BINARY_DOUBLE,
    trade                          FLOAT(64),
    inbalance                      FLOAT(64),
    outbalance                     FLOAT(64),
    pitratemethod                  CHAR(2 BYTE),
    isexec                         CHAR(1 BYTE),
    nmqtty                         FLOAT(64),
    dfamt                          BINARY_DOUBLE,
    intamt                         FLOAT(64),
    rqtty                          BINARY_DOUBLE,
    roretailbal                    BINARY_DOUBLE,
    sendpbalance                   BINARY_DOUBLE,
    sendqtty                       BINARY_DOUBLE,
    sendaqtty                      BINARY_DOUBLE,
    sendamt                        BINARY_DOUBLE,
    isreceive                      VARCHAR2(1 BYTE),
    inqtty                         FLOAT(64),
    cutpbalance                    BINARY_DOUBLE,
    cutqtty                        BINARY_DOUBLE,
    cutaqtty                       BINARY_DOUBLE,
    cutamt                         BINARY_DOUBLE,
    pafacctno                      VARCHAR2(100 BYTE),
    orgpbalance                    BINARY_DOUBLE,
    custodycd                      VARCHAR2(20 BYTE))
  SEGMENT CREATION DEFERRED
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE catelogybank
/

CREATE TABLE catelogybank
    (autoid                         FLOAT(64) NOT NULL,
    mbcode                         VARCHAR2(20 BYTE),
    mbname                         VARCHAR2(500 BYTE),
    mbname_en                      VARCHAR2(500 BYTE),
    shortname                      VARCHAR2(20 BYTE),
    licenseno                      VARCHAR2(50 BYTE),
    licensedate                    TIMESTAMP (6),
    licenseplace                   VARCHAR2(500 BYTE),
    authcapital                    BINARY_DOUBLE,
    address                        VARCHAR2(500 BYTE),
    phone                          VARCHAR2(50 BYTE),
    fax                            VARCHAR2(50 BYTE),
    email                          VARCHAR2(50 BYTE),
    mbtype                         VARCHAR2(10 BYTE),
    bidcode                        VARCHAR2(50 BYTE),
    citadcode                      VARCHAR2(50 BYTE),
    legalperson                    VARCHAR2(100 BYTE),
    authperson                     VARCHAR2(100 BYTE),
    contactperson                  VARCHAR2(100 BYTE),
    note                           VARCHAR2(500 BYTE),
    status                         VARCHAR2(1 BYTE),
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6))
  SEGMENT CREATION DEFERRED
  NOPARALLEL
  NOLOGGING
  MONITORING
/

ALTER TABLE catelogybank
ADD CONSTRAINT catelogybank_pkey PRIMARY KEY (autoid)
USING INDEX
/

DROP TABLE catelogybankmemo
/

CREATE TABLE catelogybankmemo
    (autoid                         FLOAT(64) NOT NULL,
    mbcode                         VARCHAR2(20 BYTE),
    mbname                         VARCHAR2(500 BYTE),
    mbname_en                      VARCHAR2(500 BYTE),
    shortname                      VARCHAR2(20 BYTE),
    licenseno                      VARCHAR2(50 BYTE),
    licensedate                    TIMESTAMP (6),
    licenseplace                   VARCHAR2(500 BYTE),
    authcapital                    BINARY_DOUBLE,
    address                        VARCHAR2(500 BYTE),
    phone                          VARCHAR2(50 BYTE),
    fax                            VARCHAR2(50 BYTE),
    email                          VARCHAR2(50 BYTE),
    mbtype                         VARCHAR2(10 BYTE),
    bidcode                        VARCHAR2(50 BYTE),
    citadcode                      VARCHAR2(50 BYTE),
    legalperson                    VARCHAR2(100 BYTE),
    authperson                     VARCHAR2(100 BYTE),
    contactperson                  VARCHAR2(100 BYTE),
    note                           VARCHAR2(500 BYTE),
    status                         VARCHAR2(1 BYTE),
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6))
  SEGMENT CREATION DEFERRED
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE catran
/

CREATE TABLE catran
    (txnum                          VARCHAR2(200 BYTE),
    txdate                         TIMESTAMP (6),
    acctno                         VARCHAR2(20 BYTE),
    txcd                           VARCHAR2(4 BYTE),
    namt                           FLOAT(64),
    camt                           VARCHAR2(50 BYTE),
    ref                            VARCHAR2(20 BYTE),
    deltd                          VARCHAR2(1 BYTE),
    autoid                         BINARY_DOUBLE,
    tltxcd                         VARCHAR2(4 BYTE),
    bkdate                         TIMESTAMP (6),
    trdesc                         VARCHAR2(4000 BYTE))
  SEGMENT CREATION DEFERRED
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE catrana
/

CREATE TABLE catrana
    (txnum                          VARCHAR2(200 BYTE),
    txdate                         TIMESTAMP (6),
    acctno                         VARCHAR2(20 BYTE),
    txcd                           VARCHAR2(4 BYTE),
    namt                           FLOAT(64),
    camt                           VARCHAR2(50 BYTE),
    ref                            VARCHAR2(20 BYTE),
    deltd                          VARCHAR2(1 BYTE),
    autoid                         BINARY_DOUBLE,
    tltxcd                         VARCHAR2(4 BYTE),
    bkdate                         TIMESTAMP (6),
    trdesc                         VARCHAR2(4000 BYTE))
  SEGMENT CREATION DEFERRED
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE cfauth
/

CREATE TABLE cfauth
    (autoid                         FLOAT(64) NOT NULL,
    acctno                         VARCHAR2(40 BYTE),
    custid                         VARCHAR2(20 BYTE),
    custname                       VARCHAR2(200 BYTE),
    idcode                         VARCHAR2(20 BYTE),
    iddate                         TIMESTAMP (6),
    idplace                        VARCHAR2(100 BYTE),
    efdate                         TIMESTAMP (6),
    exdate                         TIMESTAMP (6),
    address                        VARCHAR2(500 BYTE),
    linkauth                       VARCHAR2(10 BYTE),
    signature                      VARCHAR2(4000 BYTE),
    status                         VARCHAR2(1 BYTE) DEFAULT 'P',
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6),
    position                       VARCHAR2(250 BYTE),
    sex                            VARCHAR2(5 BYTE),
    birthdate                      DATE,
    relationship                   VARCHAR2(250 BYTE),
    regaddress                     VARCHAR2(4000 BYTE),
    country                        VARCHAR2(10 BYTE),
    email                          VARCHAR2(250 BYTE),
    mobile                         VARCHAR2(100 BYTE),
    fax                            VARCHAR2(100 BYTE),
    idscan                         VARCHAR2(4000 BYTE),
    authtype                       VARCHAR2(10 BYTE),
    auth_all                       VARCHAR2(10 BYTE),
    auth_order                     VARCHAR2(10 BYTE),
    auth_cash                      VARCHAR2(10 BYTE),
    auth_infor                     VARCHAR2(10 BYTE),
    idscan2                        VARCHAR2(4000 BYTE),
    authscan                       VARCHAR2(4000 BYTE),
    othercountry                   VARCHAR2(100 BYTE),
    authcert                       VARCHAR2(100 BYTE),
    altphone                       VARCHAR2(100 BYTE),
    idtype                         VARCHAR2(20 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE cfauth_edit_temp
/

CREATE TABLE cfauth_edit_temp
    (autoid                         FLOAT(64),
    acctno                         VARCHAR2(40 BYTE),
    custid                         VARCHAR2(20 BYTE),
    custname                       VARCHAR2(200 BYTE),
    idcode                         VARCHAR2(20 BYTE),
    iddate                         TIMESTAMP (6),
    idplace                        VARCHAR2(100 BYTE),
    efdate                         TIMESTAMP (6),
    exdate                         TIMESTAMP (6),
    address                        VARCHAR2(500 BYTE),
    linkauth                       VARCHAR2(10 BYTE),
    signature                      VARCHAR2(4000 BYTE),
    status                         VARCHAR2(1 BYTE),
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6),
    position                       VARCHAR2(250 BYTE),
    sex                            VARCHAR2(50 BYTE),
    birthdate                      DATE,
    relationship                   VARCHAR2(250 BYTE),
    regaddress                     VARCHAR2(4000 BYTE),
    country                        VARCHAR2(10 BYTE),
    email                          VARCHAR2(250 BYTE),
    mobile                         VARCHAR2(100 BYTE),
    fax                            VARCHAR2(100 BYTE),
    idscan                         VARCHAR2(4000 BYTE),
    authtype                       VARCHAR2(10 BYTE),
    auth_all                       VARCHAR2(10 BYTE),
    auth_order                     VARCHAR2(10 BYTE),
    auth_cash                      VARCHAR2(10 BYTE),
    auth_infor                     VARCHAR2(10 BYTE),
    isotp                          VARCHAR2(50 BYTE),
    idscan2                        VARCHAR2(4000 BYTE),
    authscan                       VARCHAR2(4000 BYTE),
    othercountry                   VARCHAR2(100 BYTE),
    authcert                       VARCHAR2(100 BYTE),
    altphone                       VARCHAR2(100 BYTE),
    idtype                         VARCHAR2(20 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE cfauth_edit_temp_hist
/

CREATE TABLE cfauth_edit_temp_hist
    (autoid                         FLOAT(64),
    acctno                         VARCHAR2(40 BYTE),
    custid                         VARCHAR2(20 BYTE),
    custname                       VARCHAR2(200 BYTE),
    idcode                         VARCHAR2(20 BYTE),
    iddate                         TIMESTAMP (6),
    idplace                        VARCHAR2(100 BYTE),
    efdate                         TIMESTAMP (6),
    exdate                         TIMESTAMP (6),
    address                        VARCHAR2(500 BYTE),
    linkauth                       VARCHAR2(10 BYTE),
    signature                      VARCHAR2(4000 BYTE),
    status                         VARCHAR2(1 BYTE),
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6),
    position                       VARCHAR2(250 BYTE),
    sex                            VARCHAR2(50 BYTE),
    birthdate                      DATE,
    relationship                   VARCHAR2(250 BYTE),
    regaddress                     VARCHAR2(4000 BYTE),
    country                        VARCHAR2(10 BYTE),
    email                          VARCHAR2(250 BYTE),
    mobile                         VARCHAR2(100 BYTE),
    fax                            VARCHAR2(100 BYTE),
    idscan                         VARCHAR2(4000 BYTE),
    authtype                       VARCHAR2(10 BYTE),
    auth_all                       VARCHAR2(10 BYTE),
    auth_order                     VARCHAR2(10 BYTE),
    auth_cash                      VARCHAR2(10 BYTE),
    auth_infor                     VARCHAR2(10 BYTE),
    isotp                          VARCHAR2(50 BYTE),
    idscan2                        VARCHAR2(4000 BYTE),
    authscan                       VARCHAR2(4000 BYTE),
    othercountry                   VARCHAR2(100 BYTE),
    authcert                       VARCHAR2(100 BYTE),
    altphone                       VARCHAR2(100 BYTE),
    idtype                         VARCHAR2(20 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE cfauth_temp
/

CREATE TABLE cfauth_temp
    (autoid                         FLOAT(64),
    acctno                         VARCHAR2(40 BYTE),
    custid                         VARCHAR2(20 BYTE),
    custname                       VARCHAR2(200 BYTE),
    idcode                         VARCHAR2(20 BYTE),
    iddate                         TIMESTAMP (6),
    idplace                        VARCHAR2(100 BYTE),
    efdate                         TIMESTAMP (6),
    exdate                         TIMESTAMP (6),
    address                        VARCHAR2(500 BYTE),
    linkauth                       VARCHAR2(10 BYTE),
    signature                      VARCHAR2(4000 BYTE),
    status                         VARCHAR2(1 BYTE),
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6),
    position                       VARCHAR2(250 BYTE),
    sex                            VARCHAR2(5 BYTE),
    birthdate                      DATE,
    relationship                   VARCHAR2(250 BYTE),
    regaddress                     VARCHAR2(4000 BYTE),
    country                        VARCHAR2(10 BYTE),
    email                          VARCHAR2(250 BYTE),
    mobile                         VARCHAR2(100 BYTE),
    fax                            VARCHAR2(100 BYTE),
    idscan                         VARCHAR2(4000 BYTE),
    authtype                       VARCHAR2(10 BYTE),
    auth_all                       VARCHAR2(10 BYTE),
    auth_order                     VARCHAR2(10 BYTE),
    auth_cash                      VARCHAR2(10 BYTE),
    auth_infor                     VARCHAR2(10 BYTE),
    isotp                          VARCHAR2(5 BYTE),
    idscan2                        VARCHAR2(4000 BYTE),
    authscan                       VARCHAR2(4000 BYTE),
    othercountry                   VARCHAR2(100 BYTE),
    authcert                       VARCHAR2(100 BYTE),
    altphone                       VARCHAR2(100 BYTE),
    idtype                         VARCHAR2(20 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE cfauth_temp_hist
/

CREATE TABLE cfauth_temp_hist
    (autoid                         FLOAT(64),
    acctno                         VARCHAR2(40 BYTE),
    custid                         VARCHAR2(20 BYTE),
    custname                       VARCHAR2(200 BYTE),
    idcode                         VARCHAR2(20 BYTE),
    iddate                         TIMESTAMP (6),
    idplace                        VARCHAR2(100 BYTE),
    efdate                         TIMESTAMP (6),
    exdate                         TIMESTAMP (6),
    address                        VARCHAR2(500 BYTE),
    linkauth                       VARCHAR2(10 BYTE),
    signature                      VARCHAR2(4000 BYTE),
    status                         VARCHAR2(1 BYTE),
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6),
    position                       VARCHAR2(250 BYTE),
    sex                            VARCHAR2(5 BYTE),
    birthdate                      DATE,
    relationship                   VARCHAR2(250 BYTE),
    regaddress                     VARCHAR2(4000 BYTE),
    country                        VARCHAR2(10 BYTE),
    email                          VARCHAR2(250 BYTE),
    mobile                         VARCHAR2(100 BYTE),
    fax                            VARCHAR2(100 BYTE),
    idscan                         VARCHAR2(4000 BYTE),
    authtype                       VARCHAR2(10 BYTE),
    auth_all                       VARCHAR2(10 BYTE),
    auth_order                     VARCHAR2(10 BYTE),
    auth_cash                      VARCHAR2(10 BYTE),
    auth_infor                     VARCHAR2(10 BYTE),
    isotp                          VARCHAR2(5 BYTE),
    idscan2                        VARCHAR2(4000 BYTE),
    authscan                       VARCHAR2(4000 BYTE),
    othercountry                   VARCHAR2(100 BYTE),
    authcert                       VARCHAR2(100 BYTE),
    altphone                       VARCHAR2(100 BYTE),
    idtype                         VARCHAR2(20 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE cfauthcv
/

CREATE TABLE cfauthcv
    (acctno                         VARCHAR2(40 BYTE),
    custname                       VARCHAR2(200 BYTE),
    idcode                         VARCHAR2(20 BYTE),
    iddate                         TIMESTAMP (6),
    idplace                        VARCHAR2(100 BYTE),
    exdate                         TIMESTAMP (6),
    address                        VARCHAR2(500 BYTE),
    linkauth                       VARCHAR2(10 BYTE))
  SEGMENT CREATION DEFERRED
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE cfauthmemo
/

CREATE TABLE cfauthmemo
    (autoid                         FLOAT(64) NOT NULL,
    acctno                         VARCHAR2(40 BYTE),
    custid                         VARCHAR2(20 BYTE),
    custname                       VARCHAR2(200 BYTE),
    idcode                         VARCHAR2(20 BYTE),
    iddate                         TIMESTAMP (6),
    idplace                        VARCHAR2(100 BYTE),
    efdate                         TIMESTAMP (6),
    exdate                         TIMESTAMP (6),
    address                        VARCHAR2(500 BYTE),
    linkauth                       VARCHAR2(10 BYTE),
    signature                      VARCHAR2(4000 BYTE),
    status                         VARCHAR2(1 BYTE) DEFAULT 'P',
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6),
    position                       VARCHAR2(250 BYTE),
    sex                            VARCHAR2(50 BYTE),
    birthdate                      DATE,
    relationship                   VARCHAR2(250 BYTE),
    regaddress                     VARCHAR2(4000 BYTE),
    country                        VARCHAR2(10 BYTE),
    email                          VARCHAR2(250 BYTE),
    mobile                         VARCHAR2(100 BYTE),
    fax                            VARCHAR2(100 BYTE),
    idscan                         VARCHAR2(4000 BYTE),
    authtype                       VARCHAR2(10 BYTE),
    auth_all                       VARCHAR2(10 BYTE),
    auth_order                     VARCHAR2(10 BYTE),
    auth_cash                      VARCHAR2(10 BYTE),
    auth_infor                     VARCHAR2(10 BYTE),
    idscan2                        VARCHAR2(4000 BYTE),
    authscan                       VARCHAR2(4000 BYTE),
    othercountry                   VARCHAR2(100 BYTE),
    authcert                       VARCHAR2(100 BYTE),
    altphone                       VARCHAR2(100 BYTE),
    idtype                         VARCHAR2(20 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE cfcontact
/

CREATE TABLE cfcontact
    (autoid                         NUMBER(*,0) NOT NULL,
    custid                         VARCHAR2(20 BYTE),
    fullname                       VARCHAR2(200 BYTE),
    position                       VARCHAR2(250 BYTE),
    birthdate                      DATE,
    sex                            VARCHAR2(5 BYTE),
    relationship                   VARCHAR2(250 BYTE),
    regaddress                     VARCHAR2(1000 BYTE),
    address                        VARCHAR2(500 BYTE),
    idcode                         VARCHAR2(20 BYTE),
    iddate                         TIMESTAMP (6),
    idplace                        VARCHAR2(100 BYTE),
    email                          VARCHAR2(250 BYTE),
    mobile                         VARCHAR2(100 BYTE),
    status                         VARCHAR2(1 BYTE),
    pstatus                        VARCHAR2(100 BYTE),
    lastchange                     TIMESTAMP (6),
    country                        VARCHAR2(5 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

ALTER TABLE cfcontact
ADD CONSTRAINT cfcontact_pkey PRIMARY KEY (autoid)
USING INDEX
/

DROP TABLE cfcontact_edit_temp
/

CREATE TABLE cfcontact_edit_temp
    (autoid                         FLOAT(64),
    custid                         VARCHAR2(20 BYTE),
    fullname                       VARCHAR2(200 BYTE),
    position                       VARCHAR2(250 BYTE),
    birthdate                      DATE,
    sex                            VARCHAR2(5 BYTE),
    relationship                   VARCHAR2(250 BYTE),
    regaddress                     VARCHAR2(4000 BYTE),
    address                        VARCHAR2(500 BYTE),
    idcode                         VARCHAR2(20 BYTE),
    iddate                         TIMESTAMP (6),
    idplace                        VARCHAR2(100 BYTE),
    email                          VARCHAR2(250 BYTE),
    mobile                         VARCHAR2(100 BYTE),
    isotp                          VARCHAR2(5 BYTE),
    status                         VARCHAR2(1 BYTE),
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6),
    country                        VARCHAR2(5 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE cfcontact_edit_temp_hist
/

CREATE TABLE cfcontact_edit_temp_hist
    (autoid                         FLOAT(64),
    custid                         VARCHAR2(20 BYTE),
    fullname                       VARCHAR2(200 BYTE),
    position                       VARCHAR2(250 BYTE),
    birthdate                      DATE,
    sex                            VARCHAR2(5 BYTE),
    relationship                   VARCHAR2(250 BYTE),
    regaddress                     VARCHAR2(4000 BYTE),
    address                        VARCHAR2(500 BYTE),
    idcode                         VARCHAR2(20 BYTE),
    iddate                         TIMESTAMP (6),
    idplace                        VARCHAR2(100 BYTE),
    email                          VARCHAR2(250 BYTE),
    mobile                         VARCHAR2(100 BYTE),
    isotp                          VARCHAR2(5 BYTE),
    status                         VARCHAR2(1 BYTE),
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6),
    country                        VARCHAR2(5 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE cfcontact_temp
/

CREATE TABLE cfcontact_temp
    (autoid                         FLOAT(64) NOT NULL,
    custid                         VARCHAR2(20 BYTE),
    fullname                       VARCHAR2(200 BYTE),
    position                       VARCHAR2(250 BYTE),
    birthdate                      DATE,
    sex                            VARCHAR2(5 BYTE),
    relationship                   VARCHAR2(250 BYTE),
    regaddress                     VARCHAR2(4000 BYTE),
    address                        VARCHAR2(500 BYTE),
    idcode                         VARCHAR2(20 BYTE),
    iddate                         TIMESTAMP (6),
    idplace                        VARCHAR2(100 BYTE),
    email                          VARCHAR2(250 BYTE),
    mobile                         VARCHAR2(100 BYTE),
    isotp                          VARCHAR2(5 BYTE),
    status                         VARCHAR2(1 BYTE) DEFAULT 'P',
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6),
    country                        VARCHAR2(5 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE cfcontact_temp_hist
/

CREATE TABLE cfcontact_temp_hist
    (autoid                         FLOAT(64),
    custid                         VARCHAR2(20 BYTE),
    fullname                       VARCHAR2(200 BYTE),
    position                       VARCHAR2(250 BYTE),
    birthdate                      DATE,
    sex                            VARCHAR2(5 BYTE),
    relationship                   VARCHAR2(250 BYTE),
    regaddress                     VARCHAR2(4000 BYTE),
    address                        VARCHAR2(500 BYTE),
    idcode                         VARCHAR2(20 BYTE),
    iddate                         TIMESTAMP (6),
    idplace                        VARCHAR2(100 BYTE),
    email                          VARCHAR2(250 BYTE),
    mobile                         VARCHAR2(100 BYTE),
    isotp                          VARCHAR2(5 BYTE),
    status                         VARCHAR2(1 BYTE),
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6),
    country                        VARCHAR2(5 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE cfcontactmemo
/

CREATE TABLE cfcontactmemo
    (autoid                         FLOAT(64) NOT NULL,
    custid                         VARCHAR2(20 BYTE),
    fullname                       VARCHAR2(200 BYTE),
    position                       VARCHAR2(250 BYTE),
    birthdate                      DATE,
    sex                            VARCHAR2(5 BYTE),
    relationship                   VARCHAR2(250 BYTE),
    regaddress                     VARCHAR2(4000 BYTE),
    address                        VARCHAR2(500 BYTE),
    idcode                         VARCHAR2(20 BYTE),
    iddate                         TIMESTAMP (6),
    idplace                        VARCHAR2(100 BYTE),
    email                          VARCHAR2(250 BYTE),
    mobile                         VARCHAR2(100 BYTE),
    status                         VARCHAR2(1 BYTE) DEFAULT 'P',
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6),
    country                        VARCHAR2(5 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE cfmast
/

CREATE TABLE cfmast
    (custid                         VARCHAR2(40 BYTE),
    custodycd                      VARCHAR2(10 BYTE),
    sid                            VARCHAR2(20 BYTE) NOT NULL,
    firstname                      VARCHAR2(200 BYTE),
    middlename                     VARCHAR2(200 BYTE),
    lastname                       VARCHAR2(50 BYTE),
    fullname                       VARCHAR2(500 BYTE),
    acctype                        VARCHAR2(10 BYTE),
    custtype                       VARCHAR2(10 BYTE),
    grinvestor                     VARCHAR2(10 BYTE),
    sex                            VARCHAR2(3 BYTE),
    idtype                         VARCHAR2(50 BYTE),
    idcode                         VARCHAR2(50 BYTE),
    idplace                        VARCHAR2(500 BYTE),
    tradingcode                    VARCHAR2(50 BYTE),
    taxno                          VARCHAR2(50 BYTE),
    regaddress                     VARCHAR2(500 BYTE),
    address                        VARCHAR2(500 BYTE),
    country                        VARCHAR2(3 BYTE),
    province                       VARCHAR2(3 BYTE),
    phone                          VARCHAR2(50 BYTE),
    mobile                         VARCHAR2(50 BYTE),
    email                          VARCHAR2(50 BYTE),
    dbcode                         VARCHAR2(4 BYTE),
    status                         VARCHAR2(1 BYTE) DEFAULT 'P',
    pstatus                        VARCHAR2(500 BYTE),
    bankacc                        VARCHAR2(20 BYTE),
    bankcode                       VARCHAR2(20 BYTE),
    citybank                       VARCHAR2(500 BYTE),
    bankacname                     VARCHAR2(500 BYTE),
    shortname                      VARCHAR2(100 BYTE),
    refname1                       VARCHAR2(500 BYTE),
    refmobile1                     VARCHAR2(100 BYTE),
    refname2                       VARCHAR2(500 BYTE),
    refmobile2                     VARCHAR2(100 BYTE),
    refpost1                       VARCHAR2(100 BYTE),
    refpost2                       VARCHAR2(100 BYTE),
    brid                           VARCHAR2(4 BYTE),
    fax                            VARCHAR2(30 BYTE),
    incomeyear                     VARCHAR2(30 BYTE),
    isauth                         VARCHAR2(3 BYTE),
    rcv_email                      VARCHAR2(3 BYTE),
    rcv_sms                        VARCHAR2(3 BYTE),
    careby                         VARCHAR2(20 BYTE),
    rcv_mail                       VARCHAR2(5 BYTE),
    isapprv                        VARCHAR2(5 BYTE),
    opnid                          VARCHAR2(20 BYTE),
    last_mkid                      VARCHAR2(20 BYTE),
    last_ofid                      VARCHAR2(20 BYTE),
    vsdstatus                      VARCHAR2(3 BYTE) DEFAULT 'P',
    classcd                        VARCHAR2(10 BYTE) DEFAULT '000',
    acctgrp                        VARCHAR2(5 BYTE) DEFAULT 'N',
    investtype                     VARCHAR2(5 BYTE),
    username                       VARCHAR2(100 BYTE),
    classsipcd                     VARCHAR2(5 BYTE) DEFAULT '000',
    iscflead                       VARCHAR2(3 BYTE) DEFAULT 'P',
    isonline                       VARCHAR2(3 BYTE) DEFAULT 'N',
    openvia                        VARCHAR2(6 BYTE),
    iscontact                      VARCHAR2(1 BYTE) DEFAULT 'N',
    lastadd_tmpid                  VARCHAR2(1000 BYTE),
    lastedit_tmpid                 VARCHAR2(1000 BYTE),
    isfatca                        VARCHAR2(1 BYTE) DEFAULT 'N',
    othercountry                   VARCHAR2(50 BYTE),
    passport                       VARCHAR2(50 BYTE),
    passportplace                  VARCHAR2(50 BYTE),
    taxplace                       VARCHAR2(50 BYTE),
    ispep                          VARCHAR2(1 BYTE) DEFAULT 'N',
    familyname1                    VARCHAR2(50 BYTE),
    familyname2                    VARCHAR2(50 BYTE),
    name1                          VARCHAR2(50 BYTE),
    name2                          VARCHAR2(50 BYTE),
    saleid                         VARCHAR2(50 BYTE),
    passportdate                   VARCHAR2(50 BYTE),
    lrcountry                      VARCHAR2(3 BYTE),
    lrposition                     VARCHAR2(50 BYTE),
    lrdecisionno                   VARCHAR2(50 BYTE),
    lrid                           VARCHAR2(50 BYTE),
    lriddate                       VARCHAR2(50 BYTE),
    lridplace                      VARCHAR2(50 BYTE),
    lraddress                      VARCHAR2(100 BYTE),
    lrcontact                      VARCHAR2(100 BYTE),
    lrpriphone                     VARCHAR2(50 BYTE),
    lraltphone                     VARCHAR2(50 BYTE),
    lrfax                          VARCHAR2(50 BYTE),
    lremail                        VARCHAR2(50 BYTE),
    isrepresentative               VARCHAR2(1 BYTE) DEFAULT 'N',
    lrname                         VARCHAR2(50 BYTE),
    lrsex                          VARCHAR2(3 BYTE),
    lrdob                          VARCHAR2(50 BYTE),
    cfstatus                       VARCHAR2(1 BYTE) DEFAULT 'P',
    job                            VARCHAR2(200 BYTE),
    workunit                       VARCHAR2(200 BYTE),
    mobilegt                       VARCHAR2(200 BYTE),
    tlidgt                         VARCHAR2(200 BYTE),
    cftype                         VARCHAR2(10 BYTE),
    iddate                         DATE,
    idexpdated                     DATE,
    tradingdate                    DATE,
    lastchange                     DATE,
    birthdate                      DATE,
    opndate                        DATE,
    cfclsdate                      DATE,
    cif                            VARCHAR2(200 BYTE),
    isprofession                   VARCHAR2(20 BYTE),
    fullnameaccented               VARCHAR2(500 BYTE),
    isexists                       VARCHAR2(20 BYTE),
    professiontodate               VARCHAR2(20 BYTE),
    professionfrdate               VARCHAR2(20 BYTE),
    seaccount                      VARCHAR2(500 BYTE),
    ciaccount                      VARCHAR2(500 BYTE),
    secif                          VARCHAR2(500 BYTE),
    lridtyper                      VARCHAR2(20 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE cfmast_cif
/

CREATE TABLE cfmast_cif
    (custid                         VARCHAR2(40 BYTE),
    custodycd                      VARCHAR2(10 BYTE),
    sid                            VARCHAR2(20 BYTE),
    firstname                      VARCHAR2(200 BYTE),
    middlename                     VARCHAR2(200 BYTE),
    lastname                       VARCHAR2(50 BYTE),
    fullname                       VARCHAR2(500 BYTE),
    acctype                        VARCHAR2(10 BYTE),
    custtype                       VARCHAR2(10 BYTE),
    grinvestor                     VARCHAR2(10 BYTE),
    sex                            VARCHAR2(3 BYTE),
    idtype                         VARCHAR2(50 BYTE),
    idcode                         VARCHAR2(50 BYTE),
    idplace                        VARCHAR2(500 BYTE),
    tradingcode                    VARCHAR2(50 BYTE),
    taxno                          VARCHAR2(50 BYTE),
    regaddress                     VARCHAR2(500 BYTE),
    address                        VARCHAR2(500 BYTE),
    country                        VARCHAR2(3 BYTE),
    province                       VARCHAR2(3 BYTE),
    phone                          VARCHAR2(50 BYTE),
    mobile                         VARCHAR2(50 BYTE),
    email                          VARCHAR2(50 BYTE),
    dbcode                         VARCHAR2(4 BYTE),
    status                         VARCHAR2(1 BYTE) DEFAULT 'P',
    pstatus                        VARCHAR2(500 BYTE),
    bankacc                        VARCHAR2(20 BYTE),
    bankcode                       VARCHAR2(20 BYTE),
    citybank                       VARCHAR2(500 BYTE),
    bankacname                     VARCHAR2(500 BYTE),
    shortname                      VARCHAR2(100 BYTE),
    refname1                       VARCHAR2(500 BYTE),
    refmobile1                     VARCHAR2(100 BYTE),
    refname2                       VARCHAR2(500 BYTE),
    refmobile2                     VARCHAR2(100 BYTE),
    refpost1                       VARCHAR2(100 BYTE),
    refpost2                       VARCHAR2(100 BYTE),
    brid                           VARCHAR2(4 BYTE),
    fax                            VARCHAR2(30 BYTE),
    incomeyear                     VARCHAR2(30 BYTE),
    isauth                         VARCHAR2(3 BYTE) DEFAULT 'N',
    rcv_email                      VARCHAR2(3 BYTE),
    rcv_sms                        VARCHAR2(3 BYTE),
    careby                         VARCHAR2(20 BYTE),
    rcv_mail                       VARCHAR2(5 BYTE),
    isapprv                        VARCHAR2(5 BYTE),
    opnid                          VARCHAR2(20 BYTE),
    last_mkid                      VARCHAR2(20 BYTE),
    last_ofid                      VARCHAR2(20 BYTE),
    vsdstatus                      VARCHAR2(3 BYTE) DEFAULT 'P',
    classcd                        VARCHAR2(10 BYTE) DEFAULT '000',
    acctgrp                        VARCHAR2(5 BYTE) DEFAULT 'N',
    investtype                     VARCHAR2(5 BYTE),
    username                       VARCHAR2(100 BYTE),
    classsipcd                     VARCHAR2(5 BYTE) DEFAULT '000',
    iscflead                       VARCHAR2(3 BYTE) DEFAULT 'P',
    isonline                       VARCHAR2(3 BYTE) DEFAULT 'Y',
    openvia                        VARCHAR2(6 BYTE),
    iscontact                      VARCHAR2(1 BYTE) DEFAULT 'N',
    lastadd_tmpid                  VARCHAR2(1000 BYTE),
    lastedit_tmpid                 VARCHAR2(1000 BYTE),
    isfatca                        VARCHAR2(1 BYTE) DEFAULT 'N',
    othercountry                   VARCHAR2(50 BYTE),
    passport                       VARCHAR2(50 BYTE),
    passportplace                  VARCHAR2(50 BYTE),
    taxplace                       VARCHAR2(50 BYTE),
    ispep                          VARCHAR2(1 BYTE) DEFAULT 'N',
    familyname1                    VARCHAR2(50 BYTE),
    familyname2                    VARCHAR2(50 BYTE),
    name1                          VARCHAR2(50 BYTE),
    name2                          VARCHAR2(50 BYTE),
    saleid                         VARCHAR2(50 BYTE),
    passportdate                   VARCHAR2(50 BYTE),
    lrcountry                      VARCHAR2(3 BYTE),
    lrposition                     VARCHAR2(50 BYTE),
    lrdecisionno                   VARCHAR2(50 BYTE),
    lrid                           VARCHAR2(50 BYTE),
    lriddate                       VARCHAR2(50 BYTE),
    lridplace                      VARCHAR2(50 BYTE),
    lraddress                      VARCHAR2(100 BYTE),
    lrcontact                      VARCHAR2(100 BYTE),
    lrpriphone                     VARCHAR2(50 BYTE),
    lraltphone                     VARCHAR2(50 BYTE),
    lrfax                          VARCHAR2(50 BYTE),
    lremail                        VARCHAR2(50 BYTE),
    isrepresentative               VARCHAR2(1 BYTE) DEFAULT 'N',
    lrname                         VARCHAR2(50 BYTE),
    lrsex                          VARCHAR2(3 BYTE),
    lrdob                          VARCHAR2(50 BYTE),
    cfstatus                       VARCHAR2(1 BYTE) DEFAULT 'P',
    job                            VARCHAR2(200 BYTE),
    workunit                       VARCHAR2(200 BYTE),
    mobilegt                       VARCHAR2(200 BYTE),
    tlidgt                         VARCHAR2(200 BYTE),
    cftype                         VARCHAR2(10 BYTE),
    iddate                         DATE,
    idexpdated                     DATE,
    tradingdate                    DATE,
    lastchange                     DATE,
    birthdate                      DATE,
    opndate                        DATE,
    cfclsdate                      DATE,
    isprofession                   VARCHAR2(20 BYTE),
    lridtyper                      VARCHAR2(20 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE cfmast_edit_temp
/

CREATE TABLE cfmast_edit_temp
    (custid                         VARCHAR2(40 BYTE),
    custodycd                      VARCHAR2(10 BYTE),
    sid                            VARCHAR2(20 BYTE),
    firstname                      VARCHAR2(200 BYTE),
    middlename                     VARCHAR2(50 BYTE),
    lastname                       VARCHAR2(50 BYTE),
    fullname                       VARCHAR2(500 BYTE),
    acctype                        VARCHAR2(10 BYTE),
    custtype                       VARCHAR2(10 BYTE),
    grinvestor                     VARCHAR2(10 BYTE),
    sex                            VARCHAR2(3 BYTE),
    birthdate                      TIMESTAMP (6),
    idtype                         VARCHAR2(50 BYTE),
    idcode                         VARCHAR2(50 BYTE),
    iddate                         TIMESTAMP (6),
    idexpdated                     TIMESTAMP (6),
    idplace                        VARCHAR2(500 BYTE),
    tradingcode                    VARCHAR2(50 BYTE),
    tradingdate                    TIMESTAMP (6),
    taxno                          VARCHAR2(50 BYTE),
    regaddress                     VARCHAR2(500 BYTE),
    address                        VARCHAR2(500 BYTE),
    country                        VARCHAR2(3 BYTE),
    province                       VARCHAR2(3 BYTE),
    phone                          VARCHAR2(50 BYTE),
    mobile                         VARCHAR2(50 BYTE),
    email                          VARCHAR2(50 BYTE),
    dbcode                         VARCHAR2(4 BYTE),
    status                         VARCHAR2(1 BYTE),
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6),
    bankacc                        VARCHAR2(20 BYTE),
    bankcode                       VARCHAR2(20 BYTE),
    citybank                       VARCHAR2(500 BYTE),
    bankacname                     VARCHAR2(500 BYTE),
    shortname                      VARCHAR2(100 BYTE),
    refname1                       VARCHAR2(500 BYTE),
    refmobile1                     VARCHAR2(100 BYTE),
    refname2                       VARCHAR2(500 BYTE),
    refmobile2                     VARCHAR2(100 BYTE),
    refpost1                       VARCHAR2(100 BYTE),
    refpost2                       VARCHAR2(100 BYTE),
    brid                           VARCHAR2(4 BYTE),
    fax                            VARCHAR2(30 BYTE),
    incomeyear                     VARCHAR2(30 BYTE),
    isauth                         VARCHAR2(3 BYTE),
    rcv_email                      VARCHAR2(3 BYTE),
    rcv_sms                        VARCHAR2(3 BYTE),
    sign_img                       VARCHAR2(4000 BYTE),
    ownlicense_img                 VARCHAR2(4000 BYTE),
    isotp                          VARCHAR2(3 BYTE),
    careby                         VARCHAR2(20 BYTE),
    rcv_mail                       VARCHAR2(5 BYTE),
    isapprv                        VARCHAR2(5 BYTE),
    cfclsdate                      DATE,
    last_mkid                      VARCHAR2(20 BYTE),
    last_ofid                      VARCHAR2(20 BYTE),
    vsdstatus                      VARCHAR2(3 BYTE),
    acctgrp                        VARCHAR2(5 BYTE),
    investtype                     VARCHAR2(5 BYTE),
    classsipcd                     VARCHAR2(5 BYTE),
    ownlicense2_img                VARCHAR2(4000 BYTE),
    ownlicense3_img                VARCHAR2(4000 BYTE),
    ownlicense4_img                VARCHAR2(4000 BYTE),
    isonline                       VARCHAR2(3 BYTE),
    editdate                       DATE,
    editid                         VARCHAR2(20 BYTE),
    iscontact                      VARCHAR2(1 BYTE),
    autoid                         VARCHAR2(4000 BYTE),
    isfatca                        CHAR(1 BYTE) DEFAULT 'N',
    othercountry                   VARCHAR2(50 BYTE),
    passport                       VARCHAR2(50 BYTE),
    passportplace                  VARCHAR2(50 BYTE),
    taxplace                       VARCHAR2(50 BYTE),
    ispep                          VARCHAR2(1 BYTE),
    familyname1                    VARCHAR2(50 BYTE),
    familyname2                    VARCHAR2(50 BYTE),
    name1                          VARCHAR2(50 BYTE),
    name2                          VARCHAR2(50 BYTE),
    saleid                         VARCHAR2(50 BYTE),
    passportdate                   VARCHAR2(50 BYTE),
    lrcountry                      VARCHAR2(3 BYTE),
    lrposition                     VARCHAR2(50 BYTE),
    lrdecisionno                   VARCHAR2(50 BYTE),
    lrid                           VARCHAR2(50 BYTE),
    lriddate                       VARCHAR2(50 BYTE),
    lridplace                      VARCHAR2(50 BYTE),
    lraddress                      VARCHAR2(100 BYTE),
    lrcontact                      VARCHAR2(100 BYTE),
    lrpriphone                     VARCHAR2(50 BYTE),
    lraltphone                     VARCHAR2(50 BYTE),
    lrfax                          VARCHAR2(50 BYTE),
    lremail                        VARCHAR2(50 BYTE),
    isrepresentative               VARCHAR2(1 BYTE),
    lrname                         VARCHAR2(50 BYTE),
    lrsex                          VARCHAR2(3 BYTE),
    lrdob                          VARCHAR2(50 BYTE),
    job                            VARCHAR2(200 BYTE),
    workunit                       VARCHAR2(200 BYTE),
    tlidgt                         VARCHAR2(200 BYTE),
    mobilegt                       VARCHAR2(200 BYTE),
    cftype                         VARCHAR2(10 BYTE),
    isprofession                   VARCHAR2(20 BYTE),
    fullnameaccented               VARCHAR2(500 BYTE),
    isexists                       VARCHAR2(20 BYTE),
    professiontodate               VARCHAR2(20 BYTE),
    professionfrdate               VARCHAR2(20 BYTE),
    seaccount                      VARCHAR2(500 BYTE),
    ciaccount                      VARCHAR2(500 BYTE),
    secif                          VARCHAR2(500 BYTE),
    lridtyper                      VARCHAR2(20 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE cfmast_edit_temp_hist
/

CREATE TABLE cfmast_edit_temp_hist
    (custid                         VARCHAR2(40 BYTE),
    custodycd                      VARCHAR2(10 BYTE),
    sid                            VARCHAR2(20 BYTE),
    firstname                      VARCHAR2(200 BYTE),
    middlename                     VARCHAR2(50 BYTE),
    lastname                       VARCHAR2(50 BYTE),
    fullname                       VARCHAR2(500 BYTE),
    acctype                        VARCHAR2(10 BYTE),
    custtype                       VARCHAR2(10 BYTE),
    grinvestor                     VARCHAR2(10 BYTE),
    sex                            VARCHAR2(3 BYTE),
    birthdate                      TIMESTAMP (6),
    idtype                         VARCHAR2(50 BYTE),
    idcode                         VARCHAR2(50 BYTE),
    iddate                         TIMESTAMP (6),
    idexpdated                     TIMESTAMP (6),
    idplace                        VARCHAR2(500 BYTE),
    tradingcode                    VARCHAR2(50 BYTE),
    tradingdate                    TIMESTAMP (6),
    taxno                          VARCHAR2(50 BYTE),
    regaddress                     VARCHAR2(500 BYTE),
    address                        VARCHAR2(500 BYTE),
    country                        VARCHAR2(3 BYTE),
    province                       VARCHAR2(3 BYTE),
    phone                          VARCHAR2(50 BYTE),
    mobile                         VARCHAR2(50 BYTE),
    email                          VARCHAR2(50 BYTE),
    dbcode                         VARCHAR2(4 BYTE),
    status                         VARCHAR2(1 BYTE),
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6),
    bankacc                        VARCHAR2(20 BYTE),
    bankcode                       VARCHAR2(20 BYTE),
    citybank                       VARCHAR2(500 BYTE),
    bankacname                     VARCHAR2(500 BYTE),
    shortname                      VARCHAR2(100 BYTE),
    refname1                       VARCHAR2(500 BYTE),
    refmobile1                     VARCHAR2(100 BYTE),
    refname2                       VARCHAR2(500 BYTE),
    refmobile2                     VARCHAR2(100 BYTE),
    refpost1                       VARCHAR2(100 BYTE),
    refpost2                       VARCHAR2(100 BYTE),
    brid                           VARCHAR2(4 BYTE),
    fax                            VARCHAR2(30 BYTE),
    incomeyear                     VARCHAR2(30 BYTE),
    isauth                         VARCHAR2(3 BYTE),
    rcv_email                      VARCHAR2(3 BYTE),
    rcv_sms                        VARCHAR2(3 BYTE),
    sign_img                       VARCHAR2(4000 BYTE),
    ownlicense_img                 VARCHAR2(4000 BYTE),
    isotp                          VARCHAR2(3 BYTE),
    careby                         VARCHAR2(20 BYTE),
    rcv_mail                       VARCHAR2(5 BYTE),
    isapprv                        VARCHAR2(5 BYTE),
    cfclsdate                      DATE,
    last_mkid                      VARCHAR2(20 BYTE),
    last_ofid                      VARCHAR2(20 BYTE),
    vsdstatus                      VARCHAR2(3 BYTE),
    acctgrp                        VARCHAR2(5 BYTE),
    investtype                     VARCHAR2(5 BYTE),
    classsipcd                     VARCHAR2(5 BYTE),
    ownlicense2_img                VARCHAR2(4000 BYTE),
    ownlicense3_img                VARCHAR2(4000 BYTE),
    ownlicense4_img                VARCHAR2(4000 BYTE),
    isonline                       VARCHAR2(3 BYTE),
    editdate                       DATE,
    editid                         VARCHAR2(20 BYTE),
    iscontact                      VARCHAR2(1 BYTE),
    autoid                         VARCHAR2(4000 BYTE),
    isfatca                        CHAR(1 BYTE),
    othercountry                   VARCHAR2(50 BYTE),
    passport                       VARCHAR2(50 BYTE),
    passportplace                  VARCHAR2(50 BYTE),
    taxplace                       VARCHAR2(50 BYTE),
    ispep                          VARCHAR2(1 BYTE),
    familyname1                    VARCHAR2(50 BYTE),
    familyname2                    VARCHAR2(50 BYTE),
    name1                          VARCHAR2(50 BYTE),
    name2                          VARCHAR2(50 BYTE),
    saleid                         VARCHAR2(50 BYTE),
    passportdate                   VARCHAR2(50 BYTE),
    lrcountry                      VARCHAR2(3 BYTE),
    lrposition                     VARCHAR2(50 BYTE),
    lrdecisionno                   VARCHAR2(50 BYTE),
    lrid                           VARCHAR2(50 BYTE),
    lriddate                       VARCHAR2(50 BYTE),
    lridplace                      VARCHAR2(50 BYTE),
    lraddress                      VARCHAR2(100 BYTE),
    lrcontact                      VARCHAR2(100 BYTE),
    lrpriphone                     VARCHAR2(50 BYTE),
    lraltphone                     VARCHAR2(50 BYTE),
    lrfax                          VARCHAR2(50 BYTE),
    lremail                        VARCHAR2(50 BYTE),
    isrepresentative               VARCHAR2(1 BYTE),
    lrname                         VARCHAR2(50 BYTE),
    lrsex                          VARCHAR2(3 BYTE),
    lrdob                          VARCHAR2(50 BYTE),
    job                            VARCHAR2(200 BYTE),
    workunit                       VARCHAR2(200 BYTE),
    tlidgt                         VARCHAR2(200 BYTE),
    mobilegt                       VARCHAR2(200 BYTE),
    cftype                         VARCHAR2(10 BYTE),
    isprofession                   VARCHAR2(20 BYTE),
    fullnameaccented               VARCHAR2(500 BYTE),
    isexists                       VARCHAR2(20 BYTE),
    professiontodate               VARCHAR2(20 BYTE),
    professionfrdate               VARCHAR2(20 BYTE),
    seaccount                      VARCHAR2(500 BYTE),
    ciaccount                      VARCHAR2(500 BYTE),
    secif                          VARCHAR2(500 BYTE),
    lridtyper                      VARCHAR2(20 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE cfmast_temp
/

CREATE TABLE cfmast_temp
    (custid                         VARCHAR2(40 BYTE) NOT NULL,
    custodycd                      VARCHAR2(10 BYTE),
    sid                            VARCHAR2(20 BYTE),
    firstname                      VARCHAR2(200 BYTE),
    middlename                     VARCHAR2(50 BYTE),
    lastname                       VARCHAR2(50 BYTE),
    fullname                       VARCHAR2(500 BYTE),
    acctype                        VARCHAR2(10 BYTE),
    custtype                       VARCHAR2(10 BYTE),
    grinvestor                     VARCHAR2(10 BYTE),
    sex                            VARCHAR2(3 BYTE),
    birthdate                      TIMESTAMP (6),
    idtype                         VARCHAR2(50 BYTE),
    idcode                         VARCHAR2(50 BYTE),
    iddate                         TIMESTAMP (6),
    idexpdated                     TIMESTAMP (6),
    idplace                        VARCHAR2(500 BYTE),
    tradingcode                    VARCHAR2(50 BYTE),
    tradingdate                    TIMESTAMP (6),
    taxno                          VARCHAR2(50 BYTE),
    regaddress                     VARCHAR2(500 BYTE),
    address                        VARCHAR2(500 BYTE),
    country                        VARCHAR2(3 BYTE),
    province                       VARCHAR2(3 BYTE),
    phone                          VARCHAR2(50 BYTE),
    mobile                         VARCHAR2(50 BYTE),
    email                          VARCHAR2(50 BYTE),
    dbcode                         VARCHAR2(4 BYTE),
    status                         VARCHAR2(1 BYTE),
    pstatus                        VARCHAR2(50 BYTE),
    lastchange                     TIMESTAMP (6),
    bankacc                        VARCHAR2(20 BYTE),
    bankcode                       VARCHAR2(20 BYTE),
    citybank                       VARCHAR2(500 BYTE),
    bankacname                     VARCHAR2(500 BYTE),
    shortname                      VARCHAR2(100 BYTE),
    refname1                       VARCHAR2(500 BYTE),
    refmobile1                     VARCHAR2(100 BYTE),
    refname2                       VARCHAR2(500 BYTE),
    refmobile2                     VARCHAR2(100 BYTE),
    refpost1                       VARCHAR2(100 BYTE),
    refpost2                       VARCHAR2(100 BYTE),
    brid                           VARCHAR2(4 BYTE),
    fax                            VARCHAR2(30 BYTE),
    incomeyear                     VARCHAR2(30 BYTE),
    isauth                         VARCHAR2(3 BYTE),
    rcv_email                      VARCHAR2(3 BYTE),
    rcv_sms                        VARCHAR2(3 BYTE),
    sign_img                       VARCHAR2(50 BYTE),
    ownlicense_img                 VARCHAR2(500 BYTE),
    isotp                          VARCHAR2(3 BYTE),
    careby                         VARCHAR2(20 BYTE),
    rcv_mail                       VARCHAR2(5 BYTE),
    isapprv                        VARCHAR2(5 BYTE),
    opndate                        DATE,
    cfclsdate                      DATE,
    opnid                          VARCHAR2(20 BYTE),
    last_mkid                      VARCHAR2(20 BYTE),
    last_ofid                      VARCHAR2(20 BYTE),
    vsdstatus                      VARCHAR2(3 BYTE) DEFAULT 'P',
    acctgrp                        VARCHAR2(5 BYTE),
    investtype                     VARCHAR2(5 BYTE),
    classsipcd                     VARCHAR2(5 BYTE),
    ownlicense2_img                VARCHAR2(500 BYTE),
    ownlicense3_img                VARCHAR2(500 BYTE),
    ownlicense4_img                VARCHAR2(500 BYTE),
    isonline                       VARCHAR2(3 BYTE),
    autoid                         VARCHAR2(1000 BYTE) ,
    iscontact                      VARCHAR2(1 BYTE),
    isfatca                        CHAR(1 BYTE) DEFAULT 'N',
    othercountry                   VARCHAR2(50 BYTE),
    passport                       VARCHAR2(50 BYTE),
    passportplace                  VARCHAR2(50 BYTE),
    taxplace                       VARCHAR2(50 BYTE),
    ispep                          VARCHAR2(1 BYTE) DEFAULT 'N',
    familyname1                    VARCHAR2(50 BYTE),
    familyname2                    VARCHAR2(50 BYTE),
    name1                          VARCHAR2(50 BYTE),
    name2                          VARCHAR2(50 BYTE),
    saleid                         VARCHAR2(50 BYTE),
    passportdate                   VARCHAR2(50 BYTE),
    lrcountry                      VARCHAR2(3 BYTE),
    lrposition                     VARCHAR2(50 BYTE),
    lrdecisionno                   VARCHAR2(50 BYTE),
    lrid                           VARCHAR2(50 BYTE),
    lriddate                       VARCHAR2(50 BYTE),
    lridplace                      VARCHAR2(50 BYTE),
    lraddress                      VARCHAR2(100 BYTE),
    lrcontact                      VARCHAR2(100 BYTE),
    lrpriphone                     VARCHAR2(50 BYTE),
    lraltphone                     VARCHAR2(50 BYTE),
    lrfax                          VARCHAR2(50 BYTE),
    lremail                        VARCHAR2(50 BYTE),
    isrepresentative               VARCHAR2(1 BYTE) DEFAULT 'N',
    lrname                         VARCHAR2(50 BYTE),
    lrsex                          VARCHAR2(3 BYTE),
    lrdob                          VARCHAR2(50 BYTE),
    job                            VARCHAR2(200 BYTE),
    workunit                       VARCHAR2(200 BYTE),
    mobilegt                       VARCHAR2(200 BYTE),
    tlidgt                         VARCHAR2(200 BYTE),
    cftype                         VARCHAR2(10 BYTE),
    isprofession                   VARCHAR2(20 BYTE),
    fullnameaccented               VARCHAR2(500 BYTE),
    isexists                       VARCHAR2(20 BYTE),
    professionfrdate               VARCHAR2(20 BYTE),
    professiontodate               VARCHAR2(20 BYTE),
    seaccount                      VARCHAR2(500 BYTE),
    ciaccount                      VARCHAR2(500 BYTE),
    secif                          VARCHAR2(500 BYTE),
    lridtyper                      VARCHAR2(20 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

ALTER TABLE cfmast_temp
ADD CONSTRAINT cfmast_tmp_pkey PRIMARY KEY (autoid)
USING INDEX
/

DROP TABLE cfmast_temp_hist
/

CREATE TABLE cfmast_temp_hist
    (custid                         VARCHAR2(40 BYTE) NOT NULL,
    custodycd                      VARCHAR2(10 BYTE),
    sid                            VARCHAR2(20 BYTE),
    firstname                      VARCHAR2(200 BYTE),
    middlename                     VARCHAR2(50 BYTE),
    lastname                       VARCHAR2(50 BYTE),
    fullname                       VARCHAR2(500 BYTE),
    acctype                        VARCHAR2(10 BYTE),
    custtype                       VARCHAR2(10 BYTE),
    grinvestor                     VARCHAR2(10 BYTE),
    sex                            VARCHAR2(3 BYTE),
    birthdate                      TIMESTAMP (6),
    idtype                         VARCHAR2(50 BYTE),
    idcode                         VARCHAR2(50 BYTE),
    iddate                         TIMESTAMP (6),
    idexpdated                     TIMESTAMP (6),
    idplace                        VARCHAR2(500 BYTE),
    tradingcode                    VARCHAR2(50 BYTE),
    tradingdate                    TIMESTAMP (6),
    taxno                          VARCHAR2(50 BYTE),
    regaddress                     VARCHAR2(500 BYTE),
    address                        VARCHAR2(500 BYTE),
    country                        VARCHAR2(3 BYTE),
    province                       VARCHAR2(3 BYTE),
    phone                          VARCHAR2(50 BYTE),
    mobile                         VARCHAR2(50 BYTE),
    email                          VARCHAR2(50 BYTE),
    dbcode                         VARCHAR2(4 BYTE),
    status                         VARCHAR2(1 BYTE),
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6),
    bankacc                        VARCHAR2(20 BYTE),
    bankcode                       VARCHAR2(20 BYTE),
    citybank                       VARCHAR2(500 BYTE),
    bankacname                     VARCHAR2(500 BYTE),
    shortname                      VARCHAR2(100 BYTE),
    refname1                       VARCHAR2(500 BYTE),
    refmobile1                     VARCHAR2(100 BYTE),
    refname2                       VARCHAR2(500 BYTE),
    refmobile2                     VARCHAR2(100 BYTE),
    refpost1                       VARCHAR2(100 BYTE),
    refpost2                       VARCHAR2(100 BYTE),
    brid                           VARCHAR2(4 BYTE),
    fax                            VARCHAR2(30 BYTE),
    incomeyear                     VARCHAR2(30 BYTE),
    isauth                         VARCHAR2(3 BYTE),
    rcv_email                      VARCHAR2(3 BYTE),
    rcv_sms                        VARCHAR2(3 BYTE),
    sign_img                       VARCHAR2(4000 BYTE),
    ownlicense_img                 VARCHAR2(4000 BYTE),
    isotp                          VARCHAR2(3 BYTE),
    careby                         VARCHAR2(20 BYTE),
    rcv_mail                       VARCHAR2(5 BYTE),
    isapprv                        VARCHAR2(5 BYTE),
    opndate                        DATE,
    cfclsdate                      DATE,
    opnid                          VARCHAR2(20 BYTE),
    last_mkid                      VARCHAR2(20 BYTE),
    last_ofid                      VARCHAR2(20 BYTE),
    vsdstatus                      VARCHAR2(3 BYTE) DEFAULT 'P',
    acctgrp                        VARCHAR2(5 BYTE),
    investtype                     VARCHAR2(5 BYTE),
    classsipcd                     VARCHAR2(5 BYTE),
    ownlicense2_img                VARCHAR2(4000 BYTE),
    ownlicense3_img                VARCHAR2(4000 BYTE),
    ownlicense4_img                VARCHAR2(4000 BYTE),
    isonline                       VARCHAR2(3 BYTE),
    autoid                         VARCHAR2(4000 BYTE) DEFAULT 'nextval(''seq_cfmast_temp' NOT NULL,
    iscontact                      VARCHAR2(1 BYTE),
    isfatca                        CHAR(1 BYTE) DEFAULT 'N',
    othercountry                   VARCHAR2(50 BYTE),
    passport                       VARCHAR2(50 BYTE),
    passportplace                  VARCHAR2(50 BYTE),
    taxplace                       VARCHAR2(50 BYTE),
    ispep                          VARCHAR2(1 BYTE) DEFAULT 'N',
    familyname1                    VARCHAR2(50 BYTE),
    familyname2                    VARCHAR2(50 BYTE),
    name1                          VARCHAR2(50 BYTE),
    name2                          VARCHAR2(50 BYTE),
    saleid                         VARCHAR2(50 BYTE),
    passportdate                   VARCHAR2(50 BYTE),
    lrcountry                      VARCHAR2(3 BYTE),
    lrposition                     VARCHAR2(50 BYTE),
    lrdecisionno                   VARCHAR2(50 BYTE),
    lrid                           VARCHAR2(50 BYTE),
    lriddate                       VARCHAR2(50 BYTE),
    lridplace                      VARCHAR2(50 BYTE),
    lraddress                      VARCHAR2(100 BYTE),
    lrcontact                      VARCHAR2(100 BYTE),
    lrpriphone                     VARCHAR2(50 BYTE),
    lraltphone                     VARCHAR2(50 BYTE),
    lrfax                          VARCHAR2(50 BYTE),
    lremail                        VARCHAR2(50 BYTE),
    isrepresentative               VARCHAR2(1 BYTE) DEFAULT 'N',
    lrname                         VARCHAR2(50 BYTE),
    lrsex                          VARCHAR2(3 BYTE),
    lrdob                          VARCHAR2(50 BYTE),
    job                            VARCHAR2(200 BYTE),
    workunit                       VARCHAR2(200 BYTE),
    mobilegt                       VARCHAR2(200 BYTE),
    tlidgt                         VARCHAR2(200 BYTE),
    cftype                         VARCHAR2(10 BYTE),
    isprofession                   VARCHAR2(20 BYTE),
    fullnameaccented               VARCHAR2(500 BYTE),
    isexists                       VARCHAR2(20 BYTE),
    professiontodate               VARCHAR2(20 BYTE),
    professionfrdate               VARCHAR2(20 BYTE),
    seaccount                      VARCHAR2(500 BYTE),
    ciaccount                      VARCHAR2(500 BYTE),
    secif                          VARCHAR2(500 BYTE),
    lridtyper                      VARCHAR2(20 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE cfmast_vsd
/

CREATE TABLE cfmast_vsd
    (txdate                         DATE,
    txnum                          VARCHAR2(30 BYTE),
    custid                         VARCHAR2(40 BYTE),
    custodycd                      VARCHAR2(10 BYTE),
    status                         VARCHAR2(3 BYTE),
    offtxdate                      DATE,
    offtxnum                       VARCHAR2(30 BYTE),
    old_fullname                   VARCHAR2(500 BYTE),
    new_fullname                   VARCHAR2(500 BYTE),
    old_idtype                     VARCHAR2(50 BYTE),
    new_idtype                     VARCHAR2(50 BYTE),
    old_idcode                     VARCHAR2(50 BYTE),
    new_idcode                     VARCHAR2(50 BYTE),
    old_iddate                     TIMESTAMP (6),
    new_iddate                     TIMESTAMP (6),
    old_idplace                    VARCHAR2(500 BYTE),
    new_idplace                    VARCHAR2(500 BYTE),
    old_idscan                     VARCHAR2(4000 BYTE),
    new_idscan                     VARCHAR2(4000 BYTE),
    old_custtype                   VARCHAR2(10 BYTE),
    new_custtype                   VARCHAR2(10 BYTE),
    old_address                    VARCHAR2(4000 BYTE),
    new_address                    VARCHAR2(4000 BYTE),
    old_bankacc                    VARCHAR2(20 BYTE),
    new_bankacc                    VARCHAR2(20 BYTE),
    old_bankcode                   VARCHAR2(20 BYTE),
    new_bankcode                   VARCHAR2(20 BYTE),
    old_citybank                   VARCHAR2(500 BYTE),
    new_citybank                   VARCHAR2(500 BYTE))
  SEGMENT CREATION DEFERRED
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE cfmastcv
/

CREATE TABLE cfmastcv
    (custodycd                      VARCHAR2(20 BYTE),
    fullname                       VARCHAR2(500 BYTE),
    acctype                        VARCHAR2(20 BYTE),
    custtype                       VARCHAR2(20 BYTE),
    grinvestor                     VARCHAR2(20 BYTE),
    sex                            VARCHAR2(10 BYTE),
    birthdate                      VARCHAR2(4000 BYTE),
    idtype                         VARCHAR2(4000 BYTE),
    idcode                         VARCHAR2(4000 BYTE),
    iddate                         VARCHAR2(4000 BYTE),
    idexpdated                     TIMESTAMP (6),
    idplace                        VARCHAR2(4000 BYTE),
    tradingcode                    VARCHAR2(4000 BYTE),
    tradingdate                    TIMESTAMP (6),
    taxno                          VARCHAR2(50 BYTE),
    regaddress                     VARCHAR2(500 BYTE),
    address                        VARCHAR2(500 BYTE),
    country                        VARCHAR2(4000 BYTE),
    province                       VARCHAR2(4000 BYTE),
    phone                          VARCHAR2(50 BYTE),
    mobile                         VARCHAR2(50 BYTE),
    email                          VARCHAR2(100 BYTE),
    dbcode                         VARCHAR2(100 BYTE),
    bankacc                        VARCHAR2(100 BYTE),
    bankcode                       VARCHAR2(100 BYTE),
    citybank                       VARCHAR2(500 BYTE),
    bankacname                     VARCHAR2(500 BYTE),
    status                         VARCHAR2(1 BYTE) DEFAULT 'P',
    openvia                        VARCHAR2(100 BYTE),
    careby                         VARCHAR2(100 BYTE),
    saleid                         VARCHAR2(100 BYTE),
    fatca1                         VARCHAR2(4000 BYTE),
    fatca2                         VARCHAR2(4000 BYTE),
    fatca3                         VARCHAR2(4000 BYTE),
    fatca4                         VARCHAR2(4000 BYTE),
    fatca5                         VARCHAR2(4000 BYTE),
    fatca6                         VARCHAR2(4000 BYTE),
    fatca7                         VARCHAR2(4000 BYTE),
    isonline                       VARCHAR2(1 BYTE),
    custodycdnew                   VARCHAR2(20 BYTE),
    siptype                        VARCHAR2(10 BYTE))
  SEGMENT CREATION DEFERRED
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE cfmaster
/

CREATE TABLE cfmaster
    (sid                            VARCHAR2(20 BYTE) NOT NULL,
    fullname                       VARCHAR2(500 BYTE),
    shortname                      VARCHAR2(50 BYTE),
    custtype                       VARCHAR2(10 BYTE),
    grinvestor                     VARCHAR2(10 BYTE),
    sex                            VARCHAR2(3 BYTE),
    birthdate                      DATE,
    idtype                         VARCHAR2(50 BYTE),
    idcode                         VARCHAR2(50 BYTE),
    iddate                         DATE,
    idexpdated                     DATE,
    idplace                        VARCHAR2(500 BYTE),
    tradingcode                    VARCHAR2(50 BYTE),
    tradingdate                    DATE,
    taxno                          VARCHAR2(50 BYTE),
    regaddress                     VARCHAR2(500 BYTE),
    address                        VARCHAR2(500 BYTE),
    country                        VARCHAR2(3 BYTE),
    province                       VARCHAR2(3 BYTE),
    phone                          VARCHAR2(50 BYTE),
    mobile                         VARCHAR2(50 BYTE),
    email                          VARCHAR2(50 BYTE),
    status                         VARCHAR2(1 BYTE),
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

ALTER TABLE cfmaster
ADD CONSTRAINT cfmaster_sid_pk PRIMARY KEY (sid)
USING INDEX
/

DROP TABLE cfmastinvest
/

CREATE TABLE cfmastinvest
    (custid                         VARCHAR2(200 BYTE),
    targer                         VARCHAR2(200 BYTE),
    experience                     VARCHAR2(200 BYTE),
    incomemonth                    VARCHAR2(200 BYTE),
    incomeyear                     VARCHAR2(200 BYTE),
    first                          VARCHAR2(200 BYTE),
    everymonth                     VARCHAR2(200 BYTE),
    saving                         VARCHAR2(200 BYTE),
    people                         VARCHAR2(200 BYTE),
    totalamt                       VARCHAR2(200 BYTE),
    risk                           VARCHAR2(200 BYTE),
    frequency                      VARCHAR2(200 BYTE),
    purpose                        VARCHAR2(200 BYTE),
    inyear                         VARCHAR2(200 BYTE),
    money                          VARCHAR2(200 BYTE),
    description                    VARCHAR2(200 BYTE),
    within                         VARCHAR2(200 BYTE),
    retired                        VARCHAR2(200 BYTE),
    monthlyspending                VARCHAR2(200 BYTE),
    id                             FLOAT(64),
    status                         VARCHAR2(3 BYTE) DEFAULT 'P',
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE cfmastinvestmemo
/

CREATE TABLE cfmastinvestmemo
    (custid                         VARCHAR2(200 BYTE),
    targer                         VARCHAR2(200 BYTE),
    experience                     VARCHAR2(200 BYTE),
    incomemonth                    VARCHAR2(200 BYTE),
    incomeyear                     VARCHAR2(200 BYTE),
    first                          VARCHAR2(200 BYTE),
    everymonth                     VARCHAR2(200 BYTE),
    saving                         VARCHAR2(200 BYTE),
    people                         VARCHAR2(200 BYTE),
    totalamt                       VARCHAR2(200 BYTE),
    risk                           VARCHAR2(200 BYTE),
    frequency                      VARCHAR2(200 BYTE),
    purpose                        VARCHAR2(200 BYTE),
    inyear                         VARCHAR2(200 BYTE),
    money                          VARCHAR2(200 BYTE),
    description                    VARCHAR2(200 BYTE),
    within                         VARCHAR2(200 BYTE),
    retired                        VARCHAR2(200 BYTE),
    monthlyspending                VARCHAR2(200 BYTE),
    id                             FLOAT(64),
    status                         VARCHAR2(3 BYTE) DEFAULT 'P',
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE cfmastmemo
/

CREATE TABLE cfmastmemo
    (custid                         VARCHAR2(40 BYTE),
    custodycd                      VARCHAR2(10 BYTE),
    sid                            VARCHAR2(20 BYTE),
    firstname                      VARCHAR2(200 BYTE),
    middlename                     VARCHAR2(200 BYTE),
    lastname                       VARCHAR2(50 BYTE),
    fullname                       VARCHAR2(500 BYTE),
    acctype                        VARCHAR2(10 BYTE),
    custtype                       VARCHAR2(10 BYTE),
    grinvestor                     VARCHAR2(10 BYTE),
    sex                            VARCHAR2(3 BYTE),
    birthdate                      TIMESTAMP (6),
    idtype                         VARCHAR2(50 BYTE),
    idcode                         VARCHAR2(50 BYTE),
    iddate                         TIMESTAMP (6),
    idexpdated                     TIMESTAMP (6),
    idplace                        VARCHAR2(500 BYTE),
    tradingcode                    VARCHAR2(50 BYTE),
    tradingdate                    TIMESTAMP (6),
    taxno                          VARCHAR2(50 BYTE),
    regaddress                     VARCHAR2(500 BYTE),
    address                        VARCHAR2(500 BYTE),
    country                        VARCHAR2(3 BYTE),
    province                       VARCHAR2(3 BYTE),
    phone                          VARCHAR2(50 BYTE),
    mobile                         VARCHAR2(50 BYTE),
    email                          VARCHAR2(50 BYTE),
    dbcode                         VARCHAR2(4 BYTE),
    status                         VARCHAR2(1 BYTE),
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6),
    bankacc                        VARCHAR2(20 BYTE),
    bankcode                       VARCHAR2(20 BYTE),
    citybank                       VARCHAR2(500 BYTE),
    bankacname                     VARCHAR2(500 BYTE),
    shortname                      VARCHAR2(100 BYTE),
    refname1                       VARCHAR2(500 BYTE),
    refmobile1                     VARCHAR2(100 BYTE),
    refname2                       VARCHAR2(500 BYTE),
    refmobile2                     VARCHAR2(100 BYTE),
    refpost1                       VARCHAR2(100 BYTE),
    refpost2                       VARCHAR2(100 BYTE),
    brid                           VARCHAR2(4 BYTE),
    fax                            VARCHAR2(30 BYTE),
    incomeyear                     VARCHAR2(30 BYTE),
    isauth                         VARCHAR2(3 BYTE),
    rcv_email                      VARCHAR2(3 BYTE),
    rcv_sms                        VARCHAR2(3 BYTE),
    careby                         VARCHAR2(20 BYTE),
    rcv_mail                       VARCHAR2(5 BYTE),
    isapprv                        VARCHAR2(5 BYTE),
    opndate                        DATE,
    cfclsdate                      DATE,
    opnid                          VARCHAR2(20 BYTE),
    last_mkid                      VARCHAR2(20 BYTE),
    last_ofid                      VARCHAR2(20 BYTE),
    vsdstatus                      VARCHAR2(3 BYTE),
    classcd                        VARCHAR2(10 BYTE),
    acctgrp                        VARCHAR2(5 BYTE),
    investtype                     VARCHAR2(5 BYTE),
    username                       VARCHAR2(100 BYTE),
    classsipcd                     VARCHAR2(5 BYTE),
    iscflead                       VARCHAR2(3 BYTE),
    isonline                       VARCHAR2(3 BYTE),
    openvia                        VARCHAR2(6 BYTE),
    iscontact                      VARCHAR2(1 BYTE),
    lastadd_tmpid                  VARCHAR2(4000 BYTE),
    lastedit_tmpid                 VARCHAR2(4000 BYTE),
    isfatca                        VARCHAR2(1 BYTE),
    othercountry                   VARCHAR2(50 BYTE),
    passport                       VARCHAR2(50 BYTE),
    passportplace                  VARCHAR2(50 BYTE),
    taxplace                       VARCHAR2(50 BYTE),
    ispep                          VARCHAR2(1 BYTE),
    familyname1                    VARCHAR2(50 BYTE),
    familyname2                    VARCHAR2(50 BYTE),
    name1                          VARCHAR2(50 BYTE),
    name2                          VARCHAR2(50 BYTE),
    saleid                         VARCHAR2(50 BYTE),
    passportdate                   VARCHAR2(50 BYTE),
    lrcountry                      VARCHAR2(3 BYTE),
    lrposition                     VARCHAR2(50 BYTE),
    lrdecisionno                   VARCHAR2(50 BYTE),
    lrid                           VARCHAR2(50 BYTE),
    lriddate                       VARCHAR2(50 BYTE),
    lridplace                      VARCHAR2(50 BYTE),
    lraddress                      VARCHAR2(100 BYTE),
    lrcontact                      VARCHAR2(100 BYTE),
    lrpriphone                     VARCHAR2(50 BYTE),
    lraltphone                     VARCHAR2(50 BYTE),
    lrfax                          VARCHAR2(50 BYTE),
    lremail                        VARCHAR2(50 BYTE),
    isrepresentative               VARCHAR2(1 BYTE),
    lrname                         VARCHAR2(50 BYTE),
    lrsex                          VARCHAR2(3 BYTE),
    lrdob                          VARCHAR2(50 BYTE),
    cfstatus                       VARCHAR2(1 BYTE),
    job                            VARCHAR2(200 BYTE),
    workunit                       VARCHAR2(200 BYTE),
    mobilegt                       VARCHAR2(50 BYTE),
    tlidgt                         VARCHAR2(50 BYTE),
    cftype                         VARCHAR2(10 BYTE),
    isprofession                   VARCHAR2(20 BYTE),
    fullnameaccented               VARCHAR2(500 BYTE),
    isexists                       VARCHAR2(20 BYTE),
    professiontodate               VARCHAR2(20 BYTE),
    professionfrdate               VARCHAR2(20 BYTE),
    seaccount                      VARCHAR2(500 BYTE),
    ciaccount                      VARCHAR2(500 BYTE),
    secif                          VARCHAR2(500 BYTE),
    lridtyper                      VARCHAR2(20 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE cfmastvip
/

CREATE TABLE cfmastvip
    (custodycd                      VARCHAR2(20 BYTE) NOT NULL,
    fullname                       VARCHAR2(500 BYTE),
    idtype                         VARCHAR2(20 BYTE),
    idcode                         VARCHAR2(30 BYTE),
    status                         VARCHAR2(10 BYTE) DEFAULT 'A',
    lastchange                     TIMESTAMP (6) DEFAULT to_date('0001-01-01 00:00:00', 'YYYY-MM-DD hh24:mi:ss'),
    pstatus                        VARCHAR2(4000 BYTE),
    active                         VARCHAR2(10 BYTE),
    txnum                          VARCHAR2(20 BYTE),
    txdate                         DATE,
    isused                         VARCHAR2(3 BYTE) DEFAULT 'N',
    grinvestor                     VARCHAR2(5 BYTE),
    custtype                       VARCHAR2(5 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE cfmastvipmemo
/

CREATE TABLE cfmastvipmemo
    (custodycd                      VARCHAR2(20 BYTE),
    fullname                       VARCHAR2(500 BYTE),
    idtype                         VARCHAR2(20 BYTE),
    idcode                         VARCHAR2(30 BYTE),
    status                         VARCHAR2(10 BYTE),
    lastchange                     TIMESTAMP (6),
    pstatus                        VARCHAR2(4000 BYTE),
    active                         VARCHAR2(10 BYTE),
    txnum                          VARCHAR2(20 BYTE),
    txdate                         DATE,
    isused                         VARCHAR2(3 BYTE),
    grinvestor                     VARCHAR2(5 BYTE),
    custtype                       VARCHAR2(5 BYTE))
  SEGMENT CREATION DEFERRED
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE cfotheracc
/

CREATE TABLE cfotheracc
    (autoid                         FLOAT(64) DEFAULT 0 NOT NULL,
    cfcustid                       VARCHAR2(20 BYTE),
    codeid                         VARCHAR2(10 BYTE),
    bankacc                        VARCHAR2(40 BYTE),
    bankacname                     VARCHAR2(100 BYTE),
    bankname                       VARCHAR2(150 BYTE),
    type                           CHAR(1 BYTE),
    citybank                       VARCHAR2(100 BYTE),
    bankcode                       VARCHAR2(20 BYTE))
  SEGMENT CREATION DEFERRED
  NOPARALLEL
  NOLOGGING
  MONITORING
/

CREATE INDEX cfotheracc_cfcustid_idx ON cfotheracc
  (
    cfcustid                        ASC
  )
NOPARALLEL
NOLOGGING
/


DROP TABLE cfownlicense
/

CREATE TABLE cfownlicense
    (autoid                         FLOAT(64) NOT NULL,
    custid                         VARCHAR2(20 BYTE),
    ownlicense                     VARCHAR2(4000 BYTE),
    valdate                        TIMESTAMP (6),
    expdate                        TIMESTAMP (6),
    type                           VARCHAR2(3 BYTE),
    description                    VARCHAR2(250 BYTE),
    status                         VARCHAR2(1 BYTE),
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6))
  SEGMENT CREATION DEFERRED
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE cfownlicensememo
/

CREATE TABLE cfownlicensememo
    (autoid                         FLOAT(64) NOT NULL,
    custid                         VARCHAR2(20 BYTE),
    ownlicense                     VARCHAR2(4000 BYTE),
    valdate                        TIMESTAMP (6),
    expdate                        TIMESTAMP (6),
    type                           VARCHAR2(3 BYTE),
    description                    VARCHAR2(250 BYTE),
    status                         VARCHAR2(1 BYTE),
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6))
  SEGMENT CREATION DEFERRED
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE cfsign
/

CREATE TABLE cfsign
    (autoid                         FLOAT(64) NOT NULL,
    custid                         VARCHAR2(20 BYTE),
    signature                      VARCHAR2(4000 BYTE),
    valdate                        TIMESTAMP (6),
    expdate                        TIMESTAMP (6),
    type                           VARCHAR2(4 BYTE),
    description                    VARCHAR2(250 BYTE),
    status                         VARCHAR2(1 BYTE),
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6),
    pautoid                        BINARY_DOUBLE,
    custodycd                      VARCHAR2(20 BYTE),
    tlid                           VARCHAR2(20 BYTE),
    cfurlfile                      VARCHAR2(100 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE cfsignmemo
/

CREATE TABLE cfsignmemo
    (autoid                         FLOAT(64) NOT NULL,
    custid                         VARCHAR2(20 BYTE),
    signature                      VARCHAR2(4000 BYTE),
    valdate                        TIMESTAMP (6),
    expdate                        TIMESTAMP (6),
    type                           VARCHAR2(4 BYTE),
    description                    VARCHAR2(250 BYTE),
    status                         VARCHAR2(1 BYTE),
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6),
    pautoid                        BINARY_DOUBLE)
  SEGMENT CREATION DEFERRED
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE cfsigntemp
/

CREATE TABLE cfsigntemp
    (autoid                         FLOAT(64) NOT NULL,
    custid                         VARCHAR2(20 BYTE),
    signature                      VARCHAR2(4000 BYTE),
    valdate                        TIMESTAMP (6),
    expdate                        TIMESTAMP (6),
    type                           VARCHAR2(4 BYTE),
    description                    VARCHAR2(250 BYTE),
    status                         VARCHAR2(1 BYTE),
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6),
    pautoid                        BINARY_DOUBLE,
    custodycd                      VARCHAR2(20 BYTE),
    tlid                           VARCHAR2(20 BYTE),
    cfurlfile                      VARCHAR2(100 BYTE),
    idcode                         VARCHAR2(20 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE citype
/

CREATE TABLE citype
    (actype                         VARCHAR2(4 BYTE) NOT NULL,
    ccycd                          VARCHAR2(2 BYTE),
    typename                       VARCHAR2(200 BYTE),
    glgrp                          VARCHAR2(4 BYTE),
    status                         VARCHAR2(1 BYTE),
    cigroup                        VARCHAR2(3 BYTE),
    glbank                         CHAR(5 BYTE),
    subcd                          VARCHAR2(3 BYTE),
    minbal                         FLOAT(64) DEFAULT 0,
    crintcd                        VARCHAR2(3 BYTE),
    crintrate                      FLOAT(64) DEFAULT 0,
    odintcd                        VARCHAR2(3 BYTE),
    odrate                         FLOAT(64) DEFAULT 0,
    drate                          VARCHAR2(3 BYTE),
    chgfeecd                       VARCHAR2(3 BYTE),
    stmcycle                       VARCHAR2(3 BYTE),
    dormday                        FLOAT(64) DEFAULT 0,
    tpr                            FLOAT(64) DEFAULT 0,
    description                    VARCHAR2(4000 BYTE),
    iccfcd                         CHAR(5 BYTE),
    iccftied                       CHAR(1 BYTE) DEFAULT 'Y',
    pstatus                        VARCHAR2(4000 BYTE),
    apprv_sts                      VARCHAR2(10 BYTE),
    rateid                         VARCHAR2(4 BYTE))
  SEGMENT CREATION DEFERRED
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE cmdauth
/

CREATE TABLE cmdauth
    (autoid                         FLOAT(64) DEFAULT 0,
    authtype                       VARCHAR2(1 BYTE),
    authid                         VARCHAR2(8 BYTE),
    cmdtype                        VARCHAR2(1 BYTE),
    cmdcode                        VARCHAR2(8 BYTE),
    cmdallow                       VARCHAR2(1 BYTE),
    strauth                        VARCHAR2(10 BYTE),
    savetlid                       VARCHAR2(8 BYTE),
    lastdate                       TIMESTAMP (6),
    cmdobjname                     VARCHAR2(50 BYTE),
    isinquiry                      VARCHAR2(1 BYTE) DEFAULT 'N',
    isadd                          VARCHAR2(1 BYTE) DEFAULT 'N',
    isedit                         VARCHAR2(1 BYTE) DEFAULT 'N',
    isdelete                       VARCHAR2(1 BYTE) DEFAULT 'N',
    isapprove                      VARCHAR2(1 BYTE) DEFAULT 'N')
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

CREATE INDEX cmdauth_cmdcode_idx ON cmdauth
  (
    cmdcode                         ASC
  )
NOPARALLEL
NOLOGGING
/

CREATE INDEX cmdauth_authid_idx ON cmdauth
  (
    authid                          ASC
  )
NOPARALLEL
NOLOGGING
/


DROP TABLE cmdauth_bk_20210121
/

CREATE TABLE cmdauth_bk_20210121
    (autoid                         FLOAT(64) NOT NULL,
    authtype                       VARCHAR2(1 BYTE) NOT NULL,
    authid                         VARCHAR2(8 BYTE) NOT NULL,
    cmdtype                        VARCHAR2(1 BYTE),
    cmdcode                        VARCHAR2(8 BYTE) NOT NULL,
    cmdallow                       VARCHAR2(1 BYTE),
    strauth                        VARCHAR2(10 BYTE),
    savetlid                       VARCHAR2(8 BYTE),
    lastdate                       TIMESTAMP (6),
    cmdobjname                     VARCHAR2(50 BYTE),
    isinquiry                      VARCHAR2(1 BYTE),
    isadd                          VARCHAR2(1 BYTE),
    isedit                         VARCHAR2(1 BYTE),
    isdelete                       VARCHAR2(1 BYTE),
    isapprove                      VARCHAR2(1 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE cmdmenu
/

CREATE TABLE cmdmenu
    (cmdid                          VARCHAR2(6 BYTE) NOT NULL,
    prid                           VARCHAR2(6 BYTE),
    lev                            FLOAT(64) DEFAULT 0,
    last                           VARCHAR2(1 BYTE),
    menutype                       VARCHAR2(1 BYTE),
    menucode                       VARCHAR2(8 BYTE),
    modcode                        VARCHAR2(3 BYTE),
    objname                        VARCHAR2(50 BYTE),
    cmdname                        VARCHAR2(400 BYTE),
    en_cmdname                     VARCHAR2(400 BYTE),
    authcode                       VARCHAR2(12 BYTE) DEFAULT 'YYYYYYYYYY',
    tltxcd                         VARCHAR2(100 BYTE),
    shortcut                       VARCHAR2(20 BYTE),
    mnviewcode                     VARCHAR2(10 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

ALTER TABLE cmdmenu
ADD CONSTRAINT cmdmenu_pkey PRIMARY KEY (cmdid)
USING INDEX
/

DROP TABLE collaborator
/

CREATE TABLE collaborator
    (coid                           VARCHAR2(6 BYTE) NOT NULL,
    fullname                       VARCHAR2(200 BYTE),
    active                         VARCHAR2(1 BYTE),
    idcode                         VARCHAR2(50 BYTE),
    mobile                         VARCHAR2(20 BYTE),
    email                          VARCHAR2(100 BYTE),
    status                         VARCHAR2(10 BYTE),
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6),
    iddate                         DATE,
    idplace                        VARCHAR2(500 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE collaboratormemo
/

CREATE TABLE collaboratormemo
    (coid                           VARCHAR2(6 BYTE) NOT NULL,
    fullname                       VARCHAR2(200 BYTE),
    active                         VARCHAR2(1 BYTE),
    idcode                         VARCHAR2(50 BYTE),
    mobile                         VARCHAR2(20 BYTE),
    email                          VARCHAR2(100 BYTE),
    status                         VARCHAR2(10 BYTE),
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6),
    iddate                         DATE,
    idplace                        VARCHAR2(500 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE collateral
/

CREATE TABLE collateral
    (autoid                         FLOAT(64) NOT NULL,
    symbol                         VARCHAR2(15 BYTE),
    refsymbol                      VARCHAR2(15 BYTE),
    qtty                           BINARY_DOUBLE,
    haircut                        BINARY_DOUBLE,
    price                          BINARY_DOUBLE,
    lastpricedt                    DATE,
    lastchange                     TIMESTAMP (6) DEFAULT to_date('0001-01-01 00:00:00', 'YYYY-MM-DD hh24:mi:ss'),
    refid                          FLOAT(64),
    status                         VARCHAR2(1 BYTE),
    pstatus                        VARCHAR2(100 BYTE))
  SEGMENT CREATION DEFERRED
  NOPARALLEL
  NOLOGGING
  MONITORING
/

ALTER TABLE collateral
ADD CONSTRAINT collateral_id_pkey PRIMARY KEY (autoid)
USING INDEX
/

DROP TABLE collateralmemo
/

CREATE TABLE collateralmemo
    (autoid                         FLOAT(64),
    symbol                         VARCHAR2(15 BYTE),
    refsymbol                      VARCHAR2(15 BYTE),
    qtty                           BINARY_DOUBLE,
    haircut                        BINARY_DOUBLE,
    price                          BINARY_DOUBLE,
    lastpricedt                    DATE,
    lastchange                     TIMESTAMP (6),
    refid                          FLOAT(64),
    status                         VARCHAR2(1 BYTE),
    pstatus                        VARCHAR2(100 BYTE))
  SEGMENT CREATION DEFERRED
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE column1
/

CREATE TABLE column1
    (substring                      VARCHAR2(4000 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE comboproduct
/

CREATE TABLE comboproduct
    (id                             NUMBER(38,0),
    productid                      VARCHAR2(50 BYTE),
    productname                    VARCHAR2(500 BYTE),
    discount                       NUMBER(10,5),
    productier                     VARCHAR2(4000 BYTE),
    dealer                         VARCHAR2(200 BYTE),
    status                         VARCHAR2(3 BYTE),
    pstatus                        VARCHAR2(4000 BYTE),
    frdate                         DATE,
    todate                         DATE,
    lastchange                     TIMESTAMP (6),
    note                           VARCHAR2(200 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE comboproductmemo
/

CREATE TABLE comboproductmemo
    (id                             NUMBER(38,0),
    productid                      VARCHAR2(50 BYTE),
    productname                    VARCHAR2(500 BYTE),
    discount                       NUMBER(10,5),
    productier                     VARCHAR2(4000 BYTE),
    dealer                         VARCHAR2(200 BYTE),
    status                         VARCHAR2(3 BYTE),
    pstatus                        VARCHAR2(4000 BYTE),
    frdate                         DATE,
    todate                         DATE,
    lastchange                     TIMESTAMP (6),
    note                           VARCHAR2(200 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE commission
/

CREATE TABLE commission
    (id                             NUMBER(38,0),
    feecode                        VARCHAR2(100 BYTE),
    feename                        VARCHAR2(200 BYTE),
    calcmethod                     VARCHAR2(10 BYTE),
    ruletype                       VARCHAR2(10 BYTE),
    feerate                        NUMBER(10,5),
    frdate                         DATE,
    todate                         DATE,
    status                         VARCHAR2(3 BYTE) DEFAULT 'P',
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6),
    feetierdata                    VARCHAR2(4000 BYTE),
    note                           VARCHAR2(100 BYTE),
    symbol                         VARCHAR2(30 BYTE),
    product                        VARCHAR2(50 BYTE),
    sbsedefacct                    VARCHAR2(20 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE commission_dtl
/

CREATE TABLE commission_dtl
    (id                             NUMBER(38,0),
    commissionid                   NUMBER(38,0),
    framt                          NUMBER(38,0),
    toamt                          NUMBER(38,0),
    feerate                        NUMBER(10,5),
    status                         VARCHAR2(1 BYTE),
    pstatus                        VARCHAR2(4000 BYTE),
    ver                            VARCHAR2(100 BYTE),
    lastchange                     TIMESTAMP (6))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE commission_dtl_log
/

CREATE TABLE commission_dtl_log
    (id                             NUMBER(38,0),
    commissionid                   NUMBER(38,0),
    framt                          NUMBER(38,0),
    toamt                          NUMBER(38,0),
    feerate                        NUMBER(10,5))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE commission_dtlmemo
/

CREATE TABLE commission_dtlmemo
    (id                             NUMBER(38,0),
    commissionid                   NUMBER(38,0),
    framt                          NUMBER(38,0),
    toamt                          NUMBER(38,0),
    feerate                        NUMBER(10,5),
    status                         VARCHAR2(1 BYTE),
    pstatus                        VARCHAR2(4000 BYTE),
    ver                            VARCHAR2(100 BYTE),
    lastchange                     TIMESTAMP (6))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE commission_log
/

CREATE TABLE commission_log
    (id                             NUMBER(38,0),
    feecode                        VARCHAR2(100 BYTE),
    feename                        VARCHAR2(200 BYTE),
    calcmethod                     VARCHAR2(10 BYTE),
    ruletype                       VARCHAR2(10 BYTE),
    feerate                        NUMBER(10,5),
    lastchange                     TIMESTAMP (6),
    feetierdata                    VARCHAR2(4000 BYTE),
    note                           VARCHAR2(100 BYTE),
    symbol                         VARCHAR2(30 BYTE),
    product                        VARCHAR2(50 BYTE),
    sbsedefacct                    VARCHAR2(20 BYTE),
    txnum                          VARCHAR2(100 BYTE),
    txdate                         DATE,
    logid                          VARCHAR2(500 BYTE),
    action_type                    VARCHAR2(5 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE commissionmemo
/

CREATE TABLE commissionmemo
    (id                             NUMBER(38,0),
    feecode                        VARCHAR2(100 BYTE),
    feename                        VARCHAR2(200 BYTE),
    calcmethod                     VARCHAR2(10 BYTE),
    ruletype                       VARCHAR2(10 BYTE),
    feerate                        NUMBER(10,5),
    frdate                         DATE,
    todate                         DATE,
    status                         VARCHAR2(3 BYTE) DEFAULT 'P',
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6),
    feetierdata                    VARCHAR2(4000 BYTE),
    note                           VARCHAR2(100 BYTE),
    symbol                         VARCHAR2(30 BYTE),
    product                        VARCHAR2(50 BYTE),
    sbsedefacct                    VARCHAR2(20 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE commisstier
/

CREATE TABLE commisstier
    (id                             NUMBER(38,0),
    feeid                          NUMBER(38,0),
    framt                          NUMBER(38,0),
    toamt                          NUMBER(38,0),
    feerate                        NUMBER(10,5))
  SEGMENT CREATION DEFERRED
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE comprogram
/

CREATE TABLE comprogram
    (id                             NUMBER(38,0),
    procode                        VARCHAR2(100 BYTE),
    proname                        VARCHAR2(500 BYTE),
    effdate                        DATE,
    expdate                        DATE,
    protype                        VARCHAR2(10 BYTE),
    procondition                   VARCHAR2(4000 BYTE),
    ruletype                       VARCHAR2(10 BYTE),
    feerate                        NUMBER(10,5),
    feetierdata                    VARCHAR2(4000 BYTE),
    note                           VARCHAR2(100 BYTE),
    status                         VARCHAR2(3 BYTE) DEFAULT 'P',
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE comprogram_cond
/

CREATE TABLE comprogram_cond
    (id                             NUMBER(38,0),
    proid                          NUMBER(38,0),
    condvalue                      VARCHAR2(500 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE comprogram_cond_log
/

CREATE TABLE comprogram_cond_log
    (id                             NUMBER(38,0),
    proid                          NUMBER(38,0),
    condvalue                      VARCHAR2(500 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE comprogram_condmemo
/

CREATE TABLE comprogram_condmemo
    (id                             NUMBER(38,0),
    proid                          NUMBER(38,0),
    condvalue                      VARCHAR2(500 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE comprogram_dtl
/

CREATE TABLE comprogram_dtl
    (id                             NUMBER(38,0),
    proid                          NUMBER(38,0),
    framt                          NUMBER(38,0),
    toamt                          NUMBER(38,0),
    feerate                        NUMBER(10,5))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE comprogram_dtl_log
/

CREATE TABLE comprogram_dtl_log
    (id                             NUMBER(38,0),
    proid                          NUMBER(38,0),
    framt                          NUMBER(38,0),
    toamt                          NUMBER(38,0),
    feerate                        NUMBER(10,5))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE comprogram_dtlmemo
/

CREATE TABLE comprogram_dtlmemo
    (id                             NUMBER(38,0),
    proid                          NUMBER(38,0),
    framt                          NUMBER(38,0),
    toamt                          NUMBER(38,0),
    feerate                        NUMBER(10,5))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE comprogram_log
/

CREATE TABLE comprogram_log
    (id                             NUMBER(38,0),
    logid                          NUMBER(38,0),
    procode                        VARCHAR2(100 BYTE),
    proname                        VARCHAR2(500 BYTE),
    effdate                        DATE,
    expdate                        DATE,
    protype                        VARCHAR2(10 BYTE),
    procondition                   VARCHAR2(4000 BYTE),
    ruletype                       VARCHAR2(10 BYTE),
    feerate                        NUMBER(10,5),
    feetierdata                    VARCHAR2(4000 BYTE),
    note                           VARCHAR2(100 BYTE),
    lastchange                     TIMESTAMP (6),
    txnum                          VARCHAR2(30 BYTE),
    txdate                         DATE,
    action_type                    VARCHAR2(10 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE comprogrammemo
/

CREATE TABLE comprogrammemo
    (id                             NUMBER(38,0),
    procode                        VARCHAR2(100 BYTE),
    proname                        VARCHAR2(500 BYTE),
    effdate                        DATE,
    expdate                        DATE,
    protype                        VARCHAR2(10 BYTE),
    procondition                   VARCHAR2(4000 BYTE),
    ruletype                       VARCHAR2(10 BYTE),
    feerate                        NUMBER(10,5),
    feetierdata                    VARCHAR2(4000 BYTE),
    note                           VARCHAR2(100 BYTE),
    status                         VARCHAR2(3 BYTE) DEFAULT 'P',
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE contenttmp
/

CREATE TABLE contenttmp
    (tmpcode                        VARCHAR2(50 BYTE),
    tmpname                        VARCHAR2(150 BYTE),
    sendvia                        CHAR(1 BYTE),
    tmptype                        CHAR(1 BYTE),
    tmppath                        VARCHAR2(250 BYTE),
    tmpbody                        VARCHAR2(500 BYTE))
  SEGMENT CREATION DEFERRED
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE cstb_user_sources
/

CREATE TABLE cstb_user_sources
    (object_name                    VARCHAR2(60 BYTE),
    version                        VARCHAR2(15 BYTE),
    archive_date                   TIMESTAMP (6),
    user_source                    CLOB,
    dev_id                         VARCHAR2(30 BYTE),
    comments                       CLOB)
  SEGMENT CREATION IMMEDIATE
  LOB ("USER_SOURCE") STORE AS SECUREFILE SYS_LOB0000076078C00004$$
  (
   NOCACHE NOLOGGING
   CHUNK 8192
  )
  LOB ("COMMENTS") STORE AS SECUREFILE SYS_LOB0000076078C00006$$
  (
   NOCACHE NOLOGGING
   CHUNK 8192
  )
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE curve_buydtl
/

CREATE TABLE curve_buydtl
    (autoid                         NUMBER ,
    id                             NUMBER,
    termcd                         VARCHAR2(1 BYTE),
    "FROM"                           NUMBER,
    "TO"                             NUMBER,
    "TYPE"                           VARCHAR2(10 BYTE),
    rate                           NUMBER(20,2),
    amplitude                      NUMBER(20,2),
    status                         VARCHAR2(2 BYTE),
    pstatus                        VARCHAR2(200 BYTE),
    action                         VARCHAR2(5 BYTE),
    calrate_method                 VARCHAR2(5 BYTE),
    feebuy                         NUMBER DEFAULT 0)
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

ALTER TABLE curve_buydtl
ADD PRIMARY KEY (autoid)
USING INDEX
/

DROP TABLE curve_buydtlmemo
/

CREATE TABLE curve_buydtlmemo
    (autoid                         NUMBER,
    id                             NUMBER,
    termcd                         VARCHAR2(1 BYTE),
    "FROM"                           NUMBER,
    "TO"                             NUMBER,
    "TYPE"                           VARCHAR2(10 BYTE),
    rate                           NUMBER(20,2),
    amplitude                      NUMBER(20,2),
    status                         VARCHAR2(2 BYTE),
    pstatus                        VARCHAR2(200 BYTE),
    action                         VARCHAR2(5 BYTE),
    calrate_method                 VARCHAR2(5 BYTE),
    feebuy                         NUMBER DEFAULT 0)
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE curve_selldtl
/

CREATE TABLE curve_selldtl
    (autoid                         NUMBER ,
    id                             NUMBER,
    termcd                         VARCHAR2(1 BYTE),
    "FROM"                           NUMBER,
    "TO"                             NUMBER,
    "TYPE"                           VARCHAR2(10 BYTE),
    rate                           NUMBER(20,2),
    amplitude                      NUMBER(20,2),
    status                         VARCHAR2(2 BYTE),
    pstatus                        VARCHAR2(200 BYTE),
    action                         VARCHAR2(5 BYTE),
    calrate_method                 VARCHAR2(5 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

ALTER TABLE curve_selldtl
ADD PRIMARY KEY (autoid)
USING INDEX
/

DROP TABLE curve_selldtlmemo
/

CREATE TABLE curve_selldtlmemo
    (autoid                         NUMBER,
    id                             NUMBER,
    termcd                         VARCHAR2(1 BYTE),
    "FROM"                           NUMBER,
    "TO"                             NUMBER,
    "TYPE"                           VARCHAR2(10 BYTE),
    rate                           NUMBER(20,2),
    amplitude                      NUMBER(20,2),
    status                         VARCHAR2(2 BYTE),
    pstatus                        VARCHAR2(200 BYTE),
    action                         VARCHAR2(5 BYTE),
    calrate_method                 VARCHAR2(5 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE customerregistersale
/

CREATE TABLE customerregistersale
    (autoid                         FLOAT(32) DEFAULT 0 NOT NULL,
    refacctno                      VARCHAR2(50 BYTE) NOT NULL,
    saleid_old                     VARCHAR2(50 BYTE) NOT NULL,
    saleid_new                     VARCHAR2(50 BYTE) NOT NULL,
    isconfirm                      VARCHAR2(1 BYTE) DEFAULT 'N')
  SEGMENT CREATION DEFERRED
  NOPARALLEL
  NOLOGGING
  MONITORING
/

ALTER TABLE customerregistersale
ADD CONSTRAINT customerregistersale_pkey PRIMARY KEY (autoid)
USING INDEX
/

DROP TABLE danhba
/

CREATE TABLE danhba
    (autoid                         BINARY_DOUBLE NOT NULL,
    danhba_ho                      VARCHAR2(250 BYTE),
    danhba_ten                     VARCHAR2(250 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE deferror
/

CREATE TABLE deferror
    (errnum                         FLOAT(64) DEFAULT 0 NOT NULL,
    errdesc                        VARCHAR2(200 BYTE),
    en_errdesc                     VARCHAR2(200 BYTE),
    modcode                        VARCHAR2(3 BYTE),
    conflvl                        FLOAT(64) DEFAULT 0)
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

ALTER TABLE deferror
ADD CONSTRAINT deferror_pkey PRIMARY KEY (errnum)
USING INDEX
/

DROP TABLE demo_tem
/

CREATE TABLE demo_tem
    (customer_id                    NUMBER(10,0) NOT NULL,
    customer_name                  VARCHAR2(50 BYTE) NOT NULL,
    city                           VARCHAR2(50 BYTE))
  SEGMENT CREATION DEFERRED
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE deposit
/

CREATE TABLE deposit
    (acctno                         VARCHAR2(15 BYTE),
    symbol                         VARCHAR2(15 BYTE),
    qtty                           NUMBER(38,0) DEFAULT 0,
    price                          NUMBER(38,0) DEFAULT 0,
    valuedt                        DATE,
    expdt                          DATE,
    fee                            NUMBER(38,0) DEFAULT 0,
    notes                          VARCHAR2(4000 BYTE),
    status                         VARCHAR2(10 BYTE) DEFAULT NULL,
    accr                           NUMBER(38,0) DEFAULT 0,
    pstatus                        VARCHAR2(10 BYTE),
    lastchange                     TIMESTAMP (6) DEFAULT NULL,
    autoid                         NUMBER(38,0) DEFAULT 0,
    deliqtty                       NUMBER(38,0) DEFAULT 0,
    sellquoteqtty                  NUMBER(38,0) DEFAULT 0,
    investedamt                    NUMBER(38,0) DEFAULT 0,
    returnamt                      NUMBER(38,0) DEFAULT 0,
    settledamt                     NUMBER(38,0) DEFAULT 0,
    isscode                        VARCHAR2(255 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE deposit_his
/

CREATE TABLE deposit_his
    (acctno                         VARCHAR2(15 BYTE),
    symbol                         VARCHAR2(15 BYTE),
    qttyindecrease                 BINARY_DOUBLE,
    price                          BINARY_DOUBLE,
    valuedt                        DATE,
    expdt                          DATE,
    notes                          VARCHAR2(4000 BYTE),
    status                         VARCHAR2(10 BYTE) DEFAULT 'P',
    pstatus                        VARCHAR2(10 BYTE),
    lastchange                     TIMESTAMP (6) DEFAULT to_date('0001-01-01 00:00:00', 'YYYY-MM-DD hh24:mi:ss'),
    autoid                         BINARY_DOUBLE DEFAULT 0,
    depositid                      BINARY_DOUBLE,
    txnum                          VARCHAR2(20 BYTE),
    qtty                           BINARY_DOUBLE)
  SEGMENT CREATION DEFERRED
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE deposit_member
/

CREATE TABLE deposit_member
    (depositid                      VARCHAR2(12 BYTE) NOT NULL,
    shortname                      VARCHAR2(600 BYTE),
    fullname                       VARCHAR2(4000 BYTE),
    officename                     VARCHAR2(4000 BYTE),
    address                        VARCHAR2(4000 BYTE),
    phone                          VARCHAR2(20 BYTE),
    fax                            VARCHAR2(20 BYTE),
    description                    VARCHAR2(4000 BYTE),
    biccode                        VARCHAR2(20 BYTE),
    interbiccode                   VARCHAR2(30 BYTE))
  SEGMENT CREATION DEFERRED
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE deposit_tmp
/

CREATE TABLE deposit_tmp
    (symbol                         VARCHAR2(20 BYTE),
    qtty                           NUMBER(38,0),
    txnum                          VARCHAR2(30 BYTE),
    txdate                         DATE,
    valuedt                        DATE,
    expdt                          DATE,
    acctno                         VARCHAR2(20 BYTE),
    isscode                        VARCHAR2(20 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE draff_phong
/

CREATE TABLE draff_phong
    (ten                            VARCHAR2(4000 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE email_notify
/

CREATE TABLE email_notify
    (autoid                         NUMBER,
    txnum                          VARCHAR2(50 BYTE),
    txdate                         DATE,
    keyname                        VARCHAR2(50 BYTE),
    keyvalue                       VARCHAR2(100 BYTE),
    autofreq                       VARCHAR2(100 BYTE),
    status                         VARCHAR2(1 BYTE) DEFAULT 'P',
    lastchange                     TIMESTAMP (6),
    sessionno                      VARCHAR2(1000 BYTE),
    codeid                         VARCHAR2(6 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE emaillog
/

CREATE TABLE emaillog
    (autoid                         FLOAT(64),
    email                          VARCHAR2(180 BYTE),
    templateid                     VARCHAR2(250 BYTE),
    datasource                     VARCHAR2(4000 BYTE),
    status                         VARCHAR2(1 BYTE),
    createtime                     TIMESTAMP (6) DEFAULT to_date('0001-01-01 00:00:00', 'YYYY-MM-DD hh24:mi:ss'),
    senttime                       TIMESTAMP (6),
    afacctno                       VARCHAR2(200 BYTE),
    note                           VARCHAR2(600 BYTE),
    typesms                        VARCHAR2(20 BYTE),
    createtype                     VARCHAR2(1 BYTE) DEFAULT 'N',
    txdate                         DATE,
    language                       VARCHAR2(5 BYTE),
    paidsts                        CHAR(1 BYTE) DEFAULT 'N',
    retry_count                    BINARY_DOUBLE DEFAULT 0,
    last_retry_time                TIMESTAMP (6),
    gateway_time                   TIMESTAMP (6),
    msgbody                        CLOB,
    custodycd                      VARCHAR2(200 BYTE),
    refaccount                     VARCHAR2(200 BYTE),
    feedbackmsg                    VARCHAR2(4000 BYTE),
    otp                            VARCHAR2(1000 BYTE))
  SEGMENT CREATION IMMEDIATE
  LOB ("MSGBODY") STORE AS SECUREFILE SYS_LOB0000076096C00018$$
  (
   NOCACHE NOLOGGING
   CHUNK 8192
  )
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE emailloghist
/

CREATE TABLE emailloghist
    (autoid                         FLOAT(64),
    email                          VARCHAR2(180 BYTE),
    templateid                     VARCHAR2(250 BYTE),
    datasource                     VARCHAR2(4000 BYTE),
    status                         VARCHAR2(1 BYTE),
    createtime                     TIMESTAMP (6),
    senttime                       TIMESTAMP (6),
    afacctno                       VARCHAR2(200 BYTE),
    note                           VARCHAR2(600 BYTE),
    typesms                        VARCHAR2(20 BYTE),
    createtype                     VARCHAR2(1 BYTE),
    txdate                         DATE,
    language                       VARCHAR2(5 BYTE),
    paidsts                        CHAR(1 BYTE),
    retry_count                    BINARY_DOUBLE,
    last_retry_time                TIMESTAMP (6),
    gateway_time                   TIMESTAMP (6),
    msgbody                        VARCHAR2(4000 BYTE),
    custodycd                      VARCHAR2(100 BYTE),
    refaccount                     VARCHAR2(200 BYTE),
    feedbackmsg                    VARCHAR2(4000 BYTE),
    otp                            VARCHAR2(1000 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE event_log
/

CREATE TABLE event_log
    (autoid                         FLOAT(32) DEFAULT 0 NOT NULL,
    objname                        VARCHAR2(4000 BYTE),
    objkey                         VARCHAR2(4000 BYTE),
    objvalue                       VARCHAR2(4000 BYTE),
    msgtype                        VARCHAR2(4000 BYTE),
    status                         VARCHAR2(4000 BYTE),
    note                           VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

