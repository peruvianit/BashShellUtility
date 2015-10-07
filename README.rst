=====
shell
=====

"""Simplice Gestione dei Backup per tutte le cartelle Configurate."""

Requisisti
============

* BashShell
* Permesso esecuzione sul file bash_generate_bck_app.sh


Utilizo
=======

Eseguire direttamente il file "bash_generate_bck_app.sh"  o aggungere al Crontab::

    >>> crontab -e 
    40 13 * * * [LOCAL_PATH]/bash_generate_bck_app.sh

    Nel caso mio, viene eseguito tutti giorni alle 13:40


Installazione
=============

Copiare file bash_generate_bck_app.sh ::

    >>> Configurare Parametri al interno del file bash_generate_bck_app.sh.
    >>> chmod +x bash_generate_bck_app.sh
    >>> creare Struttura nel fileSystem ("Script crea cartella se non la trova")
         ROOT 
          └── data
          └── log
