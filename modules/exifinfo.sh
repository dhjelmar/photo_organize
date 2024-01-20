exifinfo () {

    # show exif info I care about
    #
    # usage: dc fn.jpg
    #

    f=("$@")                            # obtain file list from commandline
    for f do                            # loop through file list
	if test -f "$f"; then
	    ## '$f' is a file and not a directory
	    echo '----------------------------------------------------------'
	    echo "file: $f"
	    echo
	    echo system date
	    ls -alF "$f"

	    echo
	    echo exiftool dates
	    exiftool -G -s "$f" | grep -i date

	    echo
	    echo "metadata shown in digikam on thumbnails"
	    echo "(requested: title, description, datetimeoriginal, tagslist, regionname)"
	    exiftool -G -s -Title -Description -DateTimeOriginal -TagsList -RegionName "$f"
	fi
    done
}
