##### This script uses inotifywait to listen for files added to /var/spool/to_hdfs/ and copies them to HDFS.

The components of the desired HDFS path should be separated by #s. For example, if the file name is logs#a#b.txt, it will be placed in /logs/a/b.txt in HDFS.

Note that a new VM is started up for each file copy so this isn't a terribly efficient ingestion mechanism.

Also make sure the user running the script has read/write permissions for the spool directory and the necessary HDFS locations.
