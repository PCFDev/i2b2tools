#Define some useful aliases for things like:
# logging into Oracle
# controlling JBoss
# viewing JBoss's logs

#NB: Meant to be called from i2b2.rc

alias i2b2_rc='source ~/i2b2.rc'

alias i2b2_ora_system='sqlplus system/${I2B2_ORACLE_SYSTEM_PASSWORD}@${I2B2_ORACLE_SID}'
alias i2b2_ora_pm='sqlplus ${I2B2_DB_PM_USER}/${I2B2_ORACLE_SYSTEM_PASSWORD}@${I2B2_ORACLE_SID}'
alias i2b2_ora_meta='sqlplus ${I2B2_DB_ONT_USER}/${I2B2_ORACLE_SYSTEM_PASSWORD}@${I2B2_ORACLE_SID}'
alias i2b2_ora_hive='sqlplus ${I2B2_DB_HIVE_USER}/${I2B2_ORACLE_SYSTEM_PASSWORD}@${I2B2_ORACLE_SID}'
alias i2b2_ora_shrine_ont='sqlplus ${I2B2_DB_SHRINE_ONT_USER}/${I2B2_ORACLE_SYSTEM_PASSWORD}@${I2B2_ORACLE_SID}'

export JBOSS_LOG_FILE="${JBOSS_HOME}/standalone/log/server.log"
export JBOSS_BIN_DIR="${JBOSS_HOME}/bin"

alias i2b2_jboss_startup="${JBOSS_BIN_DIR}/standalone.sh > /dev/null &"
alias i2b2_jboss_shutdown="${JBOSS_BIN_DIR}/jboss-cli.sh --connect --command=:shutdown"
alias i2b2_jboss_less_log='less ${JBOSS_LOG_FILE}'
alias i2b2_jboss_tail_log='tail -f ${JBOSS_LOG_FILE}'
alias i2b2_jboss_ps='ps aux | grep jboss'
