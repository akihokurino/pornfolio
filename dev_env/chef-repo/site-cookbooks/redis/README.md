DESCRIPTION:
===========

Installs a source file Redis chef cookbook.


ATTRIBUTES:
==========

See `attributes/default.rb` for default values.

* `node["redis"]["version"]` - From http://redis.googlecode.com/files/redis-#{version}.tar.gz
* Redis install at `/usr/local/redis/` - Source install default directory.
* initd file copy at `/etc/init.d/redis` - Oreore copy.


USAGE:
=====

```bash
{
  "redis": { "version" : "2.6.4" },
  "run_list": "redis"
  }
}
```


LICENSE:
==================

The MIT License (MIT)  
Copyright (c) 2012, kenjiskywalker All rights reserved.
