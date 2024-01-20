# photo_organize

# Work Process for 

- Defined find alias in Chromebook-linux/_bash_aliases
```
alias ff='find . -print | grep -i'
```

- Created txt file of all pictures
```
ff jpg   > all.txt
ff raw  >> all.txt
ff nef  >> all.txt
ff heic >> all.txt
ff png  >> all.txt
ff tiff >> all.txt

```

- Read txt file into Excel


-------------------------------------------------
# Supporting tools

- exifex
  - provides a list of useful examples to the screen

- exifinfo
  - description: extracts metadata I am most interested in
  - usage      : exifinfo files
    '''
    ## example
    exifinfo fn.jpg
    '''

- exifdates writes dates to metadata
  - usage: exifdates [-d date] files
    '''
    ## examples

    ## to set dates in fn.jpg to a specific date
    exifdates -d '2024:01:01' fn.jpg

    ## to set dates in fn.jpg to earliest date in metadata
    exifdates fn.jpg

    ## to set dates in all files to earliest date in metadata from each file
    exifdates *

    ## still need to test behavior of above vs the following
    exifdates '*'

- exifclean

- exdirclean

- exifrestore

- exifmark

- shell variables
  '''
  export tags='-Keywords<TagsList -Subject<TagsList -LastKeywordXMP<TagsList -CatalogSets<TagsList' 
  export dates='-FileCreateDate<DateTimeOriginal -FileModifyDate<DateTimeOriginal'
  '''
