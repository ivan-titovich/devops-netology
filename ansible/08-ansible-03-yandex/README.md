## Playbook for 3 hosts (clickhouse, vector, lighthouse). 

This is an ansible playbook to set up clickhouse, nginx and vector. Vector collect access-log from nginx and send them into clickhouse.

For available variables check out [clickhouse vars](playbook/group_vars/clickhouse/vars.yml), [vector vars](playbook/group_vars/vector/vars.yml) and [lighthouse vars](playbook/group_vars/lighthouse/vars.yml).

Currently only x86_64 rpm packages are supported.