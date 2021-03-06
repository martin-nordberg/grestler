--
-- (C) Copyright 2015 Martin E. Nordberg III
-- Apache 2.0 License
--

------------------------
-- Documented Element --
------------------------

-- Table
CREATE TABLE GRESTLER_DOCUMENTED_ELEMENT (
    ID UUID NOT NULL
);

-- Primary key
CREATE PRIMARY KEY PK_GRESTLER_DOCUMENTED_ELEMENT ON GRESTLER_DOCUMENTED_ELEMENT(ID);


----------------------
-- Packaged Element --
----------------------

-- Table
CREATE TABLE GRESTLER_PACKAGED_ELEMENT (
    ID UUID NOT NULL,
    PARENT_PACKAGE_ID UUID NOT NULL,
    NAME VARCHAR(256) NOT NULL
);

-- Primary key
CREATE PRIMARY KEY PK_GRESTLER_PACKAGE_ELEMENT ON GRESTLER_PACKAGED_ELEMENT(ID);

-- Foreign Keys
ALTER TABLE GRESTLER_PACKAGED_ELEMENT ADD CONSTRAINT FK_GRESTLER_PACKAGED_ELEMENT__ID
    FOREIGN KEY (ID) REFERENCES GRESTLER_DOCUMENTED_ELEMENT(ID) ON DELETE CASCADE;

-- Constraints
ALTER TABLE GRESTLER_PACKAGED_ELEMENT ADD CONSTRAINT UQ_GRESTLER_PACKAGED_ELEMENT__NAME
    UNIQUE (PARENT_PACKAGE_ID,NAME);

-- Indexes
CREATE INDEX IDX_GRESTLER_PACKAGED_ELEMENT__NAME ON GRESTLER_PACKAGED_ELEMENT(NAME);


-------------
-- Package --
-------------

-- Table
CREATE TABLE GRESTLER_PACKAGE (
    ID UUID NOT NULL
);

-- Primary key
CREATE PRIMARY KEY PK_GRESTLER_PACKAGE ON GRESTLER_PACKAGE(ID);

-- Foreign keys
ALTER TABLE GRESTLER_PACKAGE ADD CONSTRAINT FK_GRESTLER_PACKAGE__ID
    FOREIGN KEY (ID) REFERENCES GRESTLER_PACKAGED_ELEMENT(ID) ON DELETE CASCADE;

-- View
CREATE VIEW GRESTLER_VIEW_PACKAGE
  AS SELECT GRESTLER_PACKAGED_ELEMENT.ID,
            GRESTLER_PACKAGED_ELEMENT.PARENT_PACKAGE_ID,
            GRESTLER_PACKAGED_ELEMENT.NAME
       FROM GRESTLER_PACKAGE
            INNER JOIN GRESTLER_PACKAGED_ELEMENT ON GRESTLER_PACKAGE.ID = GRESTLER_PACKAGED_ELEMENT.ID;


------------------------
-- Package Dependency --
------------------------

-- Table
CREATE TABLE GRESTLER_PACKAGE_DEPENDENCY (
    ID UUID NOT NULL,
    CLIENT_PACKAGE_ID UUID NOT NULL,
    SUPPLIER_PACKAGE_ID UUID NOT NULL
);

-- Primary key
CREATE PRIMARY KEY PK_GRESTLER_PACKAGE_DEPENDENCY ON GRESTLER_PACKAGE_DEPENDENCY(ID);

-- Foreign keys
ALTER TABLE GRESTLER_PACKAGE_DEPENDENCY ADD CONSTRAINT FK_GRESTLER_PACKAGE_DEPENDENCY__ID
    FOREIGN KEY (ID) REFERENCES GRESTLER_DOCUMENTED_ELEMENT(ID) ON DELETE CASCADE;
ALTER TABLE GRESTLER_PACKAGE_DEPENDENCY ADD CONSTRAINT FK_GRESTLER_PACKAGE_DEPENDENCY__CLIENT_PACKAGE
    FOREIGN KEY (CLIENT_PACKAGE_ID) REFERENCES GRESTLER_PACKAGE(ID) ON DELETE CASCADE;
ALTER TABLE GRESTLER_PACKAGE_DEPENDENCY ADD CONSTRAINT FK_GRESTLER_PACKAGE_DEPENDENCY__SUPPLIER_PACKAGE
    FOREIGN KEY (SUPPLIER_PACKAGE_ID) REFERENCES GRESTLER_PACKAGE(ID);

-- Constraints
ALTER TABLE GRESTLER_PACKAGE_DEPENDENCY ADD CONSTRAINT UQ_GRESTLER_PACKAGE_DEPENDENCY
    UNIQUE (CLIENT_PACKAGE_ID,SUPPLIER_PACKAGE_ID);


--------------------
-- Attribute Type --
--------------------

-- Table
CREATE TABLE GRESTLER_ATTRIBUTE_TYPE (
    ID UUID NOT NULL
);

-- Primary key
CREATE PRIMARY KEY PK_GRESTLER_ATTRIBUTE_TYPE ON GRESTLER_ATTRIBUTE_TYPE(ID);

-- Foreign keys
ALTER TABLE GRESTLER_ATTRIBUTE_TYPE ADD CONSTRAINT FK_GRESTLER_ATTRIBUTE_TYPE__ID
    FOREIGN KEY (ID) REFERENCES GRESTLER_PACKAGED_ELEMENT(ID) ON DELETE CASCADE;


----------------------------
-- Boolean Attribute Type --
----------------------------

-- Table
CREATE TABLE GRESTLER_BOOLEAN_ATTRIBUTE_TYPE (
    ID UUID NOT NULL,
    DEFAULT_VALUE BOOLEAN
);

-- Primary key
CREATE PRIMARY KEY PK_GRESTLER_BOOLEAN_ATTRIBUTE_TYPE ON GRESTLER_BOOLEAN_ATTRIBUTE_TYPE(ID);

-- Foreign keys
ALTER TABLE GRESTLER_BOOLEAN_ATTRIBUTE_TYPE ADD CONSTRAINT FK_GRESTLER_BOOLEAN_ATTRIBUTE_TYPE__ID
    FOREIGN KEY (ID) REFERENCES GRESTLER_ATTRIBUTE_TYPE(ID) ON DELETE CASCADE;

-- View
CREATE VIEW GRESTLER_VIEW_BOOLEAN_ATTRIBUTE_TYPE
  AS SELECT GRESTLER_PACKAGED_ELEMENT.ID,
            GRESTLER_PACKAGED_ELEMENT.PARENT_PACKAGE_ID,
            GRESTLER_PACKAGED_ELEMENT.NAME,
            GRESTLER_BOOLEAN_ATTRIBUTE_TYPE.DEFAULT_VALUE
       FROM GRESTLER_BOOLEAN_ATTRIBUTE_TYPE
            INNER JOIN GRESTLER_PACKAGED_ELEMENT ON GRESTLER_BOOLEAN_ATTRIBUTE_TYPE.ID = GRESTLER_PACKAGED_ELEMENT.ID;


------------------------------
-- Date/Time Attribute Type --
------------------------------

CREATE TABLE GRESTLER_DATETIME_ATTRIBUTE_TYPE (
    ID UUID NOT NULL,
    MIN_VALUE TIMESTAMP,
    MAX_VALUE TIMESTAMP
    -- TODO: default value == now ?
);

-- Primary key
CREATE PRIMARY KEY PK_GRESTLER_DATETIME_ATTRIBUTE_TYPE ON GRESTLER_DATETIME_ATTRIBUTE_TYPE(ID);

-- Foreign keys
ALTER TABLE GRESTLER_DATETIME_ATTRIBUTE_TYPE ADD CONSTRAINT FK_GRESTLER_DATETIME_ATTRIBUTE_TYPE__ID
    FOREIGN KEY (ID) REFERENCES GRESTLER_ATTRIBUTE_TYPE(ID) ON DELETE CASCADE;

-- View
CREATE VIEW GRESTLER_VIEW_DATETIME_ATTRIBUTE_TYPE
  AS SELECT GRESTLER_PACKAGED_ELEMENT.ID,
            GRESTLER_PACKAGED_ELEMENT.PARENT_PACKAGE_ID,
            GRESTLER_PACKAGED_ELEMENT.NAME,
            GRESTLER_DATETIME_ATTRIBUTE_TYPE.MIN_VALUE,
            GRESTLER_DATETIME_ATTRIBUTE_TYPE.MAX_VALUE
       FROM GRESTLER_DATETIME_ATTRIBUTE_TYPE
            INNER JOIN GRESTLER_PACKAGED_ELEMENT ON GRESTLER_DATETIME_ATTRIBUTE_TYPE.ID = GRESTLER_PACKAGED_ELEMENT.ID;


----------------------------
-- Float32 Attribute Type --
----------------------------

-- TODO ...


------------------------------
-- Float64 Attribute Type --
------------------------------

CREATE TABLE GRESTLER_FLOAT64_ATTRIBUTE_TYPE (
    ID UUID NOT NULL,
    MIN_VALUE DOUBLE,
    MAX_VALUE DOUBLE,
    DEFAULT_VALUE DOUBLE
);

-- Primary key
CREATE PRIMARY KEY PK_GRESTLER_FLOAT64_ATTRIBUTE_TYPE ON GRESTLER_FLOAT64_ATTRIBUTE_TYPE(ID);

-- Foreign keys
ALTER TABLE GRESTLER_FLOAT64_ATTRIBUTE_TYPE ADD CONSTRAINT FK_GRESTLER_FLOAT64_ATTRIBUTE_TYPE__ID
    FOREIGN KEY (ID) REFERENCES GRESTLER_ATTRIBUTE_TYPE(ID) ON DELETE CASCADE;

-- View
CREATE VIEW GRESTLER_VIEW_FLOAT64_ATTRIBUTE_TYPE
  AS SELECT GRESTLER_PACKAGED_ELEMENT.ID,
            GRESTLER_PACKAGED_ELEMENT.PARENT_PACKAGE_ID,
            GRESTLER_PACKAGED_ELEMENT.NAME,
            GRESTLER_FLOAT64_ATTRIBUTE_TYPE.MIN_VALUE,
            GRESTLER_FLOAT64_ATTRIBUTE_TYPE.MAX_VALUE,
            GRESTLER_FLOAT64_ATTRIBUTE_TYPE.DEFAULT_VALUE
       FROM GRESTLER_FLOAT64_ATTRIBUTE_TYPE
            INNER JOIN GRESTLER_PACKAGED_ELEMENT ON GRESTLER_FLOAT64_ATTRIBUTE_TYPE.ID = GRESTLER_PACKAGED_ELEMENT.ID;


-----------------------------
-- Integer8 Attribute Type --
-----------------------------

-- TODO ...


------------------------------
-- Integer16 Attribute Type --
------------------------------

-- TODO ...


------------------------------
-- Integer32 Attribute Type --
------------------------------

CREATE TABLE GRESTLER_INTEGER32_ATTRIBUTE_TYPE (
    ID UUID NOT NULL,
    MIN_VALUE INTEGER,
    MAX_VALUE INTEGER,
    DEFAULT_VALUE INTEGER
);

-- Primary key
CREATE PRIMARY KEY PK_GRESTLER_INTEGER32_ATTRIBUTE_TYPE ON GRESTLER_INTEGER32_ATTRIBUTE_TYPE(ID);

-- Foreign keys
ALTER TABLE GRESTLER_INTEGER32_ATTRIBUTE_TYPE ADD CONSTRAINT FK_GRESTLER_INTEGER32_ATTRIBUTE_TYPE__ID
    FOREIGN KEY (ID) REFERENCES GRESTLER_ATTRIBUTE_TYPE(ID) ON DELETE CASCADE;

-- View
CREATE VIEW GRESTLER_VIEW_INTEGER32_ATTRIBUTE_TYPE
  AS SELECT GRESTLER_PACKAGED_ELEMENT.ID,
            GRESTLER_PACKAGED_ELEMENT.PARENT_PACKAGE_ID,
            GRESTLER_PACKAGED_ELEMENT.NAME,
            GRESTLER_INTEGER32_ATTRIBUTE_TYPE.MIN_VALUE,
            GRESTLER_INTEGER32_ATTRIBUTE_TYPE.MAX_VALUE,
            GRESTLER_INTEGER32_ATTRIBUTE_TYPE.DEFAULT_VALUE
       FROM GRESTLER_INTEGER32_ATTRIBUTE_TYPE
            INNER JOIN GRESTLER_PACKAGED_ELEMENT ON GRESTLER_INTEGER32_ATTRIBUTE_TYPE.ID = GRESTLER_PACKAGED_ELEMENT.ID;


------------------------------
-- Integer64 Attribute Type --
------------------------------

-- TODO ...


----------------------------------
-- JSON Document Attribute Type --
----------------------------------

-- TODO ...


------------------------------
-- String Attribute Type --
------------------------------

CREATE TABLE GRESTLER_STRING_ATTRIBUTE_TYPE (
    ID UUID NOT NULL,
    MIN_LENGTH INTEGER,
    MAX_LENGTH INTEGER NOT NULL,
    REGEX_PATTERN VARCHAR(1024)
);

-- Primary key
CREATE PRIMARY KEY PK_GRESTLER_STRING_ATTRIBUTE_TYPE ON GRESTLER_STRING_ATTRIBUTE_TYPE(ID);

-- Foreign keys
ALTER TABLE GRESTLER_STRING_ATTRIBUTE_TYPE ADD CONSTRAINT FK_GRESTLER_STRING_ATTRIBUTE_TYPE__ID
    FOREIGN KEY (ID) REFERENCES GRESTLER_ATTRIBUTE_TYPE(ID) ON DELETE CASCADE;

-- View
CREATE VIEW GRESTLER_VIEW_STRING_ATTRIBUTE_TYPE
  AS SELECT GRESTLER_PACKAGED_ELEMENT.ID,
            GRESTLER_PACKAGED_ELEMENT.PARENT_PACKAGE_ID,
            GRESTLER_PACKAGED_ELEMENT.NAME,
            GRESTLER_STRING_ATTRIBUTE_TYPE.MIN_LENGTH,
            GRESTLER_STRING_ATTRIBUTE_TYPE.MAX_LENGTH,
            GRESTLER_STRING_ATTRIBUTE_TYPE.REGEX_PATTERN
       FROM GRESTLER_STRING_ATTRIBUTE_TYPE
            INNER JOIN GRESTLER_PACKAGED_ELEMENT ON GRESTLER_STRING_ATTRIBUTE_TYPE.ID = GRESTLER_PACKAGED_ELEMENT.ID;


----------------------------
-- UUID Attribute Type --
----------------------------

-- Table
CREATE TABLE GRESTLER_UUID_ATTRIBUTE_TYPE (
    ID UUID NOT NULL
);

-- Primary key
CREATE PRIMARY KEY PK_GRESTLER_UUID_ATTRIBUTE_TYPE ON GRESTLER_UUID_ATTRIBUTE_TYPE(ID);

-- Foreign keys
ALTER TABLE GRESTLER_UUID_ATTRIBUTE_TYPE ADD CONSTRAINT FK_GRESTLER_UUID_ATTRIBUTE_TYPE__ID
    FOREIGN KEY (ID) REFERENCES GRESTLER_ATTRIBUTE_TYPE(ID) ON DELETE CASCADE;

-- View
CREATE VIEW GRESTLER_VIEW_UUID_ATTRIBUTE_TYPE
  AS SELECT GRESTLER_PACKAGED_ELEMENT.ID,
            GRESTLER_PACKAGED_ELEMENT.PARENT_PACKAGE_ID,
            GRESTLER_PACKAGED_ELEMENT.NAME
       FROM GRESTLER_UUID_ATTRIBUTE_TYPE
            INNER JOIN GRESTLER_PACKAGED_ELEMENT ON GRESTLER_UUID_ATTRIBUTE_TYPE.ID = GRESTLER_PACKAGED_ELEMENT.ID;


-----------------
-- Vertex Type --
-----------------

-- Table
CREATE TABLE GRESTLER_VERTEX_TYPE (
    ID UUID NOT NULL,
    SUPER_TYPE_ID UUID NOT NULL,
    IS_ABSTRACT BOOLEAN NOT NULL
);

-- Primary key
CREATE PRIMARY KEY PK_GRESTLER_VERTEX_TYPE ON GRESTLER_VERTEX_TYPE(ID);

-- Foreign keys
ALTER TABLE GRESTLER_VERTEX_TYPE ADD CONSTRAINT FK_GRESTLER_VERTEX_TYPE__ID
    FOREIGN KEY (ID) REFERENCES GRESTLER_PACKAGED_ELEMENT(ID) ON DELETE CASCADE;
ALTER TABLE GRESTLER_VERTEX_TYPE ADD CONSTRAINT FK_GRESTLER_VERTEX_TYPE__SUPER_TYPE
    FOREIGN KEY (SUPER_TYPE_ID) REFERENCES GRESTLER_VERTEX_TYPE(ID);

-- Indexes
CREATE INDEX IDX_GRESTLER_VERTEX_TYPE__IS_ABSTRACT ON GRESTLER_VERTEX_TYPE(IS_ABSTRACT);

-- View
CREATE VIEW GRESTLER_VIEW_VERTEX_TYPE
  AS SELECT GRESTLER_PACKAGED_ELEMENT.ID,
            GRESTLER_PACKAGED_ELEMENT.PARENT_PACKAGE_ID,
            GRESTLER_PACKAGED_ELEMENT.NAME,
            GRESTLER_VERTEX_TYPE.SUPER_TYPE_ID,
            GRESTLER_VERTEX_TYPE.IS_ABSTRACT
       FROM GRESTLER_VERTEX_TYPE
            INNER JOIN GRESTLER_PACKAGED_ELEMENT ON GRESTLER_VERTEX_TYPE.ID = GRESTLER_PACKAGED_ELEMENT.ID;


----------------------------------
-- Vertex Attribute Declaration --
----------------------------------

-- Table
CREATE TABLE GRESTLER_VERTEX_ATTRIBUTE_DECL (
    ID UUID NOT NULL,
    PARENT_VERTEX_TYPE_ID UUID NOT NULL,
    NAME VARCHAR(256) NOT NULL,
    ATTRIBUTE_TYPE_ID UUID NOT NULL,
    IS_REQUIRED BOOLEAN NOT NULL,
    IS_DEFAULT_LABEL BOOLEAN NOT NULL
);

-- Primary key
CREATE PRIMARY KEY PK_GRESTLER_VERTEX_ATTRIBUTE_DECL ON GRESTLER_VERTEX_ATTRIBUTE_DECL(ID);

-- Foreign keys
ALTER TABLE GRESTLER_VERTEX_ATTRIBUTE_DECL ADD CONSTRAINT FK_GRESTLER_VERTEX_ATTRIBUTE_DECL__ID
    FOREIGN KEY (ID) REFERENCES GRESTLER_DOCUMENTED_ELEMENT(ID) ON DELETE CASCADE;
ALTER TABLE GRESTLER_VERTEX_ATTRIBUTE_DECL ADD CONSTRAINT FK_GRESTLER_VERTEX_ATTRIBUTE_DECL__PARENT_VERTEX_TYPE
    FOREIGN KEY (PARENT_VERTEX_TYPE_ID) REFERENCES GRESTLER_VERTEX_TYPE(ID) ON DELETE CASCADE;
ALTER TABLE GRESTLER_VERTEX_ATTRIBUTE_DECL ADD CONSTRAINT FK_GRESTLER_VERTEX_ATTRIBUTE_DECL__ATTRIBUTE_TYPE
    FOREIGN KEY (ATTRIBUTE_TYPE_ID) REFERENCES GRESTLER_ATTRIBUTE_TYPE(ID);

-- Constraints
ALTER TABLE GRESTLER_VERTEX_ATTRIBUTE_DECL ADD CONSTRAINT UQ_GRESTLER_VERTEX_ATTRIBUTE_DECL__NAME
    UNIQUE (PARENT_VERTEX_TYPE_ID,NAME);

-- Indexes
CREATE INDEX IDX_GRESTLER_VERTEX_ATTRIBUTE_DECL__NAME ON GRESTLER_VERTEX_ATTRIBUTE_DECL(NAME);



-- TODO: Computed attribute types from formula


---------------
-- Edge Type --
---------------

-- Table
CREATE TABLE GRESTLER_EDGE_TYPE (
    ID UUID NOT NULL,
    SUPER_TYPE_ID UUID NOT NULL,
    IS_ABSTRACT BOOLEAN NOT NULL,
    IS_ACYCLIC BOOLEAN,
    IS_MULTI_EDGE_ALLOWED BOOLEAN,
    IS_SELF_LOOP_ALLOWED BOOLEAN
);

-- Primary key
CREATE PRIMARY KEY PK_GRESTLER_EDGE_TYPE ON GRESTLER_EDGE_TYPE(ID);

-- Foreign keys
ALTER TABLE GRESTLER_EDGE_TYPE ADD CONSTRAINT FK_GRESTLER_EDGE_TYPE__ID
    FOREIGN KEY (ID) REFERENCES GRESTLER_PACKAGED_ELEMENT(ID);
ALTER TABLE GRESTLER_EDGE_TYPE ADD CONSTRAINT FK_GRESTLER_EDGE_TYPE__SUPER_TYPE
    FOREIGN KEY (SUPER_TYPE_ID) REFERENCES GRESTLER_EDGE_TYPE(ID);

-- Indexes
CREATE INDEX IDX_GRESTLER_EDGE_TYPE__IS_ABSTRACT ON GRESTLER_EDGE_TYPE(IS_ABSTRACT);


------------------------
-- Directed Edge Type --
------------------------

-- Table
CREATE TABLE GRESTLER_DIRECTED_EDGE_TYPE (
    ID UUID NOT NULL,
    TAIL_VERTEX_TYPE_ID UUID NOT NULL,
    HEAD_VERTEX_TYPE_ID UUID NOT NULL,
    TAIL_ROLE_NAME VARCHAR(256),
    HEAD_ROLE_NAME VARCHAR(256),
    MIN_TAIL_OUT_DEGREE INTEGER,
    MAX_TAIL_OUT_DEGREE INTEGER,
    MIN_HEAD_IN_DEGREE INTEGER,
    MAX_HEAD_IN_DEGREE INTEGER
);

-- Primary key
CREATE PRIMARY KEY PK_GRESTLER_DIRECTED_EDGE_TYPE ON GRESTLER_DIRECTED_EDGE_TYPE(ID);

-- Foreign keys
ALTER TABLE GRESTLER_DIRECTED_EDGE_TYPE ADD CONSTRAINT FK_GRESTLER_DIRECTED_EDGE_TYPE__ID
    FOREIGN KEY (ID) REFERENCES GRESTLER_EDGE_TYPE(ID) ON DELETE CASCADE;
ALTER TABLE GRESTLER_DIRECTED_EDGE_TYPE ADD CONSTRAINT FK_GRESTLER_DIRECTED_EDGE_TYPE__TAIL_VERTEX_TYPE
    FOREIGN KEY (TAIL_VERTEX_TYPE_ID) REFERENCES GRESTLER_VERTEX_TYPE(ID);
ALTER TABLE GRESTLER_DIRECTED_EDGE_TYPE ADD CONSTRAINT FK_GRESTLER_DIRECTED_EDGE_TYPE__HEAD_VERTEX_TYPE
    FOREIGN KEY (HEAD_VERTEX_TYPE_ID) REFERENCES GRESTLER_VERTEX_TYPE(ID);

-- View
CREATE VIEW GRESTLER_VIEW_DIRECTED_EDGE_TYPE
  AS SELECT GRESTLER_PACKAGED_ELEMENT.ID,
            GRESTLER_PACKAGED_ELEMENT.PARENT_PACKAGE_ID,
            GRESTLER_PACKAGED_ELEMENT.NAME,
            GRESTLER_EDGE_TYPE.SUPER_TYPE_ID,
            GRESTLER_EDGE_TYPE.IS_ABSTRACT,
            GRESTLER_EDGE_TYPE.IS_ACYCLIC,
            GRESTLER_EDGE_TYPE.IS_MULTI_EDGE_ALLOWED,
            GRESTLER_EDGE_TYPE.IS_SELF_LOOP_ALLOWED,
            GRESTLER_DIRECTED_EDGE_TYPE.TAIL_VERTEX_TYPE_ID,
            GRESTLER_DIRECTED_EDGE_TYPE.HEAD_VERTEX_TYPE_ID,
            GRESTLER_DIRECTED_EDGE_TYPE.TAIL_ROLE_NAME,
            GRESTLER_DIRECTED_EDGE_TYPE.HEAD_ROLE_NAME,
            GRESTLER_DIRECTED_EDGE_TYPE.MIN_TAIL_OUT_DEGREE,
            GRESTLER_DIRECTED_EDGE_TYPE.MAX_TAIL_OUT_DEGREE,
            GRESTLER_DIRECTED_EDGE_TYPE.MIN_HEAD_IN_DEGREE,
            GRESTLER_DIRECTED_EDGE_TYPE.MAX_HEAD_IN_DEGREE
       FROM GRESTLER_DIRECTED_EDGE_TYPE
            INNER JOIN GRESTLER_EDGE_TYPE ON GRESTLER_DIRECTED_EDGE_TYPE.ID = GRESTLER_EDGE_TYPE.ID
            INNER JOIN GRESTLER_PACKAGED_ELEMENT ON GRESTLER_EDGE_TYPE.ID = GRESTLER_PACKAGED_ELEMENT.ID;


--------------------------
-- Undirected Edge Type --
--------------------------

-- Table
CREATE TABLE GRESTLER_UNDIRECTED_EDGE_TYPE (
    ID UUID NOT NULL,
    VERTEX_TYPE_ID UUID NOT NULL,
    MIN_DEGREE INTEGER,
    MAX_DEGREE INTEGER
);

-- Primary key
CREATE PRIMARY KEY PK_GRESTLER_UNDIRECTED_EDGE_TYPE ON GRESTLER_UNDIRECTED_EDGE_TYPE(ID);

-- Foreign keys
ALTER TABLE GRESTLER_UNDIRECTED_EDGE_TYPE ADD CONSTRAINT FK_GRESTLER_UNDIRECTED_EDGE_TYPE__ID
    FOREIGN KEY (ID) REFERENCES GRESTLER_EDGE_TYPE(ID) ON DELETE CASCADE;
ALTER TABLE GRESTLER_UNDIRECTED_EDGE_TYPE ADD CONSTRAINT FK_GRESTLER_UNDIRECTED_EDGE_TYPE__VERTEX_TYPE
    FOREIGN KEY (VERTEX_TYPE_ID) REFERENCES GRESTLER_VERTEX_TYPE(ID);

-- View
CREATE VIEW GRESTLER_VIEW_UNDIRECTED_EDGE_TYPE
  AS SELECT GRESTLER_PACKAGED_ELEMENT.ID,
            GRESTLER_PACKAGED_ELEMENT.PARENT_PACKAGE_ID,
            GRESTLER_PACKAGED_ELEMENT.NAME,
            GRESTLER_EDGE_TYPE.SUPER_TYPE_ID,
            GRESTLER_EDGE_TYPE.IS_ABSTRACT,
            GRESTLER_EDGE_TYPE.IS_ACYCLIC,
            GRESTLER_EDGE_TYPE.IS_MULTI_EDGE_ALLOWED,
            GRESTLER_EDGE_TYPE.IS_SELF_LOOP_ALLOWED,
            GRESTLER_UNDIRECTED_EDGE_TYPE.VERTEX_TYPE_ID,
            GRESTLER_UNDIRECTED_EDGE_TYPE.MIN_DEGREE,
            GRESTLER_UNDIRECTED_EDGE_TYPE.MAX_DEGREE
       FROM GRESTLER_UNDIRECTED_EDGE_TYPE
            INNER JOIN GRESTLER_EDGE_TYPE ON GRESTLER_UNDIRECTED_EDGE_TYPE.ID = GRESTLER_EDGE_TYPE.ID
            INNER JOIN GRESTLER_PACKAGED_ELEMENT ON GRESTLER_EDGE_TYPE.ID = GRESTLER_PACKAGED_ELEMENT.ID;


--------------------------------
-- Edge Attribute Declaration --
--------------------------------

-- Table
CREATE TABLE GRESTLER_EDGE_ATTRIBUTE_DECL (
    ID UUID NOT NULL,
    PARENT_EDGE_TYPE_ID UUID NOT NULL,
    NAME VARCHAR(256) NOT NULL,
    ATTRIBUTE_TYPE_ID UUID NOT NULL,
    IS_REQUIRED BOOLEAN NOT NULL
);

-- Primary key
CREATE PRIMARY KEY PK_GRESTLER_EDGE_ATTRIBUTE_DECL ON GRESTLER_EDGE_ATTRIBUTE_DECL(ID);

-- Foreign keys
ALTER TABLE GRESTLER_EDGE_ATTRIBUTE_DECL ADD CONSTRAINT FK_GRESTLER_EDGE_ATTRIBUTE_DECL__ID
    FOREIGN KEY (ID) REFERENCES GRESTLER_DOCUMENTED_ELEMENT(ID) ON DELETE CASCADE;
ALTER TABLE GRESTLER_EDGE_ATTRIBUTE_DECL ADD CONSTRAINT FK_GRESTLER_EDGE_ATTRIBUTE_DECL__PARENT_EDGE_TYPE
    FOREIGN KEY (PARENT_EDGE_TYPE_ID) REFERENCES GRESTLER_EDGE_TYPE(ID) ON DELETE CASCADE;
ALTER TABLE GRESTLER_EDGE_ATTRIBUTE_DECL ADD CONSTRAINT FK_GRESTLER_EDGE_ATTRIBUTE_DECL__ATTRIBUTE_TYPE
    FOREIGN KEY (ATTRIBUTE_TYPE_ID) REFERENCES GRESTLER_ATTRIBUTE_TYPE(ID);

-- Indexes
CREATE INDEX IDX_GRESTLER_EDGE_ATTRIBUTE_DECL__NAME ON GRESTLER_EDGE_ATTRIBUTE_DECL(NAME);



-------------
-- Command --
-------------

-- Table
CREATE TABLE GRESTLER_COMMAND (
    CMD_ID UUID NOT NULL,
    CREATION_TIMESTAMP TIMESTAMP NOT NULL,
    COMMAND_TYPE VARCHAR(256) NOT NULL,
    JSON_CMD_ARGS VARCHAR(4096) NOT NULL
);

-- Primary key
CREATE PRIMARY KEY PK_GRESTLER_COMMAND ON GRESTLER_COMMAND(CMD_ID);

-- Indexes
CREATE INDEX IDX_GRESTLER_COMMAND__CREATION_TIMESTAMP ON GRESTLER_COMMAND(CREATION_TIMESTAMP);
CREATE INDEX IDX_GRESTLER_COMMAND__COMMAND_TYPE ON GRESTLER_COMMAND(COMMAND_TYPE);



---------------
-- Instances --
---------------

-- Root package
INSERT INTO GRESTLER_DOCUMENTED_ELEMENT
            ( ID )
     VALUES ( '00000000-7a26-11e4-a545-08002741a702' );
INSERT INTO GRESTLER_PACKAGED_ELEMENT
            ( ID, PARENT_PACKAGE_ID, NAME )
     VALUES ( '00000000-7a26-11e4-a545-08002741a702', '00000000-7a26-11e4-a545-08002741a702', '$' );
INSERT INTO GRESTLER_PACKAGE
            ( ID )
     VALUES ( '00000000-7a26-11e4-a545-08002741a702' );

-- Generic base vertex type
INSERT INTO GRESTLER_DOCUMENTED_ELEMENT
            ( ID )
     VALUES ( '00000010-7a26-11e4-a545-08002741a702' );
INSERT INTO GRESTLER_PACKAGED_ELEMENT
            ( ID, PARENT_PACKAGE_ID, NAME )
     VALUES ( '00000010-7a26-11e4-a545-08002741a702', '00000000-7a26-11e4-a545-08002741a702',
              'Vertex' );
INSERT INTO GRESTLER_VERTEX_TYPE
            ( ID, SUPER_TYPE_ID, IS_ABSTRACT )
     VALUES ( '00000010-7a26-11e4-a545-08002741a702', '00000010-7a26-11e4-a545-08002741a702', TRUE );

-- Generic base directed edge type
INSERT INTO GRESTLER_DOCUMENTED_ELEMENT
            ( ID )
     VALUES ( '00000020-7a26-11e4-a545-08002741a702' );
INSERT INTO GRESTLER_PACKAGED_ELEMENT
            ( ID, PARENT_PACKAGE_ID, NAME )
     VALUES ( '00000020-7a26-11e4-a545-08002741a702', '00000000-7a26-11e4-a545-08002741a702',
              'Directed Edge' );
INSERT INTO GRESTLER_EDGE_TYPE
            ( ID, SUPER_TYPE_ID, IS_ABSTRACT )
     VALUES ( '00000020-7a26-11e4-a545-08002741a702', '00000020-7a26-11e4-a545-08002741a702', TRUE );
INSERT INTO GRESTLER_DIRECTED_EDGE_TYPE
            ( ID, TAIL_VERTEX_TYPE_ID, HEAD_VERTEX_TYPE_ID )
     VALUES ( '00000020-7a26-11e4-a545-08002741a702',
              '00000010-7a26-11e4-a545-08002741a702', '00000010-7a26-11e4-a545-08002741a702' );

-- Generic base undirected edge type
INSERT INTO GRESTLER_DOCUMENTED_ELEMENT
            ( ID )
     VALUES ( '00000030-7a26-11e4-a545-08002741a702' );
INSERT INTO GRESTLER_PACKAGED_ELEMENT
            ( ID, PARENT_PACKAGE_ID, NAME )
     VALUES ( '00000030-7a26-11e4-a545-08002741a702', '00000000-7a26-11e4-a545-08002741a702',
              'Undirected Edge' );
INSERT INTO GRESTLER_EDGE_TYPE
            ( ID, SUPER_TYPE_ID, IS_ABSTRACT )
     VALUES ( '00000030-7a26-11e4-a545-08002741a702', '00000030-7a26-11e4-a545-08002741a702', TRUE );
INSERT INTO GRESTLER_UNDIRECTED_EDGE_TYPE
            ( ID, VERTEX_TYPE_ID )
     VALUES ( '00000030-7a26-11e4-a545-08002741a702', '00000010-7a26-11e4-a545-08002741a702' );


----------------------------
-- Additional Constraints --
----------------------------

-- Packaged items in packages
ALTER TABLE GRESTLER_PACKAGED_ELEMENT ADD CONSTRAINT FK_GRESTLER_PACKAGED_ELEMENT__PARENT_PACKAGE
    FOREIGN KEY (PARENT_PACKAGE_ID) REFERENCES GRESTLER_PACKAGE(ID) ON DELETE CASCADE;

