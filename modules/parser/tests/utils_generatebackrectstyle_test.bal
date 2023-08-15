import ballerina/test;

@test:Config {}
function testGenerateBackRectStyle() returns error? {
    final xml result = check generateBackRectStyle(
        "#ffff00"
    );

    final xml expecte = xml `<rect width="770.0" height="126.0" stroke="#ffff00" stroke-width="2px" fill="#00000000"></rect>`;

    test:assertEquals(result.toJson(), expecte.toJson());
}

@test:Config {}
function testGenerateBackRectStyleSizeCustom() returns error? {
    final xml result = check generateBackRectStyle(
        "#ffff00",
        12,
        4.0
    );

    final xml expecte = xml `<rect width="1100.0" height="180.0" stroke="#ffff00" stroke-width="2px" fill="#00000000"></rect>`;

    test:assertEquals(result.toJson(), expecte.toJson());
}
