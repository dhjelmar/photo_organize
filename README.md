# photo_organize

# Work Process for xxxxxxxxxx

- Defined findext function in photo_organze/_bashrc_exiftool.sh
  ```
  findext () {
     # find all files with given extension but not with "_original" following the extension
     # usage: findext jpg
     find . -name "*.$1" -not -name "*.$1_original*" -type f
  }
  ```

- Created txt file of all pictures
  ```
  findext jpg   > all.txt
  findext raw  >> all.txt
  findext nef  >> all.txt
  findext heic >> all.txt
  findext png  >> all.txt
  findext tiff >> all.txt
  ```

- Read txt file into Excel






-------------------------------------------------
# Supporting tools

- exifex
  - provides a list of useful examples to the screen

- exifinfo
  - description: extracts metadata I am most interested in
  - usage      : exifinfo files
    ```
    ## example
    exifinfo fn.jpg
    ```

- exifdates
  - description: writes dates to metadata
  - usage      : exifdates [-d date] files
    ```
    ## examples
    
    ## to set dates in fn.jpg to a specific date
    exifdates -d '2024:01:01' fn.jpg
    
    ## to set dates in fn.jpg to earliest date in metadata
    exifdates fn.jpg
    
    ## to set dates in all files to earliest date in metadata from each file
    exifdates *
    
    ## still need to test behavior of above vs the following
    exifdates '*'
    ```

- exifclean

- exdirclean

- exifrestore

- exifmark

- shell variables
  ```
  export tags='-Keywords<TagsList -Subject<TagsList -LastKeywordXMP<TagsList -CatalogSets<TagsList' 
  export dates='-FileCreateDate<DateTimeOriginal -FileModifyDate<DateTimeOriginal'
  ```
