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
  SEGMENT CREATION DEFERRED
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
  SEGMENT CREATION DEFERRED
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
  SEGMENT CREATION DEFERRED
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
  SEGMENT CREATION DEFERRED
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
    "update"                        DATE)
  SEGMENT CREATION DEFERRED
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
  SEGMENT CREATION DEFERRED
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

DROP TABLE tmp_paymenthist_sereqclose
/

CREATE GLOBAL TEMPORARY TABLE tmp_paymenthist_sereqclose
    (symbol                         VARCHAR2(15 BYTE),
    txdate                         DATE,
    intrate                        NUMBER)
ON COMMIT DELETE ROWS
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
  SEGMENT CREATION DEFERRED
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
  SEGMENT CREATION DEFERRED
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
  SEGMENT CREATION DEFERRED
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
  SEGMENT CREATION DEFERRED
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
  SEGMENT CREATION DEFERRED
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
  SEGMENT CREATION DEFERRED
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
  SEGMENT CREATION DEFERRED
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
  SEGMENT CREATION DEFERRED
  NOPARALLEL
  NOLOGGING
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
  NOLOGGING
  MONITORING
/

CREATE INDEX aq$_txaqs_rptflex2fo_queue_table_t ON txaqs_rptflex2fo_queue_table
  (
    time_manager_info               ASC
  )
NOPARALLEL
NOLOGGING
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
NOLOGGING
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
  SEGMENT CREATION DEFERRED
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
  SEGMENT CREATION DEFERRED
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
  SEGMENT CREATION DEFERRED
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
  SEGMENT CREATION DEFERRED
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
  SEGMENT CREATION DEFERRED
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
  SEGMENT CREATION DEFERRED
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE v_count
/

CREATE TABLE v_count
    (position                       FLOAT(32))
  SEGMENT CREATION DEFERRED
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
  SEGMENT CREATION DEFERRED
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
  SEGMENT CREATION DEFERRED
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE v_rptpath
/

CREATE TABLE v_rptpath
    (varvalue                       VARCHAR2(300 BYTE))
  SEGMENT CREATION DEFERRED
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE v_saleacctno
/

CREATE TABLE v_saleacctno
    (saleacctno                     VARCHAR2(100 BYTE))
  SEGMENT CREATION DEFERRED
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE v_smstype
/

CREATE TABLE v_smstype
    ("?COLUMN?"                     VARCHAR2(4000 BYTE))
  SEGMENT CREATION DEFERRED
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE v_sql
/

CREATE TABLE v_sql
    (searchcmdsql                   VARCHAR2(4000 BYTE))
  SEGMENT CREATION DEFERRED
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
  SEGMENT CREATION DEFERRED
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE v_sumaum
/

CREATE TABLE v_sumaum
    (round                          BINARY_DOUBLE)
  SEGMENT CREATION DEFERRED
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
  SEGMENT CREATION DEFERRED
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
  SEGMENT CREATION DEFERRED
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
  SEGMENT CREATION DEFERRED
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
  SEGMENT CREATION DEFERRED
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

