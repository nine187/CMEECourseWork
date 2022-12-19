# CMEE 2022 HPC exercises R code main pro forma
# You don't HAVE to use this but it will be very helpful.
# If you opt to write everything yourself from scratch please ensure you use
# EXACTLY the same function and parameter names and beware that you may lose
# marks if it doesn't work properly because of not using the pro-forma.

rm(list=ls())

name <- "Pasith Prayoonrat"
preferred_name <- "Pasith"
email <- "pp1922@imperial.ac.uk"
username <- "pp1922"

# Please remember *not* to clear the workspace here, or anywhere in this file.
# If you do, it'll wipe out your username information that you entered just
# above, and when you use this file as a 'toolbox' as intended it'll also wipe
# away everything you're doing outside of the toolbox.  For example, it would
# wipe away any automarking code that may be running and that would be annoying!

#personal_speciation_rate <- 0.40

# Question 1
species_richness <- function(community){
  #use length combined with unique the measure the number of each unique number
  return(length(unique(community)))
}

# Question 2
init_community_max <- function(size){
  #generate a sequence from 1 to size input
  x <- (seq(1,size))
  return(x)
}
#init_community_max(5)

# Question 3
init_community_min <- function(size){
  #replicate 1 equal to the number of time the amount of size is given
  x <- (rep(1,size))
  return(x)
}

# Question 4
choose_two <- function(max_value){
  #randomly take 2 numbers from 1-max value, replace = FALSE to avoid having the same number picked
  x <- sample(1:max_value, 2, replace = FALSE)
  return(x)
}

# Question 5
neutral_step <- function(community){
  #pick 2 random position from the community data
  replace <- choose_two(length(community))
  #replace first position in community with the position of the second random position
  community[replace[1]] <- community[replace[2]]
  return(community)
}

# Question 6
neutral_generation <- function(community){
  #community length/2
  generation <- length(community)/2
  #if generation remainder is 2 not equal whole number
  if (generation %% 2 != 0){
    #randomly choose 0-1
    random <- runif(1)
    #if random and more than 0.5
    if (random > 0.5){
      #round up
      ceiling(generation)}
    else{
      #round down if less random less than 0.5
      floor(generation)}
      }
  #use neutral step for 1/2 number of gen time if even or if odd random floor/ceiling
  for (i in 1:generation){
    community <- neutral_step(community)
  }
  return(community)
}

# Question 7
neutral_time_series <- function(community,duration)  {
  #preallocate a vector with species richness
  time_series <- c(species_richness(community))
  # for every duration runs the loop
  for (i in 1:duration){
    #apply the neutral_generation function to the community
    community <- neutral_generation(community)
    #apply the species_richness to the community
    richness <- species_richness(community)
    time_series <- append(time_series, richness)
  }
  return(time_series)
}
#neutral_time_series(community = init_community_max(100), duration = 200) 

# Question 8
question_8 <- function() {
  graphics.off()
  #give the label value
  time_series <- neutral_time_series(init_community_max(100), 200)
  
  png(filename="question_8.png", width = 600, height = 400)
  plot(time_series,
       type = "l",
       xlim = c(0,200),
       ylim = c(0,100),
       ylab = "Species Richness",
       xlab = "Generations",
       main = "Neutral model simulation of 200 generations",
       col = "red")
  Sys.sleep(0.1)
  dev.off()
  
  return("If waited long enough, the system will always convert into a state in which the species richness will be reduced to 1 species while other individual die out. This is because no new replacement exists for the species that disappear from the community.")
}
question_8()

# Question 9
neutral_step_speciation <- function(community,speciation_rate)  {
#randomize a number from 0-1
random <- runif(1)

#choose 2 random pair from community
random_2 <- choose_two(length(community))

#if the randomize number is more than the speciation rate
if (random > speciation_rate){
  #replace one of the random_2 2 numbers with the second one
  community[random_2[1]] <- community[random_2[2]]
} 
#if the randomize number is not less than the speciation rate
else {
  #create a new species +1 the max community value
  new_species <- max(community) + 1
  community[random_2[1]] <- new_species
  }
return(community)
}
#neutral_step_speciation(c(1,1,2), speciation_rate = 0.5)

# Question 10
neutral_generation_speciation <- function(community,speciation_rate)  {
  #assign a random whole number of half the community size + random number
  x <- round((length(community)/2) + runif(1))
  
  #for each number, apply the speciation function
  for (i in 1:x) {
    community <- neutral_step_speciation(community, speciation_rate)
  }
  return(community)
}

#neutral_generation_speciation(c(1,2,3,4,5),(speciation_rate = 0.5))

# Question 11
neutral_time_series_speciation <- function(community,speciation_rate,duration)  {
#find the max value of the community
df <- species_richness(community)
#loop for each duraion
  for (i in 1:duration){
    #apply Q10 function
    community <- neutral_generation_speciation(community, speciation_rate)
    #record the highest community value
    abundance <- species_richness(community)
    #add it to the community
    df <- c(df, abundance)
  }
  return(df)
}
#neutral_time_series_speciation(c(1,1),(speciation_rate=1),duration=10)

# Question 12
question_12 <- function(community = 100, speciation_rate = 0.1, duration = 200)  {
  #clear the graphics
  graphics.off()
  #plot
  png(filename="question_12.png", width = 600, height = 400)
plot(neutral_time_series_speciation(init_community_max(community), speciation_rate, duration),
x.lim = c(0,200),
y.lim = c(0,100),
ylab = "Species Abundance",
xlab = "Generations",
main = "Max Initiation State and Minimum Initial State Over 200 Generations ",
col = "red",
type = "l")
lines(neutral_time_series_speciation(init_community_min(community),speciation_rate,duration),
      col = "blue",
      type = "l")
legend("topright",legend = c("Max initial states","Min initial states"),
       fill = c("red","blue"))
Sys.sleep(0.1)
dev.off()
  return("The plot started at different starting values. The number of species in the max initial state is eventually reduced to the same amount as the min.This is because the speciation rate is set at 0.1 in both models (the same). The rate of extinction is also the same. Both these factors decide the overall equilibrium of the graph.")
}
question_12()

# Question 13
species_abundance <- function(community)  {
  #use table to count each unique number
  group <- table(community)
  #sort the number and return it
  community = as.vector(sort(group, decreasing = TRUE))
  return(community)
}
#species_abundance(c(1,1,1,1,1,1,2,2,2,2,3))

# Question 14
octaves <- function(abundance_vector) {
  return(tabulate(floor(log2(abundance_vector))+1))
}

#Question 15
sum_vect <- function(x, y) {
  #compare both lengths, if x is larger add 0 to y
  if (length(x) > length(y)){
    y = c(y,rep(0,length(x)-length(y)))
    sum= x+y
  #same thing but swap
  } else 
    if(length(x) < length(y)) {
    
    x = c(x,rep(0,length(y)-length(x)))
    sum = x+y
  #if both values are the same just add the vectors
  } else {
    sum = x+y
  }
  return(sum)
}
#sum_vect(c(1,3),c(1,0,5,2)) 

# Question 16 
question_16 <- function()  {
  graphics.off()
  #assign the values
  com_max <- init_community_max(100)
  com_min <- init_community_min(100)
  duration <- 2200
  burnin <- 200
  spec_rate <- 0.1
  # for every item in the burnin apply the neutral_generation_speciation func.
  for (i in 1:burnin){
    com_max<- neutral_generation_speciation(com_max, spec_rate)
    com_min <-neutral_generation_speciation(com_min, spec_rate)}
  #apply the octaves function and store the octaves data
  octaves_max <- octaves(species_abundance(com_max))
  octaves_min <- octaves(species_abundance(com_min))
  #loop the burn in
  for (i in (burnin+1):duration){
    com_max <- neutral_generation_speciation(com_max, spec_rate)
    com_min <- neutral_generation_speciation(com_min, spec_rate)
    #save every 20 gens save the octave
    if (i > burnin & i%%20 == 0){
      octaves_max_temp <- octaves(species_abundance(com_max))
      octaves_min_temp <- octaves(species_abundance(com_min))
      octaves_max <- sum_vect(octaves_max, octaves_max_temp)
      octaves_min <- sum_vect(octaves_min, octaves_min_temp)
    }
  }
  #average
  max_mean <- octaves_max/100
  min_mean <- octaves_min/100
  #min graph
  png(filename="question_16_min.png", width = 600, height = 400)
  barplot(min_mean, 
          xlab= "Abundance Octaves",
          ylab = "Mean Species Number",
          main = "Minimum Initial Community",
          ylim = c(0,12),
          names.arg = seq(1:length(max_mean)),#label the x axis
          col = c("red"))
  Sys.sleep(0.1)
  dev.off()
  #max graph
  png(filename="question_16_max.png", width = 600, height = 400)
  barplot(max_mean, 
          xlab= "Abundance Octaves",
          ylab = "Mean Species Number",
          main = "Maximum Initial Community",
          ylim = c(0, 12),
          names.arg = seq(1:length(min_mean)),
          col = c("blue"))
  Sys.sleep(0.1)
  dev.off()
  return("The system's initial condition does not matter as both graphs are almost identical in distribution pattern. This is because there would always be an equilibrium. The same equilibrium rate is from the same speciation rate and death rate after a while, regardless of the initial conditions.")
}
question_16()

# Question 17
cluster_run <- function(speciation_rate, size, wall_time, interval_rich, 
                        interval_oct, burn_in_generations, output_file_name)  {
  #define the values
  comm <- init_community_min(size)
  #change from minute to seconds
  run_time <- wall_time*60
  #initiate the timer
  t <- proc.time()[[3]]
  #pre-allocate the data frames
  octs <- list()
  richness <- c()
  gen <- 0
  #while when the stimulation time is less than the set time
  while(proc.time()[[3]] - t < run_time){
    gen <- gen + 1
    comm <- neutral_generation_speciation(comm, speciation_rate)
    s_richness <- species_richness(comm)
    if (gen %% interval_rich == 0){
      richness <- c(richness, s_richness)
    }
    if (gen %% interval_oct == 0 ){
      octs[[length(octs) + 1]] <- octaves(species_abundance(comm))
    }
  }
#calculate the total time
end.time <- proc.time()[[3]]
total_time <- (end.time - t)/60
  #save the output
  save(time, octs, comm, total_time, speciation_rate, size, wall_time,
       interval_rich, interval_oct, burn_in_generations, file = output_file_name)
}

# Questions 18 and 19 involve writing code elsewhere to run your simulations on
# the cluster

# Question 20 
process_cluster_results <- function()  {
  #create a list of stimulation output files
  files <- list.files(pattern = "^simulation_.*\\.rda$")
  #pre allocate data frame
  a_500 <- c()
  a_1000 <- c()
  a_2500 <- c()
  a_5000 <- c()
  as_500 <- 0
  as_1000 <- 0
  as_2500 <- 0
  as_5000 <- 0
  #loop every file
  for (i in 1:100){
    load(files[i])
    #compute each size
    if (size == 500){
      #calculate the octaves
      burnin <- burn_in_generations/interval_oct
      #find the length of the generation
      as_500 <- length(oct) - burnin + as_500
      #loop throughh the generation to add all the octaves
            for (j in (burnin + 1):length(oct))
        a_500 <- sum_vect(a_500,oct[[j]])
    }
    #repeat in all sizes
        if (size == 1000){
      burnin <- burn_in_generations/interval_oct
      as_1000 <- length(oct) - burnin + as_1000
      for (j in (burnin + 1):length(oct))
        a_1000 <- sum_vect(a_1000,oct[[j]])
    }
    if (size == 2500){
      burnin <- burn_in_generations/interval_oct
      as_2500 <- length(oct) - burnin + as_2500
      for (j in (burnin + 1):length(oct))
        a_2500 <- sum_vect(a_2500,oct[[j]])
    }
    if (size == 5000){
      burnin <- burn_in_generations/interval_oct
      as_5000 <- length(oct) - burnin + as_5000
      for (j in (burnin + 1):length(oct))
        a_5000 <- sum_vect(a_5000,oct[[j]])
    }
  }
  #find the mean
  mean_500 <- a_500/as_500
  mean_1000 <- a_1000/as_1000
  mean_2500 <- a_2500/as_2500
  mean_5000 <- a_5000/as_5000
  #create a combined list
  combined_results <- list(mean_500, mean_1000, mean_2500, mean_5000)
  # save to .rda file
  save(combined_results, file = "combined_results.rda")
}
#process_neutral_cluster_results()

plot_neutral_cluster_results <- function()  {
 #clear graphic
  graphics.off()
  #load the data
  load("combined_results.rda")
  png(filename="plot_neutral_cluster_results.png", width = 600, height = 400)
  par(mfrow= c(2,2))
  #plot the barplot of each population size
  barplot(combined_results[[1]],
          xlab = "Abundance Octaves Numbers",
          ylab = "Mean Species",
          main = "1. Community Size 500",
          ylim = c(0, 250),
          names.arg = seq(1:length(combined_results[[1]])),
          col = "red")
  barplot(combined_results[[2]],
          xlab = "Abundance Octaves Numbers",
          ylab = "Mean Species",
          main = "2. Comminity Size 1000",
          names.arg = seq(1:length(combined_results[[2]])),
          col = "blue")
  barplot(combined_results[[3]],
          xlab = "Abundance Octaves Numbers",
          ylab = "Mean Species",
          main = "3.Community Size 2500",
          ylim = c(0,1200),
          names.arg = seq(1:length(combined_results[[3]])),
          col = "green")
  barplot(combined_results[[4]],
          xlab = "Abundance Octaves Numbers",
          ylab = "Mean Species",
          main = "4.Community Size 5000",
          names.arg = seq(1:length(combined_results[[4]])),
          col = "orange")
  #title
  mtext("Average Species Abundance in each Community Size from the Simulation", 
        side = 3,
        line = - 1,
        outer = TRUE)
  Sys.sleep(0.1)
  dev.off()
  return(combined_results)
}
plot_neutral_cluster_results()

####################################SECTION 2###################################

# Question 21
state_initialise_adult <- function(num_stages, initial_size){
  x <- c(rep(0, num_stages -1), initial_size)
  return(x)
}

# Question 22
state_initialise_spread <- function(num_stages, initial_size){
  x <- initial_size/num_stages
  y <- c(rep(x, num_stages))
  #if there is a remainders
  if (initial_size %% num_stages != 0){
    x <- floor(initial_size/num_stages)
    y <- c(rep(x, num_stages))
    r <- initial_size %% num_stages
    r_vect <- c(rep(1, r), rep(0, num_stages - r))
    y <- y + r_vect
  }
  return(y)
}
# Question 23
deterministic_step <- function(state,projection_matrix){
    ##%*% is for matrix multiplication
    new_state <- (projection_matrix%*%state)
    #make it a vector
    new_state <- c(new_state)
    return(new_state)
  }

# Question 24
deterministic_simulation <- function(initial_state,projection_matrix,simulation_length){
  #pre allocate data frame
    population_size <- c(sum(initial_state))
    #do this for every simulation length
  for (i in 1:simulation_length){
    #use deterministic step to multiply the matrices
    initial_state <- deterministic_step(initial_state, projection_matrix)
    #add the first pop size as the first number and add all the states 
    # to the pop siz vector
    population_size <- c(population_size, sum(initial_state))
  }
  return(population_size)
}

# Question 25
question_25 <- function(){
  projection_matrix <- matrix(c(0.1, 0.6, 0.0, 0.0,
                                0.0, 0.4, 0.4, 0.0,
                                0.0, 0.0, 0.7, 0.25,
                                2.6, 0.0, 0.0, 0.4),nrow=4,ncol=4)
  #assign the simulation length
  simulation_length = 24
  #create the 2 initial conditions (need the 2nd one to be evenly spread?)
  i_cond1 <- state_initialise_adult(4,100)
  i_cond2 <- state_initialise_spread(4,100)
  #loop each simulation
  graph_1 <- deterministic_simulation(i_cond1, projection_matrix, simulation_length)
  graph_2 <- deterministic_simulation(i_cond2, projection_matrix, simulation_length)
  #plotting
  png(filename="question_25.png", width = 600, height = 400)
  plot(graph_1,
       type = "l",
       ylim = c(0,1200),
       xlab = "Simulation Length",
       ylab = "Population Size",
       main = "Deterministic Simulation of 2 Different Populations after 24 Rounds",
       col = "red")
  lines(graph_2,
        type = "l",
        col = "blue")
  legend(x = "topright",
         legend=c("100 Adults Starting Population", "100 Evenly Spread Population"),
         fill = c("red","blue"))
  Sys.sleep(0.1)
  dev.off()
  return("In the population with 100 starting adults, the population increases initially, then eventually drops down and stabilizes at a higher rate than the 100 evenly distributed initial population. ")
}
question_25()

# Question 26
trinomial <- function(pool,probs) {
  #if prob =1, return the vector
  if (probs[1] == 1){
    return(c(pool, 0, 0))
  }
  else {
    #use rbinom to calcuate the probability, staying probability
    e_1 <- rbinom(1, pool, probs[1])
    #use the probabilty from the worksheet and rbinom, maturing probability
    e_2 <- rbinom(1, pool - e_1, probs[2]/(1-probs[1]))
    #dead-minus from other 2 events
    e_3 <- pool - e_1 - e_2
    return(c(e_1, e_2, e_3))
  }
}

# Question 27
survival_maturation <- function(state,projection_matrix) {
  #initialize new state vector
  new_state <- c(rep(0, length(state)))
  for (i in 1:(length(state)-1)){
    #how many individuals are in stage i
    current <- state[i]
    # probability of staying
    s_prob <- projection_matrix[i, i]
    #probability of maturing
    m_prob <- projection_matrix[i+1, i]
    next_stage <- trinomial(current, c(s_prob, m_prob))
    #identify the entries in new state the individuals belong to
    #stay
    new_state[i]<- new_state[i] + next_stage[1]
    #mature
    new_state[(i+1)]<- new_state[(i+1)] + next_stage[2]
  }
  #generate the individuals that survived in the last stage
  if(projection_matrix[length(state), length(state)] == 1){
    new_state[length(state)] <- new_state[length(state)] + state[length(state)]
  }
  else{
    new_state[length(state)] <- new_state[length(state)] + rbinom(1, state[length(state)], projection_matrix[length(state), lengths(state)])
  }
  return(new_state)
}

# Question 28
random_draw <- function(probability_distribution) {
#for every item in in length of the probability_distribution, loop
for (i in 1:length(probability_distribution)){
  #if the cumulative probability of i is more than the random number break the 
  #loop and return the value
  if (runif(1,0,1) < cumsum(probability_distribution[i])){break}
  else{next}
  }
  return(i)
}
#random_draw(probability_distribution = c(0,0.25,0.75))

# Question 29
stochastic_recruitment <- function(projection_matrix,clutch_distribution){
  #calculate the mean clutch size
  mean_clutch_size <- sum(clutch_distribution * 1:length(clutch_distribution))
  #calculate the recruitment probabilty
  recruitment_prob <- projection_matrix[1,ncol(projection_matrix)] / mean_clutch_size
  return(recruitment_prob)
}

# Question 30
offspring_calc <- function(state,clutch_distribution,recruitment_probability){
  #calculate the matrix in each state
    #identify the number of adult in the state (the last number)
    num_adult <- state[length(state)]
    #generate the number of adult that recruits
    no_recruit_adults <- rbinom(1, num_adult, recruitment_probability)
    total_offspring <- 0
    #if there is a recruiting adult
    if (no_recruit_adults > 0){
      for (i in 1:round(no_recruit_adults)){
        #use random draw to determine the clutch size
        total_offspring <- total_offspring + random_draw(clutch_distribution)
      }
    }
    return(total_offspring)
}
#offspring_calc(state=c(1,2,3), clutch_distribution = c(0.3,0.3,0.4), recruitment_probability = 0.75)

# Question 31
stochastic_step <- function(state,projection_matrix,clutch_distribution,recruitment_probability){
  #surivial and maturation
  new_state<- survival_maturation(state, projection_matrix)
  #recruitment
  recruits <- offspring_calc(state, clutch_distribution, recruitment_probability)
  new_state[1] <- new_state[1] + recruits
  return(new_state)
}
#Question 32
stochastic_simulation <- function(initial_state, projection_matrix, clutch_distribution, simulation_length){
  #calculate the recruitment probability
  recruitment_probability <- stochastic_recruitment(projection_matrix, clutch_distribution)
  #preallocate dataframe
  population_size <- rep(NA, simulation_length)
  state <- initial_state
  for (i in 1:simulation_length){
    #if population size reach 0
    if( round(sum(state)) > 0){
      state <- stochastic_step(state, projection_matrix, clutch_distribution, recruitment_probability)
      #add the population size
      population_size[i] <- sum(state)
    }
    #fill in 0
    else {population_size[i] <- 0}
  }
  #update the population size
  population_size <- c(sum(initial_state), population_size)
  return(population_size)
}

# Question 33
question_33 <- function(){
  #assign the initial conditions
  #assign the simulation length
  projection_matrix <- matrix(c(0.1, 0.6, 0.0, 0.0,
                                0.0, 0.4, 0.4, 0.0,
                                0.0, 0.0, 0.7, 0.25,
                                2.6, 0.0, 0.0, 0.4),nrow=4,ncol=4)
  clutch_distribution <- c(0.06,0.08,0.13,0.15,0.16,0.18,0.15,0.06,0.03)
  simulation_length = 24
  # creates 2 initial conditions
  i_cond1 <- state_initialise_adult(4,100)
  i_cond1_popsize <- stochastic_simulation(initial_state=i_cond1,projection_matrix,
                                         clutch_distribution,simulation_length)
  i_cond2 <- state_initialise_spread(4,100)
  i_cond2_popsize <- stochastic_simulation(initial_state = i_cond2,projection_matrix,
                                         clutch_distribution,simulation_length)
  
  #plotting
  png(filename="question_33.png", width = 600, height = 400)
  plot(i_cond1_popsize,
       ylab = "Population Size",
       xlab = "Simulation Length",
       main = "Stochastic Simulation of 2 Different Populations after 24 Rounds",
       col = "red",
       type = "l",
       ylim = c(0,400))
  lines(i_cond2_popsize,
        col = "blue",
        type = "l")
  legend(x = "topright",
         legend=c("100 Adults Starting Population", "100 Evenly Spread Population"),
         fill = c("red","blue"))
  Sys.sleep(0.1)
  dev.off()
  
  return("The stochastic model has a high level of fluctuation and less smoothness compared to the deterministic model. This might be due to the nature of the stochastic model in which it calculates a new probability for each individual at every step, giving the graph a more wobbly look. This mode reflects real-life situations better.")
}
question_33()

  # Questions 34 and 35 involve writing code elsewhere to run your simulations on the cluster

# Question 36
question_36 <- function(){
  #create a list of file output in section 2 cluster
  files <- list.files(pattern = "section2_*.")

  #preallocate the dataframe
  iter_250 <- c()
  iter_500 <- c()
  iter_750 <- c()
  iter_1000 <- c()
  extinction_250 <- rep(0, 250)
  extinction_500 <- rep(0, 250)
  extinction_750 <- rep(0, 250)
  extinction_1000 <- rep(0, 250)

  #loop through the files
    #figure out how many extinction occur in this initial condition
    #if there is 0 in the population size
    for (i in 1:250){
      load(files[i])
      {iter_250 <- pop_size
      if (min(iter_250) == 0 ){
        extinction_250[i] <- 1}}
    }
  
  for (i in 251:500){
    load(files[i])
    {iter_500 <- pop_size
      if (min(iter_500) == 0) {
        extinction_500[i-250] <- 1}}
  }
  
  for (i in 501:750){
    load(files[i])
    {iter_750 <- pop_size
      if (min(iter_750) == 0)
    extinction_750[i-500] <- 1}
  }
  
  for (i in 751:1000){
    try(load(files[i]))
    {iter_1000 <- pop_size
      if (min(iter_1000) == 0)
        extinction_1000[i-750] <- 1}
  }
  
  #calculate the proportion
  proportion_250 <- (sum(extinction_250))/250
  proportion_500 <- (sum(extinction_500))/250
  proportion_750 <- (sum(extinction_750))/250
  proportion_1000 <- (sum(extinction_1000))/250
  
  #graph showing the proportion of stochastic simulations result in extinction
  #for each initial condition
  png(filename="question_36.png", width = 600, height = 400)
  barplot(height = c(proportion_250,proportion_500,proportion_750,proportion_1000),
          names.arg = c("Adult,large", "Adult,small", "Spread,large", "Spread,small"),
          ylab = "Extincted Population Proportion",
          xlab = "Initial Condition",
          ylim = c(0,0.45),
          col = "blue",
          main = "Proportion of stochastic simulations which resulted in extinction",
          axes = TRUE,
          xpd = TRUE,
          border = par("fg"))
  # plot your graph here
  Sys.sleep(0.1)
  dev.off()
  return("According to this barplot, the small population that is evenly spread is the most likely to go extinct. This might be because the population is spread across rather than being in the adult stage which can reproduce. Also, due to its being a small population, the population has a higher chance of extinction(zero population size) due to its lower population size.")
}
question_36()

# Question 37
question_37 <- function(){
  #assign projection matrix and simulation length
  projection_matrix <- matrix(c(0.1, 0.6, 0.0, 0.0,
                                0.0, 0.4, 0.4, 0.0,
                                0.0, 0.0, 0.7, 0.25,
                                2.6, 0.0, 0.0, 0.4),nrow=4,ncol=4)
  simulation_length <- 120
  cond_3 <- state_initialise_spread(4,100)
  cond_4 <- state_initialise_spread(4,10)
  
  #create a list of file output in section 2 cluster
  files <- list.files(pattern = "section2_*.")
  
  #preallocate dataframe
  iter_750 <- c()
  iter_1000 <- c()
  pop_stochastic_large <- 0
  pop_stochastic_small <- 0
  
  ########large############
  #identify the appropriate population size result
  for (i in 501:750){
    load(files[i])
    #compute the mean population size(population trend) at each step
    iter_750 <- pop_size
    pop_stochastic_large <- pop_stochastic_large + iter_750
  }
  mean_pop_3 <- pop_stochastic_large/250
  
  #compute the population size time series using deterministic simulation
  large_d <- deterministic_simulation(cond_3, projection_matrix, simulation_length)
  
  #############small###########
  #there were issues with the file #99* something so i removed it
  for (i in 750:995){
    load(files[i])
    #compute the mean population size(population trend)
    iter_1000 <- pop_size
    pop_stochastic_small <- pop_stochastic_small + iter_1000
  }
  #divide by the number of files excluding the problematic ones
  mean_pop_4 <- pop_stochastic_small/245
  
  #compute the population size time series using deterministic simulation
  small_d <- deterministic_simulation(cond_4, projection_matrix, simulation_length)
  
  ##############plotting#############
  #large
  png(filename="question_37_large.png", width = 600, height = 400)
  plot(mean_pop_3,
       type = "l",
       col = "blue",
       xlab = "Simulation length",
       ylab = "Population",
       main = "Deterministic and averaged stochastic behavior \n model comparison in a large population",
       ylim = c(0,2000))
  lines(large_d,
       type = "l",
       col = "red")
  legend("topright", fill = c("blue", "red"), 
         legend = c("stochastic model", "deterministic model"))
  Sys.sleep(0.1)
  dev.off()
  
  #small
  png(filename="question_37_small.png", width = 600, height = 400)
  plot(mean_pop_4,
       type = "l",
       col = "blue",
       xlab = "Simulation length",
       ylab = "Population",
       main = "Deterministic and averaged stochastic behavior \n model comparison in a small population",
       ylim = c(0,500))
  lines(small_d,
        type = "l",
        col = "red")
  legend("topright", fill = c("blue", "red"), 
         legend = c("stochastic model", "deterministic model"))
  Sys.sleep(0.1)
  dev.off()
  
  return("It is appropriate to approximate the average behavior of the stochastic system when the sample size is significantly large, as there is a lower penalty for error in which the deterministic models would amplify compared to the stochastic model. This could result in a higher inaccurate result. If the sample size is small, we should not approximate the average behavior, and in more spread out data, we should not average as well because the sample size is smaller.")
}

question_37()


  # Challenge questions - these are optional, substantially harder, and a maximum
# of 14% is available for doing them. 

# Challenge question A
Challenge_A <- function() {
  #clear graphic
  graphics.off()
  #assign the values
  com_max <- init_community_max(100)
  com_min <- init_community_min(100)
  duration <- 2200
  burnin <- 200
  spec_rate <- 0.1
  
  
  png(filename="Challenge_A_min", width = 600, height = 400)
  # plot your graph here
  Sys.sleep(0.1)
  dev.off()
  
  png(filename="Challenge_A_max", width = 600, height = 400)
  # plot your graph here
  Sys.sleep(0.1)
  dev.off()

}

# Challenge question B
Challenge_B <- function() {
  
  
  
  png(filename="Challenge_B", width = 600, height = 400)
  # plot your graph here
  Sys.sleep(0.1)
  dev.off()

}

# Challenge question C
Challenge_C <- function() {
  #clear graphic
  graphics.off()
  browser()
  files <- list.files(pattern = "pp1922_simulation_output*.")
  
  #preallocate the dataframe

  png(filename="Challenge_C", width = 600, height = 400)
  # plot your graph here
  Sys.sleep(0.1)
  dev.off()
}

# Challenge question D
Challenge_D <- function() {
  #clear graphics
  graphics.off()
  #a-d
  N = J
  lineages <- rep(1,J)
  abundance <- as.vector(length(0))
  theta = theta <- v * (J-1) / (1-v)
  
  #e: choose an index j for vector lineages at random using uniform distribution
  #use punif for unifrom distribution
  lineages <- punif(j, min = 0, max = 1)
  #pick a random decimal using randnum b/w 0-1
  #what is this function, look over it later if have time
  randnum
  
  png(filename="Challenge_D", width = 600, height = 400)
  # plot your graph here
  Sys.sleep(0.1)
  dev.off()
  
  return("type your written answer here")
}

# Challenge question E
Challenge_E <- function(){
  #assign the values
  clutch_distribution <- c(0.06, 0.08, 0.13, 0.15, 0.16, 0.18, 0.15, 0.06, 0.03)
  projection_matrix <- matrix(c(0.1, 0.6, 0.0, 0.0,
                                0.0, 0.4, 0.4, 0.0,
                                0.0, 0.0, 0.7, 0.25,
                                2.6, 0.0, 0.0, 0.4), nrow = 4, ncol = 4)
  simulation_length <- 24
  init_adults <- state_initialise_adult(num_stages = 4, initial_size = 100)
  init_mixed <- state_initialise_spread(num_stages = 4, initial_size = 100)
  
  #preallocate df, life is mean....
  mean_life_adult <- rep(0,24)
  mean_life_mixed <- rep(0,24)
  
  #loop through each population time 24 times
  for (i in 1:24){
    
  #apply the stochastic function
  init_adults_pop <- stochastic_simulation(init_adults,projection_matrix,
                                           clutch_distribution,i)
  init_mixed_pop <- stochastic_simulation(init_mixed ,projection_matrix,
                                          clutch_distribution,i)
  
  #find the mean life stage at that time in both 
    for (i in length(init_adults_pop)){
  mean_life_adult[i] <- ((init_adults_pop[i]*i)*length(init_adults_pop))/sum(init_adults_pop)
    }
    for (i in length(init_mixed_pop)){
      mean_life_mixed[i] <- ((init_mixed_pop[i]*i)*length(init_mixed_pop))/sum(init_mixed_pop)
    }
  }

  png(filename="Challenge_E", width = 600, height = 400)
  plot(mean_life_adult,
      type = "l",
      col = "blue",
      xlab = "simulation length",
      ylab = "mean of the life stages",
      main = "Mean life stage of initial adult and initial mixed",
      xlim = c(0,40))
  lines(mean_life_mixed,
        type = "l",
        col = "red")
  legend("topright", fill = c("blue", "red"), 
         legend = c("mean initial adult", "mean initial spread"))
  Sys.sleep(0.1)
  dev.off()
  
  return("The graph does not differ that much (probably because it is wrong). 
         However, the mean initial seems to have a slightly lower mean which 
         might inidicate that there are lower number of population in that
         dataset.")
}
Challenge_E()
# Challenge question F
library(ggplot2)
Challenge_F <- function(){
  #assign values
  initial_condition <- c()
  time_step <- c()
  simulation_size <- 120
  simulation_number <- 1:1000
  population_size <- c()
  
  #create the main df
  population_size_df <- data.frame(c(simulation_number))
  #load files
  files <- list.files(pattern = "section2_*.")
  #loop through all files(except the last 5 which are problematic..)
  for (i in 1:995){
    load(files[i])
    for (j in 0:simulation_size){
      
    }
    
  }
  #loop
  
  png(filename="Challenge_F", width = 600, height = 400)
  geom_line(aes(x=time_step, y=population_size, group=simulation_number, colour=initial_state))
  Sys.sleep(0.1)
  dev.off()
  
}
