#!/bin/sh

# Script should be run with current working directory set to the input

die() {
    echo "$*" >&2
    exit 1
}

if [ -n "$1" ]; then
    cd "$1" || dir "dir $1 not found"
else
    die "Usage: run.sh [datadir]"
fi

#command -v frog || die "Frog not found"
command -v transcribedspeech2folia || die "transcribedspeech2folia not found"

#not the most efficient (frog init time) but collection is small enough to be fine
[ -d input/ ] && rm -Rf input/
[ -d output/ ] && rm -Rf output/
mkdir input output
if ! find . -name "*.txt" -exec transcribedspeech2folia -o input/ {} \; ; then
    die "Conversion failed"
fi
for f in input/*.folia.xml; do 
    frog --skip=pac -x "$f" -X "output/$(basename "$f")"  || die "Frog failed on $f"
done
