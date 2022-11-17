#!/usr/bin/env python3
#Author: Pasith Prayoonrat (pp1922@ic.ac.uk)
#Script: LV1_LV2.py
#Created: Nov 2022
#Desc: Practical work on Biological Python 2

#run the script
ipython3 LV1.py
ipython3 LV2.py


#profile the scripts
python3 -m cProfile LV1.py| head -2
echo
echo -e "LV1.py profiling complete\n"

python3 -m cProfile LV2.py| head -2
echo
echo -e "LV2.py profiling complete\n"