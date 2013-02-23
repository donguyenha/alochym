from pysqlite2 import dbapi2 as sqlite3
conn = sqlite3.connect('/home/ha/googleAPI/sqlite.db')
cursor = conn.cursor()
cursor.execute('create table ISBN(isbn_10 text, twitter text, twitter_flag int, facebook int, google_plus int)')
conn.commit()
isbn = '12345678901'
sql = 'insert into ISBN values(' + isbn + ',"", 0, 0, 0)'
cursor.execute(sql)
conn.commit()
cursor.execute("""update ISBN set facebook=1 where isbn_10='1234567890'""")
conn.commit()
select = cursor.execute('select * from ISBN where facebook=0')
for val in select:
    print val[0], val[1], val[2], val[3], val[4]
