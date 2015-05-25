# Conductor - An Application Orchestration Tool for Rally (NOTOK)

Conductor helps to launch multiple applications necessary to run the NOTOK application suite. Conductor reads a .orchestration file location in your user's home directory (~).


## Orchistration File Format


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