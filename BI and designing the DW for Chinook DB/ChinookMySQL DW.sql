--
-- ER/Studio Data Architect SQL Code Generation
-- Project :      ChinookModelFinal.DM1
--
-- Date Created : Wednesday, February 13, 2019 22:00:14
-- Target DBMS : Oracle 11g
--

-- 
-- TABLE: DimAlbum 
--

CREATE TABLE DimAlbum(
    AlbumKey      NUMBER(38, 0)     NOT NULL,
    AlbumTitle    NVARCHAR2(200)    NOT NULL,
    ArtistName    NVARCHAR2(50)     NOT NULL,
    CONSTRAINT PK7 PRIMARY KEY (AlbumKey)
)
;



-- 
-- TABLE: DimCustomer 
--

CREATE TABLE DimCustomer(
    CustomerKey             NUMBER(38, 0)     NOT NULL,
    GeographyKey            NUMBER(38, 0),
    CustomerAlternateKey    NVARCHAR2(15)     NOT NULL,
    FirstName               NVARCHAR2(50),
    LastName                NVARCHAR2(50),
    Company                 NVARCHAR2(150),
    AddressLine1            NVARCHAR2(120),
    AddressLine2            NVARCHAR2(120),
    Phone                   NVARCHAR2(20),
    EmailAddress            NVARCHAR2(50),
    CONSTRAINT PK_DimCustomer_CustomerKey PRIMARY KEY (CustomerKey)
)
;



-- 
-- TABLE: DimEmployee 
--

CREATE TABLE DimEmployee(
    EmployeeKey                             NUMBER(38, 0)    NOT NULL,
    ReportsTo                               NUMBER(38, 0),
    EmployeeNationalIDAlternateKey          NVARCHAR2(15),
    ParentEmployeeNationalIDAlternateKey    NVARCHAR2(15),
    FirstName                               NVARCHAR2(50)    NOT NULL,
    LastName                                NVARCHAR2(50)    NOT NULL,
    Title                                   NVARCHAR2(50),
    HireDate                                DATE,
    BirthDate                               DATE,
    EmailAddress                            NVARCHAR2(50),
    Phone                                   NVARCHAR2(25),
    Fax                                     NVARCHAR2(50),
    GeographyKey                            NUMBER(38, 0),
    CONSTRAINT PK_DimEmployee_EmployeeKey_1 PRIMARY KEY (EmployeeKey)
)
;



-- 
-- TABLE: DimGenre 
--

CREATE TABLE DimGenre(
    GenreKey    NUMBER(38, 0)     NOT NULL,
    Name        NVARCHAR2(120)    NOT NULL,
    CONSTRAINT PK13 PRIMARY KEY (GenreKey)
)
;



-- 
-- TABLE: DimGeography 
--

CREATE TABLE DimGeography(
    GeographyKey                NUMBER(38, 0)    NOT NULL,
    City                        NVARCHAR2(30),
    StateProvinceCode           NVARCHAR2(3),
    StateProvinceName           NVARCHAR2(50),
    CountryRegionCode           NVARCHAR2(3),
    EnglishCountryRegionName    NVARCHAR2(50),
    PostalCode                  NVARCHAR2(15),
    SalesTerritoryKey           NUMBER(38, 0),
    CONSTRAINT PK_DimGeography_GeographyKey PRIMARY KEY (GeographyKey)
)
;



-- 
-- TABLE: DimMediaType 
--

CREATE TABLE DimMediaType(
    MediaTypeKey    NUMBER(38, 0)     NOT NULL,
    Name            NVARCHAR2(120)    NOT NULL,
    CONSTRAINT PK12 PRIMARY KEY (MediaTypeKey)
)
;



-- 
-- TABLE: DimSalesTerritory 
--

CREATE TABLE DimSalesTerritory(
    SalesTerritoryKey             NUMBER(38, 0)    NOT NULL,
    SalesTerritoryAlternateKey    NUMBER(38, 0),
    BillingCountry                NVARCHAR2(50)    NOT NULL,
    BillingCity                   NVARCHAR2(50)    NOT NULL,
    BillingState                  NVARCHAR2(50),
    BillingPostalCode             NVARCHAR2(10)    NOT NULL,
    CONSTRAINT PK_DimSalesTerritory_SalesTerritoryKey PRIMARY KEY (SalesTerritoryKey)
)
;



-- 
-- TABLE: DimTrack 
--

CREATE TABLE DimTrack(
    TrackKey        NUMBER(38, 0)     NOT NULL,
    AlbumKey        NUMBER(38, 0)     NOT NULL,
    TrackName       NVARCHAR2(500)    NOT NULL,
    PlaylistName    NVARCHAR2(200),
    Milliseconds    NUMBER(38, 0)     NOT NULL,
    UnitPrice       NUMBER(10, 2)     NOT NULL,
    MediaTypeKey    NUMBER(38, 0)     NOT NULL,
    GenreKey        NUMBER(38, 0)     NOT NULL,
    CONSTRAINT PK10 PRIMARY KEY (TrackKey, AlbumKey, MediaTypeKey, GenreKey)
)
;



-- 
-- TABLE: FactInvoice 
--

CREATE TABLE FactInvoice(
    InvoiceKey           NUMBER(38, 0)    NOT NULL,
    InvoiceDate          DATE,
    UnitPrice            NUMBER(10, 2)    NOT NULL,
    Quanitity            NUMBER(38, 0)    NOT NULL,
    Total                NUMBER(10, 2)    NOT NULL,
    TrackKey             NUMBER(38, 0)    NOT NULL,
    AlbumKey             NUMBER(38, 0)    NOT NULL,
    MediaTypeKey         NUMBER(38, 0)    NOT NULL,
    GenreKey             NUMBER(38, 0)    NOT NULL,
    CustomerKey          NUMBER(38, 0)    NOT NULL,
    EmployeeKey          NUMBER(38, 0)    NOT NULL,
    SalesTerritoryKey    NUMBER(38, 0)    NOT NULL,
    CONSTRAINT PK20 PRIMARY KEY (InvoiceKey, TrackKey, AlbumKey, MediaTypeKey, GenreKey, CustomerKey, EmployeeKey)
)
;



-- 
-- TABLE: DimCustomer 
--

ALTER TABLE DimCustomer ADD CONSTRAINT RefDimGeography26 
    FOREIGN KEY (GeographyKey)
    REFERENCES DimGeography(GeographyKey)
;


-- 
-- TABLE: DimEmployee 
--

ALTER TABLE DimEmployee ADD CONSTRAINT RefDimGeography27 
    FOREIGN KEY (GeographyKey)
    REFERENCES DimGeography(GeographyKey)
;

ALTER TABLE DimEmployee ADD CONSTRAINT FK_DimEmployee_DimEmployee 
    FOREIGN KEY (ReportsTo)
    REFERENCES DimEmployee(EmployeeKey)
;


-- 
-- TABLE: DimGeography 
--

ALTER TABLE DimGeography ADD CONSTRAINT RefDimSalesTerritory34 
    FOREIGN KEY (SalesTerritoryKey)
    REFERENCES DimSalesTerritory(SalesTerritoryKey)
;


-- 
-- TABLE: DimTrack 
--

ALTER TABLE DimTrack ADD CONSTRAINT RefDimMediaType19 
    FOREIGN KEY (MediaTypeKey)
    REFERENCES DimMediaType(MediaTypeKey)
;

ALTER TABLE DimTrack ADD CONSTRAINT RefDimGenre21 
    FOREIGN KEY (GenreKey)
    REFERENCES DimGenre(GenreKey)
;

ALTER TABLE DimTrack ADD CONSTRAINT RefDimAlbum6 
    FOREIGN KEY (AlbumKey)
    REFERENCES DimAlbum(AlbumKey)
;


-- 
-- TABLE: FactInvoice 
--

ALTER TABLE FactInvoice ADD CONSTRAINT RefDimTrack29 
    FOREIGN KEY (TrackKey, AlbumKey, MediaTypeKey, GenreKey)
    REFERENCES DimTrack(TrackKey, AlbumKey, MediaTypeKey, GenreKey)
;

ALTER TABLE FactInvoice ADD CONSTRAINT RefDimCustomer30 
    FOREIGN KEY (CustomerKey)
    REFERENCES DimCustomer(CustomerKey)
;

ALTER TABLE FactInvoice ADD CONSTRAINT RefDimEmployee31 
    FOREIGN KEY (EmployeeKey)
    REFERENCES DimEmployee(EmployeeKey)
;

ALTER TABLE FactInvoice ADD CONSTRAINT RefDimSalesTerritory32 
    FOREIGN KEY (SalesTerritoryKey)
    REFERENCES DimSalesTerritory(SalesTerritoryKey)
;


