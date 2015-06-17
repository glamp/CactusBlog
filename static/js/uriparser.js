parseMongoURI = function(uri) {
  var DEFAULT_MONGO_URI = 'mongodb://localhost:27017/default';
  // Match the uri format
  var uriRE = new RegExp('^mongo(?:db)?://(?:|([^@/]*)@)([^@/]*)(?:|/([^?]*)(?:|\\?([^?]*)))$');

  var match = uriRE.exec(uri)

  var auth = match[1]
  var host = match[2]
  var db   = match[3]

  var mongoOpts = {}

  var mongoCommand = "mongo"
  if (auth!=undefined) {
    mongoCommand += " --username " + auth.split(':')[0]
    mongoOpts.username = auth.split(':')[0]
    if (auth.split(':').length > 1) {
      mongoCommand += " --password " + auth.split(':')[1]
    mongoOpts.password = auth.split(':')[1]
    }
  }
  if (host!=undefined) {
    mongoCommand += " --host " + host.split(':')[0]
    mongoOpts.host = host.split(':')[0]
    mongoCommand += " --port " + host.split(':')[1] || "27017"
    mongoOpts.port = host.split(':')[1] || "27017"
  }
  if (db!=undefined) {
    mongoCommand += " " + db
    mongoOpts.db = db
  }

  return mongoOpts
}

parseRedisURI = function(uri) {
  var uriRE = new RegExp('^redis://(?:|([^@/]*)@)([^@/]*)(?:|/([^?]*)(?:|\\?([^?]*)))$');
  var match = uriRE.exec(uri)

  var auth = match[1]
  var host = match[2]
  var db   = match[3]

  var redisOpts = {}
  
  var redisCommand = "redis-cli"
  if (auth!=undefined) {
    if (auth.split(':').length > 1) {
      // redisCommand += " -a " + auth.split(':')[1]
      redisOpts.password = auth.split(':')[1]
    }
  }
  if (host!= undefined) {
    // redisCommand += " -h " + host.split(':')[0]
    redisOpts.host = host.split(':')[0]
    // redisCommand += " -p " + host.split(':')[1] || "6379"
    redisOpts.port = host.split(':')[1]
  }

  if (db!=undefined) {
    // redisCommand += " " + db
    redisOpts.db = db
  }
  return redisOpts
}

parsePostgresURI = function(uri) {
  var uriRE = new RegExp('^postgres(?:ql)?://(?:|([^@/]*)@)([^@/]*)(?:|/([^?]*)(?:|\\?([^?]*)))$');
  var match = uriRE.exec(uri)

  var auth = match[1]
  var host = match[2]
  var db   = match[3]

  var pgOpts = {}

  var pgCommand = "psql"
  if (auth!=undefined) {
    pgCommand += " --username " + auth.split(':')[0]
    pgOpts.username = auth.split(':')[0]
    if (auth.split(':').length > 1) {
      // pgCommand += " --password " + auth.split(':')[1]
      pgOpts.password = auth.split(':')[1]
    }
  }

  if (host!= undefined) {
    pgCommand += " --host " + host.split(':')[0]
    pgOpts.host = host.split(':')[0]
    pgCommand += " --port " + host.split(':')[1] || "5432"
    pgOpts.port = host.split(':')[1] || "5432"
  }

  if (db!=undefined) {
    pgCommand += " --dbname " + db
    pgOpts.db = db
  }

  return pgOpts
}

parseMySqlURI = function(uri) {
  var uriRE = new RegExp('^mysql://(?:|([^@/]*)@)([^@/]*)(?:|/([^?]*)(?:|\\?([^?]*)))$');
  var uriRE = new RegExp('^mysql://([^@/]*)(?:|/([^?]*)(?:|\\?([^?]*)))[?]user=(.+?)&password=(.+?)$');
  var match = uriRE.exec(uri)
  var username = match[4]
  var password = match[5]

  var host = match[1]
  var db   = match[2]

  var mysqlOpts = {}
  if (host!=undefined) {
    var host = host.split(':')
    mysqlOpts.host = host[0]
    if (host.length > 1) {
      mysqlOpts.port = host[1]          
    }
  }

  mysqlOpts.db = db;
  if (db!=undefined) {
    mysqlOpts.db = db;    
  }

  if (username!=undefined) {
    mysqlOpts.username = username    
  }
  if (password!=undefined) {
    mysqlOpts.password = password
  }

  return mysqlOpts
}

generateCommand = function(commandOpts, cmd, parsedURI) {
  Object.keys(commandOpts).forEach(function(key) {
    if (parsedURI[key]!=undefined) {
      cmd += " " + commandOpts[key] + " " + parsedURI[key]
    }
  })
  return cmd
}

parseURI = function(uri) {
  console.log(uri)
  if (/^mongo/.exec(uri)) {
    return generateCommand(mongoCmd, "mongo", parseMongoURI(uri))
  } else if (/^redis/.exec(uri)) {
    return generateCommand(redisCmd, "redis-cli", parseRedisURI(uri))
  } else if (/^mysql/.exec(uri)) {
    return generateCommand(mysqlCmd, "mysql", parseMySqlURI(uri))
  } else if (/^postgres/.exec(uri)) {
    return generateCommand(pgCmd, "psql", parsePostgresURI(uri))
  }
}

var mysqlCmd = {
  host: "-h",
  port: "-p",
  username: "--username",
  password: "--password",
  db: ""
}
var mysqlExample = "mysql://localhost:3306/HerongDB?user=Herong&password=TopSecret";

var mongoCmd = {
  username: "--username",
  password: "--password",
  host: "--host",
  port: "--port",
  db: ""
}
var mongoExample = "mongodb://glamp123:password1234@alex.mongohq.com:10013/sklearn";

var redisCmd = {
  host: "-h",
  port: "-p",
  password: "-a"
}
var redisExample = "redis://:iOnwbu9u@node-fe03b4d4d9564505a.openredis.com:10701"

var pgCmd = {
  username: "--username",
  host: "--host",
  port: "--port",
  db: "--dbname"
}
var postgresExample = "postgres://joesmith:yellow@heroku.com:5432/d8rec65uraj0qv"


