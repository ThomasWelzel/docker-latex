#!/bin/sh

set +e
cd /tmp
cp -R projekt projekt2
cd projekt2
latexmk -cd -e '$$pdflatex="pdflatex -interaction=nonstopmode %S %O"' -f -pdf main.tex
echo "Compiling done!"

dirname="build"
mkdir -p ../projekt/build
cp *.pdf ../projekt/build
cp *.log ../projekt/build
cp *.bbl ../projekt/build


