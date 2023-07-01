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
    err_param                      VARCHAR2(4000 BYTE),
    headers                        VARCHAR2(4000 BYTE))
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


DROP TABLE api_log
/

CREATE TABLE api_log
    (autoid                         NUMBER,
    apicode                        VARCHAR2(50 BYTE),
    reqbody                        VARCHAR2(400 BYTE),
    query                          VARCHAR2(400 BYTE),
    resbody                        CLOB,
    calltime                       TIMESTAMP (6))
  SEGMENT CREATION IMMEDIATE
  LOB ("RESBODY") STORE AS SECUREFILE SYS_LOB0000104093C00005$$
  (
   NOCACHE NOLOGGING
   CHUNK 8192
  )
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE apiauthdef
/

CREATE TABLE apiauthdef
    (authcode                       VARCHAR2(50 BYTE),
    authdesc                       VARCHAR2(50 BYTE),
    authtype                       VARCHAR2(50 BYTE),
    authmethod                     VARCHAR2(50 BYTE),
    url                            VARCHAR2(200 BYTE),
    headers                        VARCHAR2(4000 BYTE),
    body                           VARCHAR2(4000 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE apidef
/

CREATE TABLE apidef
    (apicode                        VARCHAR2(50 BYTE),
    apidesc                        VARCHAR2(50 BYTE),
    authcode                       VARCHAR2(50 BYTE),
    apitype                        VARCHAR2(50 BYTE),
    method                         VARCHAR2(50 BYTE),
    url                            VARCHAR2(200 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
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
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE asset_treasury
/

CREATE TABLE asset_treasury
    (symbol                         VARCHAR2(100 BYTE),
    fullname                       VARCHAR2(4000 BYTE),
    synctime                       TIMESTAMP (6))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE assetdtl
/

CREATE TABLE assetdtl
    (autoid                         FLOAT(64),
    symbol                         VARCHAR2(50 BYTE),
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
    issuerid                       VARCHAR2(50 BYTE),
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
    udf                            VARCHAR2(4000 BYTE),
    intdesc                        VARCHAR2(4000 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE assetdtl_treasury
/

CREATE TABLE assetdtl_treasury
    (symbol                         VARCHAR2(50 BYTE),
    fullname                       VARCHAR2(200 BYTE),
    synctime                       TIMESTAMP (6))
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
    udfname                        VARCHAR2(500 BYTE),
    action                         VARCHAR2(200 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE assetdtlmemo
/

CREATE TABLE assetdtlmemo
    (autoid                         FLOAT(64) NOT NULL,
    symbol                         VARCHAR2(50 BYTE),
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
    issuerid                       VARCHAR2(50 BYTE),
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
    udf                            VARCHAR2(4000 BYTE),
    intdesc                        VARCHAR2(4000 BYTE))
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

DROP TABLE cflimits
/

CREATE TABLE cflimits
    (autoid                         NUMBER,
    limit_type                     VARCHAR2(10 BYTE),
    limit_cond                     VARCHAR2(4000 BYTE),
    trans_value                    NUMBER,
    daily_value                    NUMBER,
    calc_type                      VARCHAR2(10 BYTE),
    status                         CHAR(1 BYTE),
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE cflimits_log
/

CREATE TABLE cflimits_log
    (autoid                         NUMBER,
    logid                          NUMBER,
    limit_type                     VARCHAR2(10 BYTE),
    limit_cond                     VARCHAR2(4000 BYTE),
    trans_value                    NUMBER,
    daily_value                    NUMBER,
    calc_type                      VARCHAR2(10 BYTE),
    lastchange                     TIMESTAMP (6),
    txnum                          NUMBER,
    txdate                         DATE,
    action_type                    VARCHAR2(10 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE cflimitsmemo
/

CREATE TABLE cflimitsmemo
    (autoid                         NUMBER,
    limit_type                     VARCHAR2(10 BYTE),
    limit_cond                     VARCHAR2(4000 BYTE),
    trans_value                    NUMBER,
    daily_value                    NUMBER,
    calc_type                      VARCHAR2(10 BYTE),
    status                         CHAR(1 BYTE),
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6))
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
    lridtyper                      VARCHAR2(20 BYTE),
    custtypeck                     VARCHAR2(200 BYTE),
    idcodeck                       VARCHAR2(200 BYTE),
    iddateck                       DATE,
    idexpdatedck                   DATE,
    idplaceck                      VARCHAR2(2000 BYTE),
    idtypeck                       VARCHAR2(2000 BYTE))
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
    lridtyper                      VARCHAR2(20 BYTE),
    custtypeck                     VARCHAR2(200 BYTE),
    idcodeck                       VARCHAR2(200 BYTE),
    iddateck                       VARCHAR2(200 BYTE),
    idexpdatedck                   VARCHAR2(200 BYTE),
    idplaceck                      VARCHAR2(2000 BYTE),
    idtypeck                       VARCHAR2(2000 BYTE))
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
    lridtyper                      VARCHAR2(20 BYTE),
    custtypeck                     VARCHAR2(200 BYTE),
    idcodeck                       VARCHAR2(200 BYTE),
    iddateck                       VARCHAR2(200 BYTE),
    idexpdatedck                   VARCHAR2(200 BYTE),
    idplaceck                      VARCHAR2(2000 BYTE),
    idtypeck                       VARCHAR2(2000 BYTE))
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
    lridtyper                      VARCHAR2(20 BYTE),
    custtypeck                     VARCHAR2(200 BYTE),
    idcodeck                       VARCHAR2(200 BYTE),
    iddateck                       VARCHAR2(200 BYTE),
    idexpdatedck                   VARCHAR2(200 BYTE),
    idplaceck                      VARCHAR2(2000 BYTE),
    idtypeck                       VARCHAR2(2000 BYTE))
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
    lridtyper                      VARCHAR2(20 BYTE),
    custtypeck                     VARCHAR2(200 BYTE),
    idcodeck                       VARCHAR2(200 BYTE),
    iddateck                       VARCHAR2(200 BYTE),
    idexpdatedck                   VARCHAR2(200 BYTE),
    idplaceck                      VARCHAR2(2000 BYTE),
    idtypeck                       VARCHAR2(2000 BYTE))
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
    lridtyper                      VARCHAR2(20 BYTE),
    custtypeck                     VARCHAR2(200 BYTE),
    idcodeck                       VARCHAR2(200 BYTE),
    iddateck                       VARCHAR2(200 BYTE),
    idexpdatedck                   VARCHAR2(200 BYTE),
    idplaceck                      VARCHAR2(2000 BYTE),
    idtypeck                       VARCHAR2(2000 BYTE))
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
    lridtyper                      VARCHAR2(20 BYTE),
    custtypeck                     VARCHAR2(200 BYTE),
    idcodeck                       VARCHAR2(200 BYTE),
    iddateck                       VARCHAR2(200 BYTE),
    idexpdatedck                   VARCHAR2(200 BYTE),
    idplaceck                      VARCHAR2(2000 BYTE),
    idtypeck                       VARCHAR2(2000 BYTE))
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
    lastchange                     TIMESTAMP (6),
    threshold                      NUMBER)
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
    action_type                    VARCHAR2(10 BYTE),
    threshold                      NUMBER)
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
    lastchange                     TIMESTAMP (6),
    threshold                      NUMBER)
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
    from                           NUMBER,
    to                             NUMBER,
    type                           VARCHAR2(10 BYTE),
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
    from                           NUMBER,
    to                             NUMBER,
    type                           VARCHAR2(10 BYTE),
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
    from                           NUMBER,
    to                             NUMBER,
    type                           VARCHAR2(10 BYTE),
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
    from                           NUMBER,
    to                             NUMBER,
    type                           VARCHAR2(10 BYTE),
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

DROP TABLE fabankadvicetx
/

CREATE TABLE fabankadvicetx
    (autoid                         NUMBER(20,0),
    refkey                         VARCHAR2(30 BYTE),
    bankacctno                     VARCHAR2(50 BYTE),
    bankcd                         VARCHAR2(50 BYTE),
    reffundbnkid                   NUMBER,
    txdorc                         CHAR(1 BYTE) DEFAULT 'C',
    txdate                         DATE,
    txnum                          VARCHAR2(20 BYTE),
    fundcodeid                     VARCHAR2(20 BYTE),
    memberid                       NUMBER(20,0),
    custodycd                      VARCHAR2(30 BYTE),
    txdesc                         VARCHAR2(300 BYTE),
    status                         CHAR(1 BYTE) DEFAULT 'T',
    deltd                          CHAR(1 BYTE) DEFAULT 'N',
    reftxdate                      DATE,
    reftxnum                       VARCHAR2(20 BYTE),
    txamt                          NUMBER(20,0),
    type                           VARCHAR2(20 BYTE),
    bankactype                     VARCHAR2(20 BYTE))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

CREATE INDEX fabankadvicetx_autoid_idx ON fabankadvicetx
  (
    autoid                          ASC
  )
NOPARALLEL
NOLOGGING
/


DROP TABLE fafund
/

CREATE TABLE fafund
    (fundcodeid                     VARCHAR2(20 BYTE),
    faserviceid                    NUMBER(20,0) DEFAULT 0,
    description                    VARCHAR2(250 BYTE),
    parvalue                       NUMBER(20,0) DEFAULT 0,
    navccq                         NUMBER(20,2),
    txdate                         DATE,
    status                         VARCHAR2(1 BYTE) DEFAULT 'P',
    pstatus                        VARCHAR2(30 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE fafundacctbnk
/

CREATE TABLE fafundacctbnk
    (autoid                         NUMBER(20,0),
    fundcodeid                     VARCHAR2(20 BYTE),
    actype                         VARCHAR2(3 BYTE) DEFAULT 'CON',
    mbid                           NUMBER(20,0) DEFAULT 0,
    bankcd                         VARCHAR2(20 BYTE),
    bankacctno                     VARCHAR2(50 BYTE),
    description                    VARCHAR2(250 BYTE),
    status                         VARCHAR2(1 BYTE) DEFAULT 'P',
    pstatus                        VARCHAR2(30 BYTE))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE fasfnoticetx
/

CREATE TABLE fasfnoticetx
    (autoid                         NUMBER(20,0),
    refkey                         VARCHAR2(30 BYTE),
    reffundsfid                    NUMBER,
    txdate                         DATE,
    txnum                          VARCHAR2(20 BYTE),
    txbors                         CHAR(1 BYTE),
    fundcodeid                     VARCHAR2(20 BYTE),
    custodycd                      VARCHAR2(50 BYTE),
    refsymbol                      VARCHAR2(60 BYTE),
    txdesc                         VARCHAR2(300 BYTE),
    txamt                          NUMBER(20,0),
    txqtty                         NUMBER(20,0),
    feeamt                         NUMBER(20,0),
    deltd                          CHAR(1 BYTE) DEFAULT 'N',
    status                         CHAR(1 BYTE) DEFAULT 'T',
    reftxdate                      DATE,
    reftxnum                       VARCHAR2(20 BYTE),
    busdate                        DATE,
    createdby                      VARCHAR2(100 BYTE),
    intlastdt                      DATE,
    transdate                      DATE,
    ismaturity                     VARCHAR2(100 BYTE),
    idobject                       VARCHAR2(100 BYTE))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE fatca
/

CREATE TABLE fatca
    (custid                         VARCHAR2(30 BYTE) NOT NULL,
    isuscitizen                    VARCHAR2(1 BYTE),
    isusplaceofbirth               VARCHAR2(1 BYTE),
    isusmail                       VARCHAR2(1 BYTE),
    isusphone                      VARCHAR2(1 BYTE),
    isustranfer                    VARCHAR2(1 BYTE),
    isauthrigh                     VARCHAR2(1 BYTE),
    issoleaddress                  VARCHAR2(1 BYTE),
    opndate                        TIMESTAMP (6),
    isdisagree                     VARCHAR2(1 BYTE),
    isopposition                   VARCHAR2(1 BYTE),
    isussign                       VARCHAR2(1 BYTE),
    reopndate                      TIMESTAMP (6),
    w9orw8ben                      VARCHAR2(10 BYTE),
    fullname                       VARCHAR2(100 BYTE),
    roomnumber                     VARCHAR2(100 BYTE),
    city                           VARCHAR2(100 BYTE),
    state                          VARCHAR2(100 BYTE),
    national                       VARCHAR2(100 BYTE),
    zipcode                        VARCHAR2(100 BYTE),
    isssn                          VARCHAR2(1 BYTE),
    isirs                          VARCHAR2(1 BYTE),
    other                          VARCHAR2(100 BYTE),
    w8mailroomnumber               VARCHAR2(100 BYTE),
    w8mailcity                     VARCHAR2(100 BYTE),
    w8mailstate                    VARCHAR2(100 BYTE),
    w8mailnational                 VARCHAR2(100 BYTE),
    w8mailzipcode                  VARCHAR2(100 BYTE),
    idenumtax                      VARCHAR2(100 BYTE),
    foreigntax                     VARCHAR2(50 BYTE),
    ref                            VARCHAR2(50 BYTE),
    firstcall                      TIMESTAMP (6),
    firstnote                      VARCHAR2(200 BYTE),
    secondcall                     TIMESTAMP (6),
    secondnote                     VARCHAR2(200 BYTE),
    thirthcall                     TIMESTAMP (6),
    thirthnote                     VARCHAR2(200 BYTE),
    isus                           VARCHAR2(1 BYTE),
    signdate                       TIMESTAMP (6),
    note                           VARCHAR2(200 BYTE),
    status                         VARCHAR2(1 BYTE),
    pstatus                        VARCHAR2(200 BYTE),
    lastchange                     TIMESTAMP (6))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE fatca_edit_temp
/

CREATE TABLE fatca_edit_temp
    (custid                         VARCHAR2(30 BYTE),
    isuscitizen                    VARCHAR2(1 BYTE),
    isusplaceofbirth               VARCHAR2(1 BYTE),
    isusmail                       VARCHAR2(1 BYTE),
    isusphone                      VARCHAR2(1 BYTE),
    isustranfer                    VARCHAR2(1 BYTE),
    isauthrigh                     VARCHAR2(1 BYTE),
    issoleaddress                  VARCHAR2(1 BYTE),
    opndate                        TIMESTAMP (6),
    isdisagree                     VARCHAR2(1 BYTE),
    isopposition                   VARCHAR2(1 BYTE),
    isussign                       VARCHAR2(1 BYTE),
    reopndate                      TIMESTAMP (6),
    w9orw8ben                      VARCHAR2(10 BYTE),
    fullname                       VARCHAR2(100 BYTE),
    roomnumber                     VARCHAR2(100 BYTE),
    city                           VARCHAR2(100 BYTE),
    state                          VARCHAR2(100 BYTE),
    national                       VARCHAR2(100 BYTE),
    zipcode                        VARCHAR2(100 BYTE),
    isssn                          VARCHAR2(1 BYTE),
    isirs                          VARCHAR2(1 BYTE),
    other                          VARCHAR2(100 BYTE),
    w8mailroomnumber               VARCHAR2(100 BYTE),
    w8mailcity                     VARCHAR2(100 BYTE),
    w8mailstate                    VARCHAR2(100 BYTE),
    w8mailnational                 VARCHAR2(100 BYTE),
    w8mailzipcode                  VARCHAR2(100 BYTE),
    idenumtax                      VARCHAR2(100 BYTE),
    foreigntax                     VARCHAR2(50 BYTE),
    ref                            VARCHAR2(50 BYTE),
    firstcall                      TIMESTAMP (6),
    firstnote                      VARCHAR2(200 BYTE),
    secondcall                     TIMESTAMP (6),
    secondnote                     VARCHAR2(200 BYTE),
    thirthcall                     TIMESTAMP (6),
    thirthnote                     VARCHAR2(200 BYTE),
    isus                           VARCHAR2(1 BYTE),
    signdate                       TIMESTAMP (6),
    note                           VARCHAR2(500 BYTE),
    status                         VARCHAR2(1 BYTE),
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6),
    isotp                          VARCHAR2(2 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE fatca_edit_temp_hist
/

CREATE TABLE fatca_edit_temp_hist
    (custid                         VARCHAR2(30 BYTE),
    isuscitizen                    VARCHAR2(1 BYTE),
    isusplaceofbirth               VARCHAR2(1 BYTE),
    isusmail                       VARCHAR2(1 BYTE),
    isusphone                      VARCHAR2(1 BYTE),
    isustranfer                    VARCHAR2(1 BYTE),
    isauthrigh                     VARCHAR2(1 BYTE),
    issoleaddress                  VARCHAR2(1 BYTE),
    opndate                        TIMESTAMP (6),
    isdisagree                     VARCHAR2(1 BYTE),
    isopposition                   VARCHAR2(1 BYTE),
    isussign                       VARCHAR2(1 BYTE),
    reopndate                      TIMESTAMP (6),
    w9orw8ben                      VARCHAR2(10 BYTE),
    fullname                       VARCHAR2(100 BYTE),
    roomnumber                     VARCHAR2(100 BYTE),
    city                           VARCHAR2(100 BYTE),
    state                          VARCHAR2(100 BYTE),
    national                       VARCHAR2(100 BYTE),
    zipcode                        VARCHAR2(100 BYTE),
    isssn                          VARCHAR2(1 BYTE),
    isirs                          VARCHAR2(1 BYTE),
    other                          VARCHAR2(100 BYTE),
    w8mailroomnumber               VARCHAR2(100 BYTE),
    w8mailcity                     VARCHAR2(100 BYTE),
    w8mailstate                    VARCHAR2(100 BYTE),
    w8mailnational                 VARCHAR2(100 BYTE),
    w8mailzipcode                  VARCHAR2(100 BYTE),
    idenumtax                      VARCHAR2(100 BYTE),
    foreigntax                     VARCHAR2(50 BYTE),
    ref                            VARCHAR2(50 BYTE),
    firstcall                      TIMESTAMP (6),
    firstnote                      VARCHAR2(200 BYTE),
    secondcall                     TIMESTAMP (6),
    secondnote                     VARCHAR2(200 BYTE),
    thirthcall                     TIMESTAMP (6),
    thirthnote                     VARCHAR2(200 BYTE),
    isus                           VARCHAR2(1 BYTE),
    signdate                       TIMESTAMP (6),
    note                           VARCHAR2(500 BYTE),
    status                         VARCHAR2(1 BYTE),
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6),
    isotp                          VARCHAR2(2 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE fatca_temp
/

CREATE TABLE fatca_temp
    (custid                         VARCHAR2(30 BYTE) ,
    isuscitizen                    VARCHAR2(1 BYTE),
    isusplaceofbirth               VARCHAR2(1 BYTE),
    isusmail                       VARCHAR2(1 BYTE),
    isusphone                      VARCHAR2(1 BYTE),
    isustranfer                    VARCHAR2(1 BYTE),
    isauthrigh                     VARCHAR2(1 BYTE),
    issoleaddress                  VARCHAR2(1 BYTE),
    opndate                        TIMESTAMP (6),
    isdisagree                     VARCHAR2(1 BYTE),
    isopposition                   VARCHAR2(1 BYTE),
    isussign                       VARCHAR2(1 BYTE),
    reopndate                      TIMESTAMP (6),
    w9orw8ben                      VARCHAR2(10 BYTE),
    fullname                       VARCHAR2(100 BYTE),
    roomnumber                     VARCHAR2(100 BYTE),
    city                           VARCHAR2(100 BYTE),
    state                          VARCHAR2(100 BYTE),
    national                       VARCHAR2(100 BYTE),
    zipcode                        VARCHAR2(100 BYTE),
    isssn                          VARCHAR2(1 BYTE),
    isirs                          VARCHAR2(1 BYTE),
    other                          VARCHAR2(100 BYTE),
    w8mailroomnumber               VARCHAR2(100 BYTE),
    w8mailcity                     VARCHAR2(100 BYTE),
    w8mailstate                    VARCHAR2(100 BYTE),
    w8mailnational                 VARCHAR2(100 BYTE),
    w8mailzipcode                  VARCHAR2(100 BYTE),
    idenumtax                      VARCHAR2(100 BYTE),
    foreigntax                     VARCHAR2(50 BYTE),
    ref                            VARCHAR2(50 BYTE),
    firstcall                      TIMESTAMP (6),
    firstnote                      VARCHAR2(200 BYTE),
    secondcall                     TIMESTAMP (6),
    secondnote                     VARCHAR2(200 BYTE),
    thirthcall                     TIMESTAMP (6),
    thirthnote                     VARCHAR2(200 BYTE),
    isus                           VARCHAR2(1 BYTE),
    signdate                       TIMESTAMP (6),
    note                           VARCHAR2(500 BYTE),
    status                         VARCHAR2(1 BYTE),
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6),
    isotp                          VARCHAR2(20 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

ALTER TABLE fatca_temp
ADD CONSTRAINT fatca_temp_pkey PRIMARY KEY (custid)
USING INDEX
/

DROP TABLE fatca_temp_hist
/

CREATE TABLE fatca_temp_hist
    (custid                         VARCHAR2(30 BYTE),
    isuscitizen                    VARCHAR2(1 BYTE),
    isusplaceofbirth               VARCHAR2(1 BYTE),
    isusmail                       VARCHAR2(1 BYTE),
    isusphone                      VARCHAR2(1 BYTE),
    isustranfer                    VARCHAR2(1 BYTE),
    isauthrigh                     VARCHAR2(1 BYTE),
    issoleaddress                  VARCHAR2(1 BYTE),
    opndate                        TIMESTAMP (6),
    isdisagree                     VARCHAR2(1 BYTE),
    isopposition                   VARCHAR2(1 BYTE),
    isussign                       VARCHAR2(1 BYTE),
    reopndate                      TIMESTAMP (6),
    w9orw8ben                      VARCHAR2(10 BYTE),
    fullname                       VARCHAR2(100 BYTE),
    roomnumber                     VARCHAR2(100 BYTE),
    city                           VARCHAR2(100 BYTE),
    state                          VARCHAR2(100 BYTE),
    national                       VARCHAR2(100 BYTE),
    zipcode                        VARCHAR2(100 BYTE),
    isssn                          VARCHAR2(1 BYTE),
    isirs                          VARCHAR2(1 BYTE),
    other                          VARCHAR2(100 BYTE),
    w8mailroomnumber               VARCHAR2(100 BYTE),
    w8mailcity                     VARCHAR2(100 BYTE),
    w8mailstate                    VARCHAR2(100 BYTE),
    w8mailnational                 VARCHAR2(100 BYTE),
    w8mailzipcode                  VARCHAR2(100 BYTE),
    idenumtax                      VARCHAR2(100 BYTE),
    foreigntax                     VARCHAR2(50 BYTE),
    ref                            VARCHAR2(50 BYTE),
    firstcall                      TIMESTAMP (6),
    firstnote                      VARCHAR2(200 BYTE),
    secondcall                     TIMESTAMP (6),
    secondnote                     VARCHAR2(200 BYTE),
    thirthcall                     TIMESTAMP (6),
    thirthnote                     VARCHAR2(200 BYTE),
    isus                           VARCHAR2(1 BYTE),
    signdate                       TIMESTAMP (6),
    note                           VARCHAR2(500 BYTE),
    status                         VARCHAR2(1 BYTE),
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6),
    isotp                          VARCHAR2(2 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE fatcamemo
/

CREATE TABLE fatcamemo
    (custid                         VARCHAR2(30 BYTE) NOT NULL,
    isuscitizen                    VARCHAR2(1 BYTE),
    isusplaceofbirth               VARCHAR2(1 BYTE),
    isusmail                       VARCHAR2(1 BYTE),
    isusphone                      VARCHAR2(1 BYTE),
    isustranfer                    VARCHAR2(1 BYTE),
    isauthrigh                     VARCHAR2(1 BYTE),
    issoleaddress                  VARCHAR2(1 BYTE),
    opndate                        TIMESTAMP (6),
    isdisagree                     VARCHAR2(1 BYTE),
    isopposition                   VARCHAR2(1 BYTE),
    isussign                       VARCHAR2(1 BYTE),
    reopndate                      TIMESTAMP (6),
    w9orw8ben                      VARCHAR2(10 BYTE),
    fullname                       VARCHAR2(100 BYTE),
    roomnumber                     VARCHAR2(100 BYTE),
    city                           VARCHAR2(100 BYTE),
    state                          VARCHAR2(100 BYTE),
    national                       VARCHAR2(100 BYTE),
    zipcode                        VARCHAR2(100 BYTE),
    isssn                          VARCHAR2(1 BYTE),
    isirs                          VARCHAR2(1 BYTE),
    other                          VARCHAR2(100 BYTE),
    w8mailroomnumber               VARCHAR2(100 BYTE),
    w8mailcity                     VARCHAR2(100 BYTE),
    w8mailstate                    VARCHAR2(100 BYTE),
    w8mailnational                 VARCHAR2(100 BYTE),
    w8mailzipcode                  VARCHAR2(100 BYTE),
    idenumtax                      VARCHAR2(100 BYTE),
    foreigntax                     VARCHAR2(50 BYTE),
    ref                            VARCHAR2(50 BYTE),
    firstcall                      TIMESTAMP (6),
    firstnote                      VARCHAR2(200 BYTE),
    secondcall                     TIMESTAMP (6),
    secondnote                     VARCHAR2(200 BYTE),
    thirthcall                     TIMESTAMP (6),
    thirthnote                     VARCHAR2(200 BYTE),
    isus                           VARCHAR2(1 BYTE),
    signdate                       TIMESTAMP (6),
    note                           VARCHAR2(500 BYTE),
    status                         VARCHAR2(1 BYTE),
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE fee_dtl
/

CREATE TABLE fee_dtl
    (autoid                         NUMBER(*,0),
    orderid                        VARCHAR2(20 BYTE),
    acbuyer                        VARCHAR2(20 BYTE),
    fee                            NUMBER(*,0),
    types                          VARCHAR2(20 BYTE),
    acseller                       VARCHAR2(100 BYTE),
    feetype                        VARCHAR2(20 BYTE),
    deltd                          VARCHAR2(2 BYTE),
    feeid                          NUMBER)
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE feeapply
/

CREATE TABLE feeapply
    (id                             VARCHAR2(10 BYTE) NOT NULL,
    feeid                          VARCHAR2(10 BYTE),
    objfeetype                     VARCHAR2(100 BYTE),
    objname                        VARCHAR2(100 BYTE),
    objfeevalue                    VARCHAR2(100 BYTE),
    status                         VARCHAR2(1 BYTE) DEFAULT 'P',
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6),
    frdate                         DATE,
    todate                         DATE,
    ratedensity                    NUMBER DEFAULT 0,
    maxvalue                       NUMBER(38,0),
    threshold                      NUMBER DEFAULT 0)
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE feeapply_log
/

CREATE TABLE feeapply_log
    (id                             VARCHAR2(10 BYTE),
    logid                          VARCHAR2(10 BYTE),
    feeid                          VARCHAR2(10 BYTE),
    objfeetype                     VARCHAR2(100 BYTE),
    objfeevalue                    VARCHAR2(100 BYTE),
    frdate                         DATE,
    todate                         DATE,
    ratedensity                    NUMBER DEFAULT 0,
    maxvalue                       NUMBER(38,0),
    threshold                      NUMBER DEFAULT 0,
    lastchange                     TIMESTAMP (6),
    txnum                          VARCHAR2(30 BYTE),
    txdate                         DATE,
    action_type                    VARCHAR2(10 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE feeapplyflt
/

CREATE TABLE feeapplyflt
    (id                             FLOAT(64) NOT NULL,
    aplid                          VARCHAR2(10 BYTE),
    sqlstr                         VARCHAR2(500 BYTE),
    status                         VARCHAR2(1 BYTE),
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

ALTER TABLE feeapplyflt
ADD CONSTRAINT feeapplyflt_pkey PRIMARY KEY (id)
USING INDEX
/

DROP TABLE feeapplymemo
/

CREATE TABLE feeapplymemo
    (id                             VARCHAR2(10 BYTE) NOT NULL,
    feeid                          VARCHAR2(10 BYTE),
    objfeetype                     VARCHAR2(100 BYTE),
    objname                        VARCHAR2(100 BYTE),
    objfeevalue                    VARCHAR2(100 BYTE),
    status                         VARCHAR2(1 BYTE) DEFAULT 'P',
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6),
    frdate                         DATE,
    todate                         DATE,
    ratedensity                    NUMBER DEFAULT 0,
    maxvalue                       NUMBER(38,0),
    threshold                      NUMBER DEFAULT 0)
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE feemap
/

CREATE TABLE feemap
    (autoid                         BINARY_DOUBLE,
    feecd                          VARCHAR2(5 BYTE),
    tltxcd                         VARCHAR2(4 BYTE),
    amtexp                         VARCHAR2(30 BYTE),
    reffield                       VARCHAR2(50 BYTE))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE feemaster
/

CREATE TABLE feemaster
    (id                             VARCHAR2(10 BYTE),
    aplid                          VARCHAR2(10 BYTE),
    ordfee                         VARCHAR2(20 BYTE),
    forp                           VARCHAR2(1 BYTE),
    feecalc                        VARCHAR2(1 BYTE),
    feeamt                         BINARY_DOUBLE,
    feerate                        BINARY_DOUBLE,
    minamt                         BINARY_DOUBLE,
    maxamt                         BINARY_DOUBLE,
    frdate                         TIMESTAMP (6),
    todate                         TIMESTAMP (6),
    status                         VARCHAR2(1 BYTE) DEFAULT 'P',
    pstatus                        VARCHAR2(4000 BYTE),
    ver                            VARCHAR2(100 BYTE),
    lastchange                     TIMESTAMP (6),
    baseon                         VARCHAR2(10 BYTE),
    holdtime                       VARCHAR2(1 BYTE),
    holdtype                       VARCHAR2(3 BYTE),
    note                           VARCHAR2(4000 BYTE),
    ratetime                       VARCHAR2(3 BYTE),
    calnav                         VARCHAR2(3 BYTE),
    navtime                        VARCHAR2(3 BYTE),
    obligatesell                   VARCHAR2(10 BYTE),
    sellpriority                   VARCHAR2(10 BYTE),
    stopsip                        VARCHAR2(10 BYTE),
    isreserve                      VARCHAR2(10 BYTE),
    feeconvert                     VARCHAR2(50 BYTE),
    feeratepunish                  BINARY_DOUBLE)
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE feemastermemo
/

CREATE TABLE feemastermemo
    (id                             VARCHAR2(10 BYTE),
    aplid                          VARCHAR2(10 BYTE),
    ordfee                         VARCHAR2(20 BYTE),
    forp                           VARCHAR2(1 BYTE),
    feecalc                        VARCHAR2(1 BYTE),
    feeamt                         BINARY_DOUBLE,
    feerate                        BINARY_DOUBLE,
    minamt                         BINARY_DOUBLE,
    maxamt                         BINARY_DOUBLE,
    frdate                         TIMESTAMP (6),
    todate                         TIMESTAMP (6),
    status                         VARCHAR2(1 BYTE) DEFAULT 'P',
    pstatus                        VARCHAR2(4000 BYTE),
    ver                            VARCHAR2(100 BYTE),
    lastchange                     TIMESTAMP (6),
    baseon                         VARCHAR2(10 BYTE),
    holdtime                       VARCHAR2(1 BYTE),
    holdtype                       VARCHAR2(3 BYTE),
    note                           VARCHAR2(4000 BYTE),
    ratetime                       VARCHAR2(3 BYTE),
    calnav                         VARCHAR2(3 BYTE),
    navtime                        VARCHAR2(3 BYTE),
    obligatesell                   VARCHAR2(10 BYTE),
    sellpriority                   VARCHAR2(10 BYTE),
    stopsip                        VARCHAR2(10 BYTE),
    isreserve                      VARCHAR2(10 BYTE),
    feeconvert                     VARCHAR2(50 BYTE),
    feeratepunish                  BINARY_DOUBLE)
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE feetier
/

CREATE TABLE feetier
    (id                             NUMBER(38,0),
    feeid                          NUMBER(38,0),
    tiername                       VARCHAR2(200 BYTE),
    framt                          NUMBER(38,0),
    toamt                          NUMBER(38,0),
    frday                          NUMBER(38,0),
    today                          NUMBER(38,0),
    frdate                         DATE,
    todate                         DATE,
    feeamt                         NUMBER(38,0),
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

DROP TABLE feetiermemo
/

CREATE TABLE feetiermemo
    (id                             NUMBER(38,0),
    feeid                          NUMBER(38,0),
    tiername                       VARCHAR2(200 BYTE),
    framt                          NUMBER(38,0),
    toamt                          NUMBER(38,0),
    frday                          NUMBER(38,0),
    today                          NUMBER(38,0),
    frdate                         DATE,
    todate                         DATE,
    feeamt                         NUMBER(38,0),
    feerate                        NUMBER(10,5),
    status                         VARCHAR2(1 BYTE),
    pstatus                        VARCHAR2(4000 BYTE),
    ver                            VARCHAR2(100 BYTE),
    lastchange                     TIMESTAMP (6),
    action                         VARCHAR2(10 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE feetype
/

CREATE TABLE feetype
    (id                             NUMBER(38,0),
    feename                        VARCHAR2(200 BYTE),
    feetype                        VARCHAR2(200 BYTE),
    ruletype                       VARCHAR2(10 BYTE),
    feecalc                        VARCHAR2(10 BYTE),
    feeamt                         NUMBER(38,2),
    feerate                        NUMBER(10,5),
    minamt                         NUMBER(38,0),
    maxamt                         NUMBER(38,0),
    frdate                         DATE,
    todate                         DATE,
    status                         VARCHAR2(3 BYTE) DEFAULT 'P',
    pstatus                        VARCHAR2(4000 BYTE),
    ver                            VARCHAR2(100 BYTE),
    lastchange                     TIMESTAMP (6),
    feetierdata                    VARCHAR2(4000 BYTE),
    vsdfeeid                       VARCHAR2(50 BYTE),
    note                           VARCHAR2(100 BYTE),
    exectype                       VARCHAR2(10 BYTE),
    srtype                         VARCHAR2(10 BYTE),
    symbol                         VARCHAR2(30 BYTE),
    isapplydealer                  VARCHAR2(1 BYTE) DEFAULT 'N',
    feevat                         NUMBER(10,5),
    mechanism                      VARCHAR2(200 BYTE),
    typecustomer                   VARCHAR2(200 BYTE),
    aftype                         VARCHAR2(30 BYTE),
    nationality                    VARCHAR2(30 BYTE),
    product                        VARCHAR2(50 BYTE),
    dealertype                     VARCHAR2(30 BYTE),
    sbsedefacct                    VARCHAR2(20 BYTE),
    calcmethod                     VARCHAR2(10 BYTE),
    accrbasic                      VARCHAR2(10 BYTE),
    iscalcrate                     VARCHAR2(10 BYTE),
    iscalcsettamt                  VARCHAR2(10 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE feetype_bk
/

CREATE TABLE feetype_bk
    (id                             FLOAT(64),
    feename                        VARCHAR2(200 BYTE),
    feetype                        VARCHAR2(200 BYTE),
    ruletype                       VARCHAR2(10 BYTE),
    feecalc                        VARCHAR2(10 BYTE),
    feeamt                         BINARY_DOUBLE,
    feerate                        BINARY_DOUBLE,
    minamt                         BINARY_DOUBLE,
    maxamt                         BINARY_DOUBLE,
    frdate                         DATE,
    todate                         DATE,
    status                         VARCHAR2(3 BYTE),
    pstatus                        VARCHAR2(4000 BYTE),
    ver                            VARCHAR2(100 BYTE),
    lastchange                     TIMESTAMP (6),
    feetierdata                    VARCHAR2(4000 BYTE),
    vsdfeeid                       VARCHAR2(10 BYTE),
    note                           VARCHAR2(100 BYTE),
    exectype                       VARCHAR2(10 BYTE),
    srtype                         VARCHAR2(10 BYTE),
    symbol                         VARCHAR2(30 BYTE),
    isapplydealer                  VARCHAR2(1 BYTE),
    feevat                         BINARY_DOUBLE,
    mechanism                      VARCHAR2(200 BYTE),
    typecustomer                   VARCHAR2(200 BYTE),
    aftype                         VARCHAR2(30 BYTE),
    nationality                    VARCHAR2(30 BYTE),
    product                        VARCHAR2(50 BYTE),
    dealertype                     VARCHAR2(30 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE feetypememo
/

CREATE TABLE feetypememo
    (id                             NUMBER(38,0),
    feename                        VARCHAR2(200 BYTE),
    feetype                        VARCHAR2(200 BYTE),
    ruletype                       VARCHAR2(10 BYTE),
    feecalc                        VARCHAR2(10 BYTE),
    feeamt                         NUMBER(38,0),
    feerate                        NUMBER(10,5),
    minamt                         NUMBER(38,0),
    maxamt                         NUMBER(38,0),
    frdate                         DATE,
    todate                         DATE,
    status                         VARCHAR2(3 BYTE) DEFAULT 'P',
    pstatus                        VARCHAR2(4000 BYTE),
    ver                            VARCHAR2(100 BYTE),
    lastchange                     TIMESTAMP (6),
    feetierdata                    VARCHAR2(4000 BYTE),
    vsdfeeid                       VARCHAR2(50 BYTE),
    note                           VARCHAR2(100 BYTE),
    exectype                       VARCHAR2(10 BYTE),
    srtype                         VARCHAR2(10 BYTE),
    symbol                         VARCHAR2(30 BYTE),
    isapplydealer                  VARCHAR2(1 BYTE) DEFAULT 'N',
    feevat                         NUMBER(10,5),
    mechanism                      VARCHAR2(200 BYTE),
    typecustomer                   VARCHAR2(200 BYTE),
    aftype                         VARCHAR2(30 BYTE),
    nationality                    VARCHAR2(30 BYTE),
    product                        VARCHAR2(50 BYTE),
    dealertype                     VARCHAR2(30 BYTE),
    sbsedefacct                    VARCHAR2(20 BYTE),
    calcmethod                     VARCHAR2(10 BYTE),
    accrbasic                      VARCHAR2(10 BYTE),
    iscalcrate                     VARCHAR2(10 BYTE),
    iscalcsettamt                  VARCHAR2(10 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE feevar
/

CREATE TABLE feevar
    (autoid                         NUMBER NOT NULL,
    feetype                        VARCHAR2(10 BYTE),
    feename                        VARCHAR2(100 BYTE),
    trntype                        VARCHAR2(100 BYTE),
    status                         VARCHAR2(1 BYTE) DEFAULT 'A',
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6),
    calcmethod                     VARCHAR2(10 BYTE) DEFAULT 'V')
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE feevarmemo
/

CREATE TABLE feevarmemo
    (autoid                         NUMBER NOT NULL,
    feetype                        VARCHAR2(10 BYTE),
    feename                        VARCHAR2(100 BYTE),
    trntype                        VARCHAR2(100 BYTE),
    status                         VARCHAR2(1 BYTE) DEFAULT 'A',
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE fileimpopencf_log
/

CREATE TABLE fileimpopencf_log
    (autoid                         FLOAT(64),
    txdate                         DATE,
    ver                            VARCHAR2(50 BYTE),
    objname                        VARCHAR2(50 BYTE),
    fullname                       VARCHAR2(500 BYTE),
    idtype                         VARCHAR2(50 BYTE),
    idcode                         VARCHAR2(50 BYTE),
    iddate                         DATE,
    idexpdated                     DATE,
    idplace                        VARCHAR2(50 BYTE),
    tradingcode                    VARCHAR2(50 BYTE),
    tradingdate                    DATE,
    birthdate                      DATE,
    sex                            VARCHAR2(3 BYTE),
    country                        VARCHAR2(3 BYTE),
    taxno                          VARCHAR2(50 BYTE),
    regaddress                     VARCHAR2(500 BYTE),
    address                        VARCHAR2(500 BYTE),
    mobile                         VARCHAR2(50 BYTE),
    fax                            VARCHAR2(30 BYTE),
    email                          VARCHAR2(50 BYTE),
    investtype                     VARCHAR2(5 BYTE),
    custtype                       VARCHAR2(10 BYTE),
    grinvestor                     VARCHAR2(10 BYTE),
    bankacc                        VARCHAR2(20 BYTE),
    bankcode                       VARCHAR2(20 BYTE),
    citybank                       VARCHAR2(500 BYTE),
    careby                         VARCHAR2(20 BYTE),
    tlid                           VARCHAR2(20 BYTE),
    offid                          VARCHAR2(20 BYTE),
    status                         VARCHAR2(20 BYTE),
    feedbackmsg                    VARCHAR2(20 BYTE),
    lastchange                     TIMESTAMP (6) DEFAULT to_date('0001-01-01 00:00:00', 'YYYY-MM-DD hh24:mi:ss'))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE fileimporder
/

CREATE TABLE fileimporder
    (autoid                         FLOAT(32) DEFAULT 0 NOT NULL,
    fileid                         VARCHAR2(50 BYTE),
    dbcode                         VARCHAR2(4 BYTE),
    custodycd                      VARCHAR2(10 BYTE),
    fullname                       VARCHAR2(200 BYTE),
    idcode                         VARCHAR2(200 BYTE),
    iddate                         VARCHAR2(200 BYTE),
    idplace                        VARCHAR2(200 BYTE),
    address                        VARCHAR2(200 BYTE),
    symbol                         VARCHAR2(100 BYTE),
    odtype                         VARCHAR2(10 BYTE),
    feeid                          VARCHAR2(100 BYTE),
    qtty                           BINARY_DOUBLE,
    amount                         BINARY_DOUBLE,
    swsymbol                       VARCHAR2(100 BYTE),
    swfeeid                        VARCHAR2(100 BYTE),
    imptlid                        VARCHAR2(4 BYTE),
    apprtlid                       VARCHAR2(4 BYTE),
    mbid                           VARCHAR2(6 BYTE),
    deltd                          VARCHAR2(1 BYTE),
    status                         VARCHAR2(1 BYTE) DEFAULT 'N',
    errmsg                         VARCHAR2(500 BYTE),
    objname                        VARCHAR2(200 BYTE),
    ver                            VARCHAR2(200 BYTE),
    isotpchk                       VARCHAR2(1 BYTE) DEFAULT 'Y',
    lastchange                     TIMESTAMP (6))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE fileimporder_log
/

CREATE TABLE fileimporder_log
    (autoid                         FLOAT(32) DEFAULT 0 NOT NULL,
    fileid                         VARCHAR2(50 BYTE),
    dbcode                         VARCHAR2(4 BYTE),
    custodycd                      VARCHAR2(10 BYTE),
    fullname                       VARCHAR2(200 BYTE),
    idcode                         VARCHAR2(200 BYTE),
    iddate                         VARCHAR2(200 BYTE),
    idplace                        VARCHAR2(200 BYTE),
    address                        VARCHAR2(200 BYTE),
    symbol                         VARCHAR2(100 BYTE),
    odtype                         VARCHAR2(10 BYTE),
    feeid                          VARCHAR2(100 BYTE),
    qtty                           BINARY_DOUBLE,
    amount                         BINARY_DOUBLE,
    swsymbol                       VARCHAR2(100 BYTE),
    swfeeid                        VARCHAR2(100 BYTE),
    imptlid                        VARCHAR2(4 BYTE),
    apprtlid                       VARCHAR2(4 BYTE),
    mbid                           VARCHAR2(6 BYTE),
    deltd                          VARCHAR2(1 BYTE),
    status                         VARCHAR2(1 BYTE) DEFAULT 'N',
    errmsg                         VARCHAR2(500 BYTE),
    objname                        VARCHAR2(200 BYTE),
    ver                            VARCHAR2(200 BYTE),
    isotpchk                       VARCHAR2(1 BYTE) DEFAULT 'Y',
    lastchange                     TIMESTAMP (6))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE fileimpr49_logs
/

CREATE TABLE fileimpr49_logs
    (id                             FLOAT(32) DEFAULT 0 NOT NULL,
    ver                            VARCHAR2(50 BYTE),
    dbcode                         VARCHAR2(50 BYTE),
    tlid                           VARCHAR2(50 BYTE),
    txdate                         VARCHAR2(20 BYTE),
    orderid                        VARCHAR2(20 BYTE),
    custodycd                      VARCHAR2(50 BYTE),
    fullname                       VARCHAR2(50 BYTE),
    idcode                         VARCHAR2(50 BYTE),
    iddate                         VARCHAR2(50 BYTE),
    actype                         VARCHAR2(50 BYTE),
    address                        VARCHAR2(250 BYTE),
    taxcode                        VARCHAR2(50 BYTE),
    srtype                         VARCHAR2(50 BYTE),
    matchqtty                      FLOAT(24),
    feeamt                         FLOAT(24),
    feeamc                         FLOAT(24),
    taxamt                         FLOAT(24),
    matchamt                       FLOAT(24),
    amt                            FLOAT(24),
    tradingid                      VARCHAR2(50 BYTE),
    tradingdt                      VARCHAR2(50 BYTE),
    istxnum                        VARCHAR2(10 BYTE),
    dealtype                       VARCHAR2(10 BYTE),
    symbol                         VARCHAR2(50 BYTE),
    status                         CHAR(1 BYTE) DEFAULT 'V',
    errdesc                        VARCHAR2(4000 BYTE),
    lastchanged                    TIMESTAMP (6))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

ALTER TABLE fileimpr49_logs
ADD CONSTRAINT fileimpr49_logs_pkey PRIMARY KEY (id)
USING INDEX
/

DROP TABLE filemap
/

CREATE TABLE filemap
    (filecode                       VARCHAR2(5 BYTE),
    filerowname                    VARCHAR2(50 BYTE),
    tblrowname                     VARCHAR2(50 BYTE),
    tblrowtype                     VARCHAR2(50 BYTE),
    acctnofld                      CHAR(1 BYTE),
    tblrowmaxlength                BINARY_DOUBLE,
    changetype                     CHAR(1 BYTE),
    deltd                          CHAR(1 BYTE),
    disabled                       CHAR(1 BYTE),
    visible                        CHAR(1 BYTE),
    lstodr                         FLOAT(64),
    fielddesc                      VARCHAR2(100 BYTE),
    sumamt                         CHAR(1 BYTE),
    fieldcmpkey                    VARCHAR2(1 BYTE) DEFAULT 'N',
    fieldcmp                       VARCHAR2(1 BYTE) DEFAULT 'N',
    fielddesc_en                   VARCHAR2(200 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE filemaster
/

CREATE TABLE filemaster
    (eori                           CHAR(1 BYTE),
    filecode                       VARCHAR2(5 BYTE),
    filename                       VARCHAR2(200 BYTE),
    filepath                       VARCHAR2(300 BYTE),
    tablename                      VARCHAR2(50 BYTE),
    sheetname                      VARCHAR2(50 BYTE),
    rowtitle                       BINARY_DOUBLE,
    deltd                          CHAR(1 BYTE),
    extention                      VARCHAR2(10 BYTE),
    page                           BINARY_DOUBLE,
    procname                       VARCHAR2(200 BYTE),
    procfillter                    VARCHAR2(200 BYTE),
    ovrrqd                         CHAR(1 BYTE),
    modcode                        VARCHAR2(3 BYTE),
    rptid                          VARCHAR2(8 BYTE),
    cmdcode                        VARCHAR2(2 BYTE),
    procnamereject                 VARCHAR2(200 BYTE),
    iscompare                      VARCHAR2(1 BYTE) DEFAULT 'N',
    cmpsql                         VARCHAR2(4000 BYTE) DEFAULT '',
    filename_en                    VARCHAR2(4000 BYTE),
    cmdsql                         VARCHAR2(4000 BYTE),
    cmdsql_en                      VARCHAR2(4000 BYTE),
    lstodr                         BINARY_DOUBLE,
    orderbycmdsql                  VARCHAR2(4000 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE firstdepositdtl
/

CREATE TABLE firstdepositdtl
    (codeid                         FLOAT(32) DEFAULT 0 NOT NULL,
    symbol                         VARCHAR2(50 BYTE) NOT NULL,
    custodycd                      VARCHAR2(50 BYTE) NOT NULL,
    trade                          BINARY_DOUBLE NOT NULL,
    txnum                          VARCHAR2(30 BYTE),
    txdate                         DATE)
  NOPARALLEL
  NOLOGGING
  MONITORING
/

ALTER TABLE firstdepositdtl
ADD CONSTRAINT firstdepositdtl_pkey PRIMARY KEY (codeid)
USING INDEX
/

DROP TABLE fldamtexp
/

CREATE TABLE fldamtexp
    (modcode                        VARCHAR2(10 BYTE),
    objname                        VARCHAR2(50 BYTE),
    fldname                        VARCHAR2(50 BYTE),
    odrnum                         FLOAT(64) DEFAULT 0,
    amtexp                         VARCHAR2(200 BYTE),
    amtexpcaption                  VARCHAR2(100 BYTE),
    en_amtexpcaption               VARCHAR2(100 BYTE))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE flddefdesc
/

CREATE TABLE flddefdesc
    (tltxcd                         VARCHAR2(4 BYTE),
    tagname                        VARCHAR2(50 BYTE),
    maptype                        VARCHAR2(50 BYTE),
    mapname                        VARCHAR2(50 BYTE),
    objref                         VARCHAR2(250 BYTE))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE fldmaster
/

CREATE TABLE fldmaster
    (modcode                        VARCHAR2(3 BYTE) NOT NULL,
    fldname                        VARCHAR2(50 BYTE) NOT NULL,
    objname                        VARCHAR2(50 BYTE) NOT NULL,
    defname                        VARCHAR2(50 BYTE),
    caption                        VARCHAR2(400 BYTE),
    en_caption                     VARCHAR2(400 BYTE),
    odrnum                         NUMBER,
    fldtype                        VARCHAR2(1 BYTE),
    fldmask                        VARCHAR2(50 BYTE),
    fldformat                      VARCHAR2(50 BYTE),
    fldlen                         FLOAT(64),
    fldwidth                       FLOAT(64),
    llist                          VARCHAR2(250 BYTE),
    lchk                           VARCHAR2(255 BYTE),
    defval                         VARCHAR2(250 BYTE),
    visible                        VARCHAR2(1 BYTE),
    disable                        VARCHAR2(1 BYTE),
    mandatory                      VARCHAR2(1 BYTE),
    amtexp                         VARCHAR2(255 BYTE),
    validtag                       VARCHAR2(250 BYTE),
    lookup                         VARCHAR2(1 BYTE),
    datatype                       VARCHAR2(1 BYTE),
    invname                        VARCHAR2(20 BYTE),
    fldsource                      VARCHAR2(10 BYTE),
    flddesc                        VARCHAR2(10 BYTE),
    chainname                      VARCHAR2(50 BYTE),
    printinfo                      VARCHAR2(20 BYTE),
    lookupname                     VARCHAR2(20 BYTE),
    searchcode                     VARCHAR2(20 BYTE),
    srmodcode                      VARCHAR2(2 BYTE),
    invformat                      VARCHAR2(200 BYTE),
    ctltype                        VARCHAR2(1 BYTE),
    riskfld                        CHAR(1 BYTE),
    grname                         VARCHAR2(50 BYTE),
    tagfield                       VARCHAR2(50 BYTE),
    tagvalue                       VARCHAR2(100 BYTE),
    taglist                        VARCHAR2(250 BYTE),
    tagquery                       CHAR(1 BYTE),
    pdefname                       VARCHAR2(100 BYTE),
    tagupdate                      CHAR(1 BYTE),
    fldrnd                         VARCHAR2(5 BYTE),
    subfield                       CHAR(1 BYTE),
    pdefval                        VARCHAR2(100 BYTE),
    defdesc                        VARCHAR2(250 BYTE),
    defparam                       VARCHAR2(250 BYTE),
    lock_key                       VARCHAR2(5 BYTE) DEFAULT 'N',
    allowgen                       VARCHAR2(10 BYTE) DEFAULT 'Y')
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

CREATE INDEX fldmaster_idx01 ON fldmaster
  (
    objname                         ASC,
    fldname                         ASC
  )
NOPARALLEL
NOLOGGING
/


DROP TABLE fldmaster_bk
/

CREATE TABLE fldmaster_bk
    (modcode                        VARCHAR2(3 BYTE) NOT NULL,
    fldname                        VARCHAR2(50 BYTE) NOT NULL,
    objname                        VARCHAR2(50 BYTE) NOT NULL,
    defname                        VARCHAR2(50 BYTE),
    caption                        VARCHAR2(400 BYTE),
    en_caption                     VARCHAR2(400 BYTE),
    odrnum                         BINARY_DOUBLE,
    fldtype                        VARCHAR2(1 BYTE),
    fldmask                        VARCHAR2(50 BYTE),
    fldformat                      VARCHAR2(50 BYTE),
    fldlen                         FLOAT(64),
    fldwidth                       FLOAT(64),
    llist                          VARCHAR2(250 BYTE),
    lchk                           VARCHAR2(255 BYTE),
    defval                         VARCHAR2(250 BYTE),
    visible                        VARCHAR2(1 BYTE),
    disable                        VARCHAR2(1 BYTE),
    mandatory                      VARCHAR2(1 BYTE),
    amtexp                         VARCHAR2(255 BYTE),
    validtag                       VARCHAR2(250 BYTE),
    lookup                         VARCHAR2(1 BYTE),
    datatype                       VARCHAR2(1 BYTE),
    invname                        VARCHAR2(20 BYTE),
    fldsource                      VARCHAR2(10 BYTE),
    flddesc                        VARCHAR2(10 BYTE),
    chainname                      VARCHAR2(50 BYTE),
    printinfo                      VARCHAR2(20 BYTE),
    lookupname                     VARCHAR2(20 BYTE),
    searchcode                     VARCHAR2(20 BYTE),
    srmodcode                      VARCHAR2(2 BYTE),
    invformat                      VARCHAR2(200 BYTE),
    ctltype                        VARCHAR2(1 BYTE),
    riskfld                        CHAR(1 BYTE),
    grname                         VARCHAR2(50 BYTE),
    tagfield                       VARCHAR2(50 BYTE),
    tagvalue                       VARCHAR2(100 BYTE),
    taglist                        VARCHAR2(250 BYTE),
    tagquery                       CHAR(1 BYTE),
    pdefname                       VARCHAR2(100 BYTE),
    tagupdate                      CHAR(1 BYTE),
    fldrnd                         VARCHAR2(5 BYTE),
    subfield                       CHAR(1 BYTE),
    pdefval                        VARCHAR2(100 BYTE),
    defdesc                        VARCHAR2(250 BYTE),
    defparam                       VARCHAR2(250 BYTE),
    lock_key                       VARCHAR2(5 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE fldmaster_bk_1229
/

CREATE TABLE fldmaster_bk_1229
    (modcode                        VARCHAR2(3 BYTE) NOT NULL,
    fldname                        VARCHAR2(50 BYTE) NOT NULL,
    objname                        VARCHAR2(50 BYTE) NOT NULL,
    defname                        VARCHAR2(50 BYTE),
    caption                        VARCHAR2(400 BYTE),
    en_caption                     VARCHAR2(400 BYTE),
    odrnum                         BINARY_DOUBLE,
    fldtype                        VARCHAR2(1 BYTE),
    fldmask                        VARCHAR2(50 BYTE),
    fldformat                      VARCHAR2(50 BYTE),
    fldlen                         FLOAT(64),
    fldwidth                       FLOAT(64),
    llist                          VARCHAR2(250 BYTE),
    lchk                           VARCHAR2(255 BYTE),
    defval                         VARCHAR2(250 BYTE),
    visible                        VARCHAR2(1 BYTE),
    disable                        VARCHAR2(1 BYTE),
    mandatory                      VARCHAR2(1 BYTE),
    amtexp                         VARCHAR2(255 BYTE),
    validtag                       VARCHAR2(250 BYTE),
    lookup                         VARCHAR2(1 BYTE),
    datatype                       VARCHAR2(1 BYTE),
    invname                        VARCHAR2(20 BYTE),
    fldsource                      VARCHAR2(10 BYTE),
    flddesc                        VARCHAR2(10 BYTE),
    chainname                      VARCHAR2(50 BYTE),
    printinfo                      VARCHAR2(20 BYTE),
    lookupname                     VARCHAR2(20 BYTE),
    searchcode                     VARCHAR2(20 BYTE),
    srmodcode                      VARCHAR2(2 BYTE),
    invformat                      VARCHAR2(200 BYTE),
    ctltype                        VARCHAR2(1 BYTE),
    riskfld                        CHAR(1 BYTE),
    grname                         VARCHAR2(50 BYTE),
    tagfield                       VARCHAR2(50 BYTE),
    tagvalue                       VARCHAR2(100 BYTE),
    taglist                        VARCHAR2(250 BYTE),
    tagquery                       CHAR(1 BYTE),
    pdefname                       VARCHAR2(100 BYTE),
    tagupdate                      CHAR(1 BYTE),
    fldrnd                         VARCHAR2(5 BYTE),
    subfield                       CHAR(1 BYTE),
    pdefval                        VARCHAR2(100 BYTE),
    defdesc                        VARCHAR2(250 BYTE),
    defparam                       VARCHAR2(250 BYTE),
    lock_key                       VARCHAR2(5 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE fldmaster_bk_ofd
/

CREATE TABLE fldmaster_bk_ofd
    (modcode                        VARCHAR2(3 BYTE) NOT NULL,
    fldname                        VARCHAR2(50 BYTE) NOT NULL,
    objname                        VARCHAR2(50 BYTE) NOT NULL,
    defname                        VARCHAR2(50 BYTE),
    caption                        VARCHAR2(400 BYTE),
    en_caption                     VARCHAR2(400 BYTE),
    odrnum                         BINARY_DOUBLE,
    fldtype                        VARCHAR2(1 BYTE),
    fldmask                        VARCHAR2(50 BYTE),
    fldformat                      VARCHAR2(50 BYTE),
    fldlen                         FLOAT(64),
    fldwidth                       FLOAT(64),
    llist                          VARCHAR2(250 BYTE),
    lchk                           VARCHAR2(255 BYTE),
    defval                         VARCHAR2(250 BYTE),
    visible                        VARCHAR2(1 BYTE),
    disable                        VARCHAR2(1 BYTE),
    mandatory                      VARCHAR2(1 BYTE),
    amtexp                         VARCHAR2(255 BYTE),
    validtag                       VARCHAR2(250 BYTE),
    lookup                         VARCHAR2(1 BYTE),
    datatype                       VARCHAR2(1 BYTE),
    invname                        VARCHAR2(20 BYTE),
    fldsource                      VARCHAR2(10 BYTE),
    flddesc                        VARCHAR2(10 BYTE),
    chainname                      VARCHAR2(50 BYTE),
    printinfo                      VARCHAR2(20 BYTE),
    lookupname                     VARCHAR2(20 BYTE),
    searchcode                     VARCHAR2(20 BYTE),
    srmodcode                      VARCHAR2(2 BYTE),
    invformat                      VARCHAR2(200 BYTE),
    ctltype                        VARCHAR2(1 BYTE),
    riskfld                        CHAR(1 BYTE),
    grname                         VARCHAR2(50 BYTE),
    tagfield                       VARCHAR2(50 BYTE),
    tagvalue                       VARCHAR2(100 BYTE),
    taglist                        VARCHAR2(250 BYTE),
    tagquery                       CHAR(1 BYTE),
    pdefname                       VARCHAR2(100 BYTE),
    tagupdate                      CHAR(1 BYTE),
    fldrnd                         VARCHAR2(5 BYTE),
    subfield                       CHAR(1 BYTE),
    pdefval                        VARCHAR2(100 BYTE),
    defdesc                        VARCHAR2(250 BYTE),
    defparam                       VARCHAR2(250 BYTE),
    lock_key                       VARCHAR2(5 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE fldval
/

CREATE TABLE fldval
    (fldname                        VARCHAR2(50 BYTE),
    objname                        VARCHAR2(50 BYTE),
    odrnum                         FLOAT(64) DEFAULT 0,
    valtype                        VARCHAR2(3 BYTE),
    operator                       VARCHAR2(3 BYTE),
    valexp                         VARCHAR2(500 BYTE),
    valexp2                        VARCHAR2(500 BYTE),
    errmsg                         VARCHAR2(4000 BYTE),
    en_errmsg                      VARCHAR2(4000 BYTE),
    tagfield                       VARCHAR2(50 BYTE),
    tagvalue                       VARCHAR2(100 BYTE),
    chklev                         FLOAT(64) DEFAULT 0)
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE fmacctno
/

CREATE TABLE fmacctno
    (id                             FLOAT(64) NOT NULL,
    codeid                         VARCHAR2(50 BYTE),
    bankactype                     VARCHAR2(10 BYTE),
    bankacc                        VARCHAR2(50 BYTE),
    bankacname                     VARCHAR2(250 BYTE),
    bankname                       VARCHAR2(250 BYTE),
    branch                         VARCHAR2(50 BYTE),
    province                       VARCHAR2(50 BYTE),
    status                         VARCHAR2(10 BYTE) DEFAULT 'A',
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6),
    description                    VARCHAR2(4000 BYTE))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE fmacctnomemo
/

CREATE TABLE fmacctnomemo
    (id                             FLOAT(64),
    codeid                         VARCHAR2(50 BYTE),
    bankactype                     VARCHAR2(10 BYTE),
    bankacc                        VARCHAR2(50 BYTE),
    bankacname                     VARCHAR2(250 BYTE),
    bankname                       VARCHAR2(250 BYTE),
    branch                         VARCHAR2(50 BYTE),
    province                       VARCHAR2(50 BYTE),
    status                         VARCHAR2(10 BYTE),
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6),
    description                    VARCHAR2(4000 BYTE))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE fmembers
/

CREATE TABLE fmembers
    (id                             FLOAT(64) NOT NULL,
    codeid                         VARCHAR2(6 BYTE),
    fdfeeid                        VARCHAR2(10 BYTE),
    mbid                           VARCHAR2(10 BYTE),
    rolecode                       VARCHAR2(10 BYTE),
    contactperson                  VARCHAR2(100 BYTE),
    phonecontact                   VARCHAR2(100 BYTE),
    status                         VARCHAR2(10 BYTE) DEFAULT 'P',
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6),
    notes                          VARCHAR2(200 BYTE),
    symbol                         VARCHAR2(100 BYTE))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

ALTER TABLE fmembers
ADD CONSTRAINT fmembers_pkey PRIMARY KEY (id)
USING INDEX
/

DROP TABLE focmdcode
/

CREATE TABLE focmdcode
    (cmdcode                        VARCHAR2(50 BYTE) NOT NULL,
    cmdtext                        VARCHAR2(4000 BYTE),
    cmduse                         VARCHAR2(1 BYTE),
    cmdtype                        VARCHAR2(10 BYTE),
    cmddesc                        VARCHAR2(1000 BYTE),
    objname                        VARCHAR2(250 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

ALTER TABLE focmdcode
ADD CONSTRAINT focmdcode_pkey PRIMARY KEY (cmdcode)
USING INDEX
/

DROP TABLE focmdcode_tmp
/

CREATE TABLE focmdcode_tmp
    (cmdcode                        VARCHAR2(50 BYTE),
    cmdtext                        VARCHAR2(4000 BYTE),
    cmduse                         VARCHAR2(1 BYTE),
    cmdtype                        VARCHAR2(10 BYTE),
    cmddesc                        VARCHAR2(500 BYTE))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE focmdmenu
/

CREATE TABLE focmdmenu
    (cmdid                          VARCHAR2(6 BYTE) NOT NULL,
    prid                           VARCHAR2(6 BYTE),
    lev                            NUMBER(*,0),
    "last"                         VARCHAR2(1 BYTE),
    menutype                       VARCHAR2(1 BYTE),
    objname                        VARCHAR2(50 BYTE),
    cmdname                        VARCHAR2(400 BYTE),
    en_cmdname                     VARCHAR2(400 BYTE),
    boordid                        VARCHAR2(20 BYTE),
    modcode                        VARCHAR2(10 BYTE),
    roles                          VARCHAR2(50 BYTE),
    authcode                       VARCHAR2(10 BYTE),
    is4customer                    VARCHAR2(10 BYTE),
    tltxcd                         VARCHAR2(100 BYTE),
    isotpchk                       CHAR(1 BYTE),
    odrnum                         NUMBER(*,0),
    is4backend                     VARCHAR2(10 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE focmdmenu_bk_20210121
/

CREATE TABLE focmdmenu_bk_20210121
    (cmdid                          VARCHAR2(6 BYTE) NOT NULL,
    prid                           VARCHAR2(6 BYTE),
    lev                            NUMBER(*,0),
    "last"                         VARCHAR2(1 BYTE),
    menutype                       VARCHAR2(1 BYTE),
    objname                        VARCHAR2(50 BYTE),
    cmdname                        VARCHAR2(400 BYTE),
    en_cmdname                     VARCHAR2(400 BYTE),
    boordid                        VARCHAR2(20 BYTE),
    modcode                        VARCHAR2(10 BYTE),
    roles                          VARCHAR2(50 BYTE),
    authcode                       VARCHAR2(10 BYTE),
    is4customer                    VARCHAR2(10 BYTE),
    tltxcd                         VARCHAR2(100 BYTE),
    isotpchk                       CHAR(1 BYTE),
    odrnum                         NUMBER(*,0),
    is4backend                     VARCHAR2(10 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE focmdmenu_bk_20210512
/

CREATE TABLE focmdmenu_bk_20210512
    (cmdid                          VARCHAR2(6 BYTE) NOT NULL,
    prid                           VARCHAR2(6 BYTE),
    lev                            NUMBER(*,0),
    "last"                         VARCHAR2(1 BYTE),
    menutype                       VARCHAR2(1 BYTE),
    objname                        VARCHAR2(50 BYTE),
    cmdname                        VARCHAR2(400 BYTE),
    en_cmdname                     VARCHAR2(400 BYTE),
    boordid                        VARCHAR2(20 BYTE),
    modcode                        VARCHAR2(10 BYTE),
    roles                          VARCHAR2(50 BYTE),
    authcode                       VARCHAR2(10 BYTE),
    is4customer                    VARCHAR2(10 BYTE),
    tltxcd                         VARCHAR2(100 BYTE),
    isotpchk                       CHAR(1 BYTE),
    odrnum                         NUMBER(*,0),
    is4backend                     VARCHAR2(10 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE focmdmenu_bk_20210705
/

CREATE TABLE focmdmenu_bk_20210705
    (cmdid                          VARCHAR2(6 BYTE) NOT NULL,
    prid                           VARCHAR2(6 BYTE),
    lev                            NUMBER(*,0),
    "last"                         VARCHAR2(1 BYTE),
    menutype                       VARCHAR2(1 BYTE),
    objname                        VARCHAR2(50 BYTE),
    cmdname                        VARCHAR2(400 BYTE),
    en_cmdname                     VARCHAR2(400 BYTE),
    boordid                        VARCHAR2(20 BYTE),
    modcode                        VARCHAR2(10 BYTE),
    roles                          VARCHAR2(50 BYTE),
    authcode                       VARCHAR2(10 BYTE),
    is4customer                    VARCHAR2(10 BYTE),
    tltxcd                         VARCHAR2(100 BYTE),
    isotpchk                       CHAR(1 BYTE),
    odrnum                         NUMBER(*,0),
    is4backend                     VARCHAR2(10 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE focmdmenu1
/

CREATE TABLE focmdmenu1
    (cmdid                          VARCHAR2(6 BYTE),
    prid                           VARCHAR2(6 BYTE),
    lev                            FLOAT(64),
    last                           VARCHAR2(1 BYTE),
    menutype                       VARCHAR2(1 BYTE),
    objname                        VARCHAR2(50 BYTE),
    cmdname                        VARCHAR2(400 BYTE),
    en_cmdname                     VARCHAR2(400 BYTE),
    boordid                        VARCHAR2(20 BYTE),
    modcode                        VARCHAR2(10 BYTE),
    roles                          VARCHAR2(50 BYTE),
    authcode                       VARCHAR2(10 BYTE),
    is4customer                    VARCHAR2(10 BYTE),
    tltxcd                         VARCHAR2(4000 BYTE),
    isotpchk                       CHAR(1 BYTE),
    odrnum                         BINARY_DOUBLE)
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE font_param
/

CREATE TABLE font_param
    (prtype                         VARCHAR2(20 BYTE),
    prname                         VARCHAR2(500 BYTE),
    prnoidung                      VARCHAR2(100 BYTE),
    inout                          FLOAT(32))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE fund
/

CREATE TABLE fund
    (codeid                         VARCHAR2(6 BYTE) NOT NULL,
    symbol                         VARCHAR2(50 BYTE),
    mbid                           VARCHAR2(10 BYTE),
    name                           VARCHAR2(500 BYTE),
    name_en                        VARCHAR2(500 BYTE),
    shortname                      VARCHAR2(100 BYTE),
    fmcode                         VARCHAR2(20 BYTE),
    ftype                          VARCHAR2(3 BYTE),
    licenseno                      VARCHAR2(50 BYTE),
    licenseplace                   VARCHAR2(200 BYTE),
    custbank                       VARCHAR2(50 BYTE),
    supbank                        VARCHAR2(50 BYTE),
    ccycd                          VARCHAR2(10 BYTE),
    settleacctno                   VARCHAR2(50 BYTE),
    settlebank                     VARCHAR2(50 BYTE),
    blockacctno                    VARCHAR2(50 BYTE),
    blockbank                      VARCHAR2(50 BYTE),
    ipoblockacctno                 VARCHAR2(50 BYTE),
    ipoblockbank                   VARCHAR2(50 BYTE),
    fstcapital                     BINARY_DOUBLE,
    address                        VARCHAR2(500 BYTE),
    phone                          VARCHAR2(50 BYTE),
    fax                            VARCHAR2(50 BYTE),
    email                          VARCHAR2(50 BYTE),
    buyallocaterule                VARCHAR2(5 BYTE),
    sellallocaterule               VARCHAR2(5 BYTE),
    minqtty                        BINARY_DOUBLE,
    legalperson                    VARCHAR2(100 BYTE),
    legalposition                  VARCHAR2(100 BYTE),
    taxcode                        VARCHAR2(100 BYTE),
    taxaddr                        VARCHAR2(200 BYTE),
    taxname                        VARCHAR2(200 BYTE),
    status                         VARCHAR2(1 BYTE) DEFAULT 'P',
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6),
    description                    VARCHAR2(100 BYTE),
    fundname                       VARCHAR2(200 BYTE),
    licensedate                    DATE,
    name_vn                        VARCHAR2(500 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

ALTER TABLE fund
ADD CONSTRAINT fund_pkey PRIMARY KEY (codeid)
USING INDEX
/

DROP TABLE fund_member
/

CREATE TABLE fund_member
    (autoid                         FLOAT(64) DEFAULT 0 NOT NULL,
    codeid                         VARCHAR2(10 BYTE),
    custid                         VARCHAR2(10 BYTE),
    fullname                       VARCHAR2(200 BYTE),
    licenseno                      VARCHAR2(50 BYTE),
    rolecd                         CHAR(3 BYTE),
    description                    VARCHAR2(200 BYTE),
    idplace                        VARCHAR2(50 BYTE),
    iddate                         TIMESTAMP (6),
    idexpired                      TIMESTAMP (6),
    birthdate                      TIMESTAMP (6),
    sex                            VARCHAR2(3 BYTE),
    country                        VARCHAR2(10 BYTE),
    phone                          VARCHAR2(20 BYTE),
    address                        VARCHAR2(200 BYTE),
    email                          VARCHAR2(100 BYTE),
    notes                          VARCHAR2(200 BYTE),
    symbol                         VARCHAR2(100 BYTE),
    status                         VARCHAR2(10 BYTE) DEFAULT 'P',
    pstatus                        VARCHAR2(4000 BYTE))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE funddm
/

CREATE TABLE funddm
    (codeid                         VARCHAR2(10 BYTE) NOT NULL,
    symbol                         VARCHAR2(15 BYTE),
    name                           VARCHAR2(500 BYTE),
    name_en                        VARCHAR2(500 BYTE),
    shortname                      VARCHAR2(100 BYTE),
    fmcode                         VARCHAR2(20 BYTE),
    ftype                          VARCHAR2(3 BYTE),
    licenseno                      VARCHAR2(50 BYTE),
    licensedate                    TIMESTAMP (6),
    custbank                       VARCHAR2(50 BYTE),
    supbank                        VARCHAR2(50 BYTE),
    ccycd                          VARCHAR2(10 BYTE),
    settleacctno                   VARCHAR2(50 BYTE),
    settlebank                     VARCHAR2(50 BYTE),
    blockacctno                    VARCHAR2(50 BYTE),
    blockbank                      VARCHAR2(50 BYTE),
    ipoblockacctno                 VARCHAR2(50 BYTE),
    ipoblockbank                   VARCHAR2(50 BYTE),
    fstcapital                     BINARY_DOUBLE,
    maxforeignrate                 BINARY_DOUBLE,
    address                        VARCHAR2(500 BYTE),
    phone                          VARCHAR2(50 BYTE),
    fax                            VARCHAR2(50 BYTE),
    email                          VARCHAR2(50 BYTE),
    fstdate                        TIMESTAMP (6),
    clsordday                      VARCHAR2(10 BYTE),
    clsordtime                     VARCHAR2(10 BYTE),
    matchtime                      VARCHAR2(10 BYTE),
    exectime                       VARCHAR2(10 BYTE),
    clearday                       VARCHAR2(5 BYTE),
    minlimit                       BINARY_DOUBLE,
    autooddlot                     VARCHAR2(1 BYTE),
    maxredeemlimit                 BINARY_DOUBLE,
    matchrule                      VARCHAR2(1 BYTE),
    buyallocaterule                VARCHAR2(5 BYTE),
    sellallocaterule               VARCHAR2(5 BYTE),
    straddfee                      BINARY_DOUBLE,
    addfeerate                     BINARY_DOUBLE,
    minamt                         BINARY_DOUBLE,
    maxamt                         BINARY_DOUBLE,
    autoswitchpart                 VARCHAR2(1 BYTE),
    mqtty                          BINARY_DOUBLE,
    sellminqtty                    BINARY_DOUBLE,
    sellmaxqtty                    BINARY_DOUBLE,
    autosell                       VARCHAR2(1 BYTE),
    swminqtty                      BINARY_DOUBLE,
    swmaxqtty                      BINARY_DOUBLE,
    legalperson                    VARCHAR2(100 BYTE),
    legalposition                  VARCHAR2(100 BYTE),
    taxcode                        VARCHAR2(100 BYTE),
    taxaddr                        VARCHAR2(200 BYTE),
    taxname                        VARCHAR2(200 BYTE),
    genswday                       VARCHAR2(10 BYTE),
    chksupbank                     VARCHAR2(1 BYTE),
    chkotherbank                   VARCHAR2(1 BYTE),
    allocateord                    VARCHAR2(1 BYTE),
    isremainsell                   VARCHAR2(1 BYTE),
    status                         VARCHAR2(1 BYTE),
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6),
    licenseplace                   VARCHAR2(200 BYTE),
    minqtty                        BINARY_DOUBLE,
    maxqtty                        BINARY_DOUBLE,
    rndqtty                        FLOAT(16),
    mbid                           VARCHAR2(20 BYTE),
    description                    VARCHAR2(500 BYTE))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE funddtl
/

CREATE TABLE funddtl
    (codeid                         VARCHAR2(6 BYTE) NOT NULL,
    symbol                         VARCHAR2(15 BYTE),
    maxforeignrate                 BINARY_DOUBLE,
    clsordday                      VARCHAR2(10 BYTE),
    clsordtime                     VARCHAR2(10 BYTE),
    matchday                       VARCHAR2(10 BYTE),
    matchtime                      VARCHAR2(10 BYTE),
    rbankday                       VARCHAR2(10 BYTE),
    rbanktime                      VARCHAR2(10 BYTE),
    execday                        VARCHAR2(10 BYTE),
    exectime                       VARCHAR2(10 BYTE),
    execmonneyd                    VARCHAR2(10 BYTE),
    execmonneyt                    VARCHAR2(10 BYTE),
    clearday                       VARCHAR2(5 BYTE),
    minlimit                       BINARY_DOUBLE,
    autooddlot                     VARCHAR2(1 BYTE),
    maxredeemlimit                 BINARY_DOUBLE,
    matchrule                      VARCHAR2(1 BYTE),
    straddfee                      BINARY_DOUBLE,
    addfeerate                     BINARY_DOUBLE,
    autoswitchpart                 VARCHAR2(1 BYTE),
    minamt                         BINARY_DOUBLE,
    maxamt                         BINARY_DOUBLE,
    mqtty                          BINARY_DOUBLE,
    minqtty                        BINARY_DOUBLE,
    maxqtty                        BINARY_DOUBLE,
    sellminqtty                    BINARY_DOUBLE,
    sellmaxqtty                    BINARY_DOUBLE,
    autosell                       VARCHAR2(1 BYTE),
    swminqtty                      BINARY_DOUBLE,
    swmaxqtty                      BINARY_DOUBLE,
    genswday                       VARCHAR2(10 BYTE),
    chksupbank                     VARCHAR2(1 BYTE),
    chkotherbank                   VARCHAR2(1 BYTE),
    allocateord                    VARCHAR2(1 BYTE),
    isremainsell                   VARCHAR2(1 BYTE),
    rndqtty                        FLOAT(16),
    ordermatchns                   VARCHAR2(100 BYTE),
    ordermatchnr                   VARCHAR2(100 BYTE),
    autoodd                        VARCHAR2(10 BYTE),
    sellfullodd                    VARCHAR2(10 BYTE),
    status                         VARCHAR2(10 BYTE) DEFAULT 'P',
    pstatus                        VARCHAR2(4000 BYTE),
    fstdate                        DATE,
    fisttradingdate                DATE,
    pedriod                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6),
    cleardaysip                    VARCHAR2(5 BYTE),
    pedriodsip                     VARCHAR2(100 BYTE),
    chckodsip                      VARCHAR2(1 BYTE) DEFAULT 'N',
    firstodamt                     BINARY_DOUBLE DEFAULT 0)
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE funddtlmemo
/

CREATE TABLE funddtlmemo
    (codeid                         VARCHAR2(6 BYTE),
    symbol                         VARCHAR2(15 BYTE),
    maxforeignrate                 BINARY_DOUBLE,
    clsordday                      VARCHAR2(10 BYTE),
    clsordtime                     VARCHAR2(10 BYTE),
    matchday                       VARCHAR2(10 BYTE),
    matchtime                      VARCHAR2(10 BYTE),
    rbankday                       VARCHAR2(10 BYTE),
    rbanktime                      VARCHAR2(10 BYTE),
    execday                        VARCHAR2(10 BYTE),
    exectime                       VARCHAR2(10 BYTE),
    execmonneyd                    VARCHAR2(10 BYTE),
    execmonneyt                    VARCHAR2(10 BYTE),
    clearday                       VARCHAR2(5 BYTE),
    minlimit                       BINARY_DOUBLE,
    autooddlot                     VARCHAR2(1 BYTE),
    maxredeemlimit                 BINARY_DOUBLE,
    matchrule                      VARCHAR2(1 BYTE),
    straddfee                      BINARY_DOUBLE,
    addfeerate                     BINARY_DOUBLE,
    autoswitchpart                 VARCHAR2(1 BYTE),
    minamt                         BINARY_DOUBLE,
    maxamt                         BINARY_DOUBLE,
    mqtty                          BINARY_DOUBLE,
    minqtty                        BINARY_DOUBLE,
    maxqtty                        BINARY_DOUBLE,
    sellminqtty                    BINARY_DOUBLE,
    sellmaxqtty                    BINARY_DOUBLE,
    autosell                       VARCHAR2(1 BYTE),
    swminqtty                      BINARY_DOUBLE,
    swmaxqtty                      BINARY_DOUBLE,
    genswday                       VARCHAR2(10 BYTE),
    chksupbank                     VARCHAR2(1 BYTE),
    chkotherbank                   VARCHAR2(1 BYTE),
    allocateord                    VARCHAR2(1 BYTE),
    isremainsell                   VARCHAR2(1 BYTE),
    rndqtty                        FLOAT(16),
    ordermatchns                   VARCHAR2(100 BYTE),
    ordermatchnr                   VARCHAR2(100 BYTE),
    autoodd                        VARCHAR2(10 BYTE),
    sellfullodd                    VARCHAR2(10 BYTE),
    status                         VARCHAR2(10 BYTE),
    pstatus                        VARCHAR2(4000 BYTE),
    fstdate                        DATE,
    fisttradingdate                DATE,
    pedriod                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6),
    cleardaysip                    VARCHAR2(5 BYTE),
    pedriodsip                     VARCHAR2(100 BYTE),
    chckodsip                      VARCHAR2(1 BYTE) DEFAULT 'N',
    firstodamt                     BINARY_DOUBLE DEFAULT 0)
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE fundmemo
/

CREATE TABLE fundmemo
    (codeid                         VARCHAR2(6 BYTE),
    symbol                         VARCHAR2(15 BYTE),
    mbid                           VARCHAR2(10 BYTE),
    name                           VARCHAR2(500 BYTE),
    name_en                        VARCHAR2(500 BYTE),
    shortname                      VARCHAR2(100 BYTE),
    fmcode                         VARCHAR2(20 BYTE),
    ftype                          VARCHAR2(3 BYTE),
    licenseno                      VARCHAR2(50 BYTE),
    licenseplace                   VARCHAR2(200 BYTE),
    custbank                       VARCHAR2(50 BYTE),
    supbank                        VARCHAR2(50 BYTE),
    ccycd                          VARCHAR2(10 BYTE),
    settleacctno                   VARCHAR2(50 BYTE),
    settlebank                     VARCHAR2(50 BYTE),
    blockacctno                    VARCHAR2(50 BYTE),
    blockbank                      VARCHAR2(50 BYTE),
    ipoblockacctno                 VARCHAR2(50 BYTE),
    ipoblockbank                   VARCHAR2(50 BYTE),
    fstcapital                     BINARY_DOUBLE,
    address                        VARCHAR2(500 BYTE),
    phone                          VARCHAR2(50 BYTE),
    fax                            VARCHAR2(50 BYTE),
    email                          VARCHAR2(50 BYTE),
    buyallocaterule                VARCHAR2(5 BYTE),
    sellallocaterule               VARCHAR2(5 BYTE),
    minqtty                        BINARY_DOUBLE,
    legalperson                    VARCHAR2(100 BYTE),
    legalposition                  VARCHAR2(100 BYTE),
    taxcode                        VARCHAR2(100 BYTE),
    taxaddr                        VARCHAR2(200 BYTE),
    taxname                        VARCHAR2(200 BYTE),
    status                         VARCHAR2(1 BYTE),
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6),
    description                    VARCHAR2(100 BYTE),
    fundname                       VARCHAR2(200 BYTE),
    licensedate                    DATE,
    name_vn                        VARCHAR2(500 BYTE))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE g_symbol
/

CREATE TABLE g_symbol
    (symbol                         VARCHAR2(15 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE grmaster
/

CREATE TABLE grmaster
    (modcode                        VARCHAR2(10 BYTE),
    objname                        VARCHAR2(50 BYTE),
    odrnum                         FLOAT(64) DEFAULT 0,
    grname                         VARCHAR2(50 BYTE),
    grtype                         CHAR(1 BYTE) DEFAULT 'N',
    grbuttons                      VARCHAR2(20 BYTE),
    grcaption                      VARCHAR2(100 BYTE),
    en_grcaption                   VARCHAR2(100 BYTE),
    carebychk                      CHAR(1 BYTE) DEFAULT 'N',
    searchcode                     VARCHAR2(100 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE gwfvip
/

CREATE TABLE gwfvip
    (autoid                         NUMBER,
    aftype                         VARCHAR2(30 BYTE),
    custodycd                      VARCHAR2(30 BYTE),
    discount                       NUMBER,
    frdate                         DATE,
    todate                         DATE,
    status                         VARCHAR2(3 BYTE) DEFAULT 'P',
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE gwfvipmemo
/

CREATE TABLE gwfvipmemo
    (autoid                         NUMBER,
    aftype                         VARCHAR2(30 BYTE),
    custodycd                      VARCHAR2(30 BYTE),
    discount                       NUMBER,
    frdate                         DATE,
    todate                         DATE,
    status                         VARCHAR2(3 BYTE) DEFAULT 'P',
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE instrlist
/

CREATE TABLE instrlist
    (symbol                         VARCHAR2(30 BYTE),
    symbolnum                      VARCHAR2(30 BYTE),
    fullname_vn                    VARCHAR2(400 BYTE),
    fullname_en                    VARCHAR2(400 BYTE),
    cficode                        VARCHAR2(30 BYTE) DEFAULT 'ES',
    exchange                       VARCHAR2(10 BYTE) DEFAULT 'HSX',
    board                          VARCHAR2(10 BYTE),
    intrate                        NUMBER(10,2) DEFAULT 0,
    intperiod                      NUMBER(10,0),
    intperiodcd                    CHAR(1 BYTE) DEFAULT 'Y',
    issuedate                      DATE,
    expdate                        DATE,
    parvalue                       NUMBER(10,0) DEFAULT null,
    mrktprice                      NUMBER(10,2) DEFAULT 11,
    sectype                        VARCHAR2(30 BYTE) DEFAULT '001',
    intlastdt                      DATE,
    intyearcd                      CHAR(1 BYTE) DEFAULT 'S',
    fundcodeid                     VARCHAR2(30 BYTE),
    autoid                         NUMBER(20,0),
    status                         VARCHAR2(1 BYTE) DEFAULT 'P',
    pstatus                        VARCHAR2(30 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE intschd
/

CREATE TABLE intschd
    (autoid                         FLOAT(126),
    symbol                         VARCHAR2(50 BYTE),
    parvalue                       NUMBER,
    intrate                        NUMBER,
    intbaseddofy                   NUMBER,
    fromdate                       DATE,
    todate                         DATE,
    days                           NUMBER,
    amount                         NUMBER,
    reviewdt                       DATE,
    periodno                       NUMBER,
    status                         VARCHAR2(10 BYTE),
    pstatus                        VARCHAR2(2000 BYTE),
    lastchange                     TIMESTAMP (6),
    reportdt                       DATE)
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE intschdmemo
/

CREATE TABLE intschdmemo
    (autoid                         FLOAT(126),
    symbol                         VARCHAR2(50 BYTE),
    parvalue                       NUMBER,
    intrate                        NUMBER,
    intbaseddofy                   NUMBER,
    fromdate                       DATE,
    todate                         DATE,
    days                           NUMBER,
    amount                         NUMBER,
    reviewdt                       DATE,
    periodno                       NUMBER,
    status                         VARCHAR2(10 BYTE),
    pstatus                        VARCHAR2(2000 BYTE),
    lastchange                     TIMESTAMP (6),
    reportdt                       DATE)
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE investment
/

CREATE TABLE investment
    (acctno                         VARCHAR2(15 BYTE),
    symbol                         VARCHAR2(15 BYTE),
    issueddt                       DATE,
    qtty                           NUMBER(38,0) DEFAULT 0,
    price                          NUMBER(38,0) DEFAULT 0,
    notes                          VARCHAR2(4000 BYTE),
    status                         VARCHAR2(10 BYTE) DEFAULT NULL,
    pstatus                        VARCHAR2(10 BYTE),
    lastchange                     TIMESTAMP (6) DEFAULT NULL,
    refid                          NUMBER(38,0),
    accr                           NUMBER DEFAULT 0,
    fee                            NUMBER DEFAULT 0,
    sellamt                        NUMBER(38,0) DEFAULT 0,
    buyamt                         NUMBER(38,0) DEFAULT 0,
    isprofessor                    VARCHAR2(10 BYTE),
    type                           VARCHAR2(10 BYTE) DEFAULT 'I',
    refno                          VARCHAR2(100 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE iporeturn
/

CREATE TABLE iporeturn
    (ipoid                          VARCHAR2(30 BYTE),
    acctno                         VARCHAR2(15 BYTE),
    qtty                           BINARY_DOUBLE,
    amt                            BINARY_DOUBLE,
    notes                          VARCHAR2(4000 BYTE),
    status                         VARCHAR2(10 BYTE))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE isquoteexist
/

CREATE TABLE isquoteexist
    (quoteid                        VARCHAR2(100 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE issuers
/

CREATE TABLE issuers
    (autoid                         NUMBER DEFAULT 0,
    issuerid                       VARCHAR2(200 BYTE),
    shortname                      VARCHAR2(200 BYTE),
    fullname                       VARCHAR2(1000 BYTE),
    officename                     VARCHAR2(500 BYTE),
    custodycd                      VARCHAR2(10 BYTE),
    address                        VARCHAR2(1000 BYTE),
    phone                          VARCHAR2(20 BYTE),
    fax                            VARCHAR2(20 BYTE),
    description                    VARCHAR2(1000 BYTE),
    status                         VARCHAR2(1000 BYTE),
    pstatus                        VARCHAR2(1000 BYTE),
    lastchange                     TIMESTAMP (6),
    capital                        NUMBER,
    idcode                         VARCHAR2(50 BYTE),
    iddate                         DATE,
    idplace                        VARCHAR2(500 BYTE),
    lrname                         VARCHAR2(50 BYTE),
    lrposition                     VARCHAR2(50 BYTE),
    lrname2                        VARCHAR2(50 BYTE),
    lrposition2                    VARCHAR2(50 BYTE),
    udf                            VARCHAR2(200 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE issuers_udf
/

CREATE TABLE issuers_udf
    (autoid                         NUMBER DEFAULT 0,
    issuerid                       VARCHAR2(10 BYTE),
    udffield                       VARCHAR2(500 BYTE),
    udfvalue                       VARCHAR2(500 BYTE),
    udfname                        VARCHAR2(500 BYTE),
    action                         VARCHAR2(10 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE issuers_udfmemo
/

CREATE TABLE issuers_udfmemo
    (autoid                         NUMBER DEFAULT 0,
    issuerid                       VARCHAR2(10 BYTE),
    udffield                       VARCHAR2(500 BYTE),
    udfvalue                       VARCHAR2(500 BYTE),
    udfname                        VARCHAR2(500 BYTE),
    action                         VARCHAR2(10 BYTE))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE issuersmemo
/

CREATE TABLE issuersmemo
    (autoid                         NUMBER DEFAULT 0,
    issuerid                       VARCHAR2(200 BYTE),
    shortname                      VARCHAR2(200 BYTE),
    fullname                       VARCHAR2(1000 BYTE),
    officename                     VARCHAR2(500 BYTE),
    custodycd                      VARCHAR2(10 BYTE),
    address                        VARCHAR2(1000 BYTE),
    phone                          VARCHAR2(20 BYTE),
    fax                            VARCHAR2(20 BYTE),
    description                    VARCHAR2(1000 BYTE),
    status                         VARCHAR2(1000 BYTE),
    pstatus                        VARCHAR2(1000 BYTE),
    lastchange                     TIMESTAMP (6),
    capital                        NUMBER(*,0),
    idcode                         VARCHAR2(50 BYTE),
    iddate                         DATE,
    idplace                        VARCHAR2(500 BYTE),
    lrname                         VARCHAR2(50 BYTE),
    lrposition                     VARCHAR2(50 BYTE),
    lrname2                        VARCHAR2(50 BYTE),
    lrposition2                    VARCHAR2(50 BYTE),
    udf                            VARCHAR2(200 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE ivmast
/

CREATE TABLE ivmast
    (acctno                         VARCHAR2(40 BYTE) NOT NULL,
    afacctno                       VARCHAR2(30 BYTE),
    custid                         VARCHAR2(30 BYTE),
    custodycd                      VARCHAR2(10 BYTE),
    sid                            VARCHAR2(20 BYTE),
    codeid                         VARCHAR2(10 BYTE),
    symbol                         VARCHAR2(100 BYTE),
    srtype                         VARCHAR2(4 BYTE),
    sipcode                        VARCHAR2(20 BYTE),
    balance                        NUMBER(38,0) DEFAULT 0,
    receiving                      NUMBER(38,0) DEFAULT 0,
    careceiving                    NUMBER(38,0) DEFAULT 0,
    netting                        NUMBER(38,0) DEFAULT 0,
    blocked                        NUMBER(38,0) DEFAULT 0,
    status                         VARCHAR2(1 BYTE),
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6),
    floatamt                       NUMBER(38,0) DEFAULT 0)
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE ivmast_2007_01
/

CREATE TABLE ivmast_2007_01
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
    lastchange                     TIMESTAMP (6),
    floatamt                       BINARY_DOUBLE)
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE ivmastdetail
/

CREATE TABLE ivmastdetail
    (autoid                         NUMBER(38,0),
    txnum                          VARCHAR2(100 BYTE),
    txdate                         DATE,
    tltxcd                         VARCHAR2(4 BYTE),
    confirmno                      VARCHAR2(100 BYTE),
    custodycd                      VARCHAR2(100 BYTE),
    symbol                         VARCHAR2(100 BYTE),
    amt                            NUMBER(38,0))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE ivtran
/

CREATE TABLE ivtran
    (autoid                         NUMBER(38,0),
    txnum                          VARCHAR2(100 BYTE),
    txdate                         DATE,
    tltxcd                         VARCHAR2(4 BYTE),
    bkdate                         DATE,
    trdesc                         VARCHAR2(4000 BYTE),
    acctno                         VARCHAR2(40 BYTE),
    codeid                         VARCHAR2(30 BYTE),
    symbol                         VARCHAR2(100 BYTE),
    srtype                         VARCHAR2(4 BYTE),
    txcd                           VARCHAR2(4 BYTE),
    namt                           NUMBER(38,0),
    camt                           VARCHAR2(50 BYTE),
    ref                            VARCHAR2(50 BYTE),
    deltd                          CHAR(1 BYTE),
    acctref                        VARCHAR2(20 BYTE),
    lvel                           NUMBER(5,0))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE ivtran_gen
/

CREATE TABLE ivtran_gen
    (autoid                         NUMBER(38,0),
    custodycd                      VARCHAR2(20 BYTE),
    custid                         VARCHAR2(20 BYTE),
    txnum                          VARCHAR2(20 BYTE),
    txdate                         DATE,
    acctno                         VARCHAR2(20 BYTE),
    txcd                           VARCHAR2(4 BYTE),
    namt                           NUMBER(38,0),
    camt                           VARCHAR2(50 BYTE),
    ref                            VARCHAR2(50 BYTE),
    deltd                          VARCHAR2(1 BYTE),
    acctref                        VARCHAR2(20 BYTE),
    tltxcd                         VARCHAR2(4 BYTE),
    busdate                        DATE,
    txdesc                         VARCHAR2(4000 BYTE),
    txtime                         VARCHAR2(10 BYTE),
    brid                           VARCHAR2(6 BYTE),
    tlid                           VARCHAR2(4 BYTE),
    offid                          VARCHAR2(4 BYTE),
    chid                           VARCHAR2(4 BYTE),
    afacctno                       VARCHAR2(20 BYTE),
    symbol                         VARCHAR2(80 BYTE),
    txtype                         VARCHAR2(1 BYTE),
    field                          VARCHAR2(30 BYTE),
    codeid                         VARCHAR2(10 BYTE),
    tllog_autoid                   NUMBER(38,0),
    trdesc                         VARCHAR2(4000 BYTE),
    ivofftime                      VARCHAR2(10 BYTE),
    ivtxstatus                     VARCHAR2(10 BYTE),
    vermatching                    VARCHAR2(100 BYTE),
    sessionno                      VARCHAR2(20 BYTE),
    orderid                        VARCHAR2(20 BYTE))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE ivtrana
/

CREATE TABLE ivtrana
    (autoid                         NUMBER(38,0),
    txnum                          VARCHAR2(100 BYTE),
    txdate                         DATE,
    tltxcd                         VARCHAR2(4 BYTE),
    bkdate                         DATE,
    trdesc                         VARCHAR2(4000 BYTE),
    acctno                         VARCHAR2(40 BYTE),
    codeid                         VARCHAR2(30 BYTE),
    symbol                         VARCHAR2(100 BYTE),
    srtype                         VARCHAR2(4 BYTE),
    txcd                           VARCHAR2(4 BYTE),
    namt                           NUMBER(38,0),
    camt                           VARCHAR2(50 BYTE),
    ref                            VARCHAR2(50 BYTE),
    deltd                          CHAR(1 BYTE),
    acctref                        VARCHAR2(20 BYTE),
    lvel                           NUMBER(5,0))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE kd
/

CREATE TABLE kd
    ("?COLUMN?"                     FLOAT(32))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE kpiparam
/

CREATE TABLE kpiparam
    (autoid                         FLOAT(64),
    notes                          VARCHAR2(200 BYTE),
    yearcd                         VARCHAR2(200 BYTE),
    objtype                        VARCHAR2(200 BYTE),
    objvalue                       VARCHAR2(200 BYTE),
    cyclecd                        VARCHAR2(20 BYTE),
    amtyy                          BINARY_DOUBLE,
    amtq1                          BINARY_DOUBLE,
    amtq2                          BINARY_DOUBLE,
    amtq3                          BINARY_DOUBLE,
    amtq4                          BINARY_DOUBLE,
    status                         VARCHAR2(1 BYTE),
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6),
    scopetype                      VARCHAR2(200 BYTE),
    scopevalue                     VARCHAR2(200 BYTE))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE l_1
/

CREATE TABLE l_1
    (max                            BINARY_DOUBLE)
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE l_acctno1
/

CREATE TABLE l_acctno1
    ("?COLUMN?"                     VARCHAR2(4000 BYTE))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE l_buyprice
/

CREATE TABLE l_buyprice
    (round                          BINARY_DOUBLE)
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE l_calpv_method
/

CREATE TABLE l_calpv_method
    (count                          FLOAT(64))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE l_count
/

CREATE TABLE l_count
    (count                          FLOAT(64))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE l_count1
/

CREATE TABLE l_count1
    (count                          FLOAT(64))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE l_count2
/

CREATE TABLE l_count2
    (count                          FLOAT(64))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE l_count23
/

CREATE TABLE l_count23
    (count                          FLOAT(64))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE l_count3
/

CREATE TABLE l_count3
    (count                          FLOAT(64))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE l_count4
/

CREATE TABLE l_count4
    (count                          FLOAT(64))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE l_count8
/

CREATE TABLE l_count8
    (count                          FLOAT(64))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE l_dbcode
/

CREATE TABLE l_dbcode
    (max                            VARCHAR2(4000 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE l_hm1
/

CREATE TABLE l_hm1
    ("?COLUMN?"                     BINARY_DOUBLE)
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE l_intdate
/

CREATE TABLE l_intdate
    (max                            DATE)
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE l_issuerid
/

CREATE TABLE l_issuerid
    (issuerid                       VARCHAR2(10 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE l_limitval
/

CREATE TABLE l_limitval
    (limitval                       BINARY_DOUBLE)
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE l_mbcode
/

CREATE TABLE l_mbcode
    (mbid                           VARCHAR2(6 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE l_mindate
/

CREATE TABLE l_mindate
    (min                            DATE)
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE l_orgpasswrd
/

CREATE TABLE l_orgpasswrd
    (fn_passwordgenerator           VARCHAR2(4000 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE l_otp
/

CREATE TABLE l_otp
    (right                          VARCHAR2(4000 BYTE))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE l_otpnum
/

CREATE TABLE l_otpnum
    (nextval                        FLOAT(64))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE l_product_name
/

CREATE TABLE l_product_name
    (shortname                      VARCHAR2(50 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE l_qty_closing
/

CREATE TABLE l_qty_closing
    (sum                            BINARY_DOUBLE)
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE l_refissuid
/

CREATE TABLE l_refissuid
    (refissuid                      FLOAT(64))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE l_result
/

CREATE TABLE l_result
    (sum                            BINARY_DOUBLE)
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE l_return
/

CREATE TABLE l_return
    (discount                       BINARY_DOUBLE)
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE l_sum
/

CREATE TABLE l_sum
    (count                          FLOAT(64))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE l_temp1
/

CREATE TABLE l_temp1
    (shortname                      VARCHAR2(50 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE l_temp2
/

CREATE TABLE l_temp2
    (productid                      VARCHAR2(50 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE l_total
/

CREATE TABLE l_total
    (sum                            BINARY_DOUBLE)
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE l_value
/

CREATE TABLE l_value
    ("?COLUMN?"                     BINARY_DOUBLE)
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE lcount1
/

CREATE TABLE lcount1
    (count                          FLOAT(64))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE limits
/

CREATE TABLE limits
    (autoid                         NUMBER DEFAULT 0,
    limit_type                     VARCHAR2(4000 BYTE),
    acctno                         VARCHAR2(30 BYTE),
    effdate                        DATE,
    expdate                        DATE,
    status                         CHAR(1 BYTE),
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6),
    limitval                       NUMBER,
    calc_type                      VARCHAR2(500 BYTE),
    symbol                         VARCHAR2(1000 BYTE),
    method                         VARCHAR2(10 BYTE),
    product                        VARCHAR2(500 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE limits_hist
/

CREATE TABLE limits_hist
    (autoid                         NUMBER DEFAULT 0,
    limit_type                     VARCHAR2(4000 BYTE),
    acctno                         VARCHAR2(30 BYTE),
    effdate                        DATE,
    expdate                        DATE,
    status                         CHAR(1 BYTE),
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6),
    limitval                       NUMBER,
    calc_type                      VARCHAR2(500 BYTE),
    symbol                         VARCHAR2(1000 BYTE),
    method                         VARCHAR2(10 BYTE),
    product                        VARCHAR2(500 BYTE),
    action                         VARCHAR2(10 BYTE),
    id                             NUMBER)
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE limits_memo
/

CREATE TABLE limits_memo
    (autoid                         BINARY_DOUBLE DEFAULT 0,
    limit_type                     VARCHAR2(4000 BYTE),
    acctno                         VARCHAR2(30 BYTE),
    effdate                        DATE,
    expdate                        DATE,
    status                         CHAR(1 BYTE),
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6),
    calc_type                      VARCHAR2(500 BYTE),
    symbol                         VARCHAR2(1000 BYTE))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE limitsmemo
/

CREATE TABLE limitsmemo
    (autoid                         NUMBER DEFAULT 0,
    limit_type                     VARCHAR2(4000 BYTE),
    acctno                         VARCHAR2(30 BYTE),
    effdate                        DATE,
    expdate                        DATE,
    status                         CHAR(1 BYTE),
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6),
    limitval                       NUMBER,
    calc_type                      VARCHAR2(500 BYTE),
    symbol                         VARCHAR2(1000 BYTE),
    method                         VARCHAR2(10 BYTE),
    product                        VARCHAR2(500 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE log_notify
/

CREATE TABLE log_notify
    (autoid                         NUMBER,
    objname                        VARCHAR2(50 BYTE),
    keyname                        VARCHAR2(50 BYTE),
    keyvalue                       VARCHAR2(100 BYTE),
    status                         VARCHAR2(1 BYTE) DEFAULT 'P',
    logtime                        DATE,
    applytime                      DATE)
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE log_notify_fa
/

CREATE TABLE log_notify_fa
    (autoid                         NUMBER,
    objname                        VARCHAR2(50 BYTE),
    keyname                        VARCHAR2(50 BYTE),
    keyvalue                       VARCHAR2(100 BYTE),
    action                         VARCHAR2(100 BYTE),
    status                         VARCHAR2(1 BYTE) DEFAULT 'P',
    logtime                        DATE,
    applytime                      DATE)
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE logfilecv
/

CREATE TABLE logfilecv
    (id                             FLOAT(32),
    ver                            VARCHAR2(50 BYTE),
    filename                       VARCHAR2(100 BYTE),
    userid                         VARCHAR2(50 BYTE),
    startid                        FLOAT(32),
    finishid                       FLOAT(32),
    startdt                        TIMESTAMP (6),
    finishdt                       TIMESTAMP (6),
    status                         CHAR(1 BYTE),
    lastchanged                    TIMESTAMP (6))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE mail_attach
/

CREATE TABLE mail_attach
    (aid                            FLOAT(64) DEFAULT 0 NOT NULL,
    afilename                      VARCHAR2(500 BYTE),
    acontent                       BLOB,
    aencoding                      VARCHAR2(50 BYTE),
    acontenttype                   VARCHAR2(50 BYTE),
    aprotocol                      VARCHAR2(10 BYTE),
    apath                          VARCHAR2(500 BYTE),
    refid                          FLOAT(64))
  SEGMENT CREATION IMMEDIATE
  LOB ("ACONTENT") STORE AS SECUREFILE SYS_LOB0000076211C00003$$
  (
   NOCACHE NOLOGGING
   CHUNK 8192
  )
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE maintain_log
/

CREATE TABLE maintain_log
    (autoid                         NUMBER,
    table_name                     VARCHAR2(20 BYTE),
    record_key                     VARCHAR2(200 BYTE),
    record_value                   VARCHAR2(200 BYTE),
    child_table_name               VARCHAR2(50 BYTE),
    child_record_key               VARCHAR2(200 BYTE),
    child_record_value             VARCHAR2(200 BYTE),
    action_flag                    VARCHAR2(10 BYTE),
    mod_num                        FLOAT(16),
    column_name                    VARCHAR2(100 BYTE),
    from_value                     VARCHAR2(4000 BYTE),
    to_value                       VARCHAR2(4000 BYTE),
    maker_id                       VARCHAR2(8 BYTE),
    maker_dt                       DATE,
    maker_time                     VARCHAR2(20 BYTE),
    approve_rqd                    CHAR(1 BYTE),
    approve_id                     VARCHAR2(8 BYTE),
    approve_dt                     DATE,
    approve_time                   VARCHAR2(20 BYTE),
    last_change                    TIMESTAMP (6) DEFAULT to_date('0001-01-01 00:00:00', 'YYYY-MM-DD hh24:mi:ss'),
    deltd                          CHAR(1 BYTE) DEFAULT 'N',
    refobjid                       FLOAT(64),
    column_type                    VARCHAR2(200 BYTE),
    updatefld                      VARCHAR2(3 BYTE) DEFAULT 'Y')
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

CREATE INDEX maintain_log_idx02 ON maintain_log
  (
    refobjid                        ASC
  )
NOPARALLEL
NOLOGGING
/

CREATE INDEX maintain_log_idx01 ON maintain_log
  (
    action_flag                     ASC
  )
NOPARALLEL
NOLOGGING
/


DROP TABLE maintain_loghist
/

CREATE TABLE maintain_loghist
    (autoid                         NUMBER,
    table_name                     VARCHAR2(20 BYTE),
    record_key                     VARCHAR2(200 BYTE),
    record_value                   VARCHAR2(200 BYTE),
    child_table_name               VARCHAR2(50 BYTE),
    child_record_key               VARCHAR2(200 BYTE),
    child_record_value             VARCHAR2(200 BYTE),
    action_flag                    VARCHAR2(10 BYTE),
    mod_num                        FLOAT(16),
    column_name                    VARCHAR2(100 BYTE),
    from_value                     VARCHAR2(4000 BYTE),
    to_value                       VARCHAR2(4000 BYTE),
    maker_id                       VARCHAR2(8 BYTE),
    maker_dt                       DATE,
    maker_time                     VARCHAR2(20 BYTE),
    approve_rqd                    CHAR(1 BYTE),
    approve_id                     VARCHAR2(8 BYTE),
    approve_dt                     DATE,
    approve_time                   VARCHAR2(20 BYTE),
    last_change                    TIMESTAMP (6),
    deltd                          CHAR(1 BYTE),
    refobjid                       FLOAT(64),
    column_type                    VARCHAR2(200 BYTE),
    updatefld                      VARCHAR2(3 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE marketinfo
/

CREATE TABLE marketinfo
    (autoid                         FLOAT(64),
    txdate                         DATE,
    vnindex                        BINARY_DOUBLE,
    hnxindex                       BINARY_DOUBLE,
    vn30index                      BINARY_DOUBLE,
    hnx30index                     BINARY_DOUBLE,
    status                         VARCHAR2(1 BYTE) DEFAULT 'A',
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6),
    tlname                         VARCHAR2(50 BYTE))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE members
/

CREATE TABLE members
    (mbcode                         VARCHAR2(350 BYTE),
    mbname                         VARCHAR2(350 BYTE),
    address                        VARCHAR2(350 BYTE),
    phone                          VARCHAR2(50 BYTE),
    email                          VARCHAR2(350 BYTE),
    fax                            VARCHAR2(350 BYTE),
    legalperson                    VARCHAR2(500 BYTE),
    legalposition                  VARCHAR2(500 BYTE),
    status                         VARCHAR2(1 BYTE) DEFAULT 'A',
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6),
    mbname_en                      VARCHAR2(350 BYTE),
    shortname                      VARCHAR2(100 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

CREATE UNIQUE INDEX members_mbcode_unique ON members
  (
    mbcode                          ASC
  )
NOPARALLEL
NOLOGGING
/


DROP TABLE memberscv
/

CREATE TABLE memberscv
    (mbcode                         VARCHAR2(4000 BYTE),
    mbname                         VARCHAR2(4000 BYTE),
    grptype                        VARCHAR2(4000 BYTE),
    mbtype                         VARCHAR2(4000 BYTE),
    legalpersion                   VARCHAR2(4000 BYTE),
    note                           VARCHAR2(4000 BYTE),
    phone                          VARCHAR2(4000 BYTE),
    email                          VARCHAR2(4000 BYTE))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE membersmemo
/

CREATE TABLE membersmemo
    (mbcode                         VARCHAR2(350 BYTE),
    mbname                         VARCHAR2(350 BYTE),
    address                        VARCHAR2(350 BYTE),
    phone                          VARCHAR2(50 BYTE),
    email                          VARCHAR2(350 BYTE),
    fax                            VARCHAR2(350 BYTE),
    legalperson                    VARCHAR2(500 BYTE),
    legalposition                  VARCHAR2(500 BYTE),
    status                         VARCHAR2(1 BYTE),
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6),
    mbname_en                      VARCHAR2(350 BYTE),
    shortname                      VARCHAR2(100 BYTE))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE mytable
/

CREATE TABLE mytable
    (cr_custodycd                   VARCHAR2(4000 BYTE),
    cr_accountid                   VARCHAR2(4000 BYTE),
    dr_custodycd                   VARCHAR2(4000 BYTE),
    amount                         BINARY_DOUBLE,
    orderid                        VARCHAR2(4000 BYTE))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE nhanvien
/

CREATE TABLE nhanvien
    (autoid                         BINARY_DOUBLE NOT NULL,
    nhanvien_age                   FLOAT(32),
    nhanvien_ten                   VARCHAR2(250 BYTE),
    nhanvien_ho                    VARCHAR2(250 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE nhapnhap
/

CREATE TABLE nhapnhap
    (value                          VARCHAR2(4000 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE notify_log
/

CREATE TABLE notify_log
    (autoid                         FLOAT(32) DEFAULT 0 NOT NULL,
    objvalue                       VARCHAR2(4000 BYTE),
    keyvalue                       VARCHAR2(4000 BYTE),
    note                           VARCHAR2(4000 BYTE),
    lastchanger                    TIMESTAMP (6))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE objlog
/

CREATE TABLE objlog
    (autoid                         FLOAT(64) DEFAULT 0 NOT NULL,
    txnum                          VARCHAR2(12 BYTE) NOT NULL,
    txdate                         DATE NOT NULL,
    txtime                         VARCHAR2(10 BYTE),
    brid                           VARCHAR2(6 BYTE),
    tlid                           VARCHAR2(6 BYTE),
    offid                          VARCHAR2(6 BYTE),
    ovrrqs                         VARCHAR2(4000 BYTE),
    chid                           VARCHAR2(6 BYTE),
    chkid                          VARCHAR2(6 BYTE),
    tltxcd                         VARCHAR2(4 BYTE),
    ibt                            VARCHAR2(1 BYTE),
    brid2                          VARCHAR2(6 BYTE),
    tlid2                          VARCHAR2(6 BYTE),
    ccyusage                       VARCHAR2(40 BYTE),
    off_line                       VARCHAR2(1 BYTE),
    deltd                          CHAR(1 BYTE),
    brdate                         DATE,
    busdate                        DATE,
    txdesc                         VARCHAR2(4000 BYTE),
    ipaddress                      VARCHAR2(20 BYTE),
    wsname                         VARCHAR2(50 BYTE),
    txstatus                       VARCHAR2(1 BYTE) DEFAULT '0',
    msgsts                         VARCHAR2(1 BYTE) DEFAULT '0',
    ovrsts                         VARCHAR2(1 BYTE) DEFAULT '0',
    batchname                      CHAR(20 BYTE),
    msgamt                         NUMBER(8,0) DEFAULT 0,
    msgacct                        VARCHAR2(100 BYTE),
    chktime                        VARCHAR2(10 BYTE),
    offtime                        VARCHAR2(10 BYTE),
    carebygrp                      VARCHAR2(50 BYTE),
    reftxnum                       VARCHAR2(10 BYTE) DEFAULT '',
    namenv                         VARCHAR2(4000 BYTE),
    cfcustodycd                    VARCHAR2(20 BYTE),
    createdt                       TIMESTAMP (6) DEFAULT to_date('0001-01-01 00:00:00', 'YYYY-MM-DD hh24:mi:ss'),
    cffullname                     VARCHAR2(4000 BYTE),
    ptxstatus                      VARCHAR2(4000 BYTE),
    lvel                           FLOAT(64) DEFAULT 0,
    dstatus                        VARCHAR2(2 BYTE),
    last_lvel                      FLOAT(64) DEFAULT 0,
    last_dstatus                   VARCHAR2(2 BYTE),
    childkey                       VARCHAR2(100 BYTE),
    childvalue                     VARCHAR2(100 BYTE),
    chiltable                      VARCHAR2(100 BYTE),
    parentkey                      VARCHAR2(100 BYTE),
    parentvalue                    VARCHAR2(100 BYTE),
    parenttable                    VARCHAR2(100 BYTE),
    modulcode                      VARCHAR2(100 BYTE),
    actionflag                     VARCHAR2(100 BYTE),
    pautoid                        FLOAT(64),
    cmdobjname                     VARCHAR2(200 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

CREATE INDEX objlog_cmdobjname_idx ON objlog
  (
    cmdobjname                      ASC
  )
NOPARALLEL
NOLOGGING
/

CREATE INDEX objlog_idx01 ON objlog
  (
    tlid                            ASC
  )
NOPARALLEL
NOLOGGING
/

CREATE INDEX objlog_txdate_idx ON objlog
  (
    txdate                          ASC
  )
NOPARALLEL
NOLOGGING
/

CREATE INDEX objlog_txnum_txdate_idx ON objlog
  (
    txdate                          ASC,
    txnum                           ASC
  )
NOPARALLEL
NOLOGGING
/

CREATE INDEX objlog_tltxcd_idx ON objlog
  (
    tltxcd                          ASC
  )
NOPARALLEL
NOLOGGING
/


DROP TABLE objloghist
/

CREATE TABLE objloghist
    (autoid                         FLOAT(64) DEFAULT 0 NOT NULL,
    txnum                          VARCHAR2(12 BYTE) NOT NULL,
    txdate                         DATE NOT NULL,
    txtime                         VARCHAR2(10 BYTE),
    brid                           VARCHAR2(6 BYTE),
    tlid                           VARCHAR2(6 BYTE),
    offid                          VARCHAR2(6 BYTE),
    ovrrqs                         VARCHAR2(4000 BYTE),
    chid                           VARCHAR2(6 BYTE),
    chkid                          VARCHAR2(6 BYTE),
    tltxcd                         VARCHAR2(4 BYTE),
    ibt                            VARCHAR2(1 BYTE),
    brid2                          VARCHAR2(6 BYTE),
    tlid2                          VARCHAR2(6 BYTE),
    ccyusage                       VARCHAR2(40 BYTE),
    off_line                       VARCHAR2(1 BYTE),
    deltd                          CHAR(1 BYTE),
    brdate                         DATE,
    busdate                        DATE,
    txdesc                         VARCHAR2(4000 BYTE),
    ipaddress                      VARCHAR2(20 BYTE),
    wsname                         VARCHAR2(50 BYTE),
    txstatus                       VARCHAR2(1 BYTE) DEFAULT '0',
    msgsts                         VARCHAR2(1 BYTE) DEFAULT '0',
    ovrsts                         VARCHAR2(1 BYTE) DEFAULT '0',
    batchname                      VARCHAR2(20 BYTE),
    msgamt                         BINARY_DOUBLE DEFAULT 0,
    msgacct                        VARCHAR2(100 BYTE),
    chktime                        VARCHAR2(10 BYTE),
    offtime                        VARCHAR2(10 BYTE),
    carebygrp                      VARCHAR2(50 BYTE),
    reftxnum                       VARCHAR2(10 BYTE) DEFAULT '',
    namenv                         VARCHAR2(4000 BYTE),
    cfcustodycd                    VARCHAR2(20 BYTE),
    createdt                       TIMESTAMP (6) DEFAULT to_date('0001-01-01 00:00:00', 'YYYY-MM-DD hh24:mi:ss'),
    cffullname                     VARCHAR2(4000 BYTE),
    ptxstatus                      VARCHAR2(4000 BYTE),
    lvel                           FLOAT(64) DEFAULT 0,
    dstatus                        VARCHAR2(2 BYTE),
    last_lvel                      FLOAT(64) DEFAULT 0,
    last_dstatus                   VARCHAR2(2 BYTE),
    childkey                       VARCHAR2(100 BYTE),
    childvalue                     VARCHAR2(100 BYTE),
    chiltable                      VARCHAR2(100 BYTE),
    parentkey                      VARCHAR2(100 BYTE),
    parentvalue                    VARCHAR2(100 BYTE),
    parenttable                    VARCHAR2(100 BYTE),
    modulcode                      VARCHAR2(100 BYTE),
    actionflag                     VARCHAR2(100 BYTE),
    pautoid                        FLOAT(64),
    cmdobjname                     VARCHAR2(200 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE objmaster
/

CREATE TABLE objmaster
    (modcode                        VARCHAR2(10 BYTE),
    objname                        VARCHAR2(50 BYTE),
    objtitle                       VARCHAR2(100 BYTE),
    en_objtitle                    VARCHAR2(100 BYTE),
    useautoid                      CHAR(1 BYTE) DEFAULT 'N',
    carebychk                      CHAR(1 BYTE) DEFAULT 'N',
    objbuttons                     VARCHAR2(20 BYTE),
    runmod                         VARCHAR2(10 BYTE) DEFAULT 'NET',
    isauto                         VARCHAR2(1 BYTE) DEFAULT 'Y',
    fldkey                         VARCHAR2(150 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

CREATE INDEX objmaster_idx01 ON objmaster
  (
    objname                         ASC
  )
NOPARALLEL
NOLOGGING
/


DROP TABLE otp_logs
/

CREATE TABLE otp_logs
    (id                             NUMBER,
    code                           VARCHAR2(20 BYTE) NOT NULL,
    refid                          VARCHAR2(200 BYTE) NOT NULL,
    secret                         VARCHAR2(4000 BYTE) NOT NULL,
    otpintval                      NUMBER,
    otplen                         NUMBER,
    issueddt                       TIMESTAMP (6),
    exprieddt                      TIMESTAMP (6),
    status                         CHAR(1 BYTE) DEFAULT 'N',
    retry_count                    NUMBER)
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE otp_logshist
/

CREATE TABLE otp_logshist
    (id                             NUMBER,
    code                           VARCHAR2(20 BYTE) NOT NULL,
    refid                          VARCHAR2(200 BYTE) NOT NULL,
    secret                         VARCHAR2(4000 BYTE) NOT NULL,
    otpintval                      NUMBER,
    otplen                         NUMBER,
    issueddt                       TIMESTAMP (6),
    exprieddt                      TIMESTAMP (6),
    status                         CHAR(1 BYTE) DEFAULT 'N',
    retry_count                    NUMBER)
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE oxcamast
/

CREATE TABLE oxcamast
    (autoid                         NUMBER DEFAULT 0,
    codeid                         VARCHAR2(20 BYTE),
    symbol                         VARCHAR2(20 BYTE),
    txdate                         DATE,
    txnum                          VARCHAR2(30 BYTE),
    catype                         VARCHAR2(20 BYTE),
    carate                         NUMBER,
    sbseschdid                     NUMBER,
    rptdate                        DATE,
    settdate                       DATE,
    deltd                          CHAR(1 BYTE) DEFAULT 'N',
    status                         CHAR(1 BYTE),
    ratio                          NUMBER,
    price                          NUMBER,
    filename                       VARCHAR2(500 BYTE),
    qtty                           NUMBER)
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE oxcamasthist
/

CREATE TABLE oxcamasthist
    (autoid                         NUMBER,
    codeid                         VARCHAR2(20 BYTE),
    symbol                         VARCHAR2(20 BYTE),
    txdate                         DATE,
    txnum                          VARCHAR2(30 BYTE),
    catype                         VARCHAR2(20 BYTE),
    carate                         NUMBER,
    sbseschdid                     NUMBER,
    rptdate                        DATE,
    settdate                       DATE,
    deltd                          CHAR(1 BYTE),
    status                         CHAR(1 BYTE),
    ratio                          NUMBER,
    price                          NUMBER,
    filename                       VARCHAR2(500 BYTE),
    qtty                           NUMBER)
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE oxcamastmemo
/

CREATE TABLE oxcamastmemo
    (autoid                         BINARY_DOUBLE DEFAULT 0,
    codeid                         VARCHAR2(20 BYTE),
    symbol                         VARCHAR2(20 BYTE) DEFAULT 'SBSECURITIES.SYMBOL',
    txdate                         DATE,
    txnum                          VARCHAR2(30 BYTE),
    catype                         VARCHAR2(20 BYTE),
    carate                         BINARY_DOUBLE,
    sbseschdid                     BINARY_DOUBLE,
    rptdate                        DATE,
    settdate                       DATE,
    deltd                          CHAR(1 BYTE),
    status                         CHAR(1 BYTE),
    ratio                          BINARY_DOUBLE,
    price                          BINARY_DOUBLE,
    filename                       VARCHAR2(500 BYTE))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE oxcaschd
/

CREATE TABLE oxcaschd
    (autoid                         NUMBER DEFAULT 0,
    camastid                       NUMBER,
    txdate                         DATE,
    txnum                          VARCHAR2(30 BYTE),
    afacctno                       VARCHAR2(30 BYTE),
    balance                        NUMBER,
    amt                            NUMBER,
    qtty                           NUMBER,
    aamt                           NUMBER,
    aqtty                          NUMBER,
    deltd                          CHAR(1 BYTE),
    status                         CHAR(1 BYTE),
    orgvaluedt                     DATE,
    sbdefacctno                    VARCHAR2(30 BYTE),
    register_date                  DATE,
    reportdate                     DATE,
    taxamt                         NUMBER,
    confirmno                      VARCHAR2(20 BYTE),
    orgconfirmno                   VARCHAR2(20 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE oxcaschdhist
/

CREATE TABLE oxcaschdhist
    (autoid                         NUMBER DEFAULT 0,
    camastid                       NUMBER,
    txdate                         DATE,
    txnum                          VARCHAR2(30 BYTE),
    afacctno                       VARCHAR2(30 BYTE),
    balance                        NUMBER,
    amt                            NUMBER,
    qtty                           NUMBER,
    aamt                           NUMBER,
    aqtty                          NUMBER,
    deltd                          CHAR(1 BYTE),
    status                         CHAR(1 BYTE),
    orgvaluedt                     DATE,
    sbdefacctno                    VARCHAR2(30 BYTE),
    register_date                  DATE,
    reportdate                     DATE,
    taxamt                         NUMBER,
    confirmno                      VARCHAR2(20 BYTE),
    orgconfirmno                   VARCHAR2(20 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE oxinstreg
/

CREATE TABLE oxinstreg
    (autoid                         BINARY_DOUBLE,
    codeid                         VARCHAR2(20 BYTE),
    symbol                         VARCHAR2(20 BYTE),
    sectype                        VARCHAR2(3 BYTE),
    parvalue                       BINARY_DOUBLE DEFAULT 0,
    fullname                       VARCHAR2(50 BYTE),
    assetbacked                    CHAR(1 BYTE) DEFAULT 'N',
    assetnotes                     VARCHAR2(250 BYTE),
    assetpricecd                   CHAR(1 BYTE) DEFAULT 'P',
    assetpricefrq                  BINARY_DOUBLE DEFAULT 0,
    assetvalue                     BINARY_DOUBLE DEFAULT 0,
    refurl                         VARCHAR2(250 BYTE),
    issuedvol                      BINARY_DOUBLE DEFAULT 0,
    principalcd                    CHAR(1 BYTE) DEFAULT 'B',
    putoption                      CHAR(1 BYTE) DEFAULT 'N',
    calloption                     CHAR(1 BYTE) DEFAULT 'N',
    trfoption                      CHAR(1 BYTE) DEFAULT 'Y',
    callnotes                      VARCHAR2(250 BYTE),
    intratefltcd                   CHAR(1 BYTE) DEFAULT 'F',
    intratefltfrq                  VARCHAR2(50 BYTE),
    intratefltnotes                VARCHAR2(250 BYTE),
    intbaseddofy                   CHAR(1 BYTE) DEFAULT 'N',
    flintrate                      BINARY_DOUBLE DEFAULT 0,
    intrate                        BINARY_DOUBLE DEFAULT 0,
    status                         CHAR(1 BYTE) DEFAULT 'A',
    description                    VARCHAR2(250 BYTE),
    settmode                       CHAR(1 BYTE) DEFAULT 'B',
    bankacct                       VARCHAR2(100 BYTE),
    bankcd                         VARCHAR2(50 BYTE),
    spotmode                       CHAR(1 BYTE) DEFAULT 'M',
    ccpafacctno                    VARCHAR2(20 BYTE),
    mrkprice                       BINARY_DOUBLE DEFAULT 0,
    mrkdate                        TIMESTAMP (6),
    intpaidfrq                     CHAR(1 BYTE) DEFAULT 'L',
    lstintdate                     TIMESTAMP (6),
    opndate                        TIMESTAMP (6),
    duedate                        TIMESTAMP (6),
    prinpaid                       BINARY_DOUBLE DEFAULT 0,
    refinst                        VARCHAR2(20 BYTE),
    intbaseddate                   TIMESTAMP (6),
    instyp                         CHAR(1 BYTE) DEFAULT 'O',
    refcfcustid                    VARCHAR2(20 BYTE),
    refprefix                      VARCHAR2(50 BYTE),
    calldate                       TIMESTAMP (6),
    callyield                      BINARY_DOUBLE DEFAULT 0,
    putdate                        TIMESTAMP (6),
    putyield                       BINARY_DOUBLE DEFAULT 0,
    issuname                       VARCHAR2(10 BYTE),
    exday                          FLOAT(64) DEFAULT 7,
    trffeerate                     BINARY_DOUBLE DEFAULT 0,
    depofeerate                    BINARY_DOUBLE DEFAULT 0,
    floatrate                      BINARY_DOUBLE DEFAULT 0)
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE oxintrcurve
/

CREATE TABLE oxintrcurve
    (autoid                         NUMBER DEFAULT 0,
    codeid                         VARCHAR2(20 BYTE),
    refid                          NUMBER,
    shortname                      VARCHAR2(50 BYTE),
    intrcurvetp                    CHAR(3 BYTE),
    afacctno                       VARCHAR2(4000 BYTE),
    termval                        NUMBER,
    termcd                         CHAR(1 BYTE),
    effdate                        DATE,
    expdate                        DATE,
    status                         CHAR(1 BYTE),
    description                    VARCHAR2(100 BYTE),
    symbol                         VARCHAR2(20 BYTE),
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6),
    typesymbol                     VARCHAR2(40 BYTE),
    tattoan                        VARCHAR2(1 BYTE) DEFAULT 'N',
    calpv_method                   VARCHAR2(10 BYTE),
    selldtl                        VARCHAR2(4000 BYTE),
    buydtl                         VARCHAR2(4000 BYTE),
    ls_cbd                         NUMBER(20,4) DEFAULT 0,
    ls_cbc                         NUMBER(20,4) DEFAULT 0,
    discountrate                   NUMBER DEFAULT 0,
    discountrate2                  NUMBER DEFAULT 0,
    feebuyrate                     NUMBER DEFAULT 0,
    intbaseddofy                   VARCHAR2(20 BYTE) DEFAULT 'Y')
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE oxintrcurvelog
/

CREATE TABLE oxintrcurvelog
    (autoid                         BINARY_DOUBLE,
    proid                          BINARY_DOUBLE,
    proytc                         BINARY_DOUBLE DEFAULT 0,
    proprice                       BINARY_DOUBLE DEFAULT 0,
    prostdate                      TIMESTAMP (6),
    protodate                      TIMESTAMP (6),
    status                         CHAR(1 BYTE) DEFAULT 'P',
    produeamt                      BINARY_DOUBLE DEFAULT 0)
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE oxintrcurvememo
/

CREATE TABLE oxintrcurvememo
    (autoid                         NUMBER,
    codeid                         VARCHAR2(20 BYTE),
    refid                          NUMBER,
    shortname                      VARCHAR2(50 BYTE),
    intrcurvetp                    CHAR(3 BYTE),
    afacctno                       VARCHAR2(4000 BYTE),
    termval                        NUMBER,
    termcd                         CHAR(1 BYTE),
    effdate                        DATE,
    expdate                        DATE,
    status                         CHAR(1 BYTE),
    description                    VARCHAR2(100 BYTE),
    symbol                         VARCHAR2(20 BYTE),
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6),
    typesymbol                     VARCHAR2(40 BYTE),
    tattoan                        VARCHAR2(1 BYTE) DEFAULT 'N',
    calpv_method                   VARCHAR2(10 BYTE),
    selldtl                        VARCHAR2(4000 BYTE),
    buydtl                         VARCHAR2(4000 BYTE),
    ls_cbd                         NUMBER(20,4) DEFAULT 0,
    ls_cbc                         NUMBER(20,4) DEFAULT 0,
    discountrate                   NUMBER DEFAULT 0,
    discountrate2                  NUMBER DEFAULT 0,
    feebuyrate                     NUMBER DEFAULT 0,
    intbaseddofy                   VARCHAR2(20 BYTE) DEFAULT 'Y')
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE oxmast
/

CREATE TABLE oxmast
    (autoid                         NUMBER(38,0),
    confirmno                      VARCHAR2(30 BYTE),
    actype                         VARCHAR2(4 BYTE),
    txdate                         DATE,
    txtime                         VARCHAR2(20 BYTE),
    productid                      NUMBER(38,0),
    symbol                         VARCHAR2(30 BYTE),
    execqtty                       NUMBER(38,0) DEFAULT 0,
    execamt                        NUMBER(38,0) DEFAULT 0,
    settamt                        NUMBER(38,0) DEFAULT 0,
    refpostid                      VARCHAR2(30 BYTE),
    refquoteid                     VARCHAR2(30 BYTE),
    category                       CHAR(1 BYTE),
    acbuyer                        VARCHAR2(30 BYTE),
    acseller                       VARCHAR2(30 BYTE),
    acoxcash                       VARCHAR2(50 BYTE),
    acoxbank                       VARCHAR2(30 BYTE),
    deltd                          CHAR(1 BYTE),
    status                         CHAR(1 BYTE),
    feebuyer                       NUMBER(38,0) DEFAULT 0,
    feeseller                      NUMBER(38,0) DEFAULT 0,
    taxbuyer                       NUMBER(38,0) DEFAULT 0,
    taxseller                      NUMBER(38,0) DEFAULT 0,
    idbuyer                        VARCHAR2(30 BYTE),
    idseller                       VARCHAR2(30 BYTE),
    ispayment                      VARCHAR2(1 BYTE),
    istransfer                     CHAR(1 BYTE),
    price                          NUMBER(38,0) DEFAULT 0,
    moneywaitting                  NUMBER(38,0) DEFAULT 0,
    isdoing                        VARCHAR2(15 BYTE),
    orgdate                        DATE,
    orgconfirmno                   VARCHAR2(100 BYTE),
    sbdefacctno                    VARCHAR2(30 BYTE),
    settwaitting                   NUMBER(38,0) DEFAULT 0,
    buyconfirmno                   VARCHAR2(100 BYTE),
    orgprice                       NUMBER(38,0) DEFAULT 0,
    ccpafacctno                    VARCHAR2(30 BYTE),
    comboid                        NUMBER(38,0),
    promotion                      NUMBER(10,5) DEFAULT 0,
    renew                          VARCHAR2(10 BYTE) DEFAULT 'N',
    orgdeal_renew                  VARCHAR2(10 BYTE) DEFAULT '',
    couponfree                     CHAR(1 BYTE),
    couponfreefee                  NUMBER(38,0) DEFAULT 0,
    orderid                        VARCHAR2(30 BYTE),
    combounit                      NUMBER,
    contract_no                    VARCHAR2(200 BYTE),
    comboprice                     NUMBER,
    traderid                       VARCHAR2(30 BYTE),
    checkerid                      VARCHAR2(30 BYTE),
    ttkd_profile_stat              CHAR(1 BYTE),
    bks_profile_stat               CHAR(1 BYTE),
    appr_stat                      CHAR(1 BYTE),
    sett_stat                      CHAR(1 BYTE),
    transfer_stat                  CHAR(1 BYTE),
    accounting_stat                CHAR(1 BYTE),
    sale_manager_id                VARCHAR2(30 BYTE),
    idcode_collab                  VARCHAR2(30 BYTE),
    collab_id                      VARCHAR2(30 BYTE),
    brid                           VARCHAR2(30 BYTE),
    acoxcitybank                   VARCHAR2(1000 BYTE),
    matdate                        DATE,
    transfer_date                  DATE,
    pending_clsqtty                NUMBER(38,0) DEFAULT 0,
    clsqtty                        NUMBER(38,0) DEFAULT 0,
    soldqtty                       NUMBER(38,0) DEFAULT 0,
    start_prof_debt_dt             DATE,
    last_update_prof_dt            DATE,
    ttkd_reason                    VARCHAR2(30 BYTE),
    bks_reason                     VARCHAR2(30 BYTE),
    shs_reason                     VARCHAR2(1000 BYTE),
    isprofessor                    VARCHAR2(10 BYTE),
    refissuid                      NUMBER,
    ttkd_stat_maker                CHAR(1 BYTE),
    bks_stat_maker                 CHAR(1 BYTE),
    ttkd_reason_maker              VARCHAR2(30 BYTE),
    bks_reason_maker               VARCHAR2(30 BYTE),
    intrate                        NUMBER,
    ttkd_tlid                      VARCHAR2(30 BYTE),
    ttkd_offid                     VARCHAR2(30 BYTE),
    bks_tlid                       VARCHAR2(30 BYTE),
    bks_offid                      VARCHAR2(30 BYTE),
    shs_tlid                       VARCHAR2(30 BYTE),
    islisted                       VARCHAR2(10 BYTE),
    ispushed                       VARCHAR2(10 BYTE),
    moneytransfer                  CHAR(1 BYTE) DEFAULT 'N',
    issueowner                     CHAR(1 BYTE) DEFAULT 'Y',
    intadj                         CHAR(1 BYTE) DEFAULT 'N',
    comprogram                     NUMBER,
    sellercash                     VARCHAR2(100 BYTE),
    sellerbank                     VARCHAR2(100 BYTE),
    sellercitybank                 VARCHAR2(100 BYTE),
    isrmsales                      VARCHAR2(10 BYTE) DEFAULT 'Y',
    beforeadjprice                 NUMBER,
    buyercash                      VARCHAR2(100 BYTE),
    isissued                       VARCHAR2(10 BYTE),
    rateadjurl                     VARCHAR2(200 BYTE),
    buyerbank                      VARCHAR2(200 BYTE),
    buyercitybank                  VARCHAR2(200 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE oxmastca
/

CREATE TABLE oxmastca
    (autoid                         BINARY_DOUBLE DEFAULT 0,
    confirmno                      VARCHAR2(30 BYTE),
    actype                         VARCHAR2(4 BYTE),
    txdate                         DATE,
    txtime                         VARCHAR2(20 BYTE),
    productid                      BINARY_DOUBLE,
    symbol                         VARCHAR2(30 BYTE),
    execqtty                       BINARY_DOUBLE,
    execamt                        BINARY_DOUBLE,
    balance                        BINARY_DOUBLE,
    settamt                        BINARY_DOUBLE,
    refpostid                      VARCHAR2(30 BYTE),
    refsubsid                      VARCHAR2(30 BYTE),
    category                       CHAR(1 BYTE),
    dvpmode                        CHAR(1 BYTE),
    acbuyer                        VARCHAR2(30 BYTE),
    acseller                       VARCHAR2(30 BYTE),
    acoxccp                        VARCHAR2(30 BYTE),
    acoxcash                       VARCHAR2(50 BYTE),
    acoxbank                       VARCHAR2(30 BYTE),
    contrtyp                       CHAR(1 BYTE) DEFAULT 'T',
    deltd                          CHAR(1 BYTE),
    status                         CHAR(1 BYTE),
    feebuyer                       BINARY_DOUBLE,
    feeseller                      BINARY_DOUBLE,
    taxbuyer                       BINARY_DOUBLE,
    taxseller                      BINARY_DOUBLE,
    idbuyer                        VARCHAR2(30 BYTE),
    idseller                       VARCHAR2(30 BYTE),
    ispayment                      VARCHAR2(1 BYTE),
    istransfer                     CHAR(1 BYTE),
    price                          BINARY_DOUBLE,
    moneywaitting                  BINARY_DOUBLE,
    isdoing                        VARCHAR2(15 BYTE),
    orgdate                        DATE,
    orgconfirmno                   VARCHAR2(100 BYTE),
    sbdefacctno                    VARCHAR2(30 BYTE),
    camastid                       BINARY_DOUBLE,
    camaststatus                   VARCHAR2(15 BYTE),
    remainqtty                     BINARY_DOUBLE)
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE oxmasthist
/

CREATE TABLE oxmasthist
    (autoid                         NUMBER(38,0),
    confirmno                      VARCHAR2(30 BYTE),
    actype                         VARCHAR2(4 BYTE),
    txdate                         DATE,
    txtime                         VARCHAR2(20 BYTE),
    productid                      NUMBER(38,0),
    symbol                         VARCHAR2(30 BYTE),
    execqtty                       NUMBER(38,0),
    execamt                        NUMBER(38,0),
    settamt                        NUMBER(38,0),
    refpostid                      VARCHAR2(30 BYTE),
    refquoteid                     VARCHAR2(30 BYTE),
    category                       CHAR(1 BYTE),
    acbuyer                        VARCHAR2(30 BYTE),
    acseller                       VARCHAR2(30 BYTE),
    acoxcash                       VARCHAR2(50 BYTE),
    acoxbank                       VARCHAR2(30 BYTE),
    deltd                          CHAR(1 BYTE),
    status                         CHAR(1 BYTE),
    feebuyer                       NUMBER(38,0),
    feeseller                      NUMBER(38,0),
    taxbuyer                       NUMBER(38,0),
    taxseller                      NUMBER(38,0),
    idbuyer                        VARCHAR2(30 BYTE),
    idseller                       VARCHAR2(30 BYTE),
    ispayment                      VARCHAR2(1 BYTE),
    istransfer                     CHAR(1 BYTE),
    price                          NUMBER(38,0),
    moneywaitting                  NUMBER(38,0),
    isdoing                        VARCHAR2(15 BYTE),
    orgdate                        DATE,
    orgconfirmno                   VARCHAR2(100 BYTE),
    sbdefacctno                    VARCHAR2(30 BYTE),
    settwaitting                   NUMBER(38,0),
    buyconfirmno                   VARCHAR2(100 BYTE),
    orgprice                       NUMBER(38,0),
    ccpafacctno                    VARCHAR2(30 BYTE),
    comboid                        NUMBER(38,0),
    promotion                      NUMBER(10,5),
    renew                          VARCHAR2(10 BYTE),
    orgdeal_renew                  VARCHAR2(10 BYTE),
    couponfree                     CHAR(1 BYTE),
    couponfreefee                  NUMBER(38,0),
    orderid                        VARCHAR2(30 BYTE),
    combounit                      NUMBER,
    contract_no                    VARCHAR2(200 BYTE),
    comboprice                     NUMBER,
    traderid                       VARCHAR2(30 BYTE),
    checkerid                      VARCHAR2(30 BYTE),
    ttkd_profile_stat              CHAR(1 BYTE),
    bks_profile_stat               CHAR(1 BYTE),
    appr_stat                      CHAR(1 BYTE),
    sett_stat                      CHAR(1 BYTE),
    transfer_stat                  CHAR(1 BYTE),
    accounting_stat                CHAR(1 BYTE),
    sale_manager_id                VARCHAR2(30 BYTE),
    idcode_collab                  VARCHAR2(30 BYTE),
    collab_id                      VARCHAR2(30 BYTE),
    brid                           VARCHAR2(30 BYTE),
    acoxcitybank                   VARCHAR2(1000 BYTE),
    matdate                        DATE,
    transfer_date                  DATE,
    pending_clsqtty                NUMBER(38,0),
    clsqtty                        NUMBER(38,0),
    soldqtty                       NUMBER(38,0),
    start_prof_debt_dt             DATE,
    last_update_prof_dt            DATE,
    ttkd_reason                    VARCHAR2(30 BYTE),
    bks_reason                     VARCHAR2(30 BYTE),
    shs_reason                     VARCHAR2(1000 BYTE),
    isprofessor                    VARCHAR2(10 BYTE),
    refissuid                      NUMBER,
    ttkd_stat_maker                CHAR(1 BYTE),
    bks_stat_maker                 CHAR(1 BYTE),
    ttkd_reason_maker              VARCHAR2(30 BYTE),
    bks_reason_maker               VARCHAR2(30 BYTE),
    intrate                        NUMBER,
    ttkd_tlid                      VARCHAR2(30 BYTE),
    ttkd_offid                     VARCHAR2(30 BYTE),
    bks_tlid                       VARCHAR2(30 BYTE),
    bks_offid                      VARCHAR2(30 BYTE),
    shs_tlid                       VARCHAR2(30 BYTE),
    islisted                       VARCHAR2(10 BYTE),
    ispushed                       VARCHAR2(10 BYTE),
    moneytransfer                  CHAR(1 BYTE),
    issueowner                     CHAR(1 BYTE),
    intadj                         CHAR(1 BYTE),
    comprogram                     NUMBER,
    sellercash                     VARCHAR2(100 BYTE),
    sellerbank                     VARCHAR2(100 BYTE),
    sellercitybank                 VARCHAR2(100 BYTE),
    isrmsales                      VARCHAR2(10 BYTE),
    beforeadjprice                 NUMBER,
    buyercash                      VARCHAR2(100 BYTE),
    isissued                       VARCHAR2(10 BYTE),
    rateadjurl                     VARCHAR2(200 BYTE),
    buyerbank                      VARCHAR2(200 BYTE),
    buyercitybank                  VARCHAR2(200 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE oxmastipo
/

CREATE TABLE oxmastipo
    (autoid                         NUMBER(38,0),
    reforderid                     VARCHAR2(20 BYTE),
    refipoid                       NUMBER(38,0),
    txdate                         DATE,
    txnum                          VARCHAR2(30 BYTE),
    afacctno                       VARCHAR2(30 BYTE),
    codeid                         VARCHAR2(10 BYTE),
    symbol                         VARCHAR2(30 BYTE),
    qtty                           NUMBER(38,0),
    price                          NUMBER(38,0),
    deltd                          CHAR(1 BYTE),
    status                         CHAR(1 BYTE))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE oxmastleg
/

CREATE TABLE oxmastleg
    (autoid                         NUMBER(38,0),
    orgorderid                     NUMBER(38,0),
    reforderid                     NUMBER(38,0),
    symbol                         VARCHAR2(30 BYTE),
    legcd                          CHAR(1 BYTE),
    orgacctno                      VARCHAR2(20 BYTE),
    afacctno                       VARCHAR2(20 BYTE),
    coacctno                       VARCHAR2(20 BYTE),
    optioncd                       CHAR(1 BYTE),
    orgqtty                        NUMBER(38,0) DEFAULT 0,
    exerqtty                       NUMBER(38,0) DEFAULT 0,
    confirmno                      VARCHAR2(20 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE oxmastleghist
/

CREATE TABLE oxmastleghist
    (autoid                         NUMBER(38,0),
    orgorderid                     NUMBER(38,0),
    reforderid                     NUMBER(38,0),
    symbol                         VARCHAR2(30 BYTE),
    legcd                          CHAR(1 BYTE),
    orgacctno                      VARCHAR2(20 BYTE),
    afacctno                       VARCHAR2(20 BYTE),
    coacctno                       VARCHAR2(20 BYTE),
    optioncd                       CHAR(1 BYTE),
    orgqtty                        NUMBER(38,0),
    exerqtty                       NUMBER(38,0),
    confirmno                      VARCHAR2(20 BYTE))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE oxmastlegmap
/

CREATE TABLE oxmastlegmap
    (autoid                         BINARY_DOUBLE DEFAULT 0,
    mlegtyp                        CHAR(1 BYTE),
    blegid                         BINARY_DOUBLE,
    slegid                         BINARY_DOUBLE,
    codeid                         VARCHAR2(30 BYTE),
    symbol                         VARCHAR2(30 BYTE),
    afacctno                       VARCHAR2(30 BYTE),
    qtty                           BINARY_DOUBLE,
    txdate                         DATE,
    txnum                          VARCHAR2(30 BYTE),
    deltd                          CHAR(1 BYTE),
    status                         CHAR(1 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE oxmastlegmaphist
/

CREATE TABLE oxmastlegmaphist
    (autoid                         BINARY_DOUBLE,
    mlegtyp                        CHAR(1 BYTE),
    blegid                         BINARY_DOUBLE,
    slegid                         BINARY_DOUBLE,
    codeid                         VARCHAR2(30 BYTE),
    symbol                         VARCHAR2(30 BYTE),
    afacctno                       VARCHAR2(30 BYTE),
    qtty                           BINARY_DOUBLE,
    txdate                         DATE,
    txnum                          VARCHAR2(30 BYTE),
    deltd                          CHAR(1 BYTE),
    status                         CHAR(1 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE oxmasttemp
/

CREATE TABLE oxmasttemp
    (txnum                          VARCHAR2(50 BYTE),
    txdate                         DATE,
    acctno                         VARCHAR2(100 BYTE),
    symbol                         VARCHAR2(50 BYTE),
    isprofessor                    VARCHAR2(10 BYTE),
    ispushed                       VARCHAR2(10 BYTE),
    islisted                       VARCHAR2(10 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE oxpost
/

CREATE TABLE oxpost
    (autoid                         NUMBER(38,0) NOT NULL,
    orderid                        VARCHAR2(30 BYTE),
    txdate                         DATE,
    txtime                         VARCHAR2(30 BYTE),
    traderid                       VARCHAR2(30 BYTE),
    checkerid                      VARCHAR2(30 BYTE),
    afacctno                       VARCHAR2(30 BYTE),
    publicacct                     VARCHAR2(30 BYTE),
    coacctno                       VARCHAR2(4000 BYTE),
    category                       VARCHAR2(30 BYTE),
    side                           VARCHAR2(30 BYTE),
    codeid                         VARCHAR2(30 BYTE),
    symbol                         VARCHAR2(30 BYTE),
    effdate                        DATE,
    expdate                        DATE,
    quoteval                       NUMBER(38,0) DEFAULT 0,
    publicval                      NUMBER(38,0) DEFAULT 0,
    availval                       NUMBER(38,0) DEFAULT 0,
    quoteprice                     NUMBER(38,0) DEFAULT 0,
    subsqtty                       NUMBER(38,0) DEFAULT 0,
    subsamt                        NUMBER(38,0) DEFAULT 0,
    firmqtty                       NUMBER(38,0) DEFAULT 0,
    firmamt                        NUMBER(38,0) DEFAULT 0,
    settqtty                       NUMBER(38,0) DEFAULT 0,
    settamt                        NUMBER(38,0) DEFAULT 0,
    cancelqtty                     NUMBER(38,0) DEFAULT 0,
    status                         VARCHAR2(30 BYTE),
    lastchange                     TIMESTAMP (6) DEFAULT NULL,
    productid                      VARCHAR2(500 BYTE) DEFAULT NULL,
    refissuid                      NUMBER(38,0) DEFAULT NULL,
    reflegid                       NUMBER(38,0) DEFAULT NULL,
    txnum                          VARCHAR2(100 BYTE),
    dealeraccount                  VARCHAR2(30 BYTE),
    orgconfirmno                   VARCHAR2(30 BYTE),
    refadid                        VARCHAR2(30 BYTE),
    orgdate                        DATE,
    buyconfirmno                   VARCHAR2(100 BYTE),
    quoterate                      NUMBER(38,2) DEFAULT NULL,
    orgprice                       NUMBER(38,0) DEFAULT NULL,
    comboid                        NUMBER(38,0) DEFAULT NULL,
    sellopt                        VARCHAR2(1 BYTE),
    coabr                          VARCHAR2(2000 BYTE),
    maxqtty                        NUMBER,
    maxqttypercus                  NUMBER,
    cftype                         VARCHAR2(4000 BYTE),
    cfonline                       VARCHAR2(10 BYTE),
    quotetype                      VARCHAR2(10 BYTE),
    orgproductid                   NUMBER)
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE oxpost_bk
/

CREATE TABLE oxpost_bk
    (autoid                         NUMBER(38,0) NOT NULL,
    orderid                        VARCHAR2(30 BYTE),
    txdate                         DATE,
    txtime                         VARCHAR2(30 BYTE),
    traderid                       VARCHAR2(30 BYTE),
    checkerid                      VARCHAR2(30 BYTE),
    afacctno                       VARCHAR2(30 BYTE),
    publicacct                     VARCHAR2(30 BYTE),
    coacctno                       VARCHAR2(4000 BYTE),
    category                       VARCHAR2(30 BYTE),
    side                           VARCHAR2(30 BYTE),
    codeid                         VARCHAR2(30 BYTE),
    symbol                         VARCHAR2(30 BYTE),
    effdate                        DATE,
    expdate                        DATE,
    quoteval                       NUMBER(38,0),
    publicval                      NUMBER(38,0),
    availval                       NUMBER(38,0),
    quoteprice                     NUMBER(38,0),
    subsqtty                       NUMBER(38,0),
    subsamt                        NUMBER(38,0),
    firmqtty                       NUMBER(38,0),
    firmamt                        NUMBER(38,0),
    settqtty                       NUMBER(38,0),
    settamt                        NUMBER(38,0),
    cancelqtty                     NUMBER(38,0),
    status                         VARCHAR2(30 BYTE),
    lastchange                     TIMESTAMP (6),
    productid                      NUMBER(38,0),
    refissuid                      NUMBER(38,0),
    reflegid                       NUMBER(38,0),
    txnum                          VARCHAR2(100 BYTE),
    dealeraccount                  VARCHAR2(30 BYTE),
    orgconfirmno                   VARCHAR2(30 BYTE),
    refadid                        VARCHAR2(30 BYTE),
    orgdate                        DATE,
    buyconfirmno                   VARCHAR2(100 BYTE),
    quoterate                      NUMBER(38,2),
    orgprice                       NUMBER(38,0),
    comboid                        NUMBER(38,0),
    sellopt                        VARCHAR2(1 BYTE),
    coabr                          VARCHAR2(500 BYTE),
    maxqtty                        NUMBER)
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE oxposthist
/

CREATE TABLE oxposthist
    (autoid                         NUMBER(38,0) NOT NULL,
    orderid                        VARCHAR2(30 BYTE),
    txdate                         DATE,
    txtime                         VARCHAR2(30 BYTE),
    traderid                       VARCHAR2(30 BYTE),
    checkerid                      VARCHAR2(30 BYTE),
    afacctno                       VARCHAR2(30 BYTE),
    publicacct                     VARCHAR2(30 BYTE),
    coacctno                       VARCHAR2(4000 BYTE),
    category                       VARCHAR2(30 BYTE),
    side                           VARCHAR2(30 BYTE),
    codeid                         VARCHAR2(30 BYTE),
    symbol                         VARCHAR2(30 BYTE),
    effdate                        DATE,
    expdate                        DATE,
    quoteval                       NUMBER(38,0) DEFAULT 0,
    publicval                      NUMBER(38,0) DEFAULT 0,
    availval                       NUMBER(38,0) DEFAULT 0,
    quoteprice                     NUMBER(38,0) DEFAULT 0,
    subsqtty                       NUMBER(38,0) DEFAULT 0,
    subsamt                        NUMBER(38,0) DEFAULT 0,
    firmqtty                       NUMBER(38,0) DEFAULT 0,
    firmamt                        NUMBER(38,0) DEFAULT 0,
    settqtty                       NUMBER(38,0) DEFAULT 0,
    settamt                        NUMBER(38,0) DEFAULT 0,
    cancelqtty                     NUMBER(38,0) DEFAULT 0,
    status                         VARCHAR2(30 BYTE),
    lastchange                     TIMESTAMP (6) DEFAULT NULL,
    productid                      VARCHAR2(500 BYTE) DEFAULT NULL,
    refissuid                      NUMBER(38,0) DEFAULT NULL,
    reflegid                       NUMBER(38,0) DEFAULT NULL,
    txnum                          VARCHAR2(100 BYTE),
    dealeraccount                  VARCHAR2(30 BYTE),
    orgconfirmno                   VARCHAR2(30 BYTE),
    refadid                        VARCHAR2(30 BYTE),
    orgdate                        DATE,
    buyconfirmno                   VARCHAR2(100 BYTE),
    quoterate                      NUMBER(38,2) DEFAULT NULL,
    orgprice                       NUMBER(38,0) DEFAULT NULL,
    comboid                        NUMBER(38,0) DEFAULT NULL,
    sellopt                        VARCHAR2(1 BYTE),
    coabr                          VARCHAR2(500 BYTE),
    maxqtty                        NUMBER,
    maxqttypercus                  NUMBER,
    cftype                         VARCHAR2(4000 BYTE),
    cfonline                       VARCHAR2(10 BYTE),
    quotetype                      VARCHAR2(10 BYTE),
    orgproductid                   NUMBER)
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE oxposthist_bk
/

CREATE TABLE oxposthist_bk
    (autoid                         NUMBER(38,0) NOT NULL,
    orderid                        VARCHAR2(30 BYTE),
    txdate                         DATE,
    txtime                         VARCHAR2(30 BYTE),
    traderid                       VARCHAR2(30 BYTE),
    checkerid                      VARCHAR2(30 BYTE),
    afacctno                       VARCHAR2(30 BYTE),
    publicacct                     VARCHAR2(30 BYTE),
    coacctno                       VARCHAR2(4000 BYTE),
    category                       VARCHAR2(30 BYTE),
    side                           VARCHAR2(30 BYTE),
    codeid                         VARCHAR2(30 BYTE),
    symbol                         VARCHAR2(30 BYTE),
    effdate                        DATE,
    expdate                        DATE,
    quoteval                       NUMBER(38,0),
    publicval                      NUMBER(38,0),
    availval                       NUMBER(38,0),
    quoteprice                     NUMBER(38,0),
    subsqtty                       NUMBER(38,0),
    subsamt                        NUMBER(38,0),
    firmqtty                       NUMBER(38,0),
    firmamt                        NUMBER(38,0),
    settqtty                       NUMBER(38,0),
    settamt                        NUMBER(38,0),
    cancelqtty                     NUMBER(38,0),
    status                         VARCHAR2(30 BYTE),
    lastchange                     TIMESTAMP (6),
    productid                      NUMBER(38,0),
    refissuid                      NUMBER(38,0),
    reflegid                       NUMBER(38,0),
    txnum                          VARCHAR2(100 BYTE),
    dealeraccount                  VARCHAR2(30 BYTE),
    orgconfirmno                   VARCHAR2(30 BYTE),
    refadid                        VARCHAR2(30 BYTE),
    orgdate                        DATE,
    buyconfirmno                   VARCHAR2(100 BYTE),
    quoterate                      NUMBER(38,2),
    orgprice                       NUMBER(38,0),
    comboid                        NUMBER(38,0),
    sellopt                        VARCHAR2(1 BYTE),
    coabr                          VARCHAR2(500 BYTE),
    maxqtty                        NUMBER)
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE oxpostipo
/

CREATE TABLE oxpostipo
    (autoid                         NUMBER(38,0),
    orderid                        VARCHAR2(30 BYTE),
    txdate                         DATE,
    txtime                         VARCHAR2(30 BYTE),
    traderid                       VARCHAR2(30 BYTE),
    checkerid                      VARCHAR2(30 BYTE),
    afacctno                       VARCHAR2(30 BYTE),
    codeid                         VARCHAR2(30 BYTE),
    symbol                         VARCHAR2(30 BYTE),
    quotecd                        VARCHAR2(30 BYTE),
    quoteval                       NUMBER(38,0),
    pricecd                        VARCHAR2(20 BYTE),
    quoteprice                     NUMBER(38,0),
    firmqtty                       NUMBER(38,0),
    firmprice                      NUMBER(38,0),
    firmamt                        NUMBER(38,0),
    settqtty                       NUMBER(38,0),
    settamt                        NUMBER(38,0),
    status                         VARCHAR2(30 BYTE),
    productid                      NUMBER(38,0),
    txnum                          VARCHAR2(100 BYTE),
    duedate                        DATE)
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE oxpostipo_temp
/

CREATE TABLE oxpostipo_temp
    (orderid                        VARCHAR2(200 BYTE),
    symbol                         VARCHAR2(30 BYTE),
    custodycd                      VARCHAR2(200 BYTE),
    quoteval                       NUMBER(38,0))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE oxpostipomap
/

CREATE TABLE oxpostipomap
    (autoid                         NUMBER(38,0),
    confirmno                      VARCHAR2(30 BYTE),
    actype                         VARCHAR2(4 BYTE),
    txdate                         DATE,
    txtime                         VARCHAR2(20 BYTE),
    productid                      NUMBER(38,0),
    symbol                         VARCHAR2(30 BYTE),
    execqtty                       NUMBER(38,0),
    execprice                      NUMBER(38,0),
    execamt                        NUMBER(38,0),
    settamt                        NUMBER(38,0),
    firmqtty                       NUMBER(38,0),
    firmamt                        NUMBER(38,0),
    refpostid                      VARCHAR2(30 BYTE),
    dvpmode                        CHAR(1 BYTE),
    acbuyer                        VARCHAR2(30 BYTE),
    acseller                       VARCHAR2(30 BYTE),
    acoxccp                        VARCHAR2(30 BYTE),
    acoxcash                       VARCHAR2(30 BYTE),
    acoxbank                       VARCHAR2(30 BYTE),
    deltd                          CHAR(1 BYTE),
    status                         CHAR(1 BYTE),
    feebuyer                       NUMBER(38,0),
    feeseller                      NUMBER(38,0),
    taxbuyer                       NUMBER(38,0),
    taxseller                      NUMBER(38,0),
    idbuyer                        VARCHAR2(30 BYTE),
    idseller                       VARCHAR2(30 BYTE),
    istranfer                      CHAR(1 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE oxpostipomemo
/

CREATE TABLE oxpostipomemo
    (autoid                         NUMBER(38,0),
    orderid                        VARCHAR2(30 BYTE),
    txdate                         DATE,
    txtime                         VARCHAR2(30 BYTE),
    traderid                       VARCHAR2(30 BYTE),
    checkerid                      VARCHAR2(30 BYTE),
    afacctno                       VARCHAR2(30 BYTE),
    codeid                         VARCHAR2(30 BYTE),
    symbol                         VARCHAR2(30 BYTE),
    quotecd                        VARCHAR2(30 BYTE),
    quoteval                       NUMBER(38,0),
    pricecd                        VARCHAR2(20 BYTE),
    quoteprice                     NUMBER(38,0),
    firmqtty                       NUMBER(38,0),
    firmprice                      NUMBER(38,0),
    firmamt                        NUMBER(38,0),
    settqtty                       NUMBER(38,0),
    settamt                        NUMBER(38,0),
    status                         VARCHAR2(30 BYTE),
    productid                      NUMBER(38,0),
    txnum                          VARCHAR2(100 BYTE),
    duedate                        DATE)
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE oxquote
/

CREATE TABLE oxquote
    (autoid                         NUMBER(38,0),
    refpostid                      VARCHAR2(20 BYTE),
    refdealid                      VARCHAR2(20 BYTE),
    quoteid                        VARCHAR2(30 BYTE),
    txdate                         DATE,
    txtime                         VARCHAR2(30 BYTE),
    traderid                       VARCHAR2(30 BYTE),
    checkerid                      VARCHAR2(30 BYTE),
    afacctno                       VARCHAR2(30 BYTE),
    ioiacctno                      VARCHAR2(30 BYTE),
    codeid                         VARCHAR2(30 BYTE),
    symbol                         VARCHAR2(30 BYTE),
    category                       CHAR(1 BYTE),
    side                           CHAR(1 BYTE),
    qtty                           NUMBER(38,0),
    amt                            NUMBER(38,0),
    expdate                        DATE,
    deltd                          CHAR(1 BYTE),
    status                         CHAR(1 BYTE),
    quoterate                      NUMBER(10,5))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE oxquotehist
/

CREATE TABLE oxquotehist
    (autoid                         NUMBER(38,0),
    refpostid                      VARCHAR2(20 BYTE),
    refdealid                      VARCHAR2(20 BYTE),
    quoteid                        VARCHAR2(30 BYTE),
    txdate                         DATE,
    txtime                         VARCHAR2(30 BYTE),
    traderid                       VARCHAR2(30 BYTE),
    checkerid                      VARCHAR2(30 BYTE),
    afacctno                       VARCHAR2(30 BYTE),
    ioiacctno                      VARCHAR2(30 BYTE),
    codeid                         VARCHAR2(30 BYTE),
    symbol                         VARCHAR2(30 BYTE),
    category                       CHAR(1 BYTE),
    side                           CHAR(1 BYTE),
    qtty                           NUMBER(38,0),
    amt                            NUMBER(38,0),
    expdate                        DATE,
    deltd                          CHAR(1 BYTE),
    status                         CHAR(1 BYTE),
    quoterate                      NUMBER(10,5))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE oxsubscribe
/

CREATE TABLE oxsubscribe
    (autoid                         BINARY_DOUBLE DEFAULT 0,
    orderid                        VARCHAR2(30 BYTE),
    txdate                         DATE,
    txtime                         VARCHAR2(30 BYTE),
    traderid                       VARCHAR2(30 BYTE),
    checkerid                      VARCHAR2(30 BYTE),
    reforderid                     VARCHAR2(30 BYTE),
    ioiacctno                      VARCHAR2(30 BYTE),
    afacctno                       VARCHAR2(30 BYTE),
    category                       CHAR(1 BYTE),
    side                           CHAR(1 BYTE),
    codeid                         VARCHAR2(20 BYTE),
    symbol                         VARCHAR2(30 BYTE),
    subsqtty                       BINARY_DOUBLE,
    subsamt                        BINARY_DOUBLE,
    status                         CHAR(1 BYTE),
    ioiotp                         VARCHAR2(100 BYTE),
    ioiotptimestamp                TIMESTAMP (6),
    ioiotpconf                     CHAR(1 BYTE) DEFAULT 'N',
    afotp                          VARCHAR2(100 BYTE),
    afotptimestamp                 TIMESTAMP (6),
    afotpconf                      CHAR(1 BYTE) DEFAULT 'N',
    acbuyer                        VARCHAR2(20 BYTE),
    acseller                       VARCHAR2(20 BYTE),
    expdate                        DATE)
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE oxsubscribehist
/

CREATE TABLE oxsubscribehist
    (autoid                         BINARY_DOUBLE,
    orderid                        VARCHAR2(30 BYTE),
    txdate                         DATE,
    txtime                         VARCHAR2(30 BYTE),
    traderid                       VARCHAR2(30 BYTE),
    checkerid                      VARCHAR2(30 BYTE),
    reforderid                     VARCHAR2(30 BYTE),
    ioiacctno                      VARCHAR2(30 BYTE),
    afacctno                       VARCHAR2(30 BYTE),
    category                       CHAR(1 BYTE),
    side                           CHAR(1 BYTE),
    codeid                         VARCHAR2(20 BYTE),
    symbol                         VARCHAR2(30 BYTE),
    subsqtty                       BINARY_DOUBLE,
    subsamt                        BINARY_DOUBLE,
    status                         CHAR(1 BYTE),
    ioiotp                         VARCHAR2(100 BYTE),
    ioiotptimestamp                TIMESTAMP (6),
    ioiotpconf                     CHAR(1 BYTE) DEFAULT 'N',
    afotp                          VARCHAR2(100 BYTE),
    afotptimestamp                 TIMESTAMP (6),
    afotpconf                      CHAR(1 BYTE) DEFAULT 'N',
    acbuyer                        VARCHAR2(20 BYTE),
    acseller                       VARCHAR2(20 BYTE),
    expdate                        DATE)
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE oxtran
/

CREATE TABLE oxtran
    (autoid                         NUMBER(38,0),
    txnum                          VARCHAR2(100 BYTE),
    txdate                         DATE,
    tltxcd                         VARCHAR2(4 BYTE),
    bkdate                         DATE,
    deltd                          VARCHAR2(1 BYTE),
    txtype                         VARCHAR2(1 BYTE),
    amt                            NUMBER(38,0),
    orgconfirmno                   VARCHAR2(20 BYTE),
    orgdate                        DATE,
    acbuyer                        VARCHAR2(30 BYTE),
    taxamt                         NUMBER,
    feeamt                         NUMBER,
    qtty                           NUMBER)
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE p_autoid
/

CREATE TABLE p_autoid
    (autoid                         FLOAT(64))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE p_date
/

CREATE TABLE p_date
    (id                             FLOAT(64))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE p_draff
/

CREATE TABLE p_draff
    (col1                           FLOAT(32),
    col2                           FLOAT(32))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE p_id
/

CREATE TABLE p_id
    (autoid                         FLOAT(64))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE p_test
/

CREATE TABLE p_test
    (reporttemplate                 VARCHAR2(255 BYTE))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE p_tlidgt
/

CREATE TABLE p_tlidgt
    (tlid                           VARCHAR2(6 BYTE))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE pamast
/

CREATE TABLE pamast
    (autoid                         NUMBER(20,0),
    acctno                         VARCHAR2(50 BYTE),
    custid                         VARCHAR2(10 BYTE),
    sid                            VARCHAR2(20 BYTE),
    pensionid                      NUMBER(20,0),
    employerid                     NUMBER(20,0) DEFAULT 0,
    fundcodeid                     VARCHAR2(10 BYTE),
    bankcd                         VARCHAR2(10 BYTE),
    bankacctno                     VARCHAR2(50 BYTE),
    patype                         VARCHAR2(30 BYTE),
    actype                         VARCHAR2(10 BYTE),
    contributeschd                 VARCHAR2(100 BYTE),
    eeyamt                         NUMBER(20,0) DEFAULT 0,
    eeramt                         NUMBER(20,0) DEFAULT 0,
    termcd                         VARCHAR2(3 BYTE),
    termval                        NUMBER(20,0) DEFAULT 0,
    pammentcd                      VARCHAR2(3 BYTE),
    pammentval                     NUMBER(20,0) DEFAULT 0,
    eercramt                       NUMBER(20,0) DEFAULT 0,
    eeycramt                       NUMBER(20,0) DEFAULT 0,
    eerfundamt                     NUMBER(20,0) DEFAULT 0,
    eeyfundamt                     NUMBER(20,0) DEFAULT 0,
    eerdramt                       NUMBER(20,0) DEFAULT 0,
    eeydramt                       NUMBER(20,0) DEFAULT 0,
    feecramt                       NUMBER(20,0) DEFAULT 0,
    taxcramt                       NUMBER(20,0) DEFAULT 0,
    feeamtall                      NUMBER(20,0) DEFAULT 0,
    taxamtall                      NUMBER(20,0) DEFAULT 0,
    status                         CHAR(1 BYTE) DEFAULT 'P',
    opndt                          DATE,
    duedt                          DATE,
    startcontridt                  DATE,
    startpaymentdt                 DATE,
    clsdt                          DATE,
    dormdt                         DATE,
    description                    VARCHAR2(250 BYTE),
    createddt                      DATE,
    lastdate                       DATE,
    lastchange                     TIMESTAMP (6),
    txdate                         DATE,
    txnum                          VARCHAR2(100 BYTE),
    eeyfundqtty                    NUMBER(20,6) DEFAULT 0,
    eerfundqtty                    NUMBER(20,6) DEFAULT 0,
    eeyschdamt                     NUMBER(20,6) DEFAULT 0,
    eerschdamt                     NUMBER(20,6) DEFAULT 0,
    pstatus                        VARCHAR2(200 BYTE),
    eerextdt                       DATE,
    err1stdt                       DATE,
    unvestval                      NUMBER(20,4) DEFAULT 0,
    custodycd                      VARCHAR2(10 BYTE),
    vestingdttyp                   VARCHAR2(1000 BYTE),
    haltdate                       DATE)
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

CREATE UNIQUE INDEX pamast_index_pk ON pamast
  (
    acctno                          ASC
  )
NOPARALLEL
NOLOGGING
/

CREATE INDEX pamast_custid_idx ON pamast
  (
    custid                          ASC
  )
NOPARALLEL
NOLOGGING
/

CREATE INDEX pamast_custodycd_idx ON pamast
  (
    custodycd                       ASC
  )
NOPARALLEL
NOLOGGING
/

CREATE INDEX pamast_index_codeid ON pamast
  (
    fundcodeid                      ASC
  )
NOPARALLEL
NOLOGGING
/

CREATE INDEX pamast_index_pensionid ON pamast
  (
    pensionid                       ASC
  )
NOPARALLEL
NOLOGGING
/

CREATE INDEX pamast_txnum_txdate_idx ON pamast
  (
    txnum                           ASC,
    txdate                          ASC
  )
NOPARALLEL
NOLOGGING
/

CREATE INDEX pamast_index_employerid ON pamast
  (
    employerid                      ASC
  )
NOPARALLEL
NOLOGGING
/

CREATE INDEX pamast_index_patype ON pamast
  (
    patype                          ASC
  )
NOPARALLEL
NOLOGGING
/


DROP TABLE paperimport
/

CREATE TABLE paperimport
    (autoid                         NUMBER(*,0) NOT NULL,
    txnum                          VARCHAR2(100 BYTE),
    txdate                         DATE,
    bkdate                         DATE,
    papercode                      VARCHAR2(30 BYTE),
    serifrom                       VARCHAR2(50 BYTE),
    serito                         VARCHAR2(50 BYTE),
    status                         VARCHAR2(1 BYTE),
    tlid                           VARCHAR2(50 BYTE),
    chkid                          VARCHAR2(50 BYTE),
    description                    VARCHAR2(500 BYTE),
    approvement                    VARCHAR2(10 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE paperimport_dtl
/

CREATE TABLE paperimport_dtl
    (papercode                      VARCHAR2(30 BYTE),
    seri                           VARCHAR2(50 BYTE),
    status                         VARCHAR2(1 BYTE),
    position                       VARCHAR2(10 BYTE),
    brid                           VARCHAR2(50 BYTE),
    saleid                         VARCHAR2(50 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE paperimportpos
/

CREATE TABLE paperimportpos
    (autoid                         NUMBER(22,0),
    txnum                          VARCHAR2(100 BYTE),
    txdate                         DATE,
    bkdate                         DATE,
    papercode                      VARCHAR2(30 BYTE),
    serifrom                       VARCHAR2(50 BYTE),
    serito                         VARCHAR2(50 BYTE),
    brid                           VARCHAR2(50 BYTE),
    status                         VARCHAR2(1 BYTE),
    tlid                           VARCHAR2(50 BYTE),
    chkid                          VARCHAR2(50 BYTE),
    description                    VARCHAR2(500 BYTE),
    approvement                    VARCHAR2(10 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE paperimportrm
/

CREATE TABLE paperimportrm
    (autoid                         NUMBER(22,0),
    txnum                          VARCHAR2(100 BYTE),
    txdate                         DATE,
    bkdate                         DATE,
    papercode                      VARCHAR2(30 BYTE),
    serifrom                       VARCHAR2(50 BYTE),
    serito                         VARCHAR2(50 BYTE),
    brid                           VARCHAR2(50 BYTE),
    saleid                         VARCHAR2(50 BYTE),
    status                         VARCHAR2(1 BYTE),
    tlid                           VARCHAR2(50 BYTE),
    chkid                          VARCHAR2(50 BYTE),
    description                    VARCHAR2(500 BYTE),
    approvement                    VARCHAR2(50 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE payment_detail_hist
/

CREATE TABLE payment_detail_hist
    (autoid                         FLOAT(64),
    symbol                         VARCHAR2(15 BYTE),
    acctno                         VARCHAR2(30 BYTE),
    paytype                        VARCHAR2(10 BYTE),
    amount                         NUMBER,
    ratio                          NUMBER,
    orgvaluedt                     DATE,
    rptdate                        DATE,
    status                         VARCHAR2(15 BYTE),
    description                    VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6),
    intrate                        NUMBER)
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE payment_detail_hist_tmp
/

CREATE TABLE payment_detail_hist_tmp
    (autoid                         FLOAT(64),
    symbol                         VARCHAR2(15 BYTE),
    acctno                         VARCHAR2(30 BYTE),
    paytype                        VARCHAR2(10 BYTE),
    amount                         NUMBER,
    ratio                          NUMBER,
    orgvaluedt                     DATE,
    rptdate                        DATE,
    status                         VARCHAR2(15 BYTE),
    description                    VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6),
    intrate                        NUMBER,
    taxamt                         NUMBER,
    reinvestamt                    NUMBER,
    reinvest_rate                  NUMBER,
    feeamt                         NUMBER)
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE payment_hist
/

CREATE TABLE payment_hist
    (autoid                         FLOAT(64),
    symbol                         VARCHAR2(15 BYTE),
    amount                         NUMBER,
    ratio                          NUMBER,
    valuedt                        DATE,
    status                         VARCHAR2(2000 BYTE),
    description                    VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6),
    refid                          FLOAT(64),
    paytype                        VARCHAR2(10 BYTE),
    parvalue                       NUMBER,
    intrate                        NUMBER,
    days                           NUMBER,
    intbaseddofy                   NUMBER,
    pstatus                        VARCHAR2(2000 BYTE),
    payment_status                 VARCHAR2(1 BYTE),
    intdate                        DATE,
    reportdt                       DATE,
    reviewdt                       DATE)
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE payment_hist_bk
/

CREATE TABLE payment_hist_bk
    (autoid                         FLOAT(64),
    symbol                         VARCHAR2(15 BYTE),
    amount                         BINARY_DOUBLE,
    ratio                          BINARY_DOUBLE,
    valuedt                        DATE,
    status                         VARCHAR2(2000 BYTE),
    description                    VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6),
    refid                          FLOAT(64),
    paytype                        VARCHAR2(10 BYTE),
    parvalue                       BINARY_DOUBLE,
    intrate                        BINARY_DOUBLE,
    days                           BINARY_DOUBLE,
    intbaseddofy                   BINARY_DOUBLE,
    pstatus                        VARCHAR2(2000 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE payment_hist_log
/

CREATE TABLE payment_hist_log
    (autoid                         FLOAT(64),
    symbol                         VARCHAR2(15 BYTE),
    amount                         NUMBER,
    ratio                          NUMBER,
    valuedt                        DATE,
    status                         VARCHAR2(2000 BYTE),
    description                    VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6),
    refid                          FLOAT(64),
    paytype                        VARCHAR2(10 BYTE),
    parvalue                       NUMBER,
    intrate                        NUMBER,
    days                           NUMBER,
    intbaseddofy                   NUMBER,
    payment_status                 VARCHAR2(1 BYTE),
    intdate                        DATE,
    reportdt                       DATE,
    changedate                     DATE,
    pstatus                        VARCHAR2(200 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE payment_histmemo
/

CREATE TABLE payment_histmemo
    (autoid                         FLOAT(64),
    symbol                         VARCHAR2(15 BYTE),
    amount                         NUMBER,
    ratio                          NUMBER,
    valuedt                        DATE,
    status                         VARCHAR2(2000 BYTE),
    description                    VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6),
    refid                          FLOAT(64),
    paytype                        VARCHAR2(10 BYTE),
    parvalue                       NUMBER,
    intrate                        NUMBER,
    days                           NUMBER,
    intbaseddofy                   NUMBER,
    pstatus                        VARCHAR2(2000 BYTE),
    payment_status                 VARCHAR2(1 BYTE),
    intdate                        DATE,
    reportdt                       DATE,
    reviewdt                       DATE)
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE payment_schd
/

CREATE TABLE payment_schd
    (autoid                         FLOAT(126),
    symbol                         VARCHAR2(50 BYTE),
    parvalue                       NUMBER,
    fromperiod                     NUMBER,
    toperiod                       NUMBER,
    valuedt                        DATE,
    reportdt                       DATE,
    paytype                        VARCHAR2(10 BYTE),
    days                           NUMBER,
    amount                         NUMBER,
    status                         VARCHAR2(2000 BYTE),
    pstatus                        VARCHAR2(2000 BYTE),
    lastchange                     TIMESTAMP (6),
    castatus                       VARCHAR2(2000 BYTE),
    ratio                          NUMBER)
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE payment_schdmemo
/

CREATE TABLE payment_schdmemo
    (autoid                         FLOAT(126),
    symbol                         VARCHAR2(50 BYTE),
    parvalue                       NUMBER,
    fromperiod                     NUMBER,
    toperiod                       NUMBER,
    valuedt                        DATE,
    reportdt                       DATE,
    paytype                        VARCHAR2(10 BYTE),
    days                           NUMBER,
    amount                         NUMBER,
    status                         VARCHAR2(2000 BYTE),
    pstatus                        VARCHAR2(2000 BYTE),
    lastchange                     TIMESTAMP (6),
    castatus                       VARCHAR2(2000 BYTE),
    ratio                          NUMBER)
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE paymenthist_sereqclose
/

CREATE TABLE paymenthist_sereqclose
    (symbol                         VARCHAR2(15 BYTE),
    txdate                         DATE,
    intrate                        NUMBER)
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE penaltysip
/

CREATE TABLE penaltysip
    (autoid                         FLOAT(32) DEFAULT 0 NOT NULL,
    sipid                          VARCHAR2(20 BYTE),
    tradingid                      VARCHAR2(4000 BYTE),
    custodycd                      VARCHAR2(10 BYTE),
    codeid                         VARCHAR2(6 BYTE),
    tradingtype                    VARCHAR2(20 BYTE),
    termmiss                       BINARY_DOUBLE,
    txdate                         DATE,
    deltd                          VARCHAR2(10 BYTE) DEFAULT 'N',
    typep                          VARCHAR2(100 BYTE))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE product
/

CREATE TABLE product
    (autoid                         NUMBER(38,0) DEFAULT 0,
    codeid                         VARCHAR2(20 BYTE),
    shortname                      VARCHAR2(50 BYTE),
    intrcurvetp                    CHAR(3 BYTE),
    afacctno                       VARCHAR2(4000 BYTE),
    termval                        NUMBER(8,0) DEFAULT 0,
    termcd                         CHAR(1 BYTE) DEFAULT 'M',
    effdate                        DATE,
    expdate                        DATE,
    status                         CHAR(1 BYTE),
    description                    VARCHAR2(4000 BYTE),
    symbol                         VARCHAR2(20 BYTE),
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6),
    discountrate                   NUMBER(10,5) DEFAULT 0,
    discountrate2                  NUMBER(10,5) DEFAULT 0,
    earlywithdraw                  VARCHAR2(1 BYTE) DEFAULT 'Y',
    firstdate                      DATE,
    lastdate                       DATE,
    calpvmethod                    VARCHAR2(10 BYTE),
    lastclosedate                  DATE,
    selldtl                        VARCHAR2(4000 BYTE),
    buydtl                         VARCHAR2(4000 BYTE),
    feebuyrate                     NUMBER DEFAULT 0,
    intbaseddofy                   VARCHAR2(20 BYTE) DEFAULT 'Y',
    coupondtl                      VARCHAR2(4000 BYTE),
    settauto                       VARCHAR2(10 BYTE),
    overduerate                    NUMBER,
    allowresell                    VARCHAR2(10 BYTE) DEFAULT 'N',
    sellmax                        NUMBER,
    sellmin                        NUMBER,
    orderid                        VARCHAR2(100 BYTE),
    orgprdid                       NUMBER)
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE productadj
/

CREATE TABLE productadj
    (confirmno                      VARCHAR2(100 BYTE),
    discountrate                   NUMBER,
    feebuyrate                     NUMBER,
    rate                           NUMBER,
    tlid                           VARCHAR2(100 BYTE),
    status                         VARCHAR2(10 BYTE),
    txnum                          VARCHAR2(100 BYTE),
    txdate                         DATE,
    offid                          VARCHAR2(100 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE productbuydtl
/

CREATE TABLE productbuydtl
    (autoid                         NUMBER ,
    id                             NUMBER,
    termcd                         VARCHAR2(1 BYTE),
    from                           NUMBER,
    to                             NUMBER,
    type                           VARCHAR2(10 BYTE),
    rate                           NUMBER(20,2),
    amplitude                      NUMBER(20,2),
    status                         VARCHAR2(2 BYTE),
    pstatus                        VARCHAR2(200 BYTE),
    action                         VARCHAR2(5 BYTE),
    calrate_method                 VARCHAR2(5 BYTE),
    feebuy                         NUMBER DEFAULT 0,
    calfee_method                  VARCHAR2(10 BYTE),
    isdaytypefee                   VARCHAR2(10 BYTE) DEFAULT 'N')
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

ALTER TABLE productbuydtl
ADD PRIMARY KEY (autoid)
USING INDEX
/

DROP TABLE productbuydtladj
/

CREATE TABLE productbuydtladj
    (confirmno                      VARCHAR2(100 BYTE),
    termcd                         VARCHAR2(10 BYTE),
    from                           NUMBER,
    to                             NUMBER,
    type                           VARCHAR2(10 BYTE),
    rate                           NUMBER,
    amplitude                      NUMBER,
    feebuy                         NUMBER,
    calrate_method                 VARCHAR2(10 BYTE),
    autoid                         NUMBER,
    calfee_method                  VARCHAR2(10 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE productbuydtlmemo
/

CREATE TABLE productbuydtlmemo
    (autoid                         NUMBER,
    id                             NUMBER,
    termcd                         VARCHAR2(1 BYTE),
    from                           NUMBER,
    to                             NUMBER,
    type                           VARCHAR2(10 BYTE),
    rate                           NUMBER(20,2),
    amplitude                      NUMBER(20,2),
    status                         VARCHAR2(2 BYTE),
    pstatus                        VARCHAR2(200 BYTE),
    action                         VARCHAR2(5 BYTE),
    calrate_method                 VARCHAR2(5 BYTE),
    feebuy                         NUMBER DEFAULT 0,
    calfee_method                  VARCHAR2(10 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE productcoupondtl
/

CREATE TABLE productcoupondtl
    (autoid                         NUMBER,
    id                             NUMBER,
    termcd                         VARCHAR2(1 BYTE),
    from                           NUMBER,
    to                             NUMBER,
    ratio                          NUMBER,
    action                         VARCHAR2(10 BYTE),
    status                         VARCHAR2(10 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE productcoupondtlmemo
/

CREATE TABLE productcoupondtlmemo
    (autoid                         NUMBER,
    id                             NUMBER,
    termcd                         VARCHAR2(1 BYTE),
    from                           NUMBER,
    to                             NUMBER,
    ratio                          NUMBER,
    action                         VARCHAR2(10 BYTE),
    status                         VARCHAR2(10 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE productcpndtladj
/

CREATE TABLE productcpndtladj
    (confirmno                      VARCHAR2(100 BYTE),
    termcd                         VARCHAR2(10 BYTE),
    from                           NUMBER,
    to                             NUMBER,
    ratio                          NUMBER,
    amplitude                      NUMBER,
    autoid                         NUMBER)
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE productier
/

CREATE TABLE productier
    (id                             NUMBER(38,0),
    productid                      VARCHAR2(50 BYTE),
    discount                       NUMBER(10,5),
    symbol                         VARCHAR2(50 BYTE),
    status                         VARCHAR2(1 BYTE),
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6),
    autoid                         NUMBER(38,0))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE productmemo
/

CREATE TABLE productmemo
    (autoid                         NUMBER(38,0) DEFAULT 0,
    codeid                         VARCHAR2(20 BYTE),
    shortname                      VARCHAR2(50 BYTE),
    intrcurvetp                    CHAR(3 BYTE),
    afacctno                       VARCHAR2(4000 BYTE),
    termval                        NUMBER(8,0) DEFAULT 0,
    termcd                         CHAR(1 BYTE) DEFAULT 'M',
    effdate                        DATE,
    expdate                        DATE,
    status                         CHAR(1 BYTE),
    description                    VARCHAR2(4000 BYTE),
    symbol                         VARCHAR2(20 BYTE),
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6),
    discountrate                   NUMBER(10,5) DEFAULT 0,
    discountrate2                  NUMBER(10,5) DEFAULT 0,
    earlywithdraw                  VARCHAR2(1 BYTE) DEFAULT 'Y',
    firstdate                      DATE,
    lastdate                       DATE,
    calpvmethod                    VARCHAR2(10 BYTE),
    lastclosedate                  DATE,
    selldtl                        VARCHAR2(4000 BYTE),
    buydtl                         VARCHAR2(4000 BYTE),
    feebuyrate                     NUMBER DEFAULT 0,
    intbaseddofy                   VARCHAR2(20 BYTE) DEFAULT 'Y',
    overduerate                    NUMBER,
    settauto                       VARCHAR2(10 BYTE),
    coupondtl                      VARCHAR2(4000 BYTE),
    allowresell                    VARCHAR2(10 BYTE) DEFAULT 'N',
    sellmin                        NUMBER,
    sellmax                        NUMBER,
    orderid                        VARCHAR2(100 BYTE),
    orgprdid                       NUMBER)
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE productselldtl
/

CREATE TABLE productselldtl
    (autoid                         NUMBER ,
    id                             NUMBER,
    termcd                         VARCHAR2(1 BYTE),
    from                           NUMBER,
    to                             NUMBER,
    type                           VARCHAR2(10 BYTE),
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

ALTER TABLE productselldtl
ADD PRIMARY KEY (autoid)
USING INDEX
/

DROP TABLE productselldtlmemo
/

CREATE TABLE productselldtlmemo
    (autoid                         NUMBER,
    id                             NUMBER,
    termcd                         VARCHAR2(1 BYTE),
    from                           NUMBER,
    to                             NUMBER,
    type                           VARCHAR2(10 BYTE),
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

DROP TABLE professioninfo
/

CREATE TABLE professioninfo
    (idcode                         VARCHAR2(20 BYTE),
    professionfrdate               DATE,
    professiontodate               DATE,
    seaccount                      VARCHAR2(500 BYTE),
    ciaccount                      VARCHAR2(500 BYTE),
    secif                          VARCHAR2(500 BYTE),
    idtype                         VARCHAR2(50 BYTE),
    idtypeck                       VARCHAR2(200 BYTE),
    idcodeck                       VARCHAR2(200 BYTE),
    iddateck                       VARCHAR2(200 BYTE),
    idexpdatedck                   VARCHAR2(200 BYTE),
    idplaceck                      VARCHAR2(200 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE profilemanager
/

CREATE TABLE profilemanager
    (autoid                         NUMBER,
    txnum                          VARCHAR2(30 BYTE),
    txdate                         DATE,
    tlid                           VARCHAR2(30 BYTE),
    offid                          VARCHAR2(30 BYTE),
    confirmno                      VARCHAR2(30 BYTE),
    oxtype                         CHAR(1 BYTE),
    urlfile                        VARCHAR2(500 BYTE),
    status                         CHAR(1 BYTE),
    note                           VARCHAR2(1000 BYTE),
    pstatus                        VARCHAR2(100 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE promotion
/

CREATE TABLE promotion
    (id                             NUMBER,
    codeid                         VARCHAR2(200 BYTE),
    discount                       NUMBER,
    codelimit                      NUMBER(38,0),
    remaincode                     NUMBER(38,0),
    limitcustomer                  NUMBER(38,0),
    limitcareby                    NUMBER(38,0),
    symbol                         VARCHAR2(200 BYTE),
    careby                         VARCHAR2(200 BYTE),
    product                        VARCHAR2(200 BYTE),
    custodycd                      VARCHAR2(200 BYTE),
    note                           VARCHAR2(200 BYTE),
    frdate                         DATE,
    todate                         DATE,
    status                         VARCHAR2(3 BYTE) DEFAULT 'P',
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6),
    closecontract                  NUMBER,
    nextpurchase                   NUMBER)
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE promotiondtl
/

CREATE TABLE promotiondtl
    (autoid                         NUMBER(38,0),
    id                             NUMBER(38,0),
    codeid                         VARCHAR2(200 BYTE),
    type                           VARCHAR2(200 BYTE),
    value                          VARCHAR2(200 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE promotionmemo
/

CREATE TABLE promotionmemo
    (id                             NUMBER(38,0),
    codeid                         VARCHAR2(200 BYTE),
    discount                       NUMBER,
    codelimit                      NUMBER(38,0),
    remaincode                     NUMBER(38,0),
    limitcustomer                  NUMBER(38,0),
    limitcareby                    NUMBER(38,0),
    symbol                         VARCHAR2(200 BYTE),
    careby                         VARCHAR2(200 BYTE),
    product                        VARCHAR2(200 BYTE),
    custodycd                      VARCHAR2(200 BYTE),
    note                           VARCHAR2(200 BYTE),
    frdate                         DATE,
    todate                         DATE,
    status                         VARCHAR2(3 BYTE) DEFAULT 'P',
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6),
    closecontract                  NUMBER,
    nextpurchase                   NUMBER)
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE promotionowned
/

CREATE TABLE promotionowned
    (autoid                         NUMBER(38,0),
    type                           VARCHAR2(200 BYTE),
    id                             NUMBER(38,0),
    promotion_code                 VARCHAR2(200 BYTE),
    promotion                      NUMBER(38,0),
    custodycd                      VARCHAR2(200 BYTE),
    symbol                         VARCHAR2(200 BYTE),
    product                        VARCHAR2(200 BYTE),
    careby                         VARCHAR2(200 BYTE),
    confirmno                      VARCHAR2(200 BYTE),
    status                         VARCHAR2(20 BYTE),
    txnum                          VARCHAR2(100 BYTE),
    txdate                         DATE,
    used_confirmno                 VARCHAR2(200 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE promotionused
/

CREATE TABLE promotionused
    (autoid                         NUMBER(38,0),
    id                             NUMBER(38,0),
    codeid                         VARCHAR2(200 BYTE),
    custodycd                      VARCHAR2(200 BYTE),
    symbol                         VARCHAR2(200 BYTE),
    product                        VARCHAR2(200 BYTE),
    careby                         VARCHAR2(200 BYTE),
    confirmno                      VARCHAR2(200 BYTE),
    status                         VARCHAR2(20 BYTE),
    txnum                          VARCHAR2(100 BYTE),
    txdate                         DATE)
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE push2fo_queue_table
/

CREATE TABLE push2fo_queue_table
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
  NOLOGGING
  MONITORING
/

CREATE INDEX aq$_push2fo_queue_table_t ON push2fo_queue_table
  (
    time_manager_info               ASC
  )
NOPARALLEL
NOLOGGING
/

CREATE INDEX aq$_push2fo_queue_table_i ON push2fo_queue_table
  (
    q_name                          ASC,
    state                           ASC,
    enq_time                        ASC,
    step_no                         ASC,
    chain_no                        ASC,
    local_order_no                  ASC
  )
NOPARALLEL
NOLOGGING
/


ALTER TABLE push2fo_queue_table
ADD PRIMARY KEY (msgid)
USING INDEX
/

DROP TABLE ratereference
/

CREATE TABLE ratereference
    (autoid                         NUMBER NOT NULL,
    rate                           NUMBER,
    datevali                       DATE,
    status                         VARCHAR2(20 BYTE),
    pstatus                        VARCHAR2(20 BYTE),
    lastchange                     TIMESTAMP (6),
    notes                          VARCHAR2(200 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

ALTER TABLE ratereference
ADD CONSTRAINT ratereference_pkey PRIMARY KEY (autoid)
USING INDEX
/

DROP TABLE ratereferencememo
/

CREATE TABLE ratereferencememo
    (autoid                         NUMBER NOT NULL,
    rate                           NUMBER,
    datevali                       DATE,
    status                         VARCHAR2(20 BYTE),
    pstatus                        VARCHAR2(20 BYTE),
    lastchange                     TIMESTAMP (6),
    notes                          VARCHAR2(200 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

ALTER TABLE ratereferencememo
ADD CONSTRAINT ratereferencememo_pkey PRIMARY KEY (autoid)
USING INDEX
/

DROP TABLE rd
/

CREATE TABLE rd
    (floor                          BINARY_DOUBLE)
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE reconcile_r39
/

CREATE TABLE reconcile_r39
    (autoid                         FLOAT(32) DEFAULT 0 NOT NULL,
    fileid                         VARCHAR2(100 BYTE),
    txdate                         DATE,
    custodycd                      VARCHAR2(100 BYTE),
    symbol                         VARCHAR2(100 BYTE),
    exectype                       VARCHAR2(100 BYTE),
    srtype                         VARCHAR2(100 BYTE),
    tradingdate                    DATE,
    orderamt                       BINARY_DOUBLE,
    orderqtty                      BINARY_DOUBLE,
    sysorderid                     VARCHAR2(100 BYTE),
    vsdorderamt                    BINARY_DOUBLE,
    vsdorderqtty                   BINARY_DOUBLE,
    vsdorderid                     VARCHAR2(100 BYTE),
    status                         VARCHAR2(10 BYTE),
    deltd                          CHAR(1 BYTE) DEFAULT 'N',
    cmdresult                      VARCHAR2(10 BYTE),
    notes                          VARCHAR2(4000 BYTE),
    refid                          VARCHAR2(4000 BYTE),
    cancelstatus                   VARCHAR2(100 BYTE),
    lastchange                     DATE,
    odstatus                       VARCHAR2(10 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE reconcile_r39_log
/

CREATE TABLE reconcile_r39_log
    (autoid                         FLOAT(32) DEFAULT 0 NOT NULL,
    fileid                         VARCHAR2(100 BYTE),
    txdate                         DATE,
    custodycd                      VARCHAR2(100 BYTE),
    symbol                         VARCHAR2(100 BYTE),
    exectype                       VARCHAR2(100 BYTE),
    srtype                         VARCHAR2(100 BYTE),
    tradingdate                    DATE,
    orderamt                       BINARY_DOUBLE,
    orderqtty                      BINARY_DOUBLE,
    sysorderid                     VARCHAR2(100 BYTE),
    vsdorderamt                    BINARY_DOUBLE,
    vsdorderqtty                   BINARY_DOUBLE,
    vsdorderid                     VARCHAR2(100 BYTE),
    status                         VARCHAR2(10 BYTE),
    deltd                          CHAR(1 BYTE) DEFAULT 'N',
    cmdresult                      VARCHAR2(10 BYTE),
    notes                          VARCHAR2(4000 BYTE),
    refid                          VARCHAR2(4000 BYTE),
    cancelstatus                   VARCHAR2(100 BYTE),
    lastchange                     DATE,
    odstatus                       VARCHAR2(10 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE reconcile_r53
/

CREATE TABLE reconcile_r53
    (autoid                         FLOAT(32) DEFAULT 0 NOT NULL,
    fileid                         VARCHAR2(100 BYTE),
    txdate                         DATE,
    tradingdate                    DATE,
    custodycd                      VARCHAR2(250 BYTE),
    symbol                         VARCHAR2(250 BYTE),
    orderamt                       BINARY_DOUBLE,
    amountcust                     BINARY_DOUBLE,
    reconcilests                   VARCHAR2(4000 BYTE),
    reftxnum                       VARCHAR2(250 BYTE),
    refdesc                        VARCHAR2(4000 BYTE),
    vsdorderamt                    BINARY_DOUBLE,
    vsdorderid                     VARCHAR2(250 BYTE),
    deltd                          CHAR(1 BYTE),
    status                         VARCHAR2(10 BYTE),
    cmpresult                      VARCHAR2(4000 BYTE),
    feedbackmsg                    VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6),
    srtype                         VARCHAR2(100 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE reconcile_r53_log
/

CREATE TABLE reconcile_r53_log
    (autoid                         FLOAT(32) DEFAULT 0 NOT NULL,
    fileid                         VARCHAR2(100 BYTE),
    txdate                         DATE,
    tradingdate                    DATE,
    custodycd                      VARCHAR2(250 BYTE),
    symbol                         VARCHAR2(250 BYTE),
    orderamt                       BINARY_DOUBLE,
    amountcust                     BINARY_DOUBLE,
    reconcilests                   VARCHAR2(4000 BYTE),
    reftxnum                       VARCHAR2(250 BYTE),
    refdesc                        VARCHAR2(4000 BYTE),
    vsdorderamt                    BINARY_DOUBLE,
    vsdorderid                     VARCHAR2(250 BYTE),
    deltd                          CHAR(1 BYTE),
    status                         VARCHAR2(10 BYTE),
    cmpresult                      VARCHAR2(4000 BYTE),
    feedbackmsg                    VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6),
    srtype                         VARCHAR2(100 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE reconcile_r62
/

CREATE TABLE reconcile_r62
    (autoid                         FLOAT(32) DEFAULT 0 NOT NULL,
    fileid                         VARCHAR2(100 BYTE),
    txdate                         DATE,
    custodycd                      VARCHAR2(100 BYTE),
    symbol                         VARCHAR2(100 BYTE),
    exectype                       VARCHAR2(100 BYTE),
    srtype                         VARCHAR2(100 BYTE),
    tradingdate                    DATE,
    orderamt                       BINARY_DOUBLE,
    orderqtty                      BINARY_DOUBLE,
    sysorderid                     VARCHAR2(100 BYTE),
    trade1                         BINARY_DOUBLE,
    trade2                         BINARY_DOUBLE,
    vsdorderamt                    BINARY_DOUBLE,
    vsdorderqtty                   BINARY_DOUBLE,
    matchamtns                     BINARY_DOUBLE,
    matchamtnr                     BINARY_DOUBLE,
    matchqttyns                    BINARY_DOUBLE,
    matchqttynr                    BINARY_DOUBLE,
    taxamt                         BINARY_DOUBLE,
    feeamtns                       BINARY_DOUBLE,
    feeamtnr                       BINARY_DOUBLE,
    amount                         BINARY_DOUBLE,
    vsdorderid                     VARCHAR2(100 BYTE),
    status                         VARCHAR2(10 BYTE),
    deltd                          CHAR(1 BYTE) DEFAULT 'N',
    cmdresult                      VARCHAR2(10 BYTE),
    feedbackmsg                    VARCHAR2(4000 BYTE),
    lastchange                     DATE,
    nav                            BINARY_DOUBLE,
    totalnav                       BINARY_DOUBLE)
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE reconcile_r62_log
/

CREATE TABLE reconcile_r62_log
    (autoid                         FLOAT(32) DEFAULT 0 NOT NULL,
    fileid                         VARCHAR2(100 BYTE),
    txdate                         DATE,
    custodycd                      VARCHAR2(100 BYTE),
    symbol                         VARCHAR2(100 BYTE),
    exectype                       VARCHAR2(100 BYTE),
    srtype                         VARCHAR2(100 BYTE),
    tradingdate                    DATE,
    orderamt                       BINARY_DOUBLE,
    orderqtty                      BINARY_DOUBLE,
    sysorderid                     VARCHAR2(100 BYTE),
    trade1                         BINARY_DOUBLE,
    trade2                         BINARY_DOUBLE,
    vsdorderamt                    BINARY_DOUBLE,
    vsdorderqtty                   BINARY_DOUBLE,
    matchamtns                     BINARY_DOUBLE,
    matchamtnr                     BINARY_DOUBLE,
    matchqttyns                    BINARY_DOUBLE,
    matchqttynr                    BINARY_DOUBLE,
    taxamt                         BINARY_DOUBLE,
    feeamtns                       BINARY_DOUBLE,
    feeamtnr                       BINARY_DOUBLE,
    amount                         BINARY_DOUBLE,
    vsdorderid                     VARCHAR2(100 BYTE),
    status                         VARCHAR2(10 BYTE),
    deltd                          CHAR(1 BYTE) DEFAULT 'N',
    cmdresult                      VARCHAR2(10 BYTE),
    feedbackmsg                    VARCHAR2(4000 BYTE),
    lastchange                     DATE,
    nav                            BINARY_DOUBLE,
    totalnav                       BINARY_DOUBLE)
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE reinvest_rate
/

CREATE TABLE reinvest_rate
    (autoid                         NUMBER DEFAULT 0,
    ratecode                       VARCHAR2(50 BYTE),
    effdate                        DATE,
    expdate                        DATE,
    status                         CHAR(1 BYTE),
    description                    VARCHAR2(4000 BYTE),
    rate00                         NUMBER,
    rate01                         NUMBER,
    rate02                         NUMBER,
    rate03                         NUMBER,
    rate04                         NUMBER,
    rate05                         NUMBER,
    rate06                         NUMBER,
    rate07                         NUMBER,
    rate08                         NUMBER,
    rate09                         NUMBER,
    rate10                         NUMBER,
    rate11                         NUMBER,
    rate12                         NUMBER,
    rate13                         NUMBER,
    rate14                         NUMBER,
    rate15                         NUMBER,
    rate16                         NUMBER,
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6),
    reinvest_rate_dtl              VARCHAR2(4000 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE reinvest_rate_bk
/

CREATE TABLE reinvest_rate_bk
    (autoid                         BINARY_DOUBLE,
    ratecode                       VARCHAR2(50 BYTE),
    effdate                        DATE,
    expdate                        DATE,
    status                         CHAR(1 BYTE),
    description                    VARCHAR2(4000 BYTE),
    rate00                         BINARY_DOUBLE,
    rate01                         BINARY_DOUBLE,
    rate02                         BINARY_DOUBLE,
    rate03                         BINARY_DOUBLE,
    rate04                         BINARY_DOUBLE,
    rate05                         BINARY_DOUBLE,
    rate06                         BINARY_DOUBLE,
    rate07                         BINARY_DOUBLE,
    rate08                         BINARY_DOUBLE,
    rate09                         BINARY_DOUBLE,
    rate10                         BINARY_DOUBLE,
    rate11                         BINARY_DOUBLE,
    rate12                         BINARY_DOUBLE,
    rate13                         BINARY_DOUBLE,
    rate14                         BINARY_DOUBLE,
    rate15                         BINARY_DOUBLE,
    rate16                         BINARY_DOUBLE,
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE reinvest_rate_dtl
/

CREATE TABLE reinvest_rate_dtl
    (autoid                         NUMBER,
    id                             NUMBER,
    termcd                         VARCHAR2(10 BYTE),
    from                           NUMBER,
    to                             NUMBER,
    rate                           NUMBER)
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE reinvest_rate_dtlmemo
/

CREATE TABLE reinvest_rate_dtlmemo
    (autoid                         NUMBER,
    id                             NUMBER,
    termcd                         VARCHAR2(10 BYTE),
    from                           NUMBER,
    to                             NUMBER,
    rate                           NUMBER,
    action                         VARCHAR2(10 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE reinvest_ratememo
/

CREATE TABLE reinvest_ratememo
    (autoid                         NUMBER,
    ratecode                       VARCHAR2(50 BYTE),
    effdate                        DATE,
    expdate                        DATE,
    status                         CHAR(1 BYTE),
    description                    VARCHAR2(4000 BYTE),
    rate00                         NUMBER,
    rate01                         NUMBER,
    rate02                         NUMBER,
    rate03                         NUMBER,
    rate04                         NUMBER,
    rate05                         NUMBER,
    rate06                         NUMBER,
    rate07                         NUMBER,
    rate08                         NUMBER,
    rate09                         NUMBER,
    rate10                         NUMBER,
    rate11                         NUMBER,
    rate12                         NUMBER,
    rate13                         NUMBER,
    rate14                         NUMBER,
    rate15                         NUMBER,
    rate16                         NUMBER,
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6),
    reinvest_rate_dtl              VARCHAR2(4000 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE relative_temp
/

CREATE TABLE relative_temp
    (autoid                         BINARY_DOUBLE DEFAULT 0 NOT NULL,
    refoxpostid                    BINARY_DOUBLE,
    custodycd                      VARCHAR2(10 BYTE),
    reserver                       VARCHAR2(50 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

ALTER TABLE relative_temp
ADD CONSTRAINT relative_temp_pkey PRIMARY KEY (autoid)
USING INDEX
/

DROP TABLE remiser
/

CREATE TABLE remiser
    (autoid                         FLOAT(64) NOT NULL,
    fullname                       VARCHAR2(100 BYTE),
    note                           VARCHAR2(300 BYTE),
    dbcode                         VARCHAR2(10 BYTE),
    txdate                         TIMESTAMP (6),
    tlid                           VARCHAR2(10 BYTE),
    status                         VARCHAR2(1 BYTE),
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6),
    email                          VARCHAR2(50 BYTE),
    phone                          VARCHAR2(50 BYTE),
    address                        VARCHAR2(500 BYTE))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

ALTER TABLE remiser
ADD CONSTRAINT remiser_pkey PRIMARY KEY (autoid)
USING INDEX
/

DROP TABLE reportlog
/

CREATE TABLE reportlog
    (id                             FLOAT(32) DEFAULT 0 NOT NULL,
    begindate                      DATE,
    enddate                        DATE,
    tlid                           VARCHAR2(10 BYTE),
    rptid                          VARCHAR2(40 BYTE),
    wsname                         VARCHAR2(50 BYTE),
    ipaddress                      VARCHAR2(50 BYTE),
    rptinput                       VARCHAR2(4000 BYTE))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE reqlog
/

CREATE TABLE reqlog
    (autoid                         NUMBER,
    tltxcd                         VARCHAR2(10 BYTE),
    txnum                          VARCHAR2(200 BYTE),
    txdate                         DATE,
    custodycd                      VARCHAR2(100 BYTE),
    status                         CHAR(1 BYTE) DEFAULT 'P',
    updatetime                     TIMESTAMP (6),
    reftxnum                       VARCHAR2(100 BYTE),
    reftxdate                      DATE,
    related_custodycd              VARCHAR2(100 BYTE),
    confirmno                      VARCHAR2(200 BYTE),
    urlfile                        VARCHAR2(4000 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE returnissuer
/

CREATE TABLE returnissuer
    (acctno                         VARCHAR2(15 BYTE),
    symbol                         VARCHAR2(15 BYTE),
    issueddt                       DATE,
    qtty                           NUMBER(38,0),
    price                          NUMBER(38,0),
    notes                          VARCHAR2(4000 BYTE),
    status                         VARCHAR2(10 BYTE) DEFAULT 'P',
    pstatus                        VARCHAR2(10 BYTE),
    lastchange                     TIMESTAMP (6) DEFAULT NULL,
    refid                          NUMBER(38,0))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE reviewparam
/

CREATE TABLE reviewparam
    (autoid                         FLOAT(64),
    refautoid                      FLOAT(64),
    framt                          BINARY_DOUBLE,
    toamt                          BINARY_DOUBLE,
    classcd                        VARCHAR2(10 BYTE),
    applycd                        VARCHAR2(10 BYTE),
    status                         VARCHAR2(1 BYTE) DEFAULT 'A',
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6) DEFAULT to_date('0001-01-01 00:00:00', 'YYYY-MM-DD hh24:mi:ss'),
    isused                         VARCHAR2(2 BYTE) DEFAULT 'N')
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE reviewparammemo
/

CREATE TABLE reviewparammemo
    (autoid                         FLOAT(64),
    refautoid                      FLOAT(64),
    framt                          BINARY_DOUBLE,
    toamt                          BINARY_DOUBLE,
    classcd                        VARCHAR2(10 BYTE),
    applycd                        VARCHAR2(10 BYTE),
    status                         VARCHAR2(1 BYTE),
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6),
    isused                         VARCHAR2(2 BYTE) DEFAULT 'N')
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE reviewterm
/

CREATE TABLE reviewterm
    (autoid                         FLOAT(64),
    termname                       VARCHAR2(200 BYTE),
    frdate                         DATE,
    todate                         DATE,
    status                         VARCHAR2(1 BYTE) DEFAULT 'A',
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6) DEFAULT to_date('0001-01-01 00:00:00', 'YYYY-MM-DD hh24:mi:ss'),
    isused                         VARCHAR2(2 BYTE) DEFAULT 'N')
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE reviewtermmemo
/

CREATE TABLE reviewtermmemo
    (autoid                         FLOAT(64),
    termname                       VARCHAR2(200 BYTE),
    frdate                         DATE,
    todate                         DATE,
    status                         VARCHAR2(1 BYTE),
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6),
    isused                         VARCHAR2(2 BYTE))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE rightassign_log
/

CREATE TABLE rightassign_log
    (autoid                         FLOAT(64) NOT NULL,
    logtable                       VARCHAR2(50 BYTE),
    brid                           VARCHAR2(8 BYTE),
    grpid                          VARCHAR2(8 BYTE),
    authtype                       VARCHAR2(1 BYTE),
    authid                         VARCHAR2(8 BYTE),
    cmdcode                        VARCHAR2(50 BYTE),
    cmdtype                        VARCHAR2(1 BYTE),
    cmdallow                       VARCHAR2(10 BYTE),
    strauth                        VARCHAR2(10 BYTE),
    tltype                         VARCHAR2(1 BYTE),
    tllimit                        FLOAT(64),
    chgtlid                        VARCHAR2(8 BYTE),
    chgtime                        TIMESTAMP (6),
    oldvalue                       VARCHAR2(4000 BYTE),
    newvalue                       VARCHAR2(4000 BYTE),
    busdate                        TIMESTAMP (6))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE rmchangelog
/

CREATE TABLE rmchangelog
    (txnum                          VARCHAR2(30 BYTE),
    txdate                         DATE,
    refnum                         VARCHAR2(30 BYTE),
    refdate                        DATE,
    orderid                        VARCHAR2(30 BYTE),
    confirmno                      VARCHAR2(30 BYTE),
    rm_old                         VARCHAR2(30 BYTE),
    sale_manager_old               VARCHAR2(30 BYTE),
    collab_old                     VARCHAR2(30 BYTE),
    rm_new                         VARCHAR2(30 BYTE),
    sale_manager_new               VARCHAR2(30 BYTE),
    collab_new                     VARCHAR2(30 BYTE),
    reason                         VARCHAR2(500 BYTE),
    note                           VARCHAR2(500 BYTE),
    status                         CHAR(1 BYTE),
    deltd                          CHAR(1 BYTE),
    bkdate                         DATE,
    branch_old                     VARCHAR2(50 BYTE),
    branch_new                     VARCHAR2(50 BYTE),
    tlid                           VARCHAR2(20 BYTE),
    offid_1                        VARCHAR2(100 BYTE),
    tlid_2                         VARCHAR2(100 BYTE),
    ttkd_status                    VARCHAR2(10 BYTE),
    ttkd_reason                    VARCHAR2(2000 BYTE),
    offid_2                        VARCHAR2(100 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE roles
/

CREATE TABLE roles
    (autoid                         FLOAT(64),
    mbid                           FLOAT(64) NOT NULL,
    rolecode                       VARCHAR2(20 BYTE),
    rolename                       VARCHAR2(50 BYTE),
    status                         VARCHAR2(1 BYTE) DEFAULT 'P',
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6),
    firm                           VARCHAR2(4 BYTE),
    contactperson                  VARCHAR2(500 BYTE),
    phonecontact                   VARCHAR2(500 BYTE),
    dbcode                         VARCHAR2(100 BYTE),
    membercode                     VARCHAR2(20 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE rptauto
/

CREATE TABLE rptauto
    (rptid                          VARCHAR2(100 BYTE),
    id                             FLOAT(32) DEFAULT 0 ,
    autofreq                       VARCHAR2(100 BYTE),
    exptype                        VARCHAR2(100 BYTE),
    owntype                        VARCHAR2(100 BYTE),
    isemail                        VARCHAR2(100 BYTE),
    isrpt                          VARCHAR2(100 BYTE),
    isca                           VARCHAR2(100 BYTE),
    note                           VARCHAR2(4000 BYTE),
    status                         VARCHAR2(10 BYTE) DEFAULT 'P',
    pstatus                        VARCHAR2(100 BYTE),
    templateid                     VARCHAR2(100 BYTE))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

ALTER TABLE rptauto
ADD CHECK ("ID" IS NOT NULL)
/

DROP TABLE rptfields
/

CREATE TABLE rptfields
    (modcode                        VARCHAR2(3 BYTE) NOT NULL,
    fldname                        VARCHAR2(50 BYTE) NOT NULL,
    objname                        VARCHAR2(50 BYTE) NOT NULL,
    defname                        VARCHAR2(50 BYTE),
    caption                        VARCHAR2(100 BYTE),
    en_caption                     VARCHAR2(100 BYTE),
    odrnum                         BINARY_DOUBLE,
    fldtype                        VARCHAR2(1 BYTE),
    fldmask                        VARCHAR2(50 BYTE),
    fldformat                      VARCHAR2(50 BYTE),
    fldlen                         BINARY_DOUBLE,
    llist                          VARCHAR2(4000 BYTE),
    lchk                           VARCHAR2(255 BYTE),
    defval                         VARCHAR2(100 BYTE),
    visible                        VARCHAR2(1 BYTE),
    disable                        VARCHAR2(1 BYTE),
    mandatory                      VARCHAR2(1 BYTE),
    amtexp                         VARCHAR2(255 BYTE),
    validtag                       VARCHAR2(250 BYTE),
    lookup                         VARCHAR2(1 BYTE),
    datatype                       VARCHAR2(1 BYTE),
    invname                        VARCHAR2(10 BYTE),
    fldsource                      VARCHAR2(10 BYTE),
    flddesc                        VARCHAR2(10 BYTE),
    chainname                      VARCHAR2(50 BYTE),
    printinfo                      VARCHAR2(10 BYTE),
    lookupname                     VARCHAR2(20 BYTE),
    searchcode                     VARCHAR2(20 BYTE),
    srmodcode                      VARCHAR2(2 BYTE),
    invformat                      VARCHAR2(20 BYTE),
    tagfield                       VARCHAR2(50 BYTE),
    taglist                        VARCHAR2(650 BYTE),
    tagvalue                       VARCHAR2(255 BYTE),
    isparam                        VARCHAR2(1 BYTE),
    ctltype                        VARCHAR2(1 BYTE),
    llistonline                    VARCHAR2(4000 BYTE),
    autoval                        VARCHAR2(4000 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE rptlog_map
/

CREATE TABLE rptlog_map
    (objname                        VARCHAR2(100 BYTE) NOT NULL,
    fldvalue                       VARCHAR2(200 BYTE) NOT NULL,
    note                           VARCHAR2(200 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

ALTER TABLE rptlog_map
ADD PRIMARY KEY (objname)
USING INDEX
/

DROP TABLE rptlogs
/

CREATE TABLE rptlogs
    (autoid                         FLOAT(32) DEFAULT 0 NOT NULL,
    reqid                          VARCHAR2(20 BYTE),
    rptid                          VARCHAR2(10 BYTE),
    rptparam                       VARCHAR2(500 BYTE),
    owntype                        VARCHAR2(3 BYTE),
    ownval                         VARCHAR2(10 BYTE),
    rptdesc                        VARCHAR2(500 BYTE),
    rptdesc_en                     VARCHAR2(500 BYTE),
    refrptfile                     VARCHAR2(500 BYTE),
    status                         VARCHAR2(1 BYTE) DEFAULT 'P',
    mailto                         VARCHAR2(100 BYTE),
    mailsts                        VARCHAR2(1 BYTE),
    maildt                         TIMESTAMP (6),
    crtdatetime                    TIMESTAMP (6),
    subdatetime                    TIMESTAMP (6),
    subuserid                      VARCHAR2(50 BYTE),
    note                           VARCHAR2(4000 BYTE),
    priority                       VARCHAR2(2 BYTE) DEFAULT '0',
    refemaillog                    VARCHAR2(100 BYTE),
    exportpath                     VARCHAR2(500 BYTE),
    txdate                         DATE,
    refrptauto                     VARCHAR2(20 BYTE),
    isauto                         VARCHAR2(1 BYTE) DEFAULT 'N',
    exptype                        VARCHAR2(100 BYTE),
    issignoff                      VARCHAR2(1 BYTE) DEFAULT 'N',
    mbcode                         VARCHAR2(100 BYTE),
    codeid                         VARCHAR2(10 BYTE),
    tradingid                      VARCHAR2(50 BYTE),
    deltd                          VARCHAR2(10 BYTE) DEFAULT 'N',
    rolecode                       VARCHAR2(100 BYTE),
    tlid                           VARCHAR2(10 BYTE),
    tlname                         VARCHAR2(255 BYTE),
    lang                           VARCHAR2(20 BYTE),
    custodycd                      VARCHAR2(100 BYTE),
    passwordencrypt                VARCHAR2(100 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
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

DROP TABLE rptlogshist
/

CREATE TABLE rptlogshist
    (autoid                         FLOAT(32),
    reqid                          VARCHAR2(20 BYTE),
    rptid                          VARCHAR2(10 BYTE),
    rptparam                       VARCHAR2(500 BYTE),
    owntype                        VARCHAR2(3 BYTE),
    ownval                         VARCHAR2(10 BYTE),
    rptdesc                        VARCHAR2(500 BYTE),
    rptdesc_en                     VARCHAR2(500 BYTE),
    refrptfile                     VARCHAR2(500 BYTE),
    status                         VARCHAR2(1 BYTE),
    mailto                         VARCHAR2(100 BYTE),
    mailsts                        VARCHAR2(1 BYTE),
    maildt                         TIMESTAMP (6),
    crtdatetime                    TIMESTAMP (6),
    subdatetime                    TIMESTAMP (6),
    subuserid                      VARCHAR2(50 BYTE),
    note                           VARCHAR2(4000 BYTE),
    priority                       VARCHAR2(2 BYTE),
    refemaillog                    VARCHAR2(100 BYTE),
    exportpath                     VARCHAR2(4000 BYTE),
    txdate                         DATE,
    refrptauto                     VARCHAR2(20 BYTE),
    isauto                         VARCHAR2(1 BYTE),
    exptype                        VARCHAR2(100 BYTE),
    issignoff                      VARCHAR2(1 BYTE),
    mbcode                         VARCHAR2(100 BYTE),
    codeid                         VARCHAR2(10 BYTE),
    tradingid                      VARCHAR2(50 BYTE),
    deltd                          VARCHAR2(10 BYTE),
    rolecode                       VARCHAR2(100 BYTE),
    tlid                           VARCHAR2(10 BYTE),
    tlname                         VARCHAR2(255 BYTE),
    lang                           VARCHAR2(20 BYTE),
    custodycd                      VARCHAR2(100 BYTE),
    passwordencrypt                VARCHAR2(100 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE rptmaster
/

CREATE TABLE rptmaster
    (rptid                          VARCHAR2(8 BYTE) NOT NULL,
    dsn                            VARCHAR2(8 BYTE),
    modcode                        VARCHAR2(3 BYTE),
    fontsize                       VARCHAR2(2 BYTE),
    rheader                        VARCHAR2(3 BYTE),
    pheader                        VARCHAR2(3 BYTE),
    rdetail                        VARCHAR2(3 BYTE),
    pfooter                        VARCHAR2(3 BYTE),
    rfooter                        VARCHAR2(3 BYTE),
    description                    VARCHAR2(255 BYTE),
    ad_hoc                         VARCHAR2(1 BYTE),
    rorder                         BINARY_DOUBLE DEFAULT 0,
    psize                          VARCHAR2(2 BYTE),
    orientation                    VARCHAR2(1 BYTE),
    storedname                     VARCHAR2(100 BYTE),
    visible                        VARCHAR2(1 BYTE),
    area                           VARCHAR2(3 BYTE),
    islocal                        VARCHAR2(1 BYTE),
    cmdtype                        VARCHAR2(1 BYTE) DEFAULT 'R',
    iscareby                       VARCHAR2(1 BYTE) DEFAULT 'N',
    ispublic                       VARCHAR2(1 BYTE) DEFAULT 'N',
    isauto                         VARCHAR2(1 BYTE) DEFAULT 'M',
    ord                            VARCHAR2(3 BYTE) DEFAULT '000',
    aors                           VARCHAR2(1 BYTE) DEFAULT 'S',
    rowperpage                     BINARY_DOUBLE DEFAULT -1,
    en_description                 VARCHAR2(400 BYTE),
    stylecode                      VARCHAR2(100 BYTE),
    topmargin                      BINARY_DOUBLE DEFAULT 0,
    leftmargin                     BINARY_DOUBLE DEFAULT 0,
    rightmargin                    BINARY_DOUBLE DEFAULT 0,
    bottommargin                   BINARY_DOUBLE DEFAULT 0,
    subrpt                         VARCHAR2(1 BYTE) DEFAULT 'N',
    iscmp                          VARCHAR2(1 BYTE) DEFAULT 'N',
    isdefaultdb                    VARCHAR2(1 BYTE) DEFAULT 'Y',
    mnviewtype                     VARCHAR2(1 BYTE),
    is4customer                    VARCHAR2(1 BYTE) DEFAULT 'N',
    expdatatype                    VARCHAR2(100 BYTE) DEFAULT 'pdf,xml',
    reporttemplate                 VARCHAR2(255 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE rptsubs
/

CREATE TABLE rptsubs
    (autoid                         FLOAT(32) DEFAULT 0 NOT NULL,
    rptid                          VARCHAR2(10 BYTE),
    rptsubid                       VARCHAR2(10 BYTE),
    storename                      VARCHAR2(500 BYTE),
    rptsubtemplate                 VARCHAR2(500 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE rptsubschart
/

CREATE TABLE rptsubschart
    (autoid                         FLOAT(32) DEFAULT 0 NOT NULL,
    storename                      VARCHAR2(500 BYTE),
    rptsubtemplate                 BINARY_DOUBLE)
  NOPARALLEL
  NOLOGGING
  MONITORING
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

CREATE TABLE productbuydtl
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
    feebuy                         NUMBER DEFAULT 0,
    calfee_method                  VARCHAR2(10 BYTE),
    isdaytypefee                   VARCHAR2(10 BYTE) DEFAULT 'N')
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

ALTER TABLE productbuydtl
ADD PRIMARY KEY (autoid)
USING INDEX
/

CREATE TABLE productbuydtladj
    (confirmno                      VARCHAR2(100 BYTE),
    termcd                         VARCHAR2(10 BYTE),
    "FROM"                           NUMBER,
    "TO"                             NUMBER,
    "TYPE"                           VARCHAR2(10 BYTE),
    rate                           NUMBER,
    amplitude                      NUMBER,
    feebuy                         NUMBER,
    calrate_method                 VARCHAR2(10 BYTE),
    autoid                         NUMBER,
    calfee_method                  VARCHAR2(10 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

CREATE TABLE productbuydtlmemo
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
    feebuy                         NUMBER DEFAULT 0,
    calfee_method                  VARCHAR2(10 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

CREATE TABLE productcoupondtl
    (autoid                         NUMBER,
    id                             NUMBER,
    termcd                         VARCHAR2(1 BYTE),
    "FROM"                           NUMBER,
    "TO"                             NUMBER,
    ratio                          NUMBER,
    action                         VARCHAR2(10 BYTE),
    status                         VARCHAR2(10 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

CREATE TABLE productcoupondtlmemo
    (autoid                         NUMBER,
    id                             NUMBER,
    termcd                         VARCHAR2(1 BYTE),
    "FROM"                           NUMBER,
    "TO"                             NUMBER,
    ratio                          NUMBER,
    action                         VARCHAR2(10 BYTE),
    status                         VARCHAR2(10 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

CREATE TABLE productcpndtladj
    (confirmno                      VARCHAR2(100 BYTE),
    termcd                         VARCHAR2(10 BYTE),
    "FROM"                           NUMBER,
    "TO"                             NUMBER,
    ratio                          NUMBER,
    amplitude                      NUMBER,
    autoid                         NUMBER)
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

CREATE TABLE productselldtl
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

ALTER TABLE productselldtl
ADD PRIMARY KEY (autoid)
USING INDEX
/

CREATE TABLE productselldtlmemo
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

CREATE TABLE reinvest_rate_dtl
    (autoid                         NUMBER,
    id                             NUMBER,
    termcd                         VARCHAR2(10 BYTE),
    "FROM"                           NUMBER,
    "TO"                             NUMBER,
    rate                           NUMBER)
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

CREATE TABLE reinvest_rate_dtlmemo
    (autoid                         NUMBER,
    id                             NUMBER,
    termcd                         VARCHAR2(10 BYTE),
    "FROM"                           NUMBER,
    "TO"                             NUMBER,
    rate                           NUMBER,
    action                         VARCHAR2(10 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

