--
-- ER/Studio Data Architect SQL Code Generation
-- Project :      ChinookModelFinal.DM1
--
-- Date Created : Wednesday, February 13, 2019 22:02:49
-- Target DBMS : PostgreSQL 8.0
--

-- 
-- TABLE: "DimAlbum" 
--

CREATE TABLE "DimAlbum"(
    "AlbumKey"    int4            NOT NULL,
    "AlbumTitle"  varchar(200)    NOT NULL,
    "ArtistName"  varchar(50)     NOT NULL,
    CONSTRAINT "PK7" PRIMARY KEY ("AlbumKey")
)
;



-- 
-- TABLE: "DimCustomer" 
--

CREATE TABLE "DimCustomer"(
    "CustomerKey"           int4            NOT NULL,
    "GeographyKey"          int4,
    "CustomerAlternateKey"  varchar(15)     NOT NULL,
    "FirstName"             varchar(50),
    "LastName"              varchar(50),
    "Company"               varchar(150),
    "AddressLine1"          varchar(120),
    "AddressLine2"          varchar(120),
    "Phone"                 varchar(20),
    "EmailAddress"          varchar(50),
    CONSTRAINT "PK_DimCustomer_CustomerKey" PRIMARY KEY ("CustomerKey")
)
;



-- 
-- TABLE: "DimEmployee" 
--

CREATE TABLE "DimEmployee"(
    "EmployeeKey"                           int4           NOT NULL,
    "ReportsTo"                             int4,
    "EmployeeNationalIDAlternateKey"        varchar(15),
    "ParentEmployeeNationalIDAlternateKey"  varchar(15),
    "FirstName"                             varchar(50)    NOT NULL,
    "LastName"                              varchar(50)    NOT NULL,
    "Title"                                 varchar(50),
    "HireDate"                              date,
    "BirthDate"                             date,
    "EmailAddress"                          varchar(50),
    "Phone"                                 varchar(25),
    "Fax"                                   varchar(50),
    "GeographyKey"                          int4,
    CONSTRAINT "PK_DimEmployee_EmployeeKey_1" PRIMARY KEY ("EmployeeKey")
)
;



-- 
-- TABLE: "DimGenre" 
--

CREATE TABLE "DimGenre"(
    "GenreKey"  int4            NOT NULL,
    "Name"      varchar(120)    NOT NULL,
    CONSTRAINT "PK13" PRIMARY KEY ("GenreKey")
)
;



-- 
-- TABLE: "DimGeography" 
--

CREATE TABLE "DimGeography"(
    "GeographyKey"              int4           NOT NULL,
    "City"                      varchar(30),
    "StateProvinceCode"         varchar(3),
    "StateProvinceName"         varchar(50),
    "CountryRegionCode"         varchar(3),
    "EnglishCountryRegionName"  varchar(50),
    "PostalCode"                varchar(15),
    "SalesTerritoryKey"         int4,
    CONSTRAINT "PK_DimGeography_GeographyKey" PRIMARY KEY ("GeographyKey")
)
;



-- 
-- TABLE: "DimMediaType" 
--

CREATE TABLE "DimMediaType"(
    "MediaTypeKey"  int4            NOT NULL,
    "Name"          varchar(120)    NOT NULL,
    CONSTRAINT "PK12" PRIMARY KEY ("MediaTypeKey")
)
;



-- 
-- TABLE: "DimSalesTerritory" 
--

CREATE TABLE "DimSalesTerritory"(
    "SalesTerritoryKey"           int4           NOT NULL,
    "SalesTerritoryAlternateKey"  int4,
    "BillingCountry"              varchar(50)    NOT NULL,
    "BillingCity"                 varchar(50)    NOT NULL,
    "BillingState"                varchar(50),
    "BillingPostalCode"           varchar(10)    NOT NULL,
    CONSTRAINT "PK_DimSalesTerritory_SalesTerritoryKey" PRIMARY KEY ("SalesTerritoryKey")
)
;



-- 
-- TABLE: "DimTrack" 
--

CREATE TABLE "DimTrack"(
    "TrackKey"      int4              NOT NULL,
    "AlbumKey"      int4              NOT NULL,
    "TrackName"     varchar(500)      NOT NULL,
    "PlaylistName"  varchar(200),
    "Milliseconds"  int4              NOT NULL,
    "UnitPrice"     numeric(10, 2)    NOT NULL,
    "MediaTypeKey"  int4              NOT NULL,
    "GenreKey"      int4              NOT NULL,
    CONSTRAINT "PK10" PRIMARY KEY ("TrackKey", "AlbumKey", "MediaTypeKey", "GenreKey")
)
;



-- 
-- TABLE: "FactInvoice" 
--

CREATE TABLE "FactInvoice"(
    "InvoiceKey"         int4              NOT NULL,
    "InvoiceDate"        date,
    "UnitPrice"          numeric(10, 2)    NOT NULL,
    "Quanitity"          int4              NOT NULL,
    "Total"              numeric(10, 2)    NOT NULL,
    "TrackKey"           int4              NOT NULL,
    "AlbumKey"           int4              NOT NULL,
    "MediaTypeKey"       int4              NOT NULL,
    "GenreKey"           int4              NOT NULL,
    "CustomerKey"        int4              NOT NULL,
    "EmployeeKey"        int4              NOT NULL,
    "SalesTerritoryKey"  int4              NOT NULL,
    CONSTRAINT "PK20" PRIMARY KEY ("InvoiceKey", "TrackKey", "AlbumKey", "MediaTypeKey", "GenreKey", "CustomerKey", "EmployeeKey")
)
;



-- 
-- TABLE: "DimCustomer" 
--

ALTER TABLE "DimCustomer" ADD CONSTRAINT "RefDimGeography26" 
    FOREIGN KEY ("GeographyKey")
    REFERENCES "DimGeography"("GeographyKey")
;


-- 
-- TABLE: "DimEmployee" 
--

ALTER TABLE "DimEmployee" ADD CONSTRAINT "RefDimGeography27" 
    FOREIGN KEY ("GeographyKey")
    REFERENCES "DimGeography"("GeographyKey")
;

ALTER TABLE "DimEmployee" ADD CONSTRAINT "FK_DimEmployee_DimEmployee" 
    FOREIGN KEY ("ReportsTo")
    REFERENCES "DimEmployee"("EmployeeKey")
;


-- 
-- TABLE: "DimGeography" 
--

ALTER TABLE "DimGeography" ADD CONSTRAINT "RefDimSalesTerritory34" 
    FOREIGN KEY ("SalesTerritoryKey")
    REFERENCES "DimSalesTerritory"("SalesTerritoryKey")
;


-- 
-- TABLE: "DimTrack" 
--

ALTER TABLE "DimTrack" ADD CONSTRAINT "RefDimAlbum6" 
    FOREIGN KEY ("AlbumKey")
    REFERENCES "DimAlbum"("AlbumKey")
;

ALTER TABLE "DimTrack" ADD CONSTRAINT "RefDimMediaType19" 
    FOREIGN KEY ("MediaTypeKey")
    REFERENCES "DimMediaType"("MediaTypeKey")
;

ALTER TABLE "DimTrack" ADD CONSTRAINT "RefDimGenre21" 
    FOREIGN KEY ("GenreKey")
    REFERENCES "DimGenre"("GenreKey")
;


-- 
-- TABLE: "FactInvoice" 
--

ALTER TABLE "FactInvoice" ADD CONSTRAINT "RefDimTrack29" 
    FOREIGN KEY ("TrackKey", "AlbumKey", "MediaTypeKey", "GenreKey")
    REFERENCES "DimTrack"("TrackKey", "AlbumKey", "MediaTypeKey", "GenreKey")
;

ALTER TABLE "FactInvoice" ADD CONSTRAINT "RefDimCustomer30" 
    FOREIGN KEY ("CustomerKey")
    REFERENCES "DimCustomer"("CustomerKey")
;

ALTER TABLE "FactInvoice" ADD CONSTRAINT "RefDimEmployee31" 
    FOREIGN KEY ("EmployeeKey")
    REFERENCES "DimEmployee"("EmployeeKey")
;

ALTER TABLE "FactInvoice" ADD CONSTRAINT "RefDimSalesTerritory32" 
    FOREIGN KEY ("SalesTerritoryKey")
    REFERENCES "DimSalesTerritory"("SalesTerritoryKey")
;


