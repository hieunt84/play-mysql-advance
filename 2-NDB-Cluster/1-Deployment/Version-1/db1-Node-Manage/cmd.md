### commands
    ndb_mgm
     show
    or
    ndb_mgm -e "show"
    ---
    ndb_mgm -e "all status"
    ndb_mgm -e "all report memory"    
    ---   
    # start
    ndb_mgmd -f /var/lib/mysql-cluster/config.ini
    ---
    # Safe Shutdown and Restart of NDB Cluster
    # ref: https://dev.mysql.com/doc/refman/5.7/en/mysql-cluster-install-shutdown-restart.html
    ndb_mgm -e shutdown
      
