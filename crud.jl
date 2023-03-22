using SQLite
using DataFrames

# Create the table
db = SQLite.DB("sample.sqlite")
SQLite.execute(db, "CREATE TABLE IF NOT EXISTS animes (id INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT NOT NULL, genre TEXT NOT NULL)")

function showList()
    println("Here is your favorite anime list: ")
    data = DBInterface.execute(db, "SELECT * FROM animes") |> DataFrame
    println(data)
end

# Insert to the table
function insertList()
    println("Please enter the tuitle of the anime: ")
    title = readline()
    println("Please enter the genre of the anime: ")
    genre = readline()
    SQLite.execute(db, "INSERT INTO animes (title, genre) VALUES ('$title', '$genre')")
    println("Your database has been updated succesfully.")
end

# Delete from the table
function deleteFromList()
    println("Which anime would you like to delete? (ID)")
    id = parse(Int, readline())
    row = DBInterface.execute(db, "SELECT * FROM animes WHERE id = $id") |> DataFrame
    SQLite.execute(db, "DELETE FROM animes WHERE id = $id")
    println("You have succesfully deleted the following anime from the DB")
    println(row)
end

quit = false
while !quit
    println("""
            Favorite anime list DB
            
            Option1: See the list.
            Option2: Add entry to the list.
            Option3: Remove entry from the list.
            Option4: quit
            """)

    option = parse(Int, readline())

    option == 1 && showList()
    option == 2 && insertList()
    option == 3 && deleteFromList()
    option == 4 && (global quit = true)
end

SQLite.close(db)
