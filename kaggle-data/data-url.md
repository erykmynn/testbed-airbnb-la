https://www.kaggle.com/datasets/wafaaalayoubi/los-angeles-airbnb-data-june-2025


sed 's/\\""/\\u0022/g' old > new


ddev restart; drush migrate:import testbed_airbnb_la_listings --limit=5000

