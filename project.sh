#!/bin/bash

syslogfile=/var/log/syslog
logfile=/tmp/grandmasteranalyzerlog.log
patternfile=~/Desktop/pattern.txt
resultfile=~/Desktop/analysisresult.txt
errors_found_with_specific_patterns=0
errorlinesfound=0

grep -oEf $patternfile $syslogfile > $logfile

IFS=$'\n'

for line in $(cat "$logfile")
do

if echo "$line" | grep -q "Failed to fetch"; then
((errors_found_with_specific_patterns++))
echo "Failure to fetch a repository, this is error #$errors_found_with_specific_patterns" > $resultfile

elif echo "$line" | grep -q "Failed to stop"; then
((errors_found_with_specific_patterns++))
echo "Failure to stop a proccess/service, this is error #$errors_found_with_specific_patterns" >> $resultfile

elif echo "$line" | grep -q "Failed to initialize"; then
((errors_found_with_specific_patterns++))
echo "Failed to start a process/services, this is error #$errors_found_with_specific_patterns" >> $resultfile

elif echo "$line" | grep -q "Failed to start application"; then
((errors_found_with_specific_patterns++))
echo "Failed to start a specific software/system applicaation, this is error #$errors_found_with_specific_patterns" >> $resultfile

elif echo "$line" | grep -q "Failed to register client"; then
((errors_found_with_specific_patterns++))
echo "Failed to register a client application inside the system, this is error #$errors_found_with_specific_patterns" >> $resultfile

elif echo "$line" | grep -q "couldnt check support for device"; then
((errors_found_with_specific_patterns++))
echo "Couldn't check support for a driver, this is error #$errors_found_with_specific_patterns" >> $resultfile

elif echo "$line" | grep -q "Failed to parse saved session file"; then
((errors_found_with_specific_patterns++))
echo "Failed to read user session file mid-usage, this is error #$errors_found_with_specific_patterns" >> $resultfile

elif echo "$line" | grep -q "Unable to acquire varlink connection"; then
((errors_found_with_specific_patterns++))
echo "Failed to acquire a varlink connections, this is error #$errors_found_with_specific_patterns" >> $resultfile

elif echo "$line" | grep -q "unable to update icon"; then
((errors_found_with_specific_patterns++))
echo "Failed to update some icon, this is error #$errors_found_with_specific_patterns" >> $resultfile

fi

errorlinesfound=$(($errorlinesfound + 1))
done

echo "" >> $resultfile
echo "" >> $resultfile

echo "total number of errors found with predefined pattern: $errorlinesfound" >> $resultfile
echo "total number of detected errors using specific patterns: $errors_found_with_specific_patterns" >> $resultfile

cat $resultfile

echo ""
echo ""
echo "This log file will be saved at: $resultfile"


