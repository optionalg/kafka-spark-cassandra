# Zookeeper Wrapper
## Recipes
`default` - Installs, configures and starts a zookeeper instance.

## Attributes
### `default['zookeeper-cluster']['databag']`
Name of the data bag with the zookeeper nodes hostnames. Defaults to `zookeeper.json`.

## Sample of zookeeper.json

```
{
  "id": "zookeeper",
  "nodes": [
    "aaa.aaa.aaa.aaa",
    "bbb.bbb.bbb.bbb",
    "ccc.ccc.ccc.ccc"
  ]
}
```
