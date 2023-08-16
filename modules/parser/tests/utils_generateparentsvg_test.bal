import ballerina/test;

@test:Config {}
function testGenerateParentSvg() returns error? {
    final xml result = check generateParentSvg();

    final xml expecte = xml `<svg width="766.0" height="122.0" xmlns="http://www.w3.org/2000/svg"></svg>`;

    test:assertEquals(result.toString(), expecte.toString());
}

