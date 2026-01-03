# Column-Level Database Encryption Performance Evaluation

This repository contains SQL and PL/SQL scripts used to evaluate the performance and storage overhead of column-level encryption in an Oracle APEX database environment.

## Contents
- Table creation script (plaintext and encrypted tables)
- Performance test scripts for:
  - 10,000 records
  - 20,000 records
  - 30,000 records
- Result extraction queries

## Overview
The scripts compare baseline (plaintext) and encrypted database operations, focusing on read performance, write performance, scalability behaviour, and storage usage across increasing dataset sizes.

## Execution Environment
- Platform: Oracle APEX
- Tool: SQL Workshop
- Encryption Scope: Column-level encryption

## Notes
All scripts were executed manually within Oracle APEX SQL Workshop.  
Some encrypted write operations at larger dataset sizes were constrained by storage limits imposed by the environment.
