My own role
=========

My own role for testing my own module for ansible.

Requirements
------------

Has no special requirements.

Role Variables
--------------

path: "/absolute/path/to/file/"

filename: "file_name"

content: "content, that could be written to file by the path from variable 'path'."


Dependencies
------------

Has no special dependencies.

Example Playbook
----------------

Including an example of how to use your role (for instance, with variables passed in as parameters) is always nice for users too:
    
    
```
- name: run the new module
  my_own_module:
    "path": "{{ path }}"
    "content": "{{ content }}"
```

License
-------

BSD

Author Information
------------------

Ivan Titovich
