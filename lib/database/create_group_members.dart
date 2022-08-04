final String createGroupMembers = """
CREATE TABLE "group_members" (
	"id"	INTEGER,
	"groupId"	INTEGER NOT NULL,
	"memberId"	INTEGER NOT NULL,
	FOREIGN KEY("memberId") REFERENCES "members"("id"),
	FOREIGN KEY("groupId") REFERENCES "groups"("id"),
	PRIMARY KEY("id" AUTOINCREMENT)
);
""";
