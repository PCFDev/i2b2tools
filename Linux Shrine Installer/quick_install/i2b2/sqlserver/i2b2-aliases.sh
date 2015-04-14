#Define some useful aliases for things like:
# logging into Postgres
# controlling JBoss
# viewing JBoss's logs

#NB: Meant to be called from i2b2.rc

alias i2b2_rc='source ~/i2b2.rc'

alias i2b2_pg_system='sudo -u postgres psql ${I2B2_DB_NAME}'
alias i2b2_pg_pm='sudo -u postgres psql ${I2B2_DB_PM_USER}'
alias i2b2_pg_meta='sudo -u postgres psql ${I2B2_DB_ONT_USER}'
alias i2b2_pg_hive='sudo -u postgres psql ${I2B2_DB_HIVE_USER}'
alias i2b2_pg_shrine_ont='sudo -u postgres psql ${I2B2_DB_ONT_USER}'

export JBOSS_LOG_FILE="${JBOSS_HOME}/standalone/log/server.log"
export JBOSS_BIN_DIR="${JBOSS_HOME}/bin"

alias i2b2_jboss_startup="${JBOSS_BIN_DIR}/standalone.sh > /dev/null &"
alias i2b2_jboss_shutdown="${JBOSS_BIN_DIR}/jboss-cli.sh --connect --command=:shutdown"
alias i2b2_jboss_less_log='less ${JBOSS_LOG_FILE}'
alias i2b2_jboss_tail_log='tail -f ${JBOSS_LOG_FILE}'
alias i2b2_jboss_ps='ps aux | grep jboss'
