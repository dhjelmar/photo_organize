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
  - xxxxxxxxxx
  - xxxxxxxxxx

- xxxxxxxxxxx






-------------------------------------------------
# Supporting tools

- exiforg
  - description: recursively moves image files into folders based on user specified structure
  - usage      : exiforg [-h] [-f] struct sourcefolder targetfolder
  - options    : `-h`     = help
    - struct = sets folder structure
      
      `-ym`  = folder structure is YYYY / YYYY_mm             
      `-ymd` = folder structure is YYYY / YYYY_mm / YYYY_mm_dd
      `-ymt` = folder structure is YYYY / YYYY_mm / Title; Only image files with Title metadata will be moved
      
    - `-d`     = dry run shows chagnes that will be made but does not make them
    - `-f`     = flatten current folder (recursively moves all images to current folder)

  - examples:
    ```
    exiforg -ymt . ../sorted    # moves all image files to folder 'sorted' in ymt structure
    exiforg -h               # to get help
    exiforg -f               # to recursively flatten imgage files in subfolders to current folder
    ```

example of simple manual command:
    exiftool -r -d %Y/%Y_%m '-Directory<newfolder/\$FileCreateDate' .

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
