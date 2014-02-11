import json

f = open('temp.json', 'r')
x = json.load(f)
f.close()

#Response
print("Status: %s\n" % "200 OK")
print(json.dumps(x))