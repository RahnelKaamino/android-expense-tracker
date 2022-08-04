final String createMembers = """
CREATE TABLE "members" (
	"id"	INTEGER,
	"name"	TEXT DEFAULT 'Member',
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE "group_members" (
	"id"	INTEGER,
	"groupId"	INTEGER NOT NULL,
	"memberId"	INTEGER NOT NULL,
	FOREIGN KEY("memberId") REFERENCES "members"("id"),
	FOREIGN KEY("groupId") REFERENCES "groups"("id"),
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE "expenses" (
	"id"	INTEGER,
	"groupMemberId"	INTEGER NOT NULL,
	"expense"	INTEGER DEFAULT 100,
	FOREIGN KEY("groupMemberId") REFERENCES "group_members"("id"),
	PRIMARY KEY("id" AUTOINCREMENT)
);
""";
