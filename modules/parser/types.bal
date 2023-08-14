# Contribution level color
#
# + NONE - No contributions occurred.
# + FIRST_QUARTILE - Lowest 25% of days of contributions.
# + SECOND_QUARTILE - Second lowest 25% of days of contributions. More contributions than the first quartile.
# + THIRD_QUARTILE - Second highest 25% of days of contributions. More contributions than second quartile, less than the fourth quartile.
# + FOURTH_QUARTILE - Highest 25% of days of contributions. More contributions than the third quartile.
type ContributionLevelColor record {|
    string NONE;
    string FIRST_QUARTILE;
    string SECOND_QUARTILE;
    string THIRD_QUARTILE;
    string FOURTH_QUARTILE;
|};
