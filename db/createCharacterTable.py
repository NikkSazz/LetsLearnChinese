import sqlite3
import csv

csv_file = "/Users/dmitrysazonov/Desktop/Characters.csv"
dbfile = "llcdb.sqlite"
connection = sqlite3.connect(dbfile)

tableName = "Characters"
cursor = connection.cursor()
cursor.execute(f"""
CREATE TABLE IF NOT EXISTS {tableName} (
    id INTEGER PRIMARY KEY,
    chinese TEXT,
    english TEXT,
    pinyin TEXT,
    unit_id INTEGER,
    type TEXT
)
""")

with open(csv_file, encoding="utf-8") as file:
    reader = csv.DictReader(file)
    for row in reader:
        cursor.execute(f"""
        INSERT INTO {tableName} (id, chinese, english, pinyin, unit_id, type)
        VALUES (?, ?, ?, ?, ?, ?)
        """, (row["id"], row["chinese"], row["english"], row["pinyin"], row["unit_id"], row["type"]))

connection.commit()

connection.close()

print(f"Data successfully imported into the {tableName} table!")
