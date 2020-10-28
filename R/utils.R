# Run the latest emulator function

run_emulator <- function(R0, E, I, R) {
  
  reticulate::virtualenv_create(envname = 'python3_env', 
                                python = "python3")
  
  reticulate::virtualenv_install(
    envname = 'python3_env',
    packages = c('numpy', 'pandas', 'sklearn')
  )
  
  reticulate::use_virtualenv('python3_env', required = TRUE)

  reticulate::source_python("inst/app/www/emulator.py")
  # 
  out <- emulator(list(0,R0, E, I, R)) %>% tidyr::pivot_longer(cols = dplyr::everything()) %>% tibble::deframe()
  # ans <-  system(paste("python3  ", "inst/app/www/emulator.py", 1,2000,2000,300000), intern = TRUE)
  # out <-  as.numeric(strsplit(ans[2], "  ")[[1]][-1])
  # 
  # # Now produce the predictions
  # names(out) <-  c("q5", "q10", "q25", "q50", "q75", "q90", "q95")
  # 
  # # Check for weird values - i.e. not in order
  # if(any(diff(order(out))<0)) warning('Some values not in correct order - more emulator runs required')
  # 
  # return(out)
}

write_date_calendar <- function(img_path, path = NULL, month, day, year){
  img <- magick::image_read(img_path)
  
  img <- img %>% 
    magick::image_annotate(
      month,
      size = 170,
      gravity = "center",
      location = "-0-300",
      color = "white"
    ) %>% 
    magick::image_annotate(
      day,
      size = 280,
      gravity = "center",
      location = "-0+50"
    ) %>% 
    magick::image_annotate(
      year,
      size = 190,
      gravity = "center",
      location = "-0+250"
    ) 
  
  if(!is.null(path)){
    img <- img %>% 
      magick::image_write(path)
  }
    img
}