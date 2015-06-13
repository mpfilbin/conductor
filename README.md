# Conductor - An Application Orchestration Tool

Conductor helps to launch and manage multiple applications from the command line simply and easily. Conductor reads a .orchestration file location in your user's home directory (~).


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