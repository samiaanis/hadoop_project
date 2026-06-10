#!/bin/bash

set -e

DB_HOST="13.42.152.118"
DB_PORT="5432"
DB_NAME="testdb"
DB_USER="admin"
DB_PASS="admin123"

HDFS_DIR="/tmp/tfl_project_hadoop"

echo "======================================="
echo "Starting PostgreSQL Full Load"
echo "======================================="

hdfs dfs -mkdir -p $HDFS_DIR

# dim_networks_full_load
sqoop import \
--connect jdbc:postgresql://$DB_HOST:$DB_PORT/$DB_NAME \
--username $DB_USER \
--password $DB_PASS \
--query "SELECT * FROM aparna.dim_networks_full_load WHERE \$CONDITIONS" \
--split-by network_id \
--target-dir $HDFS_DIR/dim_networks_full_load \
--delete-target-dir \
-m 1

# dim_lines_full_load
sqoop import \
--connect jdbc:postgresql://$DB_HOST:$DB_PORT/$DB_NAME \
--username $DB_USER \
--password $DB_PASS \
--query "SELECT * FROM aparna.dim_lines_full_load WHERE \$CONDITIONS" \
--split-by line_id \
--target-dir $HDFS_DIR/dim_lines_full_load \
--delete-target-dir \
-m 1

# dim_stations_full_load
sqoop import \
--connect jdbc:postgresql://$DB_HOST:$DB_PORT/$DB_NAME \
--username $DB_USER \
--password $DB_PASS \
--query "SELECT * FROM aparna.dim_stations_full_load WHERE \$CONDITIONS" \
--split-by station_id \
--target-dir $HDFS_DIR/dim_stations_full_load \
--delete-target-dir \
-m 1

# dim_date_full_load
sqoop import \
--connect jdbc:postgresql://$DB_HOST:$DB_PORT/$DB_NAME \
--username $DB_USER \
--password $DB_PASS \
--query "SELECT * FROM aparna.dim_date_full_load WHERE \$CONDITIONS" \
--split-by date_id \
--target-dir $HDFS_DIR/dim_date_full_load \
--delete-target-dir \
-m 1

# fact_station_lines_full_load
sqoop import \
--connect jdbc:postgresql://$DB_HOST:$DB_PORT/$DB_NAME \
--username $DB_USER \
--password $DB_PASS \
--query "SELECT * FROM aparna.fact_station_lines_full_load WHERE \$CONDITIONS" \
--split-by station_line_id \
--target-dir $HDFS_DIR/fact_station_lines_full_load \
--delete-target-dir \
-m 1

# fact_passenger_entry_exit_full_load
sqoop import \
--connect jdbc:postgresql://$DB_HOST:$DB_PORT/$DB_NAME \
--username $DB_USER \
--password $DB_PASS \
--query "SELECT * FROM aparna.fact_passenger_entry_exit_full_load WHERE \$CONDITIONS" \
--split-by entry_exit_id \
--target-dir $HDFS_DIR/fact_passenger_entry_exit_full_load \
--delete-target-dir \
-m 1

echo "======================================="
echo "All imports completed successfully!"
echo "======================================="

hdfs dfs -ls $HDFS_DIR
