final String createTrip = """
CREATE TABLE "trips" (
	"id"	INTEGER,
	"groupID"	INTEGER NOT NULL,
	"name"	TEXT DEFAULT 'Trip',
	"status"	TEXT DEFAULT 'IN PROGRESS',
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("groupID") REFERENCES "groups"("id")
);
""";
