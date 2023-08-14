import ballerina/io;

# Generate color style
#
# ```ballerina
# xml result = generateColorStyle({
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
function generateColorStyle(ContributionLevelColor levelColor) returns xml|error {
    // Constant style
    final string startTag = "<style>";
    final string endTag = "</style>";
    final string pixelStyle = string `
            #github-contributions .pixel {
                width: 10px;
                height: 10px;
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
