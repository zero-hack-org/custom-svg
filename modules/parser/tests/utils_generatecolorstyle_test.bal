import ballerina/test;
import ballerina/io;

@test:Config {}
function testGenerateColorStyle() returns error? {
    final xml result = check generateColorStyle({
        NONE: "#333333",
        FIRST_QUARTILE: "#555555",
        SECOND_QUARTILE: "#777777",
        THIRD_QUARTILE: "#999999",
        FOURTH_QUARTILE: "#BBBBBB"
    });

    final xml expected = check io:fileReadXml("modules/parser/tests/resources/utils_generatecolorstyle.xml");

    test:assertEquals(
        result,
        expected
    );

}
