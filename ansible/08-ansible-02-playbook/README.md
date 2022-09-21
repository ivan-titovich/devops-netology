## Clickhouse, nginx and vector playbook.
This is an ansible playbook to set up clickhouse, nginx and vector. Vector collect access-log from nginx and send them into clickhouse.

For available variables check out [clickhouse vars](playbook/group_vars/clickhouse/vars.yaml) and [vector vars](playbook/group_vars/vector/vars.yaml).


Currently only x86_64 rpm packages are supported.