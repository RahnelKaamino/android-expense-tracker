final String createDb = """
CREATE TABLE "groups" (
	"id"	INTEGER,
	"groupSize"	INTEGER NOT NULL DEFAULT 1,
	PRIMARY KEY("id" AUTOINCREMENT)
);
""";
