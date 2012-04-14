#!/bin/bash

## Backup the DB for later use

mysqldump bootstrapdrupal > files/var/tmp/sql/00-bootstrapdrupal.sql
