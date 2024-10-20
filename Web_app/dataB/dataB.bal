import ballerina/io;
import ballerinax/mongodb;

public function main() returns error? {
    // # URI Structure: mongodb+srv:// <UserName> : <Password> @cluster0.8gwtw.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0
    string uri = "mongodb+srv://appClient:CWF3ElDbKjBUUnMJ@cluster0.8gwtw.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0";

    mongodb:Client mongoDb = check new ({
        connection: uri
    });

    string[] databases = check mongoDb->listDatabaseNames();

    // Print the databases
    io:println("Databases in the MongoDB server:");
    foreach var db in databases {
        io:println(db);
    }
}


public function connect() returns string{
    return "hello";
}