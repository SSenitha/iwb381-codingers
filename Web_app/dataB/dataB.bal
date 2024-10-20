
import ballerina/io;
import ballerinax/mongodb;


type Letter record {
    string title;
    string sender;
    int state;
};

public function main() returns error? {
    // # URI Structure: mongodb+srv:// <UserName> : <Password> @cluster0.8gwtw.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0
    string uri = "mongodb+srv://appClient:CWF3ElDbKjBUUnMJ@cluster0.8gwtw.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0";

    mongodb:Client mongoDb = check new ({
        connection: uri
    });


    //----------------------_Cluster_Operations_------------------------
    string[] databases = check mongoDb->listDatabaseNames();

    // Print the databases
    io:println("Databases in the MongoDB server:");
    foreach var db in databases {
        io:println(db);
    }

    //----------------------_Database_Operations_------------------------
    // Get the Letter_app database
    mongodb:Database LetterDb = check mongoDb->getDatabase("Letter_app");
    //moviesDb = check mongoDb->getDatabase("Letter_app");
    string[] collections = check LetterDb->listCollectionNames();

    // Print the collections
    io:println("Collections in the MongoDB server:");
    foreach var col in collections {
        io:println(col);
    }


    //mongodb:Collection moviesCollection = check moviesDb->getCollection("letters");
}



// public function addLetter() returns string{
//     mongodb:Collection moviesCollection = check LetterDb->getCollection("letters");
//     Letter newLetter = {title:"Logo permission request", sender:"foc", state:1};

//     return "hello";
// }
