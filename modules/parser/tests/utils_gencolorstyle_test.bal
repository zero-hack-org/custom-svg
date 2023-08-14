import ballerina/test;

@test:Config {}
function testGenerateColorStyle() returns error? {
    final xml result = check generateColorStyle({
        NONE: "#333333",
        FIRST_QUARTILE: "#555555",
        SECOND_QUARTILE: "#777777",
        THIRD_QUARTILE: "#999999",
        FOURTH_QUARTILE: "#BBBBBB"
    });

    final xml expected = xml `<style>
            #github-contributions .pixel {
                width: 10px;
                height: 10px;
                rx: 2px;
                ry: 2px;
                stroke: rgba(0, 0, 0, 0);
                stroke-width: 0px;
            }
        
            #github-contributions .NONE {
                fill: #333333;
            }
        
            #github-contributions .FIRST_QUARTILE {
                fill: #555555;
            }
        
            #github-contributions .SECOND_QUARTILE {
                fill: #777777;
            }
        
            #github-contributions .THIRD_QUARTILE {
                fill: #999999;
            }
        
            #github-contributions .FOURTH_QUARTILE {
                fill: #BBBBBB;
            }
        </style>`;

    test:assertEquals(
        result.toJson(),
        expected.toJson()
    );

}
