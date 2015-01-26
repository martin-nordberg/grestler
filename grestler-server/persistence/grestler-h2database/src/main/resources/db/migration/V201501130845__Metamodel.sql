--
-- (C) Copyright 2015 Martin E. Nordberg III
-- Apache 2.0 License
--

-------------
-- Package --
-------------

-- Table
CREATE TABLE GRESTLER_PACKAGE (
    ID UUID NOT NULL,
    PARENT_PACKAGE_ID UUID NOT NULL,
    NAME VARCHAR(256) NOT NULL
);

-- Primary key
ALTER TABLE GRESTLER_PACKAGE ADD CONSTRAINT PK_GRESTLER_PACKAGE
    PRIMARY KEY (ID);

-- Foreign keys
ALTER TABLE GRESTLER_PACKAGE ADD CONSTRAINT FK_GRESTLER_PACKAGE__PARENT_PACKAGE
    FOREIGN KEY (PARENT_PACKAGE_ID) REFERENCES GRESTLER_PACKAGE(ID);

-- Constraints
ALTER TABLE GRESTLER_PACKAGE ADD CONSTRAINT UQ_GRESTLER_PACKAGE__NAME
    UNIQUE (PARENT_PACKAGE_ID,NAME);

-- Root package
INSERT INTO GRESTLER_PACKAGE
            ( ID, PARENT_PACKAGE_ID, NAME )
     VALUES ( '00000000-7a26-11e4-a545-08002741a702', '00000000-7a26-11e4-a545-08002741a702', '$' );


-- TODO: package dependencies ...


--------------------
-- Attribute Type --
--------------------

-- Table
CREATE TABLE GRESTLER_ATTRIBUTE_TYPE (
    ID UUID NOT NULL,
    PARENT_PACKAGE_ID UUID NOT NULL,
    NAME VARCHAR(256) NOT NULL
);

-- Primary key
ALTER TABLE GRESTLER_ATTRIBUTE_TYPE ADD CONSTRAINT PK_GRESTLER_ATTRIBUTE_TYPE
    PRIMARY KEY (ID);

-- Foreign keys
ALTER TABLE GRESTLER_ATTRIBUTE_TYPE ADD CONSTRAINT FK_GRESTLER_ATTRIBUTE_TYPE__PARENT_PACKAGE
    FOREIGN KEY (PARENT_PACKAGE_ID) REFERENCES GRESTLER_PACKAGE(ID);

-- Constraints
ALTER TABLE GRESTLER_ATTRIBUTE_TYPE ADD CONSTRAINT UQ_GRESTLER_ATTRIBUTE_TYPE__NAME
    UNIQUE (PARENT_PACKAGE_ID,NAME);


----------------------------
-- Boolean Attribute Type --
----------------------------

-- Table
CREATE TABLE GRESTLER_BOOLEAN_ATTRIBUTE_TYPE (
    ID UUID NOT NULL
    -- TODO: default value
);

-- Primary key
ALTER TABLE GRESTLER_BOOLEAN_ATTRIBUTE_TYPE ADD CONSTRAINT PK_GRESTLER_BOOLEAN_ATTRIBUTE_TYPE
    PRIMARY KEY (ID);

-- Foreign keys
ALTER TABLE GRESTLER_BOOLEAN_ATTRIBUTE_TYPE ADD CONSTRAINT FK_GRESTLER_BOOLEAN_ATTRIBUTE_TYPE__ID
    FOREIGN KEY (ID) REFERENCES GRESTLER_ATTRIBUTE_TYPE(ID) ON DELETE CASCADE;

-- View
CREATE VIEW GRESTLER_VIEW_BOOLEAN_ATTRIBUTE_TYPE
  AS SELECT GRESTLER_ATTRIBUTE_TYPE.ID,
            GRESTLER_ATTRIBUTE_TYPE.PARENT_PACKAGE_ID,
            GRESTLER_ATTRIBUTE_TYPE.NAME
       FROM GRESTLER_BOOLEAN_ATTRIBUTE_TYPE
            INNER JOIN GRESTLER_ATTRIBUTE_TYPE ON GRESTLER_BOOLEAN_ATTRIBUTE_TYPE.ID = GRESTLER_ATTRIBUTE_TYPE.ID;


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
ALTER TABLE GRESTLER_DATETIME_ATTRIBUTE_TYPE ADD CONSTRAINT PK_GRESTLER_DATETIME_ATTRIBUTE_TYPE
    PRIMARY KEY (ID);

-- Foreign keys
ALTER TABLE GRESTLER_DATETIME_ATTRIBUTE_TYPE ADD CONSTRAINT FK_GRESTLER_DATETIME_ATTRIBUTE_TYPE__ID
    FOREIGN KEY (ID) REFERENCES GRESTLER_ATTRIBUTE_TYPE(ID) ON DELETE CASCADE;

-- View
CREATE VIEW GRESTLER_VIEW_DATETIME_ATTRIBUTE_TYPE
  AS SELECT GRESTLER_ATTRIBUTE_TYPE.ID,
            GRESTLER_ATTRIBUTE_TYPE.PARENT_PACKAGE_ID,
            GRESTLER_ATTRIBUTE_TYPE.NAME,
            GRESTLER_DATETIME_ATTRIBUTE_TYPE.MIN_VALUE,
            GRESTLER_DATETIME_ATTRIBUTE_TYPE.MAX_VALUE
       FROM GRESTLER_DATETIME_ATTRIBUTE_TYPE
            INNER JOIN GRESTLER_ATTRIBUTE_TYPE ON GRESTLER_DATETIME_ATTRIBUTE_TYPE.ID = GRESTLER_ATTRIBUTE_TYPE.ID;


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
    MAX_VALUE DOUBLE
    -- TODO: default value
);

-- Primary key
ALTER TABLE GRESTLER_FLOAT64_ATTRIBUTE_TYPE ADD CONSTRAINT PK_GRESTLER_FLOAT64_ATTRIBUTE_TYPE
    PRIMARY KEY (ID);

-- Foreign keys
ALTER TABLE GRESTLER_FLOAT64_ATTRIBUTE_TYPE ADD CONSTRAINT FK_GRESTLER_FLOAT64_ATTRIBUTE_TYPE__ID
    FOREIGN KEY (ID) REFERENCES GRESTLER_ATTRIBUTE_TYPE(ID) ON DELETE CASCADE;

-- View
CREATE VIEW GRESTLER_VIEW_FLOAT64_ATTRIBUTE_TYPE
  AS SELECT GRESTLER_ATTRIBUTE_TYPE.ID,
            GRESTLER_ATTRIBUTE_TYPE.PARENT_PACKAGE_ID,
            GRESTLER_ATTRIBUTE_TYPE.NAME,
            GRESTLER_FLOAT64_ATTRIBUTE_TYPE.MIN_VALUE,
            GRESTLER_FLOAT64_ATTRIBUTE_TYPE.MAX_VALUE
       FROM GRESTLER_FLOAT64_ATTRIBUTE_TYPE
            INNER JOIN GRESTLER_ATTRIBUTE_TYPE ON GRESTLER_FLOAT64_ATTRIBUTE_TYPE.ID = GRESTLER_ATTRIBUTE_TYPE.ID;


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
    MAX_VALUE INTEGER
    -- TODO: default value
);

-- Primary key
ALTER TABLE GRESTLER_INTEGER32_ATTRIBUTE_TYPE ADD CONSTRAINT PK_GRESTLER_INTEGER32_ATTRIBUTE_TYPE
    PRIMARY KEY (ID);

-- Foreign keys
ALTER TABLE GRESTLER_INTEGER32_ATTRIBUTE_TYPE ADD CONSTRAINT FK_GRESTLER_INTEGER32_ATTRIBUTE_TYPE__ID
    FOREIGN KEY (ID) REFERENCES GRESTLER_ATTRIBUTE_TYPE(ID) ON DELETE CASCADE;

-- View
CREATE VIEW GRESTLER_VIEW_INTEGER32_ATTRIBUTE_TYPE
  AS SELECT GRESTLER_ATTRIBUTE_TYPE.ID,
            GRESTLER_ATTRIBUTE_TYPE.PARENT_PACKAGE_ID,
            GRESTLER_ATTRIBUTE_TYPE.NAME,
            GRESTLER_INTEGER32_ATTRIBUTE_TYPE.MIN_VALUE,
            GRESTLER_INTEGER32_ATTRIBUTE_TYPE.MAX_VALUE
       FROM GRESTLER_INTEGER32_ATTRIBUTE_TYPE
            INNER JOIN GRESTLER_ATTRIBUTE_TYPE ON GRESTLER_INTEGER32_ATTRIBUTE_TYPE.ID = GRESTLER_ATTRIBUTE_TYPE.ID;


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
    -- TODO: default value?
);

-- Primary key
ALTER TABLE GRESTLER_STRING_ATTRIBUTE_TYPE ADD CONSTRAINT PK_GRESTLER_STRING_ATTRIBUTE_TYPE
    PRIMARY KEY (ID);

-- Foreign keys
ALTER TABLE GRESTLER_STRING_ATTRIBUTE_TYPE ADD CONSTRAINT FK_GRESTLER_STRING_ATTRIBUTE_TYPE__ID
    FOREIGN KEY (ID) REFERENCES GRESTLER_ATTRIBUTE_TYPE(ID) ON DELETE CASCADE;

-- View
CREATE VIEW GRESTLER_VIEW_STRING_ATTRIBUTE_TYPE
  AS SELECT GRESTLER_ATTRIBUTE_TYPE.ID,
            GRESTLER_ATTRIBUTE_TYPE.PARENT_PACKAGE_ID,
            GRESTLER_ATTRIBUTE_TYPE.NAME,
            GRESTLER_STRING_ATTRIBUTE_TYPE.MIN_LENGTH,
            GRESTLER_STRING_ATTRIBUTE_TYPE.MAX_LENGTH,
            GRESTLER_STRING_ATTRIBUTE_TYPE.REGEX_PATTERN
       FROM GRESTLER_STRING_ATTRIBUTE_TYPE
            INNER JOIN GRESTLER_ATTRIBUTE_TYPE ON GRESTLER_STRING_ATTRIBUTE_TYPE.ID = GRESTLER_ATTRIBUTE_TYPE.ID;


----------------------------
-- UUID Attribute Type --
----------------------------

-- Table
CREATE TABLE GRESTLER_UUID_ATTRIBUTE_TYPE (
    ID UUID NOT NULL
);

-- Primary key
ALTER TABLE GRESTLER_UUID_ATTRIBUTE_TYPE ADD CONSTRAINT PK_GRESTLER_UUID_ATTRIBUTE_TYPE
    PRIMARY KEY (ID);

-- Foreign keys
ALTER TABLE GRESTLER_UUID_ATTRIBUTE_TYPE ADD CONSTRAINT FK_GRESTLER_UUID_ATTRIBUTE_TYPE__ID
    FOREIGN KEY (ID) REFERENCES GRESTLER_ATTRIBUTE_TYPE(ID) ON DELETE CASCADE;

-- View
CREATE VIEW GRESTLER_VIEW_UUID_ATTRIBUTE_TYPE
  AS SELECT GRESTLER_ATTRIBUTE_TYPE.ID,
            GRESTLER_ATTRIBUTE_TYPE.PARENT_PACKAGE_ID,
            GRESTLER_ATTRIBUTE_TYPE.NAME
       FROM GRESTLER_UUID_ATTRIBUTE_TYPE
            INNER JOIN GRESTLER_ATTRIBUTE_TYPE ON GRESTLER_UUID_ATTRIBUTE_TYPE.ID = GRESTLER_ATTRIBUTE_TYPE.ID;


-----------------
-- Vertex Type --
-----------------

-- Table
CREATE TABLE GRESTLER_VERTEX_TYPE (
    ID UUID NOT NULL,
    PARENT_PACKAGE_ID UUID NOT NULL,
    NAME VARCHAR(256) NOT NULL,
    SUPER_TYPE_ID UUID NOT NULL,
    IS_ABSTRACT BOOLEAN NOT NULL
);

-- Primary key
ALTER TABLE GRESTLER_VERTEX_TYPE ADD CONSTRAINT PK_GRESTLER_VERTEX_TYPE
    PRIMARY KEY (ID);

-- Foreign keys
ALTER TABLE GRESTLER_VERTEX_TYPE ADD CONSTRAINT FK_GRESTLER_VERTEX_TYPE__SUPER_TYPE
    FOREIGN KEY (SUPER_TYPE_ID) REFERENCES GRESTLER_VERTEX_TYPE(ID);
ALTER TABLE GRESTLER_VERTEX_TYPE ADD CONSTRAINT FK_GRESTLER_VERTEX_TYPE__PARENT_PACKAGE
    FOREIGN KEY (PARENT_PACKAGE_ID) REFERENCES GRESTLER_PACKAGE(ID);

-- Constraints
ALTER TABLE GRESTLER_VERTEX_TYPE ADD CONSTRAINT UQ_GRESTLER_VERTEX_TYPE__NAME
    UNIQUE (PARENT_PACKAGE_ID,NAME);

-- Generic base vertex type
INSERT INTO GRESTLER_VERTEX_TYPE
            ( ID, PARENT_PACKAGE_ID, NAME, SUPER_TYPE_ID, IS_ABSTRACT )
     VALUES ( '00000010-7a26-11e4-a545-08002741a702', '00000000-7a26-11e4-a545-08002741a702',
              'Vertex', '00000010-7a26-11e4-a545-08002741a702', TRUE );


----------------------------------
-- Vertex Attribute Declaration --
----------------------------------

-- Table
CREATE TABLE GRESTLER_VERTEX_ATTRIBUTE_DECL (
    ID UUID NOT NULL,
    PARENT_VERTEX_TYPE_ID UUID NOT NULL,
    NAME VARCHAR(256) NOT NULL,
    ATTRIBUTE_TYPE_ID UUID NOT NULL,
    IS_REQUIRED BOOLEAN NOT NULL
);

-- Primary key
ALTER TABLE GRESTLER_VERTEX_ATTRIBUTE_DECL ADD CONSTRAINT PK_GRESTLER_VERTEX_ATTRIBUTE_DECL
    PRIMARY KEY (ID);

-- Foreign keys
ALTER TABLE GRESTLER_VERTEX_ATTRIBUTE_DECL ADD CONSTRAINT FK_GRESTLER_VERTEX_ATTRIBUTE_DECL__PARENT_VERTEX_TYPE
    FOREIGN KEY (PARENT_VERTEX_TYPE_ID) REFERENCES GRESTLER_VERTEX_TYPE(ID) ON DELETE CASCADE;
ALTER TABLE GRESTLER_VERTEX_ATTRIBUTE_DECL ADD CONSTRAINT FK_GRESTLER_VERTEX_ATTRIBUTE_DECL__ATTRIBUTE_TYPE
    FOREIGN KEY (ATTRIBUTE_TYPE_ID) REFERENCES GRESTLER_ATTRIBUTE_TYPE(ID);


---------------
-- Edge Type --
---------------

-- Table
CREATE TABLE GRESTLER_EDGE_TYPE (
    ID UUID NOT NULL,
    PARENT_PACKAGE_ID UUID NOT NULL,
    NAME VARCHAR(256) NOT NULL,
    SUPER_TYPE_ID UUID NOT NULL,
    IS_ABSTRACT BOOLEAN NOT NULL,
    TAIL_VERTEX_TYPE_ID UUID NOT NULL,
    HEAD_VERTEX_TYPE_ID UUID NOT NULL,
    TAIL_ROLE_NAME VARCHAR(256),
    HEAD_ROLE_NAME VARCHAR(256),
    IS_ACYCLIC BOOLEAN,
    IS_MULTI_EDGE_ALLOWED BOOLEAN,
    IS_SELF_EDGE_ALLOWED BOOLEAN
);

-- TODO: Undirected edge type:
         -- VERTEX_TYPE_ID,
         -- MIN_DEGREE
         -- MAX_DEGREE
-- TODO: Directed edge type:
         -- TAIL_VERTEX_TYPE_ID,
         -- HEAD_VERTEX_TYPE_ID,
         -- TAIL_ROLE_NAME,
         -- HEAD_ROLE_NAME
         -- MIN_TAIL_OUT_DEGREE
         -- MAX_TAIL_OUT_DEGREE
         -- MIN_HEAD_IN_DEGREE
         -- MAX_HEAD_IN_DEGREE

-- Primary key
ALTER TABLE GRESTLER_EDGE_TYPE ADD CONSTRAINT PK_GRESTLER_EDGE_TYPE
    PRIMARY KEY (ID);

-- Foreign keys
ALTER TABLE GRESTLER_EDGE_TYPE ADD CONSTRAINT FK_GRESTLER_EDGE_TYPE__SUPER_TYPE
    FOREIGN KEY (SUPER_TYPE_ID) REFERENCES GRESTLER_EDGE_TYPE(ID);
ALTER TABLE GRESTLER_EDGE_TYPE ADD CONSTRAINT FK_GRESTLER_EDGE_TYPE__PARENT_PACKAGE
    FOREIGN KEY (PARENT_PACKAGE_ID) REFERENCES GRESTLER_PACKAGE(ID);
ALTER TABLE GRESTLER_EDGE_TYPE ADD CONSTRAINT FK_GRESTLER_EDGE_TYPE__FROM_VERTEX_TYPE
    FOREIGN KEY (TAIL_VERTEX_TYPE_ID) REFERENCES GRESTLER_VERTEX_TYPE(ID);
ALTER TABLE GRESTLER_EDGE_TYPE ADD CONSTRAINT FK_GRESTLER_EDGE_TYPE__TO_VERTEX_TYPE
    FOREIGN KEY (HEAD_VERTEX_TYPE_ID) REFERENCES GRESTLER_VERTEX_TYPE(ID);

-- Constraints
ALTER TABLE GRESTLER_EDGE_TYPE ADD CONSTRAINT UQ_GRESTLER_EDGE_TYPE__NAME
    UNIQUE (PARENT_PACKAGE_ID,NAME);

-- Generic base edge type
INSERT INTO GRESTLER_EDGE_TYPE
            ( ID, PARENT_PACKAGE_ID, NAME, SUPER_TYPE_ID, IS_ABSTRACT, TAIL_VERTEX_TYPE_ID, HEAD_VERTEX_TYPE_ID )
     VALUES ( '00000020-7a26-11e4-a545-08002741a702', '00000000-7a26-11e4-a545-08002741a702',
              'Edge', '00000020-7a26-11e4-a545-08002741a702', TRUE,
              '00000010-7a26-11e4-a545-08002741a702', '00000010-7a26-11e4-a545-08002741a702' );


----------------------------------
-- Edge Attribute Declaration --
----------------------------------

-- Table
CREATE TABLE GRESTLER_EDGE_ATTRIBUTE_DECL (
    ID UUID NOT NULL,
    PARENT_EDGE_TYPE_ID UUID NOT NULL,
    NAME VARCHAR(256) NOT NULL,
    ATTRIBUTE_TYPE_ID UUID NOT NULL,
    IS_REQUIRED BOOLEAN NOT NULL
);

-- Primary key
ALTER TABLE GRESTLER_EDGE_ATTRIBUTE_DECL ADD CONSTRAINT PK_GRESTLER_EDGE_ATTRIBUTE_DECL
    PRIMARY KEY (ID);

-- Foreign keys
ALTER TABLE GRESTLER_EDGE_ATTRIBUTE_DECL ADD CONSTRAINT FK_GRESTLER_EDGE_ATTRIBUTE_DECL__PARENT_EDGE_TYPE
    FOREIGN KEY (PARENT_EDGE_TYPE_ID) REFERENCES GRESTLER_EDGE_TYPE(ID) ON DELETE CASCADE;
ALTER TABLE GRESTLER_EDGE_ATTRIBUTE_DECL ADD CONSTRAINT FK_GRESTLER_EDGE_ATTRIBUTE_DECL__ATTRIBUTE_TYPE
    FOREIGN KEY (ATTRIBUTE_TYPE_ID) REFERENCES GRESTLER_ATTRIBUTE_TYPE(ID);


