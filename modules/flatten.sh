flatten () {
    
    # Loop through arguments and process them
    keepdir=false
    while [[ $# -gt 0 ]]; do
	case $1 in
            -h|--help)
		echo
		echo "Description:"
		echo "    Pulls all files to current folder."
		echo "    If duplicate exists, add path from subfolders to the filename."
		echo
		echo "Usage: flatten [-d]"
		echo
		echo "Option: -d = adds directories to filenames even if not a duplicate"
		echo
		echo "Example:"
		echo "     Given files in current folder            : fn.jpg"
		echo "                                                test1 / fn.jpg"
		echo "                                                test1 / fn2.jpg"
		echo "                                                test1 / test2 / fn.jpg"
		echo "     Enter command                            : flatten"
		echo "     Creates following files in current folder: fn.jpg"
		echo "                                                fn.jpg__test1.jpg"
		echo "                                                fn.jpg__test1_test2.jpg"
		echo "                                                fn2.jpg"
		echo
		return
		;;
            -d)
                keepdir=true
                shift # past argument
                ;;
            *)
		files+=("$1") # save any remaining arguments in files
		shift # past argument
		;;
	esac
    done
   
    OIFS="$IFS"  # To handle spaces in folders and files: 1st save IFS
    #            # $IFS default is <space><tab<>newline> by default
    IFS=$'\n'    # To handle spaces in folders and files: 2nd change it to focus on new lines
    
    # find all files recursively
    path_files=`find . -type f -name '*.*'`
    
    for old in $path_files; do
	dir=`dirname "${old}"`
	
	if [ $dir != '.' ]; then
	    
	    #echo ------------------------
	    #echo $old
	    
	    ## remove current directory
	    dir="${dir#*/}"                     # e.g., ./folder1/folder2
	    # use sed to replace "/" with "_"
	    dir=$(echo "${dir}" | sed s@/@_@g)  # e.g., folder1/folder2

	    # extract name of file (e.g., fn.ex)
	    file=`basename "${old}"`
	    #echo "file: $file"
	    #echo "dir : $dir"

	    if [ $keepdir = true ] || [ -f $file ]; then
	    #if [ -f "$file" ]; then
		# option to keep path or file exists in starting folder
		#echo "add path to file"
		
		# extract parts of fn.ext
		fn="${file%.*}"
		ext=$([[ "$file" = *.* ]] && echo "${file##*.}" || echo '')

		# construct new name for file
		new="${fn}.${ext}__${dir}.${ext}"	

		#echo "fn  : $fn"
		#echo "ext : $ext"
		#echo "old : $old"
		#echo "new : $new"
		#echo mv \"$old\" \"$new\"
		mv "$old" "$new"

	    else
		#echo "do not add path to file"
		#echo mv \"$old\" \"$file\"
		mv "$old" "$file"
	    fi
		
	    #echo ------------------------
	fi
    done
    IFS="$OIFS"  # To handle spaces in folders and files: 3rd and last, reset IFS
     return
}

flatten_test () {
    # creates filestructure:
    #
    #     flatten_test
    #       |   fn1.tx
    #       |
    #       \--dir1
    #          |   fn1.txt
    #          |   fn2.txt
    #          |
    #          \---dir2
    #          fn1.txt
    #
    dir0=$PWD
    mkdir flatten_test
    cd flatten_test
    touch fn1.txt
    mkdir dir1
    cd dir1
    touch fn1.txt
    touch fn2.txt
    mkdir dir2
    cd dir2
    touch fn1.txt
    cd "$dir0"
    tree flatten_test
}
