#!/bin/sh

#for DOT in dot/reducao_mochila.dot; do
  #echo "File $DOT"

  #echo "\tGenerating TEX..."
  #dot2tex --preproc -tmath -s $DOT | dot2tex --nominsize -ftikz --prog twopi -c > tex/`basename $DOT .dot`.tex
  #cd tex/
  #pdflatex `basename $DOT .dot`.tex
  #mv `basename $DOT .dot`.pdf ../pdf
  #cd ..
  #evince pdf/`basename $DOT .dot`.pdf &
#done

#for DOT in dot/spp_d*; do
  #echo "File $DOT"

  #echo "\tGenerating TEX..."
  #neato -Txdot $DOT | dot2tex --preproc -tmath -s | dot2tex --nominsize -ftikz --prog neato -s -c > tex/`basename $DOT .dot`.tex

  #cd tex/
  #pdflatex `basename $DOT .dot`.tex
  #mv `basename $DOT .dot`.pdf ../pdf
  #cd ..
  #evince pdf/`basename $DOT .dot`.pdf &
#done

for DOT in dot/pd2*; do
  echo "File $DOT"

  echo "\tGenerating TEX..."
  dot2tex --preproc -tmath -s $DOT | dot2tex --nominsize -ftikz --prog dot -c > tex/`basename $DOT .dot`.tex
  #neato -Txdot $DOT | dot2tex --preproc -tmath -s | dot2tex --nominsize -ftikz --prog neato -s -c > tex/`basename $DOT .dot`.tex

  cd tex/
  pdflatex `basename $DOT .dot`.tex
  mv `basename $DOT .dot`.pdf ../pdf
  cd ..
  evince pdf/`basename $DOT .dot`.pdf &
done
