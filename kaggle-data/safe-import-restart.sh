#!/bin/bash

# ---  Configuration Variables ---
MIGRATE_ID="testbed_airbnb_la_listings"
LIMIT=2500
TOTAL_RUNS=20
# -------------------------------
# Exit immediately if any command fails (Crucial for failure handling)
set -e

echo "Starting migration for: ${MIGRATE_ID}"
echo "Running ${TOTAL_RUNS} batches of ${LIMIT} items each."
echo "Will restart DDEV after every batch to avoid errors."
echo "-------------------------------------"

   ddev restart
for i in $(seq 1 $TOTAL_RUNS); do
   echo "starting $i of $TOTAL_RUNS runs (--limit=$LIMIT)"
   ddev drush migrate:import "${MIGRATE_ID}" --limit="${LIMIT}"
   ddev restart
done

echo "Sequence of $TOTAL_RUNS runs complete"