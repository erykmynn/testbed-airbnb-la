# Data Testbed

This is a preconfigured [Drupal](https://drupal.org) setup designed to import a real-world based [Kaggle](https://www.kaggle.com/) data set for experimental development, feature testing, etc.

This testbed features **~45k AirBnb Listings in Los Angeles.**

I set this up so as to have realistic data to pilot vector search, chatbot, geovisualization (contains lat/long), and data analysis and display technologies on top of Drupal.

## Contact
If you have questions or ideas please use the message and issue options here on github or find me on Drupal Slack as: `@erykmynn`

# Prerequisites
- [Composer](https://getcomposer.org/doc/00-intro.md#installation-linux-unix-macos)
- [DDEV](https://docs.ddev.com/en/stable/users/install/ddev-installation/)
- [A Docker Provider](https://docs.ddev.com/en/stable/users/install/docker-installation/) (I'm using Rancher)
*You can also likely install these through your package manager, including Brew on Mac. You could use another local dev container system or virtual machine if so inclined.*

# Getting Started
- Clone this repository or a fork of it. **Recommended to fork unless you are just kicking the tires or working on the base install itself.**

## Install preconfigured Drupal
(From the repo's root directory)
Install all composer dependecies, contrib modules, etc:
```
composer install
```

Start DDEV
```
ddev start
```

Install Drupal using the existing config files:
```
ddev drush site:install --existing-config
```
*Drush will provide an admin username and password.*

# Data setup

## Data Prep
- Visit <https://www.kaggle.com/datasets/wafaaalayoubi/los-angeles-airbnb-data-june-2025> and download the source data (registration may be required).
- Unzip if necessary.
- Ensure the `.csv` file is placed in `kaggle-data/` directory.
- **Important:**Run the following shell script to clean broken encoding in the importable CSVs (command shown at repo root):
```
sed 's/\\""/\\u0022/g' kaggle-data/listings.csv > kaggle-data/listings-corrected.csv
```

## Data Import

There are two ways to go about this.
- Break it up to avoid MYSQL dropout
- Just go for it and hope your setup makes it all the way through

### Partial-Restart Script
 I was running into `MYSQL has gone away` errors if I tried to import it in one go, so instead did 5000 records at a time then restarted ddev. I oroginally did this by executing `ddev restart; drush migrate:import testbed_airbnb_la_listings --limit=5000
` repleatedly, but **you can execute this as a script** (command shown from repo root):
```
kaggle-data/safe-import-restart.sh
```

### Full import
If you feel comfortable running the whole import in one pass, you can try:
```
ddev drush migrate:import testbed_airbnb_la_listings
```

# Next Steps

**Have fun!** Try stuff on top of here. I'm curious how a testbed like this is useful. Drop me a line!

## To-dos
- **Configure display layer minimally:** I don't want to base install here to be very opinionated about how to display this info (hide/show, etc) but in some cases basic defaults need to be set up so it's at least navigable when used for it's other testing purposes. For example it could use some basic teaser displays to make lists usable, and maybe some collapsing/group of extensive related data fields. 