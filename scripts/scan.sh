#!/bin/sh
outdir=`date +%Y_%m_%d`
exitcode=0
for filepath in /volume2/Share2/Scan/*.pdf
do
    if [ -e "$filepath" ]; then
      filename=$(basename "$filepath")
	  echo "converting $filename"
	  docker run --rm --network=host -v /volume2/Share2/Scan/:/datain -v "/volume2/Share2/Documents/$outdir":/dataout andy008/ocrmypdf --output-type pdf "/datain/$filename" "/dataout/$filename"
	  mkdir -p "/volume2/Share2/Scan/original/$outdir"
	  mv "/volume2/Share2/Scan/$filename" "/volume2/Share2/Scan/original/$outdir/$filename"
	  exitcode=1
	fi
done
chown -R sr.users "/volume2/Share2/Documents/$outdir"
# if we did not create anything remove the directory to avoid empty dirs
rmdir --ignore-fail-on-non-empty "/volume2/Share2/Documents/$outdir"
exit $exitcode
