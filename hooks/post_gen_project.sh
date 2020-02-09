#!/bin/sh

git init
git add .
git commit -m "Ansible {{ cookiecutter.role_name }} role: {{ cookiecutter.description }}"
