import ballerina/test;

@test:Config {}
function testStringToXml() returns error? {
    final xml result = check stringToXml("<svg></svg>");

    final xml expected = xml `<svg></svg>`;

    test:assertEquals(result, expected);
}
