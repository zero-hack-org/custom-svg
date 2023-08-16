import zerohack/github;
import svg_parser.parser;
import ballerina/http;

configurable int port = 8080;

service / on new http:Listener(port) {
    resource function get contributions(http:Caller caller, http:Request request) returns error? {
        http:Response response = new;
        final github:GraphQlClient githubClient = new;
        github:ContributionsResponse contributions = check githubClient.getContributions();

        final xml:Element result = check parser:generateContributions(contributions);

        response.setPayload(result);
        response.setHeader("Content-Type", "image/svg+xml");
        check caller->respond(response);
    }
}
