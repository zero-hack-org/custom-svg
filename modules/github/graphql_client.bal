import ballerina/graphql;
import ballerina/os;

// GitHub graphql endpoint(https: //docs.github.com/ja/graphql/guides/forming-calls-with-graphql#the-graphql-endpoint)
final string GITHUB_GRAPHQL_ENDPOINT = "https://api.github.com/graphql";

// Environment key
final string GITHUB_USERNAME = "GITHUB_USERNAME";
final string GITHUB_PERSONAL_ACCESS_TOKEN = "GITHUB_PERSONAL_ACCESS_TOKEN";

function init() {
    if os:getEnv(GITHUB_USERNAME).length() < 1 {
        panic error GithubConfigurationError(string `Environment variable '${GITHUB_USERNAME}' is not set.`);
    }

    if os:getEnv(GITHUB_PERSONAL_ACCESS_TOKEN).length() < 1 {
        panic error GithubConfigurationError(string `Environment variable '${GITHUB_PERSONAL_ACCESS_TOKEN}' is not set.`);
    }
}

// Github graphql client
public class GraphQlClient {

    private final graphql:Client githubClient;

    private final string username;

    # Constructor
    #
    # + serviceUrl - Endpoint url
    # + configuration - Graphql client confuguration
    # + return - error?
    public function init(
            string serviceUrl = GITHUB_GRAPHQL_ENDPOINT,
            graphql:ClientConfiguration configuration = {}
    ) returns error? {
        final string username = os:getEnv(GITHUB_USERNAME);
        if username.length() < 1 {
            panic error GithubConfigurationError(string `Environment variable '${GITHUB_USERNAME}' is not set.`);
        }
        self.username = username;
        self.githubClient = check new (serviceUrl, configuration);
    }

    public function execute(
            string document,
            map<anydata>? variables = (),
            string? operationName = (),
            map<string|string[]>? headers = ()
    ) returns graphql:GenericResponseWithErrors|record {|anydata...;|}|json|graphql:ClientError {

        map<anydata> clonedVariables;
        if variables is () {
            clonedVariables = {"username": self.getUsername()};
        } else {
            clonedVariables = variables.clone();
            clonedVariables["username"] = self.getUsername();

        }

        return self.githubClient->execute(document, clonedVariables, operationName, headers);
    };

    // public function execute(
    //         string document, map<anydata>? variables = (), string? operationName = (),
    //         map<string|string[]>? headers = (),
    //         typedesc<graphql:GenericResponseWithErrors|record {}|json> targetType = <>
    // ) returns targetType|graphql:ClientError = @java:Method {
    //     'class: "io.ballerina.stdlib.graphql.runtime.client.QueryExecutor",
    //     name: "execute"
    // } external;

    private function getUsername() returns string {
        return os:getEnv(GITHUB_USERNAME);
    }

    private function getToken() returns string {
        return os:getEnv(GITHUB_PERSONAL_ACCESS_TOKEN);
    }

}
