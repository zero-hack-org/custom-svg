import ballerina/io;

# Generate color style
#
# ```ballerina
# generateColorStyle({
#   NONE: "#333333",
#   FIRST_QUARTILE: "#555555",
#   SECOND_QUARTILE: "#777777",
#   THIRD_QUARTILE: "#999999",
#   FOURTH_QUARTILE: "#BBBBBB"
# });
# ⇒ xml `<style>
#            #github-contributions .pixel {
#                width: 10px;
#                height: 10px;
#                rx: 2px;
#                ry: 2px;
#                stroke: rgba(0, 0, 0, 0);
#                stroke-width: 0px;
#            }
#
#            #github-contributions .NONE {
#                fill: #333333;
#            }
#
#            #github-contributions .FIRST_QUARTILE {
#                fill: #555555;
#            }
#
#            #github-contributions .SECOND_QUARTILE {
#                fill: #777777;
#            }
#
#            #github-contributions .THIRD_QUARTILE {
#                fill: #999999;
#            }
#
#            #github-contributions .FOURTH_QUARTILE {
#                fill: #BBBBBB;
#            }
#        </style>`;
#
# ```
#
# + levelColor - contributions level color config
# + return - xml style tag
function generateColorStyle(ContributionLevelColor levelColor, int pixelSize = 10) returns xml|error {
    // Constant style
    final string startTag = "<style>";
    final string endTag = "</style>";
    final string pixelStyle = string `
            #github-contributions .pixel {
                width: ${pixelSize}px;
                height: ${pixelSize}px;
                rx: 2px;
                ry: 2px;
                stroke: rgba(0, 0, 0, 0);
                stroke-width: 0px;
            }
        `;

    // Generate style per color level
    final string[] colorStyles = [];
    foreach string level in levelColor.keys() {
        final string color = levelColor.get(level);
        final string colorStyle = string `
            #github-contributions .${level} {
                fill: ${color};
            }
        `;
        colorStyles.push(colorStyle);
    }

    // Merge style string
    string mergeStyleString = "";
    foreach var style in [startTag, pixelStyle, ...colorStyles, endTag] {
        mergeStyleString += style;
    }

    final io:StringReader reader = new (mergeStyleString);
    final xml result = check reader.readXml() ?: xml ``;

    return result;
}

# Generate background rect style
#
# ```:ballerina
# generateBackRectStyle(
#     "#ffff00"
# );
# ⇒ xml `<rect width="770.0" height="126.0" stroke="#ffff00" stroke-width="2px" fill="#00000000"></rect>`;  
# ```
#
# + strokeColor - rect stroke color
# + pixelSize - pixel size for calc rect size
# + pitch - pixel pitch for calc rect size
# + return - rect style
function generateBackRectStyle(string strokeColor, int pixelSize = 10, float pitch = 2.0) returns xml|error {

    // 1week(7day) * 53 = 371
    // IF column is 52, 1week(7day) * 52 = 364 < 365
    final int column = 53;
    final int row = 7;
    final float onePixelSize = <float>pixelSize + pitch * 2.0;
    final float margin = onePixelSize * 2;

    // calc width, height
    final float width = onePixelSize * column + margin;
    final float height = onePixelSize * row + margin;

    final string backRectStyle = string `<rect width="${width}" height="${height}" stroke="${strokeColor}" stroke-width="2px" fill="#00000000"></rect>`;

    final io:StringReader reader = new (backRectStyle);
    final xml result = check reader.readXml() ?: xml ``;

    return result;

}
