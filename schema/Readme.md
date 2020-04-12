Create database first

create database eu_soccer;

IMPORT USING THE FOLLOWING COMMAND (inside /schema directory)

sudo mysql -u root -p eu_soccer < soccer.sql [linux]
mysql -u root -p eu_soccer < soccer.sql [windows]