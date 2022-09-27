Lighthouse role
=========

This role for installation nginx and lighthouse server.

Requirements
------------

In progress...

Role Variables
--------------
You can change ligthhouse template name: 
```
lighthouse_template: "templates/lighthouse.conf"

lighthouse_config_file: "/etc/nginx/conf.d/lighthouse.conf"
```
Dependencies
------------

In progress.

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:

    - hosts: lighthouse
      roles:
         - { role: lighthouse-role }

License
-------

BSD

