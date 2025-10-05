CREATE TYPE media_mode as ENUM ('all', 'images', 'none');
CREATE TYPE user_state as ENUM ('active', 'unverified', 'inactive');
CREATE TYPE auth_user_group as ENUM ('all', 'account', 'verified');
CREATE TYPE replic_state as ENUM ('active', 'removed');
CREATE TYPE report_state as ENUM ('open', 'reviewed');
CREATE TYPE token_type as ENUM ('refresh', 'email');

CREATE TABLE users
(
    id                UUID PRIMARY KEY NOT NULL,
    created_timestamp TIMESTAMP        NOT NULL,

    email             TEXT             NOT NULL UNIQUE,
    username          TEXT             NOT NULL UNIQUE,
    is_admin          boolean          NOT NULL,
    profile_color     integer          NOT NULL,
    password_hash     TEXT             NOT NULL,
    state             user_state       NOT NULL
);

CREATE TABLE replics
(
    id                UUID PRIMARY KEY NOT NULL,
    created_timestamp TIMESTAMP        NOT NULL,

    original_link     TEXT             NOT NULL,
    media_mode        media_mode       NOT NULL,
    state             replic_state     NOT NULL,

    description       TEXT,
    expiration        TIMESTAMP,
    password_hash     TEXT,
    author_id         UUID REFERENCES users (id)
);

CREATE TABLE replic_accesses
(
    id                UUID PRIMARY KEY             NOT NULL,
    created_timestamp TIMESTAMP                    NOT NULL,

    replic_id         UUID REFERENCES replics (id) NOT NULL,
    visitor_id        UUID REFERENCES users (id)
);

CREATE TABLE reports
(
    id                UUID PRIMARY KEY             NOT NULL,
    created_timestamp TIMESTAMP                    NOT NULL,

    replic_id         UUID REFERENCES replics (id) NOT NULL,

    description       TEXT,
    author_id         UUID REFERENCES users (id)
);

CREATE TABLE server_config
(
    id                     UUID PRIMARY KEY NOT NULL,
    created_timestamp      TIMESTAMP        NOT NULL,

    create_replic_group    auth_user_group  NOT NULL,
    create_report_group    auth_user_group  NOT NULL,
    access_replic_group    auth_user_group  NOT NULL,
    allow_account_creation boolean          NOT NULL,

    limit_period           TEXT,
    limit_count            integer,
    limit_period_start TIMESTAMP,
    min_exp_period         TEXT
);

CREATE TABLE auth_token
(
    id                UUID PRIMARY KEY           NOT NULL,
    created_timestamp TIMESTAMP                  NOT NULL,

    expiration        TIMESTAMP                  NOT NULL,
    token             UUID                       NOT NULL UNIQUE,
    user_id           UUID REFERENCES users (id) NOT NULL,
    invalidated       boolean                    NOT NULL,
    type              token_type                 NOT NULL,

    data              TEXT
);