#/usr/bin/env python
print("sample-id,absolute-filepath,direction")
with open("filenames.txt", 'r') as fhandle:
    for line in fhandle:
        linelist = line.strip().split("_")
        sample = linelist[2] +"_" + linelist[1] + "_" + linelist[3]
        if linelist[4] == "R1.fastq.gz":
            direction = "forward"
        else:
            direction = "reverse"
        filename = "$PWD/" + line.strip()
        lineout = [sample, filename, direction]
        print(",".join(lineout))
