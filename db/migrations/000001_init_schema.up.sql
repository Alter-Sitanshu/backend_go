CREATE TABLE "doctors" (
  "id" bigserial PRIMARY KEY,
  "first_name" varchar(60) NOT NULL,
  "last_name" varchar(60) NOT NULL,
  "dept" integer NOT NULL,
  "contact" varchar(12) NOT NULL,
  "experience" integer NOT NULL,
  "fee" integer NOT NULL,
  "email" varchar(60) NOT NULL,
  "created_at" timestamptz DEFAULT 'now()'
);

CREATE TABLE "users" (
  "id" bigserial PRIMARY KEY,
  "first_name" varchar(60) NOT NULL,
  "last_name" varchar(60) NOT NULL,
  "contact" varchar(12) NOT NULL,
  "created_at" timestamptz DEFAULT 'now()'
);

CREATE TABLE "departments" (
  "id" bigserial PRIMARY KEY NOT NULL,
  "name" varchar(10) NOT NULL
);

CREATE TABLE "bookings" (
  "id" bigserial PRIMARY KEY,
  "user_id" bigint NOT NULL,
  "doc_id" bigint NOT NULL,
  "booked_at" timestamptz NOT NULL DEFAULT 'now()',
  "slot" timestamptz NOT NULL
);

CREATE INDEX ON "doctors" ("id");

CREATE INDEX ON "doctors" ("dept");

CREATE INDEX ON "doctors" ("first_name");

CREATE INDEX ON "users" ("id");

CREATE INDEX ON "bookings" ("user_id", "doc_id");

COMMENT ON COLUMN "doctors"."experience" IS 'CHECK (experience > 0)';

COMMENT ON COLUMN "doctors"."fee" IS 'CHECK (fee > 0)';

ALTER TABLE "doctors" ADD FOREIGN KEY ("dept") REFERENCES "departments" ("id");

ALTER TABLE "bookings" ADD FOREIGN KEY ("user_id") REFERENCES "users" ("id");

ALTER TABLE "bookings" ADD FOREIGN KEY ("doc_id") REFERENCES "doctors" ("id");