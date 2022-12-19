# this code will automatically test your answers to some questions
# from the HPC practical coursework from CMEE
# you should keep all the files you would hand in within a folder named with your username
# I've given you the proforma with a placeholder username so you'll obviously need to change that

# Make sure the current working directory is set to the folder containing
# this file before you source it.

rm(list=ls())
test_username <- "pp1922" # this should be your username
year <- 2022
# ======= MARK DATA INITIALISATION ======= #

# make vectors to store the results -1 means that question was not marked yet
final_mark <- seq(-1,-1,length=30)
final_mark_max <- c(2,1,1,2,2,2,2,3,3,1,1,4,3,3,2,4,6,6,10,10,2,2,8,2,2,2,3,4,3,4)
final_comments_main <- list()
final_comments_main[[length(final_mark)+1]] <- "END"

# ======= DEFINE USEFUL FUNCTIONS ======= #

test_data_updated <- function(variable,variable_name,default_value){
  if (!exists(variable_name)){
   return(paste("ERROR: no variable named",variable_name,"workspace might have been wrongly cleared",sep=" "))
  } else { 
    if (variable == default_value) {
      return(paste("ERROR: variable named",variable_name,"was not set correctly",sep=" "))
    } else 
    {
      return(paste(variable_name,"was set to",variable,sep=" "))
    }
  }
} 

test_data_correct <- function(variable,variable_name,expected_value){
  if (!exists(variable_name)){
    return(paste("ERROR: no variable named",variable_name,"workspace might have been wrongly cleared",sep=" "))
  } else { 
    if (variable != expected_value) {
      return(paste("ERROR: variable named",variable_name,"was not set correctly to",expected_value,sep=" "))
    } else 
    {
      return(paste(variable_name,"was set to",variable,sep=" "))
    }
  }
} 

load_student_work <- function(student_username){
  student_file <- paste(student_username,"/",student_username,"_HPC_",year,"_main.R",sep="")
  load_test_data <- list()
  
  if(file_test("-f",student_file)) {
    
    source(student_file)
    load_test_data[[length(load_test_data)+1]] <- "FILE SOURCED"
    
    load_test_data[[length(load_test_data)+1]] <-  test_data_updated(name,"name","James Rosindell")
    load_test_data[[length(load_test_data)+1]] <-  test_data_updated(preferred_name,"preferred_name","James")
    load_test_data[[length(load_test_data)+1]] <-  test_data_updated(email,"email","j.rosindell@imperial.ac.uk")
    load_test_data[[length(load_test_data)+1]] <-  test_data_correct(username,"username",test_username)
  } else {
    load_test_data[[length(load_test_data)+1]] <- "ERROR: no file to source"
  }
  print(load_test_data)
  return(load_test_data)
}

add_comment <- function(question,comment){
  if (length(final_comments_main)<question)
  {
    final_comments_main[[question]] <<- comment
  }
  else {
    if (is.null(final_comments_main[[question]])) {
      final_comments_main[[question]] <<- comment
    } else {
      final_comments_main[[question]] <<- paste( final_comments_main[[question]],comment,sep=", ")
    }
  }
}

# new identical function (identical built in is very sensitive to things that don't matter for marking)
is_identical <- function(ros_x , ros_y){
  if (length(ros_x) != length(ros_y)) {
    return(FALSE)
  } else {
    for (i in 1:(length(ros_y)))
    {
      if (ros_x[i] != ros_y[i])
        return(FALSE)
    }
  }
  return(TRUE)
}

# check that a function exists and provide printed output
basic_test <- function(question,func_name=NULL){
        if (!is.null(func_name))
        {
            if (exists(func_name))
            {
                return(TRUE)
            } else {
                add_comment(question,"missing function for Q")
                final_mark[question] = 0;
                final_done[question] = 1;
                return(FALSE)
            }
        } else {
            return(TRUE)
        }
}

basic_func_test <- function(question, func_input, given_output, correct_output,text_message =""){
  func_input_str <- ""
  if (!is.null(func_input)) 
    {if(length(func_input) == 1) {
    func_input_str <- paste(func_input)
  } else {
    func_input_str <- paste("c(",paste(func_input,collapse=","),")",sep="")
  }}
  
  if (is.null(given_output)) {
    add_comment(question,paste(text_message,func_input_str,"evaluates as null",sep=" "))
    return(FALSE)
  } else {
    if (!is_identical(given_output,correct_output)) {
      add_comment(question,paste(text_message,func_input_str,"evaluates incorrectly"))
      return(FALSE)
    } else {
      return(TRUE)
    }
  }
}

save_to_file <- function(filename){
  write(paste("HPC long practical feedback for",preferred_name,"(",name,")",year,sep=" "), file = filename, append=FALSE)
  write(" ", file = filename, append=TRUE)
  for (i in 1:length(data_from_loading)) {
    write(data_from_loading[[i]], file = filename, append=TRUE)
  }
  
  write(" ", file = filename, append=TRUE)
  write("Marks for main questions", file = filename, append=TRUE)
  for(i in c(1,2,3,13,14,15))
  {
    if (final_mark[i] >= 0)
    {
      if ((length(final_comments_main)>=i)&&(!is.null(final_comments_main[[i]])))
      {
        write(paste("Q",i,":   ",final_mark[i],"/",final_mark_max[i],"   comments:",final_comments_main[[i]]), file = filename, append=TRUE)
        } else {
        write(paste("Q",i,":   ",final_mark[i],"/",final_mark_max[i]), file = filename, append=TRUE)
      }
    } else {
      if ((length(final_comments_main)>=i)&&(!is.null(final_comments_main[[i]])))
      {
        write(paste("Q",i,":   ","?","/",final_mark_max[i],"   comments:",final_comments_main[[i]]), file = filename, append=TRUE)
      } else {
        write(paste("Q",i,":   ","?","/",final_mark_max[i]), file = filename, append=TRUE)
      }
      final_mark[i] <<- 0
    }
    
  }
  
  write(" ", file = filename, append=TRUE)
  write("Remember this test only marks questions 1-3 and 13-15", file = filename, append=TRUE)
}

# ======= load the data ======= #

data_from_loading <- load_student_work(test_username)
save_to_file(paste(test_username,"_HPC_feedback",sep=""))

# ======= test question 1 ======= #
this_question <- 1 # question number
if(basic_test(this_question,'species_richness')){
    final_max <- final_mark_max[this_question] # max mark for this question
    final_mark[this_question] = final_max
    
    test_cases <- list()
    test_answers <- list()

    test_cases[[1]] <- c(1,1,2,3,4,4)
    test_answers[[1]] <- 4
    test_cases[[2]] <- c(1,1,2,3,4,1,1,2,3,2,3,3,4,2,1,1,1)
    test_answers[[2]] <- 4
    test_cases[[3]] <- c(100,101,101,4,4,4,4,4,4,4,4,4,100,101,3,3,3,4,1,1,1,1,2,3,4)
    test_answers[[3]] <- 6
    test_cases[[4]] <- c(2)
    test_answers[[4]] <- 1 
      
   for (i in 1:length(test_cases)) 
   {
      if(!(basic_func_test(this_question,  test_cases[[i]], species_richness(test_cases[[i]]), test_answers[[i]]))) 
      { 
        final_mark[this_question] = final_mark[this_question] -1; 
      }
    }
    
    if (final_mark[this_question] < 0)
    {
      final_mark[this_question] = 0;
    }
}
save_to_file(paste(test_username,"_HPC_feedback",sep=""))


# ======= test question 2 ======= #
this_question <- 2 # question number
if(basic_test(this_question,'init_community_max')){
    final_max <- final_mark_max[this_question] # max mark for this question
    final_mark[this_question] = final_max
    
    if(!(basic_func_test(this_question,  8, init_community_max(8),c(1,2,3,4,5,6,7,8)))) { 
      final_mark[this_question] = final_mark[this_question] -1; 
    }
    if(!(basic_func_test(this_question,  12, init_community_max(12),c(1,2,3,4,5,6,7,8,9,10,11,12)))) { 
      final_mark[this_question] = final_mark[this_question] -1; 
    }
    if(!(basic_func_test(this_question,  2, init_community_max(2),c(1,2)))) { 
      final_mark[this_question] = final_mark[this_question] -1; 
    }
    
    if (final_mark[this_question] < 0)
    {
      final_mark[this_question] = 0;
    }
}
save_to_file(paste(test_username,"_HPC_feedback",sep=""))

# ======= test question 3 ======= #
this_question <- 3 # question number
if(basic_test(this_question,'init_community_min')){
    final_max <- final_mark_max[this_question] # max mark for this question
    final_mark[this_question] = final_max
    
    if(!(basic_func_test(this_question,  5, init_community_min(5),c(1,1,1,1,1)))) { 
      final_mark[this_question] = final_mark[this_question] -1; 
    }
    if(!(basic_func_test(this_question,  10, init_community_min(10),c(1,1,1,1,1,1,1,1,1,1)))) { 
      final_mark[this_question] = final_mark[this_question] -1; 
    }
    if(!(basic_func_test(this_question,  1, init_community_min(1),c(1)))) { 
      final_mark[this_question] = final_mark[this_question] -1; 
    }
    
    if (final_mark[this_question] < 0)
    {
      final_mark[this_question] = 0;
    }
}
save_to_file(paste(test_username,"_HPC_feedback",sep=""))

# ======= test question 13 ======= #
this_question <- 13 # question number
if(basic_test(this_question,'species_abundance')){
  final_max <- final_mark_max[this_question] # max mark for this question
  final_mark[this_question] <- final_max
  
    test_cases <- list()
    test_answers <- list()
    test_cases[[1]] <- (c(1,5,3,6,5,6,1,1))
    test_answers[[1]] <- c(3,2,2,1)
    test_cases[[2]] <- c(1,1,1,5,3,6,5,6,1,1)
    test_answers[[2]] <- c(5,2,2,1)
    test_cases[[3]] <- c(1,1,1,5,3,6,5,6,1,1,6,6,6,6,100)
    test_answers[[3]] <-  c(6,5,2,1,1)
    test_cases[[4]] <- c(1,1,1,5,3,6,5,6,1,1,6,6,6,6,100,101,42)
    test_answers[[4]] <- c(6,5,2,1,1,1,1) 
    
    for (i in 1:length(test_cases)) 
    {
      if(!(basic_func_test(this_question,  test_cases[[i]], species_abundance(test_cases[[i]]), test_answers[[i]]))) 
      { 
        final_mark[this_question] = final_mark[this_question] -1; 
      }
    }
    
    if (final_mark[this_question] < 0)
    {
        final_mark[this_question] = 0;
    }
}
save_to_file(paste(test_username,"_HPC_feedback",sep=""))


# ======= test question 14 ======= #
this_question <- 14 # question number
if(basic_test(this_question,'octaves')){
    final_max <- final_mark_max[this_question] # max mark for this question
    final_mark[this_question] = final_max
    
    test_cases <- list()
    test_answers <- list()
    test_cases[[1]] <- c(100,64,63,5,4,3,2,2,1,1,1,1)
    test_answers[[1]] <- c(4,3,2,0,0,1,2)
    test_cases[[2]] <- c(110,100,64,63,5,4,3,2,2,1,1,1,1)
    test_answers[[2]] <- c(4,3,2,0,0,1,3)
    test_cases[[3]] <- c(2,2,2,1,1,1,1,1,1)
    test_answers[[3]] <-  c(6,3)
    test_cases[[4]] <- c(4,2,2,2,1,1,1,1,1,1)
    test_answers[[4]] <- c(6,3,1)
    
    for (i in 1:length(test_cases)) 
    {
      if(!(basic_func_test(this_question,  test_cases[[i]], octaves(test_cases[[i]]), test_answers[[i]]))) 
      { 
        final_mark[this_question] = final_mark[this_question] -1; 
      }
    }
    
    if (final_mark[this_question] < 0)
    {
        final_mark[this_question] = 0;
    }
}
save_to_file(paste(test_username,"_HPC_feedback",sep=""))

# ======= test question 15 ======= #
this_question <- 15 # question number
if(basic_test(this_question,'sum_vect')){
    final_max <- final_mark_max[this_question] # max mark for this question
    final_mark[this_question] = final_max
    
    if(!(basic_func_test(this_question,  NULL, sum_vect(c(1,3),c(1,0,5,2)), c(2,3,5,2),"sum_vect(c(1,3),c(1,0,5,2))"))) { 
      final_mark[this_question] = final_mark[this_question] -1; 
    }
    if(!(basic_func_test(this_question,  NULL, sum_vect(c(4,42),c(5,1)), c(9,43),"sum_vect(c(4,42),c(5,1))"))) { 
      final_mark[this_question] = final_mark[this_question] -1; 
    }
    if(!(basic_func_test(this_question,  NULL, sum_vect(c(5,9,9,1),c(1,0,0)), c(c(6,9,9,1)),"sum_vect(c(5,9,9,1),c(1,0,0))"))) { 
      final_mark[this_question] = final_mark[this_question] -1; 
    }
    if(!(basic_func_test(this_question,  NULL, sum_vect(c(1000,1),c(0,1,42)), c(1000,2,42),"sum_vect(c(1000,1),c(0,1,42))"))) { 
      final_mark[this_question] = final_mark[this_question] -1; 
    }
    
    if (final_mark[this_question] < 0)
    {
        final_mark[this_question] = 0;
    }
}
save_to_file(paste(test_username,"_HPC_feedback",sep=""))