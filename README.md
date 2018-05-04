# docker-latex

Dockerfile für thowel/latex image: Ubuntu mit texlive und git

textlive installation:
- texlive-latex-extra 
- texlive-fonts-extra 
- texlive-bibtex-extra
- texlive-extra-utils
- texlive-science
- texlive-lang-german

## how to run local to build latex script

git clone https://github.com/ThomasWelzel/latex-bitbucket.git

```
docker run -v $pathtolatexprojekt$:/tmp/projekt -v $pathto$/latex-bitbucket/:/tmp/scripts -i thowel/latex /tmp/scripts/compile.sh
```

## setup bitbucket pipeline
Automatisches bauen eines Latexprojektes und pushen der generierten Dateien in ein Github Projekt.

Die Beispielkonfiguration generiert ein `build-YYYYmmDD_HHMMSS` Unterordner und pusht das Ergebnis in ein Git Projekt.

Aktiviere Piplines in deinem Bitbucket Projekt und lege folgende Konfiguration an:
Filename: bitbucket-pipelines.yml

```
image: thowel/latex
pipelines:
  custom:
    latex:
       - step:
           script:
             - set +e
             - latexmk -cd -e '$$pdflatex="pdflatex -interaction=nonstopmode %S %O"' -f -pdf main.tex
             - echo "Compiling done!"
             - git clone https://<user>:<passwort>@<url>/<projekt>.git
             - git config --global user.email "<mail>"
             - git config --global user.name "<name>"
             - dirname="build-"$(date +"%Y%m%d_%H%M%S")
             - mkdir -p <projekt>/builds/$dirname
             - cp *.pdf <projekt>/builds/$dirname/
             - cp *.log <projekt>/builds/$dirname/
             - cp *.bbl <projekt>/builds/$dirname/
             - cd <projekt>
             - git add .
             - git commit -m $dirname
             - git push
```
