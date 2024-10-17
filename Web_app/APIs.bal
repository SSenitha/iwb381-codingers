import ballerina/http;

listener http:Listener httpListener = new (8080);



service / on httpListener {

    resource function get greeting() returns http:Response { 
        http:Response res = new http:Response();
        res.setHeader("Access-Control-Allow-Origin", "*");
        res.setHeader("Access-Control-Allow-Methods", "GET, POST, OPTIONS");
        res.setHeader("Access-Control-Allow-Headers", "Content-Type, X-Requested-With, Authorization");
        res.setPayload("Hello, World!");
        return res; 
    }

    resource function get greeting/[string name]() returns http:Response { 
        http:Response res = new http:Response();
        res.setHeader("Access-Control-Allow-Origin", "*");
        res.setHeader("Access-Control-Allow-Methods", "GET, POST, OPTIONS");
        res.setHeader("Access-Control-Allow-Headers", "Content-Type, X-Requested-With, Authorization");
        res.setPayload("Hello, " + name);
        return res; 
    }
}