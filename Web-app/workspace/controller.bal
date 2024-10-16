import ballerina/io;
import ballerina/http;

public function main() returns error?{
    //io:println("Hello, World!");
    //http:ClientConfig clientConfig = {};
    http:Client cl = check new ("localhost:8080");
    var response = cl->get("/greeting", targetType=string);
    
    //io:println("Response: " + response);
    io:println(response);
}