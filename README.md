# lua_auth_plugin

An authentication plug-in for [Mosquitto](https://mosquitto.org/), where the authentication process is
controlled by [Lua](https://www.lua.org/) code.

# Install
Installation of Mosquitto and Lua is required in advance.

Please modify the library path in Makefile and the installation destination as appropriate according to each environment.

```
cd lua_auth_plugin
make
make install
```

# Configuration
Please add the following setting to `mosquitto.conf`.

```
auth_plugin /path/to/lua_auth_plugin.so
auth_opt_auth_file /path/to/your_auth_file.lua
```

By adding extra `auth_opt_*` directives yourself, you can add configurable settings
to your plugin.

# Lua functions
Please prepare the following functions in the Lua file.

- `plugin_init(opts)`: Called when the plugin is initialized.  opts is a
  table keyed with the names of `auth_opts_*` settings from
  `mosquitto.conf`.
- `plugin_cleanup(opts)`: Called when the plugin terminates.
- `security_init(opts, reload)`: Called when initializing the plugin and
  when reloading the configuration.  When reloading, `reload` value is
  `true`.
- `security_cleanup(opts, reload)`: Called when the plug-in terminates and
  when reloading the configuration.  When reloading, `reload` value is
  `true`.
- `acl_check(clientid, username, topic, access)`: Called when the broker
  checks access to the topic.  `access` may be one of `MOSQ_ACL_SUBSCRIBE`
  (when a client is asking to subscribe to a topic string), `MOSQ_ACL_READ`
  (when a message is about to be sent to a client) and `MOSQ_ACL_WRITE` (when
  a message has been received from a client).
- `unpwd_check(username, password)`: Called when the broker checks username/password.

# C Function
The following functions are C functions available from Lua.

- `topic_matches_sub(sub, topic)`: This function determines whether `topic` matches `sub`.

# Credits
Basic composition and ideas are based on [mosquitto_pyauth](https://github.com/mbachry/mosquitto_pyauth).

The code is forked from [DenkiYagi/lua_auth_plugin](https://github.com/DenkiYagi/lua_auth_plugin) repository.
