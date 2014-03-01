import pandas as pd
import numpy as np



df = pd.read_csv("/Users/glamp/Downloads/nbagames.csv")
df['away'] = df.matchup.str.split(' at ').apply(lambda x: x[0])
df['home'] = df.matchup.str.split(' at ').apply(lambda x: x[1])
df['away_score'] = df.score.str.split(' - ').apply(lambda x: int(x[0]))
df['home_score'] = df.score.str.split(' - ').apply(lambda x: int(x[1]))
df['home_win'] = np.where(df.away_score < df.home_score, 1, 0)

