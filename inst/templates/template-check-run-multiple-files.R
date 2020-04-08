con <- file(%LOGFILE%)
sink(con, append=TRUE)
sink(con, append=TRUE, type="message")

# Load file list:
files <- readLines(con = %FILELIST%)

# This will echo all input and not truncate 150+ character lines...
for(file in files){
  cat("Running code for file: ")
  cat(file)
source(paste0(file), echo=TRUE, max.deparse.length=10000)
}
# Restore output to console
sink()
sink(type="message")

# Create timestamped file:
sink(file = %RESULT%)
cat("File completed without error:\n")
cat(%TIME%)
cat("\n")
sink(file = NULL)
