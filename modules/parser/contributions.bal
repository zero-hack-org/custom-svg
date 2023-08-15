import zerohack/github;

# No contributions occurred.
configurable string noneQuaritleColor = "#ebedf0";
# Lowest 25% of days of contributions.
configurable string firstQuaritleColor = "#9be9a8";
# Second lowest 25% of days of contributions. More contributions than the first quartile.
configurable string secondQuaritleColor = "#40c463";
# Second highest 25% of days of contributions. More contributions than second quartile, less than the fourth quartile.
configurable string thirdQuaritleColor = "#30a14e";
# Highest 25% of days of contributions. More contributions than the third quartile.
configurable string fourthQuaritleColor = "#216e39";

configurable string strokeColor = "#affeca";

# Generate contributions xml
#
# + contributions - contributions data
# + return - contributions xml
public function generateContributions(github:ContributionsResponse contributions) returns error|xml:Element {
    final xml:Element parent = check generateParentSvg();

    final xml colorStyle = check generateColorStyle({
        NONE: noneQuaritleColor,
        FIRST_QUARTILE: firstQuaritleColor,
        SECOND_QUARTILE: secondQuaritleColor,
        THIRD_QUARTILE: thirdQuaritleColor,
        FOURTH_QUARTILE: fourthQuaritleColor
    });

    final xml rect = check generateBackRectStyle(strokeColor);

    final xml pixels = check generatePixel(contributions);

    parent.setChildren(colorStyle + rect + pixels);

    return parent;
}
