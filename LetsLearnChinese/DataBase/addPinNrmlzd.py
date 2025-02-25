import sqlite3
import unicodedata

def normalize_pinyin():
    # Connect to the SQLite database
    conn = sqlite3.connect('llcdb.sqlite')
    cursor = conn.cursor()

    # Check if the pinyin_normalized column exists, and add it if not
    try:
        cursor.execute("""
        ALTER TABLE characters ADD COLUMN pinyin_normalized TEXT
        """)
        conn.commit()
    except sqlite3.OperationalError:
        # Column already exists
        pass

    # Fetch all rows from the characters table
    cursor.execute("SELECT id, pinyin FROM characters")
    rows = cursor.fetchall()

    # Iterate over rows to normalize pinyin and update the database
    for row in rows:
        char_id, pinyin = row
        if pinyin:  # Check if pinyin is not None
            normalized_pinyin = remove_accents(pinyin)
            cursor.execute(
                "UPDATE characters SET pinyin_normalized = ? WHERE id = ?",
                (normalized_pinyin, char_id)
            )

    # Commit the changes and close the connection
    conn.commit()
    conn.close()


def remove_accents(text):
    """Remove accents from the input text."""
    return ''.join(
        char for char in unicodedata.normalize('NFD', text)
        if unicodedata.category(char) != 'Mn'
    )


if __name__ == "__main__":
    normalize_pinyin()
