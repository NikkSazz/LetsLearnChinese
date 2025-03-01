import sqlite3
import csv

csv_file = "/Users/dmitrysazonov/Desktop/Units.csv"
dbfile = "llcdb.sqlite"
connection = sqlite3.connect(dbfile)

tableName = "Units"
cursor = connection.cursor()
cursor.execute(f"""
CREATE TABLE IF NOT EXISTS {tableName} (
    id INTEGER PRIMARY KEY,
    chinese TEXT,
    english TEXT,
    pinyin TEXT,
    level_id INTEGER,
    level_part INTEGER
)
""")

with open(csv_file, encoding="utf-8") as file:
    reader = csv.DictReader(file)
    for row in reader:
        cursor.execute(f"""
        INSERT OR IGNORE INTO {tableName} (id, chinese, english, pinyin, level_id, level_part)
        VALUES (?, ?, ?, ?, ?, ?)
        """, (row["id"], row["Chinese"], row["English"], row["Pinyin"], row["level_id"], row["level_part"]))

connection.commit()

connection.close()

print(f"Data successfully imported into the {tableName} table!, file {dbfile}")
