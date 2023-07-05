#!/bin/bash
ansible-playbook entrypoint.yml  -c local --tags "run"
echo "starting server"
/usr/sbin/nginx start