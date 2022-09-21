## Clickhouse, nginx and vector playbook.
This is an ansible playbook to set up clickhouse, nginx and vector. Vector collect access-log from nginx and send them into clickhouse.

For available variables check out [clickhouse vars](https://github.com/ivan-titovich/devops-netology/blob/08-ansible-02-playbook/ansible/08-ansible-02-playbook/playbook/group_vars/clickhouse/vars.yml) and [vector vars](https://github.com/ivan-titovich/devops-netology/blob/08-ansible-02-playbook/ansible/08-ansible-02-playbook/playbook/group_vars/vector/vars.yml).

[short](playbook/group_vars/clickhouse/vars.yml)


[long /](/08-ansible-02-playbook/playbook/group_vars/clickhouse/vars.yml)

https://github.com/ivan-titovich/devops-netology/blob/08-ansible-02-playbook/ansible/08-ansible-02-playbook/playbook/group_vars/clickhouse/vars.yml
Currently only x86_64 rpm packages are supported.