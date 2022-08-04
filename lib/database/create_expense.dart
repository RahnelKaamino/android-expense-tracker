final String createExpense = """
CREATE TABLE "expenses" (
	"id"	INTEGER,
	"groupMemberId"	INTEGER NOT NULL,
	"name"	TEXT DEFAULT 'Expense name',
	"expense"	INTEGER DEFAULT 100,
	FOREIGN KEY("groupMemberId") REFERENCES "group_members"("id"),
	PRIMARY KEY("id" AUTOINCREMENT)
);
""";
