select (a.first_time - b.first_time) * 3600 * 24
from v$log_history a, v$log_history b
where b.sequence#=a.sequence# - 1;