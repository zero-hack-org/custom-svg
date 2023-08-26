import zerohack/github;
import ballerina/io;

# Generate parent svg tag
#
# ```ballerina
# generateParentSvg()
# ⇒ xml `<svg width="770.0" height="126.0" xmlns="http://www.w3.org/2000/svg"></svg>`;
# ```
#
# + pixelSize - pixel size
# + pitch - pitch size
# + return - svg tag
isolated function generateParentSvg(int pixelSize = 10, float pitch = 2.0) returns xml:Element|error {
    // 1week(7day) * 53 = 371
    // IF column is 52, 1week(7day) * 52 = 364 < 365
    final int column = 53;
    final int row = 7;
    final float onePixelSize = <float>pixelSize + pitch * 2.0;
    final float margin = onePixelSize * 2;
    // Value for adjust
    final float adjust = pitch * 2.0;

    // calc width, height
    final float width = (onePixelSize * column + margin) - adjust;
    final float height = (onePixelSize * row + margin) - adjust;

    final string svg = string `<svg width="${width}" height="${height}" xmlns="http://www.w3.org/2000/svg"></svg>`;

    final xml result = check stringToXml(svg);

    return <xml:Element>result;
}

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
#            .pixel {
#                width: 10px;
#                height: 10px;
#                rx: 2px;
#                ry: 2px;
#                stroke: rgba(0, 0, 0, 0);
#                stroke-width: 0px;
#            }
#
#            .NONE {
#                fill: #333333;
#            }
#
#            .FIRST_QUARTILE {
#                fill: #555555;
#            }
#
#            .SECOND_QUARTILE {
#                fill: #777777;
#            }
#
#            .THIRD_QUARTILE {
#                fill: #999999;
#            }
#
#            .FOURTH_QUARTILE {
#                fill: #BBBBBB;
#            }
#        </style>`;
#
# ```
#
# + levelColor - contributions level color config
# + pixelSize - pixel size
# + return - xml style tag
isolated function generateColorStyle(ContributionLevelColor levelColor, int pixelSize = 10) returns xml|error {
    // Constant style
    final string startTag = "<style>";
    final string endTag = "</style>";
    final string pixelStyle = string `
            .pixel {
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
            .${level} {
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

    final xml result = check stringToXml(mergeStyleString);
    return result;
}

# Generate background rect style
#
# ```:ballerina
# generateBackRectStyle(
#     "#ffff00"
# );
# ⇒ xml `<rect width="100%" height="100%" stroke="#ffff00" stroke-width="2px" fill="#00000000"></rect>`;  
# ```
#
# + strokeColor - rect stroke color
# + return - rect style
isolated function generateBackRectStyle(string strokeColor) returns xml|error {
    final string backRectStyle = string `<rect width="100%" height="100%" stroke="${strokeColor}" stroke-width="4px" fill="#00000000"></rect>`;

    final xml result = check stringToXml(backRectStyle);
    return result;

}

# Generate pixcels svg from contributions data
#
# + contributions - contributions data
# + pixelSize - pixel size
# + pitch - pitch
# + return - pixels svg xml
isolated function generatePixel(github:ContributionsResponse contributions, int pixelSize = 10, float pitch = 2.0) returns xml|error {
    // generate base tag
    final float onePixel = <float>pixelSize + pitch * 2.0;
    final string startParentSvg = string `<g transform="translate(${onePixel}, ${onePixel})">`;
    final string endParentSvg = "</g>";

    // generate pixel tag
    string pixelsString = startParentSvg;

    foreach [int, github:Weeks] week in contributions.data.user.contributionsCollection.contributionCalendar.weeks.enumerate() {
        final float positionX = week[0] * onePixel;
        foreach [int, github:ContributionDays] day in week[1].contributionDays.enumerate() {
            final float positionY = day[0] * onePixel;
            final string pixelString = string `
                <rect class="pixel ${day[1].contributionLevel}" x="${positionX}" y="${positionY}" data-date="${day[1].date}" data-count="${day[1].contributionCount}">
                    <title>${day[1].date}: ${day[1].contributionCount}</title>
                </rect>
            `;
            pixelsString += pixelString;
        }

    }

    pixelsString += endParentSvg;
    final xml pixelsXml = check stringToXml(pixelsString);
    return pixelsXml;
}

# Convert string to xml
#
# ```ballerina
# strintToXml("<svg></svg>")
# ⇒ xml `<svg></svg>`
# ```
#
# + xmlString - xml format string
# + return - xml
isolated function stringToXml(string xmlString) returns xml|error {
    final io:StringReader reader = new (xmlString);
    final xml result = check reader.readXml() ?: xml ``;
    return result;
}
