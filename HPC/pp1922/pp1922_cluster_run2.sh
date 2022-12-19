#!/bin/bash
# Desc: Shell for running R script on HPC cluster

#PBS -l walltime=01:00:00 
#PBS -l select=1:ncpus=1:mem=1gb

module load anaconda3/personal

echo "running R"

R --vanilla < $HOME/pp1922_HPC_2022_cluster2.R

echo "Done with running R"