DROP TABLE sale_calculator
/

CREATE TABLE sale_calculator
    (autoid                         FLOAT(32) DEFAULT 0 NOT NULL,
    saledate                       DATE NOT NULL,
    saleid                         VARCHAR2(20 BYTE),
    tradingvalue                   BINARY_DOUBLE NOT NULL,
    dshh                           BINARY_DOUBLE,
    ruletype                       VARCHAR2(1 BYTE) NOT NULL,
    feerate                        BINARY_DOUBLE,
    feevalue                       BINARY_DOUBLE,
    dmtt                           BINARY_DOUBLE,
    dmgt                           BINARY_DOUBLE,
    ismanager                      VARCHAR2(2 BYTE),
    dmnhom                         BINARY_DOUBLE,
    dmds                           BINARY_DOUBLE,
    iscomm                         VARCHAR2(1 BYTE),
    groupid                        FLOAT(32),
    lastchange                     TIMESTAMP (6) DEFAULT to_date('0001-01-01 00:00:00', 'YYYY-MM-DD hh24:mi:ss'),
    confirmno                      VARCHAR2(20 BYTE),
    rerole                         VARCHAR2(10 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE sale_calculator_history
/

CREATE TABLE sale_calculator_history
    (autoid                         FLOAT(32) DEFAULT 0 NOT NULL,
    fromdate                       DATE NOT NULL,
    todate                         DATE NOT NULL,
    lastchange                     TIMESTAMP (6) DEFAULT to_date('0001-01-01 00:00:00', 'YYYY-MM-DD hh24:mi:ss'))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE sale_customers
/

CREATE TABLE sale_customers
    (autoid                         FLOAT(32) DEFAULT 0 NOT NULL,
    txdate                         DATE,
    txnum                          VARCHAR2(30 BYTE),
    saleid                         VARCHAR2(30 BYTE),
    reftype                        VARCHAR2(3 BYTE) DEFAULT 'ACC',
    refacctno                      VARCHAR2(30 BYTE),
    frdate                         DATE,
    todate                         DATE,
    status                         CHAR(1 BYTE) DEFAULT 'A',
    pstatus                        VARCHAR2(100 BYTE),
    deltd                          CHAR(1 BYTE) DEFAULT 'N',
    clstxdate                      DATE,
    clstxnum                       VARCHAR2(30 BYTE),
    saleacctno                     VARCHAR2(30 BYTE),
    rerole                         VARCHAR2(10 BYTE),
    effdate                        DATE,
    expdate                        DATE)
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

ALTER TABLE sale_customers
ADD CONSTRAINT sale_customers_pkey PRIMARY KEY (autoid)
USING INDEX
/

DROP TABLE sale_customersmemo
/

CREATE TABLE sale_customersmemo
    (autoid                         FLOAT(32) NOT NULL,
    txdate                         DATE,
    txnum                          VARCHAR2(30 BYTE),
    saleid                         VARCHAR2(30 BYTE),
    reftype                        VARCHAR2(3 BYTE),
    refacctno                      VARCHAR2(30 BYTE),
    frdate                         DATE,
    todate                         DATE,
    status                         CHAR(1 BYTE),
    pstatus                        VARCHAR2(100 BYTE),
    deltd                          CHAR(1 BYTE),
    clstxdate                      DATE,
    clstxnum                       VARCHAR2(30 BYTE),
    saleacctno                     VARCHAR2(30 BYTE),
    rerole                         VARCHAR2(10 BYTE),
    effdate                        DATE,
    expdate                        DATE)
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  LOGGING
  MONITORING
/

DROP TABLE sale_groups
/

CREATE TABLE sale_groups
    (autoid                         FLOAT(32) DEFAULT 0 NOT NULL,
    grllevel                       NUMBER,
    prgrpid                        VARCHAR2(20 BYTE),
    fullname                       VARCHAR2(100 BYTE),
    active                         VARCHAR2(1 BYTE),
    managerid                      VARCHAR2(50 BYTE),
    mindrevamt                     NUMBER,
    minirevamt                     NUMBER,
    rateamttyp                     VARCHAR2(1 BYTE),
    rateamt                        NUMBER,
    ratecomm                       NUMBER,
    effdate                        DATE,
    expdate                        DATE,
    status                         VARCHAR2(1 BYTE),
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6) DEFAULT to_date('0001-01-01 00:00:00', 'YYYY-MM-DD hh24:mi:ss'),
    autorefid                      VARCHAR2(20 BYTE),
    groupthreshold                 NUMBER,
    issalesofself                  VARCHAR2(1 BYTE) DEFAULT 'N' NOT NULL)
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

ALTER TABLE sale_groups
ADD CONSTRAINT sale_groups_pkey PRIMARY KEY (autoid)
USING INDEX
/

DROP TABLE sale_groupscv
/

CREATE TABLE sale_groupscv
    (autoid                         VARCHAR2(4000 BYTE) NOT NULL,
    grllevel                       BINARY_DOUBLE,
    prgrpid                        VARCHAR2(4000 BYTE),
    fullname                       VARCHAR2(100 BYTE),
    managerid                      VARCHAR2(50 BYTE),
    rateamt                        BINARY_DOUBLE,
    ratecomm                       BINARY_DOUBLE)
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE sale_groupsmemo
/

CREATE TABLE sale_groupsmemo
    (autoid                         FLOAT(32) DEFAULT 0 NOT NULL,
    grllevel                       NUMBER,
    prgrpid                        VARCHAR2(20 BYTE),
    fullname                       VARCHAR2(100 BYTE),
    active                         VARCHAR2(1 BYTE),
    managerid                      VARCHAR2(50 BYTE),
    mindrevamt                     NUMBER,
    minirevamt                     NUMBER,
    rateamttyp                     VARCHAR2(1 BYTE),
    rateamt                        NUMBER,
    ratecomm                       NUMBER,
    effdate                        DATE,
    expdate                        DATE,
    status                         VARCHAR2(1 BYTE),
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6) DEFAULT to_date('0001-01-01 00:00:00', 'YYYY-MM-DD hh24:mi:ss'),
    autorefid                      VARCHAR2(20 BYTE),
    groupthreshold                 NUMBER,
    issalesofself                  VARCHAR2(100 BYTE) DEFAULT 'N' NOT NULL)
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

ALTER TABLE sale_groupsmemo
ADD CONSTRAINT sale_groupsmemo_pkey PRIMARY KEY (autoid)
USING INDEX
/

DROP TABLE sale_inforcv
/

CREATE TABLE sale_inforcv
    (tlid                           VARCHAR2(100 BYTE),
    rerole                         VARCHAR2(100 BYTE),
    reproduct                      VARCHAR2(100 BYTE),
    rateamt                        BINARY_DOUBLE,
    ratecomm                       BINARY_DOUBLE,
    grpid                          VARCHAR2(100 BYTE),
    vsdsaleid                      VARCHAR2(20 BYTE))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE sale_managers
/

CREATE TABLE sale_managers
    (autoid                         FLOAT(32) DEFAULT 0 NOT NULL,
    grpid                          FLOAT(64) NOT NULL,
    saleid                         VARCHAR2(6 BYTE),
    txdate                         DATE,
    txnum                          VARCHAR2(20 BYTE),
    effdate                        DATE,
    expdate                        DATE,
    active                         VARCHAR2(1 BYTE) DEFAULT 'A',
    status                         VARCHAR2(1 BYTE) DEFAULT 'P',
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6) DEFAULT to_date('0001-01-01 00:00:00', 'YYYY-MM-DD hh24:mi:ss'),
    clstxdate                      DATE,
    clstxnum                       VARCHAR2(20 BYTE),
    saleacctno                     VARCHAR2(20 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE sale_managers_log
/

CREATE TABLE sale_managers_log
    (autoid                         FLOAT(32) DEFAULT 0 NOT NULL,
    grpid                          FLOAT(64) NOT NULL,
    saleid                         VARCHAR2(6 BYTE),
    txdate                         DATE,
    txnum                          VARCHAR2(20 BYTE),
    effdate                        DATE,
    expdate                        DATE,
    active                         VARCHAR2(1 BYTE) DEFAULT 'A',
    status                         VARCHAR2(1 BYTE) DEFAULT 'P',
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6) DEFAULT to_date('0001-01-01 00:00:00', 'YYYY-MM-DD hh24:mi:ss'),
    clstxdate                      DATE,
    clstxnum                       VARCHAR2(20 BYTE),
    saleacctno                     VARCHAR2(20 BYTE))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE sale_members
/

CREATE TABLE sale_members
    (autoid                         FLOAT(32) DEFAULT 0 NOT NULL,
    saleacctno                     VARCHAR2(100 BYTE),
    effdate                        DATE,
    expdate                        DATE,
    mbcode                         VARCHAR2(100 BYTE),
    areaid                         VARCHAR2(100 BYTE),
    brid                           VARCHAR2(100 BYTE),
    ratecomm                       BINARY_DOUBLE,
    description                    VARCHAR2(4000 BYTE),
    status                         VARCHAR2(10 BYTE),
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6),
    ratealoc                       BINARY_DOUBLE)
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE sale_memberscv
/

CREATE TABLE sale_memberscv
    (saleacctno                     VARCHAR2(100 BYTE),
    mbcode                         VARCHAR2(100 BYTE),
    areaid                         VARCHAR2(100 BYTE),
    brid                           VARCHAR2(100 BYTE),
    effdate                        DATE,
    expdate                        DATE,
    rateamt                        BINARY_DOUBLE,
    ratecomm                       BINARY_DOUBLE)
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE sale_membersmemo
/

CREATE TABLE sale_membersmemo
    (autoid                         FLOAT(32),
    saleacctno                     VARCHAR2(100 BYTE),
    effdate                        DATE,
    expdate                        DATE,
    mbcode                         VARCHAR2(100 BYTE),
    areaid                         VARCHAR2(100 BYTE),
    brid                           VARCHAR2(100 BYTE),
    ratecomm                       BINARY_DOUBLE,
    description                    VARCHAR2(4000 BYTE),
    status                         VARCHAR2(10 BYTE),
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6),
    ratealoc                       BINARY_DOUBLE)
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE sale_ordersmap
/

CREATE TABLE sale_ordersmap
    (autoid                         FLOAT(32) DEFAULT 0 NOT NULL,
    txdate                         DATE,
    txnum                          VARCHAR2(30 BYTE),
    saleacctno                     VARCHAR2(30 BYTE),
    orderid                        VARCHAR2(30 BYTE),
    orderqtty                      BINARY_DOUBLE,
    orderamt                       BINARY_DOUBLE,
    feeamt                         BINARY_DOUBLE,
    clstxdate                      DATE,
    clstxnum                       VARCHAR2(30 BYTE),
    status                         VARCHAR2(4000 BYTE) DEFAULT '2',
    deltd                          VARCHAR2(1 BYTE))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

ALTER TABLE sale_ordersmap
ADD CONSTRAINT sale_ordersmap_pkey PRIMARY KEY (autoid)
USING INDEX
/

DROP TABLE sale_profilesmemo
/

CREATE TABLE sale_profilesmemo
    (autoid                         FLOAT(32),
    salename                       VARCHAR2(50 BYTE),
    salepass                       VARCHAR2(100 BYTE),
    fullname                       VARCHAR2(100 BYTE),
    organizationid                 VARCHAR2(20 BYTE),
    regionid                       VARCHAR2(100 BYTE),
    brpid                          VARCHAR2(100 BYTE),
    opndate                        DATE,
    clsdate                        DATE,
    status                         VARCHAR2(1 BYTE),
    pstatus                        VARCHAR2(100 BYTE),
    apprv_sts                      VARCHAR2(1 BYTE),
    groupid                        BINARY_DOUBLE)
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE sale_retype
/

CREATE TABLE sale_retype
    (autoid                         FLOAT(126) DEFAULT 0 ,
    actype                         VARCHAR2(30 BYTE),
    typename                       VARCHAR2(300 BYTE),
    status                         VARCHAR2(1 BYTE) DEFAULT 'P',
    pstatus                        VARCHAR2(4000 BYTE),
    rerole                         VARCHAR2(30 BYTE),
    effdate                        DATE,
    expdate                        DATE,
    description                    VARCHAR2(500 BYTE),
    ratedensity                    NUMBER DEFAULT 0,
    lastchange                     TIMESTAMP (6),
    maxvalue                       NUMBER(38,0),
    isdefault                      VARCHAR2(1 BYTE),
    retype                         VARCHAR2(20 BYTE) DEFAULT 'D',
    reproduct                      VARCHAR2(20 BYTE) DEFAULT 'A',
    threshold                      NUMBER DEFAULT 0)
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

ALTER TABLE sale_retype
ADD CONSTRAINT sale_retype_pkey PRIMARY KEY (autoid)
USING INDEX
/

DROP TABLE sale_retype_log
/

CREATE TABLE sale_retype_log
    (autoid                         NUMBER(38,0),
    logid                          VARCHAR2(500 BYTE),
    actype                         VARCHAR2(10 BYTE),
    typename                       VARCHAR2(300 BYTE),
    rerole                         VARCHAR2(10 BYTE),
    effdate                        DATE,
    expdate                        DATE,
    description                    VARCHAR2(500 BYTE),
    isdefault                      VARCHAR2(10 BYTE),
    lastchange                     TIMESTAMP (6),
    txnum                          VARCHAR2(30 BYTE),
    txdate                         DATE,
    action_type                    VARCHAR2(10 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE sale_retypememo
/

CREATE TABLE sale_retypememo
    (autoid                         FLOAT(32) NOT NULL,
    actype                         VARCHAR2(30 BYTE),
    typename                       VARCHAR2(300 BYTE),
    status                         VARCHAR2(1 BYTE),
    pstatus                        VARCHAR2(4000 BYTE),
    rerole                         VARCHAR2(30 BYTE),
    effdate                        DATE,
    expdate                        DATE,
    description                    VARCHAR2(500 BYTE),
    ratedensity                    NUMBER,
    lastchange                     TIMESTAMP (6),
    maxvalue                       NUMBER,
    isdefault                      VARCHAR2(1 BYTE),
    retype                         VARCHAR2(20 BYTE) DEFAULT 'D',
    reproduct                      VARCHAR2(20 BYTE) DEFAULT 'A',
    threshold                      NUMBER)
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE sale_roles
/

CREATE TABLE sale_roles
    (autoid                         FLOAT(32) DEFAULT 0 NOT NULL,
    retype                         VARCHAR2(50 BYTE),
    saleid                         VARCHAR2(6 BYTE),
    brid                           VARCHAR2(100 BYTE),
    effdate                        DATE,
    expdate                        DATE,
    active                         VARCHAR2(1 BYTE),
    status                         VARCHAR2(1 BYTE),
    pstatus                        VARCHAR2(100 BYTE),
    lastchange                     TIMESTAMP (6) DEFAULT to_date('0001-01-01 00:00:00', 'YYYY-MM-DD hh24:mi:ss'),
    threshold                      NUMBER DEFAULT 0,
    iscomm                         VARCHAR2(1 BYTE),
    rerole                         VARCHAR2(10 BYTE),
    retypeid                       VARCHAR2(50 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

ALTER TABLE sale_roles
ADD CONSTRAINT sale_roles_pkey PRIMARY KEY (autoid)
USING INDEX
/

DROP TABLE sale_roles_log
/

CREATE TABLE sale_roles_log
    (autoid                         FLOAT(126) DEFAULT 0,
    logid                          VARCHAR2(50 BYTE),
    retype                         VARCHAR2(50 BYTE),
    retypeid                       VARCHAR2(50 BYTE),
    saleid                         VARCHAR2(6 BYTE),
    brid                           VARCHAR2(100 BYTE),
    effdate                        DATE,
    expdate                        DATE,
    rerole                         VARCHAR2(10 BYTE),
    lastchange                     TIMESTAMP (6) DEFAULT to_date('0001-01-01 00:00:00', 'YYYY-MM-DD hh24:mi:ss'),
    txnum                          VARCHAR2(50 BYTE),
    txdate                         VARCHAR2(50 BYTE),
    action_type                    VARCHAR2(50 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE sale_rolesmemo
/

CREATE TABLE sale_rolesmemo
    (autoid                         FLOAT(32) NOT NULL,
    retype                         VARCHAR2(50 BYTE),
    saleid                         VARCHAR2(6 BYTE),
    brid                           VARCHAR2(100 BYTE),
    effdate                        DATE,
    expdate                        DATE,
    active                         VARCHAR2(1 BYTE),
    status                         VARCHAR2(1 BYTE),
    pstatus                        VARCHAR2(100 BYTE),
    lastchange                     TIMESTAMP (6),
    threshold                      NUMBER,
    iscomm                         VARCHAR2(1 BYTE),
    rerole                         VARCHAR2(10 BYTE),
    retypeid                       VARCHAR2(50 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE salerolevar
/

CREATE TABLE salerolevar
    (autoid                         NUMBER,
    saleroleid                     VARCHAR2(100 BYTE),
    salerolename                   VARCHAR2(500 BYTE),
    status                         VARCHAR2(10 BYTE),
    pstatus                        VARCHAR2(10 BYTE),
    lastchange                     TIMESTAMP (6))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  LOGGING
  MONITORING
/

DROP TABLE salerolevarmemo
/

CREATE TABLE salerolevarmemo
    (autoid                         NUMBER,
    saleroleid                     VARCHAR2(100 BYTE),
    salerolename                   VARCHAR2(500 BYTE),
    status                         VARCHAR2(10 BYTE),
    pstatus                        VARCHAR2(10 BYTE),
    lastchange                     TIMESTAMP (6))
  NOPARALLEL
  LOGGING
  MONITORING
/

DROP TABLE sbbatchctl
/

CREATE TABLE sbbatchctl
    (bchsqn                         NUMBER,
    apptype                        VARCHAR2(2 BYTE),
    bchmdl                         VARCHAR2(20 BYTE),
    bchtitle                       VARCHAR2(4000 BYTE),
    runat                          VARCHAR2(10 BYTE),
    action                         VARCHAR2(10 BYTE),
    rptprint                       VARCHAR2(1 BYTE),
    tlbchname                      VARCHAR2(4 BYTE),
    msg                            VARCHAR2(4000 BYTE),
    bkp                            VARCHAR2(1 BYTE),
    bkpsql                         VARCHAR2(50 BYTE),
    rstsql                         VARCHAR2(50 BYTE),
    rowperpage                     NUMBER,
    runmod                         VARCHAR2(3 BYTE),
    status                         VARCHAR2(1 BYTE) DEFAULT 'Y',
    bchtitle_en                    VARCHAR2(4000 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE sbbatchsts
/

CREATE TABLE sbbatchsts
    (bchdate                        DATE,
    bchmdl                         VARCHAR2(20 BYTE),
    bchsts                         VARCHAR2(1 BYTE),
    cmpltime                       TIMESTAMP (6),
    rowperpage                     BINARY_DOUBLE,
    bchsucpage                     BINARY_DOUBLE)
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE sbcldr
/

CREATE TABLE sbcldr
    (autoid                         FLOAT(64) DEFAULT 0 NOT NULL,
    sbdate                         DATE,
    sbbusday                       VARCHAR2(1 BYTE),
    sbeow                          VARCHAR2(1 BYTE),
    sbeom                          VARCHAR2(1 BYTE),
    sbeoq                          VARCHAR2(1 BYTE),
    sbeoy                          VARCHAR2(1 BYTE),
    sbbow                          VARCHAR2(1 BYTE),
    sbbom                          VARCHAR2(1 BYTE),
    sbboq                          VARCHAR2(1 BYTE),
    sbboy                          VARCHAR2(1 BYTE),
    holiday                        VARCHAR2(1 BYTE),
    cldrtype                       CHAR(20 BYTE) DEFAULT '000',
    sip                            VARCHAR2(100 BYTE),
    sipcode                        VARCHAR2(4000 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE sbcurrdate
/

CREATE TABLE sbcurrdate
    (currdate                       TIMESTAMP (6),
    sbdate                         TIMESTAMP (6),
    numday                         FLOAT(64),
    sbtype                         CHAR(1 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE sbcurrency
/

CREATE TABLE sbcurrency
    (ccycd                          VARCHAR2(2 BYTE) NOT NULL,
    shortcd                        VARCHAR2(100 BYTE),
    ccyname                        VARCHAR2(200 BYTE),
    ccydecimal                     FLOAT(64) DEFAULT 0,
    active                         VARCHAR2(1 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE sbseasset
/

CREATE TABLE sbseasset
    (autoid                         FLOAT(32),
    codeid                         VARCHAR2(20 BYTE),
    refid                          FLOAT(32),
    refsymbol                      VARCHAR2(50 BYTE),
    qtty                           FLOAT(32),
    haircut                        FLOAT(32),
    price                          FLOAT(32),
    lastpricedt                    DATE)
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE sbsecurities
/

CREATE TABLE sbsecurities
    (codeid                         VARCHAR2(10 BYTE) NOT NULL,
    issuerid                       VARCHAR2(80 BYTE),
    symbol                         VARCHAR2(80 BYTE),
    sectype                        VARCHAR2(3 BYTE),
    investmenttype                 VARCHAR2(3 BYTE),
    risktype                       VARCHAR2(3 BYTE),
    parvalue                       FLOAT(64),
    foreignrate                    FLOAT(64),
    status                         VARCHAR2(1 BYTE),
    tradeplace                     CHAR(3 BYTE),
    depository                     VARCHAR2(20 BYTE),
    securedratio                   FLOAT(64),
    mortageratio                   FLOAT(64),
    reporatio                      FLOAT(64),
    issuedate                      TIMESTAMP (6),
    expdate                        TIMESTAMP (6),
    intperiod                      FLOAT(16),
    intrate                        FLOAT(32),
    halt                           VARCHAR2(1 BYTE),
    sbtype                         VARCHAR2(3 BYTE),
    careby                         VARCHAR2(20 BYTE),
    chkrate                        BINARY_DOUBLE,
    refcodeid                      VARCHAR2(6 BYTE),
    issqtty                        BINARY_DOUBLE,
    bondtype                       VARCHAR2(3 BYTE),
    markettype                     VARCHAR2(3 BYTE),
    allowsession                   VARCHAR2(2 BYTE),
    issedepofee                    CHAR(1 BYTE),
    intcoupon                      FLOAT(64),
    typeterm                       VARCHAR2(10 BYTE),
    term                           FLOAT(64),
    underlyingtype                 VARCHAR2(10 BYTE),
    underlyingsymbol               VARCHAR2(50 BYTE),
    issuername                     VARCHAR2(50 BYTE),
    coveredwarranttype             VARCHAR2(10 BYTE),
    settlementtype                 VARCHAR2(10 BYTE),
    settlementprice                BINARY_DOUBLE,
    cwterm                         FLOAT(64),
    maturitydate                   TIMESTAMP (6),
    lasttradingdate                TIMESTAMP (6),
    nvalue                         BINARY_DOUBLE,
    exerciseratio                  BINARY_DOUBLE,
    exerciseprice                  BINARY_DOUBLE)
  NOPARALLEL
  NOLOGGING
  MONITORING
/

CREATE INDEX sbsecurities_tradeplace_idx ON sbsecurities
  (
    tradeplace                      ASC
  )
NOPARALLEL
NOLOGGING
/

CREATE INDEX sbsecurities_issuerid_idx ON sbsecurities
  (
    issuerid                        ASC
  )
NOPARALLEL
NOLOGGING
/


ALTER TABLE sbsecurities
ADD CONSTRAINT sbsecurities_pkey PRIMARY KEY (codeid)
USING INDEX
/

DROP TABLE sbsedefacct
/

CREATE TABLE sbsedefacct
    (autoid                         NUMBER(38,0),
    codeid                         VARCHAR2(20 BYTE),
    refid                          NUMBER(38,0),
    category                       CHAR(2 BYTE),
    refafacctno                    VARCHAR2(20 BYTE),
    crbankacct                     VARCHAR2(50 BYTE),
    drbankacct                     VARCHAR2(50 BYTE),
    bankcd                         VARCHAR2(100 BYTE),
    bidasksprd                     NUMBER(38,5) DEFAULT 0,
    symbol                         VARCHAR2(20 BYTE),
    description                    VARCHAR2(500 BYTE),
    status                         CHAR(1 BYTE),
    lastchange                     TIMESTAMP (6),
    intrcurvetp                    VARCHAR2(50 BYTE),
    pstatus                        VARCHAR2(4000 BYTE),
    calpv_method                   VARCHAR2(10 BYTE),
    citybank                       VARCHAR2(200 BYTE),
    firtdate                       DATE,
    lastdate                       DATE,
    payment_rule                   VARCHAR2(10 BYTE),
    lastbuydate                    DATE,
    ipodiscrate                    NUMBER,
    discountratefirst              NUMBER,
    discountratelast               NUMBER)
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE sbsedefacctmemo
/

CREATE TABLE sbsedefacctmemo
    (autoid                         NUMBER(38,0),
    codeid                         VARCHAR2(20 BYTE),
    refid                          NUMBER(38,0),
    category                       CHAR(2 BYTE),
    refafacctno                    VARCHAR2(20 BYTE),
    crbankacct                     VARCHAR2(50 BYTE),
    drbankacct                     VARCHAR2(50 BYTE),
    bankcd                         VARCHAR2(100 BYTE),
    bidasksprd                     NUMBER(38,5) DEFAULT 0,
    symbol                         VARCHAR2(20 BYTE),
    description                    VARCHAR2(500 BYTE),
    status                         CHAR(1 BYTE),
    lastchange                     TIMESTAMP (6),
    intrcurvetp                    VARCHAR2(50 BYTE),
    pstatus                        VARCHAR2(4000 BYTE),
    calpv_method                   VARCHAR2(10 BYTE),
    citybank                       VARCHAR2(200 BYTE),
    firtdate                       DATE,
    lastdate                       DATE,
    payment_rule                   VARCHAR2(10 BYTE),
    lastbuydate                    DATE,
    ipodiscrate                    NUMBER,
    discountratefirst              NUMBER,
    discountratelast               NUMBER)
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  LOGGING
  MONITORING
/

DROP TABLE sbseissue
/

CREATE TABLE sbseissue
    (autoid                         FLOAT(32),
    txdate                         DATE,
    txnum                          VARCHAR2(20 BYTE),
    codeid                         VARCHAR2(20 BYTE),
    afacctno                       VARCHAR2(20 BYTE),
    basedqtty                      FLOAT(32),
    basedprice                     FLOAT(32),
    effdate                        DATE,
    expdate                        DATE,
    status                         CHAR(1 BYTE),
    investamt                      FLOAT(32),
    investqtty                     FLOAT(32),
    subqtty                        FLOAT(32),
    deliqtty                       FLOAT(32),
    retqtty                        FLOAT(32),
    paidamt                        FLOAT(32),
    deltd                          CHAR(1 BYTE))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE sbseschd
/

CREATE TABLE sbseschd
    (autoid                         FLOAT(32),
    refid                          FLOAT(32),
    codeid                         VARCHAR2(20 BYTE),
    schdcd                         CHAR(1 BYTE),
    rateval                        FLOAT(32),
    intrate                        FLOAT(32),
    prinratio                      FLOAT(32),
    valuedt                        DATE,
    status                         CHAR(1 BYTE),
    description                    VARCHAR2(250 BYTE))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE schdctl
/

CREATE TABLE schdctl
    (id                             FLOAT(64),
    codeid                         VARCHAR2(10 BYTE),
    schdtype                       VARCHAR2(200 BYTE),
    lstord                         FLOAT(64),
    description                    VARCHAR2(4000 BYTE),
    status                         VARCHAR2(1 BYTE),
    pstatus                        VARCHAR2(4000 BYTE),
    ver                            VARCHAR2(100 BYTE),
    lastchange                     TIMESTAMP (6))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE schdsts
/

CREATE TABLE schdsts
    (id                             BINARY_DOUBLE,
    codeid                         VARCHAR2(10 BYTE),
    tradingdate                    DATE,
    sessionno                      VARCHAR2(50 BYTE),
    schdtype                       VARCHAR2(50 BYTE),
    isauto                         VARCHAR2(10 BYTE),
    deftime                        VARCHAR2(10 BYTE),
    begintime                      TIMESTAMP (6),
    endtime                        TIMESTAMP (6),
    description                    VARCHAR2(4000 BYTE),
    status                         VARCHAR2(10 BYTE),
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE search
/

CREATE TABLE search
    (searchcode                     VARCHAR2(250 BYTE) NOT NULL,
    searchtitle                    VARCHAR2(4000 BYTE),
    en_searchtitle                 VARCHAR2(4000 BYTE),
    searchcmdsql                   VARCHAR2(4000 BYTE),
    objname                        VARCHAR2(50 BYTE) NOT NULL,
    frmname                        VARCHAR2(50 BYTE),
    orderbycmdsql                  VARCHAR2(100 BYTE),
    tltxcd                         CHAR(4 BYTE),
    cntrecord                      FLOAT(64) DEFAULT 0,
    rowperpage                     BINARY_DOUBLE DEFAULT -1,
    autosearch                     CHAR(1 BYTE) DEFAULT 'N',
    interval                       BINARY_DOUBLE DEFAULT 30,
    authcode                       VARCHAR2(20 BYTE),
    rowlimit                       VARCHAR2(1 BYTE) DEFAULT 'Y',
    cmdtype                        VARCHAR2(1 BYTE) DEFAULT 'T',
    conddeffld                     VARCHAR2(100 BYTE),
    bankinq                        CHAR(1 BYTE) DEFAULT 'N',
    bankacct                       VARCHAR2(20 BYTE) DEFAULT '',
    isfltcodeid                    CHAR(1 BYTE),
    isfltmbcode                    CHAR(1 BYTE),
    searchcmdsql_en                VARCHAR2(4000 BYTE))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE searchfld
/

CREATE TABLE searchfld
    (position                       FLOAT(64) DEFAULT 0,
    fieldcode                      VARCHAR2(30 BYTE) NOT NULL,
    fieldname                      VARCHAR2(200 BYTE),
    fieldtype                      VARCHAR2(1 BYTE),
    searchcode                     VARCHAR2(20 BYTE) NOT NULL,
    fieldsize                      FLOAT(64) DEFAULT 0,
    mask                           VARCHAR2(50 BYTE),
    operator                       VARCHAR2(25 BYTE),
    format                         VARCHAR2(50 BYTE),
    display                        VARCHAR2(1 BYTE),
    srch                           VARCHAR2(1 BYTE),
    key                            VARCHAR2(1 BYTE),
    width                          FLOAT(64) DEFAULT 0,
    lookupcmdsql                   VARCHAR2(4000 BYTE),
    en_fieldname                   VARCHAR2(200 BYTE),
    refvalue                       CHAR(1 BYTE) DEFAULT 'N',
    fldcd                          CHAR(2 BYTE),
    defvalue                       VARCHAR2(50 BYTE),
    multilang                      CHAR(1 BYTE) DEFAULT 'N',
    acdtype                        VARCHAR2(50 BYTE),
    acdname                        VARCHAR2(50 BYTE),
    fieldcmp                       VARCHAR2(50 BYTE),
    fieldcmpkey                    CHAR(1 BYTE) DEFAULT 'N')
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE secmast
/

CREATE TABLE secmast
    (autoid                         NUMBER(38,0),
    txnum                          VARCHAR2(50 BYTE),
    txdate                         DATE,
    acctno                         VARCHAR2(20 BYTE),
    symbol                         VARCHAR2(20 BYTE),
    trtype                         VARCHAR2(10 BYTE),
    ptype                          VARCHAR2(10 BYTE),
    camastid                       VARCHAR2(20 BYTE),
    orderid                        VARCHAR2(20 BYTE),
    qtty                           NUMBER(38,0) DEFAULT 0,
    costprice                      NUMBER(38,0) DEFAULT 0,
    mapqtty                        NUMBER(38,0) DEFAULT 0,
    status                         VARCHAR2(1 BYTE),
    mapavl                         VARCHAR2(1 BYTE),
    busdate                        DATE,
    deltd                          VARCHAR2(1 BYTE),
    trqtty                         NUMBER(38,0) DEFAULT 0)
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

CREATE INDEX secmast_symbol_idx ON secmast
  (
    symbol                          ASC
  )
NOPARALLEL
NOLOGGING
/

CREATE INDEX secmast_acctno_idx ON secmast
  (
    acctno                          ASC
  )
NOPARALLEL
NOLOGGING
/

CREATE INDEX secmast_txdate_idx ON secmast
  (
    txdate                          ASC
  )
NOPARALLEL
NOLOGGING
/


DROP TABLE secmasthist
/

CREATE TABLE secmasthist
    (autoid                         NUMBER(38,0),
    txnum                          VARCHAR2(50 BYTE),
    txdate                         DATE,
    acctno                         VARCHAR2(20 BYTE),
    symbol                         VARCHAR2(20 BYTE),
    trtype                         VARCHAR2(10 BYTE),
    ptype                          VARCHAR2(10 BYTE),
    camastid                       VARCHAR2(20 BYTE),
    orderid                        VARCHAR2(20 BYTE),
    qtty                           NUMBER(38,0) DEFAULT 0,
    costprice                      NUMBER(38,0) DEFAULT 0,
    mapqtty                        NUMBER(38,0) DEFAULT 0,
    status                         VARCHAR2(1 BYTE),
    mapavl                         VARCHAR2(1 BYTE),
    busdate                        DATE,
    deltd                          VARCHAR2(1 BYTE),
    trqtty                         NUMBER(38,0) DEFAULT 0)
  NOPARALLEL
  NOLOGGING
  MONITORING
/

CREATE INDEX secmasthist_acctno_idx ON secmasthist
  (
    acctno                          ASC
  )
NOPARALLEL
NOLOGGING
/

CREATE INDEX secmasthist_txdate_idx ON secmasthist
  (
    txdate                          ASC
  )
NOPARALLEL
NOLOGGING
/

CREATE INDEX secmasthist_symbol_idx ON secmasthist
  (
    symbol                          ASC
  )
NOPARALLEL
NOLOGGING
/


DROP TABLE secnet
/

CREATE TABLE secnet
    (autoid                         BINARY_DOUBLE,
    inid                           BINARY_DOUBLE,
    outid                          BINARY_DOUBLE,
    netdate                        DATE,
    acctno                         VARCHAR2(20 BYTE),
    symbol                         VARCHAR2(20 BYTE),
    netqtty                        BINARY_DOUBLE,
    inamt                          BINARY_DOUBLE,
    outamt                         BINARY_DOUBLE,
    deltd                          VARCHAR2(1 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

CREATE INDEX secnet_netdate_idx ON secnet
  (
    netdate                         ASC
  )
NOPARALLEL
NOLOGGING
/

CREATE INDEX secnet_symbol_idx ON secnet
  (
    symbol                          ASC
  )
NOPARALLEL
NOLOGGING
/

CREATE INDEX secnet_acctno_idx ON secnet
  (
    acctno                          ASC
  )
NOPARALLEL
NOLOGGING
/


DROP TABLE securities_info
/

CREATE TABLE securities_info
    (autoid                         FLOAT(64) NOT NULL,
    codeid                         VARCHAR2(6 BYTE) NOT NULL,
    symbol                         VARCHAR2(80 BYTE),
    txdate                         TIMESTAMP (6),
    listingqtty                    FLOAT(64),
    tradeunit                      FLOAT(64),
    listingstatus                  VARCHAR2(1 BYTE),
    adjustqtty                     FLOAT(64),
    listtingdate                   TIMESTAMP (6),
    referencestatus                VARCHAR2(3 BYTE),
    adjustrate                     FLOAT(64),
    referencerate                  FLOAT(64),
    referencedate                  TIMESTAMP (6),
    status                         VARCHAR2(3 BYTE),
    basicprice                     FLOAT(64),
    openprice                      FLOAT(64),
    prevcloseprice                 FLOAT(64),
    currprice                      FLOAT(64),
    closeprice                     FLOAT(64),
    avgprice                       FLOAT(64),
    ceilingprice                   FLOAT(64),
    floorprice                     FLOAT(64),
    mtmprice                       FLOAT(64),
    mtmpricecd                     VARCHAR2(3 BYTE),
    internalbidprice               FLOAT(64),
    internalaskprice               FLOAT(64),
    pe                             FLOAT(64),
    eps                            FLOAT(64),
    divyeild                       FLOAT(64),
    dayrange                       FLOAT(64),
    yearrange                      FLOAT(64),
    tradelot                       FLOAT(64),
    tradebuysell                   VARCHAR2(1 BYTE),
    telelimitmin                   FLOAT(64),
    telelimitmax                   FLOAT(64),
    onlinelimitmin                 FLOAT(64),
    onlinelimitmax                 FLOAT(64),
    repolimitmin                   FLOAT(64),
    repolimitmax                   FLOAT(64),
    advancedlimitmin               FLOAT(64),
    advancedlimitmax               FLOAT(64),
    marginlimitmin                 FLOAT(64),
    marginlimitmax                 FLOAT(64),
    secureratiotmin                FLOAT(64),
    secureratiomax                 FLOAT(64),
    depofeeunit                    FLOAT(64),
    depofeelot                     FLOAT(64),
    mortageratiomin                FLOAT(64),
    mortageratiomax                FLOAT(64),
    securedratiomin                FLOAT(64),
    securedratiomax                FLOAT(64),
    current_room                   FLOAT(64),
    bminamt                        BINARY_DOUBLE,
    sminamt                        BINARY_DOUBLE,
    marginprice                    BINARY_DOUBLE,
    marginrefprice                 BINARY_DOUBLE,
    roomlimit                      BINARY_DOUBLE,
    roomlimitmax                   BINARY_DOUBLE,
    dfrefprice                     BINARY_DOUBLE,
    syroomlimit                    BINARY_DOUBLE,
    syroomused                     BINARY_DOUBLE,
    margincallprice                BINARY_DOUBLE,
    marginrefcallprice             BINARY_DOUBLE,
    dfrlsprice                     FLOAT(64),
    roomlimitmax_set               BINARY_DOUBLE,
    syroomlimit_set                BINARY_DOUBLE,
    roomused                       BINARY_DOUBLE,
    newprice                       VARCHAR2(1 BYTE) DEFAULT '0',
    newceilingprice                BINARY_DOUBLE DEFAULT 0,
    newfloorprice                  BINARY_DOUBLE DEFAULT 0,
    newbasicprice                  BINARY_DOUBLE DEFAULT 0)
  NOPARALLEL
  NOLOGGING
  MONITORING
/

CREATE INDEX securities_info_symbol_idx ON securities_info
  (
    symbol                          ASC
  )
NOPARALLEL
NOLOGGING
/


ALTER TABLE securities_info
ADD CONSTRAINT securities_info_pkey PRIMARY KEY (codeid)
USING INDEX
/

DROP TABLE securities_ticksize
/

CREATE TABLE securities_ticksize
    (autoid                         FLOAT(64) NOT NULL,
    codeid                         VARCHAR2(10 BYTE),
    symbol                         VARCHAR2(40 BYTE),
    ticksize                       FLOAT(64),
    fromprice                      FLOAT(64),
    toprice                        FLOAT(64),
    status                         VARCHAR2(1 BYTE))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE sedeposit
/

CREATE TABLE sedeposit
    (autoid                         NUMBER DEFAULT 0,
    acctno                         VARCHAR2(20 BYTE),
    txnum                          VARCHAR2(20 BYTE),
    txdate                         DATE,
    depositprice                   NUMBER DEFAULT 0,
    depositqtty                    NUMBER DEFAULT 0,
    status                         VARCHAR2(1 BYTE),
    deltd                          VARCHAR2(1 BYTE),
    description                    CHAR(250 BYTE),
    depotrade                      NUMBER DEFAULT 0,
    depoblock                      NUMBER DEFAULT 0,
    typedepoblock                  VARCHAR2(120 BYTE),
    rdate                          DATE,
    wtrade                         NUMBER DEFAULT 0,
    pstatus                        VARCHAR2(30 BYTE) DEFAULT 'N',
    depodate                       DATE,
    senddepodate                   DATE,
    vsdcode                        VARCHAR2(50 BYTE),
    isconfirm                      VARCHAR2(50 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE sedtl
/

CREATE TABLE sedtl
    (id                             BINARY_DOUBLE NOT NULL,
    afacctno                       VARCHAR2(30 BYTE),
    custodycd                      VARCHAR2(10 BYTE),
    sid                            VARCHAR2(20 BYTE),
    codeid                         VARCHAR2(10 BYTE),
    seacctno                       VARCHAR2(40 BYTE),
    symbol                         VARCHAR2(10 BYTE),
    nors                           VARCHAR2(1 BYTE),
    orderid                        VARCHAR2(100 BYTE),
    feeid                          VARCHAR2(50 BYTE),
    sipid                          VARCHAR2(100 BYTE),
    paid                           VARCHAR2(20 BYTE),
    swid                           VARCHAR2(20 BYTE),
    trade                          BINARY_DOUBLE,
    tradeepr                       BINARY_DOUBLE,
    tradeepe                       BINARY_DOUBLE,
    orgtrade                       BINARY_DOUBLE,
    sessionno                      VARCHAR2(50 BYTE),
    price                          BINARY_DOUBLE,
    txdate                         DATE,
    txnum                          VARCHAR2(20 BYTE),
    cleardate                      TIMESTAMP (6),
    netting                        BINARY_DOUBLE,
    receiving                      BINARY_DOUBLE,
    sending                        BINARY_DOUBLE,
    status                         VARCHAR2(1 BYTE),
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6),
    secured                        BINARY_DOUBLE DEFAULT 0,
    mapqtty                        BINARY_DOUBLE,
    feemanage                      BINARY_DOUBLE DEFAULT 0,
    saleacctno                     VARCHAR2(50 BYTE),
    busdate                        DATE,
    feeamt                         BINARY_DOUBLE DEFAULT 0,
    taxamt                         BINARY_DOUBLE DEFAULT 0)
  NOPARALLEL
  NOLOGGING
  MONITORING
/

ALTER TABLE sedtl
ADD CONSTRAINT sedtl_pkey PRIMARY KEY (id)
USING INDEX
/

DROP TABLE sedtl_20180912
/

CREATE TABLE sedtl_20180912
    (id                             BINARY_DOUBLE,
    afacctno                       VARCHAR2(30 BYTE),
    custodycd                      VARCHAR2(10 BYTE),
    sid                            VARCHAR2(20 BYTE),
    codeid                         VARCHAR2(10 BYTE),
    seacctno                       VARCHAR2(40 BYTE),
    symbol                         VARCHAR2(10 BYTE),
    nors                           VARCHAR2(1 BYTE),
    orderid                        VARCHAR2(100 BYTE),
    feeid                          VARCHAR2(20 BYTE),
    sipid                          VARCHAR2(100 BYTE),
    paid                           VARCHAR2(20 BYTE),
    swid                           VARCHAR2(20 BYTE),
    trade                          BINARY_DOUBLE,
    tradeepr                       BINARY_DOUBLE,
    tradeepe                       BINARY_DOUBLE,
    orgtrade                       BINARY_DOUBLE,
    sessionno                      VARCHAR2(50 BYTE),
    price                          BINARY_DOUBLE,
    txdate                         DATE,
    txnum                          VARCHAR2(20 BYTE),
    cleardate                      TIMESTAMP (6),
    netting                        BINARY_DOUBLE,
    receiving                      BINARY_DOUBLE,
    sending                        BINARY_DOUBLE,
    status                         VARCHAR2(1 BYTE),
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6),
    secured                        BINARY_DOUBLE,
    mapqtty                        BINARY_DOUBLE,
    feemanage                      BINARY_DOUBLE,
    saleacctno                     VARCHAR2(50 BYTE),
    busdate                        DATE,
    feeamt                         BINARY_DOUBLE,
    taxamt                         BINARY_DOUBLE)
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE selloption
/

CREATE TABLE selloption
    (autoid                         NUMBER(38,0),
    id                             NUMBER(38,0),
    putoption                      VARCHAR2(50 BYTE),
    fixeddatesell                  VARCHAR2(50 BYTE),
    putdate                        DATE,
    status                         VARCHAR2(1 BYTE),
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6),
    action                         VARCHAR2(200 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE semast
/

CREATE TABLE semast
    (acctno                         VARCHAR2(40 BYTE),
    afacctno                       VARCHAR2(30 BYTE),
    custodycd                      VARCHAR2(10 BYTE),
    sid                            VARCHAR2(20 BYTE),
    codeid                         VARCHAR2(20 BYTE),
    symbol                         VARCHAR2(20 BYTE),
    trade                          NUMBER(38,0) DEFAULT 0,
    tradeepr                       NUMBER(38,0) DEFAULT 0,
    tradeepe                       NUMBER(38,0) DEFAULT 0,
    careceiving                    NUMBER(38,0) DEFAULT 0,
    costprice                      NUMBER(38,0) DEFAULT 0,
    receiving                      NUMBER(38,0) DEFAULT 0,
    blocked                        NUMBER(38,0) DEFAULT 0,
    netting                        NUMBER(38,0) DEFAULT 0,
    status                         VARCHAR2(1 BYTE),
    pl                             NUMBER(38,0) DEFAULT 0,
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6),
    sending                        NUMBER(38,0) DEFAULT 0,
    secured                        NUMBER(38,0) DEFAULT 0,
    tradesip                       NUMBER(38,0) DEFAULT 0,
    sendingsip                     NUMBER(38,0) DEFAULT 0,
    blockedsip                     NUMBER(38,0) DEFAULT 0,
    isallowodsip                   VARCHAR2(1 BYTE) DEFAULT 'N',
    senddeposit                    NUMBER(38,0) DEFAULT 0,
    deposit                        NUMBER(38,0) DEFAULT 0,
    irtied                         CHAR(1 BYTE),
    iccftied                       CHAR(1 BYTE),
    ircd                           VARCHAR2(10 BYTE),
    withdraw                       NUMBER(38,0) DEFAULT 0,
    blockwithdraw                  NUMBER(38,0) DEFAULT 0,
    waiting                        NUMBER(38,0) DEFAULT 0,
    blockedtransfer                NUMBER(38,0) DEFAULT 0)
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

CREATE INDEX semast_custodycd_idx ON semast
  (
    custodycd                       ASC
  )
NOPARALLEL
NOLOGGING
/

CREATE INDEX semast_codeid_idx ON semast
  (
    codeid                          ASC
  )
NOPARALLEL
NOLOGGING
/

CREATE INDEX semast_symbol_idx ON semast
  (
    symbol                          ASC
  )
NOPARALLEL
NOLOGGING
/


DROP TABLE semast_tmp
/

CREATE TABLE semast_tmp
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
    lastchange                     TIMESTAMP (6))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE semastcv
/

CREATE TABLE semastcv
    (acctno                         VARCHAR2(40 BYTE),
    symbol                         VARCHAR2(20 BYTE),
    trade                          BINARY_DOUBLE,
    tradesip                       BINARY_DOUBLE DEFAULT 0,
    costprice                      BINARY_DOUBLE,
    feemag                         BINARY_DOUBLE,
    finalcheck                     VARCHAR2(100 BYTE),
    note                           VARCHAR2(100 BYTE),
    lastchange                     TIMESTAMP (6))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE sendingemail
/

CREATE TABLE sendingemail
    (autoid                         FLOAT(64),
    emailtype                      VARCHAR2(10 BYTE),
    shortcontent                   VARCHAR2(4000 BYTE),
    maincontent                    VARCHAR2(4000 BYTE),
    frdate                         DATE,
    todate                         DATE,
    retradingdate                  DATE,
    senddate                       DATE,
    status                         VARCHAR2(10 BYTE),
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6),
    txnum                          VARCHAR2(20 BYTE),
    txdate                         DATE,
    note                           VARCHAR2(5 BYTE))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE sendingemailmemo
/

CREATE TABLE sendingemailmemo
    (autoid                         FLOAT(64),
    emailtype                      VARCHAR2(10 BYTE),
    shortcontent                   VARCHAR2(4000 BYTE),
    maincontent                    VARCHAR2(4000 BYTE),
    frdate                         DATE,
    todate                         DATE,
    retradingdate                  DATE,
    senddate                       DATE,
    status                         VARCHAR2(10 BYTE),
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6),
    txnum                          VARCHAR2(20 BYTE),
    txdate                         DATE,
    note                           VARCHAR2(5 BYTE))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE sereg
/

CREATE TABLE sereg
    (autoid                         FLOAT(64),
    custid                         VARCHAR2(30 BYTE),
    acctno                         VARCHAR2(40 BYTE),
    afacctno                       VARCHAR2(30 BYTE),
    codeid                         VARCHAR2(20 BYTE),
    symbol                         VARCHAR2(20 BYTE),
    reid                           VARCHAR2(10 BYTE),
    txdate                         TIMESTAMP (6),
    status                         VARCHAR2(1 BYTE),
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE seregmemo
/

CREATE TABLE seregmemo
    (autoid                         FLOAT(64),
    custid                         VARCHAR2(30 BYTE),
    acctno                         VARCHAR2(40 BYTE),
    afacctno                       VARCHAR2(30 BYTE),
    codeid                         VARCHAR2(20 BYTE),
    symbol                         VARCHAR2(20 BYTE),
    reid                           VARCHAR2(10 BYTE),
    txdate                         TIMESTAMP (6),
    status                         VARCHAR2(1 BYTE),
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE sereqclose
/

CREATE TABLE sereqclose
    (autoid                         NUMBER(38,0),
    acctno                         VARCHAR2(40 BYTE),
    dealeracctno                   VARCHAR2(30 BYTE),
    symbol                         VARCHAR2(20 BYTE),
    quantity                       NUMBER(38,0),
    price                          NUMBER(38,0),
    status                         CHAR(1 BYTE),
    txdate                         DATE,
    ref                            VARCHAR2(20 BYTE),
    orgconfirmno                   VARCHAR2(30 BYTE),
    refclose                       VARCHAR2(30 BYTE),
    taxamt                         NUMBER(38,0),
    feeamt                         NUMBER(38,0),
    tlid                           VARCHAR2(30 BYTE),
    offid                          VARCHAR2(30 BYTE),
    contract_no                    VARCHAR2(500 BYTE),
    confirmno                      VARCHAR2(30 BYTE),
    ttkd_profile_stat              CHAR(1 BYTE),
    bks_profile_stat               CHAR(1 BYTE),
    appr_stat                      CHAR(1 BYTE),
    sett_stat                      CHAR(1 BYTE),
    transfer_stat                  CHAR(1 BYTE),
    accounting_stat                CHAR(1 BYTE),
    transfer_date                  DATE,
    start_prof_debt_dt             DATE,
    last_update_prof_dt            DATE,
    ttkd_reason                    VARCHAR2(30 BYTE),
    bks_reason                     VARCHAR2(30 BYTE),
    shs_reason                     VARCHAR2(1000 BYTE),
    txtime                         VARCHAR2(20 BYTE),
    sett_date                      DATE,
    istransfer                     CHAR(1 BYTE),
    ttkd_stat_maker                CHAR(1 BYTE),
    bks_stat_maker                 CHAR(1 BYTE),
    ttkd_reason_maker              VARCHAR2(30 BYTE),
    bks_reason_maker               VARCHAR2(30 BYTE),
    ttkd_tlid                      VARCHAR2(30 BYTE),
    ttkd_offid                     VARCHAR2(30 BYTE),
    bks_tlid                       VARCHAR2(30 BYTE),
    bks_offid                      VARCHAR2(30 BYTE),
    shs_tlid                       VARCHAR2(30 BYTE),
    intrate                        NUMBER,
    islisted                       VARCHAR2(10 BYTE),
    ispushed                       VARCHAR2(10 BYTE),
    moneytransfer                  VARCHAR2(10 BYTE),
    inadvance                      VARCHAR2(10 BYTE),
    feetransfer                    NUMBER)
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE sereqclosememo
/

CREATE TABLE sereqclosememo
    (autoid                         BINARY_DOUBLE NOT NULL,
    acctno                         VARCHAR2(40 BYTE),
    afacctno                       VARCHAR2(30 BYTE),
    custodycd                      VARCHAR2(10 BYTE),
    codeid                         VARCHAR2(20 BYTE),
    symbol                         VARCHAR2(20 BYTE),
    quantity                       BINARY_DOUBLE,
    price                          BINARY_DOUBLE,
    status                         VARCHAR2(1 BYTE))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE serviceaccounts
/

CREATE TABLE serviceaccounts
    (autoid                         FLOAT(64) NOT NULL,
    symbol                         VARCHAR2(15 BYTE),
    categoryid                     VARCHAR2(15 BYTE),
    category                       VARCHAR2(500 BYTE),
    refafacctno                    VARCHAR2(500 BYTE),
    crbankacct                     VARCHAR2(500 BYTE),
    drbankacct                     VARCHAR2(500 BYTE),
    bankcdid                       VARCHAR2(15 BYTE),
    bankcd                         VARCHAR2(500 BYTE),
    lastchange                     TIMESTAMP (6) DEFAULT to_date('0001-01-01 00:00:00', 'YYYY-MM-DD hh24:mi:ss'))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

ALTER TABLE serviceaccounts
ADD CONSTRAINT serviceaccounts_id_pkey PRIMARY KEY (autoid)
USING INDEX
/

DROP TABLE sesendout
/

CREATE TABLE sesendout
    (autoid                         BINARY_DOUBLE DEFAULT 0 NOT NULL,
    txnum                          VARCHAR2(15 BYTE),
    txdate                         DATE,
    acctno                         VARCHAR2(20 BYTE),
    trade                          BINARY_DOUBLE,
    blocked                        BINARY_DOUBLE,
    caqtty                         BINARY_DOUBLE,
    strade                         BINARY_DOUBLE,
    sblocked                       BINARY_DOUBLE,
    scaqtty                        BINARY_DOUBLE,
    ctrade                         BINARY_DOUBLE,
    cblocked                       BINARY_DOUBLE,
    ccaqtty                        BINARY_DOUBLE,
    recustodycd                    VARCHAR2(10 BYTE),
    recustname                     VARCHAR2(200 BYTE),
    deltd                          VARCHAR2(1 BYTE),
    status                         VARCHAR2(1 BYTE),
    codeid                         VARCHAR2(30 BYTE),
    price                          BINARY_DOUBLE,
    outward                        VARCHAR2(3 BYTE),
    id2255                         VARCHAR2(50 BYTE),
    trtype                         VARCHAR2(3 BYTE),
    qttytype                       VARCHAR2(10 BYTE),
    fee                            BINARY_DOUBLE DEFAULT 0,
    tax                            BINARY_DOUBLE DEFAULT 0,
    feesv                          BINARY_DOUBLE DEFAULT 0,
    referenceid                    VARCHAR2(50 BYTE))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

ALTER TABLE sesendout
ADD CONSTRAINT sesendout_pkey PRIMARY KEY (autoid)
USING INDEX
/

DROP TABLE setran
/

CREATE TABLE setran
    (txnum                          VARCHAR2(100 BYTE),
    txdate                         DATE,
    acctno                         VARCHAR2(40 BYTE),
    txcd                           VARCHAR2(4 BYTE),
    namt                           NUMBER(38,0),
    camt                           VARCHAR2(50 BYTE),
    ref                            VARCHAR2(50 BYTE),
    deltd                          VARCHAR2(1 BYTE),
    autoid                         NUMBER(38,0),
    acctref                        VARCHAR2(50 BYTE),
    tltxcd                         VARCHAR2(4 BYTE),
    bkdate                         TIMESTAMP (6),
    trdesc                         VARCHAR2(4000 BYTE),
    lvel                           NUMBER(38,0) DEFAULT 0,
    vermatching                    VARCHAR2(30 BYTE),
    sessionno                      VARCHAR2(30 BYTE),
    nav                            NUMBER(38,0) DEFAULT 0,
    feeamt                         NUMBER(38,0) DEFAULT 0,
    taxamt                         NUMBER(38,0) DEFAULT 0)
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE setran_gen
/

CREATE TABLE setran_gen
    (autoid                         NUMBER(38,0),
    custodycd                      VARCHAR2(20 BYTE),
    custid                         VARCHAR2(20 BYTE),
    txnum                          VARCHAR2(20 BYTE),
    txdate                         DATE,
    acctno                         VARCHAR2(40 BYTE),
    txcd                           VARCHAR2(4 BYTE),
    namt                           NUMBER(38,0),
    camt                           VARCHAR2(50 BYTE),
    ref                            VARCHAR2(50 BYTE),
    deltd                          VARCHAR2(1 BYTE),
    acctref                        VARCHAR2(50 BYTE),
    tltxcd                         VARCHAR2(4 BYTE),
    busdate                        DATE,
    txdesc                         VARCHAR2(4000 BYTE),
    txtime                         VARCHAR2(10 BYTE),
    brid                           VARCHAR2(6 BYTE),
    tlid                           VARCHAR2(10 BYTE),
    offid                          VARCHAR2(10 BYTE),
    chid                           VARCHAR2(10 BYTE),
    afacctno                       VARCHAR2(20 BYTE),
    symbol                         VARCHAR2(80 BYTE),
    txtype                         VARCHAR2(1 BYTE),
    field                          VARCHAR2(30 BYTE),
    codeid                         VARCHAR2(10 BYTE),
    tllog_autoid                   NUMBER(38,0),
    trdesc                         VARCHAR2(4000 BYTE),
    seofftime                      VARCHAR2(10 BYTE),
    setxstatus                     VARCHAR2(10 BYTE),
    vermatching                    VARCHAR2(100 BYTE),
    sessionno                      VARCHAR2(20 BYTE),
    orderid                        VARCHAR2(20 BYTE),
    nav                            NUMBER(38,0),
    feeamt                         NUMBER(38,0),
    taxamt                         NUMBER(38,0))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE setrana
/

CREATE TABLE setrana
    (txnum                          VARCHAR2(100 BYTE),
    txdate                         DATE,
    acctno                         VARCHAR2(40 BYTE),
    txcd                           VARCHAR2(4 BYTE),
    namt                           NUMBER(38,0),
    camt                           VARCHAR2(50 BYTE),
    ref                            VARCHAR2(50 BYTE),
    deltd                          VARCHAR2(1 BYTE),
    autoid                         NUMBER(38,0),
    acctref                        VARCHAR2(50 BYTE),
    tltxcd                         VARCHAR2(4 BYTE),
    bkdate                         TIMESTAMP (6),
    trdesc                         VARCHAR2(4000 BYTE),
    lvel                           NUMBER(38,0) DEFAULT 0,
    vermatching                    VARCHAR2(30 BYTE),
    sessionno                      VARCHAR2(30 BYTE),
    nav                            NUMBER(38,0) DEFAULT 0,
    feeamt                         NUMBER(38,0) DEFAULT 0,
    taxamt                         NUMBER(38,0) DEFAULT 0)
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE sewithdrawdtl
/

CREATE TABLE sewithdrawdtl
    (txdate                         DATE,
    acctno                         VARCHAR2(20 BYTE) NOT NULL,
    codeid                         VARCHAR2(20 BYTE),
    afacctno                       VARCHAR2(20 BYTE),
    status                         VARCHAR2(1 BYTE),
    pstatus                        VARCHAR2(50 BYTE),
    price                          NUMBER,
    withdraw                       NUMBER,
    deltd                          CHAR(1 BYTE) DEFAULT 'N',
    txnum                          VARCHAR2(20 BYTE),
    txdatetxnum                    VARCHAR2(50 BYTE),
    confirmtxnum                   VARCHAR2(20 BYTE),
    confirmtxdate                  DATE,
    blockwithdraw                  NUMBER,
    referenceid                    VARCHAR2(50 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE sewithdrawdtl_bk
/

CREATE TABLE sewithdrawdtl_bk
    (txdate                         DATE,
    acctno                         VARCHAR2(20 BYTE) NOT NULL,
    codeid                         VARCHAR2(20 BYTE),
    afacctno                       VARCHAR2(20 BYTE),
    status                         VARCHAR2(1 BYTE),
    pstatus                        VARCHAR2(50 BYTE),
    price                          BINARY_DOUBLE,
    withdraw                       BINARY_DOUBLE,
    deltd                          CHAR(1 BYTE),
    txnum                          VARCHAR2(20 BYTE),
    txdatetxnum                    VARCHAR2(50 BYTE),
    confirmtxnum                   VARCHAR2(20 BYTE),
    confirmtxdate                  DATE,
    blockwithdraw                  BINARY_DOUBLE,
    referenceid                    VARCHAR2(50 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE sip
/

CREATE TABLE sip
    (spid                           VARCHAR2(20 BYTE),
    spcode                         VARCHAR2(4 BYTE),
    spname                         VARCHAR2(200 BYTE),
    symbol                         VARCHAR2(10 BYTE),
    acctno                         VARCHAR2(10 BYTE),
    frdate                         TIMESTAMP (6),
    todate                         TIMESTAMP (6),
    txdate                         TIMESTAMP (6),
    txnum                          VARCHAR2(10 BYTE),
    amt                            BINARY_DOUBLE,
    minamt                         BINARY_DOUBLE,
    maxamt                         BINARY_DOUBLE,
    maxmiss                        BINARY_DOUBLE,
    tradingcycle                   VARCHAR2(100 BYTE),
    description                    VARCHAR2(500 BYTE),
    status                         VARCHAR2(1 BYTE),
    pstatus                        VARCHAR2(4000 BYTE),
    feeid                          VARCHAR2(10 BYTE),
    ver                            VARCHAR2(10 BYTE),
    lastchange                     TIMESTAMP (6))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE solddtl
/

CREATE TABLE solddtl
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
    before_limit_ass               NUMBER,
    remain_limit_ass               NUMBER,
    return_limit_ass               NUMBER,
    before_limit_prd               NUMBER,
    remain_limit_prd               NUMBER,
    return_limit_prd               NUMBER)
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE source_maintain
/

CREATE TABLE source_maintain
    (funckey                        VARCHAR2(50 BYTE),
    source_code                    CLOB,
    lastchange                     TIMESTAMP (6))
  SEGMENT CREATION IMMEDIATE
  LOB ("SOURCE_CODE") STORE AS SECUREFILE SYS_LOB0000076374C00002$$
  (
   NOCACHE NOLOGGING
   CHUNK 8192
  )
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE srbrkfee
/

CREATE TABLE srbrkfee
    (id                             FLOAT(64),
    orderid                        VARCHAR2(50 BYTE),
    txdate                         TIMESTAMP (6),
    feemstid                       VARCHAR2(30 BYTE),
    feeapid                        VARCHAR2(20 BYTE),
    feeamt                         BINARY_DOUBLE DEFAULT 0,
    feerate                        BINARY_DOUBLE DEFAULT 0)
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE srmast
/

CREATE TABLE srmast
    (orderid                        VARCHAR2(20 BYTE) NOT NULL,
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
    orderamt                       BINARY_DOUBLE DEFAULT 0,
    orderqtty                      BINARY_DOUBLE DEFAULT 0,
    remainqtty                     BINARY_DOUBLE DEFAULT 0,
    cancelqtty                     BINARY_DOUBLE DEFAULT 0,
    adjustqtty                     BINARY_DOUBLE DEFAULT 0,
    matchamt                       BINARY_DOUBLE DEFAULT 0,
    matchqtty                      BINARY_DOUBLE DEFAULT 0,
    cancelamt                      BINARY_DOUBLE DEFAULT 0,
    adjustamt                      BINARY_DOUBLE DEFAULT 0,
    feeamt                         BINARY_DOUBLE DEFAULT 0,
    sessionno                      VARCHAR2(20 BYTE),
    status                         VARCHAR2(10 BYTE),
    pstatus                        VARCHAR2(4000 BYTE),
    deltd                          VARCHAR2(1 BYTE) DEFAULT 'N',
    username                       VARCHAR2(100 BYTE),
    tlid                           VARCHAR2(10 BYTE),
    feeid                          VARCHAR2(50 BYTE),
    verfee                         VARCHAR2(100 BYTE),
    vermatching                    VARCHAR2(10 BYTE),
    porderid                       VARCHAR2(20 BYTE),
    lastchange                     TIMESTAMP (6),
    nav                            BINARY_DOUBLE DEFAULT 0,
    swcodeid                       VARCHAR2(10 BYTE),
    refquoteid                     VARCHAR2(20 BYTE),
    taxamt                         BINARY_DOUBLE DEFAULT 0,
    feebasic                       BINARY_DOUBLE DEFAULT 0,
    penaltyfee                     BINARY_DOUBLE DEFAULT 0,
    vsdorderid                     VARCHAR2(50 BYTE),
    txtime                         VARCHAR2(200 BYTE),
    saleacctno                     VARCHAR2(30 BYTE),
    cistatus                       VARCHAR2(1 BYTE) DEFAULT 'N',
    tradingdate                    DATE,
    objname                        VARCHAR2(100 BYTE),
    odconfirm                      VARCHAR2(1 BYTE),
    allqtty                        NUMBER,
    reid                           VARCHAR2(100 BYTE))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

CREATE INDEX srmast_custodycd_idx ON srmast
  (
    custodycd                       ASC
  )
NOPARALLEL
NOLOGGING
/


ALTER TABLE srmast
ADD CONSTRAINT srmast_orderid_pk PRIMARY KEY (orderid)
USING INDEX
/

DROP TABLE srmasthist
/

CREATE TABLE srmasthist
    (orderid                        VARCHAR2(20 BYTE) NOT NULL,
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
    orderamt                       BINARY_DOUBLE DEFAULT 0,
    orderqtty                      BINARY_DOUBLE DEFAULT 0,
    remainqtty                     BINARY_DOUBLE DEFAULT 0,
    cancelqtty                     BINARY_DOUBLE DEFAULT 0,
    adjustqtty                     BINARY_DOUBLE DEFAULT 0,
    matchamt                       BINARY_DOUBLE DEFAULT 0,
    matchqtty                      BINARY_DOUBLE DEFAULT 0,
    cancelamt                      BINARY_DOUBLE DEFAULT 0,
    adjustamt                      BINARY_DOUBLE DEFAULT 0,
    feeamt                         BINARY_DOUBLE DEFAULT 0,
    sessionno                      VARCHAR2(20 BYTE),
    status                         VARCHAR2(2 BYTE),
    pstatus                        VARCHAR2(4000 BYTE),
    deltd                          VARCHAR2(1 BYTE) DEFAULT 'N',
    username                       VARCHAR2(100 BYTE),
    tlid                           VARCHAR2(10 BYTE),
    feeid                          VARCHAR2(50 BYTE),
    verfee                         VARCHAR2(100 BYTE),
    vermatching                    VARCHAR2(10 BYTE),
    porderid                       VARCHAR2(20 BYTE),
    lastchange                     TIMESTAMP (6),
    nav                            BINARY_DOUBLE DEFAULT 0,
    swcodeid                       VARCHAR2(10 BYTE),
    refquoteid                     VARCHAR2(20 BYTE),
    taxamt                         BINARY_DOUBLE DEFAULT 0,
    feebasic                       BINARY_DOUBLE DEFAULT 0,
    penaltyfee                     BINARY_DOUBLE DEFAULT 0,
    vsdorderid                     VARCHAR2(50 BYTE),
    txtime                         VARCHAR2(200 BYTE),
    saleacctno                     VARCHAR2(30 BYTE),
    cistatus                       VARCHAR2(1 BYTE) DEFAULT 'N',
    tradingdate                    DATE,
    objname                        VARCHAR2(100 BYTE),
    odconfirm                      VARCHAR2(1 BYTE) DEFAULT 'N',
    allqtty                        NUMBER,
    reid                           VARCHAR2(100 BYTE))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

ALTER TABLE srmasthist
ADD CONSTRAINT srmasthist_orderid_pk PRIMARY KEY (orderid)
USING INDEX
/

DROP TABLE srreconcile
/

CREATE TABLE srreconcile
    (autoid                         BINARY_DOUBLE NOT NULL,
    account                        VARCHAR2(40 BYTE),
    symbol                         VARCHAR2(10 BYTE),
    srtype                         VARCHAR2(10 BYTE),
    orderid                        VARCHAR2(20 BYTE),
    ordamt                         BINARY_DOUBLE,
    amount                         BINARY_DOUBLE,
    content                        VARCHAR2(4000 BYTE),
    reftxnum                       VARCHAR2(10 BYTE),
    adjamt                         BINARY_DOUBLE,
    status                         VARCHAR2(1 BYTE),
    missamt                        BINARY_DOUBLE,
    examt                          BINARY_DOUBLE,
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6),
    custodycd                      VARCHAR2(10 BYTE),
    transid                        VARCHAR2(50 BYTE),
    txdate                         TIMESTAMP (6),
    tradingid                      VARCHAR2(100 BYTE),
    estmatchamt                    BINARY_DOUBLE)
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE srreconciledtl
/

CREATE TABLE srreconciledtl
    (autoid                         BINARY_DOUBLE,
    custodycd                      VARCHAR2(10 BYTE),
    account                        VARCHAR2(40 BYTE),
    symbol                         VARCHAR2(10 BYTE),
    orderid                        VARCHAR2(20 BYTE),
    ordamt                         BINARY_DOUBLE,
    amount                         BINARY_DOUBLE,
    reftxnum                       VARCHAR2(10 BYTE),
    reftxdate                      TIMESTAMP (6),
    orgamt                         BINARY_DOUBLE,
    content                        VARCHAR2(4000 BYTE),
    tradingid                      VARCHAR2(100 BYTE),
    estmatchamt                    BINARY_DOUBLE)
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE srreconciledtlhist
/

CREATE TABLE srreconciledtlhist
    (autoid                         BINARY_DOUBLE,
    custodycd                      VARCHAR2(10 BYTE),
    account                        VARCHAR2(40 BYTE),
    symbol                         VARCHAR2(10 BYTE),
    orderid                        VARCHAR2(20 BYTE),
    ordamt                         BINARY_DOUBLE,
    amount                         BINARY_DOUBLE,
    reftxnum                       VARCHAR2(10 BYTE),
    reftxdate                      TIMESTAMP (6),
    orgamt                         BINARY_DOUBLE,
    content                        VARCHAR2(4000 BYTE),
    tradingid                      VARCHAR2(100 BYTE),
    estmatchamt                    BINARY_DOUBLE)
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE srreconcilehist
/

CREATE TABLE srreconcilehist
    (autoid                         BINARY_DOUBLE,
    account                        VARCHAR2(40 BYTE),
    symbol                         VARCHAR2(10 BYTE),
    srtype                         VARCHAR2(10 BYTE),
    orderid                        VARCHAR2(20 BYTE),
    ordamt                         BINARY_DOUBLE,
    amount                         BINARY_DOUBLE,
    content                        VARCHAR2(4000 BYTE),
    reftxnum                       VARCHAR2(10 BYTE),
    adjamt                         BINARY_DOUBLE,
    status                         VARCHAR2(1 BYTE),
    missamt                        BINARY_DOUBLE,
    examt                          BINARY_DOUBLE,
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6),
    custodycd                      VARCHAR2(10 BYTE),
    transid                        VARCHAR2(50 BYTE),
    txdate                         TIMESTAMP (6),
    tradingid                      VARCHAR2(100 BYTE),
    estmatchamt                    BINARY_DOUBLE)
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE srschd
/

CREATE TABLE srschd
    (id                             BINARY_DOUBLE NOT NULL,
    orderid                        VARCHAR2(20 BYTE),
    duetype                        VARCHAR2(2 BYTE),
    afacctno                       VARCHAR2(30 BYTE),
    codeid                         VARCHAR2(10 BYTE),
    custodycd                      VARCHAR2(10 BYTE),
    seacctno                       VARCHAR2(40 BYTE),
    sid                            VARCHAR2(20 BYTE),
    sessionno                      VARCHAR2(20 BYTE),
    symbol                         VARCHAR2(10 BYTE),
    txdate                         TIMESTAMP (6),
    txnum                          VARCHAR2(20 BYTE),
    clrdate                        TIMESTAMP (6),
    clearday                       FLOAT(16),
    amt                            BINARY_DOUBLE,
    qtty                           BINARY_DOUBLE,
    famt                           BINARY_DOUBLE,
    status                         VARCHAR2(1 BYTE),
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

ALTER TABLE srschd
ADD CONSTRAINT srschd_id_pk PRIMARY KEY (id)
USING INDEX
/

DROP TABLE srschdhist
/

CREATE TABLE srschdhist
    (id                             BINARY_DOUBLE NOT NULL,
    orderid                        VARCHAR2(20 BYTE),
    duetype                        VARCHAR2(2 BYTE),
    afacctno                       VARCHAR2(30 BYTE),
    codeid                         VARCHAR2(10 BYTE),
    custodycd                      VARCHAR2(10 BYTE),
    seacctno                       VARCHAR2(40 BYTE),
    sid                            VARCHAR2(20 BYTE),
    sessionno                      VARCHAR2(20 BYTE),
    symbol                         VARCHAR2(10 BYTE),
    txdate                         TIMESTAMP (6),
    txnum                          VARCHAR2(20 BYTE),
    clrdate                        TIMESTAMP (6),
    clearday                       FLOAT(16),
    amt                            BINARY_DOUBLE,
    qtty                           BINARY_DOUBLE,
    famt                           BINARY_DOUBLE,
    status                         VARCHAR2(1 BYTE),
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

ALTER TABLE srschdhist
ADD CONSTRAINT srschdhist_id_pk PRIMARY KEY (id)
USING INDEX
/

DROP TABLE srtrade
/

CREATE TABLE srtrade
    (id                             BINARY_DOUBLE NOT NULL,
    orderid                        VARCHAR2(50 BYTE),
    txnum                          VARCHAR2(20 BYTE),
    txdate                         TIMESTAMP (6),
    exectype                       VARCHAR2(2 BYTE),
    afacctno                       VARCHAR2(30 BYTE),
    custodycd                      VARCHAR2(10 BYTE),
    codeid                         VARCHAR2(6 BYTE),
    symbol                         VARCHAR2(20 BYTE),
    reforderid                     VARCHAR2(30 BYTE),
    matchamt                       BINARY_DOUBLE,
    matchqtty                      BINARY_DOUBLE,
    sedtlid                        BINARY_DOUBLE,
    feerate                        BINARY_DOUBLE,
    feeamt                         BINARY_DOUBLE DEFAULT 0,
    sessionno                      VARCHAR2(100 BYTE),
    feeid                          VARCHAR2(50 BYTE),
    feeappid                       VARCHAR2(10 BYTE),
    lastchange                     TIMESTAMP (6),
    nav                            BINARY_DOUBLE DEFAULT 0,
    taxamt                         BINARY_DOUBLE DEFAULT 0)
  NOPARALLEL
  NOLOGGING
  MONITORING
/

ALTER TABLE srtrade
ADD CONSTRAINT srtrade_pkey PRIMARY KEY (id)
USING INDEX
/

DROP TABLE srtran
/

CREATE TABLE srtran
    (txnum                          VARCHAR2(100 BYTE),
    txdate                         TIMESTAMP (6),
    acctno                         VARCHAR2(40 BYTE),
    txcd                           VARCHAR2(4 BYTE),
    namt                           FLOAT(64) DEFAULT 0,
    camt                           VARCHAR2(50 BYTE),
    acctref                        VARCHAR2(20 BYTE),
    deltd                          VARCHAR2(1 BYTE),
    ref                            VARCHAR2(20 BYTE),
    autoid                         BINARY_DOUBLE DEFAULT 0,
    tltxcd                         VARCHAR2(4 BYTE),
    bkdate                         TIMESTAMP (6),
    trdesc                         VARCHAR2(4000 BYTE))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE st
/

CREATE TABLE st
    (storedname                     VARCHAR2(100 BYTE))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE state4bankdtl
/

CREATE TABLE state4bankdtl
    (autoid                         NUMBER(38,0),
    refid                          VARCHAR2(4000 BYTE),
    txnum                          VARCHAR2(100 BYTE),
    txdate                         TIMESTAMP (6),
    types                          VARCHAR2(100 BYTE),
    amount                         NUMBER(38,0) DEFAULT 0,
    fee                            NUMBER(38,0) DEFAULT 0,
    tax                            NUMBER(38,0) DEFAULT 0,
    codeid                         VARCHAR2(10 BYTE),
    symbol                         VARCHAR2(100 BYTE),
    sessionno                      VARCHAR2(100 BYTE),
    status                         VARCHAR2(100 BYTE),
    pstatus                        VARCHAR2(100 BYTE),
    deltd                          VARCHAR2(10 BYTE) DEFAULT 'N',
    des                            VARCHAR2(100 BYTE),
    seacctno                       VARCHAR2(100 BYTE),
    custodycd                      VARCHAR2(20 BYTE),
    bankacc                        VARCHAR2(100 BYTE),
    bankcode                       VARCHAR2(100 BYTE),
    citybank                       VARCHAR2(100 BYTE),
    bankacname                     VARCHAR2(100 BYTE),
    fullname                       VARCHAR2(500 BYTE),
    orderid                        VARCHAR2(30 BYTE),
    rbankdate                      DATE,
    transdate                      DATE,
    transid                        VARCHAR2(100 BYTE),
    bankaccount                    VARCHAR2(100 BYTE),
    content                        VARCHAR2(500 BYTE),
    orgamt                         NUMBER(38,0) DEFAULT 0,
    srtype                         VARCHAR2(2 BYTE),
    bankacc_cr                     VARCHAR2(100 BYTE),
    bankcode_cr                    VARCHAR2(100 BYTE),
    citybank_cr                    VARCHAR2(100 BYTE),
    bankacc_dr                     VARCHAR2(100 BYTE),
    bankcode_dr                    VARCHAR2(100 BYTE),
    citybank_dr                    VARCHAR2(100 BYTE),
    isdoing                        VARCHAR2(20 BYTE),
    vat                            NUMBER(38,0))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE state4bankdtl_log
/

CREATE TABLE state4bankdtl_log
    (autoid                         NUMBER(38,0),
    refid                          NUMBER(38,0),
    txnum                          VARCHAR2(100 BYTE),
    txdate                         TIMESTAMP (6),
    types                          VARCHAR2(100 BYTE),
    amount                         NUMBER(38,0) DEFAULT 0,
    fee                            NUMBER(38,0) DEFAULT 0,
    tax                            NUMBER(38,0) DEFAULT 0,
    codeid                         VARCHAR2(10 BYTE),
    symbol                         VARCHAR2(100 BYTE),
    sessionno                      VARCHAR2(100 BYTE),
    status                         VARCHAR2(100 BYTE) DEFAULT 'P',
    pstatus                        VARCHAR2(100 BYTE),
    deltd                          VARCHAR2(10 BYTE) DEFAULT 'N',
    des                            VARCHAR2(100 BYTE),
    seacctno                       VARCHAR2(100 BYTE),
    custodycd                      VARCHAR2(20 BYTE),
    bankacc                        VARCHAR2(100 BYTE),
    bankcode                       VARCHAR2(100 BYTE),
    citybank                       VARCHAR2(100 BYTE),
    bankacname                     VARCHAR2(100 BYTE),
    fullname                       VARCHAR2(500 BYTE),
    orderid                        VARCHAR2(30 BYTE),
    rbankdate                      DATE,
    transdate                      DATE,
    transid                        VARCHAR2(100 BYTE),
    bankaccount                    VARCHAR2(100 BYTE),
    content                        VARCHAR2(500 BYTE),
    orgamt                         NUMBER(38,0) DEFAULT 0,
    srtype                         VARCHAR2(2 BYTE),
    bankacc_cr                     VARCHAR2(100 BYTE),
    bankcode_cr                    VARCHAR2(100 BYTE),
    citybank_cr                    VARCHAR2(100 BYTE),
    bankacc_dr                     VARCHAR2(100 BYTE),
    bankcode_dr                    VARCHAR2(100 BYTE),
    citybank_dr                    VARCHAR2(100 BYTE))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE state4bankdtlhist
/

CREATE TABLE state4bankdtlhist
    (id                             NUMBER,
    refid                          NUMBER,
    txnum                          VARCHAR2(100 BYTE),
    txdate                         DATE,
    types                          VARCHAR2(100 BYTE),
    amount                         NUMBER,
    fee                            NUMBER,
    tax                            NUMBER,
    codeid                         VARCHAR2(100 BYTE),
    symbol                         VARCHAR2(100 BYTE),
    sessionno                      VARCHAR2(100 BYTE),
    status                         VARCHAR2(100 BYTE),
    pstatus                        VARCHAR2(1000 BYTE),
    deltd                          VARCHAR2(100 BYTE),
    des                            VARCHAR2(1000 BYTE),
    seacctno                       VARCHAR2(100 BYTE),
    custodycd                      VARCHAR2(20 BYTE),
    bankacc                        VARCHAR2(100 BYTE),
    bankcode                       VARCHAR2(100 BYTE),
    citybank                       VARCHAR2(100 BYTE),
    bankacname                     VARCHAR2(100 BYTE),
    fullname                       VARCHAR2(500 BYTE),
    orderid                        VARCHAR2(30 BYTE),
    rbankdate                      DATE,
    transdate                      DATE,
    transid                        VARCHAR2(500 BYTE),
    bankaccount                    VARCHAR2(500 BYTE),
    content                        VARCHAR2(500 BYTE),
    orgamt                         NUMBER(20,5))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE stp_event
/

CREATE TABLE stp_event
    (id                             NUMBER(10,0),
    txnum                          VARCHAR2(20 BYTE),
    txdate                         DATE,
    tltxcd                         VARCHAR2(10 BYTE),
    isprocess                      VARCHAR2(10 BYTE) DEFAULT 'N',
    logtime                        TIMESTAMP (6),
    processtime                    TIMESTAMP (6))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE stp_nav
/

CREATE TABLE stp_nav
    (idtllog                        NUMBER,
    txdate                         DATE,
    txnum                          VARCHAR2(100 BYTE),
    idate                          DATE,
    tradingid                      VARCHAR2(100 BYTE),
    codeid                         VARCHAR2(100 BYTE),
    symbol                         VARCHAR2(100 BYTE),
    amt                            NUMBER DEFAULT 0,
    totalamt                       NUMBER DEFAULT 0,
    issend                         VARCHAR2(100 BYTE) DEFAULT 'N',
    issendtime                     TIMESTAMP (6),
    note                           VARCHAR2(1000 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE stp_rptlogs
/

CREATE TABLE stp_rptlogs
    (autoid                         VARCHAR2(20 BYTE),
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
    exportpath                     VARCHAR2(1000 BYTE),
    txdate                         DATE,
    refrptauto                     VARCHAR2(20 BYTE),
    isauto                         VARCHAR2(1 BYTE) DEFAULT 'N',
    exptype                        VARCHAR2(100 BYTE),
    mbcode                         VARCHAR2(100 BYTE),
    issignoff                      VARCHAR2(1 BYTE) DEFAULT 'N',
    codeid                         VARCHAR2(10 BYTE),
    tradingid                      VARCHAR2(50 BYTE),
    deltd                          VARCHAR2(10 BYTE) DEFAULT 'N',
    rolecode                       VARCHAR2(100 BYTE),
    exportpathstp                  VARCHAR2(2000 BYTE),
    logtime                        TIMESTAMP (6),
    isend                          VARCHAR2(10 BYTE) DEFAULT 'N',
    isendtime                      TIMESTAMP (6),
    confirmstatus                  VARCHAR2(100 BYTE),
    err_code                       VARCHAR2(100 BYTE),
    err_param                      VARCHAR2(500 BYTE),
    vsdcode                        VARCHAR2(100 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE stp_state4bank
/

CREATE TABLE stp_state4bank
    (autoid                         NUMBER(20,0),
    settype                        VARCHAR2(100 BYTE),
    debankacc                      VARCHAR2(100 BYTE),
    txdate                         VARCHAR2(20 BYTE),
    address                        VARCHAR2(1000 BYTE),
    bankcode                       VARCHAR2(100 BYTE),
    bankacc                        VARCHAR2(100 BYTE),
    bankaccname                    VARCHAR2(1000 BYTE),
    bankname                       VARCHAR2(1000 BYTE),
    description                    VARCHAR2(1000 BYTE),
    ccycd                          VARCHAR2(100 BYTE),
    amount                         NUMBER(20,0),
    account                        VARCHAR2(100 BYTE),
    symbol                         VARCHAR2(100 BYTE),
    sessionno                      VARCHAR2(100 BYTE),
    tradingdate                    VARCHAR2(20 BYTE),
    types                          VARCHAR2(100 BYTE),
    logtime                        TIMESTAMP (6),
    issend                         VARCHAR2(10 BYTE) DEFAULT 'N',
    issendtime                     TIMESTAMP (6),
    confirmstatus                  VARCHAR2(100 BYTE),
    err_code                       VARCHAR2(100 BYTE),
    err_param                      VARCHAR2(500 BYTE),
    orgbankcode                    VARCHAR2(100 BYTE),
    transdate                      DATE,
    transid                        VARCHAR2(100 BYTE),
    bankaccount                    VARCHAR2(100 BYTE),
    content                        VARCHAR2(500 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE stpreceivemsg
/

CREATE TABLE stpreceivemsg
    (id                             NUMBER(10,0),
    refid                          NUMBER(10,0),
    tltxcd                         VARCHAR2(10 BYTE),
    strmsg                         VARCHAR2(4000 BYTE),
    err_code                       VARCHAR2(10 BYTE),
    err_param                      VARCHAR2(1000 BYTE),
    logtime                        TIMESTAMP (6),
    processtime                    TIMESTAMP (6),
    isprocess                      VARCHAR2(1 BYTE) DEFAULT 'N',
    status                         VARCHAR2(1 BYTE) DEFAULT 'N',
    custodycd                      VARCHAR2(100 BYTE),
    txnum                          VARCHAR2(100 BYTE),
    txdate                         DATE,
    stptxnum                       VARCHAR2(100 BYTE))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE stpsendmsg
/

CREATE TABLE stpsendmsg
    (id                             NUMBER(10,0),
    refid                          NUMBER(10,0),
    tltxcd                         VARCHAR2(10 BYTE),
    strmsg                         VARCHAR2(4000 BYTE),
    err_code                       VARCHAR2(10 BYTE),
    err_param                      VARCHAR2(1000 BYTE),
    logtime                        TIMESTAMP (6),
    processtime                    TIMESTAMP (6),
    custodycd                      VARCHAR2(100 BYTE),
    txnum                          VARCHAR2(100 BYTE),
    txdate                         DATE,
    stptxnum                       VARCHAR2(100 BYTE))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE sysvar
/

CREATE TABLE sysvar
    (grname                         VARCHAR2(10 BYTE) NOT NULL,
    varname                        VARCHAR2(30 BYTE) NOT NULL,
    varvalue                       VARCHAR2(300 BYTE),
    vardesc                        VARCHAR2(300 BYTE),
    en_vardesc                     VARCHAR2(300 BYTE),
    editallow                      CHAR(1 BYTE) DEFAULT 'N',
    lastchange                     TIMESTAMP (6),
    status                         VARCHAR2(10 BYTE),
    pstatus                        VARCHAR2(4000 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE sysvarmemo
/

CREATE TABLE sysvarmemo
    (grname                         VARCHAR2(10 BYTE) NOT NULL,
    varname                        VARCHAR2(30 BYTE) NOT NULL,
    varvalue                       VARCHAR2(300 BYTE),
    vardesc                        VARCHAR2(300 BYTE),
    en_vardesc                     VARCHAR2(300 BYTE),
    editallow                      CHAR(1 BYTE) DEFAULT 'N',
    lastchange                     TIMESTAMP (6),
    status                         VARCHAR2(10 BYTE),
    pstatus                        VARCHAR2(4000 BYTE))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE t
/

CREATE TABLE t
    (helper1                        VARCHAR2(50 BYTE),
    helper2                        VARCHAR2(50 BYTE),
    dataelement                    VARCHAR2(50 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE t_servicemix_log
/

CREATE TABLE t_servicemix_log
    (id                             FLOAT(32) DEFAULT 0 NOT NULL,
    notes                          VARCHAR2(4000 BYTE),
    laschanger                     TIMESTAMP (6))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE tablink
/

CREATE TABLE tablink
    (objname                        VARCHAR2(20 BYTE),
    linktable                      VARCHAR2(20 BYTE),
    fksrc                          VARCHAR2(20 BYTE),
    fkdes                          VARCHAR2(20 BYTE),
    linkname                       VARCHAR2(50 BYTE),
    lstodr                         FLOAT(64) DEFAULT 0)
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE taholder
/

CREATE TABLE taholder
    (autoid                         FLOAT(32) DEFAULT 0 NOT NULL,
    custodycd                      VARCHAR2(20 BYTE),
    seacctno                       VARCHAR2(50 BYTE),
    codeid                         VARCHAR2(20 BYTE),
    saleacctno                     VARCHAR2(30 BYTE),
    frdate                         DATE,
    todate                         DATE,
    nors                           VARCHAR2(2 BYTE),
    trade                          BINARY_DOUBLE,
    buynav                         BINARY_DOUBLE,
    currnav                        BINARY_DOUBLE,
    feecalc                        VARCHAR2(3 BYTE),
    feerate                        BINARY_DOUBLE,
    feeamt                         BINARY_DOUBLE,
    deltd                          VARCHAR2(1 BYTE) DEFAULT 'N',
    lastchange                     TIMESTAMP (6) DEFAULT to_date('0001-01-01 00:00:00', 'YYYY-MM-DD hh24:mi:ss'),
    moveqtty                       BINARY_DOUBLE DEFAULT 0)
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE taholder_201801
/

CREATE TABLE taholder_201801
    (autoid                         FLOAT(32) DEFAULT 0 NOT NULL,
    custodycd                      VARCHAR2(20 BYTE),
    seacctno                       VARCHAR2(50 BYTE),
    codeid                         VARCHAR2(20 BYTE),
    saleacctno                     VARCHAR2(30 BYTE),
    frdate                         DATE,
    todate                         DATE,
    nors                           VARCHAR2(2 BYTE),
    trade                          BINARY_DOUBLE,
    buynav                         BINARY_DOUBLE,
    currnav                        BINARY_DOUBLE,
    feecalc                        VARCHAR2(3 BYTE),
    feerate                        BINARY_DOUBLE,
    feeamt                         BINARY_DOUBLE,
    deltd                          VARCHAR2(1 BYTE) DEFAULT 'N',
    lastchange                     TIMESTAMP (6) DEFAULT to_date('0001-01-01 00:00:00', 'YYYY-MM-DD hh24:mi:ss'),
    moveqtty                       BINARY_DOUBLE DEFAULT 0)
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE taholder_201901
/

CREATE TABLE taholder_201901
    (autoid                         FLOAT(32) DEFAULT 0 NOT NULL,
    custodycd                      VARCHAR2(20 BYTE),
    seacctno                       VARCHAR2(50 BYTE),
    codeid                         VARCHAR2(20 BYTE),
    saleacctno                     VARCHAR2(30 BYTE),
    frdate                         DATE,
    todate                         DATE,
    nors                           VARCHAR2(2 BYTE),
    trade                          BINARY_DOUBLE,
    buynav                         BINARY_DOUBLE,
    currnav                        BINARY_DOUBLE,
    feecalc                        VARCHAR2(3 BYTE),
    feerate                        BINARY_DOUBLE,
    feeamt                         BINARY_DOUBLE,
    deltd                          VARCHAR2(1 BYTE) DEFAULT 'N',
    lastchange                     TIMESTAMP (6) DEFAULT to_date('0001-01-01 00:00:00', 'YYYY-MM-DD hh24:mi:ss'),
    moveqtty                       BINARY_DOUBLE DEFAULT 0)
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE taholder_201902
/

CREATE TABLE taholder_201902
    (autoid                         FLOAT(32) DEFAULT 0 NOT NULL,
    custodycd                      VARCHAR2(20 BYTE),
    seacctno                       VARCHAR2(50 BYTE),
    codeid                         VARCHAR2(20 BYTE),
    saleacctno                     VARCHAR2(30 BYTE),
    frdate                         DATE,
    todate                         DATE,
    nors                           VARCHAR2(2 BYTE),
    trade                          BINARY_DOUBLE,
    buynav                         BINARY_DOUBLE,
    currnav                        BINARY_DOUBLE,
    feecalc                        VARCHAR2(3 BYTE),
    feerate                        BINARY_DOUBLE,
    feeamt                         BINARY_DOUBLE,
    deltd                          VARCHAR2(1 BYTE) DEFAULT 'N',
    lastchange                     TIMESTAMP (6) DEFAULT to_date('0001-01-01 00:00:00', 'YYYY-MM-DD hh24:mi:ss'),
    moveqtty                       BINARY_DOUBLE DEFAULT 0)
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE taholder_202001
/

CREATE TABLE taholder_202001
    (autoid                         FLOAT(32) DEFAULT 0 NOT NULL,
    custodycd                      VARCHAR2(20 BYTE),
    seacctno                       VARCHAR2(50 BYTE),
    codeid                         VARCHAR2(20 BYTE),
    saleacctno                     VARCHAR2(30 BYTE),
    frdate                         DATE,
    todate                         DATE,
    nors                           VARCHAR2(2 BYTE),
    trade                          BINARY_DOUBLE,
    buynav                         BINARY_DOUBLE,
    currnav                        BINARY_DOUBLE,
    feecalc                        VARCHAR2(3 BYTE),
    feerate                        BINARY_DOUBLE,
    feeamt                         BINARY_DOUBLE,
    deltd                          VARCHAR2(1 BYTE) DEFAULT 'N',
    lastchange                     TIMESTAMP (6) DEFAULT to_date('0001-01-01 00:00:00', 'YYYY-MM-DD hh24:mi:ss'),
    moveqtty                       BINARY_DOUBLE DEFAULT 0)
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE taholder_202002
/

CREATE TABLE taholder_202002
    (autoid                         FLOAT(32) DEFAULT 0 NOT NULL,
    custodycd                      VARCHAR2(20 BYTE),
    seacctno                       VARCHAR2(50 BYTE),
    codeid                         VARCHAR2(20 BYTE),
    saleacctno                     VARCHAR2(30 BYTE),
    frdate                         DATE,
    todate                         DATE,
    nors                           VARCHAR2(2 BYTE),
    trade                          BINARY_DOUBLE,
    buynav                         BINARY_DOUBLE,
    currnav                        BINARY_DOUBLE,
    feecalc                        VARCHAR2(3 BYTE),
    feerate                        BINARY_DOUBLE,
    feeamt                         BINARY_DOUBLE,
    deltd                          VARCHAR2(1 BYTE) DEFAULT 'N',
    lastchange                     TIMESTAMP (6) DEFAULT to_date('0001-01-01 00:00:00', 'YYYY-MM-DD hh24:mi:ss'),
    moveqtty                       BINARY_DOUBLE DEFAULT 0)
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE taholder_202101
/

CREATE TABLE taholder_202101
    (autoid                         FLOAT(32) DEFAULT 0 NOT NULL,
    custodycd                      VARCHAR2(20 BYTE),
    seacctno                       VARCHAR2(50 BYTE),
    codeid                         VARCHAR2(20 BYTE),
    saleacctno                     VARCHAR2(30 BYTE),
    frdate                         DATE,
    todate                         DATE,
    nors                           VARCHAR2(2 BYTE),
    trade                          BINARY_DOUBLE,
    buynav                         BINARY_DOUBLE,
    currnav                        BINARY_DOUBLE,
    feecalc                        VARCHAR2(3 BYTE),
    feerate                        BINARY_DOUBLE,
    feeamt                         BINARY_DOUBLE,
    deltd                          VARCHAR2(1 BYTE) DEFAULT 'N',
    lastchange                     TIMESTAMP (6) DEFAULT to_date('0001-01-01 00:00:00', 'YYYY-MM-DD hh24:mi:ss'),
    moveqtty                       BINARY_DOUBLE DEFAULT 0)
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE taholder_202102
/

CREATE TABLE taholder_202102
    (autoid                         FLOAT(32) DEFAULT 0 NOT NULL,
    custodycd                      VARCHAR2(20 BYTE),
    seacctno                       VARCHAR2(50 BYTE),
    codeid                         VARCHAR2(20 BYTE),
    saleacctno                     VARCHAR2(30 BYTE),
    frdate                         DATE,
    todate                         DATE,
    nors                           VARCHAR2(2 BYTE),
    trade                          BINARY_DOUBLE,
    buynav                         BINARY_DOUBLE,
    currnav                        BINARY_DOUBLE,
    feecalc                        VARCHAR2(3 BYTE),
    feerate                        BINARY_DOUBLE,
    feeamt                         BINARY_DOUBLE,
    deltd                          VARCHAR2(1 BYTE) DEFAULT 'N',
    lastchange                     TIMESTAMP (6) DEFAULT to_date('0001-01-01 00:00:00', 'YYYY-MM-DD hh24:mi:ss'),
    moveqtty                       BINARY_DOUBLE DEFAULT 0)
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE taholder_202201
/

CREATE TABLE taholder_202201
    (autoid                         FLOAT(32) DEFAULT 0 NOT NULL,
    custodycd                      VARCHAR2(20 BYTE),
    seacctno                       VARCHAR2(50 BYTE),
    codeid                         VARCHAR2(20 BYTE),
    saleacctno                     VARCHAR2(30 BYTE),
    frdate                         DATE,
    todate                         DATE,
    nors                           VARCHAR2(2 BYTE),
    trade                          BINARY_DOUBLE,
    buynav                         BINARY_DOUBLE,
    currnav                        BINARY_DOUBLE,
    feecalc                        VARCHAR2(3 BYTE),
    feerate                        BINARY_DOUBLE,
    feeamt                         BINARY_DOUBLE,
    deltd                          VARCHAR2(1 BYTE) DEFAULT 'N',
    lastchange                     TIMESTAMP (6) DEFAULT to_date('0001-01-01 00:00:00', 'YYYY-MM-DD hh24:mi:ss'),
    moveqtty                       BINARY_DOUBLE DEFAULT 0)
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE taholder_202202
/

CREATE TABLE taholder_202202
    (autoid                         FLOAT(32) DEFAULT 0 NOT NULL,
    custodycd                      VARCHAR2(20 BYTE),
    seacctno                       VARCHAR2(50 BYTE),
    codeid                         VARCHAR2(20 BYTE),
    saleacctno                     VARCHAR2(30 BYTE),
    frdate                         DATE,
    todate                         DATE,
    nors                           VARCHAR2(2 BYTE),
    trade                          BINARY_DOUBLE,
    buynav                         BINARY_DOUBLE,
    currnav                        BINARY_DOUBLE,
    feecalc                        VARCHAR2(3 BYTE),
    feerate                        BINARY_DOUBLE,
    feeamt                         BINARY_DOUBLE,
    deltd                          VARCHAR2(1 BYTE) DEFAULT 'N',
    lastchange                     TIMESTAMP (6) DEFAULT to_date('0001-01-01 00:00:00', 'YYYY-MM-DD hh24:mi:ss'),
    moveqtty                       BINARY_DOUBLE DEFAULT 0)
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE taholder_202301
/

CREATE TABLE taholder_202301
    (autoid                         FLOAT(32) DEFAULT 0 NOT NULL,
    custodycd                      VARCHAR2(20 BYTE),
    seacctno                       VARCHAR2(50 BYTE),
    codeid                         VARCHAR2(20 BYTE),
    saleacctno                     VARCHAR2(30 BYTE),
    frdate                         DATE,
    todate                         DATE,
    nors                           VARCHAR2(2 BYTE),
    trade                          BINARY_DOUBLE,
    buynav                         BINARY_DOUBLE,
    currnav                        BINARY_DOUBLE,
    feecalc                        VARCHAR2(3 BYTE),
    feerate                        BINARY_DOUBLE,
    feeamt                         BINARY_DOUBLE,
    deltd                          VARCHAR2(1 BYTE) DEFAULT 'N',
    lastchange                     TIMESTAMP (6) DEFAULT to_date('0001-01-01 00:00:00', 'YYYY-MM-DD hh24:mi:ss'),
    moveqtty                       BINARY_DOUBLE DEFAULT 0)
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE taholder_202302
/

CREATE TABLE taholder_202302
    (autoid                         FLOAT(32) DEFAULT 0 NOT NULL,
    custodycd                      VARCHAR2(20 BYTE),
    seacctno                       VARCHAR2(50 BYTE),
    codeid                         VARCHAR2(20 BYTE),
    saleacctno                     VARCHAR2(30 BYTE),
    frdate                         DATE,
    todate                         DATE,
    nors                           VARCHAR2(2 BYTE),
    trade                          BINARY_DOUBLE,
    buynav                         BINARY_DOUBLE,
    currnav                        BINARY_DOUBLE,
    feecalc                        VARCHAR2(3 BYTE),
    feerate                        BINARY_DOUBLE,
    feeamt                         BINARY_DOUBLE,
    deltd                          VARCHAR2(1 BYTE) DEFAULT 'N',
    lastchange                     TIMESTAMP (6) DEFAULT to_date('0001-01-01 00:00:00', 'YYYY-MM-DD hh24:mi:ss'),
    moveqtty                       BINARY_DOUBLE DEFAULT 0)
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE taholder_202401
/

CREATE TABLE taholder_202401
    (autoid                         FLOAT(32) DEFAULT 0 NOT NULL,
    custodycd                      VARCHAR2(20 BYTE),
    seacctno                       VARCHAR2(50 BYTE),
    codeid                         VARCHAR2(20 BYTE),
    saleacctno                     VARCHAR2(30 BYTE),
    frdate                         DATE,
    todate                         DATE,
    nors                           VARCHAR2(2 BYTE),
    trade                          BINARY_DOUBLE,
    buynav                         BINARY_DOUBLE,
    currnav                        BINARY_DOUBLE,
    feecalc                        VARCHAR2(3 BYTE),
    feerate                        BINARY_DOUBLE,
    feeamt                         BINARY_DOUBLE,
    deltd                          VARCHAR2(1 BYTE) DEFAULT 'N',
    lastchange                     TIMESTAMP (6) DEFAULT to_date('0001-01-01 00:00:00', 'YYYY-MM-DD hh24:mi:ss'),
    moveqtty                       BINARY_DOUBLE DEFAULT 0)
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE taholder_202402
/

CREATE TABLE taholder_202402
    (autoid                         FLOAT(32) DEFAULT 0 NOT NULL,
    custodycd                      VARCHAR2(20 BYTE),
    seacctno                       VARCHAR2(50 BYTE),
    codeid                         VARCHAR2(20 BYTE),
    saleacctno                     VARCHAR2(30 BYTE),
    frdate                         DATE,
    todate                         DATE,
    nors                           VARCHAR2(2 BYTE),
    trade                          BINARY_DOUBLE,
    buynav                         BINARY_DOUBLE,
    currnav                        BINARY_DOUBLE,
    feecalc                        VARCHAR2(3 BYTE),
    feerate                        BINARY_DOUBLE,
    feeamt                         BINARY_DOUBLE,
    deltd                          VARCHAR2(1 BYTE) DEFAULT 'N',
    lastchange                     TIMESTAMP (6) DEFAULT to_date('0001-01-01 00:00:00', 'YYYY-MM-DD hh24:mi:ss'),
    moveqtty                       BINARY_DOUBLE DEFAULT 0)
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE taholder_202501
/

CREATE TABLE taholder_202501
    (autoid                         FLOAT(32) DEFAULT 0 NOT NULL,
    custodycd                      VARCHAR2(20 BYTE),
    seacctno                       VARCHAR2(50 BYTE),
    codeid                         VARCHAR2(20 BYTE),
    saleacctno                     VARCHAR2(30 BYTE),
    frdate                         DATE,
    todate                         DATE,
    nors                           VARCHAR2(2 BYTE),
    trade                          BINARY_DOUBLE,
    buynav                         BINARY_DOUBLE,
    currnav                        BINARY_DOUBLE,
    feecalc                        VARCHAR2(3 BYTE),
    feerate                        BINARY_DOUBLE,
    feeamt                         BINARY_DOUBLE,
    deltd                          VARCHAR2(1 BYTE) DEFAULT 'N',
    lastchange                     TIMESTAMP (6) DEFAULT to_date('0001-01-01 00:00:00', 'YYYY-MM-DD hh24:mi:ss'),
    moveqtty                       BINARY_DOUBLE DEFAULT 0)
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE taholder_202502
/

CREATE TABLE taholder_202502
    (autoid                         FLOAT(32) DEFAULT 0 NOT NULL,
    custodycd                      VARCHAR2(20 BYTE),
    seacctno                       VARCHAR2(50 BYTE),
    codeid                         VARCHAR2(20 BYTE),
    saleacctno                     VARCHAR2(30 BYTE),
    frdate                         DATE,
    todate                         DATE,
    nors                           VARCHAR2(2 BYTE),
    trade                          BINARY_DOUBLE,
    buynav                         BINARY_DOUBLE,
    currnav                        BINARY_DOUBLE,
    feecalc                        VARCHAR2(3 BYTE),
    feerate                        BINARY_DOUBLE,
    feeamt                         BINARY_DOUBLE,
    deltd                          VARCHAR2(1 BYTE) DEFAULT 'N',
    lastchange                     TIMESTAMP (6) DEFAULT to_date('0001-01-01 00:00:00', 'YYYY-MM-DD hh24:mi:ss'),
    moveqtty                       BINARY_DOUBLE DEFAULT 0)
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE taholder_ex
/

CREATE TABLE taholder_ex
    (autoid                         FLOAT(32) DEFAULT 0 NOT NULL,
    custodycd                      VARCHAR2(20 BYTE),
    seacctno                       VARCHAR2(50 BYTE),
    codeid                         VARCHAR2(20 BYTE),
    saleacctno                     VARCHAR2(30 BYTE),
    frdate                         DATE,
    todate                         DATE,
    nors                           VARCHAR2(2 BYTE),
    trade                          BINARY_DOUBLE,
    buynav                         BINARY_DOUBLE,
    currnav                        BINARY_DOUBLE,
    feecalc                        VARCHAR2(3 BYTE),
    feerate                        BINARY_DOUBLE,
    feeamt                         BINARY_DOUBLE,
    deltd                          VARCHAR2(1 BYTE) DEFAULT 'N',
    lastchange                     TIMESTAMP (6) DEFAULT to_date('0001-01-01 00:00:00', 'YYYY-MM-DD hh24:mi:ss'),
    moveqtty                       BINARY_DOUBLE DEFAULT 0)
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE taholderdtl
/

CREATE TABLE taholderdtl
    (autoid                         FLOAT(32) DEFAULT 0 NOT NULL,
    custodycd                      VARCHAR2(20 BYTE),
    seacctno                       VARCHAR2(50 BYTE),
    codeid                         VARCHAR2(20 BYTE),
    saleacctno                     VARCHAR2(30 BYTE),
    refid                          VARCHAR2(50 BYTE),
    frdate                         DATE,
    todate                         DATE,
    nors                           VARCHAR2(2 BYTE),
    trade                          BINARY_DOUBLE,
    buynav                         BINARY_DOUBLE,
    currnav                        BINARY_DOUBLE,
    feecalc                        VARCHAR2(3 BYTE),
    feerate                        BINARY_DOUBLE,
    feeamt                         BINARY_DOUBLE,
    deltd                          VARCHAR2(1 BYTE) DEFAULT 'N',
    lastchange                     TIMESTAMP (6) DEFAULT to_date('0001-01-01 00:00:00', 'YYYY-MM-DD hh24:mi:ss'),
    swid                           VARCHAR2(50 BYTE),
    moveqtty                       BINARY_DOUBLE DEFAULT 0,
    begindate                      DATE)
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE taholderdtl_01_2019
/

CREATE TABLE taholderdtl_01_2019
    (autoid                         FLOAT(32) DEFAULT 0 NOT NULL,
    custodycd                      VARCHAR2(20 BYTE),
    seacctno                       VARCHAR2(50 BYTE),
    codeid                         VARCHAR2(20 BYTE),
    saleacctno                     VARCHAR2(30 BYTE),
    refid                          VARCHAR2(50 BYTE),
    frdate                         DATE,
    todate                         DATE,
    nors                           VARCHAR2(2 BYTE),
    trade                          BINARY_DOUBLE,
    buynav                         BINARY_DOUBLE,
    currnav                        BINARY_DOUBLE,
    feecalc                        VARCHAR2(3 BYTE),
    feerate                        BINARY_DOUBLE,
    feeamt                         BINARY_DOUBLE,
    deltd                          VARCHAR2(1 BYTE) DEFAULT 'N',
    lastchange                     TIMESTAMP (6) DEFAULT to_date('0001-01-01 00:00:00', 'YYYY-MM-DD hh24:mi:ss'),
    swid                           VARCHAR2(50 BYTE),
    moveqtty                       BINARY_DOUBLE DEFAULT 0,
    begindate                      DATE)
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE taholderdtl_01_2020
/

CREATE TABLE taholderdtl_01_2020
    (autoid                         FLOAT(32) DEFAULT 0 NOT NULL,
    custodycd                      VARCHAR2(20 BYTE),
    seacctno                       VARCHAR2(50 BYTE),
    codeid                         VARCHAR2(20 BYTE),
    saleacctno                     VARCHAR2(30 BYTE),
    refid                          VARCHAR2(50 BYTE),
    frdate                         DATE,
    todate                         DATE,
    nors                           VARCHAR2(2 BYTE),
    trade                          BINARY_DOUBLE,
    buynav                         BINARY_DOUBLE,
    currnav                        BINARY_DOUBLE,
    feecalc                        VARCHAR2(3 BYTE),
    feerate                        BINARY_DOUBLE,
    feeamt                         BINARY_DOUBLE,
    deltd                          VARCHAR2(1 BYTE) DEFAULT 'N',
    lastchange                     TIMESTAMP (6) DEFAULT to_date('0001-01-01 00:00:00', 'YYYY-MM-DD hh24:mi:ss'),
    swid                           VARCHAR2(50 BYTE),
    moveqtty                       BINARY_DOUBLE DEFAULT 0,
    begindate                      DATE)
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE taholderdtl_01_2021
/

CREATE TABLE taholderdtl_01_2021
    (autoid                         FLOAT(32) DEFAULT 0 NOT NULL,
    custodycd                      VARCHAR2(20 BYTE),
    seacctno                       VARCHAR2(50 BYTE),
    codeid                         VARCHAR2(20 BYTE),
    saleacctno                     VARCHAR2(30 BYTE),
    refid                          VARCHAR2(50 BYTE),
    frdate                         DATE,
    todate                         DATE,
    nors                           VARCHAR2(2 BYTE),
    trade                          BINARY_DOUBLE,
    buynav                         BINARY_DOUBLE,
    currnav                        BINARY_DOUBLE,
    feecalc                        VARCHAR2(3 BYTE),
    feerate                        BINARY_DOUBLE,
    feeamt                         BINARY_DOUBLE,
    deltd                          VARCHAR2(1 BYTE) DEFAULT 'N',
    lastchange                     TIMESTAMP (6) DEFAULT to_date('0001-01-01 00:00:00', 'YYYY-MM-DD hh24:mi:ss'),
    swid                           VARCHAR2(50 BYTE),
    moveqtty                       BINARY_DOUBLE DEFAULT 0,
    begindate                      DATE)
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE taholderdtl_06_2018
/

CREATE TABLE taholderdtl_06_2018
    (autoid                         FLOAT(32) DEFAULT 0 NOT NULL,
    custodycd                      VARCHAR2(20 BYTE),
    seacctno                       VARCHAR2(50 BYTE),
    codeid                         VARCHAR2(20 BYTE),
    saleacctno                     VARCHAR2(30 BYTE),
    refid                          VARCHAR2(50 BYTE),
    frdate                         DATE,
    todate                         DATE,
    nors                           VARCHAR2(2 BYTE),
    trade                          BINARY_DOUBLE,
    buynav                         BINARY_DOUBLE,
    currnav                        BINARY_DOUBLE,
    feecalc                        VARCHAR2(3 BYTE),
    feerate                        BINARY_DOUBLE,
    feeamt                         BINARY_DOUBLE,
    deltd                          VARCHAR2(1 BYTE) DEFAULT 'N',
    lastchange                     TIMESTAMP (6) DEFAULT to_date('0001-01-01 00:00:00', 'YYYY-MM-DD hh24:mi:ss'),
    swid                           VARCHAR2(50 BYTE),
    moveqtty                       BINARY_DOUBLE DEFAULT 0,
    begindate                      DATE)
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE taholderdtl_06_2019
/

CREATE TABLE taholderdtl_06_2019
    (autoid                         FLOAT(32) DEFAULT 0 NOT NULL,
    custodycd                      VARCHAR2(20 BYTE),
    seacctno                       VARCHAR2(50 BYTE),
    codeid                         VARCHAR2(20 BYTE),
    saleacctno                     VARCHAR2(30 BYTE),
    refid                          VARCHAR2(50 BYTE),
    frdate                         DATE,
    todate                         DATE,
    nors                           VARCHAR2(2 BYTE),
    trade                          BINARY_DOUBLE,
    buynav                         BINARY_DOUBLE,
    currnav                        BINARY_DOUBLE,
    feecalc                        VARCHAR2(3 BYTE),
    feerate                        BINARY_DOUBLE,
    feeamt                         BINARY_DOUBLE,
    deltd                          VARCHAR2(1 BYTE) DEFAULT 'N',
    lastchange                     TIMESTAMP (6) DEFAULT to_date('0001-01-01 00:00:00', 'YYYY-MM-DD hh24:mi:ss'),
    swid                           VARCHAR2(50 BYTE),
    moveqtty                       BINARY_DOUBLE DEFAULT 0,
    begindate                      DATE)
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE taholderdtl_06_2020
/

CREATE TABLE taholderdtl_06_2020
    (autoid                         FLOAT(32) DEFAULT 0 NOT NULL,
    custodycd                      VARCHAR2(20 BYTE),
    seacctno                       VARCHAR2(50 BYTE),
    codeid                         VARCHAR2(20 BYTE),
    saleacctno                     VARCHAR2(30 BYTE),
    refid                          VARCHAR2(50 BYTE),
    frdate                         DATE,
    todate                         DATE,
    nors                           VARCHAR2(2 BYTE),
    trade                          BINARY_DOUBLE,
    buynav                         BINARY_DOUBLE,
    currnav                        BINARY_DOUBLE,
    feecalc                        VARCHAR2(3 BYTE),
    feerate                        BINARY_DOUBLE,
    feeamt                         BINARY_DOUBLE,
    deltd                          VARCHAR2(1 BYTE) DEFAULT 'N',
    lastchange                     TIMESTAMP (6) DEFAULT to_date('0001-01-01 00:00:00', 'YYYY-MM-DD hh24:mi:ss'),
    swid                           VARCHAR2(50 BYTE),
    moveqtty                       BINARY_DOUBLE DEFAULT 0,
    begindate                      DATE)
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE taholderdtl_06_2021
/

CREATE TABLE taholderdtl_06_2021
    (autoid                         FLOAT(32) DEFAULT 0 NOT NULL,
    custodycd                      VARCHAR2(20 BYTE),
    seacctno                       VARCHAR2(50 BYTE),
    codeid                         VARCHAR2(20 BYTE),
    saleacctno                     VARCHAR2(30 BYTE),
    refid                          VARCHAR2(50 BYTE),
    frdate                         DATE,
    todate                         DATE,
    nors                           VARCHAR2(2 BYTE),
    trade                          BINARY_DOUBLE,
    buynav                         BINARY_DOUBLE,
    currnav                        BINARY_DOUBLE,
    feecalc                        VARCHAR2(3 BYTE),
    feerate                        BINARY_DOUBLE,
    feeamt                         BINARY_DOUBLE,
    deltd                          VARCHAR2(1 BYTE) DEFAULT 'N',
    lastchange                     TIMESTAMP (6) DEFAULT to_date('0001-01-01 00:00:00', 'YYYY-MM-DD hh24:mi:ss'),
    swid                           VARCHAR2(50 BYTE),
    moveqtty                       BINARY_DOUBLE DEFAULT 0,
    begindate                      DATE)
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE taholderdtl_201801
/

CREATE TABLE taholderdtl_201801
    (autoid                         FLOAT(32) DEFAULT 0 NOT NULL,
    custodycd                      VARCHAR2(20 BYTE),
    seacctno                       VARCHAR2(50 BYTE),
    codeid                         VARCHAR2(20 BYTE),
    saleacctno                     VARCHAR2(30 BYTE),
    refid                          VARCHAR2(50 BYTE),
    frdate                         DATE,
    todate                         DATE,
    nors                           VARCHAR2(2 BYTE),
    trade                          BINARY_DOUBLE,
    buynav                         BINARY_DOUBLE,
    currnav                        BINARY_DOUBLE,
    feecalc                        VARCHAR2(3 BYTE),
    feerate                        BINARY_DOUBLE,
    feeamt                         BINARY_DOUBLE,
    deltd                          VARCHAR2(1 BYTE) DEFAULT 'N',
    lastchange                     TIMESTAMP (6) DEFAULT to_date('0001-01-01 00:00:00', 'YYYY-MM-DD hh24:mi:ss'),
    swid                           VARCHAR2(50 BYTE),
    moveqtty                       BINARY_DOUBLE DEFAULT 0,
    begindate                      DATE)
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE taholderdtl_201901
/

CREATE TABLE taholderdtl_201901
    (autoid                         FLOAT(32) DEFAULT 0 NOT NULL,
    custodycd                      VARCHAR2(20 BYTE),
    seacctno                       VARCHAR2(50 BYTE),
    codeid                         VARCHAR2(20 BYTE),
    saleacctno                     VARCHAR2(30 BYTE),
    refid                          VARCHAR2(50 BYTE),
    frdate                         DATE,
    todate                         DATE,
    nors                           VARCHAR2(2 BYTE),
    trade                          BINARY_DOUBLE,
    buynav                         BINARY_DOUBLE,
    currnav                        BINARY_DOUBLE,
    feecalc                        VARCHAR2(3 BYTE),
    feerate                        BINARY_DOUBLE,
    feeamt                         BINARY_DOUBLE,
    deltd                          VARCHAR2(1 BYTE) DEFAULT 'N',
    lastchange                     TIMESTAMP (6) DEFAULT to_date('0001-01-01 00:00:00', 'YYYY-MM-DD hh24:mi:ss'),
    swid                           VARCHAR2(50 BYTE),
    moveqtty                       BINARY_DOUBLE DEFAULT 0,
    begindate                      DATE)
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE taholderdtl_201902
/

CREATE TABLE taholderdtl_201902
    (autoid                         FLOAT(32) DEFAULT 0 NOT NULL,
    custodycd                      VARCHAR2(20 BYTE),
    seacctno                       VARCHAR2(50 BYTE),
    codeid                         VARCHAR2(20 BYTE),
    saleacctno                     VARCHAR2(30 BYTE),
    refid                          VARCHAR2(50 BYTE),
    frdate                         DATE,
    todate                         DATE,
    nors                           VARCHAR2(2 BYTE),
    trade                          BINARY_DOUBLE,
    buynav                         BINARY_DOUBLE,
    currnav                        BINARY_DOUBLE,
    feecalc                        VARCHAR2(3 BYTE),
    feerate                        BINARY_DOUBLE,
    feeamt                         BINARY_DOUBLE,
    deltd                          VARCHAR2(1 BYTE) DEFAULT 'N',
    lastchange                     TIMESTAMP (6) DEFAULT to_date('0001-01-01 00:00:00', 'YYYY-MM-DD hh24:mi:ss'),
    swid                           VARCHAR2(50 BYTE),
    moveqtty                       BINARY_DOUBLE DEFAULT 0,
    begindate                      DATE)
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE taholderdtl_202001
/

CREATE TABLE taholderdtl_202001
    (autoid                         FLOAT(32) DEFAULT 0 NOT NULL,
    custodycd                      VARCHAR2(20 BYTE),
    seacctno                       VARCHAR2(50 BYTE),
    codeid                         VARCHAR2(20 BYTE),
    saleacctno                     VARCHAR2(30 BYTE),
    refid                          VARCHAR2(50 BYTE),
    frdate                         DATE,
    todate                         DATE,
    nors                           VARCHAR2(2 BYTE),
    trade                          BINARY_DOUBLE,
    buynav                         BINARY_DOUBLE,
    currnav                        BINARY_DOUBLE,
    feecalc                        VARCHAR2(3 BYTE),
    feerate                        BINARY_DOUBLE,
    feeamt                         BINARY_DOUBLE,
    deltd                          VARCHAR2(1 BYTE) DEFAULT 'N',
    lastchange                     TIMESTAMP (6) DEFAULT to_date('0001-01-01 00:00:00', 'YYYY-MM-DD hh24:mi:ss'),
    swid                           VARCHAR2(50 BYTE),
    moveqtty                       BINARY_DOUBLE DEFAULT 0,
    begindate                      DATE)
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE taholderdtl_202002
/

CREATE TABLE taholderdtl_202002
    (autoid                         FLOAT(32) DEFAULT 0 NOT NULL,
    custodycd                      VARCHAR2(20 BYTE),
    seacctno                       VARCHAR2(50 BYTE),
    codeid                         VARCHAR2(20 BYTE),
    saleacctno                     VARCHAR2(30 BYTE),
    refid                          VARCHAR2(50 BYTE),
    frdate                         DATE,
    todate                         DATE,
    nors                           VARCHAR2(2 BYTE),
    trade                          BINARY_DOUBLE,
    buynav                         BINARY_DOUBLE,
    currnav                        BINARY_DOUBLE,
    feecalc                        VARCHAR2(3 BYTE),
    feerate                        BINARY_DOUBLE,
    feeamt                         BINARY_DOUBLE,
    deltd                          VARCHAR2(1 BYTE) DEFAULT 'N',
    lastchange                     TIMESTAMP (6) DEFAULT to_date('0001-01-01 00:00:00', 'YYYY-MM-DD hh24:mi:ss'),
    swid                           VARCHAR2(50 BYTE),
    moveqtty                       BINARY_DOUBLE DEFAULT 0,
    begindate                      DATE)
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE taholderdtl_202101
/

CREATE TABLE taholderdtl_202101
    (autoid                         FLOAT(32) DEFAULT 0 NOT NULL,
    custodycd                      VARCHAR2(20 BYTE),
    seacctno                       VARCHAR2(50 BYTE),
    codeid                         VARCHAR2(20 BYTE),
    saleacctno                     VARCHAR2(30 BYTE),
    refid                          VARCHAR2(50 BYTE),
    frdate                         DATE,
    todate                         DATE,
    nors                           VARCHAR2(2 BYTE),
    trade                          BINARY_DOUBLE,
    buynav                         BINARY_DOUBLE,
    currnav                        BINARY_DOUBLE,
    feecalc                        VARCHAR2(3 BYTE),
    feerate                        BINARY_DOUBLE,
    feeamt                         BINARY_DOUBLE,
    deltd                          VARCHAR2(1 BYTE) DEFAULT 'N',
    lastchange                     TIMESTAMP (6) DEFAULT to_date('0001-01-01 00:00:00', 'YYYY-MM-DD hh24:mi:ss'),
    swid                           VARCHAR2(50 BYTE),
    moveqtty                       BINARY_DOUBLE DEFAULT 0,
    begindate                      DATE)
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE taholderdtl_202102
/

CREATE TABLE taholderdtl_202102
    (autoid                         FLOAT(32) DEFAULT 0 NOT NULL,
    custodycd                      VARCHAR2(20 BYTE),
    seacctno                       VARCHAR2(50 BYTE),
    codeid                         VARCHAR2(20 BYTE),
    saleacctno                     VARCHAR2(30 BYTE),
    refid                          VARCHAR2(50 BYTE),
    frdate                         DATE,
    todate                         DATE,
    nors                           VARCHAR2(2 BYTE),
    trade                          BINARY_DOUBLE,
    buynav                         BINARY_DOUBLE,
    currnav                        BINARY_DOUBLE,
    feecalc                        VARCHAR2(3 BYTE),
    feerate                        BINARY_DOUBLE,
    feeamt                         BINARY_DOUBLE,
    deltd                          VARCHAR2(1 BYTE) DEFAULT 'N',
    lastchange                     TIMESTAMP (6) DEFAULT to_date('0001-01-01 00:00:00', 'YYYY-MM-DD hh24:mi:ss'),
    swid                           VARCHAR2(50 BYTE),
    moveqtty                       BINARY_DOUBLE DEFAULT 0,
    begindate                      DATE)
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE taholderdtl_202201
/

CREATE TABLE taholderdtl_202201
    (autoid                         FLOAT(32) DEFAULT 0 NOT NULL,
    custodycd                      VARCHAR2(20 BYTE),
    seacctno                       VARCHAR2(50 BYTE),
    codeid                         VARCHAR2(20 BYTE),
    saleacctno                     VARCHAR2(30 BYTE),
    refid                          VARCHAR2(50 BYTE),
    frdate                         DATE,
    todate                         DATE,
    nors                           VARCHAR2(2 BYTE),
    trade                          BINARY_DOUBLE,
    buynav                         BINARY_DOUBLE,
    currnav                        BINARY_DOUBLE,
    feecalc                        VARCHAR2(3 BYTE),
    feerate                        BINARY_DOUBLE,
    feeamt                         BINARY_DOUBLE,
    deltd                          VARCHAR2(1 BYTE) DEFAULT 'N',
    lastchange                     TIMESTAMP (6) DEFAULT to_date('0001-01-01 00:00:00', 'YYYY-MM-DD hh24:mi:ss'),
    swid                           VARCHAR2(50 BYTE),
    moveqtty                       BINARY_DOUBLE DEFAULT 0,
    begindate                      DATE)
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE taholderdtl_202202
/

CREATE TABLE taholderdtl_202202
    (autoid                         FLOAT(32) DEFAULT 0 NOT NULL,
    custodycd                      VARCHAR2(20 BYTE),
    seacctno                       VARCHAR2(50 BYTE),
    codeid                         VARCHAR2(20 BYTE),
    saleacctno                     VARCHAR2(30 BYTE),
    refid                          VARCHAR2(50 BYTE),
    frdate                         DATE,
    todate                         DATE,
    nors                           VARCHAR2(2 BYTE),
    trade                          BINARY_DOUBLE,
    buynav                         BINARY_DOUBLE,
    currnav                        BINARY_DOUBLE,
    feecalc                        VARCHAR2(3 BYTE),
    feerate                        BINARY_DOUBLE,
    feeamt                         BINARY_DOUBLE,
    deltd                          VARCHAR2(1 BYTE) DEFAULT 'N',
    lastchange                     TIMESTAMP (6) DEFAULT to_date('0001-01-01 00:00:00', 'YYYY-MM-DD hh24:mi:ss'),
    swid                           VARCHAR2(50 BYTE),
    moveqtty                       BINARY_DOUBLE DEFAULT 0,
    begindate                      DATE)
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE taholderdtl_202301
/

CREATE TABLE taholderdtl_202301
    (autoid                         FLOAT(32) DEFAULT 0 NOT NULL,
    custodycd                      VARCHAR2(20 BYTE),
    seacctno                       VARCHAR2(50 BYTE),
    codeid                         VARCHAR2(20 BYTE),
    saleacctno                     VARCHAR2(30 BYTE),
    refid                          VARCHAR2(50 BYTE),
    frdate                         DATE,
    todate                         DATE,
    nors                           VARCHAR2(2 BYTE),
    trade                          BINARY_DOUBLE,
    buynav                         BINARY_DOUBLE,
    currnav                        BINARY_DOUBLE,
    feecalc                        VARCHAR2(3 BYTE),
    feerate                        BINARY_DOUBLE,
    feeamt                         BINARY_DOUBLE,
    deltd                          VARCHAR2(1 BYTE) DEFAULT 'N',
    lastchange                     TIMESTAMP (6) DEFAULT to_date('0001-01-01 00:00:00', 'YYYY-MM-DD hh24:mi:ss'),
    swid                           VARCHAR2(50 BYTE),
    moveqtty                       BINARY_DOUBLE DEFAULT 0,
    begindate                      DATE)
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE taholderdtl_202302
/

CREATE TABLE taholderdtl_202302
    (autoid                         FLOAT(32) DEFAULT 0 NOT NULL,
    custodycd                      VARCHAR2(20 BYTE),
    seacctno                       VARCHAR2(50 BYTE),
    codeid                         VARCHAR2(20 BYTE),
    saleacctno                     VARCHAR2(30 BYTE),
    refid                          VARCHAR2(50 BYTE),
    frdate                         DATE,
    todate                         DATE,
    nors                           VARCHAR2(2 BYTE),
    trade                          BINARY_DOUBLE,
    buynav                         BINARY_DOUBLE,
    currnav                        BINARY_DOUBLE,
    feecalc                        VARCHAR2(3 BYTE),
    feerate                        BINARY_DOUBLE,
    feeamt                         BINARY_DOUBLE,
    deltd                          VARCHAR2(1 BYTE) DEFAULT 'N',
    lastchange                     TIMESTAMP (6) DEFAULT to_date('0001-01-01 00:00:00', 'YYYY-MM-DD hh24:mi:ss'),
    swid                           VARCHAR2(50 BYTE),
    moveqtty                       BINARY_DOUBLE DEFAULT 0,
    begindate                      DATE)
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE taholderdtl_202401
/

CREATE TABLE taholderdtl_202401
    (autoid                         FLOAT(32) DEFAULT 0 NOT NULL,
    custodycd                      VARCHAR2(20 BYTE),
    seacctno                       VARCHAR2(50 BYTE),
    codeid                         VARCHAR2(20 BYTE),
    saleacctno                     VARCHAR2(30 BYTE),
    refid                          VARCHAR2(50 BYTE),
    frdate                         DATE,
    todate                         DATE,
    nors                           VARCHAR2(2 BYTE),
    trade                          BINARY_DOUBLE,
    buynav                         BINARY_DOUBLE,
    currnav                        BINARY_DOUBLE,
    feecalc                        VARCHAR2(3 BYTE),
    feerate                        BINARY_DOUBLE,
    feeamt                         BINARY_DOUBLE,
    deltd                          VARCHAR2(1 BYTE) DEFAULT 'N',
    lastchange                     TIMESTAMP (6) DEFAULT to_date('0001-01-01 00:00:00', 'YYYY-MM-DD hh24:mi:ss'),
    swid                           VARCHAR2(50 BYTE),
    moveqtty                       BINARY_DOUBLE DEFAULT 0,
    begindate                      DATE)
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE taholderdtl_202402
/

CREATE TABLE taholderdtl_202402
    (autoid                         FLOAT(32) DEFAULT 0 NOT NULL,
    custodycd                      VARCHAR2(20 BYTE),
    seacctno                       VARCHAR2(50 BYTE),
    codeid                         VARCHAR2(20 BYTE),
    saleacctno                     VARCHAR2(30 BYTE),
    refid                          VARCHAR2(50 BYTE),
    frdate                         DATE,
    todate                         DATE,
    nors                           VARCHAR2(2 BYTE),
    trade                          BINARY_DOUBLE,
    buynav                         BINARY_DOUBLE,
    currnav                        BINARY_DOUBLE,
    feecalc                        VARCHAR2(3 BYTE),
    feerate                        BINARY_DOUBLE,
    feeamt                         BINARY_DOUBLE,
    deltd                          VARCHAR2(1 BYTE) DEFAULT 'N',
    lastchange                     TIMESTAMP (6) DEFAULT to_date('0001-01-01 00:00:00', 'YYYY-MM-DD hh24:mi:ss'),
    swid                           VARCHAR2(50 BYTE),
    moveqtty                       BINARY_DOUBLE DEFAULT 0,
    begindate                      DATE)
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE taholderdtl_202501
/

CREATE TABLE taholderdtl_202501
    (autoid                         FLOAT(32) DEFAULT 0 NOT NULL,
    custodycd                      VARCHAR2(20 BYTE),
    seacctno                       VARCHAR2(50 BYTE),
    codeid                         VARCHAR2(20 BYTE),
    saleacctno                     VARCHAR2(30 BYTE),
    refid                          VARCHAR2(50 BYTE),
    frdate                         DATE,
    todate                         DATE,
    nors                           VARCHAR2(2 BYTE),
    trade                          BINARY_DOUBLE,
    buynav                         BINARY_DOUBLE,
    currnav                        BINARY_DOUBLE,
    feecalc                        VARCHAR2(3 BYTE),
    feerate                        BINARY_DOUBLE,
    feeamt                         BINARY_DOUBLE,
    deltd                          VARCHAR2(1 BYTE) DEFAULT 'N',
    lastchange                     TIMESTAMP (6) DEFAULT to_date('0001-01-01 00:00:00', 'YYYY-MM-DD hh24:mi:ss'),
    swid                           VARCHAR2(50 BYTE),
    moveqtty                       BINARY_DOUBLE DEFAULT 0,
    begindate                      DATE)
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE taholderdtl_202502
/

CREATE TABLE taholderdtl_202502
    (autoid                         FLOAT(32) DEFAULT 0 NOT NULL,
    custodycd                      VARCHAR2(20 BYTE),
    seacctno                       VARCHAR2(50 BYTE),
    codeid                         VARCHAR2(20 BYTE),
    saleacctno                     VARCHAR2(30 BYTE),
    refid                          VARCHAR2(50 BYTE),
    frdate                         DATE,
    todate                         DATE,
    nors                           VARCHAR2(2 BYTE),
    trade                          BINARY_DOUBLE,
    buynav                         BINARY_DOUBLE,
    currnav                        BINARY_DOUBLE,
    feecalc                        VARCHAR2(3 BYTE),
    feerate                        BINARY_DOUBLE,
    feeamt                         BINARY_DOUBLE,
    deltd                          VARCHAR2(1 BYTE) DEFAULT 'N',
    lastchange                     TIMESTAMP (6) DEFAULT to_date('0001-01-01 00:00:00', 'YYYY-MM-DD hh24:mi:ss'),
    swid                           VARCHAR2(50 BYTE),
    moveqtty                       BINARY_DOUBLE DEFAULT 0,
    begindate                      DATE)
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE taholderdtl_ex
/

CREATE TABLE taholderdtl_ex
    (autoid                         FLOAT(32) DEFAULT 0 NOT NULL,
    custodycd                      VARCHAR2(20 BYTE),
    seacctno                       VARCHAR2(50 BYTE),
    codeid                         VARCHAR2(20 BYTE),
    saleacctno                     VARCHAR2(30 BYTE),
    refid                          VARCHAR2(50 BYTE),
    frdate                         DATE,
    todate                         DATE,
    nors                           VARCHAR2(2 BYTE),
    trade                          BINARY_DOUBLE,
    buynav                         BINARY_DOUBLE,
    currnav                        BINARY_DOUBLE,
    feecalc                        VARCHAR2(3 BYTE),
    feerate                        BINARY_DOUBLE,
    feeamt                         BINARY_DOUBLE,
    deltd                          VARCHAR2(1 BYTE) DEFAULT 'N',
    lastchange                     TIMESTAMP (6) DEFAULT to_date('0001-01-01 00:00:00', 'YYYY-MM-DD hh24:mi:ss'),
    swid                           VARCHAR2(50 BYTE),
    moveqtty                       BINARY_DOUBLE DEFAULT 0,
    begindate                      DATE)
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE taipo
/

CREATE TABLE taipo
    (ipoid                          VARCHAR2(20 BYTE) NOT NULL,
    codeid                         VARCHAR2(10 BYTE),
    symbol                         VARCHAR2(10 BYTE),
    iponame                        VARCHAR2(500 BYTE),
    maxccq                         BINARY_DOUBLE,
    minccq                         BINARY_DOUBLE,
    minqtty                        BINARY_DOUBLE,
    rndrule                        BINARY_DOUBLE,
    frgrate                        BINARY_DOUBLE,
    bankacctno                     VARCHAR2(20 BYTE),
    bankacctname                   VARCHAR2(200 BYTE),
    bankcode                       VARCHAR2(20 BYTE),
    estavl                         BINARY_DOUBLE,
    rlavl                          BINARY_DOUBLE,
    cntiv                          BINARY_DOUBLE,
    minamt                         BINARY_DOUBLE,
    price                          BINARY_DOUBLE,
    parvalue                       BINARY_DOUBLE,
    matchrule                      VARCHAR2(1 BYTE),
    feerate                        BINARY_DOUBLE,
    feeinout                       VARCHAR2(1 BYTE),
    frdate                         DATE,
    todate                         DATE,
    execdate                       DATE,
    execrule                       VARCHAR2(1 BYTE),
    status                         VARCHAR2(10 BYTE) DEFAULT 'P',
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6),
    licenseno                      VARCHAR2(50 BYTE),
    licensedate                    DATE,
    licenseplace                   VARCHAR2(200 BYTE),
    name                           VARCHAR2(500 BYTE),
    name_en                        VARCHAR2(500 BYTE),
    phone                          VARCHAR2(50 BYTE),
    fax                            VARCHAR2(50 BYTE),
    ccycd                          VARCHAR2(50 BYTE),
    address                        VARCHAR2(200 BYTE),
    feeipo                         BINARY_DOUBLE,
    ipolicenceno                   VARCHAR2(50 BYTE),
    ipoiddate                      DATE,
    ipostatus                      VARCHAR2(10 BYTE),
    ipoplace                       VARCHAR2(200 BYTE),
    odprocess                      VARCHAR2(20 BYTE))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

ALTER TABLE taipo
ADD CONSTRAINT taipo_id_pk PRIMARY KEY (ipoid)
USING INDEX
/

DROP TABLE taipomembers
/

CREATE TABLE taipomembers
    (id                             FLOAT(64) NOT NULL,
    codeid                         VARCHAR2(10 BYTE),
    symbol                         VARCHAR2(10 BYTE),
    mbid                           VARCHAR2(10 BYTE),
    rolecode                       VARCHAR2(10 BYTE),
    status                         VARCHAR2(10 BYTE) DEFAULT 'P',
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6),
    bankacctno                     VARCHAR2(20 BYTE),
    bankacctname                   VARCHAR2(200 BYTE),
    bankcode                       VARCHAR2(20 BYTE),
    mbname                         VARCHAR2(100 BYTE),
    pname                          VARCHAR2(100 BYTE),
    pphone                         VARCHAR2(20 BYTE),
    bankname                       VARCHAR2(100 BYTE),
    notes                          VARCHAR2(200 BYTE))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

ALTER TABLE taipomembers
ADD CONSTRAINT taipomembers_pkey PRIMARY KEY (id)
USING INDEX
/

DROP TABLE taipomemo
/

CREATE TABLE taipomemo
    (ipoid                          VARCHAR2(20 BYTE),
    codeid                         FLOAT(64),
    symbol                         VARCHAR2(10 BYTE),
    iponame                        VARCHAR2(500 BYTE),
    maxccq                         BINARY_DOUBLE,
    minccq                         BINARY_DOUBLE,
    minqtty                        BINARY_DOUBLE,
    rndrule                        BINARY_DOUBLE,
    frgrate                        BINARY_DOUBLE,
    bankacctno                     VARCHAR2(20 BYTE),
    bankacctname                   VARCHAR2(200 BYTE),
    bankcode                       VARCHAR2(20 BYTE),
    estavl                         BINARY_DOUBLE,
    rlavl                          BINARY_DOUBLE,
    cntiv                          BINARY_DOUBLE,
    minamt                         BINARY_DOUBLE,
    price                          BINARY_DOUBLE,
    parvalue                       BINARY_DOUBLE,
    matchrule                      VARCHAR2(1 BYTE),
    feerate                        BINARY_DOUBLE,
    feeinout                       VARCHAR2(1 BYTE),
    frdate                         TIMESTAMP (6),
    todate                         TIMESTAMP (6),
    execdate                       TIMESTAMP (6),
    execrule                       VARCHAR2(1 BYTE),
    status                         VARCHAR2(1 BYTE),
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6),
    licenseno                      VARCHAR2(50 BYTE),
    licensedate                    TIMESTAMP (6),
    licenseplace                   VARCHAR2(200 BYTE),
    name                           VARCHAR2(500 BYTE),
    name_en                        VARCHAR2(500 BYTE),
    phone                          VARCHAR2(50 BYTE),
    fax                            VARCHAR2(50 BYTE),
    ccycd                          VARCHAR2(50 BYTE))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE taivallocate
/

CREATE TABLE taivallocate
    (autoid                         FLOAT(64) NOT NULL,
    codeid                         FLOAT(64),
    symbol                         VARCHAR2(10 BYTE),
    exectype                       VARCHAR2(10 BYTE),
    isallocateavg                  VARCHAR2(1 BYTE),
    allocaterule                   VARCHAR2(5 BYTE),
    status                         VARCHAR2(1 BYTE),
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

ALTER TABLE taivallocate
ADD CONSTRAINT taivallocate_pkey PRIMARY KEY (autoid)
USING INDEX
/

DROP TABLE taquote
/

CREATE TABLE taquote
    (quoteid                        VARCHAR2(20 BYTE) NOT NULL,
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
    halt                           VARCHAR2(1 BYTE) DEFAULT 'N',
    wsname                         VARCHAR2(50 BYTE),
    ipaddress                      VARCHAR2(50 BYTE),
    orstatus                       VARCHAR2(3 BYTE) DEFAULT '1',
    objname                        VARCHAR2(100 BYTE),
    feedbackmsg                    VARCHAR2(4000 BYTE),
    txtime                         VARCHAR2(200 BYTE),
    saleacctno                     VARCHAR2(30 BYTE),
    tradingdate                    DATE,
    vsdorderid                     VARCHAR2(100 BYTE))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

CREATE INDEX taquote_custodycd_idx ON taquote
  (
    custodycd                       ASC
  )
NOPARALLEL
NOLOGGING
/


ALTER TABLE taquote
ADD CONSTRAINT taquote_quoteid_pk PRIMARY KEY (quoteid)
USING INDEX
/

DROP TABLE taquotehist
/

CREATE TABLE taquotehist
    (quoteid                        VARCHAR2(20 BYTE) NOT NULL,
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
    halt                           VARCHAR2(1 BYTE) DEFAULT 'N',
    wsname                         VARCHAR2(50 BYTE),
    ipaddress                      VARCHAR2(50 BYTE),
    orstatus                       VARCHAR2(3 BYTE) DEFAULT '1',
    objname                        VARCHAR2(100 BYTE),
    feedbackmsg                    VARCHAR2(4000 BYTE),
    txtime                         VARCHAR2(200 BYTE),
    saleacctno                     VARCHAR2(30 BYTE),
    tradingdate                    DATE,
    vsdorderid                     VARCHAR2(100 BYTE))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

ALTER TABLE taquotehist
ADD CONSTRAINT taquote_taquotehist_pk PRIMARY KEY (quoteid)
USING INDEX
/

DROP TABLE taquoteotp
/

CREATE TABLE taquoteotp
    (autoid                         FLOAT(32) DEFAULT 0 NOT NULL,
    quoteid                        VARCHAR2(100 BYTE),
    ioiotp                         VARCHAR2(100 BYTE),
    ioiotptimestamp                TIMESTAMP (6),
    ioiotpconf                     CHAR(1 BYTE),
    afotp                          VARCHAR2(100 BYTE),
    afotptimestamp                 TIMESTAMP (6),
    afotpconf                      CHAR(1 BYTE),
    acbuyer                        VARCHAR2(20 BYTE),
    acseller                       VARCHAR2(20 BYTE))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

ALTER TABLE taquoteotp
ADD CONSTRAINT taquoteotp_pkey PRIMARY KEY (autoid)
USING INDEX
/

DROP TABLE tasip
/

CREATE TABLE tasip
    (spid                           VARCHAR2(20 BYTE) NOT NULL,
    spcode                         VARCHAR2(4 BYTE),
    spname                         VARCHAR2(200 BYTE),
    codeid                         VARCHAR2(20 BYTE),
    symbol                         VARCHAR2(20 BYTE),
    acctno                         VARCHAR2(20 BYTE),
    custodycd                      VARCHAR2(20 BYTE),
    frdate                         DATE,
    todate                         DATE,
    txdate                         DATE,
    txnum                          VARCHAR2(20 BYTE),
    amt                            BINARY_DOUBLE,
    minflamt                       BINARY_DOUBLE,
    maxflamt                       BINARY_DOUBLE,
    refautoid                      FLOAT(64),
    begindate                      DATE,
    regtype                        VARCHAR2(1 BYTE),
    noterm                         BINARY_DOUBLE,
    description                    VARCHAR2(500 BYTE),
    status                         VARCHAR2(1 BYTE),
    deltd                          VARCHAR2(1 BYTE),
    pstatus                        VARCHAR2(100 BYTE),
    feeid                          VARCHAR2(50 BYTE),
    penstatus                      VARCHAR2(1 BYTE) DEFAULT 'A',
    isenoughperiod                 VARCHAR2(10 BYTE),
    ver                            VARCHAR2(10 BYTE),
    lastchange                     TIMESTAMP (6),
    reqspid                        VARCHAR2(20 BYTE),
    tlid                           VARCHAR2(20 BYTE),
    username                       VARCHAR2(20 BYTE),
    txtime                         VARCHAR2(20 BYTE),
    exectype                       VARCHAR2(20 BYTE),
    srtype                         VARCHAR2(20 BYTE),
    objname                        VARCHAR2(100 BYTE),
    saleacctno                     VARCHAR2(100 BYTE),
    isexport                       CHAR(1 BYTE) DEFAULT 'N',
    vsdrefid                       VARCHAR2(100 BYTE),
    odconfirm                      VARCHAR2(1 BYTE) DEFAULT 'N')
  NOPARALLEL
  NOLOGGING
  MONITORING
/

ALTER TABLE tasip
ADD CONSTRAINT tasip_spid_pk PRIMARY KEY (spid)
USING INDEX
/

DROP TABLE tasipaction
/

CREATE TABLE tasipaction
    (autoid                         FLOAT(64) NOT NULL,
    spid                           VARCHAR2(20 BYTE),
    spcode                         VARCHAR2(4 BYTE),
    spname                         VARCHAR2(200 BYTE),
    codeid                         VARCHAR2(20 BYTE),
    symbol                         VARCHAR2(20 BYTE),
    acctno                         VARCHAR2(40 BYTE),
    custodycd                      VARCHAR2(10 BYTE),
    frdate                         DATE,
    todate                         DATE,
    begindate                      DATE,
    txdate                         DATE,
    txnum                          VARCHAR2(20 BYTE),
    actiontype                     VARCHAR2(1 BYTE),
    halttype                       VARCHAR2(1 BYTE),
    description                    VARCHAR2(500 BYTE),
    status                         VARCHAR2(1 BYTE),
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

ALTER TABLE tasipaction
ADD CONSTRAINT tasipaction_pkey PRIMARY KEY (autoid)
USING INDEX
/

DROP TABLE tasipcv
/

CREATE TABLE tasipcv
    (symbol                         VARCHAR2(20 BYTE),
    acctno                         VARCHAR2(20 BYTE),
    siptype                        VARCHAR2(10 BYTE))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE tasipdef
/

CREATE TABLE tasipdef
    (spcode                         VARCHAR2(4 BYTE) NOT NULL,
    spname                         VARCHAR2(200 BYTE),
    codeid                         VARCHAR2(10 BYTE),
    frdate                         DATE,
    todate                         DATE,
    ishalt                         VARCHAR2(1 BYTE),
    methods                        VARCHAR2(10 BYTE),
    minamt                         BINARY_DOUBLE,
    maxamt                         BINARY_DOUBLE,
    minterm                        FLOAT(64),
    maxterm                        FLOAT(64),
    status                         VARCHAR2(1 BYTE) DEFAULT 'P',
    pstatus                        VARCHAR2(4000 BYTE),
    ver                            VARCHAR2(100 BYTE),
    description                    VARCHAR2(500 BYTE),
    lastchange                     TIMESTAMP (6),
    vsdspcode                      VARCHAR2(100 BYTE),
    vsdspcodesip                   VARCHAR2(100 BYTE),
    bankacctno                     VARCHAR2(20 BYTE),
    bankacctnosip                  VARCHAR2(20 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

ALTER TABLE tasipdef
ADD CONSTRAINT tasipdef_pkey PRIMARY KEY (spcode)
USING INDEX
/

DROP TABLE tasiperr
/

CREATE TABLE tasiperr
    (autoid                         FLOAT(32) DEFAULT 0 NOT NULL,
    refautoid                      FLOAT(64),
    istermcont                     VARCHAR2(1 BYTE),
    termcont                       FLOAT(64),
    isdiscont                      VARCHAR2(1 BYTE),
    termdiscont                    FLOAT(64),
    istotalterm                    VARCHAR2(1 BYTE),
    totalterm                      FLOAT(64),
    status                         VARCHAR2(1 BYTE) DEFAULT 'P',
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6),
    des                            VARCHAR2(500 BYTE))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

ALTER TABLE tasiperr
ADD CONSTRAINT tasiperr_pkey PRIMARY KEY (autoid)
USING INDEX
/

DROP TABLE tasipreq
/

CREATE TABLE tasipreq
    (spid                           VARCHAR2(20 BYTE) NOT NULL,
    spcode                         VARCHAR2(4 BYTE),
    spname                         VARCHAR2(200 BYTE),
    codeid                         VARCHAR2(20 BYTE),
    symbol                         VARCHAR2(20 BYTE),
    acctno                         VARCHAR2(20 BYTE),
    custodycd                      VARCHAR2(10 BYTE),
    frdate                         DATE,
    todate                         DATE,
    txdate                         DATE,
    txnum                          VARCHAR2(10 BYTE),
    amt                            BINARY_DOUBLE,
    minflamt                       BINARY_DOUBLE,
    maxflamt                       BINARY_DOUBLE,
    refautoid                      BINARY_DOUBLE,
    begindate                      DATE,
    regtype                        VARCHAR2(1 BYTE),
    noterm                         BINARY_DOUBLE,
    description                    VARCHAR2(500 BYTE),
    status                         VARCHAR2(1 BYTE),
    deltd                          VARCHAR2(1 BYTE),
    pstatus                        VARCHAR2(100 BYTE),
    feeid                          VARCHAR2(50 BYTE),
    penstatus                      VARCHAR2(1 BYTE) DEFAULT 'A',
    isenoughperiod                 VARCHAR2(10 BYTE),
    ver                            VARCHAR2(10 BYTE),
    lastchange                     TIMESTAMP (6),
    refspid                        VARCHAR2(20 BYTE),
    orgspid                        VARCHAR2(20 BYTE),
    updatemode                     VARCHAR2(20 BYTE),
    tlid                           VARCHAR2(20 BYTE),
    username                       VARCHAR2(20 BYTE),
    wsname                         VARCHAR2(50 BYTE),
    ipaddress                      VARCHAR2(50 BYTE),
    objname                        VARCHAR2(20 BYTE),
    txtime                         VARCHAR2(20 BYTE),
    exectype                       VARCHAR2(20 BYTE),
    srtype                         VARCHAR2(20 BYTE),
    saleacctno                     VARCHAR2(100 BYTE),
    feedbackmsg                    VARCHAR2(4000 BYTE))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

ALTER TABLE tasipreq
ADD CONSTRAINT tasipreq_spid_pk PRIMARY KEY (spid)
USING INDEX
/

DROP TABLE tasipreqhist
/

CREATE TABLE tasipreqhist
    (spid                           VARCHAR2(20 BYTE),
    spcode                         VARCHAR2(4 BYTE),
    spname                         VARCHAR2(200 BYTE),
    codeid                         VARCHAR2(20 BYTE),
    symbol                         VARCHAR2(20 BYTE),
    acctno                         VARCHAR2(20 BYTE),
    custodycd                      VARCHAR2(10 BYTE),
    frdate                         DATE,
    todate                         DATE,
    txdate                         DATE,
    txnum                          VARCHAR2(10 BYTE),
    amt                            BINARY_DOUBLE,
    minflamt                       BINARY_DOUBLE,
    maxflamt                       BINARY_DOUBLE,
    refautoid                      BINARY_DOUBLE,
    begindate                      DATE,
    regtype                        VARCHAR2(1 BYTE),
    noterm                         BINARY_DOUBLE,
    description                    VARCHAR2(500 BYTE),
    status                         VARCHAR2(1 BYTE),
    deltd                          VARCHAR2(1 BYTE),
    pstatus                        VARCHAR2(100 BYTE),
    feeid                          VARCHAR2(50 BYTE),
    penstatus                      VARCHAR2(1 BYTE),
    isenoughperiod                 VARCHAR2(10 BYTE),
    ver                            VARCHAR2(10 BYTE),
    lastchange                     TIMESTAMP (6),
    refspid                        VARCHAR2(20 BYTE),
    orgspid                        VARCHAR2(20 BYTE),
    updatemode                     VARCHAR2(20 BYTE),
    tlid                           VARCHAR2(20 BYTE),
    username                       VARCHAR2(20 BYTE),
    wsname                         VARCHAR2(50 BYTE),
    ipaddress                      VARCHAR2(50 BYTE),
    objname                        VARCHAR2(20 BYTE),
    txtime                         VARCHAR2(20 BYTE),
    exectype                       VARCHAR2(20 BYTE),
    srtype                         VARCHAR2(20 BYTE),
    saleacctno                     VARCHAR2(100 BYTE),
    feedbackmsg                    VARCHAR2(4000 BYTE))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE taswitch
/

CREATE TABLE taswitch
    (swid                           VARCHAR2(20 BYTE),
    acctno                         VARCHAR2(20 BYTE),
    frcodeid                       VARCHAR2(20 BYTE),
    frfeeid                        VARCHAR2(20 BYTE),
    tocodeid                       VARCHAR2(20 BYTE),
    frsymbol                       VARCHAR2(100 BYTE),
    tosymbol                       VARCHAR2(100 BYTE),
    feeid                          VARCHAR2(10 BYTE),
    qtty                           BINARY_DOUBLE,
    iscont                         VARCHAR2(1 BYTE),
    txdate                         DATE,
    description                    VARCHAR2(500 BYTE),
    status                         VARCHAR2(1 BYTE),
    pstatus                        VARCHAR2(100 BYTE),
    lastchange                     TIMESTAMP (6),
    custodycd                      VARCHAR2(10 BYTE),
    orderid                        VARCHAR2(30 BYTE),
    matchamt                       BINARY_DOUBLE,
    matchqtty                      BINARY_DOUBLE,
    sedtlid                        BINARY_DOUBLE)
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE tbl_acctno_updating
/

CREATE TABLE tbl_acctno_updating
    (acctno                         VARCHAR2(30 BYTE) NOT NULL,
    updatetype                     VARCHAR2(20 BYTE) NOT NULL,
    createdate                     TIMESTAMP (6))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

ALTER TABLE tbl_acctno_updating
ADD CONSTRAINT tbl_acctno_updating_pkey PRIMARY KEY (updatetype, acctno)
USING INDEX
/

DROP TABLE tbl_closesession_info
/

CREATE TABLE tbl_closesession_info
    (autoid                         FLOAT(32) DEFAULT 0 NOT NULL,
    symbol                         VARCHAR2(100 BYTE),
    tradingid                      VARCHAR2(250 BYTE),
    txdate                         DATE,
    db_time                        TIMESTAMP (6),
    sy_time                        TIMESTAMP (6),
    fund_closetime                 TIMESTAMP (6))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE tbl_closesession_info_hist
/

CREATE TABLE tbl_closesession_info_hist
    (autoid                         FLOAT(32) DEFAULT 0 NOT NULL,
    symbol                         VARCHAR2(100 BYTE),
    tradingid                      VARCHAR2(250 BYTE),
    txdate                         DATE,
    db_time                        TIMESTAMP (6),
    sy_time                        TIMESTAMP (6),
    fund_closetime                 TIMESTAMP (6))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE tbl_cron_job1
/

CREATE TABLE tbl_cron_job1
    (id                             FLOAT(32) DEFAULT 0 NOT NULL,
    content                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE tbl_cron_job2
/

CREATE TABLE tbl_cron_job2
    (id                             FLOAT(32) DEFAULT 0 NOT NULL,
    content                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE tbl_cronjobb
/

CREATE TABLE tbl_cronjobb
    (id                             FLOAT(32),
    name                           VARCHAR2(50 BYTE),
    begin                          VARCHAR2(100 BYTE),
    "end"                          VARCHAR2(50 BYTE),
    action                         VARCHAR2(10 BYTE),
    status                         FLOAT(126),
    feq                            VARCHAR2(200 BYTE))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE tbl_fldvals
/

CREATE TABLE tbl_fldvals
    (datetime                       TIMESTAMP (6),
    objname                        VARCHAR2(80 BYTE),
    postmap                        VARCHAR2(4000 BYTE))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE tbl_lock_key_updating
/

CREATE TABLE tbl_lock_key_updating
    (lock_key                       VARCHAR2(4000 BYTE) NOT NULL,
    tltxcd                         VARCHAR2(100 BYTE) NOT NULL,
    txdate                         DATE,
    txnum                          VARCHAR2(50 BYTE),
    createdate                     TIMESTAMP (6) DEFAULT to_date('0001-01-01 00:00:00', 'YYYY-MM-DD hh24:mi:ss'))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

ALTER TABLE tbl_lock_key_updating
ADD CONSTRAINT tbl_lock_key_updating_pkey PRIMARY KEY (tltxcd, lock_key)
USING INDEX
/

DROP TABLE tbl_logsendemail
/

CREATE TABLE tbl_logsendemail
    (id                             FLOAT(32) DEFAULT 0 NOT NULL,
    refid                          VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE tbl_objectmaster
/

CREATE TABLE tbl_objectmaster
    (datetime                       TIMESTAMP (6),
    objname                        VARCHAR2(80 BYTE),
    postmap                        VARCHAR2(4000 BYTE))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE tbl_postmap
/

CREATE TABLE tbl_postmap
    (datetime                       TIMESTAMP (6),
    tltxcd                         CHAR(4 BYTE),
    postmap                        VARCHAR2(4000 BYTE))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE tbl_schedulerjobs
/

CREATE TABLE tbl_schedulerjobs
    (job_id                         FLOAT(32) DEFAULT 0 NOT NULL,
    job_name                       VARCHAR2(200 BYTE),
    job_type                       VARCHAR2(200 BYTE),
    job_creator                    VARCHAR2(200 BYTE),
    job_action                     VARCHAR2(200 BYTE),
    job_startdate                  TIMESTAMP (6),
    job_lastrundate                TIMESTAMP (6),
    job_nextrundate                TIMESTAMP (6),
    job_frequency                  VARCHAR2(200 BYTE),
    job_interval                   BINARY_DOUBLE,
    job_anable                     FLOAT(126),
    job_priority                   BINARY_DOUBLE,
    job_runcount                   BINARY_DOUBLE,
    job_comments                   VARCHAR2(4000 BYTE),
    job_intervalvalue              VARCHAR2(20 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE tbl_schedulerjobs_log
/

CREATE TABLE tbl_schedulerjobs_log
    (job_id                         FLOAT(32) DEFAULT 0 NOT NULL,
    job_name                       VARCHAR2(200 BYTE),
    job_action                     VARCHAR2(200 BYTE),
    job_lastrundate                TIMESTAMP (6),
    job_nextrundate                TIMESTAMP (6),
    job_frequency                  VARCHAR2(200 BYTE),
    job_interval                   BINARY_DOUBLE)
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE tbl_testjob
/

CREATE TABLE tbl_testjob
    (id                             FLOAT(32),
    name                           VARCHAR2(50 BYTE))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE tbl_testjob1
/

CREATE TABLE tbl_testjob1
    (id                             FLOAT(32),
    name                           VARCHAR2(50 BYTE))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE tbl_transaction_updating
/

CREATE TABLE tbl_transaction_updating
    (txdate                         DATE NOT NULL,
    txnum                          VARCHAR2(30 BYTE) NOT NULL,
    tltxcd                         VARCHAR2(20 BYTE),
    createdate                     TIMESTAMP (6))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

ALTER TABLE tbl_transaction_updating
ADD CONSTRAINT tbl_transaction_updating_pkey PRIMARY KEY (txnum, txdate)
USING INDEX
/

DROP TABLE tbl_txpks
/

CREATE TABLE tbl_txpks
    (datetime                       TIMESTAMP (6),
    tltxcd                         CHAR(4 BYTE),
    postmap                        CLOB)
  SEGMENT CREATION IMMEDIATE
  LOB ("POSTMAP") STORE AS SECUREFILE SYS_LOB0000076500C00003$$
  (
   NOCACHE NOLOGGING
   CHUNK 8192
  )
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE tblbackup
/

CREATE TABLE tblbackup
    (frtable                        VARCHAR2(50 BYTE),
    totable                        VARCHAR2(50 BYTE),
    typbk                          VARCHAR2(1 BYTE) DEFAULT 'T')
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE tblcf_dlpp
/

CREATE TABLE tblcf_dlpp
    (autoid                         FLOAT(32) DEFAULT 0 NOT NULL,
    ver                            VARCHAR2(50 BYTE),
    objname                        VARCHAR2(50 BYTE),
    tlid                           VARCHAR2(20 BYTE),
    offid                          VARCHAR2(20 BYTE),
    deltd                          VARCHAR2(1 BYTE) DEFAULT 'N',
    status                         VARCHAR2(20 BYTE) DEFAULT 'P',
    errmsg                         VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6) DEFAULT to_date('0001-01-01 00:00:00', 'YYYY-MM-DD hh24:mi:ss'),
    fileid                         VARCHAR2(30 BYTE),
    mbid                           VARCHAR2(30 BYTE),
    custodycd                      VARCHAR2(20 BYTE),
    fullname                       VARCHAR2(500 BYTE),
    acctype                        VARCHAR2(20 BYTE),
    custtype                       VARCHAR2(20 BYTE),
    grinvest                       VARCHAR2(20 BYTE),
    sex                            VARCHAR2(1 BYTE),
    birthdate                      DATE,
    idtype                         VARCHAR2(10 BYTE),
    idcode                         VARCHAR2(50 BYTE),
    iddate                         DATE,
    idexpdated                     DATE,
    idplace                        VARCHAR2(200 BYTE),
    tradingcode                    VARCHAR2(50 BYTE),
    tradingdate                    DATE,
    taxno                          VARCHAR2(50 BYTE),
    regaddress                     VARCHAR2(500 BYTE),
    address                        VARCHAR2(500 BYTE),
    country                        VARCHAR2(30 BYTE),
    province                       VARCHAR2(30 BYTE),
    phone                          VARCHAR2(30 BYTE),
    mobile                         VARCHAR2(30 BYTE),
    email                          VARCHAR2(100 BYTE),
    dbcode                         VARCHAR2(30 BYTE),
    bankacc                        VARCHAR2(30 BYTE),
    bankcode                       VARCHAR2(30 BYTE),
    citybank                       VARCHAR2(300 BYTE),
    bankaccname                    VARCHAR2(300 BYTE),
    openvia                        VARCHAR2(30 BYTE),
    careby                         VARCHAR2(30 BYTE),
    saleid                         VARCHAR2(30 BYTE),
    fatca1                         VARCHAR2(30 BYTE),
    fatca2                         VARCHAR2(30 BYTE),
    fatca3                         VARCHAR2(30 BYTE),
    fatca4                         VARCHAR2(30 BYTE),
    fatca5                         VARCHAR2(30 BYTE),
    fatca6                         VARCHAR2(30 BYTE),
    fatca7                         VARCHAR2(30 BYTE),
    isonline                       VARCHAR2(1 BYTE) DEFAULT 'N',
    des                            VARCHAR2(500 BYTE),
    isotpchk                       VARCHAR2(1 BYTE) DEFAULT 'N',
    grinvestor                     VARCHAR2(10 BYTE),
    bankacname                     VARCHAR2(200 BYTE),
    passport                       VARCHAR2(20 BYTE),
    isfatca                        VARCHAR2(1 BYTE) DEFAULT 'N',
    isauth                         VARCHAR2(1 BYTE) DEFAULT 'N',
    authname                       VARCHAR2(200 BYTE),
    authidcode                     VARCHAR2(20 BYTE),
    authiddate                     DATE,
    authidplace                    VARCHAR2(200 BYTE),
    authphone                      VARCHAR2(50 BYTE),
    authaddress                    VARCHAR2(200 BYTE),
    authefdate                     DATE,
    authexdate                     DATE,
    linkauth                       VARCHAR2(20 BYTE))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE tblcf_dlpp_log
/

CREATE TABLE tblcf_dlpp_log
    (autoid                         FLOAT(64) NOT NULL,
    ver                            VARCHAR2(50 BYTE),
    objname                        VARCHAR2(50 BYTE),
    tlid                           VARCHAR2(20 BYTE),
    offid                          VARCHAR2(20 BYTE),
    deltd                          VARCHAR2(1 BYTE) DEFAULT 'N',
    status                         VARCHAR2(20 BYTE) DEFAULT 'P',
    errmsg                         VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6) DEFAULT to_date('0001-01-01 00:00:00', 'YYYY-MM-DD hh24:mi:ss'),
    fileid                         VARCHAR2(30 BYTE),
    mbid                           VARCHAR2(30 BYTE),
    custodycd                      VARCHAR2(20 BYTE),
    fullname                       VARCHAR2(500 BYTE),
    acctype                        VARCHAR2(20 BYTE),
    custtype                       VARCHAR2(20 BYTE),
    grinvest                       VARCHAR2(20 BYTE),
    sex                            VARCHAR2(1 BYTE),
    birthdate                      DATE,
    idtype                         VARCHAR2(10 BYTE),
    idcode                         VARCHAR2(50 BYTE),
    iddate                         DATE,
    idexpdated                     DATE,
    idplace                        VARCHAR2(200 BYTE),
    tradingcode                    VARCHAR2(50 BYTE),
    tradingdate                    DATE,
    taxno                          VARCHAR2(50 BYTE),
    regaddress                     VARCHAR2(500 BYTE),
    address                        VARCHAR2(500 BYTE),
    country                        VARCHAR2(30 BYTE),
    province                       VARCHAR2(30 BYTE),
    phone                          VARCHAR2(30 BYTE),
    mobile                         VARCHAR2(30 BYTE),
    email                          VARCHAR2(100 BYTE),
    dbcode                         VARCHAR2(30 BYTE),
    bankacc                        VARCHAR2(30 BYTE),
    bankcode                       VARCHAR2(30 BYTE),
    citybank                       VARCHAR2(300 BYTE),
    bankaccname                    VARCHAR2(300 BYTE),
    openvia                        VARCHAR2(30 BYTE),
    careby                         VARCHAR2(30 BYTE),
    saleid                         VARCHAR2(30 BYTE),
    fatca1                         VARCHAR2(30 BYTE),
    fatca2                         VARCHAR2(30 BYTE),
    fatca3                         VARCHAR2(30 BYTE),
    fatca4                         VARCHAR2(30 BYTE),
    fatca5                         VARCHAR2(30 BYTE),
    fatca6                         VARCHAR2(30 BYTE),
    fatca7                         VARCHAR2(30 BYTE),
    isonline                       VARCHAR2(1 BYTE) DEFAULT 'N',
    des                            VARCHAR2(500 BYTE),
    isotpchk                       VARCHAR2(1 BYTE) DEFAULT 'N',
    grinvestor                     VARCHAR2(10 BYTE),
    bankacname                     VARCHAR2(200 BYTE),
    passport                       VARCHAR2(20 BYTE),
    isfatca                        VARCHAR2(1 BYTE) DEFAULT 'N',
    isauth                         VARCHAR2(1 BYTE) DEFAULT 'N',
    authname                       VARCHAR2(200 BYTE),
    authidcode                     VARCHAR2(20 BYTE),
    authiddate                     DATE,
    authidplace                    VARCHAR2(200 BYTE),
    authphone                      VARCHAR2(50 BYTE),
    authaddress                    VARCHAR2(200 BYTE),
    authefdate                     DATE,
    authexdate                     DATE,
    linkauth                       VARCHAR2(20 BYTE))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE tblcf2004
/

CREATE TABLE tblcf2004
    (autoid                         FLOAT(64) DEFAULT 0,
    txdate                         DATE,
    ver                            VARCHAR2(50 BYTE),
    objname                        VARCHAR2(50 BYTE),
    fullname                       VARCHAR2(500 BYTE),
    idtype                         VARCHAR2(50 BYTE),
    idcode                         VARCHAR2(50 BYTE),
    iddate                         DATE,
    idexpdated                     DATE,
    idplace                        VARCHAR2(500 BYTE),
    tradingcode                    VARCHAR2(50 BYTE),
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
    acctype                        VARCHAR2(10 BYTE),
    bankacc                        VARCHAR2(20 BYTE),
    bankcode                       VARCHAR2(20 BYTE),
    citybank                       VARCHAR2(500 BYTE),
    careby                         VARCHAR2(20 BYTE),
    tlid                           VARCHAR2(20 BYTE),
    offid                          VARCHAR2(20 BYTE),
    deltd                          VARCHAR2(1 BYTE) DEFAULT 'N',
    status                         VARCHAR2(20 BYTE) DEFAULT 'P',
    errmsg                         VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6) DEFAULT to_date('0001-01-01 00:00:00', 'YYYY-MM-DD hh24:mi:ss'),
    fileid                         VARCHAR2(30 BYTE),
    mbid                           VARCHAR2(30 BYTE),
    isonline                       VARCHAR2(3 BYTE),
    saletlname                     VARCHAR2(150 BYTE),
    acctno                         VARCHAR2(50 BYTE),
    txnum                          VARCHAR2(50 BYTE),
    amt                            BINARY_DOUBLE,
    des                            VARCHAR2(500 BYTE),
    isotpchk                       VARCHAR2(1 BYTE),
    reftxnum                       VARCHAR2(50 BYTE),
    reftxdate                      DATE,
    codeid                         VARCHAR2(50 BYTE),
    custodycd                      VARCHAR2(50 BYTE),
    saleid                         VARCHAR2(500 BYTE),
    taxplace                       VARCHAR2(200 BYTE),
    othercountry                   VARCHAR2(200 BYTE),
    phone                          VARCHAR2(50 BYTE),
    ispep                          VARCHAR2(1 BYTE),
    familyname1                    VARCHAR2(200 BYTE),
    name1                          VARCHAR2(200 BYTE),
    familyname2                    VARCHAR2(200 BYTE),
    name2                          VARCHAR2(200 BYTE),
    isfatca                        VARCHAR2(1 BYTE),
    job                            VARCHAR2(200 BYTE),
    workunit                       VARCHAR2(200 BYTE),
    mobilegt                       VARCHAR2(200 BYTE),
    tlidgt                         VARCHAR2(50 BYTE),
    cftype                         VARCHAR2(50 BYTE))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE tblcf2004_log
/

CREATE TABLE tblcf2004_log
    (autoid                         FLOAT(64),
    txdate                         DATE,
    ver                            VARCHAR2(50 BYTE),
    objname                        VARCHAR2(50 BYTE),
    fullname                       VARCHAR2(500 BYTE),
    idtype                         VARCHAR2(50 BYTE),
    idcode                         VARCHAR2(50 BYTE),
    iddate                         DATE,
    idexpdated                     DATE,
    idplace                        VARCHAR2(500 BYTE),
    tradingcode                    VARCHAR2(50 BYTE),
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
    acctype                        VARCHAR2(10 BYTE),
    bankacc                        VARCHAR2(20 BYTE),
    bankcode                       VARCHAR2(20 BYTE),
    citybank                       VARCHAR2(500 BYTE),
    careby                         VARCHAR2(20 BYTE),
    tlid                           VARCHAR2(20 BYTE),
    offid                          VARCHAR2(20 BYTE),
    deltd                          VARCHAR2(1 BYTE),
    status                         VARCHAR2(20 BYTE),
    errmsg                         VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6),
    fileid                         VARCHAR2(30 BYTE),
    mbid                           VARCHAR2(30 BYTE),
    isonline                       VARCHAR2(3 BYTE),
    saletlname                     VARCHAR2(150 BYTE),
    acctno                         VARCHAR2(50 BYTE),
    txnum                          VARCHAR2(50 BYTE),
    amt                            BINARY_DOUBLE,
    des                            VARCHAR2(500 BYTE),
    isotpchk                       VARCHAR2(1 BYTE),
    reftxnum                       VARCHAR2(50 BYTE),
    reftxdate                      DATE,
    codeid                         VARCHAR2(50 BYTE),
    custodycd                      VARCHAR2(50 BYTE),
    saleid                         VARCHAR2(500 BYTE),
    taxplace                       VARCHAR2(200 BYTE),
    othercountry                   VARCHAR2(200 BYTE),
    phone                          VARCHAR2(50 BYTE),
    ispep                          VARCHAR2(1 BYTE),
    familyname1                    VARCHAR2(200 BYTE),
    name1                          VARCHAR2(200 BYTE),
    familyname2                    VARCHAR2(200 BYTE),
    name2                          VARCHAR2(200 BYTE),
    isfatca                        VARCHAR2(1 BYTE),
    job                            VARCHAR2(200 BYTE),
    workunit                       VARCHAR2(200 BYTE),
    mobilegt                       VARCHAR2(200 BYTE),
    tlidgt                         VARCHAR2(50 BYTE),
    cftype                         VARCHAR2(50 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE tblcf2006
/

CREATE TABLE tblcf2006
    (autoid                         FLOAT(32) DEFAULT 0 NOT NULL,
    ver                            VARCHAR2(50 BYTE),
    objname                        VARCHAR2(50 BYTE),
    tlid                           VARCHAR2(20 BYTE),
    offid                          VARCHAR2(20 BYTE),
    deltd                          VARCHAR2(1 BYTE) DEFAULT 'N',
    status                         VARCHAR2(20 BYTE) DEFAULT 'P',
    errmsg                         VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6) DEFAULT to_date('0001-01-01 00:00:00', 'YYYY-MM-DD hh24:mi:ss'),
    fileid                         VARCHAR2(30 BYTE),
    mbid                           VARCHAR2(30 BYTE),
    custodycd                      VARCHAR2(20 BYTE),
    fullname                       VARCHAR2(500 BYTE),
    oldcare                        VARCHAR2(20 BYTE),
    newcare                        VARCHAR2(20 BYTE),
    des                            VARCHAR2(500 BYTE),
    isotpchk                       VARCHAR2(1 BYTE) DEFAULT 'N')
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE tblcf2006_log
/

CREATE TABLE tblcf2006_log
    (autoid                         FLOAT(32) DEFAULT 0 NOT NULL,
    ver                            VARCHAR2(50 BYTE),
    objname                        VARCHAR2(50 BYTE),
    tlid                           VARCHAR2(20 BYTE),
    offid                          VARCHAR2(20 BYTE),
    deltd                          VARCHAR2(1 BYTE) DEFAULT 'N',
    status                         VARCHAR2(20 BYTE) DEFAULT 'P',
    errmsg                         VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6) DEFAULT to_date('0001-01-01 00:00:00', 'YYYY-MM-DD hh24:mi:ss'),
    fileid                         VARCHAR2(30 BYTE),
    mbid                           VARCHAR2(30 BYTE),
    custodycd                      VARCHAR2(20 BYTE),
    fullname                       VARCHAR2(500 BYTE),
    oldcare                        VARCHAR2(20 BYTE),
    newcare                        VARCHAR2(20 BYTE),
    des                            VARCHAR2(500 BYTE),
    isotpchk                       VARCHAR2(1 BYTE) DEFAULT 'N')
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE tblcf2007
/

CREATE TABLE tblcf2007
    (autoid                         FLOAT(32) DEFAULT 0 NOT NULL,
    ver                            VARCHAR2(50 BYTE),
    objname                        VARCHAR2(50 BYTE),
    tlid                           VARCHAR2(20 BYTE),
    offid                          VARCHAR2(20 BYTE),
    deltd                          VARCHAR2(1 BYTE) DEFAULT 'N',
    status                         VARCHAR2(20 BYTE) DEFAULT 'P',
    errmsg                         VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6) DEFAULT to_date('0001-01-01 00:00:00', 'YYYY-MM-DD hh24:mi:ss'),
    fileid                         VARCHAR2(30 BYTE),
    mbid                           VARCHAR2(30 BYTE),
    custodycd                      VARCHAR2(20 BYTE),
    refacctno                      VARCHAR2(20 BYTE),
    des                            VARCHAR2(500 BYTE),
    isotpchk                       VARCHAR2(1 BYTE) DEFAULT 'N')
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE tblcf2008
/

CREATE TABLE tblcf2008
    (autoid                         FLOAT(32) DEFAULT 0 NOT NULL,
    ver                            VARCHAR2(50 BYTE),
    objname                        VARCHAR2(50 BYTE),
    tlid                           VARCHAR2(20 BYTE),
    offid                          VARCHAR2(20 BYTE),
    deltd                          VARCHAR2(1 BYTE) DEFAULT 'N',
    status                         VARCHAR2(20 BYTE) DEFAULT 'P',
    errmsg                         VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6) DEFAULT to_date('0001-01-01 00:00:00', 'YYYY-MM-DD hh24:mi:ss'),
    fileid                         VARCHAR2(30 BYTE),
    mbid                           VARCHAR2(30 BYTE),
    custodycd                      VARCHAR2(20 BYTE),
    fullname                       VARCHAR2(100 BYTE),
    reacctno                       VARCHAR2(20 BYTE),
    des                            VARCHAR2(500 BYTE),
    isotpchk                       VARCHAR2(1 BYTE) DEFAULT 'N')
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE tblcf2008_log
/

CREATE TABLE tblcf2008_log
    (autoid                         FLOAT(32) DEFAULT 0 NOT NULL,
    ver                            VARCHAR2(50 BYTE),
    objname                        VARCHAR2(50 BYTE),
    tlid                           VARCHAR2(20 BYTE),
    offid                          VARCHAR2(20 BYTE),
    deltd                          VARCHAR2(1 BYTE) DEFAULT 'N',
    status                         VARCHAR2(20 BYTE) DEFAULT 'P',
    errmsg                         VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6) DEFAULT to_date('0001-01-01 00:00:00', 'YYYY-MM-DD hh24:mi:ss'),
    fileid                         VARCHAR2(30 BYTE),
    mbid                           VARCHAR2(30 BYTE),
    custodycd                      VARCHAR2(20 BYTE),
    fullname                       VARCHAR2(100 BYTE),
    reacctno                       VARCHAR2(20 BYTE),
    des                            VARCHAR2(500 BYTE),
    isotpchk                       VARCHAR2(1 BYTE) DEFAULT 'N')
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE tblci1101
/

CREATE TABLE tblci1101
    (autoid                         FLOAT(32) DEFAULT 0 NOT NULL,
    ver                            VARCHAR2(50 BYTE),
    objname                        VARCHAR2(50 BYTE),
    tlid                           VARCHAR2(20 BYTE),
    offid                          VARCHAR2(20 BYTE),
    deltd                          VARCHAR2(1 BYTE) DEFAULT 'N',
    status                         VARCHAR2(20 BYTE) DEFAULT 'P',
    errmsg                         VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6) DEFAULT to_date('0001-01-01 00:00:00', 'YYYY-MM-DD hh24:mi:ss'),
    fileid                         VARCHAR2(30 BYTE),
    mbid                           VARCHAR2(30 BYTE),
    acctno                         VARCHAR2(20 BYTE),
    txnum                          VARCHAR2(150 BYTE),
    txdate                         DATE,
    amt                            BINARY_DOUBLE DEFAULT 0,
    des                            VARCHAR2(500 BYTE),
    isotpchk                       VARCHAR2(1 BYTE) DEFAULT 'N',
    reftxnum                       VARCHAR2(20 BYTE),
    reftxdate                      DATE,
    codeid                         VARCHAR2(50 BYTE),
    custodycd                      VARCHAR2(50 BYTE))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE tblci1101_log
/

CREATE TABLE tblci1101_log
    (autoid                         FLOAT(32) DEFAULT 0 NOT NULL,
    ver                            VARCHAR2(50 BYTE),
    objname                        VARCHAR2(50 BYTE),
    tlid                           VARCHAR2(20 BYTE),
    offid                          VARCHAR2(20 BYTE),
    deltd                          VARCHAR2(1 BYTE) DEFAULT 'N',
    status                         VARCHAR2(20 BYTE) DEFAULT 'P',
    errmsg                         VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6) DEFAULT to_date('0001-01-01 00:00:00', 'YYYY-MM-DD hh24:mi:ss'),
    fileid                         VARCHAR2(30 BYTE),
    mbid                           VARCHAR2(30 BYTE),
    acctno                         VARCHAR2(20 BYTE),
    txnum                          VARCHAR2(150 BYTE),
    txdate                         DATE,
    amt                            BINARY_DOUBLE DEFAULT 0,
    des                            VARCHAR2(500 BYTE),
    isotpchk                       VARCHAR2(1 BYTE) DEFAULT 'N',
    reftxnum                       VARCHAR2(20 BYTE),
    reftxdate                      DATE,
    codeid                         VARCHAR2(50 BYTE),
    custodycd                      VARCHAR2(50 BYTE))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE tbliv062
/

CREATE TABLE tbliv062
    (autoid                         FLOAT(32) DEFAULT 0 NOT NULL,
    ver                            VARCHAR2(50 BYTE),
    objname                        VARCHAR2(50 BYTE),
    tlid                           VARCHAR2(20 BYTE),
    offid                          VARCHAR2(20 BYTE),
    deltd                          VARCHAR2(1 BYTE) DEFAULT 'N',
    status                         VARCHAR2(20 BYTE) DEFAULT 'P',
    errmsg                         VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6) DEFAULT to_date('0001-01-01 00:00:00', 'YYYY-MM-DD hh24:mi:ss'),
    fileid                         VARCHAR2(30 BYTE),
    mbid                           VARCHAR2(30 BYTE),
    dealtype                       VARCHAR2(20 BYTE),
    symbol                         VARCHAR2(200 BYTE),
    orgamt                         BINARY_DOUBLE DEFAULT 0,
    amount                         BINARY_DOUBLE DEFAULT 0,
    content                        VARCHAR2(4000 BYTE),
    tradingdate                    DATE,
    transid                        VARCHAR2(20 BYTE),
    bankaccount                    VARCHAR2(50 BYTE),
    transdate                      DATE,
    isotpchk                       VARCHAR2(1 BYTE) DEFAULT 'N',
    custodycd                      VARCHAR2(20 BYTE),
    codeid                         VARCHAR2(20 BYTE),
    srtype                         VARCHAR2(2 BYTE))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE tbliv062_log
/

CREATE TABLE tbliv062_log
    (autoid                         FLOAT(64) NOT NULL,
    ver                            VARCHAR2(50 BYTE),
    objname                        VARCHAR2(50 BYTE),
    tlid                           VARCHAR2(20 BYTE),
    offid                          VARCHAR2(20 BYTE),
    deltd                          VARCHAR2(1 BYTE) DEFAULT 'N',
    status                         VARCHAR2(20 BYTE) DEFAULT 'P',
    errmsg                         VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6) DEFAULT to_date('0001-01-01 00:00:00', 'YYYY-MM-DD hh24:mi:ss'),
    fileid                         VARCHAR2(30 BYTE),
    mbid                           VARCHAR2(30 BYTE),
    dealtype                       VARCHAR2(20 BYTE),
    symbol                         VARCHAR2(200 BYTE),
    orgamt                         BINARY_DOUBLE DEFAULT 0,
    amount                         BINARY_DOUBLE DEFAULT 0,
    content                        VARCHAR2(4000 BYTE),
    tradingdate                    DATE,
    transid                        VARCHAR2(20 BYTE),
    bankaccount                    VARCHAR2(50 BYTE),
    transdate                      DATE,
    isotpchk                       VARCHAR2(1 BYTE) DEFAULT 'N',
    custodycd                      VARCHAR2(20 BYTE),
    codeid                         VARCHAR2(20 BYTE),
    srtype                         VARCHAR2(2 BYTE))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE tblod5001
/

CREATE TABLE tblod5001
    (autoid                         FLOAT(32) DEFAULT 0 NOT NULL,
    fileid                         VARCHAR2(50 BYTE),
    dbcode                         VARCHAR2(10 BYTE),
    custodycd                      VARCHAR2(50 BYTE),
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
    imptlid                        VARCHAR2(10 BYTE),
    apprtlid                       VARCHAR2(10 BYTE),
    mbid                           VARCHAR2(10 BYTE),
    deltd                          VARCHAR2(1 BYTE),
    status                         VARCHAR2(1 BYTE) DEFAULT 'N',
    errmsg                         VARCHAR2(500 BYTE),
    objname                        VARCHAR2(200 BYTE),
    ver                            VARCHAR2(200 BYTE),
    isotpchk                       VARCHAR2(1 BYTE) DEFAULT 'Y',
    lastchange                     TIMESTAMP (6),
    dealtype                       VARCHAR2(20 BYTE))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE tblod5001_log
/

CREATE TABLE tblod5001_log
    (autoid                         FLOAT(32) DEFAULT 0 NOT NULL,
    fileid                         VARCHAR2(50 BYTE),
    dbcode                         VARCHAR2(10 BYTE),
    custodycd                      VARCHAR2(50 BYTE),
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
    imptlid                        VARCHAR2(10 BYTE),
    apprtlid                       VARCHAR2(10 BYTE),
    mbid                           VARCHAR2(10 BYTE),
    deltd                          VARCHAR2(1 BYTE),
    status                         VARCHAR2(1 BYTE) DEFAULT 'N',
    errmsg                         VARCHAR2(500 BYTE),
    objname                        VARCHAR2(200 BYTE),
    ver                            VARCHAR2(200 BYTE),
    isotpchk                       VARCHAR2(1 BYTE) DEFAULT 'Y',
    lastchange                     TIMESTAMP (6),
    dealtype                       VARCHAR2(20 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE tblr39
/

CREATE TABLE tblr39
    (autoid                         FLOAT(64) DEFAULT 0 NOT NULL,
    impdate                        DATE,
    ver                            VARCHAR2(50 BYTE),
    objname                        VARCHAR2(50 BYTE),
    fileid                         VARCHAR2(30 BYTE),
    mbid                           VARCHAR2(30 BYTE),
    orderid                        VARCHAR2(50 BYTE),
    exectype                       VARCHAR2(100 BYTE),
    dealtypecode                   VARCHAR2(100 BYTE),
    dealtype                       VARCHAR2(250 BYTE),
    fullname                       VARCHAR2(4000 BYTE),
    custodycd                      VARCHAR2(30 BYTE),
    actype                         VARCHAR2(250 BYTE),
    actype_code                    VARCHAR2(250 BYTE),
    orderamt                       BINARY_DOUBLE DEFAULT 0,
    orderqtty                      BINARY_DOUBLE DEFAULT 0,
    matchqtty                      BINARY_DOUBLE DEFAULT 0,
    orderamt9                      BINARY_DOUBLE DEFAULT 0,
    orderqtty9                     BINARY_DOUBLE DEFAULT 0,
    txdate                         DATE,
    tradingdate                    DATE,
    status                         VARCHAR2(250 BYTE),
    bankname                       VARCHAR2(500 BYTE),
    citybank                       VARCHAR2(500 BYTE),
    bankacc                        VARCHAR2(50 BYTE),
    bankacname                     VARCHAR2(50 BYTE),
    reason                         VARCHAR2(4000 BYTE),
    tradingid                      VARCHAR2(50 BYTE),
    symbol                         VARCHAR2(50 BYTE),
    name                           VARCHAR2(500 BYTE),
    feeid                          VARCHAR2(100 BYTE),
    feename                        VARCHAR2(250 BYTE),
    tlid                           VARCHAR2(20 BYTE),
    offid                          VARCHAR2(20 BYTE),
    deltd                          VARCHAR2(1 BYTE) DEFAULT 'N',
    impstatus                      VARCHAR2(20 BYTE) DEFAULT 'P',
    cancelstatus                   VARCHAR2(20 BYTE) DEFAULT 'N',
    errmsg                         VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6) DEFAULT to_date('0001-01-01 00:00:00', 'YYYY-MM-DD hh24:mi:ss'),
    createdate                     TIMESTAMP (6),
    odstatus                       VARCHAR2(10 BYTE))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE tblr39_log
/

CREATE TABLE tblr39_log
    (autoid                         FLOAT(64) DEFAULT 0 NOT NULL,
    impdate                        DATE,
    ver                            VARCHAR2(50 BYTE),
    objname                        VARCHAR2(50 BYTE),
    fileid                         VARCHAR2(30 BYTE),
    mbid                           VARCHAR2(30 BYTE),
    orderid                        VARCHAR2(50 BYTE),
    exectype                       VARCHAR2(100 BYTE),
    dealtypecode                   VARCHAR2(100 BYTE),
    dealtype                       VARCHAR2(250 BYTE),
    fullname                       VARCHAR2(4000 BYTE),
    custodycd                      VARCHAR2(30 BYTE),
    actype                         VARCHAR2(250 BYTE),
    actype_code                    VARCHAR2(250 BYTE),
    orderamt                       BINARY_DOUBLE DEFAULT 0,
    orderqtty                      BINARY_DOUBLE DEFAULT 0,
    matchqtty                      BINARY_DOUBLE DEFAULT 0,
    orderamt9                      BINARY_DOUBLE DEFAULT 0,
    orderqtty9                     BINARY_DOUBLE DEFAULT 0,
    txdate                         DATE,
    tradingdate                    DATE,
    status                         VARCHAR2(250 BYTE),
    bankname                       VARCHAR2(500 BYTE),
    citybank                       VARCHAR2(500 BYTE),
    bankacc                        VARCHAR2(50 BYTE),
    bankacname                     VARCHAR2(50 BYTE),
    reason                         VARCHAR2(4000 BYTE),
    tradingid                      VARCHAR2(50 BYTE),
    symbol                         VARCHAR2(50 BYTE),
    name                           VARCHAR2(500 BYTE),
    feeid                          VARCHAR2(100 BYTE),
    feename                        VARCHAR2(250 BYTE),
    tlid                           VARCHAR2(20 BYTE),
    offid                          VARCHAR2(20 BYTE),
    deltd                          VARCHAR2(1 BYTE) DEFAULT 'N',
    impstatus                      VARCHAR2(20 BYTE) DEFAULT 'P',
    cancelstatus                   VARCHAR2(20 BYTE) DEFAULT 'N',
    errmsg                         VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6) DEFAULT to_date('0001-01-01 00:00:00', 'YYYY-MM-DD hh24:mi:ss'),
    createdate                     TIMESTAMP (6),
    odstatus                       VARCHAR2(10 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE tblr53
/

CREATE TABLE tblr53
    (autoid                         FLOAT(32) DEFAULT 0 NOT NULL,
    impdate                        DATE,
    ver                            VARCHAR2(50 BYTE),
    objname                        VARCHAR2(50 BYTE),
    fileid                         VARCHAR2(30 BYTE),
    mbid                           VARCHAR2(30 BYTE),
    custodycd                      VARCHAR2(30 BYTE),
    fullname                       VARCHAR2(4000 BYTE),
    symbol                         VARCHAR2(300 BYTE),
    srtype                         VARCHAR2(300 BYTE),
    orderid                        VARCHAR2(300 BYTE),
    orderamt                       BINARY_DOUBLE,
    ordamt                         BINARY_DOUBLE,
    amountcust                     BINARY_DOUBLE,
    reconcilests                   VARCHAR2(300 BYTE),
    estmatchamt                    BINARY_DOUBLE,
    orgamt                         BINARY_DOUBLE,
    content                        VARCHAR2(4000 BYTE),
    reftxnum                       VARCHAR2(300 BYTE),
    name                           VARCHAR2(300 BYTE),
    amount                         BINARY_DOUBLE,
    exmamount                      BINARY_DOUBLE,
    exmamountcust                  BINARY_DOUBLE,
    orgamtcust                     BINARY_DOUBLE,
    dealtype                       VARCHAR2(100 BYTE),
    dealtypecode                   VARCHAR2(250 BYTE),
    tlid                           VARCHAR2(20 BYTE),
    offid                          VARCHAR2(20 BYTE),
    deltd                          VARCHAR2(1 BYTE) DEFAULT 'N',
    impstatus                      VARCHAR2(20 BYTE) DEFAULT 'P',
    errmsg                         VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6) DEFAULT to_date('0001-01-01 00:00:00', 'YYYY-MM-DD hh24:mi:ss'),
    feedbackmsg                    VARCHAR2(4000 BYTE),
    tradingdate                    DATE,
    rsymbol                        VARCHAR2(250 BYTE),
    mbname                         VARCHAR2(250 BYTE),
    s_amount                       BINARY_DOUBLE,
    orgamt_2                       BINARY_DOUBLE DEFAULT 0)
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE tblr53_log
/

CREATE TABLE tblr53_log
    (autoid                         FLOAT(32) DEFAULT 0 NOT NULL,
    impdate                        DATE,
    ver                            VARCHAR2(50 BYTE),
    objname                        VARCHAR2(50 BYTE),
    fileid                         VARCHAR2(30 BYTE),
    mbid                           VARCHAR2(30 BYTE),
    custodycd                      VARCHAR2(30 BYTE),
    fullname                       VARCHAR2(4000 BYTE),
    symbol                         VARCHAR2(300 BYTE),
    srtype                         VARCHAR2(300 BYTE),
    orderid                        VARCHAR2(300 BYTE),
    orderamt                       BINARY_DOUBLE,
    ordamt                         BINARY_DOUBLE,
    amountcust                     BINARY_DOUBLE,
    reconcilests                   VARCHAR2(300 BYTE),
    estmatchamt                    BINARY_DOUBLE,
    orgamt                         BINARY_DOUBLE,
    content                        VARCHAR2(4000 BYTE),
    reftxnum                       VARCHAR2(300 BYTE),
    name                           VARCHAR2(300 BYTE),
    amount                         BINARY_DOUBLE,
    exmamount                      BINARY_DOUBLE,
    exmamountcust                  BINARY_DOUBLE,
    orgamtcust                     BINARY_DOUBLE,
    dealtype                       VARCHAR2(100 BYTE),
    dealtypecode                   VARCHAR2(250 BYTE),
    tlid                           VARCHAR2(20 BYTE),
    offid                          VARCHAR2(20 BYTE),
    deltd                          VARCHAR2(1 BYTE) DEFAULT 'N',
    impstatus                      VARCHAR2(20 BYTE) DEFAULT 'P',
    errmsg                         VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6) DEFAULT to_date('0001-01-01 00:00:00', 'YYYY-MM-DD hh24:mi:ss'),
    feedbackmsg                    VARCHAR2(4000 BYTE),
    tradingdate                    DATE,
    rsymbol                        VARCHAR2(250 BYTE),
    mbname                         VARCHAR2(250 BYTE),
    s_amount                       BINARY_DOUBLE,
    orgamt2                        BINARY_DOUBLE DEFAULT 0)
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE tblr62
/

CREATE TABLE tblr62
    (autoid                         FLOAT(64) DEFAULT 0 NOT NULL,
    impdate                        DATE,
    ver                            VARCHAR2(50 BYTE),
    objname                        VARCHAR2(50 BYTE),
    fileid                         VARCHAR2(30 BYTE),
    mbid                           VARCHAR2(30 BYTE),
    tlid                           VARCHAR2(20 BYTE),
    offid                          VARCHAR2(20 BYTE),
    deltd                          VARCHAR2(1 BYTE) DEFAULT 'N',
    impstatus                      VARCHAR2(20 BYTE) DEFAULT 'P',
    errmsg                         VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6) DEFAULT to_date('0001-01-01 00:00:00', 'YYYY-MM-DD hh24:mi:ss'),
    fullname                       VARCHAR2(4000 BYTE),
    idcode                         VARCHAR2(250 BYTE),
    iddate                         DATE,
    address                        VARCHAR2(250 BYTE),
    email                          VARCHAR2(200 BYTE),
    custodycd                      VARCHAR2(20 BYTE),
    dbcode                         VARCHAR2(250 BYTE),
    tradet1                        BINARY_DOUBLE,
    tradet2                        BINARY_DOUBLE,
    orderamt                       BINARY_DOUBLE,
    matchamtns                     BINARY_DOUBLE,
    matchamtnr                     BINARY_DOUBLE,
    orderqtty                      BINARY_DOUBLE,
    matchqttyns                    BINARY_DOUBLE,
    matchqttynr                    BINARY_DOUBLE,
    taxamt                         BINARY_DOUBLE,
    feeamtns                       BINARY_DOUBLE,
    feeamtnr                       BINARY_DOUBLE,
    amount                         BINARY_DOUBLE,
    tradingid                      VARCHAR2(200 BYTE),
    symbol                         VARCHAR2(200 BYTE),
    symbolname                     VARCHAR2(200 BYTE),
    nav                            BINARY_DOUBLE,
    totalnav                       BINARY_DOUBLE,
    tradingdate                    DATE,
    orderid                        VARCHAR2(200 BYTE),
    dealtype                       VARCHAR2(200 BYTE),
    dealtypecode                   VARCHAR2(200 BYTE),
    mbname                         VARCHAR2(250 BYTE))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE tblr62_log
/

CREATE TABLE tblr62_log
    (autoid                         FLOAT(64) DEFAULT 0 NOT NULL,
    impdate                        DATE,
    ver                            VARCHAR2(50 BYTE),
    objname                        VARCHAR2(50 BYTE),
    fileid                         VARCHAR2(30 BYTE),
    mbid                           VARCHAR2(30 BYTE),
    tlid                           VARCHAR2(20 BYTE),
    offid                          VARCHAR2(20 BYTE),
    deltd                          VARCHAR2(1 BYTE) DEFAULT 'N',
    impstatus                      VARCHAR2(20 BYTE) DEFAULT 'P',
    errmsg                         VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6) DEFAULT to_date('0001-01-01 00:00:00', 'YYYY-MM-DD hh24:mi:ss'),
    fullname                       VARCHAR2(4000 BYTE),
    idcode                         VARCHAR2(250 BYTE),
    iddate                         DATE,
    address                        VARCHAR2(250 BYTE),
    email                          VARCHAR2(200 BYTE),
    custodycd                      VARCHAR2(20 BYTE),
    dbcode                         VARCHAR2(250 BYTE),
    tradet1                        BINARY_DOUBLE,
    tradet2                        BINARY_DOUBLE,
    orderamt                       BINARY_DOUBLE,
    matchamtns                     BINARY_DOUBLE,
    matchamtnr                     BINARY_DOUBLE,
    orderqtty                      BINARY_DOUBLE,
    matchqttyns                    BINARY_DOUBLE,
    matchqttynr                    BINARY_DOUBLE,
    taxamt                         BINARY_DOUBLE,
    feeamtns                       BINARY_DOUBLE,
    feeamtnr                       BINARY_DOUBLE,
    amount                         BINARY_DOUBLE,
    tradingid                      VARCHAR2(200 BYTE),
    symbol                         VARCHAR2(200 BYTE),
    symbolname                     VARCHAR2(200 BYTE),
    nav                            BINARY_DOUBLE,
    totalnav                       BINARY_DOUBLE,
    tradingdate                    DATE,
    orderid                        VARCHAR2(200 BYTE),
    dealtype                       VARCHAR2(200 BYTE),
    dealtypecode                   VARCHAR2(200 BYTE),
    mbname                         VARCHAR2(250 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE tblse_dlpp
/

CREATE TABLE tblse_dlpp
    (autoid                         FLOAT(32) DEFAULT 0 NOT NULL,
    ver                            VARCHAR2(50 BYTE),
    objname                        VARCHAR2(50 BYTE),
    tlid                           VARCHAR2(20 BYTE),
    offid                          VARCHAR2(20 BYTE),
    deltd                          VARCHAR2(1 BYTE) DEFAULT 'N',
    status                         VARCHAR2(20 BYTE) DEFAULT 'P',
    errmsg                         VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6) DEFAULT to_date('0001-01-01 00:00:00', 'YYYY-MM-DD hh24:mi:ss'),
    fileid                         VARCHAR2(30 BYTE),
    mbid                           VARCHAR2(30 BYTE),
    acctno                         VARCHAR2(20 BYTE),
    symbol                         VARCHAR2(200 BYTE),
    trade                          BINARY_DOUBLE DEFAULT 0,
    tradesip                       BINARY_DOUBLE DEFAULT 0,
    costprice                      BINARY_DOUBLE DEFAULT 0,
    isotpchk                       VARCHAR2(1 BYTE) DEFAULT 'N')
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE tblse_dlpp_log
/

CREATE TABLE tblse_dlpp_log
    (autoid                         FLOAT(64) NOT NULL,
    ver                            VARCHAR2(50 BYTE),
    objname                        VARCHAR2(50 BYTE),
    tlid                           VARCHAR2(20 BYTE),
    offid                          VARCHAR2(20 BYTE),
    deltd                          VARCHAR2(1 BYTE) DEFAULT 'N',
    status                         VARCHAR2(20 BYTE) DEFAULT 'P',
    errmsg                         VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6) DEFAULT to_date('0001-01-01 00:00:00', 'YYYY-MM-DD hh24:mi:ss'),
    fileid                         VARCHAR2(30 BYTE),
    mbid                           VARCHAR2(30 BYTE),
    acctno                         VARCHAR2(20 BYTE),
    symbol                         VARCHAR2(200 BYTE),
    trade                          BINARY_DOUBLE DEFAULT 0,
    tradesip                       BINARY_DOUBLE DEFAULT 0,
    costprice                      BINARY_DOUBLE DEFAULT 0,
    isotpchk                       VARCHAR2(1 BYTE) DEFAULT 'N')
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE tblse2244
/

CREATE TABLE tblse2244
    (autoid                         BINARY_DOUBLE DEFAULT 0 NOT NULL,
    codeid                         VARCHAR2(6 BYTE),
    symbol                         VARCHAR2(20 BYTE),
    outward                        VARCHAR2(3 BYTE),
    custodycd                      VARCHAR2(10 BYTE),
    afacctno                       VARCHAR2(16 BYTE),
    acctno                         VARCHAR2(16 BYTE),
    price                          BINARY_DOUBLE DEFAULT 0,
    trade                          BINARY_DOUBLE DEFAULT 0,
    blocked                        BINARY_DOUBLE DEFAULT 0,
    caqtty                         BINARY_DOUBLE DEFAULT 0,
    recustodycd                    VARCHAR2(10 BYTE),
    recustname                     VARCHAR2(100 BYTE),
    deltd                          VARCHAR2(1 BYTE),
    status                         VARCHAR2(1 BYTE),
    errmsg                         VARCHAR2(200 BYTE),
    des                            VARCHAR2(500 BYTE),
    fileid                         VARCHAR2(20 BYTE),
    type                           VARCHAR2(6 BYTE),
    trtype                         VARCHAR2(6 BYTE),
    custodycd2                     VARCHAR2(10 BYTE),
    afacctno2                      VARCHAR2(16 BYTE),
    fullname                       VARCHAR2(50 BYTE),
    cridcode                       VARCHAR2(50 BYTE),
    criddate                       VARCHAR2(50 BYTE),
    cridplace                      VARCHAR2(100 BYTE),
    cridaddress                    VARCHAR2(250 BYTE),
    tlidimp                        VARCHAR2(10 BYTE),
    tlidovr                        VARCHAR2(10 BYTE),
    txtime                         TIMESTAMP (6),
    impstatus                      VARCHAR2(2 BYTE),
    ovrstatus                      VARCHAR2(2 BYTE))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

ALTER TABLE tblse2244
ADD CONSTRAINT "TBLSE2244_pkey" PRIMARY KEY (autoid)
USING INDEX
/

DROP TABLE tblsp_cv
/

CREATE TABLE tblsp_cv
    (autoid                         FLOAT(32) DEFAULT 0 NOT NULL,
    spname                         VARCHAR2(50 BYTE),
    symbol                         VARCHAR2(50 BYTE),
    custodycd                      VARCHAR2(50 BYTE),
    amt                            BINARY_DOUBLE,
    status                         VARCHAR2(1 BYTE) DEFAULT 'P')
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE temp
/

CREATE TABLE temp
    (temp                           VARCHAR2(4000 BYTE))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE temp_oxmast
/

CREATE TABLE temp_oxmast
    (label                          VARCHAR2(500 BYTE),
    value                          VARCHAR2(500 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE temp_rate
/

CREATE GLOBAL TEMPORARY TABLE temp_rate
    ("year"                         NUMBER,
    age                            NUMBER,
    rate                           NUMBER,
    moneyyear                      NUMBER,
    investvalue                    NUMBER,
    interestamt                    NUMBER,
    interestamtaccr                NUMBER,
    balance                        NUMBER)
ON COMMIT DELETE ROWS
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
/

DROP TABLE temp_rate_order
/

CREATE TABLE temp_rate_order
    (months                         NUMBER,
    rate                           NUMBER,
    symbol                         VARCHAR2(200 BYTE),
    productid                      VARCHAR2(100 BYTE),
    productname                    VARCHAR2(100 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE templates
/

CREATE TABLE templates
    (code                           CHAR(4 BYTE),
    name                           VARCHAR2(50 BYTE),
    subject                        VARCHAR2(300 BYTE),
    subject_en                     VARCHAR2(300 BYTE),
    type                           CHAR(1 BYTE) DEFAULT 'E',
    format                         CHAR(1 BYTE) DEFAULT 'T',
    require_register               CHAR(1 BYTE) DEFAULT 'N',
    attachment_id                  CHAR(6 BYTE),
    export_path                    VARCHAR2(100 BYTE),
    allow_zip                      CHAR(1 BYTE) DEFAULT 'Y',
    authentication                 CHAR(1 BYTE) DEFAULT 'N',
    isccbroker                     VARCHAR2(1 BYTE) DEFAULT 'N',
    msgtype                        VARCHAR2(10 BYTE) DEFAULT 'S',
    msgdatatype                    VARCHAR2(100 BYTE) DEFAULT 'email',
    msgcontent                     VARCHAR2(4000 BYTE),
    msgcontenttype                 VARCHAR2(100 BYTE) DEFAULT 'text/html',
    msgattachcard                  VARCHAR2(4000 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE tempsale_groups_total
/

CREATE TABLE tempsale_groups_total
    (autoid                         FLOAT(32) DEFAULT 0 NOT NULL,
    grllevel                       BINARY_DOUBLE,
    prgrpid                        VARCHAR2(20 BYTE),
    managerid                      VARCHAR2(50 BYTE),
    ratecomm                       BINARY_DOUBLE,
    groupthreshold                 BINARY_DOUBLE)
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE termdefn
/

CREATE TABLE termdefn
    (autoid                         FLOAT(64),
    termcode                       VARCHAR2(20 BYTE),
    termname                       VARCHAR2(200 BYTE),
    min_day                        FLOAT(64),
    max_day                        FLOAT(64),
    status                         VARCHAR2(1 BYTE) DEFAULT 'A')
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE test
/

CREATE TABLE test
    (id                             BINARY_DOUBLE,
    value                          VARCHAR2(20 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE thaitq
/

CREATE TABLE thaitq
    (ten                            VARCHAR2(4000 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE thaitq_test_11111
/

CREATE TABLE thaitq_test_11111
    (tellerid                       VARCHAR2(8 BYTE),
    cmdobjname                     VARCHAR2(50 BYTE))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE thaitq_test_price
/

CREATE TABLE thaitq_test_price
    (orderid                        VARCHAR2(30 BYTE),
    price                          NUMBER)
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE tlauth
/

CREATE TABLE tlauth
    (autoid                         BINARY_DOUBLE DEFAULT 0 NOT NULL,
    authtype                       VARCHAR2(1 BYTE),
    authid                         VARCHAR2(8 BYTE),
    tltxcd                         VARCHAR2(6 BYTE),
    tltype                         VARCHAR2(1 BYTE),
    auth_d1                        VARCHAR2(1 BYTE) DEFAULT 'N',
    auth_d2                        VARCHAR2(1 BYTE) DEFAULT 'N',
    auth_s1                        VARCHAR2(1 BYTE) DEFAULT 'N',
    auth_s2                        VARCHAR2(1 BYTE) DEFAULT 'N',
    auth_c1                        VARCHAR2(1 BYTE) DEFAULT 'N',
    auth_c2                        VARCHAR2(1 BYTE) DEFAULT 'N',
    auth_v1                        VARCHAR2(1 BYTE) DEFAULT 'N',
    auth_v2                        VARCHAR2(1 BYTE) DEFAULT 'N',
    savetlid                       VARCHAR2(8 BYTE),
    lastdate                       TIMESTAMP (6))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

ALTER TABLE tlauth
ADD CONSTRAINT tlauth_pkey PRIMARY KEY (autoid)
USING INDEX
/

DROP TABLE tlgroups
/

CREATE TABLE tlgroups
    (grpid                          VARCHAR2(10 BYTE) NOT NULL,
    grpname                        VARCHAR2(100 BYTE),
    grptype                        VARCHAR2(10 BYTE),
    rolecode                       VARCHAR2(10 BYTE),
    subgrptype                     VARCHAR2(10 BYTE),
    refmember                      VARCHAR2(10 BYTE),
    active                         VARCHAR2(1 BYTE),
    description                    VARCHAR2(500 BYTE),
    lastchange                     TIMESTAMP (6),
    grpright                       VARCHAR2(10 BYTE),
    status                         VARCHAR2(10 BYTE) DEFAULT 'A',
    pstatus                        VARCHAR2(4000 BYTE),
    grprefid                       VARCHAR2(20 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

ALTER TABLE tlgroups
ADD CONSTRAINT tlgroups_pkey PRIMARY KEY (grpid)
USING INDEX
/

DROP TABLE tlgroupscv
/

CREATE TABLE tlgroupscv
    (grpid                          VARCHAR2(4000 BYTE) NOT NULL,
    grpname                        VARCHAR2(100 BYTE),
    grptype                        VARCHAR2(10 BYTE),
    rolecode                       VARCHAR2(10 BYTE))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE tlgroupsmemo
/

CREATE TABLE tlgroupsmemo
    (grpid                          VARCHAR2(10 BYTE),
    grpname                        VARCHAR2(100 BYTE),
    grptype                        VARCHAR2(10 BYTE),
    rolecode                       VARCHAR2(10 BYTE),
    subgrptype                     VARCHAR2(10 BYTE),
    refmember                      VARCHAR2(10 BYTE),
    active                         VARCHAR2(1 BYTE),
    description                    VARCHAR2(500 BYTE),
    lastchange                     TIMESTAMP (6),
    grpright                       VARCHAR2(10 BYTE),
    status                         VARCHAR2(10 BYTE),
    pstatus                        VARCHAR2(4000 BYTE),
    grprefid                       VARCHAR2(20 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE tlgrp
/

CREATE TABLE tlgrp
    (grpid                          VARCHAR2(20 BYTE),
    mbid                           VARCHAR2(500 BYTE),
    areaid                         VARCHAR2(500 BYTE),
    prbrid                         VARCHAR2(500 BYTE),
    brid                           VARCHAR2(500 BYTE),
    status                         VARCHAR2(3 BYTE) DEFAULT 'A',
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE tlgrpusers
/

CREATE TABLE tlgrpusers
    (id                             VARCHAR2(8 BYTE) NOT NULL,
    grpid                          VARCHAR2(4 BYTE),
    tlid                           VARCHAR2(8 BYTE),
    active                         VARCHAR2(1 BYTE) DEFAULT 'N',
    lastchange                     TIMESTAMP (6),
    status                         VARCHAR2(3 BYTE) DEFAULT 'A',
    pstatus                        VARCHAR2(4000 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

CREATE INDEX tlgrpusers_idx01 ON tlgrpusers
  (
    tlid                            ASC,
    active                          ASC,
    grpid                           ASC
  )
NOPARALLEL
NOLOGGING
/


ALTER TABLE tlgrpusers
ADD CONSTRAINT tlgrpusers_pkey PRIMARY KEY (id)
USING INDEX
/

DROP TABLE tlgrpusersmemo
/

CREATE TABLE tlgrpusersmemo
    (id                             VARCHAR2(8 BYTE),
    grpid                          VARCHAR2(4 BYTE),
    tlid                           VARCHAR2(8 BYTE),
    active                         VARCHAR2(1 BYTE),
    lastchange                     TIMESTAMP (6),
    status                         VARCHAR2(3 BYTE),
    pstatus                        VARCHAR2(4000 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE tllog
/

CREATE TABLE tllog
    (autoid                         FLOAT(64) DEFAULT 0 NOT NULL,
    txnum                          VARCHAR2(20 BYTE) NOT NULL,
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
    msgamt                         NUMBER DEFAULT 0,
    msgacct                        VARCHAR2(100 BYTE),
    chktime                        VARCHAR2(10 BYTE),
    offtime                        VARCHAR2(10 BYTE),
    carebygrp                      VARCHAR2(50 BYTE),
    reftxnum                       VARCHAR2(10 BYTE) DEFAULT '',
    namenv                         VARCHAR2(4000 BYTE),
    cfcustodycd                    VARCHAR2(200 BYTE),
    createdt                       TIMESTAMP (6) DEFAULT to_date('0001-01-01 00:00:00', 'YYYY-MM-DD hh24:mi:ss'),
    cffullname                     VARCHAR2(4000 BYTE),
    ptxstatus                      VARCHAR2(4000 BYTE),
    lvel                           FLOAT(64) DEFAULT 0,
    dstatus                        VARCHAR2(2 BYTE),
    last_lvel                      FLOAT(64) DEFAULT 0,
    last_dstatus                   VARCHAR2(2 BYTE),
    via                            VARCHAR2(10 BYTE),
    dbcode                         VARCHAR2(10 BYTE),
    cmdobjname                     VARCHAR2(100 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

CREATE UNIQUE INDEX tllog_txdatetxnum_key ON tllog
  (
    txnum                           ASC,
    txdate                          ASC
  )
NOPARALLEL
NOLOGGING
/

CREATE INDEX tllog_tltxcd_idx ON tllog
  (
    tltxcd                          ASC
  )
NOPARALLEL
NOLOGGING
/

CREATE INDEX tllog_txnum_txdate_idx ON tllog
  (
    txdate                          ASC,
    txnum                           ASC
  )
NOPARALLEL
NOLOGGING
/

CREATE INDEX tllog_busdate_idx ON tllog
  (
    busdate                         ASC
  )
NOPARALLEL
NOLOGGING
/

CREATE INDEX tllog_txdate_idx ON tllog
  (
    txdate                          ASC
  )
NOPARALLEL
NOLOGGING
/

CREATE INDEX tllog_idx01 ON tllog
  (
    tlid                            ASC
  )
NOPARALLEL
NOLOGGING
/


DROP TABLE tllogall
/

CREATE TABLE tllogall
    (autoid                         FLOAT(64) DEFAULT 0 NOT NULL,
    txnum                          VARCHAR2(20 BYTE) NOT NULL,
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
    msgamt                         BINARY_DOUBLE DEFAULT 0,
    msgacct                        VARCHAR2(100 BYTE),
    chktime                        VARCHAR2(10 BYTE),
    offtime                        VARCHAR2(10 BYTE),
    carebygrp                      VARCHAR2(50 BYTE),
    reftxnum                       VARCHAR2(10 BYTE) DEFAULT '',
    namenv                         VARCHAR2(4000 BYTE),
    cfcustodycd                    VARCHAR2(100 BYTE),
    createdt                       TIMESTAMP (6) DEFAULT to_date('0001-01-01 00:00:00', 'YYYY-MM-DD hh24:mi:ss'),
    cffullname                     VARCHAR2(4000 BYTE),
    ptxstatus                      VARCHAR2(4000 BYTE),
    lvel                           FLOAT(64) DEFAULT 0,
    dstatus                        VARCHAR2(2 BYTE),
    last_lvel                      FLOAT(64) DEFAULT 0,
    last_dstatus                   VARCHAR2(2 BYTE),
    via                            VARCHAR2(10 BYTE),
    dbcode                         VARCHAR2(10 BYTE),
    cmdobjname                     VARCHAR2(100 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE tllogbds
/

CREATE TABLE tllogbds
    (autoid                         FLOAT(64),
    txnum                          VARCHAR2(10 BYTE),
    txdate                         TIMESTAMP (6),
    txtime                         VARCHAR2(10 BYTE),
    brid                           VARCHAR2(4 BYTE),
    tlid                           VARCHAR2(6 BYTE),
    offid                          VARCHAR2(6 BYTE),
    ovrrqs                         VARCHAR2(4000 BYTE),
    chid                           VARCHAR2(6 BYTE),
    chkid                          VARCHAR2(6 BYTE),
    tltxcd                         VARCHAR2(4 BYTE),
    ibt                            VARCHAR2(1 BYTE),
    brid2                          VARCHAR2(4 BYTE),
    tlid2                          VARCHAR2(6 BYTE),
    ccyusage                       VARCHAR2(40 BYTE),
    off_line                       VARCHAR2(1 BYTE),
    deltd                          CHAR(1 BYTE),
    brdate                         TIMESTAMP (6),
    busdate                        TIMESTAMP (6),
    txdesc                         VARCHAR2(4000 BYTE),
    ipaddress                      VARCHAR2(20 BYTE),
    wsname                         VARCHAR2(50 BYTE),
    txstatus                       VARCHAR2(1 BYTE),
    msgsts                         VARCHAR2(1 BYTE),
    ovrsts                         VARCHAR2(1 BYTE),
    batchname                      CHAR(20 BYTE),
    msgamt                         BINARY_DOUBLE,
    msgacct                        VARCHAR2(100 BYTE),
    chktime                        VARCHAR2(10 BYTE),
    offtime                        VARCHAR2(10 BYTE),
    carebygrp                      VARCHAR2(50 BYTE),
    reftxnum                       VARCHAR2(10 BYTE),
    namenv                         VARCHAR2(4000 BYTE),
    cfcustodycd                    VARCHAR2(20 BYTE),
    createdt                       TIMESTAMP (6),
    cffullname                     VARCHAR2(4000 BYTE),
    ptxstatus                      VARCHAR2(4000 BYTE),
    lvel                           FLOAT(64) DEFAULT 0,
    dstatus                        VARCHAR2(2 BYTE),
    last_lvel                      FLOAT(64) DEFAULT 0,
    last_dstatus                   VARCHAR2(2 BYTE))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE tllogfld
/

CREATE TABLE tllogfld
    (autoid                         NUMBER(38,0) DEFAULT 0 NOT NULL,
    txnum                          VARCHAR2(100 BYTE),
    txdate                         DATE,
    fldcd                          VARCHAR2(3 BYTE),
    nvalue                         NUMBER(38,5) DEFAULT 0,
    cvalue                         VARCHAR2(4000 BYTE),
    txdesc                         VARCHAR2(4000 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

CREATE INDEX tllogfld_txnum_idx ON tllogfld
  (
    txnum                           ASC
  )
NOPARALLEL
NOLOGGING
/


ALTER TABLE tllogfld
ADD CONSTRAINT tllogfld_pkey PRIMARY KEY (autoid)
USING INDEX
/

DROP TABLE tllogfld_bk
/

CREATE TABLE tllogfld_bk
    (autoid                         FLOAT(64) NOT NULL,
    txnum                          VARCHAR2(100 BYTE),
    txdate                         DATE,
    fldcd                          VARCHAR2(3 BYTE),
    nvalue                         BINARY_DOUBLE,
    cvalue                         VARCHAR2(4000 BYTE),
    txdesc                         VARCHAR2(400 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE tllogfldall
/

CREATE TABLE tllogfldall
    (autoid                         NUMBER(38,0) DEFAULT 0 NOT NULL,
    txnum                          VARCHAR2(400 BYTE),
    txdate                         TIMESTAMP (6),
    fldcd                          VARCHAR2(2 BYTE),
    nvalue                         NUMBER(38,5) DEFAULT 0,
    cvalue                         VARCHAR2(4000 BYTE),
    txdesc                         VARCHAR2(4000 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE tllogwf
/

CREATE TABLE tllogwf
    (autoid                         FLOAT(64) NOT NULL,
    txnum                          VARCHAR2(20 BYTE) NOT NULL,
    txdate                         DATE NOT NULL,
    busdate                        DATE,
    txtime                         VARCHAR2(10 BYTE),
    lvel                           FLOAT(64) NOT NULL,
    dstatus                        VARCHAR2(2 BYTE),
    tlid                           VARCHAR2(6 BYTE),
    txdesc                         VARCHAR2(4000 BYTE),
    ipaddress                      VARCHAR2(20 BYTE),
    wsname                         VARCHAR2(50 BYTE),
    dsaction                       VARCHAR2(2 BYTE),
    lastchange                     TIMESTAMP (6),
    apprdate                       DATE)
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE tlog
/

CREATE TABLE tlog
    (id                             NUMBER ,
    ldate                          DATE DEFAULT SYSDATE,
    lhsecs                         NUMBER,
    llevel                         NUMBER,
    lsection                       VARCHAR2(4000 BYTE),
    ltexte                         VARCHAR2(4000 BYTE),
    luser                          VARCHAR2(30 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

ALTER TABLE tlog
ADD CONSTRAINT pk_tlog PRIMARY KEY (id)
USING INDEX
/

DROP TABLE tlogdebug
/

CREATE TABLE tlogdebug
    (user_name                      VARCHAR2(60 BYTE),
    module                         VARCHAR2(15 BYTE),
    loglevel                       NUMBER(4,0),
    log4table                      CHAR(1 BYTE),
    log4alert                      CHAR(1 BYTE),
    log4trace                      CHAR(1 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE tloglevel
/

CREATE TABLE tloglevel
    (llevel                         NUMBER(4,0) ,
    ljlevel                        NUMBER(5,0),
    lsyslogequiv                   NUMBER(4,0),
    lcode                          VARCHAR2(10 BYTE),
    ldesc                          VARCHAR2(255 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

ALTER TABLE tloglevel
ADD CONSTRAINT pk_tloglevel PRIMARY KEY (llevel)
USING INDEX
/

DROP TABLE tlprofiles
/

CREATE TABLE tlprofiles
    (tlid                           VARCHAR2(6 BYTE) NOT NULL,
    tlname                         VARCHAR2(200 BYTE),
    tlfullname                     VARCHAR2(200 BYTE),
    mbid                           VARCHAR2(6 BYTE),
    brid                           VARCHAR2(10 BYTE),
    password                       VARCHAR2(500 BYTE),
    active                         VARCHAR2(1 BYTE),
    tltype                         VARCHAR2(20 BYTE),
    department                     VARCHAR2(100 BYTE),
    tltitle                        VARCHAR2(100 BYTE),
    idcode                         VARCHAR2(50 BYTE),
    mobile                         VARCHAR2(20 BYTE),
    email                          VARCHAR2(100 BYTE),
    description                    VARCHAR2(500 BYTE),
    status                         VARCHAR2(10 BYTE) DEFAULT 'A',
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6),
    tlrefid                        VARCHAR2(20 BYTE),
    vsdsaleid                      VARCHAR2(20 BYTE),
    ismanager                      VARCHAR2(10 BYTE),
    retry_count                    NUMBER)
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

ALTER TABLE tlprofiles
ADD CONSTRAINT tlprofiles_pkey PRIMARY KEY (tlid)
USING INDEX
/

DROP TABLE tlprofilescv
/

CREATE TABLE tlprofilescv
    (tlid                           VARCHAR2(4000 BYTE),
    tlname                         VARCHAR2(200 BYTE),
    tlfullname                     VARCHAR2(200 BYTE),
    mbid                           VARCHAR2(4000 BYTE),
    areaid                         VARCHAR2(4000 BYTE),
    brid                           VARCHAR2(4000 BYTE),
    idcode                         VARCHAR2(50 BYTE),
    mobile                         VARCHAR2(4000 BYTE),
    email                          VARCHAR2(100 BYTE),
    department                     VARCHAR2(100 BYTE),
    tltitle                        VARCHAR2(100 BYTE),
    careby                         VARCHAR2(20 BYTE),
    "update"                       DATE)
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE tlprofilesmemo
/

CREATE TABLE tlprofilesmemo
    (tlid                           VARCHAR2(6 BYTE) NOT NULL,
    tlname                         VARCHAR2(200 BYTE),
    tlfullname                     VARCHAR2(200 BYTE),
    mbid                           VARCHAR2(6 BYTE),
    brid                           VARCHAR2(10 BYTE),
    password                       VARCHAR2(500 BYTE),
    active                         VARCHAR2(1 BYTE),
    tltype                         VARCHAR2(20 BYTE),
    department                     VARCHAR2(100 BYTE),
    tltitle                        VARCHAR2(100 BYTE),
    idcode                         VARCHAR2(50 BYTE),
    mobile                         VARCHAR2(20 BYTE),
    email                          VARCHAR2(100 BYTE),
    description                    VARCHAR2(500 BYTE),
    status                         VARCHAR2(10 BYTE) DEFAULT 'P',
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6),
    tlrefid                        VARCHAR2(20 BYTE),
    vsdsaleid                      VARCHAR2(20 BYTE),
    ismanager                      VARCHAR2(10 BYTE),
    retry_count                    NUMBER)
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE tlroles
/

CREATE TABLE tlroles
    (id                             BINARY_DOUBLE NOT NULL,
    tlid                           VARCHAR2(10 BYTE),
    roleid                         FLOAT(64),
    rolecode                       VARCHAR2(10 BYTE),
    refcodetyp                     VARCHAR2(10 BYTE),
    refcodeid                      VARCHAR2(10 BYTE),
    subgrptype                     VARCHAR2(10 BYTE),
    frdate                         TIMESTAMP (6),
    todate                         TIMESTAMP (6),
    lastchange                     TIMESTAMP (6))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

ALTER TABLE tlroles
ADD CONSTRAINT tlroles_pkey PRIMARY KEY (id)
USING INDEX
/

DROP TABLE tltx
/

CREATE TABLE tltx
    (tltxcd                         VARCHAR2(4 BYTE) NOT NULL,
    txdesc                         VARCHAR2(400 BYTE),
    en_txdesc                      VARCHAR2(400 BYTE),
    limit                          FLOAT(64) DEFAULT 0,
    offlineallow                   VARCHAR2(1 BYTE),
    ibt                            VARCHAR2(1 BYTE),
    ovrrqd                         VARCHAR2(1 BYTE),
    late                           VARCHAR2(2 BYTE),
    ovrlev                         FLOAT(64) DEFAULT 0,
    prn                            VARCHAR2(10 BYTE),
    local                          VARCHAR2(1 BYTE),
    chain                          VARCHAR2(1 BYTE),
    direct                         VARCHAR2(1 BYTE),
    hostacno                       VARCHAR2(1 BYTE),
    backup                         VARCHAR2(1 BYTE),
    txtype                         VARCHAR2(2 BYTE),
    nosubmit                       VARCHAR2(1 BYTE),
    delallow                       VARCHAR2(1 BYTE),
    feeapp                         VARCHAR2(1 BYTE),
    msqrqr                         VARCHAR2(1 BYTE),
    voucher                        VARCHAR2(20 BYTE),
    mnem                           VARCHAR2(10 BYTE),
    msg_amt                        VARCHAR2(100 BYTE),
    msg_acct                       VARCHAR2(2 BYTE),
    withacct                       VARCHAR2(2 BYTE),
    acctentry                      VARCHAR2(1 BYTE),
    bgcolor                        FLOAT(64) DEFAULT 0,
    display                        VARCHAR2(1 BYTE) DEFAULT 'Y',
    bkdate                         VARCHAR2(1 BYTE) DEFAULT 'Y',
    adjallow                       VARCHAR2(1 BYTE) DEFAULT 'Y',
    glgp                           VARCHAR2(2 BYTE) DEFAULT 'N',
    voucherid                      VARCHAR2(100 BYTE),
    ccycd                          CHAR(2 BYTE) DEFAULT '##',
    runmod                         VARCHAR2(3 BYTE),
    restrictallow                  CHAR(1 BYTE) DEFAULT 'N',
    refobj                         VARCHAR2(20 BYTE),
    refkeyfld                      VARCHAR2(20 BYTE),
    msgtype                        VARCHAR2(20 BYTE),
    chkbkdate                      CHAR(1 BYTE) DEFAULT 'N',
    cfcustodycd                    CHAR(2 BYTE) DEFAULT '##',
    cffullname                     CHAR(2 BYTE) DEFAULT '##',
    visible                        VARCHAR2(1 BYTE) DEFAULT 'Y',
    chgtypeallow                   VARCHAR2(1 BYTE) DEFAULT 'Y',
    chksingle                      VARCHAR2(60 BYTE) DEFAULT 'N',
    foallow                        VARCHAR2(1 BYTE) DEFAULT 'N')
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

ALTER TABLE tltx
ADD CONSTRAINT tltx_pkey PRIMARY KEY (tltxcd)
USING INDEX
/

DROP TABLE tltxwf
/

CREATE TABLE tltxwf
    (autoid                         FLOAT(64) NOT NULL,
    tltxcd                         VARCHAR2(4 BYTE),
    lvel                           FLOAT(64) NOT NULL,
    dstatus                        VARCHAR2(2 BYTE),
    aprlvel                        FLOAT(64),
    refuselvel                     FLOAT(64),
    last                           VARCHAR2(1 BYTE),
    status                         VARCHAR2(1 BYTE),
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE tmp_int_schd
/

CREATE TABLE tmp_int_schd
    (autoid                         NUMBER,
    symbol                         VARCHAR2(100 BYTE),
    periodno                       NUMBER)
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  LOGGING
  MONITORING
/

DROP TABLE tmp_payment_schd
/

CREATE TABLE tmp_payment_schd
    (autoid                         NUMBER,
    symbol                         VARCHAR2(100 BYTE),
    amount                         NUMBER)
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  LOGGING
  MONITORING
/

DROP TABLE tmp_paymenthist_sereqclose
/

CREATE GLOBAL TEMPORARY TABLE tmp_paymenthist_sereqclose
    (symbol                         VARCHAR2(15 BYTE),
    txdate                         DATE,
    intrate                        NUMBER)
ON COMMIT DELETE ROWS
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
/

DROP TABLE tmp_price_for_sell
/

CREATE TABLE tmp_price_for_sell
    (orderid                        VARCHAR2(30 BYTE),
    price_for_sell                 NUMBER)
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE tradingcycle
/

CREATE TABLE tradingcycle
    (autoid                         FLOAT(64) NOT NULL,
    codeid                         VARCHAR2(10 BYTE),
    symbol                         VARCHAR2(10 BYTE),
    spcode                         VARCHAR2(10 BYTE),
    adjtraderule                   VARCHAR2(10 BYTE),
    tradingcycle                   VARCHAR2(100 BYTE),
    status                         VARCHAR2(10 BYTE) DEFAULT 'P',
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6),
    monthtype                      VARCHAR2(1 BYTE),
    cycletype                      VARCHAR2(1 BYTE),
    minamt                         BINARY_DOUBLE,
    maxamt                         BINARY_DOUBLE,
    minterm                        FLOAT(64),
    maxterm                        FLOAT(64),
    traddingtype                   VARCHAR2(20 BYTE),
    frequency                      FLOAT(64),
    mintermregister                FLOAT(64),
    mintermjoin                    FLOAT(64),
    tdate                          BINARY_DOUBLE,
    fstdate                        DATE,
    maxtermjoin                    BINARY_DOUBLE)
  NOPARALLEL
  NOLOGGING
  MONITORING
/

ALTER TABLE tradingcycle
ADD CONSTRAINT tradingcycle_pkey PRIMARY KEY (autoid)
USING INDEX
/

DROP TABLE tradingcycledtl
/

CREATE TABLE tradingcycledtl
    (autoid                         FLOAT(64) NOT NULL,
    refautoid                      FLOAT(64),
    symbol                         VARCHAR2(10 BYTE),
    tradingcycledtl                VARCHAR2(100 BYTE),
    content                        VARCHAR2(100 BYTE),
    status                         VARCHAR2(1 BYTE),
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

ALTER TABLE tradingcycledtl
ADD CONSTRAINT tradingcycledtl_pkey PRIMARY KEY (autoid)
USING INDEX
/

DROP TABLE tradingsession
/

CREATE TABLE tradingsession
    (tradingid                      VARCHAR2(50 BYTE) NOT NULL,
    codeid                         VARCHAR2(50 BYTE),
    tradingdate                    DATE,
    matchdate                      DATE,
    execdateccq                    DATE,
    execdatecash                   DATE,
    txdate                         DATE,
    enav                           BINARY_DOUBLE DEFAULT 0,
    nav                            BINARY_DOUBLE DEFAULT 0,
    buyamt                         BINARY_DOUBLE DEFAULT 0,
    tradingstatus                  VARCHAR2(1 BYTE),
    lastchange                     TIMESTAMP (6),
    clsorddate                     DATE,
    sip                            VARCHAR2(1 BYTE) DEFAULT 'N',
    tradingtype                    VARCHAR2(3 BYTE) DEFAULT 'NOR',
    vermatching                    VARCHAR2(100 BYTE) DEFAULT '0',
    totalenav                      BINARY_DOUBLE DEFAULT 0,
    totalnav                       BINARY_DOUBLE DEFAULT 0)
  NOPARALLEL
  NOLOGGING
  MONITORING
/

ALTER TABLE tradingsession
ADD CONSTRAINT tradingsession_id_pk PRIMARY KEY (tradingid)
USING INDEX
/

DROP TABLE tradingsessiondtl
/

CREATE TABLE tradingsessiondtl
    (autoid                         FLOAT(64),
    tradingid                      VARCHAR2(50 BYTE),
    codeid                         VARCHAR2(10 BYTE),
    tradingdate                    TIMESTAMP (6),
    confirmtime                    TIMESTAMP (6),
    confirmstatus                  VARCHAR2(1 BYTE),
    confirmtype                    VARCHAR2(2 BYTE),
    lastchange                     TIMESTAMP (6),
    dbcode                         VARCHAR2(10 BYTE))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE tradingsessiondtlhist
/

CREATE TABLE tradingsessiondtlhist
    (autoid                         FLOAT(64),
    tradingid                      VARCHAR2(50 BYTE),
    codeid                         VARCHAR2(10 BYTE),
    tradingdate                    TIMESTAMP (6),
    confirmtime                    TIMESTAMP (6),
    confirmstatus                  VARCHAR2(1 BYTE),
    lastchange                     TIMESTAMP (6))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE tradingsessionhist
/

CREATE TABLE tradingsessionhist
    (tradingid                      VARCHAR2(50 BYTE) NOT NULL,
    codeid                         VARCHAR2(50 BYTE),
    tradingdate                    DATE,
    matchdate                      DATE,
    execdateccq                    DATE,
    execdatecash                   DATE,
    txdate                         DATE,
    enav                           BINARY_DOUBLE,
    nav                            BINARY_DOUBLE,
    buyamt                         BINARY_DOUBLE,
    tradingstatus                  VARCHAR2(1 BYTE),
    lastchange                     TIMESTAMP (6),
    clsorddate                     DATE,
    sip                            VARCHAR2(1 BYTE) DEFAULT 'N',
    tradingtype                    VARCHAR2(3 BYTE) DEFAULT 'NOR',
    vermatching                    VARCHAR2(100 BYTE) DEFAULT '0',
    totalenav                      BINARY_DOUBLE,
    totalnav                       BINARY_DOUBLE)
  NOPARALLEL
  NOLOGGING
  MONITORING
/

ALTER TABLE tradingsessionhist
ADD CONSTRAINT tradingsessionhist_id_pk PRIMARY KEY (tradingid)
USING INDEX
/

DROP TABLE tradingsessionlog
/

CREATE TABLE tradingsessionlog
    (tradingid                      VARCHAR2(50 BYTE),
    codeid                         VARCHAR2(50 BYTE),
    tradingdate                    DATE,
    matchdate                      DATE,
    execdateccq                    DATE,
    execdatecash                   DATE,
    txdate                         DATE,
    enav                           BINARY_DOUBLE,
    nav                            BINARY_DOUBLE,
    buyamt                         BINARY_DOUBLE,
    tradingstatus                  VARCHAR2(1 BYTE),
    lastchange                     TIMESTAMP (6),
    clsorddate                     DATE,
    sip                            VARCHAR2(1 BYTE),
    tradingtype                    VARCHAR2(3 BYTE),
    vermatching                    VARCHAR2(100 BYTE),
    totalenav                      BINARY_DOUBLE,
    totalnav                       BINARY_DOUBLE)
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE tradingsessionschd
/

CREATE TABLE tradingsessionschd
    (tradingid                      VARCHAR2(50 BYTE) NOT NULL,
    codeid                         VARCHAR2(50 BYTE),
    tradingdate                    DATE,
    matchdate                      DATE,
    execdateccq                    DATE,
    execdatecash                   DATE,
    txdate                         DATE,
    tradingstatus                  VARCHAR2(1 BYTE),
    clsorddate                     DATE,
    sip                            VARCHAR2(1 BYTE) DEFAULT 'N',
    tradingtype                    VARCHAR2(3 BYTE) DEFAULT 'NOR',
    vermatching                    VARCHAR2(100 BYTE) DEFAULT '0',
    lastchange                     TIMESTAMP (6) DEFAULT to_date('0001-01-01 00:00:00', 'YYYY-MM-DD hh24:mi:ss'))
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE transferdetail
/

CREATE TABLE transferdetail
    (autoid                         NUMBER,
    custodycd                      VARCHAR2(100 BYTE),
    symbol                         VARCHAR2(100 BYTE),
    tltxcd                         VARCHAR2(100 BYTE),
    txdate                         DATE,
    qtty                           NUMBER,
    amt                            NUMBER,
    feeamt                         NUMBER,
    taxamt                         NUMBER,
    txtype                         VARCHAR2(10 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  LOGGING
  MONITORING
/

DROP TABLE transfermoney
/

CREATE TABLE transfermoney
    (acctno                         VARCHAR2(15 BYTE),
    symbol                         VARCHAR2(15 BYTE),
    issueddt                       DATE,
    amt                            NUMBER,
    notes                          VARCHAR2(4000 BYTE),
    status                         VARCHAR2(10 BYTE) DEFAULT 'P',
    pstatus                        VARCHAR2(10 BYTE),
    lastchange                     TIMESTAMP (6) DEFAULT to_date('0001-01-01 00:00:00', 'YYYY-MM-DD hh24:mi:ss'),
    refid                          FLOAT(64))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE transfermoney_bk
/

CREATE TABLE transfermoney_bk
    (acctno                         VARCHAR2(15 BYTE),
    symbol                         VARCHAR2(15 BYTE),
    issueddt                       DATE,
    amt                            BINARY_DOUBLE,
    notes                          VARCHAR2(4000 BYTE),
    status                         VARCHAR2(10 BYTE),
    pstatus                        VARCHAR2(10 BYTE),
    lastchange                     TIMESTAMP (6),
    refid                          FLOAT(64))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

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

