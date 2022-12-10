BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "demo_myroles" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"useremail"	varchar(255) NOT NULL,
	"userrole"	varchar(255) NOT NULL,
	"created_at"	datetime NOT NULL,
	"updated_at"	datetime NOT NULL
);
CREATE TABLE IF NOT EXISTS "demo_apografh" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"first_name"	varchar(255) NOT NULL,
	"last_name"	varchar(255) NOT NULL,
	"email"	varchar(255) NOT NULL,
	"father_name"	varchar(255) NOT NULL,
	"mother_name"	varchar(255) NOT NULL,
	"id_number"	varchar(255) NOT NULL,
	"AFM"	varchar(255) NOT NULL,
	"nomos"	varchar(255) NOT NULL,
	"perioxh"	varchar(255) NOT NULL,
	"odos"	varchar(255) NOT NULL,
	"aithsh_id"	varchar(255) NOT NULL,
	"height"	varchar(255) NOT NULL,
	"weight"	varchar(255) NOT NULL,
	"katatajh"	varchar(255) NOT NULL,
	"education_level"	varchar(255) NOT NULL,
	"communication"	varchar(255) NOT NULL,
	"formFile"	varchar(100) NOT NULL,
	"created_at"	datetime NOT NULL,
	"updated_at"	datetime NOT NULL,
	"status"	varchar(255) NOT NULL
);
CREATE TABLE IF NOT EXISTS "demo_aithsh" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"first_name"	varchar(255) NOT NULL,
	"last_name"	varchar(255) NOT NULL,
	"email"	varchar(255) NOT NULL,
	"katatajh"	varchar(255) NOT NULL,
	"education_level"	varchar(255) NOT NULL,
	"communication"	varchar(255) NOT NULL,
	"status"	varchar(255) NOT NULL,
	"created_at"	datetime NOT NULL,
	"updated_at"	datetime NOT NULL,
	"age"	varchar(255) NOT NULL,
	"formFile"	varchar(100) NOT NULL,
	"military_id"	varchar(255) NOT NULL,
	"nomos_stratopedou"	varchar(255) NOT NULL,
	"number_stratopedou"	varchar(255) NOT NULL
);
CREATE TABLE IF NOT EXISTS "demo_sxolh" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"first_name"	varchar(255) NOT NULL,
	"last_name"	varchar(255) NOT NULL,
	"email"	varchar(255) NOT NULL,
	"age"	varchar(255) NOT NULL,
	"AFM"	varchar(255) NOT NULL,
	"AMKA"	varchar(255) NOT NULL,
	"communication"	varchar(255) NOT NULL,
	"mysxolh"	varchar(255) NOT NULL,
	"formFile"	varchar(100) NOT NULL,
	"status"	varchar(255) NOT NULL,
	"created_at"	datetime NOT NULL,
	"updated_at"	datetime NOT NULL
);
CREATE TABLE IF NOT EXISTS "demo_diakoph" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"first_name"	varchar(255) NOT NULL,
	"last_name"	varchar(255) NOT NULL,
	"email"	varchar(255) NOT NULL,
	"aithsh_id"	varchar(255) NOT NULL,
	"reason"	varchar(355) NOT NULL,
	"status"	varchar(255) NOT NULL,
	"created_at"	datetime NOT NULL,
	"updated_at"	datetime NOT NULL,
	"formFile"	varchar(100) NOT NULL
);
CREATE TABLE IF NOT EXISTS "django_session" (
	"session_key"	varchar(40) NOT NULL,
	"session_data"	text NOT NULL,
	"expire_date"	datetime NOT NULL,
	PRIMARY KEY("session_key")
);
CREATE TABLE IF NOT EXISTS "django_keycloak_server" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"url"	varchar(255) NOT NULL,
	"internal_url"	varchar(255)
);
CREATE TABLE IF NOT EXISTS "django_keycloak_role" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"reference"	varchar(50) NOT NULL,
	"client_id"	bigint NOT NULL,
	"permission_id"	integer NOT NULL,
	FOREIGN KEY("permission_id") REFERENCES "auth_permission"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("client_id") REFERENCES "django_keycloak_client"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "django_keycloak_remoteclient" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"name"	varchar(255) NOT NULL,
	"realm_id"	bigint NOT NULL,
	FOREIGN KEY("realm_id") REFERENCES "django_keycloak_realm"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "django_keycloak_realm" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"name"	varchar(255) NOT NULL UNIQUE,
	"_certs"	text NOT NULL,
	"_well_known_oidc"	text NOT NULL,
	"server_id"	integer NOT NULL,
	FOREIGN KEY("server_id") REFERENCES "django_keycloak_server"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "django_keycloak_openidconnectprofile" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"access_token"	text,
	"expires_before"	datetime,
	"refresh_token"	text,
	"refresh_expires_before"	datetime,
	"sub"	varchar(255) NOT NULL UNIQUE,
	"realm_id"	integer NOT NULL,
	"user_id"	integer NOT NULL UNIQUE,
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("realm_id") REFERENCES "django_keycloak_realm"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "django_keycloak_nonce" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"state"	char(32) NOT NULL UNIQUE,
	"redirect_uri"	varchar(255) NOT NULL,
	"next_path"	varchar(255)
);
CREATE TABLE IF NOT EXISTS "django_keycloak_exchangedtoken" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"access_token"	text,
	"expires_before"	datetime,
	"refresh_token"	text,
	"refresh_expires_before"	datetime,
	"oidc_profile_id"	integer NOT NULL,
	"remote_client_id"	integer NOT NULL,
	FOREIGN KEY("remote_client_id") REFERENCES "django_keycloak_remoteclient"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("oidc_profile_id") REFERENCES "django_keycloak_openidconnectprofile"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "django_keycloak_client" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"client_id"	varchar(255) NOT NULL,
	"secret"	varchar(255) NOT NULL,
	"realm_id"	integer NOT NULL UNIQUE,
	"service_account_profile_id"	integer UNIQUE,
	FOREIGN KEY("service_account_profile_id") REFERENCES "django_keycloak_openidconnectprofile"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("realm_id") REFERENCES "django_keycloak_realm"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "auth_user" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"password"	varchar(128) NOT NULL,
	"last_login"	datetime,
	"is_superuser"	bool NOT NULL,
	"username"	varchar(150) NOT NULL UNIQUE,
	"last_name"	varchar(150) NOT NULL,
	"email"	varchar(254) NOT NULL,
	"is_staff"	bool NOT NULL,
	"is_active"	bool NOT NULL,
	"date_joined"	datetime NOT NULL,
	"first_name"	varchar(150) NOT NULL
);
CREATE TABLE IF NOT EXISTS "auth_group" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"name"	varchar(150) NOT NULL UNIQUE
);
CREATE TABLE IF NOT EXISTS "auth_permission" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"content_type_id"	integer NOT NULL,
	"codename"	varchar(100) NOT NULL,
	"name"	varchar(255) NOT NULL,
	FOREIGN KEY("content_type_id") REFERENCES "django_content_type"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "django_content_type" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"app_label"	varchar(100) NOT NULL,
	"model"	varchar(100) NOT NULL
);
CREATE TABLE IF NOT EXISTS "django_admin_log" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"action_time"	datetime NOT NULL,
	"object_id"	text,
	"object_repr"	varchar(200) NOT NULL,
	"change_message"	text NOT NULL,
	"content_type_id"	integer,
	"user_id"	integer NOT NULL,
	"action_flag"	smallint unsigned NOT NULL CHECK("action_flag">=0),
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("content_type_id") REFERENCES "django_content_type"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "auth_user_user_permissions" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"user_id"	integer NOT NULL,
	"permission_id"	integer NOT NULL,
	FOREIGN KEY("permission_id") REFERENCES "auth_permission"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "auth_user_groups" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"user_id"	integer NOT NULL,
	"group_id"	integer NOT NULL,
	FOREIGN KEY("group_id") REFERENCES "auth_group"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "auth_group_permissions" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"group_id"	integer NOT NULL,
	"permission_id"	integer NOT NULL,
	FOREIGN KEY("permission_id") REFERENCES "auth_permission"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("group_id") REFERENCES "auth_group"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "django_migrations" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"app"	varchar(255) NOT NULL,
	"name"	varchar(255) NOT NULL,
	"applied"	datetime NOT NULL
);
INSERT INTO "demo_myroles" VALUES (1,'admin@hua.gr','admin','2022-11-13 15:50:40.513234','2022-11-13 15:50:40.513282');
INSERT INTO "demo_myroles" VALUES (2,'rey@hua.gr','soldier','2022-11-13 15:58:27.815508','2022-11-13 15:58:27.815567');
INSERT INTO "demo_myroles" VALUES (5,'joe@hua.gr','staff','2022-11-15 12:20:15.688658','2022-11-15 12:20:15.688709');
INSERT INTO "demo_myroles" VALUES (6,'giannis@hua.gr','soldier','2022-11-15 12:22:57.463642','2022-11-15 12:22:57.463685');
INSERT INTO "demo_myroles" VALUES (7,'mike@hua.gr','soldier','2022-11-15 18:32:41.797218','2022-11-15 18:32:41.797262');
INSERT INTO "demo_apografh" VALUES (2,'rey','mysterio','rey@hua.gr','john','maria','an45845','0755565652','euboia','xalkida','monis eriwn ','2','170','60','Στρατός ξηράς','Τελειόφοιτος Δημοτικού','6943269657','f6c82580b76c40bcab3103d9c1100b1d.png','2022-11-12 16:38:09.663144','2022-11-12 16:38:09.663190','Checked');
INSERT INTO "demo_aithsh" VALUES (1,'rey','mysterio','rey@hua.gr','Στρατός ξηράς','Τελειόφοιτος Δημοτικού','6943269657','Reject','2022-11-05 16:16:30.984351','2022-11-05 16:16:30.984399','18','0000000','','Επιλέξτε νομό...','');
INSERT INTO "demo_aithsh" VALUES (2,'rey','mysterio','rey@hua.gr','Στρατός ξηράς','Τελειόφοιτος Δημοτικού','6943269657','Pass','2022-11-05 16:16:59.677608','2022-11-05 16:16:59.677675','28','0000000','1002','ΦΘΙΩΤΙΔΑΣ','288');
INSERT INTO "demo_aithsh" VALUES (3,'rey','mysterio','rey@hua.gr','Στρατός ξηράς','Τελειόφοιτος Δημοτικού','6943269657','Reject','2022-11-06 13:27:31.323470','2022-11-06 13:27:31.323526','18','user.png','1003','ΦΘΙΩΤΙΔΑΣ','191');
INSERT INTO "demo_aithsh" VALUES (4,'mike','mpatsovski','mike@hua.gr','Ειδικές Δυνάμεις','Τελειόφοιτος Πανεπιστημίου','6943269657','Reject','2022-11-17 12:23:37.099369','2022-11-17 12:23:37.099440','21','1stDeliverable.pdf','','Επιλέξτε νομό...','');
INSERT INTO "demo_aithsh" VALUES (5,'mike','mpatsovski','mike@hua.gr','Ειδικές Δυνάμεις','Τελειόφοιτος Πανεπιστημίου','6943269657','Reject','2022-11-17 12:42:53.616752','2022-11-17 12:42:53.616808','21','1stDeliverable_Z5Z82Rt.pdf','','Επιλέξτε νομό...','');
INSERT INTO "demo_sxolh" VALUES (1,'rey','mysterio','rey@hua.gr','18','0755565652','2123141414','6943269657','Ανώτατο Στρατιωτικό Εκπαιδευτικό Ίδρυμα','user_0YKriQz.png','Reject','2022-11-10 12:20:47.953052','2022-11-10 12:20:47.953132');
INSERT INTO "demo_sxolh" VALUES (2,'rey','mysterio','rey@hua.gr','18','0755565652','2123141414','666666666','Στρατιωτική Σχολή Αξιωματικών Σωμάτων','user_tuKckSO.png','Reject','2022-11-16 16:18:25.240400','2022-11-16 16:18:25.240452');
INSERT INTO "demo_sxolh" VALUES (3,'mike','mpatsovski','mike@hua.gr','18','0755565652','2123141414','6943269657','Ανώτατο Στρατιωτικό Εκπαιδευτικό Ίδρυμα','1stDeliverable_XHM1FB3.pdf','Reject','2022-11-17 12:43:31.266525','2022-11-17 12:43:31.266589');
INSERT INTO "demo_diakoph" VALUES (1,'rey','mysterio','rey@hua.gr','1','Για λόγους υγείας','Pass','2022-11-12 15:45:13.305899','2022-11-12 15:45:13.305981','user_8JH0dDu.png');
INSERT INTO "django_session" VALUES ('74ueg07yta1yj8wfa7q6qubm1r8jxtsc','eyJvaWRjX3N0YXRlIjoiYTdlMjFiMTUtZWFkNy00M2MxLTlmMmEtMTFmZmJjODM3ZjM3In0:1opozI:c7gdNMwRn92OVnr-nz7ii8EF0W_bzZcJzPy-_wlymGY','2022-11-15 10:59:20.528095');
INSERT INTO "django_session" VALUES ('rw1s4tr8tmackvk6btaxfxnrl6q4wuv2','eyJvaWRjX3N0YXRlIjoiMTlhMGFmNGQtZTU0Zi00ODM1LWI0YmItNDJlNWZkOTM4OTA4In0:1opp0C:xNsEq3Qpd3we8JDo6OD2Cpz4nT2Fp1D-L1Sd37Knneg','2022-11-15 11:00:16.368801');
INSERT INTO "django_session" VALUES ('a37do8bvyqlugv2wpzpdcobvg3f0np6w','eyJvaWRjX3N0YXRlIjoiM2QwYzI2N2UtMGYwZS00NGFlLTk1ZWMtZmVhYWZkZThmZDVjIn0:1opp7d:39evu_XLxevXljfGkWDHxthDLUWG_xe0mcVvKCeQKO8','2022-11-15 11:07:57.101003');
INSERT INTO "django_session" VALUES ('jef1gkcoe85cdm5mx7bvonsy6bs0uk9a','eyJvaWRjX3N0YXRlIjoiYWVjMTQ4ZDMtNGJlYy00NzliLWE1YzAtYmYwYWExOWFjMjQxIn0:1oppBN:mDoStwzyR4ZBiAy08lRKPKocLtNZBFxn_Q2TuM1rDkA','2022-11-15 11:11:49.844808');
INSERT INTO "django_session" VALUES ('qwtf5dnz7n8rjlxaaxy1sniuvqnl5ejq','eyJvaWRjX3N0YXRlIjoiZmM0MTc3M2EtMzI3My00YWFmLWI0ZDQtZWM4MDU1MGNjMmU4In0:1oppCN:kRmyjHoy4AcXThSglP8eQ2u80hxT3FuY6QLFTB4I0Qc','2022-11-15 11:12:51.743282');
INSERT INTO "django_session" VALUES ('ys9p8dvwf3o98qjtr0zlycmgt5nghzyo','eyJvaWRjX3N0YXRlIjoiZmQ0NzczZDUtODVjOC00ZTJiLWIwMGUtYTM1OTE5NGVmMzU4In0:1oppCo:0jB9yXZey02xZYNPRuflWzX4mVGf-oNOLFqlKqJtPjc','2022-11-15 11:13:18.061037');
INSERT INTO "django_session" VALUES ('6vhju0zhtmys5razvrr046yfbref7w3b','eyJvaWRjX3N0YXRlIjoiMWU3ZjNhZWEtZDRhYy00MzkyLThkNzMtZGU5OGUwMzI2ZGRjIn0:1opq0Y:1hEAK51-aZCJGRMmtrGDKmdHlwKUzhgIS-cxEy9o4iQ','2022-11-15 12:04:42.083258');
INSERT INTO "django_session" VALUES ('78uccs7xp991dg3kbekuanyt43v14slt','eyJvaWRjX3N0YXRlIjoiMjgxYTNmMjktZjcxNS00NjIzLTk1YWEtMTNmOGRhMDI1ZDYyIn0:1opq0w:AbhdaDYlB8KdT-QGWuJ-9xQJkDA11X2MpxamMahdZho','2022-11-15 12:05:06.199308');
INSERT INTO "django_session" VALUES ('4xqrjfnp8b8vcpdcsu95cnquydmusact','eyJvaWRjX3N0YXRlIjoiMmEyZDQzYTEtODE3ZS00Y2ZiLTkxYmEtN2JlMzcwZGIzODg4In0:1opq10:ExoC72ev6kGi1WFxcwc56q0vljSA6iqmr0yLXmcuoLU','2022-11-15 12:05:10.866106');
INSERT INTO "django_session" VALUES ('rlk09c2mmscr3ssibr40i06fd0or3bdt','eyJvaWRjX3N0YXRlIjoiOWU4OTVhZmMtNDU4Mi00YjIwLTk1MDktMzljOGY0YzdkY2IwIn0:1opqPR:05Gx2bdxxhZose14HExTrSr_x7sK1ndUJ3vSTVYme80','2022-11-15 12:30:25.735197');
INSERT INTO "django_session" VALUES ('kr2t0j5yp0oju25kqoypbru26gj6bfws','.eJxVjDsOwjAQBe_imkSO4y8dUHIIa71ekxAUS_kUgLg7jpQm7cx782W5j-jnBRZiZyatFgIbrFQQoZJK6gpMxMpoYwQnbShpdmIe1qXz60yT72O5tUcWAAcaNxGfMD6yH-iNrwxDvW3qXc_1fceXQvPUf2Dp83jLka574FDtYO5K0irOVQoNJ-CYuIYkyenkbFLgLIhWxIhKOWpd44A7QY10ZaQIBErJ2e8PDXBOwQ:1oqEPf:mAUra1iPAE8RNfIL354aZ8bdvsK1iaFzr3i-MjgfUQA','2022-11-16 14:08:15.434316');
INSERT INTO "django_session" VALUES ('fpodeqkonr69qrauvgxp8fgic4bhtvsj','.eJxVjMFugzAUBP_F54KejQ283NIe8xHW2n4uhAhLgRzSqv9ekLhwndmdX1XGFP2yYhV1UR2LdEx9xbC2shldFXTXVgaNZkfggKA-lMdrHfxrkacf03ZrziwgTjLvIt0xfxc_yTs-CqZ639SHXurbga8bLc_xB-tY5q-S5PMInKoDlmFL9o7I5aBJQDFTi2yF28x9duAepjEpRedYGtYMYiPa8jZyAhOtJfX3DzVJTvE:1oqGMx:8CilbzdnoOSq3X1F_TuM5Y9K5xOYvN3wsE6SvylmRs4','2022-11-16 16:13:35.819674');
INSERT INTO "django_session" VALUES ('iwr5e549xrtujk1y2w274qiqd4d7ofe2','eyJvaWRjX3N0YXRlIjoiOGQ1YzZiNGEtOGM0Yi00YmM5LThjYmEtMzMzYTYwNzgxODdjIn0:1otA22:Tn5_mwpMrU6inPgcEeGwOThus4XZ4nsAZMkd2RGwOro','2022-11-24 16:03:58.618339');
INSERT INTO "django_session" VALUES ('56kywrv0c8c9rz4ganeyxfs4l3k9ojza','eyJvaWRjX3N0YXRlIjoiNzU5ODM3OTgtZjY0My00ZTIwLTlmOWItNWRmMDE1ZjM1MDJiIn0:1ovfTB:JDE4p75yjq1t_idea02Rl-5J66gf6cRTzLfpKKB409I','2022-12-01 14:02:21.275732');
INSERT INTO "django_keycloak_server" VALUES (1,'http://localhost:8080/auth','http://localhost:8080/auth');
INSERT INTO "django_keycloak_realm" VALUES (1,'demo','{"keys": [{"kid": "abEDuAMbGTahA945yll1lt6eUibmqFMnh6agtzQWolk", "kty": "RSA", "alg": "RS256", "use": "sig", "n": "qLk-tdk9hDWs2GcArxzM4JZBDxtcIToh6lky9aIZidpFxvMWzYqnH1-rlsDbbRj-rk6lRGx2i04HwcvJLP8bwS2tFc7w3ozVJ6ziFJ3kDGquHA36-Wiq0eDd4wwKeFgyjanTdxmShDiC_4doDJD9p-sNkDHD1bJxY2VJjhSxHLM_4pCsOfhFAXXIX-kWBfduJKQue6lo_X4JgLAccpn3xwRoMaIHcv6ukOrvzzU2ikvwf9oMYjflDfFpvlFOME4j7_N8go-wO97l-NWnFvdiEnErdVAvPzR6y_H1JwgqwWIUFUnVOfI2ZKsvTslNxzzhLy-4tb-tdGMsyJDcnzT-EQ", "e": "AQAB", "x5c": ["MIIClzCCAX8CBgGD0KeE+TANBgkqhkiG9w0BAQsFADAPMQ0wCwYDVQQDDARkZW1vMB4XDTIyMTAxMzA5MjEyM1oXDTMyMTAxMzA5MjMwM1owDzENMAsGA1UEAwwEZGVtbzCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAKi5PrXZPYQ1rNhnAK8czOCWQQ8bXCE6IepZMvWiGYnaRcbzFs2Kpx9fq5bA220Y/q5OpURsdotOB8HLySz/G8EtrRXO8N6M1Ses4hSd5AxqrhwN+vloqtHg3eMMCnhYMo2p03cZkoQ4gv+HaAyQ/afrDZAxw9WycWNlSY4UsRyzP+KQrDn4RQF1yF/pFgX3biSkLnupaP1+CYCwHHKZ98cEaDGiB3L+rpDq7881NopL8H/aDGI35Q3xab5RTjBOI+/zfIKPsDve5fjVpxb3YhJxK3VQLz80esvx9ScIKsFiFBVJ1TnyNmSrL07JTcc84S8vuLW/rXRjLMiQ3J80/hECAwEAATANBgkqhkiG9w0BAQsFAAOCAQEARQJFuEFvIdvZok/fS0qkFBmMd9zgy1IeDK6WZB98j+12bKqxgSzBM2UuU+hDDxe6sESvxJQIIs3fpWm3xYPRWd2dYjbkhmPq9QHQi8WB5mrtgSfleGdUwc+x4M4Q7yC/eiutJSVA6JZD/iJf4Ib6gkRqiiSqWSKKKEdcTO+XG+1V7tdOqHa4LnusnQGtLAPrwUDdbHQYQ2kD/GGGcj4Wgzycd8RDDzprEd1Pn6bGda1I+HVpWR5PQoUYlr3tOCZPrR5MzJOpCBNpvM21ZJzx9TiZzZYLrX88gtz/zLsLUqBVID6zNX0MRu8grPK+NmamfNbt5ZQeYV9l+OSERHkn8Q=="], "x5t": "00iBnkUuyymFiERUBb19WGfy5CY", "x5t#S256": "ljuo7RJ7tAi2eBbvjJqJWD2AYVtxl36mbWYPeG4grqs"}]}','{"issuer": "http://localhost:8080/auth/realms/demo", "authorization_endpoint": "http://localhost:8080/auth/realms/demo/protocol/openid-connect/auth", "token_endpoint": "http://localhost:8080/auth/realms/demo/protocol/openid-connect/token", "token_introspection_endpoint": "http://localhost:8080/auth/realms/demo/protocol/openid-connect/token/introspect", "userinfo_endpoint": "http://localhost:8080/auth/realms/demo/protocol/openid-connect/userinfo", "end_session_endpoint": "http://localhost:8080/auth/realms/demo/protocol/openid-connect/logout", "jwks_uri": "http://localhost:8080/auth/realms/demo/protocol/openid-connect/certs", "check_session_iframe": "http://localhost:8080/auth/realms/demo/protocol/openid-connect/login-status-iframe.html", "grant_types_supported": ["authorization_code", "implicit", "refresh_token", "password", "client_credentials"], "response_types_supported": ["code", "none", "id_token", "token", "id_token token", "code id_token", "code token", "code id_token token"], "subject_types_supported": ["public", "pairwise"], "id_token_signing_alg_values_supported": ["PS384", "ES384", "RS384", "HS256", "HS512", "ES256", "RS256", "HS384", "ES512", "PS256", "PS512", "RS512"], "userinfo_signing_alg_values_supported": ["PS384", "ES384", "RS384", "HS256", "HS512", "ES256", "RS256", "HS384", "ES512", "PS256", "PS512", "RS512", "none"], "request_object_signing_alg_values_supported": ["PS384", "ES384", "RS384", "ES256", "RS256", "ES512", "PS256", "PS512", "RS512", "none"], "response_modes_supported": ["query", "fragment", "form_post"], "registration_endpoint": "http://localhost:8080/auth/realms/demo/clients-registrations/openid-connect", "token_endpoint_auth_methods_supported": ["private_key_jwt", "client_secret_basic", "client_secret_post", "client_secret_jwt"], "token_endpoint_auth_signing_alg_values_supported": ["RS256"], "claims_supported": ["aud", "sub", "iss", "auth_time", "name", "given_name", "family_name", "preferred_username", "email"], "claim_types_supported": ["normal"], "claims_parameter_supported": false, "scopes_supported": ["openid", "address", "email", "microprofile-jwt", "offline_access", "phone", "profile", "roles", "web-origins"], "request_parameter_supported": true, "request_uri_parameter_supported": true, "code_challenge_methods_supported": ["plain", "S256"], "tls_client_certificate_bound_access_tokens": true, "introspection_endpoint": "http://localhost:8080/auth/realms/demo/protocol/openid-connect/token/introspect"}',1);
INSERT INTO "django_keycloak_openidconnectprofile" VALUES (1,NULL,NULL,NULL,NULL,'8f929050-717a-4b78-b0e7-928632fa12ed',1,3);
INSERT INTO "django_keycloak_openidconnectprofile" VALUES (2,NULL,NULL,NULL,NULL,'f42076e2-4bba-4777-a6f9-8c01d8ec9a86',1,5);
INSERT INTO "django_keycloak_openidconnectprofile" VALUES (3,NULL,NULL,NULL,NULL,'52375ee4-2aa1-46bc-9f90-75c7f1159401',1,6);
INSERT INTO "django_keycloak_openidconnectprofile" VALUES (4,NULL,NULL,NULL,NULL,'4402c76a-4e91-46a5-bafb-6964e3392000',1,7);
INSERT INTO "django_keycloak_openidconnectprofile" VALUES (5,NULL,NULL,NULL,NULL,'9456bf74-b320-4e88-8db4-23a4a1faf42c',1,8);
INSERT INTO "django_keycloak_nonce" VALUES (7,'d00ab22122cf4668a5886a6b5d1eb527','http://127.0.0.1:8000/keycloak/login-complete',NULL);
INSERT INTO "django_keycloak_nonce" VALUES (8,'a536c39c37c34c4da5bd1ace0f37b5ec','http://127.0.0.1:8000/keycloak/login-complete',NULL);
INSERT INTO "django_keycloak_nonce" VALUES (43,'4e05199a55cb4424b474f73077f7ed35','http://127.0.0.1:8000/keycloak/login-complete',NULL);
INSERT INTO "django_keycloak_nonce" VALUES (55,'c1b23e39da7d4ef0b2f2eaf1afa80068','http://127.0.0.1:8000/keycloak/login-complete',NULL);
INSERT INTO "django_keycloak_nonce" VALUES (61,'1e6c262fa45b43e8a6c345f52c1329d8','http://127.0.0.1:8000/keycloak/login-complete',NULL);
INSERT INTO "django_keycloak_nonce" VALUES (86,'8caeafc42b8f4d7b917ecbfdffe43697','http://127.0.0.1:8000/keycloak/login-complete',NULL);
INSERT INTO "django_keycloak_nonce" VALUES (87,'2488fa6f6133449cbbcf7eae9fd41e93','http://127.0.0.1:8000/keycloak/login-complete',NULL);
INSERT INTO "django_keycloak_nonce" VALUES (102,'cc94d61835ea43809dc4ae105b8b3fb4','http://127.0.0.1:8000/keycloak/login-complete',NULL);
INSERT INTO "django_keycloak_nonce" VALUES (109,'c43e520a86a241738d8cf4c4a9822a77','http://127.0.0.1:8000/keycloak/login-complete',NULL);
INSERT INTO "django_keycloak_nonce" VALUES (111,'61dd0b071bef4e1fb2c16647695858dd','http://127.0.0.1:8000/keycloak/login-complete',NULL);
INSERT INTO "django_keycloak_nonce" VALUES (118,'70cae220e31e4cd2aadde1d685804cc0','http://127.0.0.1:8000/keycloak/login-complete',NULL);
INSERT INTO "django_keycloak_nonce" VALUES (129,'63ede7d52d9b4e13bcec06661d91488e','http://127.0.0.1:8000/keycloak/login-complete',NULL);
INSERT INTO "django_keycloak_nonce" VALUES (133,'f51f02fcdaef49ad80ddd7953ef8ee13','http://127.0.0.1:8000/keycloak/login-complete',NULL);
INSERT INTO "django_keycloak_nonce" VALUES (153,'b9b96d6c4ad549ddabf5499da9aeee37','http://127.0.0.1:8000/keycloak/login-complete',NULL);
INSERT INTO "django_keycloak_nonce" VALUES (177,'25e4e853523145099ec7581e2829848b','http://127.0.0.1:8000/keycloak/login-complete',NULL);
INSERT INTO "django_keycloak_nonce" VALUES (207,'f5bc692a243a4b8dabcb0f8998c9a43a','http://127.0.0.1:8000/keycloak/login-complete',NULL);
INSERT INTO "django_keycloak_nonce" VALUES (218,'c01eda6c39a74e178f14c35fb96327ed','http://127.0.0.1:8000/keycloak/login-complete',NULL);
INSERT INTO "django_keycloak_nonce" VALUES (243,'bcdbcd1c38c5443eb45b118f99c11a19','http://127.0.0.1:8000/keycloak/login-complete',NULL);
INSERT INTO "django_keycloak_nonce" VALUES (244,'0dea3179253242719405d312c1604c4a','http://127.0.0.1:8000/keycloak/login-complete',NULL);
INSERT INTO "django_keycloak_nonce" VALUES (245,'eabff9ac5a3746229dd804bf7c25f263','http://127.0.0.1:8000/keycloak/login-complete',NULL);
INSERT INTO "django_keycloak_nonce" VALUES (246,'1e23d2f61ab640d2a0f04da52790240f','http://127.0.0.1:8000/keycloak/login-complete',NULL);
INSERT INTO "django_keycloak_nonce" VALUES (247,'f734f1bf82474e30905b069c6ea3bdfd','http://127.0.0.1:8000/keycloak/login-complete',NULL);
INSERT INTO "django_keycloak_nonce" VALUES (248,'bb9a206e692a40a9aa176e8cd9ef7480','http://127.0.0.1:8000/keycloak/login-complete',NULL);
INSERT INTO "django_keycloak_nonce" VALUES (249,'77e197ab3432449eaa5d1eafedb6f310','http://127.0.0.1:8000/keycloak/login-complete',NULL);
INSERT INTO "django_keycloak_nonce" VALUES (250,'886d198627904c25bd1fda0cf5b42f0e','http://127.0.0.1:8000/keycloak/login-complete',NULL);
INSERT INTO "django_keycloak_nonce" VALUES (251,'22d73aa8679e4def937890487b258c6b','http://127.0.0.1:8000/keycloak/login-complete',NULL);
INSERT INTO "django_keycloak_nonce" VALUES (252,'bc3e48e8f3434ff1acaa8b17d525805e','http://127.0.0.1:8000/keycloak/login-complete',NULL);
INSERT INTO "django_keycloak_nonce" VALUES (254,'5dd6a832a3614aa1ae2c0952045c0510','http://127.0.0.1:8000/keycloak/login-complete',NULL);
INSERT INTO "django_keycloak_nonce" VALUES (258,'097e9efaf5844fd1987c48051b97185b','http://127.0.0.1:8000/keycloak/login-complete',NULL);
INSERT INTO "django_keycloak_nonce" VALUES (260,'fe35c4b30d144def8562c3ae8007bf98','http://127.0.0.1:8000/keycloak/login-complete',NULL);
INSERT INTO "django_keycloak_nonce" VALUES (261,'6a31306bf7c64e79845a2cde4e83f370','http://127.0.0.1:8000/keycloak/login-complete',NULL);
INSERT INTO "django_keycloak_nonce" VALUES (264,'103f5e71ee6b4382963a7878db273130','http://127.0.0.1:8000/keycloak/login-complete',NULL);
INSERT INTO "django_keycloak_nonce" VALUES (267,'f7f631e0484543a9958238b738b86449','http://127.0.0.1:8000/keycloak/login-complete',NULL);
INSERT INTO "django_keycloak_nonce" VALUES (268,'fabb07af3e1f47648bd1f4730a0756ca','http://127.0.0.1:8000/keycloak/login-complete',NULL);
INSERT INTO "django_keycloak_nonce" VALUES (270,'cc862acdd58b46c399a7aefd5e71b641','http://127.0.0.1:8000/keycloak/login-complete',NULL);
INSERT INTO "django_keycloak_nonce" VALUES (271,'476a5a36bf7e47c59f4702a81f0b546d','http://127.0.0.1:8000/keycloak/login-complete',NULL);
INSERT INTO "django_keycloak_nonce" VALUES (277,'de1931ea5b0a4d4288e62a8ec32197dc','http://127.0.0.1:8000/keycloak/login-complete',NULL);
INSERT INTO "django_keycloak_nonce" VALUES (296,'75983798f6434e209f9b5df015f3502b','http://127.0.0.1:8000/keycloak/login-complete',NULL);
INSERT INTO "django_keycloak_client" VALUES (1,'django-allauth','d879df5d-c710-48ca-94b2-38428aff122f',1,NULL);
INSERT INTO "auth_user" VALUES (1,'pbkdf2_sha256$260000$1wTUoJ44JGHI50gjxh2Rbx$Ah8SFqGxwWK+GSD/lqcql6Xri3Bpaum3VOzLq/3I3U0=','2022-11-01 10:42:51.016537',1,'admin','','admin@hua.gr',1,1,'2022-11-01 10:37:50.142963','');
INSERT INTO "auth_user" VALUES (2,'pbkdf2_sha256$260000$Rukn9xkJBZbBQvQaxLYZEM$kgcuMdpG6OPF1vLAYXYhNKAWPXkAksFB9/rXF6SlPX0=','2022-11-01 10:42:33.609702',1,'panos','','panos@hua.gr',1,1,'2022-11-01 10:41:14.132660','');
INSERT INTO "auth_user" VALUES (3,'','2022-11-17 13:38:58.559979',0,'8f929050-717a-4b78-b0e7-928632fa12ed','[soldier, offline_access, uma_authorization]','rey@hua.gr',0,1,'2022-11-01 10:59:20.288566','rey mysterio');
INSERT INTO "auth_user" VALUES (4,'','2022-11-02 11:10:27.317092',0,'reymysterio','mysterio','rey@hua.gr',0,1,'2022-11-01 14:04:18.483385','rey');
INSERT INTO "auth_user" VALUES (5,'','2022-11-17 14:01:26.537951',0,'f42076e2-4bba-4777-a6f9-8c01d8ec9a86','[offline_access, staff, uma_authorization]','joe@hua.gr',0,1,'2022-11-02 13:20:25.032866','john doe');
INSERT INTO "auth_user" VALUES (6,'','2022-11-15 12:17:59.939162',0,'52375ee4-2aa1-46bc-9f90-75c7f1159401','[offline_access, uma_authorization]','admin@hua.gr',0,1,'2022-11-13 12:50:05.807402','admin admin');
INSERT INTO "auth_user" VALUES (7,'','2022-11-15 13:21:21.935393',0,'4402c76a-4e91-46a5-bafb-6964e3392000','[soldier, offline_access, uma_authorization]','giannis@hua.gr',0,1,'2022-11-15 12:22:56.391126','giannis tzaf');
INSERT INTO "auth_user" VALUES (8,'','2022-11-17 14:02:06.778567',0,'9456bf74-b320-4e88-8db4-23a4a1faf42c','[soldier, offline_access, uma_authorization]','mike@hua.gr',0,1,'2022-11-15 18:32:41.070396','mike zampidis');
INSERT INTO "auth_permission" VALUES (1,1,'add_logentry','Can add log entry');
INSERT INTO "auth_permission" VALUES (2,1,'change_logentry','Can change log entry');
INSERT INTO "auth_permission" VALUES (3,1,'delete_logentry','Can delete log entry');
INSERT INTO "auth_permission" VALUES (4,1,'view_logentry','Can view log entry');
INSERT INTO "auth_permission" VALUES (5,2,'add_permission','Can add permission');
INSERT INTO "auth_permission" VALUES (6,2,'change_permission','Can change permission');
INSERT INTO "auth_permission" VALUES (7,2,'delete_permission','Can delete permission');
INSERT INTO "auth_permission" VALUES (8,2,'view_permission','Can view permission');
INSERT INTO "auth_permission" VALUES (9,3,'add_group','Can add group');
INSERT INTO "auth_permission" VALUES (10,3,'change_group','Can change group');
INSERT INTO "auth_permission" VALUES (11,3,'delete_group','Can delete group');
INSERT INTO "auth_permission" VALUES (12,3,'view_group','Can view group');
INSERT INTO "auth_permission" VALUES (13,4,'add_user','Can add user');
INSERT INTO "auth_permission" VALUES (14,4,'change_user','Can change user');
INSERT INTO "auth_permission" VALUES (15,4,'delete_user','Can delete user');
INSERT INTO "auth_permission" VALUES (16,4,'view_user','Can view user');
INSERT INTO "auth_permission" VALUES (17,5,'add_contenttype','Can add content type');
INSERT INTO "auth_permission" VALUES (18,5,'change_contenttype','Can change content type');
INSERT INTO "auth_permission" VALUES (19,5,'delete_contenttype','Can delete content type');
INSERT INTO "auth_permission" VALUES (20,5,'view_contenttype','Can view content type');
INSERT INTO "auth_permission" VALUES (21,6,'add_session','Can add session');
INSERT INTO "auth_permission" VALUES (22,6,'change_session','Can change session');
INSERT INTO "auth_permission" VALUES (23,6,'delete_session','Can delete session');
INSERT INTO "auth_permission" VALUES (24,6,'view_session','Can view session');
INSERT INTO "auth_permission" VALUES (25,7,'add_client','Can add client');
INSERT INTO "auth_permission" VALUES (26,7,'change_client','Can change client');
INSERT INTO "auth_permission" VALUES (27,7,'delete_client','Can delete client');
INSERT INTO "auth_permission" VALUES (28,7,'view_client','Can view client');
INSERT INTO "auth_permission" VALUES (29,8,'add_nonce','Can add nonce');
INSERT INTO "auth_permission" VALUES (30,8,'change_nonce','Can change nonce');
INSERT INTO "auth_permission" VALUES (31,8,'delete_nonce','Can delete nonce');
INSERT INTO "auth_permission" VALUES (32,8,'view_nonce','Can view nonce');
INSERT INTO "auth_permission" VALUES (33,9,'add_openidconnectprofile','Can add open id connect profile');
INSERT INTO "auth_permission" VALUES (34,9,'change_openidconnectprofile','Can change open id connect profile');
INSERT INTO "auth_permission" VALUES (35,9,'delete_openidconnectprofile','Can delete open id connect profile');
INSERT INTO "auth_permission" VALUES (36,9,'view_openidconnectprofile','Can view open id connect profile');
INSERT INTO "auth_permission" VALUES (37,10,'add_realm','Can add realm');
INSERT INTO "auth_permission" VALUES (38,10,'change_realm','Can change realm');
INSERT INTO "auth_permission" VALUES (39,10,'delete_realm','Can delete realm');
INSERT INTO "auth_permission" VALUES (40,10,'view_realm','Can view realm');
INSERT INTO "auth_permission" VALUES (41,11,'add_role','Can add role');
INSERT INTO "auth_permission" VALUES (42,11,'change_role','Can change role');
INSERT INTO "auth_permission" VALUES (43,11,'delete_role','Can delete role');
INSERT INTO "auth_permission" VALUES (44,11,'view_role','Can view role');
INSERT INTO "auth_permission" VALUES (45,12,'add_server','Can add server');
INSERT INTO "auth_permission" VALUES (46,12,'change_server','Can change server');
INSERT INTO "auth_permission" VALUES (47,12,'delete_server','Can delete server');
INSERT INTO "auth_permission" VALUES (48,12,'view_server','Can view server');
INSERT INTO "auth_permission" VALUES (49,13,'add_exchangedtoken','Can add exchanged token');
INSERT INTO "auth_permission" VALUES (50,13,'change_exchangedtoken','Can change exchanged token');
INSERT INTO "auth_permission" VALUES (51,13,'delete_exchangedtoken','Can delete exchanged token');
INSERT INTO "auth_permission" VALUES (52,13,'view_exchangedtoken','Can view exchanged token');
INSERT INTO "auth_permission" VALUES (53,14,'add_remoteclient','Can add remote client');
INSERT INTO "auth_permission" VALUES (54,14,'change_remoteclient','Can change remote client');
INSERT INTO "auth_permission" VALUES (55,14,'delete_remoteclient','Can delete remote client');
INSERT INTO "auth_permission" VALUES (56,14,'view_remoteclient','Can view remote client');
INSERT INTO "auth_permission" VALUES (57,15,'add_aithsh','Can add aithsh');
INSERT INTO "auth_permission" VALUES (58,15,'change_aithsh','Can change aithsh');
INSERT INTO "auth_permission" VALUES (59,15,'delete_aithsh','Can delete aithsh');
INSERT INTO "auth_permission" VALUES (60,15,'view_aithsh','Can view aithsh');
INSERT INTO "auth_permission" VALUES (61,16,'add_diakoph','Can add diakoph');
INSERT INTO "auth_permission" VALUES (62,16,'change_diakoph','Can change diakoph');
INSERT INTO "auth_permission" VALUES (63,16,'delete_diakoph','Can delete diakoph');
INSERT INTO "auth_permission" VALUES (64,16,'view_diakoph','Can view diakoph');
INSERT INTO "auth_permission" VALUES (65,17,'add_apografh','Can add apografh');
INSERT INTO "auth_permission" VALUES (66,17,'change_apografh','Can change apografh');
INSERT INTO "auth_permission" VALUES (67,17,'delete_apografh','Can delete apografh');
INSERT INTO "auth_permission" VALUES (68,17,'view_apografh','Can view apografh');
INSERT INTO "auth_permission" VALUES (69,18,'add_sxolh','Can add sxolh');
INSERT INTO "auth_permission" VALUES (70,18,'change_sxolh','Can change sxolh');
INSERT INTO "auth_permission" VALUES (71,18,'delete_sxolh','Can delete sxolh');
INSERT INTO "auth_permission" VALUES (72,18,'view_sxolh','Can view sxolh');
INSERT INTO "auth_permission" VALUES (73,19,'add_myroles','Can add my roles');
INSERT INTO "auth_permission" VALUES (74,19,'change_myroles','Can change my roles');
INSERT INTO "auth_permission" VALUES (75,19,'delete_myroles','Can delete my roles');
INSERT INTO "auth_permission" VALUES (76,19,'view_myroles','Can view my roles');
INSERT INTO "django_content_type" VALUES (1,'admin','logentry');
INSERT INTO "django_content_type" VALUES (2,'auth','permission');
INSERT INTO "django_content_type" VALUES (3,'auth','group');
INSERT INTO "django_content_type" VALUES (4,'auth','user');
INSERT INTO "django_content_type" VALUES (5,'contenttypes','contenttype');
INSERT INTO "django_content_type" VALUES (6,'sessions','session');
INSERT INTO "django_content_type" VALUES (7,'django_keycloak','client');
INSERT INTO "django_content_type" VALUES (8,'django_keycloak','nonce');
INSERT INTO "django_content_type" VALUES (9,'django_keycloak','openidconnectprofile');
INSERT INTO "django_content_type" VALUES (10,'django_keycloak','realm');
INSERT INTO "django_content_type" VALUES (11,'django_keycloak','role');
INSERT INTO "django_content_type" VALUES (12,'django_keycloak','server');
INSERT INTO "django_content_type" VALUES (13,'django_keycloak','exchangedtoken');
INSERT INTO "django_content_type" VALUES (14,'django_keycloak','remoteclient');
INSERT INTO "django_content_type" VALUES (15,'demo','aithsh');
INSERT INTO "django_content_type" VALUES (16,'demo','diakoph');
INSERT INTO "django_content_type" VALUES (17,'demo','apografh');
INSERT INTO "django_content_type" VALUES (18,'demo','sxolh');
INSERT INTO "django_content_type" VALUES (19,'demo','myroles');
INSERT INTO "django_admin_log" VALUES (1,'2022-11-01 10:43:48.333984','1','http://localhost:8080/auth','[{"added": {}}]',12,1,1);
INSERT INTO "django_admin_log" VALUES (2,'2022-11-01 10:45:47.529947','1','demo','[{"added": {}}, {"added": {"name": "client", "object": "django-allauth"}}]',10,1,1);
INSERT INTO "django_migrations" VALUES (1,'contenttypes','0001_initial','2022-11-01 10:37:25.346386');
INSERT INTO "django_migrations" VALUES (2,'auth','0001_initial','2022-11-01 10:37:25.608634');
INSERT INTO "django_migrations" VALUES (3,'admin','0001_initial','2022-11-01 10:37:25.851886');
INSERT INTO "django_migrations" VALUES (4,'admin','0002_logentry_remove_auto_add','2022-11-01 10:37:25.938162');
INSERT INTO "django_migrations" VALUES (5,'admin','0003_logentry_add_action_flag_choices','2022-11-01 10:37:26.067783');
INSERT INTO "django_migrations" VALUES (6,'contenttypes','0002_remove_content_type_name','2022-11-01 10:37:26.253150');
INSERT INTO "django_migrations" VALUES (7,'auth','0002_alter_permission_name_max_length','2022-11-01 10:37:26.398328');
INSERT INTO "django_migrations" VALUES (8,'auth','0003_alter_user_email_max_length','2022-11-01 10:37:26.501655');
INSERT INTO "django_migrations" VALUES (9,'auth','0004_alter_user_username_opts','2022-11-01 10:37:26.654563');
INSERT INTO "django_migrations" VALUES (10,'auth','0005_alter_user_last_login_null','2022-11-01 10:37:26.741436');
INSERT INTO "django_migrations" VALUES (11,'auth','0006_require_contenttypes_0002','2022-11-01 10:37:26.831579');
INSERT INTO "django_migrations" VALUES (12,'auth','0007_alter_validators_add_error_messages','2022-11-01 10:37:26.925827');
INSERT INTO "django_migrations" VALUES (13,'auth','0008_alter_user_username_max_length','2022-11-01 10:37:27.002090');
INSERT INTO "django_migrations" VALUES (14,'auth','0009_alter_user_last_name_max_length','2022-11-01 10:37:27.107313');
INSERT INTO "django_migrations" VALUES (15,'auth','0010_alter_group_name_max_length','2022-11-01 10:37:27.251803');
INSERT INTO "django_migrations" VALUES (16,'auth','0011_update_proxy_permissions','2022-11-01 10:37:27.378162');
INSERT INTO "django_migrations" VALUES (17,'auth','0012_alter_user_first_name_max_length','2022-11-01 10:37:27.482007');
INSERT INTO "django_migrations" VALUES (18,'django_keycloak','0001_initial','2022-11-01 10:37:27.704107');
INSERT INTO "django_migrations" VALUES (19,'django_keycloak','0002_auto_20180322_2059','2022-11-01 10:37:27.880218');
INSERT INTO "django_migrations" VALUES (20,'django_keycloak','0003_auto_20190204_1949','2022-11-01 10:37:28.046156');
INSERT INTO "django_migrations" VALUES (21,'django_keycloak','0004_client_service_account_profile','2022-11-01 10:37:28.167572');
INSERT INTO "django_migrations" VALUES (22,'django_keycloak','0005_auto_20190219_2002','2022-11-01 10:37:28.315957');
INSERT INTO "django_migrations" VALUES (23,'django_keycloak','0006_remove_client_service_account','2022-11-01 10:37:28.446105');
INSERT INTO "django_migrations" VALUES (24,'django_keycloak','0007_auto_20221101_1037','2022-11-01 10:37:28.810372');
INSERT INTO "django_migrations" VALUES (25,'sessions','0001_initial','2022-11-01 10:37:28.989984');
INSERT INTO "django_migrations" VALUES (26,'demo','0001_initial','2022-11-05 12:46:23.838171');
INSERT INTO "django_migrations" VALUES (27,'demo','0002_remove_aithsh_formfile','2022-11-05 15:41:42.540842');
INSERT INTO "django_migrations" VALUES (28,'demo','0003_aithsh_age','2022-11-05 16:16:19.698905');
INSERT INTO "django_migrations" VALUES (29,'demo','0004_auto_20221106_1326','2022-11-06 13:26:50.950175');
INSERT INTO "django_migrations" VALUES (30,'demo','0005_diakoph_formfile','2022-11-06 13:35:10.140793');
INSERT INTO "django_migrations" VALUES (31,'demo','0006_apografh','2022-11-07 13:31:00.706812');
INSERT INTO "django_migrations" VALUES (32,'demo','0007_auto_20221110_1058','2022-11-10 10:59:03.181823');
INSERT INTO "django_migrations" VALUES (33,'demo','0008_apografh_status','2022-11-12 16:35:21.044987');
INSERT INTO "django_migrations" VALUES (34,'demo','0009_myroles','2022-11-13 15:33:13.970231');
CREATE INDEX IF NOT EXISTS "django_session_expire_date_a5c62663" ON "django_session" (
	"expire_date"
);
CREATE INDEX IF NOT EXISTS "django_keycloak_role_permission_id_265dc2fb" ON "django_keycloak_role" (
	"permission_id"
);
CREATE INDEX IF NOT EXISTS "django_keycloak_role_client_id_d95839c6" ON "django_keycloak_role" (
	"client_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "django_keycloak_role_client_id_permission_id_6fc6c80b_uniq" ON "django_keycloak_role" (
	"client_id",
	"permission_id"
);
CREATE INDEX IF NOT EXISTS "django_keycloak_remoteclient_realm_id_3d7c9881" ON "django_keycloak_remoteclient" (
	"realm_id"
);
CREATE INDEX IF NOT EXISTS "django_keycloak_realm_server_id_1896da4d" ON "django_keycloak_realm" (
	"server_id"
);
CREATE INDEX IF NOT EXISTS "django_keycloak_openidconnectprofile_realm_id_ceca7619" ON "django_keycloak_openidconnectprofile" (
	"realm_id"
);
CREATE INDEX IF NOT EXISTS "django_keycloak_exchangedtoken_remote_client_id_23520768" ON "django_keycloak_exchangedtoken" (
	"remote_client_id"
);
CREATE INDEX IF NOT EXISTS "django_keycloak_exchangedtoken_oidc_profile_id_c7304a6f" ON "django_keycloak_exchangedtoken" (
	"oidc_profile_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "django_keycloak_exchangedtoken_oidc_profile_id_remote_client_id_129963f3_uniq" ON "django_keycloak_exchangedtoken" (
	"oidc_profile_id",
	"remote_client_id"
);
CREATE INDEX IF NOT EXISTS "auth_permission_content_type_id_2f476e4b" ON "auth_permission" (
	"content_type_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "auth_permission_content_type_id_codename_01ab375a_uniq" ON "auth_permission" (
	"content_type_id",
	"codename"
);
CREATE UNIQUE INDEX IF NOT EXISTS "django_content_type_app_label_model_76bd3d3b_uniq" ON "django_content_type" (
	"app_label",
	"model"
);
CREATE INDEX IF NOT EXISTS "django_admin_log_user_id_c564eba6" ON "django_admin_log" (
	"user_id"
);
CREATE INDEX IF NOT EXISTS "django_admin_log_content_type_id_c4bce8eb" ON "django_admin_log" (
	"content_type_id"
);
CREATE INDEX IF NOT EXISTS "auth_user_user_permissions_permission_id_1fbb5f2c" ON "auth_user_user_permissions" (
	"permission_id"
);
CREATE INDEX IF NOT EXISTS "auth_user_user_permissions_user_id_a95ead1b" ON "auth_user_user_permissions" (
	"user_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "auth_user_user_permissions_user_id_permission_id_14a6b632_uniq" ON "auth_user_user_permissions" (
	"user_id",
	"permission_id"
);
CREATE INDEX IF NOT EXISTS "auth_user_groups_group_id_97559544" ON "auth_user_groups" (
	"group_id"
);
CREATE INDEX IF NOT EXISTS "auth_user_groups_user_id_6a12ed8b" ON "auth_user_groups" (
	"user_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "auth_user_groups_user_id_group_id_94350c0c_uniq" ON "auth_user_groups" (
	"user_id",
	"group_id"
);
CREATE INDEX IF NOT EXISTS "auth_group_permissions_permission_id_84c5c92e" ON "auth_group_permissions" (
	"permission_id"
);
CREATE INDEX IF NOT EXISTS "auth_group_permissions_group_id_b120cbf9" ON "auth_group_permissions" (
	"group_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "auth_group_permissions_group_id_permission_id_0cd325b0_uniq" ON "auth_group_permissions" (
	"group_id",
	"permission_id"
);
COMMIT;
