# EdgeOS Spamhaus blocklist script

## Overview
The script is used to automatically update EdgeOS (Edgerouter) firewall groups, which can be used to block the most popular botnets, cyber-crime bots, and other automated attacs at your network.

## Usage
- `scp` the script onto your Edgerouter.
- `chmod a+x spamhaus.sh`
- run it: `./blocklist.sh <SPAMHAUS_URL> <NETWORK_GROUP_NAME>`

Example:

```bash
./spamhaus.sh https://www.spamhaus.org/drop/drop.txt SPAMHAUS_DROP
```

Network group will be automatically created and populated with address pools.

As a next step, you will likely need to set up Firewall rules to drop all connections that originated from the created network group.

Remember to put DROP rule for this network group before your other ACCEPT rules.
