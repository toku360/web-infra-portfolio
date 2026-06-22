# Ansible Local Build Linux 実行結果

- Local(WSL)にWebLogic Server構築
- OS/リソース情報取得のためのPlabook実行

目的： 
AWS EC2向けのPlaybookをローカルに構築したサーバでテストを実施する。

結果： 

```cmd

tokud@LAPTOP-B02HI6LF:~/web-infra-portfolio/ansible$ ansible-playbook -i inventory/hosts.ini playbooks/gather-info.yml | tee logs/gather-info_$(date +%F).log

PLAY [Gather Linux Information] ************************************************

TASK [Gathering Facts] *********************************************************
ok: [weblogic01]

TASK [Hostname] ****************************************************************
changed: [weblogic01]

TASK [debug] *******************************************************************
ok: [weblogic01] => {
    "hostname_result.stdout": "LAPTOP-B02HI6LF"
}

TASK [Uptime] ******************************************************************
changed: [weblogic01]

TASK [debug] *******************************************************************
ok: [weblogic01] => {
    "uptime_result.stdout": " 16:22:48 up  5:16,  1 user,  load average: 0.08, 0.02, 0.01"
}

TASK [Disk] ********************************************************************
changed: [weblogic01]

TASK [debug] *******************************************************************
ok: [weblogic01] => {
    "disk_result.stdout_lines": [
        "Filesystem      Size  Used Avail Use% Mounted on",
        "none            3.8G     0  3.8G   0% /usr/lib/modules/6.6.87.2-microsoft-standard-WSL2",
        "none            3.8G  4.0K  3.8G   1% /mnt/wsl",
        "drivers         953G  108G  846G  12% /usr/lib/wsl/drivers",
        "/dev/sdd       1007G  7.1G  949G   1% /",
        "none            3.8G  148K  3.8G   1% /mnt/wslg",
        "none            3.8G     0  3.8G   0% /usr/lib/wsl/lib",
        "rootfs          3.8G  2.7M  3.8G   1% /init",
        "none            3.8G  548K  3.8G   1% /run",
        "none            3.8G     0  3.8G   0% /run/lock",
        "none            3.8G  144K  3.8G   1% /run/shm",
        "none            3.8G   96K  3.8G   1% /mnt/wslg/versions.txt",
        "none            3.8G   96K  3.8G   1% /mnt/wslg/doc",
        "C:\\             953G  108G  846G  12% /mnt/c",
        "tmpfs           3.8G   16K  3.8G   1% /run/user/1000"
    ]
}

PLAY RECAP *********************************************************************
weblogic01                 : ok=7    changed=3    unreachable=0    failed=0    skipped=0    rescued=0    ignored=0

```

