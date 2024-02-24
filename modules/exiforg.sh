exiforg () {
    # recursively moves image files into folders based on user specified structure

    # set defaults
    org="not specified"
    title=
    dryrun=false
    recursive=
    
    while [[ $# -gt 0 ]]; do
	case $1 in
	    -h|--help)
		echo
		echo "description: recursively moves image files into folders based on user specified structure"
		echo "             removes any empty folders after moves in source and target folders"
		echo
		echo "usage: exiforg [-h] [-f] struct sourcefolder targetfolder"
		echo
		echo "options: -h     = help"
		echo "         struct = sets folder structure"
		echo "                = -ym  = folder structure is YYYY / YYYY_mm             "
		echo "                = -ymd = folder structure is YYYY / YYYY_mm / YYYY_mm_dd"
		echo "                = -ymt = folder structure is YYYY / YYYY_mm / Title     "
		echo "                         Only image files with Title metadata will be moved"
		echo "         -d     = dry run shows chagnes that will be made but does not make them"
		echo "         -f     = flatten current folder (recursively moves all images to current folder)"
		echo 
		echo "examples: exiforg -ymd . structured    # moves all image files to folder 'sorted' in ymd structure"
		echo "          exiforg -h"
		echo "          exiforg -f"
		echo
		echo "example of simple manual command:"
		echo "    exiftool -r -d %Y/%Y_%m '-Directory<newfolder/\$FileCreateDate' ."
		echo
		return
		;;
            -f|-flat)
		exiftool -r '-Directory=.' .
		return
		;;
            -ym)
		org="%Y/%Y_%m"
		shift # past argument
		;;
            -ymd)
		org="%Y/%Y_%m/%Y_%m_%d"
		shift # past argument
		;;
            -ymt)
		echo #####################################################################
		echo #                                                                   #
		echo # WARNING: Only images with titles will be moved into new structure #
		echo #                                                                   #
		echo #####################################################################
		org="%Y/%Y_%m"
		# ";" inside the {} for a tag replaces any characters that would be dangerous for a folder name
		title='/${Title;}'
		shift # past argument
		;;
            -d|--dry)
		dryrun=true
                shift # past argument
                ;;
            *)  # anthing that remains should be source and target folders
                echo Setting source and target folders
                source="$1"
                target="$2"
                echo source: $source
                echo target: $target
                shift # past argument
                shift # past argument
                ;;
        esac
    done

    if [ "$org" = 'not specified' ]; then
	echo "ERROR: Need to specify file structure in command line."
	echo "       Options include: -ym, -ymd, -ymt"
	return
    fi
    
    if [ $dryrun = false ]; then
        exiftool -r -d "$org"                               \
                 '-Directory<'"$target"'/$FileModifyDate'"$title"   \
                 '-Directory<'"$target"'/$FileCreateDate'"$title"   \
                 '-Directory<'"$target"'/$CreateDate'"$title"       \
                 '-Directory<'"$target"'/$DateTimeOriginal'"$title" \
                 "$source"
    else
        #exiftool -r -d "$org"  '-TestName<'"$target"'/$FileCreateDate' "$source"
        exiftool -r -d "$org"                               \
                 '-TestName<'"$target"'/$FileModifyDate'"$title"   \
                 '-TestName<'"$target"'/$FileCreateDate'"$title"   \
                 '-TestName<'"$target"'/$CreateDate'"$title"       \
                 '-TestName<'"$target"'/$DateTimeOriginal'"$title" \
                 "$source"
    fi

    # eliminate empty folders in source and target folders
    find $source -empty -type d -delete
    if [ $source != $target ]; then find $target -empty -type d -delete; fi
}
