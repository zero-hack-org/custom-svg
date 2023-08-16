import ballerina/http;
import zerohack/github;
import ballerina/test;

http:Client testClient = check new ("http://localhost:8080/");

@test:Config {}
public function testGet() returns error? {

    final github:ContributionsResponse contributions = {
        "data": {
            "user": {
                "contributionsCollection": {
                    "contributionCalendar": {
                        "totalContributions": 1003,
                        "weeks": [
                            {
                                "contributionDays": [
                                    {
                                        "contributionCount": 1,
                                        "date": "2022-08-14T00:00:00.000+00:00",
                                        "color": "#9be9a8",
                                        "weekday": 0,
                                        "contributionLevel": "NONE"
                                    }
                                ]
                            }
                        ]
                    }
                }
            }
        }
    };

    // Mock
    githubClient = test:mock(github:GraphQlClient);

    test:prepare(githubClient).when("getContributions").thenReturn(contributions);

    http:Response response = check testClient->get("/contributions");
    test:assertEquals(response.statusCode, http:STATUS_OK);
    test:assertEquals(response.getHeader("Content-Type"), "image/svg+xml");
}
