# CONVENIENT ALIASES
## Stop / Start SHRINE services
## View the Logs
## Check running processes

#NB: Meant to be called from shrine.rc

alias shrine_rc='source ~/shrine.rc';

TOMCAT_BIN_DIR='${SHRINE_TOMCAT_HOME}/bin'

alias shrine_startup="${TOMCAT_BIN_DIR}/startup.sh"
alias shrine_shutdown="${TOMCAT_BIN_DIR}/shutdown.sh"
alias shrine_ps='ps aux | grep shrine'

TOMCAT_LOG_DIR='${SHRINE_TOMCAT_HOME}/logs'

alias shrine_tomcat_log="tail -80f ${TOMCAT_LOG_DIR}/catalina.out"
alias shrine_app_log="tail -80f ${TOMCAT_LOG_DIR}/shrine.log"
alias shrine_proxy_log="tail -80f ${TOMCAT_LOG_DIR}/proxy.log"
alias shrine_query_history='mysql -u ${SHRINE_MYSQL_USER} -p${SHRINE_MYSQL_PASSWORD} -D shrine_query_history'