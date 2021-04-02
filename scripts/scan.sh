#!/bin/sh
# create a per date output directory
outdir=`date +%Y_%m_%d`
exitcode=0
SRC=/volume2/Share2/Scan
DEST=/volume2/Share2/Documents
# docker image to use
IMAGE=andy008/ocrmypdf
for filepath in $SRC/*.pdf
do
  if [ -e "$filepath" ]; then
    filename=$(basename "$filepath")
	  echo "converting $filename"
	  docker run --rm --network=host -v $SRC/:/datain -v "$DEST/$outdir":/dataout $IMAGE --output-type pdf "/datain/$filename" "/dataout/$filename"
    #
    # TODO use pdftotext like
    # >> pdftotext -f 1 -l 1 -layout $filename - | grep -Eq "(Rechnung|Pollin)"
    # to generate more self descriptive filenames or subdirectories based on pdf content
    # extracted_date=`grep -m 1 -o -E "(3[01]|[12][0-9]|0?[1-9])\.(1[012]|0?[1-9])\.((?:19|20)\d{2})"`
    #
    # create a backup of the original file
	  mkdir -p "$SRC/original/$outdir"
	  mv "$SRC/$filename" "$SRC/original/$outdir/$filename"
	  # by setting the exitcode to 1 if something was processed, you can get a mail from synology scheduler
    exitcode=1
	fi
done
chown -R sr.users "$DEST/$outdir"
# if we did not create anything remove the directory to avoid empty dirs
rmdir --ignore-fail-on-non-empty "$DEST/$outdir"
exit $exitcode
