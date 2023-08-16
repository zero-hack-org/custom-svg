import zerohack/github;
import ballerina/test;
import ballerina/io;

@test:Config {}
function testGeneratePixel() returns error? {
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
                                    },
                                    {
                                        "contributionCount": 9,
                                        "date": "2022-08-15T00:00:00.000+00:00",
                                        "color": "#9be9a8",
                                        "weekday": 1,
                                        "contributionLevel": "FIRST_QUARTILE"
                                    },
                                    {
                                        "contributionCount": 1,
                                        "date": "2022-08-16T00:00:00.000+00:00",
                                        "color": "#9be9a8",
                                        "weekday": 2,
                                        "contributionLevel": "SECOND_QUARTILE"
                                    },
                                    {
                                        "contributionCount": 0,
                                        "date": "2022-08-17T00:00:00.000+00:00",
                                        "color": "#9be9a8",
                                        "weekday": 3,
                                        "contributionLevel": "THIRD_QUARTILE"
                                    },
                                    {
                                        "contributionCount": 0,
                                        "date": "2022-08-18T00:00:00.000+00:00",
                                        "color": "#9be9a8",
                                        "weekday": 4,
                                        "contributionLevel": "FOURTH_QUARTILE"
                                    }
                                ]
                            }
                        ]
                    }
                }
            }
        }
    };

    final xml result = check generatePixel(contributions);

    final xml expected = check io:fileReadXml("modules/parser/tests/resources/utils_generatepixel.xml");

    test:assertEquals(
        result,
        expected
    );

}
