#!/bin/bash

#==========================================================================================
# Author  : Sergio Arellano
# Version : 1.0.1

# Last modified: 31/01/2015 
#                03/08/2015 - Controllo della grandeza del File log,se supera 
#                             1 MegaByte (1048576)
#		              Automaticamente sara rinominato il file log a
#			      >> "[FILE LOG].YYYYMMGG_HHmm"
#                07/10/2015 - FOLDERS=(Path absoluti per tutte le cartelle aggiunte) 
#
# Creazione dei file Tar.gz per la creazioni dei Backup de tutte 
# l'applicazioni Web al interno della variabile FOLDERS=("APP1" "APP2" .. "APPN")
#==========================================================================================

#### DEBUGGIN ####
set -e

#----------------------------------------------------

logger(){
	if [ -f ${LOGFILE} ]; then
                SIZE_FILE=$( stat -c %s ${LOG_FILE})
                if [ ${SIZE_FILE} -gt 1048576 ]; then
                        mv ${LOG_FILE} "${LOG_FILE}.`date +%d%m%Y_%H%M`"
                fi
        fi
	CURRENT_TIMESTAMP=`date "+%d/%m/%Y %H:%M:%S"`
	
	echo ${CURRENT_TIMESTAMP} [$1] $2 >> ${LOG_FILE} 
}

#### RETURN VALUES/EXIT STATUS CODES
readonly E_CREATE_FOLDER=201
readonly E_E_CREATE_FILE_TAR=202

#### BEGIN CONFIGURATION ####

#----------------------------------------------------
# ROOT        : Cartella del File System per i salvataggio
#               di tutti file *.tar.gz.
# FOLDERS     : Array con tutte le cartelle da fare 
#               il Backup.
#               FOLDERS=("APP1" "APP2" .. "APPN")
# PATH_BACKUP : Path dove saranno salvati tutti files
#               Generati dal comando tar.gz
#
#  Esempio Struttura Cartelle
#
# ROOT ├── data
#  │   ├── source_20150929_1200.tar.gz
#  │   ├── source_20150930_1740.tar.gz
#  │   ├── source_20151002_1340.tar.gz
#  │   └── VerifyValidator_20151007_1720.tar.gz
#  └── log
#      └── log_backup_apps.log
#-----------------------------------------------------

ROOT="/home/sarellano/Repository/backup/"
FOLDERS=("/home/sarellano/Progetti/Almaviva/FE-CCA/CCA-FE/cca-webapp/source" "/home/sarellano/Progetti/Almaviva/Shell/VerifyValidator")
PATH_BACKUP="${ROOT}/data/"
PATH_LOG="${ROOT}/log/"
LOG_FILE=${PATH_LOG}"bash_generate_bck_app.sh.log"

#### END CONFIGURATION ####

#-----------------------------------------------------
# La creazioni dei file tar.gz saranno creati con 
# il formato :
#             "PATH_BACKUP/NAME_APP_YYYYMMGG_HHmm.tar.gz"
# 
#-----------------------------------------------------

DATE_BACKUP=`date +%Y%m%d_%H%M`

#-----------------------------------------------------

if [ ! -d "${PATH_BACKUP}" ]; then
	mkdir ${PATH_BACKUP}
	if [ $? -ne 0 ]; then
        	logger "ERROR" "Creazione della cartella ${PATH_BACKUP}"
        	exit $E_CREATE_FOLDER
	fi
	chmod 750 ${PATH_BACKUP}	
fi

if [ ! -d "${PATH_LOG}" ]; then
        mkdir ${PATH_LOG}
        if [ $? -ne 0 ]; then
                logger "ERROR" "Creazione della cartella ${PATH_LOG}"
                exit $E_CREATE_FOLDER
        fi
        chmod 750 ${PATH_LOG}
fi

logger "INFO" "Numero di progetti per creare Backup : ${#FOLDERS[*]}"

for index in ${!FOLDERS[*]}
do
	NAME_APP=${FOLDERS[$index]}
	BASE_NAME=$( basename ${FOLDERS[$index]})
        APP=${NAME_APP}
	if [ -d "${APP}" ]; then
		NAME_FILE_TAR="${PATH_BACKUP}${BASE_NAME}_${DATE_BACKUP}.tar.gz"
		
		logger "DEBUG" "Lettura Progetto [$(($index + 1))]: ${APP}"
			
		tar cvzf ${NAME_FILE_TAR} ${APP} 
		if [ $? -ne 0 ]; then
                	logger "ERROR" "Creazione del file ${NAME_FILE_TAR}"
                	exit $E_CREATE_FILE_TAR
        	fi		
		logger "DEBUG" "Scrittura file tar.gz : ${NAME_FILE_TAR}"
	else
		logger "ERROR" "La cartella non esiste per effettuare il backup : ${APP}"
    	fi
done

exit 0 #--> Uscito con successo.
# --> END SCRIPT SHELL

