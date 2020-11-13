# importing
import matplotlib.pyplot as plt
import pandas as pd
from scipy.stats.stats import pearsonr

# another save path
savePath = 'C:/Users/Amin Gulamani/Desktop/EE Files/Data/CSV files/Output/'

# making relevant variables
df_fdi = pd.read_csv('FDI.csv')
df_unemp = pd.read_csv('Unemp.csv')
df_X = pd.read_csv('X-M.csv')
df_growth = pd.read_csv('growth.csv')
nations = pd.read_csv("FDI.csv", nrows=0).columns
nations = nations.tolist()
# aruba doesnt have any unemployment values so i did the program a favour
nations = nations[1:len(nations)]

# years in the data set cause i didnt feel like importing from the other script
years = df_fdi['year']

# prints correlation coefficient for a quick look at good and bad correlations
# nice for picking my nation cause it helps me know which i'll likely get good data on
# aka making a short list which I later picked from
for x in nations:
    points = []
    print(x)
    try:
        print(pearsonr(Fdi, Unemp))
    except:
        print('Incomplete data')
    Fdi = df_fdi[x]
    Fdi = Fdi.tolist()
    X = df_X[x]
    X = X.tolist()
    growth = df_growth[x]
    growth = growth.tolist()
    Unemp = df_unemp[x]
    Unemp = Unemp.tolist()

    name = ['FDI']
    # formatting and making those fancy graphs as seen in appendixs C
    # I was having trouble picking the nation so I just did them all
    l = pd.DataFrame(Fdi, columns=name)
    l.insert(0, "Unemployment", Unemp)
    l.insert(0, "Exports Minus", X)
    l.insert(0, "Year", years)
    l.insert(0,'GDP', growth)
    l.to_csv(savePath + x + '.csv', index=False)

    plt.figure(figsize=(5, 5))
    plt.scatter(Fdi, Unemp, color='red')
    plt.title(x + "")
    for i, txt in enumerate(years):
        plt.annotate(txt, (Fdi[i], Unemp[i]))
    plt.xlabel("Foreign Direct Investment % GDP")
    plt.ylabel("Unemployment % ILO t.")
    plt.savefig(savePath + x)
    plt.close()
