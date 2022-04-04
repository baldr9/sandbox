#!/bin/bash

cd ~/.ssh
ssh-add id_rsa
ssh-add id_rsa_tmo
ssh-add github_baldr9_id_rsa
ssh-add github_baldr9_id_iot-blackbox
ssh-add github_baldr9_id_cpp
ssh-add -l

