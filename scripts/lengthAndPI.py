from isoelectric import ipc
seqs = open("seqsOnly.csv", "r")
pIAndLength = open("pIAndLength.csv", "w")
text = "proteinLength,isoelectricPoint"
x=0
for line in seqs:
    if x == 0:
        None
    else:
        seq = line
        length = str(len(seq))
        pI = str(ipc.predict_isoelectric_point(seq))
        text = text + "\"" + length + "\"^^<http://www.w3.org/2001/XMLSchema#int>" + "," + "\"" + pI + "\"^^<http://www.w3.org/2001/XMLSchema#float>\n"
pIAndLength.write(text)
seqs.close()
pIAndLength.close()