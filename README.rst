=====
shell
=====

"""Simplice gestione dei Backup per il filesystem."""

Requisisti
============

* BashShell
* Permesso escuzione sul bash_generate_bck_app.sh


Utilizo
=======

Esegure direttamente o tramite Crontab::

    >>> crontab -e 
    40 13 * * * [LOCAL_PATH]/bash_generate_bck_app.sh

    Nel caso mio, viene eseguito tutti giorni alle 13:40


Instalazione
============

Copiare file bash_generate_bck_app.sh ::

    >>> Configurare Parametri al interno del file bash_generate_bck_app.sh.
    >>> chmod +x bash_generate_bck_app.sh
    >>> creare Struttura nel fileSystem
         ROOT 
          └── data
          └── log
