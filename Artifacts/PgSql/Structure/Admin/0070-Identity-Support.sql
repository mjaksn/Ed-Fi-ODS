-- SPDX-License-Identifier: Apache-2.0
-- Licensed to the Ed-Fi Alliance under one or more agreements.
-- The Ed-Fi Alliance licenses this file to you under the Apache License, Version 2.0.
-- See the LICENSE and NOTICES files in the project root for more information.

CREATE TABLE dbo.aspnetroleclaims (
    id integer NOT NULL,
    roleid text NOT NULL,
    claimtype text,
    claimvalue text
);

ALTER TABLE dbo.aspnetroleclaims ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME dbo.aspnetroleclaims_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

CREATE TABLE dbo.aspnetroles (
    id text NOT NULL,
    name character varying(256),
    normalizedname character varying(256),
    concurrencystamp text
);

CREATE TABLE dbo.aspnetuserclaims (
    id integer NOT NULL,
    userid text NOT NULL,
    claimtype text,
    claimvalue text
);

ALTER TABLE dbo.aspnetuserclaims ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME dbo.aspnetuserclaims_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);

CREATE TABLE dbo.aspnetuserlogins (
    loginprovider text NOT NULL,
    providerkey text NOT NULL,
    providerdisplayname text,
    userid text NOT NULL
);

CREATE TABLE dbo.aspnetuserroles (
    userid text NOT NULL,
    roleid text NOT NULL
);

CREATE TABLE dbo.aspnetusers (
    id text NOT NULL,
    username character varying(256),
    normalizedusername character varying(256),
    email character varying(256),
    normalizedemail character varying(256),
    emailconfirmed boolean NOT NULL,
    passwordhash text,
    securitystamp text,
    concurrencystamp text,
    phonenumber text,
    phonenumberconfirmed boolean NOT NULL,
    twofactorenabled boolean NOT NULL,
    lockoutend timestamp with time zone,
    lockoutenabled boolean NOT NULL,
    accessfailedcount integer NOT NULL
);

CREATE TABLE dbo.aspnetusertokens (
    userid text NOT NULL,
    loginprovider text NOT NULL,
    name text NOT NULL,
    value text
);

ALTER TABLE ONLY dbo.aspnetroleclaims
    ADD CONSTRAINT pk_aspnetroleclaims PRIMARY KEY (id);

ALTER TABLE ONLY dbo.aspnetroles
    ADD CONSTRAINT pk_aspnetroles PRIMARY KEY (id);

ALTER TABLE ONLY dbo.aspnetuserclaims
    ADD CONSTRAINT pk_aspnetuserclaims PRIMARY KEY (id);

ALTER TABLE ONLY dbo.aspnetuserlogins
    ADD CONSTRAINT pk_aspnetuserlogins PRIMARY KEY (loginprovider, providerkey);

ALTER TABLE ONLY dbo.aspnetuserroles
    ADD CONSTRAINT pk_aspnetuserroles PRIMARY KEY (userid, roleid);

ALTER TABLE ONLY dbo.aspnetusers
    ADD CONSTRAINT pk_aspnetusers PRIMARY KEY (id);

ALTER TABLE ONLY dbo.aspnetusertokens
    ADD CONSTRAINT pk_aspnetusertokens PRIMARY KEY (userid, loginprovider, name);

CREATE INDEX emailindex ON dbo.aspnetusers USING btree (normalizedemail);

CREATE INDEX ix_aspnetroleclaims_roleid ON dbo.aspnetroleclaims USING btree (roleid);

CREATE INDEX ix_aspnetuserclaims_userid ON dbo.aspnetuserclaims USING btree (userid);

CREATE INDEX ix_aspnetuserlogins_userid ON dbo.aspnetuserlogins USING btree (userid);

CREATE INDEX ix_aspnetuserroles_roleid ON dbo.aspnetuserroles USING btree (roleid);

CREATE UNIQUE INDEX rolenameindex ON dbo.aspnetroles USING btree (normalizedname);

CREATE UNIQUE INDEX usernameindex ON dbo.aspnetusers USING btree (normalizedusername);

ALTER TABLE ONLY dbo.aspnetroleclaims
    ADD CONSTRAINT fk_aspnetroleclaims_aspnetroles_roleid FOREIGN KEY (roleid) REFERENCES dbo.aspnetroles(id) ON DELETE CASCADE;

ALTER TABLE ONLY dbo.aspnetuserclaims
    ADD CONSTRAINT fk_aspnetuserclaims_aspnetusers_userid FOREIGN KEY (userid) REFERENCES dbo.aspnetusers(id) ON DELETE CASCADE;

ALTER TABLE ONLY dbo.aspnetuserlogins
    ADD CONSTRAINT fk_aspnetuserlogins_aspnetusers_userid FOREIGN KEY (userid) REFERENCES dbo.aspnetusers(id) ON DELETE CASCADE;

ALTER TABLE ONLY dbo.aspnetuserroles
    ADD CONSTRAINT fk_aspnetuserroles_aspnetroles_roleid FOREIGN KEY (roleid) REFERENCES dbo.aspnetroles(id) ON DELETE CASCADE;

ALTER TABLE ONLY dbo.aspnetuserroles
    ADD CONSTRAINT fk_aspnetuserroles_aspnetusers_userid FOREIGN KEY (userid) REFERENCES dbo.aspnetusers(id) ON DELETE CASCADE;

ALTER TABLE ONLY dbo.aspnetusertokens
    ADD CONSTRAINT fk_aspnetusertokens_aspnetusers_userid FOREIGN KEY (userid) REFERENCES dbo.aspnetusers(id) ON DELETE CASCADE;

