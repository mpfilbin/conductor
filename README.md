# Conductor - An Application Orchestration Tool

Conductor helps to launch and manage multiple applications from the command line simply and easily. Conductor reads a .orchestration file location in your user's home directory (~).

[ ![Codeship Status for mpfilbin/conductor](https://codeship.com/projects/82085720-0634-0133-0179-4226f86e04c9/status?branch=master)](https://codeship.com/projects/89659)

## Orchestration File Format


```yaml
---

-
	home: '$WEBAPP_HOME'
	start: 'gw'
	params:
		- 'jettyRun'
-
	home: '$BURRO_HOME'
	start: 'npm'
	params:
		- 'start'

-
	home: '$HOME'
	start: 'mongod'
	params:
		- '--config /usr/local/etc/mongod.conf'

-
	home: '$DEEPTHOUGHT_HOME'
	start: 'lein'
	params:
		- 'run
```