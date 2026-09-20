#!/bin/bash

printf "\n[+] Introduce usuario: "
read user

printf "\n[+] Introduce contraseña: "
read -s password

printf "\n\n[+] Introduce contraseña de usuario root de la DB: "
read -s passdb

sqlplus -S sys/$passdb as sysdba<<SQL

WHENEVER SQLERROR EXIT SQL.SQLCODE
ALTER SESSION SET "_ORACLE_SCRIPT"=true;
CREATE USER ${user} IDENTIFIED BY "$password";
GRANT CONNECT, RESOURCE TO ${user};
GRANT UNLIMITED TABLESPACE TO ${user};
GRANT CREATE VIEW TO ${user};
EXIT

SQL
