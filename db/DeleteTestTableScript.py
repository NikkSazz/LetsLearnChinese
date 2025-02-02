import sqlite3

dbfile = "llcdb.sqlite"
connection = sqlite3.connect(dbfile)
cursor = connection.cursor()

# Name of the table to delete
table_name = "CharacterTest"  # Change this to the table you want to delete

# Delete the table
try:
    cursor.execute(f"DROP TABLE IF EXISTS {table_name}")
    print(f"Table '{table_name}' deleted successfully.")
except sqlite3.Error as e:
    print(f"An error occurred: {e}")

# Commit changes and close the connection
connection.commit()
connection.close()
