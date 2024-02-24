# photo_organize

# Work Process to organize files

- Review existing folders to determine whether metadata dates or titles need to be fixed before using `exiforg` to create file structure (`exiforg` will use DateTimeOriginal, CreateDate, FileCreateDate, then FileModifyDate if needed).
  - If you are confident that dates are good and just want to view the tree of folder names so you know where to focus to add to meta data, enter `treed`.
  - digikam
    - In album (enter using top left side tab), highlight pictures to modify.
    - Press `t` to open tag interface then select "Description"
    - If needed, correct date. If desired, add title. Select "Apply".
  - exifdates
    - Use to set dates to either a user specified date or the earliest date for each image in the metadata for that image recursively through folders
    - See instructions further below
  - exiftool
    - Use directly if only need to change titles, for example, the following adds a title recursively through the folder:
      `exiftool -r "-title=Italy, Rome" .`

- Run exiforg to establish folder structure: YYYY / YYYY_mm / YYYY_mm_dd
  - Example: `exiforg -ymd . .`
  - To inspect the folder structure: `treed`
  - To inspect what files are in what folders: `tree`

- Run exiforg again to move images with titles from YYYY_mm_dd to YYYY_mm_Title folders
  - example: `exiforg -ymt . .`

- In digiKam or some other picture managment tool
  - In album, right click and select "refresh"
  - Inspect new folder structure and pictures in digiKam
  - Rename remaining YYYY_mm_dd folders to YYYY_mm_Title format if desired

- Add metadata to all pictures using digiKam

- If everything looks OK, remove any "original" files left over from exiftool commands.
  - Inspect results in digiKam
  - Remove all files ending in "_original" (e.g., `rmorig`)

- Copy or move new folders into the area where other organized folders reside.



-------------------------------------------------

# Setup
- Install Exiftool (not part of this repository)
- Clone git repository
- Source _bashrc_exiftool.sh
- Optional
  - Install digiKam as a picture viewer and tool to work with metadata.
  - If using Windows and will need to copy/paste or cut/paste large numbers of files or folders, you should install TeraCopy rather than useing the default File Explorere file manager. (See https://codesector.com/teracopy.)


-------------------------------------------------

# Supporting tools to run in Linux or Git Bash shell

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

  - recommendation:
    - run 1st using -ymd to establish date based structure for all images
    - run again using -ymt to move any images that have titles from a YYYY_mm_dd to a YYYY_Title folder


- exifmeta
  - description: 



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

-------------------------------------------------
# Example manual commands

example of simple manual command to create a file structure only from FileCreateDate:
    exiftool -r -d %Y/%Y_%m '-Directory<newfolder/\$FileCreateDate' .
