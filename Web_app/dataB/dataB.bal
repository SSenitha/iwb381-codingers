
import ballerina/io;
import ballerinax/mongodb;
//import ballerina/openapi;


type Letter record {
    string title;
    string sender;
    int state;
};

type returnLetter record {
    string _id;
    string title;
    string sender;
    int state;
};


// # URI Structure: mongodb+srv:// <UserName> : <Password> @cluster0.8gwtw.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0
string uri = "mongodb+srv://appClient:CWF3ElDbKjBUUnMJ@cluster0.8gwtw.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0";

mongodb:Client mongoDb = check new ({
    connection: uri
});

public function main() returns error? {
    // //----------------------_Cluster_Operations_------------------------
    // string[] databases = check mongoDb->listDatabaseNames();

    // // Print the databases
    // io:println("Databases in the MongoDB server:");
    // foreach var db in databases {
    //     io:println(db);
    // }

    // // Get the Letter_app database
    // mongodb:Database LetterDb = check mongoDb->getDatabase("Letter_app");

    // //----------------------_Database_Operations_------------------------
    // //moviesDb = check mongoDb->getDatabase("Letter_app");
    // string[] collections = check LetterDb->listCollectionNames();

    // // Print the collections
    // io:println("Collections in the MongoDB server:");
    // foreach var col in collections {
    //     io:println(col);
    // }


    //---------------------_Add_Record_---------------------
    //io:println(addLetter("About student IDs","FHSS"));


    //---------------------_Get_Record_---------------------
    string ID = check getLetter(null,"FHSS");
    // if ID is "400"{
    //     io:println("ERROR: Empty query");
    // }else if (ID is "404"){
    //     io:println("ERROR: No document found");
    // }else{
    //     io:println(ID);
    // }


    //---------------------_Update_Record_---------------------
    string|error updateMsg = updateLetter(ID,"FOC");
    io:println(updateMsg);
}



public function addLetter(string title, string sender) returns string|error{

    //connect to the collection
    mongodb:Database LetterDb = check mongoDb->getDatabase("Letter_app");
    mongodb:Collection LetterCollection = check LetterDb->getCollection("letters");

    //Set letter record and insert to the collection
    Letter newLetter = {title:title, sender:sender, state:1};
    check LetterCollection->insertOne(newLetter);

    return title + " by " + sender + " added to the database";
}

public function getLetter(string? title, string? sender) returns string|error{

    //connect to the collection
    mongodb:Database LetterDb = check mongoDb->getDatabase("Letter_app");
    mongodb:Collection LetterCollection = check LetterDb->getCollection("letters");

    //Set letter record and insert to the collection
    returnLetter? queryLetter;
    string ID;

    if (title is string && sender is string){
        queryLetter = check LetterCollection->findOne({
            title: title,
            sender: sender
        },findOptions = {});
    }else if (title is string) {
        queryLetter = check LetterCollection->findOne({
            title: title
        }, findOptions = {});
    }else if (sender is string) {
        queryLetter = check LetterCollection->findOne({
            sender: sender
        }, findOptions = {});
    }else{
        return "400";
    }

    if (queryLetter is returnLetter){
        ID = queryLetter._id.toString();
        return ID;
    }

    return  "404";
}

public function getState(string id) returns string|error{
    string rMsg = "ERROR";

    //connect to the collection
    mongodb:Database LetterDb = check mongoDb->getDatabase("Letter_app");
    mongodb:Collection LetterCollection = check LetterDb->getCollection("letters");

    
    returnLetter? queryLetter = check LetterCollection->findOne(
        {_id: id},
        findOptions = {}
    );

   if (queryLetter is returnLetter){
        rMsg = "Document with ID: " + queryLetter._id.toString();
        if (queryLetter.state is 0){
            rMsg += " is ready to collect";
        }else{
            rMsg += " is still processing";
        }
    }

    return rMsg;
}

public function updateLetter(string id, string sender) returns string|error{

    //connect to the collection
    mongodb:Database LetterDb = check mongoDb->getDatabase("Letter_app");
    mongodb:Collection LetterCollection = check LetterDb->getCollection("letters");

    //Set letter record and insert to the collection
    var result = check LetterCollection->updateOne({_id:id}, {"set":{sender:sender}});

    if (result is mongodb:UpdateResult) {
        if (result.matchedCount > 0) {
            return "Update successful. Modified " + result.modifiedCount.toString() + " document(s).";
        } else {
            return "No documents matched the query.";
        }
    } else {
        // If an error occurs, return the error
    }
}

public function updateState(string id) returns string|error{

    //connect to the collection
    mongodb:Database LetterDb = check mongoDb->getDatabase("Letter_app");
    mongodb:Collection LetterCollection = check LetterDb->getCollection("letters");

    //Set letter record and insert to the collection
    var result = check LetterCollection->updateOne({_id:id}, {"set":{state:0}});

    if (result is mongodb:UpdateResult) {
        if (result.matchedCount > 0) {
            return "SUCCESS: " + result.modifiedCount.toString() + " document set as dispatched.";
        } else {
            return "No documents matched the query.";
        }
    } else {
        // If an error occurs, return the error
    }
}