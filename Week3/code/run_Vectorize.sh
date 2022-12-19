#!/bin/bash

echo "Running Vectorize1.R"
Rscript ./Vectorize1.R

echo "Running Vectorize2.R"
Rscript ./Vectorize2.R

echo "Running Vectorize1.py"
ipython3 ./Vectorize1.py

echo "Running Vectorize2.py"
ipython3 ./Vectorize2.py

echo "Four files completed"