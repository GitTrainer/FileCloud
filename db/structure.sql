CREATE TABLE "schema_migrations" ("version" varchar(255) NOT NULL);
CREATE TABLE "users" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "name" varchar(255), "email" varchar(255), "login" varchar(255), "created_at" datetime NOT NULL, "updated_at" datetime NOT NULL, "password_digest" varchar(255), "remember_token" varchar(255), "admin" boolean DEFAULT 'f', "password_reset" varchar(255), "password_reset_sent_at" datetime, "status" boolean DEFAULT 'f');
CREATE UNIQUE INDEX "index_users_on_email" ON "users" ("email");
CREATE INDEX "index_users_on_remember_token" ON "users" ("remember_token");
CREATE UNIQUE INDEX "unique_schema_migrations" ON "schema_migrations" ("version");
INSERT INTO schema_migrations (version) VALUES ('20130108065816');

INSERT INTO schema_migrations (version) VALUES ('20130110035058');

INSERT INTO schema_migrations (version) VALUES ('20130110063103');

INSERT INTO schema_migrations (version) VALUES ('20130110082044');

INSERT INTO schema_migrations (version) VALUES ('20130110102115');

INSERT INTO schema_migrations (version) VALUES ('20130111073825');

INSERT INTO schema_migrations (version) VALUES ('20130111082713');

INSERT INTO schema_migrations (version) VALUES ('20130114102205');