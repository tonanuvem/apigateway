#!/bin/bash
bash -c 'while [[ "$(curl -s -o /dev/null -w ''%{http_code}'' localhost:8001)" != "200" ]]; do echo .; sleep 5; done'
echo "Kong is up"

curl -s -X POST http://localhost:8001/services -d name=mockbin -d url=http://mockbin.org/request
curl -s -X POST http://localhost:8001/services/mockbin/routes -d paths[]=/mock

curl -s http://localhost:8000/mock
