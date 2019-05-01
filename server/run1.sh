#export http_proxy=http://35.189.157.110:8888
#export https_proxy=http://35.189.157.110:8888
FACT_DATA_PATH=/mnt/factorio-1-0.17
FACT_EXECUTABLE_PATH=$FACT_DATA_PATH/bin/x64/
$FACT_EXECUTABLE_PATH/factorio --start-server-load-latest --executable-path $FACT_EXECUTABLE_PATH --server-settings $FACT_DATA_PATH/data/server-settings.json
