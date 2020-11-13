import requests
import re
import pandas as pd
from datetime import date

print("starting")
# defining
rdate = date(2017, 2, 2)
dates = []
df = pd.read_csv('units.csv', delimiter=',')
test = df['0'].tolist()
filepath = "C:/Users/Amin Gulamani/Desktop/FEH PowerCreep/"
move = []
TT = []
rating = []
rang = []
# stat columns
# lows
lhp = []
latk = []
lspd = []
ldef = []
lres = []
# mids
mhp = []
matk = []
mspd = []
mdef = []
mres = []
# highs
hhp = []
hatk = []
hspd = []
hdef = []
hres = []
# bsts
lbst = []
hbst = []
for i in test:
    print(i)
    i = i.replace(' ', '_')
    URL = 'https://feheroes.gamepedia.com/' + i
    page = requests.get(URL)
    pagetxt = str(page.text)
    # level 40 stats and bst
    countstr = pagetxt.index(r'mw-headline" id="Level_40_stats')
    countstr2 = pagetxt.index(r'id="Gro')
    pg40txt = pagetxt[countstr:countstr2]
    stats = re.findall(r'[0-9]+/[0-9]+/[0-9]+', pg40txt)
    bst = re.findall(r'>[0-9~]+<', pg40txt)
    bst = str(bst[-1])
    bst = bst.replace(">", "")
    bst = bst.replace("<", "")
    stats = stats[-5:]  # hp,atk,spd,def,res,bst
    hp = stats[0].split('/')
    lhp.append(hp[0])
    mhp.append(hp[1])
    hhp.append(hp[2])
    atk = stats[1].split('/')
    latk.append(atk[0])
    matk.append(atk[1])
    hatk.append(atk[2])
    spd = stats[2].split('/')
    lspd.append(spd[0])
    mspd.append(spd[1])
    hspd.append(spd[2])
    defe = stats[3].split('/')
    ldef.append(defe[0])
    mdef.append(defe[1])
    hdef.append(defe[2])
    res = stats[4].split('/')
    lres.append(res[0])
    mres.append(res[1])
    hres.append(res[2])
    lbst.append(bst[0:3])
    hbst.append(bst[len(bst) - 3:len(bst)])
    # days since release
    countstr = pagetxt.index(r'<time')
    countstr2 = pagetxt.index(r'</time>')
    pagedaystxt = pagetxt[countstr:countstr2]
    wdate = pagedaystxt[16:26]
    udate = date(int(wdate[0:4]), int(wdate[5:7]), int(wdate[8:10]))
    fdate = udate - rdate
    dates.append(fdate.days)
    # MoveType
    countstr = pagetxt.index(r'alt="Icon Move')
    countstr2 = pagetxt.index(r'.png"')
    movetype = pagetxt[countstr:countstr2]
    movetype = movetype.replace('alt="Icon Move ', "")
    movetype = movetype.replace('.png"', "")
    move.append(movetype)
    # Tempest trials
    if 'title="Tempest Trials' in pagetxt:
        TT.append(1)
    else:
        TT.append(0)
    # rating
    countstr = pagetxt.index(r'Rarities</span>')
    countstr2 = pagetxt.index(r'Weapon Type')
    rates = pagetxt[countstr:countstr2]
    ratings = re.findall(r'Icon_Rarity_[0-9].png', rates)
    for x in range(0, len(ratings)):
        ratings[x] = ratings[x].replace('Icon_Rarity_', "")
        ratings[x] = ratings[x].replace('.png', "")
    rating.append(ratings)
    # weapon type
    if 'Ranged' in pagetxt:
        if 'Melee'in pagetxt:
            rang.append('Melee and Ranged')
        else:
            rang.append('Ranged')
    elif 'Melee' in pagetxt:
        rang.append('Melee')
    elif 'Dragonstone' in pagetxt:
        rang.append('Dragonstone')
    else:
        rang.append('Beast')



l = pd.DataFrame(test, columns=['Name'])
l.insert(1, 'Lowhp', lhp)
l.insert(2, 'Midhp', mhp)
l.insert(3, 'Hihp', hhp)
l.insert(4, 'Lowatk', latk)
l.insert(5, 'Midatk', matk)
l.insert(6, 'Hiatk', hatk)
l.insert(7, 'Lowspd', lspd)
l.insert(8, 'Midspd', mspd)
l.insert(9, 'Hispd', hspd)
l.insert(10, 'Lowdef', ldef)
l.insert(11, 'Middef', mdef)
l.insert(12, 'Hidef', hdef)
l.insert(13, 'Lowres', lres)
l.insert(14, 'Midres', mres)
l.insert(15, 'Hires', hres)
l.insert(16, 'Lowbst', lbst)
l.insert(17, 'Hibst', hbst)
l.insert(18, 'DSR', dates)
l.insert(19, 'MT', move)
l.insert(20, 'TT', TT)
l.insert(21, 'Ratings', rating)
l.insert(22, 'Weapon Type', rang)
l.to_csv(filepath + 'funits.csv', index=False)
print("values collected!")
