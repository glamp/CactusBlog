from pymongo import Connection


conn = Connection(host='localhost', port=27017)
db = conn['dbname']
db.authenticate('username', 'password')