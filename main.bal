import zerohack/github;
import svg_parser.parser;
import ballerina/http;

configurable int port = 8080;

github:GraphQlClient githubClient = new;

service / on new http:Listener(port) {
    resource function get contributions(http:Request request) returns error|http:Response {
        http:Response response = new;
        github:ContributionsResponse contributions = check githubClient.getContributions();

        final xml:Element result = check parser:generateContributions(contributions);

        response.setPayload(result);
        response.setHeader("Content-Type", "image/svg+xml");
        return response;
    }
}
