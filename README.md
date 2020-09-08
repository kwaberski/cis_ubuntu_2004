# IN DEVELOPMENT :lock::no_entry:

[![Build Status](https://travis-ci.com/darkwizard242/cis_ubuntu_2004.svg?branch=feature_cis_ubuntu_2004-development)](https://travis-ci.com/darkwizard242/cis_ubuntu_2004)![GitHub repo size](https://img.shields.io/github/repo-size/darkwizard242/cis_ubuntu_2004?color=orange&style=flat-square)

# Ansible Role: cis_ubuntu_2004

Ansible Role for applying **CIS Ubuntu Linux 20.04 LTS Benchmark v1.0.0**.

## 1\. Installation/Download Instructions:

This role is available on Ansible Galaxy. There are a few methods you can utilize to install/download the `cis_ubuntu_2004` role on your Ansible Controller node either from Ansible Galaxy or directly from the repository.

### Without a requirements.yml file:

- Installing/Downloading latest (default) available tag version:

  ```shell
  ansible-galaxy install darkwizard242.cis_ubuntu_2004
  ```

- Installing/Downloading specific available tag version (using 1.0.0 as an example):

  ```shell
  ansible-galaxy install darkwizard242.cis_ubuntu_2004,1.0.0
  ```

- Installing/Downloading specific available branch version from repository (using master branch as an example):

  ```shell
  ansible-galaxy install darkwizard242.cis_ubuntu_2004,master
  ```

### With a requirements.yml file:

Add to an existing **requirements.yml** file along with your other roles or create a new one to install `cis_ubuntu_2004`.

- Latest version directly from Ansible Galaxy.

  ```yaml
  - name: darkwizard242.cis_ubuntu_2004
  ```

- Specific version directly from Ansible Galaxy.

  ```yaml
  - name: darkwizard242.cis_ubuntu_2004
    version: 1.0.0
  ```

- Specific branch from repository.

  ```yaml
  - name: cis_ubuntu_2004
    src: https://github.com/darkwizard242/cis_ubuntu_2004
    version: master
  ```

Installing/Downloading after adding to **requirements.yml** :

```shell
ansible-galaxy install -r requirements.yml
```

**_NOTE:_** Installing a role as mentioned above only downloads the role to have it available for use in your ansible playbooks. You can read up on the roles install/download instructions [here](https://galaxy.ansible.com/docs/using/installing.html).

## 2\. Few Considerations:

Benchmarks around the **_disk partitioning_** and their **_mount points_** from **Section 1** are not applied in this role. The reason is simply that every individual/organization's system architecture and disk layout will likely vary. I would recommend to apply those yourself. Following is a list of those benchmarks:

- 1.1.10 Ensure separate partition exists for /var (Automated)
- 1.1.11 Ensure separate partition exists for /var/tmp (Automated)
- 1.1.12 Ensure nodev option set on /var/tmp partition (Automated)
- 1.1.13 Ensure nosuid option set on /var/tmp partition (Automated)
- 1.1.14 Ensure noexec option set on /var/tmp partition (Automated)
- 1.1.15 Ensure separate partition exists for /var/log (Automated)
- 1.1.16 Ensure separate partition exists for /var/log/audit (Automated)
- 1.1.17 Ensure separate partition exists for /home (Automated)
- 1.1.18 Ensure nodev option set on /home partition (Automated)
- 1.1.19 Ensure nodev option set on removable media partitions (Manual)
- 1.1.20 Ensure nosuid option set on removable media partitions (Manual)
- 1.1.21 Ensure noexec option set on removable media partitions (Manual)

Following benchmarks from **Section 4** has also not been implemented:

- 4.2.1.5 Ensure rsyslog is configured to send logs to a remote log host (Automated)
- 4.2.1.6 Ensure remote rsyslog messages are only accepted on designated log hosts. (Manual)
- 4.3 Ensure logrotate is configured (Manual)

## 3\. Requirements

None.

## 4\. Role Variables

Role default variables being utilized in role tasks are located in `defaults/main/`.

[defaults/main/main.yml](https://github.com/darkwizard242/cis_ubuntu_2004/blob/master/defaults/main/main.yml) consists of variables referring to the entire CIS sections like the following and the system breaking variables like the ones mentioned in [Important Variables](https://github.com/darkwizard242/cis_ubuntu_2004/tree/master#important-variables) section:

```yaml
ubuntu_2004_cis_section1: true
ubuntu_2004_cis_section2: true
ubuntu_2004_cis_section3: true
ubuntu_2004_cis_section4: true
ubuntu_2004_cis_section5: true
ubuntu_2004_cis_section6: true
```

The purpose of above mentioned variables is to indicate that all of tasks pertaining to these sections should be applied through `cis_ubuntu_2004` role.

Variables for each of the sections are located in their own files.

- Section 1 variables are in [defaults/main/section_01.yml](https://github.com/darkwizard242/cis_ubuntu_2004/blob/master/defaults/main/section_01.yml)
- Section 2 variables are in [defaults/main/section_02.yml](https://github.com/darkwizard242/cis_ubuntu_2004/blob/master/defaults/main/section_02.yml)
- Section 3 variables are in [defaults/main/section_03.yml](https://github.com/darkwizard242/cis_ubuntu_2004/blob/master/defaults/main/section_03.yml)
- Section 4 variables are in [defaults/main/section_04.yml](https://github.com/darkwizard242/cis_ubuntu_2004/blob/master/defaults/main/section_04.yml)

Role default values for everything in the `cis_ubuntu_2004` role can be superseded via passing them in a playbook or any other [variable precedence method](https://docs.ansible.com/ansible/latest/user_guide/playbooks_variables.html#variable-precedence-where-should-i-put-a-variable).

- ### Important variables

CIS Ubuntu 20.04 hardening benchmarks require purging of many services that can be exploited, have known vulnerabilities, result in an exposure of attack surface or should be disabled if not required. As per the benchmark, by default - all of these services will be purged and the value for their variables has been set to `false`. However, if you still require the use of these services for any reason, please change their values to `true` so that when applying the role in a playbook, the role tasks to _purge_ those services can be **skipped**.

Along with the above mentioned explanation for some variables, there are also other variables that define whether a specific service is desired on the system or not (for e.g. SSH daemon), parameters for configuration of various tools (for e.g. auditd) etc. These can also be overridden in a playbook.

```yaml
# Set to `false` if SSH daemon is not required.
ubuntu_2004_cis_require_ssh_server: true

# Variable to store strong Ciphers for SSH daemon.
ubuntu_2004_cis_require_ssh_ciphers: chacha20-poly1305@openssh.com,aes256-gcm@openssh.com,aes128-gcm@openssh.com,aes256-ctr,aes192-ctr,aes128-ctr

# Variable to store strong MAC Algorithms for SSH daemon.
ubuntu_2004_cis_require_ssh_macs: hmac-sha2-512-etm@openssh.com,hmac-sha2-256-etm@openssh.com,hmac-sha2-512,hmac-sha2-256

# Variable to store strong Key Exchange Algorithms for SSH daemon.
ubuntu_2004_cis_require_ssh_kexalgorithms: curve25519-sha256,curve25519-sha256@libssh.org,diffie-hellman-group14-sha256,diffie-hellman-group16-sha512,diffie-hellman-group18-sha512,ecdh-sha2-nistp521,ecdh-sha2-nistp384,ecdh-sha2-nistp256,diffie-hellman-group-exchange-sha256

# Variable to store Client Alive Interval in seconds for SSH daemon.
ubuntu_2004_cis_require_ssh_clientaliveinterval: '300'

# Variable to store number of Client Alive Count Max for SSH daemon.
ubuntu_2004_cis_require_ssh_clientalivecountmax: '3'

# Variable to store Login Grace Time in seconds for SSH daemon.
ubuntu_2004_cis_require_ssh_logingracetime: '60'

# Set to `true` if IPv6 is required.
ubuntu_2004_cis_require_ipv6: false

# Set to `true` if Wireless is required.
ubuntu_2004_cis_require_wireless: false

# Set to `true` if system is supposed to act as a router.
ubuntu_2004_cis_require_router: false

# can be one of 'iptables' or 'nftables' or 'ufw'.
ubuntu_2004_cis_firewall: ufw

# IF 'ufw' is used, setting to 'yes' allows for a UFW git application profile to be configured and allowed.
ubuntu_2004_cis_section3_rule_3_5_1_7_ufw_require_git_profile: yes

# IF 'ufw' is used, setting to 'yes' allows for a UFW HTTP application profile to be configured and allowed.
ubuntu_2004_cis_section3_rule_3_5_1_7_ufw_require_http_profile: yes

# IF 'ufw' is used, setting to 'yes' allows for a UFW HTTPS application profile to be configured and allowed.
ubuntu_2004_cis_section3_rule_3_5_1_7_ufw_require_https_profile: yes

# IF 'ufw' is used, setting to 'true' will deny all incoming connections by default. Operates same as `ufw default deny incoming`. Set to `false` if you don't require this to be applied.
ubuntu_2004_cis_section3_rule_ufw_default_deny_incoming: true

# IF 'ufw' is used, setting to 'true' will deny all outgoing connections by default. Operates same as `ufw default deny outgoing`. Set to `false` if you don't require this to be applied.
ubuntu_2004_cis_section3_rule_ufw_default_deny_outgoing: true

# IF 'ufw' is used, setting to 'true' will deny all routed connections by default. Operates same as `ufw default deny routed`. Set to `false` if you don't require this to be applied.
ubuntu_2004_cis_section3_rule_ufw_default_deny_routed: true

# IF 'nftables' is used, setting to 'true' will deny all input/forward/output connections by default, leaving the system unreachable. Set to `false` if you don't require this to be applied or to lose connectivity.
ubuntu_2004_cis_section3_rule_3_5_2_8: true

# IF 'iptables' is used, setting to 'true' will deny all inbound connections on ipv4 by default, leaving the system unreachable. Set to `false` if you don't require this to be applied or to lose connectivity.
ubuntu_2004_cis_section3_rule_iptables_ipv4_default_deny_input: true

# IF 'iptables' is used, setting to 'true' will deny all outbound connections on ipv4 by default, leaving the system unreachable. Set to `false` if you don't require this to be applied or to lose connectivity.
ubuntu_2004_cis_section3_rule_iptables_ipv4_default_deny_output: true

# IF 'iptables' is used, setting to 'true' will deny all forward connections on ipv4 by default, leaving the system unreachable. Set to `false` if you don't require this to be applied or to lose connectivity.
ubuntu_2004_cis_section3_rule_iptables_ipv4_default_deny_forward: true

# IF 'iptables' is used and ipv6 is enabled, setting to 'true' will deny all inbound connections on ipv4 by default, leaving the system unreachable. Set to `false` if you don't require this to be applied or to lose connectivity.
ubuntu_2004_cis_section3_rule_iptables_ipv6_default_deny_input: true

# IF 'iptables' is used and ipv6 is enabled, setting to 'true' will deny all outbound connections on ipv4 by default, leaving the system unreachable. Set to `false` if you don't require this to be applied or to lose connectivity.
ubuntu_2004_cis_section3_rule_iptables_ipv6_default_deny_output: true

# IF 'iptables' is used and ipv6 is enabled, setting to 'true' will deny all forward connections on ipv4 by default, leaving the system unreachable. Set to `false` if you don't require this to be applied or to lose connectivity.
ubuntu_2004_cis_section3_rule_iptables_ipv6_default_deny_forward: true

# can be one of 'ntp' or 'chrony' or 'systemd-timesyncd'.
ubuntu_2004_cis_time_synchronization: systemd-timesyncd

# Auditd backlog limit to store sufficient records at boot time.
ubuntu_2004_cis_auditd_backloglimit: '8192'

# Log file size for auditd logs. Set as appropriate.
ubuntu_2004_cis_auditd_maxlogfile: '25'

# Action to take when auditd logs have reached max size. Set as appropriate.
ubuntu_2004_cis_auditd_maxlogfileaction: keep_logs

# Action to take for low space left for auditd. Set as appropriate.
ubuntu_2004_cis_auditd_spaceleftaction: email

# Who to mail for auditd. Set as appropriate.
ubuntu_2004_cis_auditd_actionmailacct: root

# Option to halt when audit logs are full. Set as appropriate.
ubuntu_2004_cis_auditd_adminspaceleftaction: halt

# Users allowed to schedule cronjobs.
ubuntu_2004_cis_cron_allow_users:
  - root
  - ubuntu

# Users allowed to use 'at' to schedule jobs.
ubuntu_2004_cis_at_allow_users:
  - root
  - ubuntu

# Set to `true` if X Windows System is required.
ubuntu_2004_cis_require_xwindows_system: false

# Set to `true` if CUPS is required.
ubuntu_2004_cis_require_cups: false

# Set to `true` if DHCP server is required.
ubuntu_2004_cis_require_dhcp_server: false

# Set to `true` if LDAP server is required.
ubuntu_2004_cis_require_ldap_server: false

# Set to `true` if NFS server is required.
ubuntu_2004_cis_require_nfs_server: false

# Set to `true` if DNS server is required.
ubuntu_2004_cis_require_dns_server: false

# Set to `true` if FTP server is required.
ubuntu_2004_cis_require_ftp_server: false

# Set to `true` if HTTP (apache2) server is required.
ubuntu_2004_cis_require_http_server: false

# Set to `true` if IMAP and POP3 servers are required.
ubuntu_2004_cis_require_imap_pop3_server: false

# Set to `true` if Samba daemon is required.
ubuntu_2004_cis_require_samba_server: false

# Set to `true` if Squid server is required.
ubuntu_2004_cis_require_squid_server: false

# Set to `true` if SNMP server is required.
ubuntu_2004_cis_require_snmp_server: false

# Set's postfix to act in local-only mode.
ubuntu_2004_cis_require_mail_server: true

# Set to `true` if RSYNC is required.
ubuntu_2004_cis_require_rsyncd_server: false

# Set to `true` if NIS server is required.
ubuntu_2004_cis_require_nis_server: false

# Set to `true` if NIS client is required.
ubuntu_2004_cis_require_nis_client: false

# Set to `true` if RSH client is required.
ubuntu_2004_cis_require_rsh_client: false

# Set to `true` if TALK client is required.
ubuntu_2004_cis_require_talk_client: false

# Set to `true` if TELNET client is required.
ubuntu_2004_cis_require_telnet_client: false

# Set to `true` if LDAP client is required.
ubuntu_2004_cis_require_ldap_client: false

# Set to `true` if RPCBIND client is required.
ubuntu_2004_cis_require_rpcbind_client: false
```

## 5\. Dependencies

None

## License

[MIT](https://github.com/darkwizard242/cis_ubuntu_2004/blob/master/LICENSE)

## Author Information

This role was created by [Ali Muhammad](https://www.linkedin.com/in/ali-muhammad-759791130/).
