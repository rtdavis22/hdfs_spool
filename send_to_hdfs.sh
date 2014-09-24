#! /bin/bash

inotifywait -m -e close_write -e moved_to --format "%w%f" /var/spool/to_hdfs | while read f; do
    if [[ $f == *FAIL ]]; then
        continue
    fi
    FILE_NAME=${f##*/}
    HDFS_PATH=hdfs:///${FILE_NAME//\#//}
    hadoop fs -test -e $HDFS_PATH
    if [ $? -ne 0 ]; then
        hadoop fs -mkdir ${HDFS_PATH%/*} 2> /dev/null
        #echo "MOVING $f -> $HDFS_PATH"
        chmod 666 $f
        hadoop fs -copyFromLocal $f $HDFS_PATH
        if [ $? -eq 0 ]; then
            rm $f
        else
            echo "FAILURE"
            mv $f ${f}.FAIL
        fi
    fi
done
