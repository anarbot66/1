USE CH
GO

SET ANSI_NULLS ON;
GO
SET QUOTED_IDENTIFIER ON;
GO

CREATE TABLE dbo.Users (
    UserId    INT IDENTITY(1,1) NOT NULL,
    UserName  NVARCHAR(50)  NOT NULL,
    Password  NVARCHAR(255) NOT NULL,
    CONSTRAINT PK_Users PRIMARY KEY CLUSTERED (UserId),
    CONSTRAINT UQ_Users_UserName UNIQUE (UserName)
);
GO

CREATE TABLE dbo.ProductTypes (
    ProductTypeId INT IDENTITY(1,1) NOT NULL,
    Name          NVARCHAR(100) NULL,
    Coefficient   FLOAT         NOT NULL,
    CONSTRAINT PK_ProductTypes PRIMARY KEY CLUSTERED (ProductTypeId)
);
GO

CREATE TABLE dbo.MaterialTypes (
    MaterialTypeId INT IDENTITY(1,1) NOT NULL,
    Name           NVARCHAR(100) NULL,
    LossPercent    FLOAT         NOT NULL,
    CONSTRAINT PK_MaterialTypes PRIMARY KEY CLUSTERED (MaterialTypeId)
);
GO

CREATE TABLE dbo.Materials (
    MaterialId      INT           IDENTITY(1,1) NOT NULL,
    Name            NVARCHAR(100) NOT NULL,
    QuantityInStock DECIMAL(18,2) NOT NULL CONSTRAINT DF_Materials_QuantityInStock DEFAULT(0),
    MinimumAllowed  DECIMAL(18,2) NOT NULL CONSTRAINT DF_Materials_MinimumAllowed DEFAULT(0),
    [Type]          NVARCHAR(50)  NOT NULL CONSTRAINT DF_Materials_Type DEFAULT(N'�����'),
    Price           DECIMAL(18,2) NOT NULL CONSTRAINT DF_Materials_Price DEFAULT(0),
    Unit            NVARCHAR(20)  NOT NULL CONSTRAINT DF_Materials_Unit DEFAULT(N'��.'),
    QuantityInPack  INT           NOT NULL CONSTRAINT DF_Materials_QuantityInPack DEFAULT(1),
    CONSTRAINT PK_Materials PRIMARY KEY CLUSTERED (MaterialId)
);
GO

CREATE TABLE dbo.MaterialHistory (
    MaterialHistoryId INT           IDENTITY(1,1) NOT NULL,
    MaterialId        INT           NOT NULL,
    ChangeDate        DATETIME2(7)  NOT NULL CONSTRAINT DF_MaterialHistory_ChangeDate DEFAULT(SYSUTCDATETIME()),
    QuantityBefore    DECIMAL(18,2) NOT NULL,
    QuantityAfter     DECIMAL(18,2) NOT NULL,
    [Comment]         NVARCHAR(200) NULL,
    CONSTRAINT PK_MaterialHistory PRIMARY KEY CLUSTERED (MaterialHistoryId),
    CONSTRAINT FK_MH_Material FOREIGN KEY (MaterialId) REFERENCES dbo.Materials (MaterialId)
);
GO

CREATE TABLE dbo.Products (
    ProductId       INT IDENTITY(1,1) NOT NULL,
    Article         NVARCHAR(50)  NOT NULL,
    Name            NVARCHAR(100) NOT NULL,
    PlannedQuantity INT           NOT NULL CONSTRAINT DF_Products_PlannedQuantity DEFAULT(0),
    CONSTRAINT PK_Products PRIMARY KEY CLUSTERED (ProductId)
);
GO

CREATE TABLE dbo.ProductMaterials (
    ProductMaterialId INT           IDENTITY(1,1) NOT NULL,
    ProductId         INT           NOT NULL,
    MaterialId        INT           NOT NULL,
    QuantityPerUnit   DECIMAL(18,2) NOT NULL,
    CONSTRAINT PK_ProductMaterials PRIMARY KEY CLUSTERED (ProductMaterialId),
    CONSTRAINT FK_PM_Product FOREIGN KEY (ProductId)   REFERENCES dbo.Products (ProductId),
    CONSTRAINT FK_PM_Material FOREIGN KEY (MaterialId) REFERENCES dbo.Materials (MaterialId)
);
GO

CREATE TABLE dbo.Suppliers (
    SupplierId     INT IDENTITY(1,1) NOT NULL,
    SupplierTypeId INT         NOT NULL,
    Name           NVARCHAR(200) NOT NULL,
    INN            NVARCHAR(20)  NOT NULL,
    ContactPhone   NVARCHAR(50)  NULL,
    ContactEmail   NVARCHAR(100) NULL,
    LegalAddress   NVARCHAR(250) NULL,
    Rating         DECIMAL(5,2)  NULL,
    CONSTRAINT PK_Suppliers PRIMARY KEY CLUSTERED (SupplierId),
    CONSTRAINT FK_Suppliers_Type FOREIGN KEY (SupplierTypeId)
        REFERENCES dbo.SupplierTypes (SupplierTypeId)
);
GO

CREATE TABLE dbo.SupplierMaterialHistory (
    SupplierMaterialHistoryId INT IDENTITY(1,1) NOT NULL,
    SupplierId                INT         NOT NULL,
    MaterialId                INT         NOT NULL,
    SupplyDate                DATETIME2   NOT NULL CONSTRAINT DF_SMH_SupplyDate DEFAULT(SYSUTCDATETIME()),
    Quantity                  DECIMAL(18,2) NOT NULL,
    UnitPrice                 DECIMAL(18,2) NOT NULL,
    CONSTRAINT PK_SupplierMaterialHistory PRIMARY KEY CLUSTERED (SupplierMaterialHistoryId),
    CONSTRAINT FK_SMH_Supplier FOREIGN KEY (SupplierId) REFERENCES dbo.Suppliers (SupplierId),
    CONSTRAINT FK_SMH_Material FOREIGN KEY (MaterialId) REFERENCES dbo.Materials (MaterialId)
);
GO

CREATE TABLE dbo.Partners (
    PartnerId        INT IDENTITY(1,1) NOT NULL,
    PartnerTypeId    INT         NOT NULL,
    CompanyName      NVARCHAR(200) NOT NULL,
    LegalAddress     NVARCHAR(250) NULL,
    INN              NVARCHAR(20)  NOT NULL,
    DirectorFullName NVARCHAR(200) NOT NULL,
    Phone            NVARCHAR(50)  NULL,
    Email            NVARCHAR(100) NULL,
    Logo             VARBINARY(MAX) NULL,
    CurrentRating    DECIMAL(5,2)  NOT NULL CONSTRAINT DF_Partners_CurrentRating DEFAULT(0),
    CONSTRAINT PK_Partners PRIMARY KEY CLUSTERED (PartnerId),
    CONSTRAINT FK_Partners_Type FOREIGN KEY (PartnerTypeId)
        REFERENCES dbo.PartnerTypes (PartnerTypeId),
    CONSTRAINT UQ_Partners_INN UNIQUE (INN)
);
GO

CREATE TABLE dbo.PartnerSalesHistory (
    SalesHistoryId INT IDENTITY(1,1) NOT NULL,
    PartnerId      INT         NOT NULL,
    ProductId      INT         NOT NULL,
    SaleDate       DATETIME2   NOT NULL,
    Quantity       INT         NOT NULL,
    TotalAmount    DECIMAL(18,2) NOT NULL,
    CONSTRAINT PK_PartnerSalesHistory PRIMARY KEY CLUSTERED (SalesHistoryId),
    CONSTRAINT FK_PSH_Partner FOREIGN KEY (PartnerId) REFERENCES dbo.Partners (PartnerId),
    CONSTRAINT FK_PSH_Product FOREIGN KEY (ProductId) REFERENCES dbo.Products (ProductId)
);
GO

CREATE TABLE dbo.PartnerRatingHistory (
    RatingHistoryId INT IDENTITY(1,1) NOT NULL,
    PartnerId       INT         NOT NULL,
    ChangeDate      DATETIME2   NOT NULL CONSTRAINT DF_PRH_ChangeDate DEFAULT(SYSUTCDATETIME()),
    RatingBefore    DECIMAL(5,2) NOT NULL,
    RatingAfter     DECIMAL(5,2) NOT NULL,
    ChangedByUserId INT         NOT NULL,
    [Comment]       NVARCHAR(500) NULL,
    CONSTRAINT PK_PartnerRatingHistory PRIMARY KEY CLUSTERED (RatingHistoryId),
    CONSTRAINT FK_PRH_Partner FOREIGN KEY (PartnerId) REFERENCES dbo.Partners (PartnerId),
    CONSTRAINT FK_PRH_User FOREIGN KEY (ChangedByUserId) REFERENCES dbo.Users (UserId)
);
GO

CREATE TABLE dbo.PartnerDiscounts (
    DiscountId      INT IDENTITY(1,1) NOT NULL,
    PartnerId       INT         NOT NULL,
    MinVolume       DECIMAL(18,2) NOT NULL,
    MaxVolume       DECIMAL(18,2) NULL,
    DiscountPercent DECIMAL(5,2) NOT NULL,
    CONSTRAINT PK_PartnerDiscounts PRIMARY KEY CLUSTERED (DiscountId),
    CONSTRAINT FK_PD_Partner FOREIGN KEY (PartnerId) REFERENCES dbo.Partners (PartnerId)
);
GO

CREATE TABLE dbo.Managers (
    ManagerId INT IDENTITY(1,1) NOT NULL,
    UserId    INT         NOT NULL,
    HireDate  DATETIME2   NOT NULL CONSTRAINT DF_Managers_HireDate DEFAULT(SYSUTCDATETIME()),
    CONSTRAINT PK_Managers PRIMARY KEY CLUSTERED (ManagerId),
    CONSTRAINT UQ_Managers_User UNIQUE (UserId),
    CONSTRAINT FK_Managers_User FOREIGN KEY (UserId) REFERENCES dbo.Users (UserId)
);
GO


CREATE TABLE dbo.Orders (
    OrderId                INT IDENTITY(1,1) NOT NULL,
    PartnerId              INT         NOT NULL,
    ManagerId              INT         NOT NULL,
    OrderDate              DATETIME2   NOT NULL CONSTRAINT DF_Orders_OrderDate DEFAULT(SYSUTCDATETIME()),
    Status                 NVARCHAR(50) NOT NULL,
    PrepaymentDueDate      DATETIME2   NOT NULL,
    PrepaymentReceivedDate DATETIME2   NULL,
    FullPaymentDate        DATETIME2   NULL,
    CONSTRAINT PK_Orders PRIMARY KEY CLUSTERED (OrderId),
    CONSTRAINT FK_Orders_Partner FOREIGN KEY (PartnerId) REFERENCES dbo.Partners (PartnerId),
    CONSTRAINT FK_Orders_Manager FOREIGN KEY (ManagerId) REFERENCES dbo.Managers (ManagerId)
);
GO

CREATE TABLE dbo.OrderItems (
    OrderItemId         INT IDENTITY(1,1) NOT NULL,
    OrderId             INT         NOT NULL,
    ProductId           INT         NOT NULL,
    Quantity            INT         NOT NULL,
    UnitPrice           DECIMAL(18,2) NOT NULL,
    ProductionStartDate DATETIME2   NULL,
    ProductionEndDate   DATETIME2   NULL,
    CONSTRAINT PK_OrderItems PRIMARY KEY CLUSTERED (OrderItemId),
    CONSTRAINT FK_OI_Order FOREIGN KEY (OrderId) REFERENCES dbo.Orders (OrderId),
    CONSTRAINT FK_OI_Product FOREIGN KEY (ProductId) REFERENCES dbo.Products (ProductId)
);
GO

CREATE TABLE dbo.ProductHistory (
    ProductHistoryId INT           IDENTITY(1,1) NOT NULL,
    ProductId        INT           NOT NULL,
    ChangeDate       DATETIME2     NOT NULL CONSTRAINT DF_PH_ChangeDate DEFAULT(SYSUTCDATETIME()),
    QuantityBefore   INT           NOT NULL,
    QuantityAfter    INT           NOT NULL,
    [Comment]        NVARCHAR(500) NULL,
    CONSTRAINT PK_ProductHistory PRIMARY KEY CLUSTERED (ProductHistoryId),
    CONSTRAINT FK_PH_Product FOREIGN KEY (ProductId) REFERENCES dbo.Products (ProductId)
);
GO

CREATE TABLE dbo.Employees (
    EmployeeId     INT IDENTITY(1,1) NOT NULL,
    UserId         INT         NOT NULL,
    FullName       NVARCHAR(200) NOT NULL,
    DateOfBirth    DATE        NOT NULL,
    PassportSeries NVARCHAR(20) NOT NULL,
    PassportNumber NVARCHAR(20) NOT NULL,
    BankAccount    NVARCHAR(50)  NULL,
    HasFamily      BIT          NOT NULL CONSTRAINT DF_Employees_HasFamily DEFAULT(0),
    HealthStatus   NVARCHAR(200) NULL,
    CONSTRAINT PK_Employees PRIMARY KEY CLUSTERED (EmployeeId),
    CONSTRAINT UQ_Employees_User UNIQUE (UserId),
    CONSTRAINT FK_Employees_User FOREIGN KEY (UserId) REFERENCES dbo.Users (UserId)
);
GO

CREATE TABLE dbo.Equipment (
    EquipmentId INT IDENTITY(1,1) NOT NULL,
    Name        NVARCHAR(200) NOT NULL,
    Description NVARCHAR(500) NULL,
    CONSTRAINT PK_Equipment PRIMARY KEY CLUSTERED (EquipmentId)
);
GO


CREATE TABLE dbo.AccessCards (
    CardId     INT IDENTITY(1,1) NOT NULL,
    EmployeeId INT         NOT NULL,
    CardNumber NVARCHAR(50) NOT NULL,
    IssueDate  DATETIME2   NOT NULL CONSTRAINT DF_AC_IssueDate DEFAULT(SYSUTCDATETIME()),
    ExpiryDate DATETIME2   NULL,
    CONSTRAINT PK_AccessCards PRIMARY KEY CLUSTERED (CardId),
    CONSTRAINT UQ_AccessCards_Number UNIQUE (CardNumber),
    CONSTRAINT FK_AC_Employee FOREIGN KEY (EmployeeId) REFERENCES dbo.Employees (EmployeeId)
);
GO
