import ballerina/http;

service / on new http:Listener(8080) {
    resource function get [string username](http:Caller caller, http:Request request) returns error? {
        http:Response response = new;
        string svgData = "<svg xmlns='http://www.w3.org/2000/svg' width='100' height='100'><circle cx='50' cy='50' r='40' stroke='black' stroke-width='3' fill='red' /></svg>";
        response.setPayload(svgData);
        response.setHeader("Content-Type", "image/svg+xml");
        check caller->respond(response);
    }
}
