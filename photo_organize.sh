## return relative path
path=`ff config | cut -d '/' -f2-`

## return vetor from path split by '/' delimeter
pathv=(${path//\// })

## ## access start of vector
## echo ${pathv[0]}

## ## loop through each part of path
## for i in $(echo $path | tr "/" "\n")
## do
##   # process
## done


## add entire path to EXIF meta data
exiftool xxxxxxxxxxxxxxxxxxx


## find number of parts to path
lastnum=(${#pathv[@]})

## if only wanted to grab the 2nd part of the variable, could use the following
last=`echo ${path} | cut -d '/' -f $lastnum`

## add last part of the path to the end of the filename
mv xx xx


#######################################################

## pull all dates from meta data


## pull date from file path


## if original date exists, set all dates equal to that


## if no original date, look for any date that matches the folder name year and month.
## set all dates to that date.


## if no match, set all dates to the 1st of the month and year of the folder name
