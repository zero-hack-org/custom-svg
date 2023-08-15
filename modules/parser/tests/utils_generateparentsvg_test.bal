import ballerina/test;

@test:Config {}
function testGenerateParentSvg() returns error? {
    final xml result = check generateParentSvg();

    final xml expecte = xml `<svg width="770.0" height="126.0" xmlns="http://www.w3.org/2000/svg"></svg>`;

    test:assertEquals(result.toJson(), expecte.toJson());
}

