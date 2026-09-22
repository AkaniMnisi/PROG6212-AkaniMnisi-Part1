-- =============================================
-- RaceDay Database Schema & Seed Data
-- Module: PROG6212
-- =============================================

CREATE DATABASE RaceDayDB;
GO

USE RaceDayDB;
GO

-- 1. Users Table (Stores both Organisers and Participants)
CREATE TABLE Users (
    UserId INT IDENTITY(1,1) PRIMARY KEY,
    FullName NVARCHAR(100) NOT NULL,
    Email NVARCHAR(150) NOT NULL UNIQUE,
    PasswordHash NVARCHAR(255) NOT NULL,
    Role NVARCHAR(20) NOT NULL CHECK (Role IN ('Organiser', 'Participant')),
    CreatedAt DATETIME DEFAULT GETDATE()
);

-- 2. Events Table
CREATE TABLE Events (
    EventId INT IDENTITY(1,1) PRIMARY KEY,
    OrganiserId INT NOT NULL,
    EventName NVARCHAR(150) NOT NULL,
    Description NVARCHAR(MAX),
    EventDate DATETIME NOT NULL,
    Location NVARCHAR(200) NOT NULL,
    FOREIGN KEY (OrganiserId) REFERENCES Users(UserId) ON DELETE CASCADE
);

-- 3. Categories Table (e.g., 10km, 21km, 42km)
CREATE TABLE Categories (
    CategoryId INT IDENTITY(1,1) PRIMARY KEY,
    EventId INT NOT NULL,
    CategoryName NVARCHAR(50) NOT NULL,
    DistanceKm DECIMAL(5,2) NOT NULL,
    EntryFee DECIMAL(10,2) NOT NULL,
    MaxParticipants INT NOT NULL,
    FOREIGN KEY (EventId) REFERENCES Events(EventId) ON DELETE CASCADE
);

-- 4. Enrolments Table (Links Participants to Events)
CREATE TABLE Enrolments (
    EnrolmentId INT IDENTITY(1,1) PRIMARY KEY,
    ParticipantId INT NOT NULL,
    CategoryId INT NOT NULL,
    EnrolmentDate DATETIME DEFAULT GETDATE(),
    BibNumber NVARCHAR(20),
    FOREIGN KEY (ParticipantId) REFERENCES Users(UserId),
    FOREIGN KEY (CategoryId) REFERENCES Categories(CategoryId)
);

-- 5. Results Table
CREATE TABLE Results (
    ResultId INT IDENTITY(1,1) PRIMARY KEY,
    EnrolmentId INT NOT NULL UNIQUE,
    FinishTime TIME(0) NOT NULL,
    Position INT,
    FOREIGN KEY (EnrolmentId) REFERENCES Enrolments(EnrolmentId) ON DELETE CASCADE
);

-- 6. Routes Table (For route info and weather preparation)
CREATE TABLE Routes (
    RouteId INT IDENTITY(1,1) PRIMARY KEY,
    CategoryId INT NOT NULL,
    RouteMapUrl NVARCHAR(500),
    ElevationGainMeters INT,
    RouteDescription NVARCHAR(MAX),
    FOREIGN KEY (CategoryId) REFERENCES Categories(CategoryId) ON DELETE CASCADE
);
GO

-- =============================================
-- SEED DATA (Realistic SA Context)
-- =============================================

-- Insert 2 Organisers
INSERT INTO Users (FullName, Email, PasswordHash, Role) VALUES 
('Comrades Organising Committee', 'admin@comrades.co.za', 'hashed_pw_1', 'Organiser'),
('Cape Town Cycle Tour Trust', 'info@capetowncycletour.co.za', 'hashed_pw_2', 'Organiser');

-- Insert 2 Participants
INSERT INTO Users (FullName, Email, PasswordHash, Role) VALUES 
('John Doe', 'john.doe@gmail.com', 'hashed_pw_3', 'Participant'),
('Jane Smith', 'jane.smith@webmail.co.za', 'hashed_pw_4', 'Participant');

-- Insert 3 Events
INSERT INTO Events (OrganiserId, EventName, Description, EventDate, Location) VALUES 
(1, 'Comrades Marathon 2026', 'The Ultimate Human Race', '2026-06-14 05:30:00', 'Pietermaritzburg to Durban'),
(2, 'Cape Town Cycle Tour 2026', 'The world''s largest timed cycle race', '2026-03-08 06:00:00', 'Cape Town'),
(1, 'Soweto Marathon 2026', 'Annual marathon in Soweto', '2026-11-01 06:00:00', 'Soweto, Johannesburg');

-- Insert Categories for those events
INSERT INTO Categories (EventId, CategoryName, DistanceKm, EntryFee, MaxParticipants) VALUES 
(1, 'Ultra Marathon', 89.00, 600.00, 20000),
(2, 'Cycle Tour', 109.00, 750.00, 35000),
(3, 'Half Marathon', 21.10, 250.00, 10000);

-- Insert Sample Enrolments
INSERT INTO Enrolments (ParticipantId, CategoryId, BibNumber) VALUES 
(3, 1, '12345'),
(4, 2, '54321'),
(3, 3, '98765');

-- Insert Sample Results
INSERT INTO Results (EnrolmentId, FinishTime, Position) VALUES 
(1, '11:30:00', 4502),
(2, '03:45:00', 1205);

-- Insert Sample Routes
INSERT INTO Routes (CategoryId, RouteMapUrl, ElevationGainMeters, RouteDescription) VALUES 
(1, 'https://comrades.com/map', 1500, 'Rolling hills between PMB and Durban.'),
(2, 'https://capetowncycletour.com/map', 800, 'Coastal route around the Cape Peninsula.');
GO