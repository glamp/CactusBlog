import pandas as pd
import numpy as np
import operator
import pprint as pp


def expected_outcome(rating_a, rating_b):
    """
    Calculates the expected outcome of a game played between a team with
    rating_a and rating_b

    rating_a - rating for Team A
    rating_b - rating for Team B

    Examples
    ========
    >>> expected_outcome(1300, 1500)
    0.24025307335204213
    >>> expected_outcome(1653, 1345)
    0.8548291775317597
    """
    q_a = 10**(rating_a / 400.)
    q_b = 10**(rating_b / 400.)
    return q_a / (q_a + q_b)

# K is a constant that can be tweaked. It is sort of a "momentum" parameter.
K = 32
def calc_new_rating(rating_a, rating_b, result, mov=1.0):
    """
    Calculates the new rating for a team given the ratings of both teams and
    a 0/1 binary indicator as to whether or not Team A won.
    
    rating_a - rating for Team A
    rating_b - rating for Team B
    result - 0 if Team A lost, 1 if Team A won
    
    Examples
    ========
    >>> calc_new_rating(1300, 1500, 0)
    1275
    >>> calc_new_rating(1653, 1345, 1)
    1667
    """
    e_a = expected_outcome(rating_a, rating_b)
    new_rating = rating_a + (K * mov) * (result - e_a)
    return int(new_rating)


df = pd.read_csv("/Users/glamp/Downloads/nbagames.csv")
df['away'] = df.matchup.str.split(' at ').apply(lambda x: x[0])
df['home'] = df.matchup.str.split(' at ').apply(lambda x: x[1])
df['away_score'] = df.score.str.split(' - ').apply(lambda x: int(x[0]))
df['home_score'] = df.score.str.split(' - ').apply(lambda x: int(x[1]))
df['home_win'] = np.where(df.away_score < df.home_score, 1, 0)


ratings = {team: 1400 for team in df.home.unique()}


# Loop through the seasons games, calculate the rating after each game and store
# the results into ratings
for idx, row in df.iterrows():
    row = row.to_dict()
    away = row['away']
    home = row['home']
    result = row['home_win']
    # margin of victory
    mov = abs(row['home_score'] - row['away_score'])
    # visitor's rating
    ratings[away] = calc_new_rating(ratings[away], ratings[home], 1 - result)
    # home team's rating
    ratings[home] = calc_new_rating(ratings[home], ratings[away], result)

sorted_ratings = sorted(ratings.iteritems(), key=operator.itemgetter(1),
                        reverse=True)
pp.pprint(sorted_ratings)

