# CMEE 2022 HPC excercises R code HPC run code pro forma
# For neutral model cluster run

rm(list=ls()) 
dev.off
# Source the function file we need
source("/rds/general/user/pp1922/home/pp1922_HPC_2022_main.R")
#source("pp1922_HPC_2022_main.R")

# Find out the job number:
iter <- as.numeric(Sys.getenv("PBS_ARRAY_INDEX"))
#iter = 1

# Set this as the random seed so that all runs have a unique seed:
set.seed(iter)

#creates dataframe for each size
community_size <- c(500, 1000, 2500, 5000)

#group the iteration into different community sizes
if (iter >= 1 && iter <= 25) size <- community_size[1]
if (iter > 25 && iter <= 50) size <- community_size[2]
if (iter > 50 && iter <= 75) size <- community_size[3]
if (iter > 75 && iter <= 100) size <- community_size[4]

#create a name of output file
if(exists("cluster_run")){print("YES!")}else(print("NO!!"))

#save the file
output <- paste("/rds/general/user/pp1922/home/
                pp1922_simulation_output",iter,".rda",sep = "")

#speciation rate is the personal speciation rate
cluster_run(speciation_rate = 0.40,
            size = size,
            #12 hrs
            wall_time = (11.5*60),
            interval_rich = 1,
            interval_oct = size/10,
            burn_in_generations = 8*size,
            output_file_name = output)