[ ![Codeship Status for mpfilbin/conductor](https://codeship.com/projects/82085720-0634-0133-0179-4226f86e04c9/status?branch=master)](https://codeship.com/projects/89659)

# Conductor - An Application Orchestration Tool
Conductor helps to launch and manage multiple applications from the command line simply and easily.

## Project Progress

The progress of this project is tracked on a Trello board, [here](https://trello.com/b/e5QCYdx1/rally-hackathon-conductor).

## Demos and Additional Information

- [Demo Presentation](https://drive.google.com/open?id=1GkursBv2Ffh-L_b8SWqAscQHNTROEhbqYJfvJe734e0)
- [Demo Screencast](https://drive.google.com/open?id=0B9d-p2NvyGzqZDVXM21OLVhBUnc)

## Commandline Interface

    Usage: conductor <command> <stack_name> [parameters] [options]:

    Supported commands include...
    - orchestrate <stack_name>: starts up an application stack defined by a stack file
    - ps: lists all of the actively running process along with their PIDs
    - kill <pid>: kills a process with a given PID. Will not restart it.
    - kill_all: kills all processes managed by Conductor

    Supported options:
    -c CONFIG [--config=CONFIG]: Specify a path for your stack files
    -p PIDSFILE [--pids=PIDSFILE]: Specify a path to write PIDs to
    -l LOGGINGPATH [--logging-path=LOGGINGPATH]: Path to write error and log files for stack

    Example:

    conductor killall app_stack     #=> Kills all processes defined by 'app_stack'
    conductor kill app_stack 1390   #=> Kills process with ID 1390 in 'app_stack'
    conductor orchestrate app_stack #=> Orchestrate applications defined by 'app_stack'

## Orchestration File Format


```yaml
---

- path: /usr/local/bin
  start: nginx
  args:
    - -c ~/projects/deepthought/nginx.conf
- start: grunt
  working_dir: ~/projects/churro
  args:
    - webpack 
    - dev 
    - server
- start: npm
  working_dir: ~/projects/burro
  args:
    - run
    - dev
    - ~/projects/churro
- start: lein
  working_dir: ~/projects/deepthought
  env:
    - ZUUL_TENANT_OVERRIDE=my_scheme
```

## Default Paths:

- Stack files: `~/stacks.d`
- PID Files: `/var/run`
- Unix Socket Files: `/var/run`