PROJECT = emq-relx
PROJECT_DESCRIPTION = Release Project for the EMQ Broker
PROJECT_VERSION = 2.3

## Fix 'rebar command not found'
DEPS = goldrush
dep_goldrush = git https://github.com/basho/goldrush 0.1.9

DEPS += emqttd emq_modules emq_dashboard emq_retainer emq_recon emq_reloader \
        emq_auth_clientid emq_auth_username emq_auth_ldap emq_auth_http \
        emq_auth_mysql emq_auth_pgsql emq_auth_redis emq_auth_mongo \
        emq_sn emq_coap emq_stomp emq_plugin_template emq_web_hook \
        emq_lua_hook emq_auth_jwt emq_lwm2m

# emq deps
dep_emqttd        = git https://github.com/emqtt/emqttd windows
dep_emq_modules   = git https://github.com/emqtt/emq-modules v2.3-beta.3
dep_emq_dashboard = git https://github.com/emqtt/emq-dashboard v2.3-beta.3
dep_emq_retainer  = git https://github.com/emqtt/emq-retainer v2.3-beta.3
dep_emq_recon     = git https://github.com/emqtt/emq-recon v2.3-beta.3
dep_emq_reloader  = git https://github.com/emqtt/emq-reloader v2.3-beta.3

# emq auth/acl plugins
dep_emq_auth_clientid = git https://github.com/emqtt/emq-auth-clientid v2.3-beta.3
dep_emq_auth_username = git https://github.com/emqtt/emq-auth-username v2.3-beta.3
dep_emq_auth_ldap     = git https://github.com/emqtt/emq-auth-ldap v2.3-beta.3
dep_emq_auth_http     = git https://github.com/emqtt/emq-auth-http v2.3-beta.3
dep_emq_auth_mysql    = git https://github.com/emqtt/emq-auth-mysql v2.3-beta.3
dep_emq_auth_pgsql    = git https://github.com/emqtt/emq-auth-pgsql v2.3-beta.3
dep_emq_auth_redis    = git https://github.com/emqtt/emq-auth-redis v2.3-beta.3
dep_emq_auth_mongo    = git https://github.com/emqtt/emq-auth-mongo v2.3-beta.3
dep_emq_auth_jwt      = git https://github.com/emqtt/emq-auth-jwt v2.3-beta.3

# mqtt-sn, coap and stomp
dep_emq_sn    = git https://github.com/emqtt/emq-sn v2.3-beta.3
dep_emq_coap  = git https://github.com/emqtt/emq-coap v2.3-beta.3
dep_emq_stomp = git https://github.com/emqtt/emq-stomp v2.3-beta.3
dep_emq_lwm2m = git https://github.com/emqtt/emq-lwm2m 0.1

# plugin template
dep_emq_plugin_template = git https://github.com/emqtt/emq-plugin-template v2.3-beta.3

# web_hook lua_hook
dep_emq_web_hook  = git https://github.com/emqtt/emq-web-hook v2.3-beta.3
dep_emq_lua_hook  = git https://github.com/emqtt/emq-lua-hook v2.3-beta.3

# COVER = true

include erlang.mk

plugins:
	@rm -rf rel
	@mkdir -p rel/conf/plugins/ rel/schema/
	@for conf in $(DEPS_DIR)/*/etc/*.conf* ; do \
		if [ "emq.conf" = "$${conf##*/}" ] ; then \
			cp $${conf} rel/conf/ ; \
		elif [ "acl.conf" = "$${conf##*/}" ] ; then \
			cp $${conf} rel/conf/ ; \
		else \
			cp $${conf} rel/conf/plugins ; \
		fi ; \
	done
	@for schema in $(DEPS_DIR)/*/priv/*.schema ; do \
		cp $${schema} rel/schema/ ; \
	done

app:: plugins
