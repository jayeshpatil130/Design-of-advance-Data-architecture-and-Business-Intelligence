/*
 * ER/Studio Data Architect SQL Code Generation
 * Project :      ChinookModelFinal.DM1
 *
 * Date Created : Wednesday, February 13, 2019 21:58:20
 * Target DBMS : Microsoft SQL Server 2017
 */

CREATE TYPE AccountNumber FROM nvarchar(15) NULL
go

CREATE TYPE Flag FROM bit NOT NULL
go

CREATE TYPE Name FROM nvarchar(50) NULL
go

CREATE TYPE NameStyle FROM bit NOT NULL
go

CREATE TYPE OrderNumber FROM nvarchar(25) NULL
go

CREATE TYPE Phone FROM nvarchar(25) NULL
go

/* 
 * TABLE: DimAlbum 
 */

CREATE TABLE DimAlbum(
    AlbumKey_SK    int              NOT NULL,
    AlbumId_NK     int              NULL,
    ArtistId_NK    int              NULL,
    AlbumTitle     nvarchar(200)    NOT NULL,
    ArtistName     nvarchar(50)     NOT NULL,
    CONSTRAINT PK7 PRIMARY KEY NONCLUSTERED (AlbumKey_SK)
)
go



IF OBJECT_ID('DimAlbum') IS NOT NULL
    PRINT '<<< CREATED TABLE DimAlbum >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE DimAlbum >>>'
go

/* 
 * TABLE: DimCustomer 
 */

CREATE TABLE DimCustomer(
    CustomerKey_SK          int              NOT NULL,
    CustomerId_NK           int              NULL,
    GeographyKey            int              NULL,
    CustomerAlternateKey    nvarchar(15)     NOT NULL,
    FirstName               nvarchar(50)     NULL,
    LastName                nvarchar(50)     NULL,
    Company                 nvarchar(150)    NULL,
    AddressLine1            nvarchar(120)    NULL,
    AddressLine2            nvarchar(120)    NULL,
    Phone                   nvarchar(20)     NULL,
    EmailAddress            nvarchar(50)     NULL,
    CONSTRAINT PK_DimCustomer_CustomerKey PRIMARY KEY NONCLUSTERED (CustomerKey_SK)
)
go



IF OBJECT_ID('DimCustomer') IS NOT NULL
    PRINT '<<< CREATED TABLE DimCustomer >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE DimCustomer >>>'
go

/* 
 * TABLE: DimDate 
 */

CREATE TABLE DimDate(
    DateKey                 int          IDENTITY(1,1),
    FullDateAlternateKey    timestamp    NULL,
    DayNumberofWeeks        date         NULL,
    NameofWeek              date         NULL,
    DayNumberofMonth        date         NULL,
    DayNumberofYear         date         NULL,
    MonthName               date         NULL,
    WeekNumberofYear        date         NULL,
    MonthNumberofYear       date         NULL,
    CalenderQuarter         date         NULL,
    CalenderYear            date         NULL,
    CalenderSemester        date         NULL,
    CONSTRAINT PK10_1 PRIMARY KEY NONCLUSTERED (DateKey)
)
go



IF OBJECT_ID('DimDate') IS NOT NULL
    PRINT '<<< CREATED TABLE DimDate >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE DimDate >>>'
go

/* 
 * TABLE: DimEmployee 
 */

CREATE TABLE DimEmployee(
    EmployeeKey_SK                    int              NOT NULL,
    EmployeeId_NK                     int              NULL,
    EmployeeNationalIDAlternateKey    nvarchar(15)     NULL,
    FirstName                         nvarchar(50)     NOT NULL,
    LastName                          nvarchar(50)     NOT NULL,
    Title                             nvarchar(50)     NULL,
    HireDate                          date             NULL,
    BirthDate                         date             NULL,
    EmailAddress                      nvarchar(50)     NULL,
    Phone                             nvarchar(25)     NULL,
    AddressLine1                      nvarchar(200)    NULL,
    AddressLine2                      nvarchar(200)    NULL,
    Fax                               nvarchar(50)     NULL,
    GeographyKey                      int              NULL,
    CONSTRAINT PK_DimEmployee_EmployeeKey_1 PRIMARY KEY NONCLUSTERED (EmployeeKey_SK)
)
go



IF OBJECT_ID('DimEmployee') IS NOT NULL
    PRINT '<<< CREATED TABLE DimEmployee >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE DimEmployee >>>'
go

/* 
 * TABLE: DimGenre 
 */

CREATE TABLE DimGenre(
    GenreKey_Sk    int              NOT NULL,
    GenreId_NK     int              NULL,
    Name           nvarchar(120)    NOT NULL,
    CONSTRAINT PK13 PRIMARY KEY NONCLUSTERED (GenreKey_Sk)
)
go



IF OBJECT_ID('DimGenre') IS NOT NULL
    PRINT '<<< CREATED TABLE DimGenre >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE DimGenre >>>'
go

/* 
 * TABLE: DimGeography 
 */

CREATE TABLE DimGeography(
    GeographyKey                int             NOT NULL,
    City                        nvarchar(30)    NULL,
    StateProvinceCode           nvarchar(3)     NULL,
    StateProvinceName           nvarchar(50)    NULL,
    CountryRegionCode           nvarchar(3)     NULL,
    EnglishCountryRegionName    nvarchar(50)    NULL,
    PostalCode                  nvarchar(15)    NULL,
    SalesTerritoryKey           int             NULL,
    CONSTRAINT PK_DimGeography_GeographyKey PRIMARY KEY NONCLUSTERED (GeographyKey)
)
go



IF OBJECT_ID('DimGeography') IS NOT NULL
    PRINT '<<< CREATED TABLE DimGeography >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE DimGeography >>>'
go

/* 
 * TABLE: DimMediaType 
 */

CREATE TABLE DimMediaType(
    MediaTypeKey_SK    int              NOT NULL,
    MediaTypeId_NK     int              NULL,
    Name               nvarchar(120)    NOT NULL,
    CONSTRAINT PK12 PRIMARY KEY NONCLUSTERED (MediaTypeKey_SK)
)
go



IF OBJECT_ID('DimMediaType') IS NOT NULL
    PRINT '<<< CREATED TABLE DimMediaType >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE DimMediaType >>>'
go

/* 
 * TABLE: DimSalesTerritory 
 */

CREATE TABLE DimSalesTerritory(
    SalesTerritoryKey    int             NOT NULL,
    BillingCity          nvarchar(50)    NOT NULL,
    BillingState         nvarchar(50)    NULL,
    BillingCountry       nvarchar(50)    NOT NULL,
    BillingPostalCode    nvarchar(10)    NOT NULL,
    CONSTRAINT PK_DimSalesTerritory_SalesTerritoryKey PRIMARY KEY NONCLUSTERED (SalesTerritoryKey)
)
go



IF OBJECT_ID('DimSalesTerritory') IS NOT NULL
    PRINT '<<< CREATED TABLE DimSalesTerritory >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE DimSalesTerritory >>>'
go

/* 
 * TABLE: DimTrack 
 */

CREATE TABLE DimTrack(
    TrackKey_SK        int               NOT NULL,
    GenreKey_Sk        int               NULL,
    MediaTypeKey_SK    int               NULL,
    AlbumKey_SK        int               NULL,
    TrackId_NK         int               NULL,
    TrackName          nvarchar(500)     NOT NULL,
    PlaylistName       nvarchar(200)     NULL,
    Milliseconds       int               NOT NULL,
    UnitPrice          numeric(10, 2)    NOT NULL,
    CONSTRAINT PK10 PRIMARY KEY NONCLUSTERED (TrackKey_SK)
)
go



IF OBJECT_ID('DimTrack') IS NOT NULL
    PRINT '<<< CREATED TABLE DimTrack >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE DimTrack >>>'
go

/* 
 * TABLE: FactInvoice 
 */

CREATE TABLE FactInvoice(
    InvoiceKey           int               NOT NULL,
    TrackKey_SK          int               NOT NULL,
    CustomerKey_SK       int               NULL,
    EmployeeKey_SK       int               NULL,
    InvoiceDate          date              NULL,
    UnitPrice            numeric(10, 2)    NOT NULL,
    Quanitity            int               NOT NULL,
    Total                numeric(10, 2)    NOT NULL,
    SalesTerritoryKey    int               NOT NULL,
    DateKey              int               NOT NULL,
    CONSTRAINT PK20 PRIMARY KEY NONCLUSTERED (InvoiceKey, TrackKey_SK)
)
go



IF OBJECT_ID('FactInvoice') IS NOT NULL
    PRINT '<<< CREATED TABLE FactInvoice >>>'
ELSE
    PRINT '<<< FAILED CREATING TABLE FactInvoice >>>'
go

/* 
 * TABLE: DimCustomer 
 */

ALTER TABLE DimCustomer ADD CONSTRAINT RefDimGeography38 
    FOREIGN KEY (GeographyKey)
    REFERENCES DimGeography(GeographyKey)
go


/* 
 * TABLE: DimEmployee 
 */

ALTER TABLE DimEmployee ADD CONSTRAINT RefDimGeography39 
    FOREIGN KEY (GeographyKey)
    REFERENCES DimGeography(GeographyKey)
go


/* 
 * TABLE: DimGeography 
 */

ALTER TABLE DimGeography ADD CONSTRAINT RefDimSalesTerritory44 
    FOREIGN KEY (SalesTerritoryKey)
    REFERENCES DimSalesTerritory(SalesTerritoryKey)
go


/* 
 * TABLE: DimTrack 
 */

ALTER TABLE DimTrack ADD CONSTRAINT RefDimAlbum35 
    FOREIGN KEY (AlbumKey_SK)
    REFERENCES DimAlbum(AlbumKey_SK)
go

ALTER TABLE DimTrack ADD CONSTRAINT RefDimMediaType36 
    FOREIGN KEY (MediaTypeKey_SK)
    REFERENCES DimMediaType(MediaTypeKey_SK)
go

ALTER TABLE DimTrack ADD CONSTRAINT RefDimGenre37 
    FOREIGN KEY (GenreKey_Sk)
    REFERENCES DimGenre(GenreKey_Sk)
go


/* 
 * TABLE: FactInvoice 
 */

ALTER TABLE FactInvoice ADD CONSTRAINT RefDimTrack40 
    FOREIGN KEY (TrackKey_SK)
    REFERENCES DimTrack(TrackKey_SK)
go

ALTER TABLE FactInvoice ADD CONSTRAINT RefDimCustomer41 
    FOREIGN KEY (CustomerKey_SK)
    REFERENCES DimCustomer(CustomerKey_SK)
go

ALTER TABLE FactInvoice ADD CONSTRAINT RefDimEmployee42 
    FOREIGN KEY (EmployeeKey_SK)
    REFERENCES DimEmployee(EmployeeKey_SK)
go

ALTER TABLE FactInvoice ADD CONSTRAINT RefDimSalesTerritory43 
    FOREIGN KEY (SalesTerritoryKey)
    REFERENCES DimSalesTerritory(SalesTerritoryKey)
go

ALTER TABLE FactInvoice ADD CONSTRAINT RefDimDate45 
    FOREIGN KEY (DateKey)
    REFERENCES DimDate(DateKey)
go


