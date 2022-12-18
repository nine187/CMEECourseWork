#!/usr/bin/env python3
# Author: Pasith Prayoonrat
# Script: TestR.py
# Description: This script demonstrates running R from python 
# Date: December 2022

"""Demonstrating running R from python"""

#import the subprocess module
import subprocess

subprocess.Popen("Rscript --verbose TestR.R > ../results/TestR.Rout 2> ../results/TestR_errFile.Rout", shell=True).wait()