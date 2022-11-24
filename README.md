# conntest

Try to create a bunch of http / redis connections all "at once" to test whether it causes issues with E2 instances.

## Usage

Set the environment variables as follows:

- `HTTP_OFF` - If set to a non-empty value, will disable making HTTP requests.
- `HTTP_CONNS` - Set to a number to make that many HTTP connections (all at once, in separate threads). Defaults to 500.
- `REDIS_URL` - Set to a redis url to enable redis connections.
- `REDIS_CONNS` - Set to a number to specify how many Redis connections to make. Defaults to 500.


### Behavior

The redis connections will set one key, wait .1 sec, read the key, wait .1 sec, then delete the key. After that they will idle.

The HTTP connections will do the number of connections requested and then stop.