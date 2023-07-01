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
  SEGMENT CREATION DEFERRED
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
  SEGMENT CREATION DEFERRED
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
  SEGMENT CREATION DEFERRED
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
    feetype                        VARCHAR2(20 BYTE))
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

DROP TABLE feeapplyflt
/

CREATE TABLE feeapplyflt
    (id                             FLOAT(64) NOT NULL,
    aplid                          VARCHAR2(10 BYTE),
    sqlstr                         VARCHAR2(500 BYTE),
    status                         VARCHAR2(1 BYTE),
    pstatus                        VARCHAR2(4000 BYTE),
    lastchange                     TIMESTAMP (6))
  SEGMENT CREATION DEFERRED
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
  SEGMENT CREATION DEFERRED
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
  SEGMENT CREATION DEFERRED
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
  SEGMENT CREATION DEFERRED
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
    calcmethod                     VARCHAR2(10 BYTE))
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
    calcmethod                     VARCHAR2(10 BYTE))
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
  SEGMENT CREATION DEFERRED
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
  SEGMENT CREATION DEFERRED
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
  SEGMENT CREATION DEFERRED
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
  SEGMENT CREATION DEFERRED
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
  SEGMENT CREATION DEFERRED
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
  SEGMENT CREATION DEFERRED
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
  SEGMENT CREATION DEFERRED
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
  SEGMENT CREATION DEFERRED
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
  SEGMENT CREATION DEFERRED
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
  SEGMENT CREATION DEFERRED
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
  SEGMENT CREATION DEFERRED
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
  SEGMENT CREATION DEFERRED
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
  SEGMENT CREATION DEFERRED
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
  SEGMENT CREATION DEFERRED
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
  SEGMENT CREATION DEFERRED
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
  SEGMENT CREATION DEFERRED
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
  SEGMENT CREATION DEFERRED
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
  SEGMENT CREATION DEFERRED
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
    symbol                         VARCHAR2(15 BYTE),
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
    symbol                         VARCHAR2(15 BYTE),
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
    accr                           NUMBER(38,0) DEFAULT 0,
    fee                            NUMBER(38,0) DEFAULT 0,
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
  SEGMENT CREATION DEFERRED
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
    udfname                        VARCHAR2(500 BYTE))
  SEGMENT CREATION IMMEDIATE
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
  SEGMENT CREATION DEFERRED
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
  SEGMENT CREATION DEFERRED
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
  SEGMENT CREATION DEFERRED
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
  SEGMENT CREATION DEFERRED
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
  SEGMENT CREATION DEFERRED
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
  SEGMENT CREATION DEFERRED
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
  SEGMENT CREATION DEFERRED
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
  SEGMENT CREATION DEFERRED
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
  SEGMENT CREATION DEFERRED
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
  SEGMENT CREATION DEFERRED
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
  SEGMENT CREATION DEFERRED
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
  SEGMENT CREATION DEFERRED
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
  SEGMENT CREATION DEFERRED
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
  SEGMENT CREATION DEFERRED
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
  SEGMENT CREATION DEFERRED
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
  SEGMENT CREATION DEFERRED
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
  SEGMENT CREATION DEFERRED
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
    isrmsales                      VARCHAR2(10 BYTE) DEFAULT 'Y')
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
  SEGMENT CREATION DEFERRED
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
    ttkd_tlid                      VARCHAR2(30 BYTE),
    ttkd_offid                     VARCHAR2(30 BYTE),
    bks_tlid                       VARCHAR2(30 BYTE),
    bks_offid                      VARCHAR2(30 BYTE),
    shs_tlid                       VARCHAR2(30 BYTE),
    intrate                        NUMBER)
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
  SEGMENT CREATION DEFERRED
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
  SEGMENT CREATION DEFERRED
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
    cfonline                       VARCHAR2(10 BYTE))
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
    maxqtty                        NUMBER)
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
    acbuyer                        VARCHAR2(30 BYTE))
  SEGMENT CREATION IMMEDIATE
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE p_autoid
/

CREATE TABLE p_autoid
    (autoid                         FLOAT(64))
  SEGMENT CREATION DEFERRED
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE p_date
/

CREATE TABLE p_date
    (id                             FLOAT(64))
  SEGMENT CREATION DEFERRED
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
  SEGMENT CREATION DEFERRED
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE p_test
/

CREATE TABLE p_test
    (reporttemplate                 VARCHAR2(255 BYTE))
  SEGMENT CREATION DEFERRED
  NOPARALLEL
  NOLOGGING
  MONITORING
/

DROP TABLE p_tlidgt
/

CREATE TABLE p_tlidgt
    (tlid                           VARCHAR2(6 BYTE))
  SEGMENT CREATION DEFERRED
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
  SEGMENT CREATION DEFERRED
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
    symbol                         VARCHAR2(15 BYTE),
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
    symbol                         VARCHAR2(15 BYTE),
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
  SEGMENT CREATION DEFERRED
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
    sellmin                        NUMBER)
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

ALTER TABLE productbuydtl
ADD PRIMARY KEY (autoid)
USING INDEX
/

DROP TABLE productbuydtladj
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

DROP TABLE productbuydtlmemo
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

DROP TABLE productcoupondtl
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

DROP TABLE productcoupondtlmemo
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

DROP TABLE productcpndtladj
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
    sellmax                        NUMBER)
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

DROP TABLE productselldtlmemo
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

DROP TABLE professioninfo
/

CREATE TABLE professioninfo
    (idcode                         VARCHAR2(20 BYTE),
    professionfrdate               DATE,
    professiontodate               DATE,
    seaccount                      VARCHAR2(500 BYTE),
    ciaccount                      VARCHAR2(500 BYTE),
    secif                          VARCHAR2(500 BYTE))
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

