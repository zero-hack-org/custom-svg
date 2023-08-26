import ballerina/test;

@test:Config {}
function testGenerateBackRectStyle() returns error? {
    final xml result = check generateBackRectStyle(
        "#ffff00"
    );

    final xml expecte = xml `<rect width="100%" height="100%" stroke="#ffff00" stroke-width="4px" fill="#00000000"></rect>`;

    test:assertEquals(result.toString(), expecte.toString());
}

