import ballerinax/mongodb;


string username = "fc110548";
string password = "215/5Kesbewa";
string uri = "mongodb+srv://"+ username +":"+ password +"@cluster0.8gwtw.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0";

mongodb:Client mongoDb = check new ({
    connection: uri
});

public function connect() returns string{
    return "hello";
}