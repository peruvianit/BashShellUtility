# Author : Sergio Arellano Diaz
# Version : 1.0
BashBackupApplication
============================================

 Simplice gestione dei Backup per il filesystem

 ROOT        : Directory del File System per i salvataggio
               di tutti file creati.
 FOLDERS     : Array con tutte progetti("cartelle")
               al interno del ROOT per la creazioni
               dei files tar.gz
 PATH_BACKUP : Path dove saranno scritti tutti files
               generati dal comando tar.gz

 Esempio Struttura delle Cartelle, con la creazione dei
 file tar.gz dopo la escuzione del Bash

 ROOT ├── data
  │   ├── source_20150929_1200.tar.gz
  │   ├── source_20150930_1740.tar.gz
  │   ├── source_20151002_1340.tar.gz
  │   └── VerifyValidator_20151007_1720.tar.gz
  └── log
      └── log_backup_apps.log

------------------------------------------------------------

Gestione con il utilizo di crontab :
crontab -e 
40 13 * * * [LOCAL_PATH]/bash_generate_bck_app.sh

Nel caso mio, viene eseguito tutti giorni alle 13:40

Requisito :
chmod +x bash_generate_bck_app.sh


 
