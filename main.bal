import zerohack/github;
import ballerina/http;

configurable int port = 8080;

service / on new http:Listener(port) {
    resource function get [string username](http:Caller caller, http:Request request) returns error? {
        http:Response response = new;
        final github:GraphQlClient githubClient = new;
        github:ContributionsResponse _ = check githubClient.getContributions();

        string svgData = "<svg xmlns='http://www.w3.org/2000/svg' width='100' height='100'><circle cx='50' cy='50' r='40' stroke='black' stroke-width='3' fill='red' /></svg>";
        response.setPayload(svgData);
        response.setHeader("Content-Type", "image/svg+xml");
        check caller->respond(response);
    }
}
