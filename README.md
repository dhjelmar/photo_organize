# photo_organize

## Description

add description here

## Steps

- Defined find alias
```
alias ff='find . -print | grep -i'
```

- Created txt file of all pictures
```
ff jpg > all_jpg.txt
ff raw > all_raw.txt
ff nef > all_nef.txt
ff heic > all_heic.txt
ff png > all_png.txt
ff tiff > all_tiff.txt
cat all_* > all.txt
```

- Read txt file into Excel
