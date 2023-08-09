import ballerina/graphql;
import ballerina/os;

configurable string githubUsername = os:getEnv(GITHUB_USERNAME);
configurable string githubPersonalAccessToken = os:getEnv(GITHUB_PERSONAL_ACCESS_TOKEN);

# Configurable check
function init() {
    if githubUsername.length() < 1 {
        panic error GithubConfigurationError(string `variable githubUsername is not set.`);
    }

    if githubPersonalAccessToken.length() < 1 {
        panic error GithubConfigurationError(string `variable githubPersonalAccessToken is not set.`);
    }
}

// Github graphql client
public class GraphQlClient {

    private final graphql:Client githubClient;

    # Constructor
    #
    # + serviceUrl - Endpoint url
    # + configuration - Graphql client confuguration
    # + return - error?
    public function init(
            string serviceUrl = GITHUB_GRAPHQL_ENDPOINT,
            graphql:ClientConfiguration configuration = {}
    ) returns error? {
        self.githubClient = check new (serviceUrl, configuration);
    }

    # Query execute
    #
    # + document - Query
    # + variables - Query parameter
    # + operationName - Operation name
    # + headers - Request headers
    # + return - Response
    public function execute(
            string document,
            map<anydata>? variables = (),
            string? operationName = (),
            map<string|string[]>? headers = ()
    ) returns graphql:GenericResponseWithErrors|record {|anydata...;|}|json|graphql:ClientError {

        // gen variables
        map<anydata> clonedVariables;
        if variables is () {
            clonedVariables = {[REQUEST_VARIABLE_USERNAME_KEY] : githubUsername};
        } else {
            clonedVariables = variables.clone();
            clonedVariables[REQUEST_VARIABLE_USERNAME_KEY] = githubUsername;
        }

        // gen headers
        map<string|string[]> clonedHeaders;
        if headers is () {
            clonedHeaders = {[REQUEST_HEADER_AUTHORIZATION_KEY] : string `bearer ${githubPersonalAccessToken}`};
        } else {
            clonedHeaders = headers.clone();
            clonedHeaders[REQUEST_HEADER_AUTHORIZATION_KEY] = string `bearer ${githubPersonalAccessToken}`;
        }

        record {|anydata...;|}|graphql:ClientError result = self.githubClient->execute(document, clonedVariables, operationName, clonedHeaders);
        return result;
    };

}
