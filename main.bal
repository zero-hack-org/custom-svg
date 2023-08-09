import custom_svg.github;
import ballerina/http;
import ballerina/graphql;
import ballerina/os;
import ballerina/io;

configurable int port = check int:fromString(os:getEnv(PORT));

service / on new http:Listener(port) {
    resource function get [string username](http:Caller caller, http:Request request) returns error? {
        http:Response response = new;

        string query = string `
            query contributions($username: String!) {
                user(login: $username) {
                    contributionsCollection {
                        contributionCalendar {
                            weeks {
                                contributionDays {
                                    date
                                    color
                                    contributionCount
                                }
                            }
                        }
                    }
                }
            }
        `;

        final github:GraphQlClient githubClient = check new;
        graphql:GenericResponseWithErrors|record {|anydata...;|}|json|graphql:ClientError result = githubClient.execute(
            document = query
        );

        io:println(result);

        string svgData = "<svg xmlns='http://www.w3.org/2000/svg' width='100' height='100'><circle cx='50' cy='50' r='40' stroke='black' stroke-width='3' fill='red' /></svg>";
        response.setPayload(svgData);
        response.setHeader("Content-Type", "image/svg+xml");
        check caller->respond(response);
    }
}
