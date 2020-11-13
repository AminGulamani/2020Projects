import requests
import re
import pandas as pd

URL = "https://feheroes.gamepedia.com/List_of_Heroes"
page = requests.get(URL)
pagetxt = str(page.text)
countstr = pagetxt.index(r'<table')
countstr2 = pagetxt.index(r'</table>')
pagetxt = pagetxt[countstr:countstr2]

test = re.findall(r'title="[^<>]+">', pagetxt)
for i in range(0, len(test)):
    test[i] = test[i].replace('"', '')
    test[i] = test[i].replace('title=','')
    test[i] = test[i].replace('>', '')
    test[i] = test[i].replace('&#39;', "%27")
    test[i] = test[i].replace('&quot;', '"')
for i in test:
    if 'Category:' in i:
        test.remove(i)
    elif 'Story Maps' in i:
        test.remove(i)
    elif 'Tempest Trials' in i:
        test.remove(i)
    elif 'Grand Hero' in i:
        test.remove(i)
test = test[::3]
l = pd.DataFrame(test)
l.to_csv('units' + '.csv', index=False)
print('names collected!')