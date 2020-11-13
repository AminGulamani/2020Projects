#importing packages
import pandas as pd

#saving a commonly used filepath to save on writing time
dataFilepath = "C:/Users/Amin Gulamani/Desktop/EE Files/Data/CSV files/"

#creating lists for later use
yearsFdi = []
yearsUnemp = []
yearsX = []
yearsgrowth = []
nations = []
yearsGDP = []

#opening world bank files
df_fdiIn = pd.read_csv(dataFilepath + 'FDI Inflows.csv')
df_unemp = pd.read_csv(dataFilepath + 'Unemployment.csv')
df_exports = pd.read_csv(dataFilepath + 'Exports GDP.csv')
df_imports = pd.read_csv(dataFilepath + 'Imports GDP.csv')
df_growth = pd.read_csv(dataFilepath + 'GDPGrowth.csv')
df_GDP = pd.read_csv(dataFilepath + 'GDP.csv')
#saving country names from bank  files
nationsFdiIn = df_fdiIn['Country Name' ]
nationsUnemp = df_unemp['Country Name' ]
nationsExports = df_exports['Country Name' ]
nationsImports = df_imports['Country Name' ]
nationsGrowth = df_growth['Country Name' ]
nationsGDP = df_growth['Country Name' ]

#getting nations from each file
nationsFdiIn = nationsFdiIn.tolist()
nationsFdiIn.insert(0,'year')
nationsUnemp = nationsUnemp.tolist()
nationsUnemp.insert(0,'year')
nationsExports = nationsExports.tolist()
nationsExports.insert(0,'year')
nationsImports = nationsImports.tolist()
nationsImports.insert(0,'year')
nationsGrowth = nationsGrowth.tolist()
nationsGrowth.insert(0,'year')
nationsGDP = nationsGDP.tolist()
nationsGDP.insert(0,'year')

#creating FDI column
for x in range(1991,2020):
    y = df_fdiIn['{0}'.format(x)]
    y = y.tolist()
    y.insert(0,x)
    yearsFdi.append(y)

#GDPGrowth
for x in range(1991, 2020):
    y = df_growth['{0}'.format(x)]
    y = y.tolist()
    y.insert(0, x)
    yearsgrowth.append(y)

for x in range(1991, 2020):
    y = df_growth['{0}'.format(x)]
    y = y.tolist()
    y.insert(0, x)
    yearsGDP.append(y)

#creating X-M column
for x in range(1991,2020):
    y = df_exports['{0}'.format(x)]
    z = df_imports['{0}'.format(x)]
    y = y - z
    y = y.tolist()
    y.insert(0,x)
    yearsX.append(y)

#saving unemployment rate values
for x in range(1991,2020):
    y = df_unemp['{0}'.format(x)]
    y = y.tolist()
    if x in nationsUnemp and x in nationsExports and x in nationsImports and x in nationsGrowth and x in nationsFdiIn:
        nations.append(x)
    y.insert(0,x)
    yearsUnemp.append(y)

# removes all periods from nation names as to not cause errors later
for x in range(0, len(nations) - 1):
    nations[x] = nations[x].replace(".", "")

# saves a sheet of nations and fdi values
l = pd.DataFrame(yearsFdi)
print(l)
l.to_csv('FDI.csv', header=nationsFdiIn, index=False)

# saves a sheet of nations and netExport values
l = pd.DataFrame(yearsX)
print(l)
l.to_csv('X-M.csv', header=nationsExports, index=False)

#saves GDPGrowth
l = pd.DataFrame(yearsgrowth)
print(l)
l.to_csv('growth.csv', header=nationsGrowth, index=False)

l = pd.DataFrame(yearsGDP)
print(l)
l.to_csv('GDP.csv', header=nationsGDP, index=False)

# saves a sheet of nations and unemployment values
l = pd.DataFrame(yearsUnemp)
print(l)
l.to_csv('Unemp.csv', header=nationsUnemp, index=False)



