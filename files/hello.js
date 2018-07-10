var http = require('http');
 
http.createServer(function (req, res) {
    console.log('A new request arrived with HTTP headers: ' + JSON.stringify(req.headers));
 
var Connection = require('tedious').Connection;
var Request = require('tedious').Request;
 
// Create connection to database
var config = 
   {
     userName: 'Azure', // update me
     password: 'P@ssw0rd1234', // update me
     server: 'CHANGEME.database.windows.net', // update me
     options: 
        {
           database: 'mySampleDatabase' //update me
           , encrypt: true
        }
   }
var connection = new Connection(config);
 
// Attempt to connect and execute queries if connection goes through
connection.on('connect', function(err) 
   {
     if (err) 
       {
          console.log(err);
  res.writeHead(200, { 'Content-Type': 'text/html' });
          res.end('Access Denied - SQL DB Service Endpoint is disabled on this VNET! <p>Check the latest <a href="iisnode">logs</a>');
       }
    else
       {
           queryDatabase();
   res.writeHead(200, { 'Content-Type': 'text/html' });
           res.end('Hello, SQL DB Service Endpoint is enabled on this VNET! <p>Check the latest <a href="iisnode">logs</a>')
       }
   }
);
 
 
function queryDatabase()
   { console.log('Reading rows from the Table...');
 
       // Read all rows from table
     request = new Request(
          "SELECT TOP 20 pc.Name as CategoryName, p.name as ProductName FROM [SalesLT].[ProductCategory] pc JOIN [SalesLT].[Product] p ON pc.productcategoryid = p.productcategoryid",
             function(err, rowCount, rows) 
                {
                    console.log(rowCount + ' row(s) returned');
                    process.exit();
                }
            );
 
     request.on('row', function(columns) {
        columns.forEach(function(column) {
            console.log("%s\t%s", column.metadata.colName, column.value);
         });
             });
     connection.execSql(request);
   }
 
}).listen(process.env.PORT);
 
console.log('Application has started at location ' + process.env.PORT);
