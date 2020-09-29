# Run the latest emulator function

run_emulator <- function(R0, E, I, R) {
  
  ans <-  system(paste("python3  ", system.file("app/www/emulator.py",package = "hamiltonHowlong"), R0, E, I, R), intern = TRUE)
  out <-  as.numeric(strsplit(ans[3], "  ")[[1]][-1])
  
  # Now produce the predictions
  names(out) <-  c("q5", "q10", "q25", "q50", "q75", "q90", "q95")
  
  # Check for weird values - i.e. not in order
  if(any(diff(order(out))<0)) warning('Some values not in correct order - more emulator runs required')
  
  return(out)
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