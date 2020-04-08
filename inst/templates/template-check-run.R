con <- file(%LOGFILE%)
sink(con, append=TRUE)
sink(con, append=TRUE, type="message")

# This will echo all input and not truncate 150+ character lines...
source(paste0(%FILENAME%), echo=TRUE, max.deparse.length=10000)

# Restore output to console
sink() 
sink(type="message")

# Create timestamped file:
sink(file = %RESULT%)
cat("File completed without error:\n")
cat(%TIME%)
cat("\n")
sink(file = NULL)
